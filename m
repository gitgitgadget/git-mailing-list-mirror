From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 2/2] optimize set_shared_perm()
Date: Sat, 30 Mar 2013 10:53:16 +0100
Message-ID: <5156B60C.6070707@web.de>
References: <201303251657.57222.tboegi@web.de> <7vli95nbs4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org, j6t@kdbg.org, kusmabite@gmail.com,
	mlevedahl@gmail.com, ramsay@ramsay1.demon.co.uk,
	sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 30 10:53:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULsTv-0001JX-Ip
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 10:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755493Ab3C3JxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Mar 2013 05:53:23 -0400
Received: from mout.web.de ([212.227.17.12]:63988 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755303Ab3C3JxX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Mar 2013 05:53:23 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MPGym-1UHSd21mca-004RdD; Sat, 30 Mar 2013 10:53:17
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <7vli95nbs4.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:o5YqA64npJm3G6di69qFItMeaURwTK+XNd0zV8hYHJd
 yWUb5PZgg5/0bp3lgVBGcnv5e+Sv96Gs6cxNfChc2IVU6hkj8P
 AhnamkwxZaGQmKrh8CCUVySxa7XPoKlJnWZdX/GrGpcrW5yR4V
 +7aVpcDnsKIoIMfGAbrZ1EeZSMbtfgslTDpjgHALvy4g6eMmwb
 Ca2u4NnPTuF0+e/0qmJ/g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219582>

On 29.03.13 22:20, Junio C Hamano wrote:
[snip]
> The last two points can become a separate "preparation" step.  The
> result would be easier to read.
> 
> Your updated adjust_shared_perm() does not begin with:
> 
> 	if (!shared_repository)
>         	return 0;
> 
> as the original, but it always first calls to get_st_mode_bits()
> which makes a call to lstat(2).
> 
> That smells like a huge regression for !shared_repository case,
> unless you have updated the existing callers of adjust_shared_perm()
> not to call it when !shared_repository.
> 
Thanks for carefull review:
The achieved effect of the code is the same,
but the developer is to blame.

I send a new patch of 2/2 in a minute, splitted into 2 commits.

Highlights of part 2:
a) move "if (!shared_repository)" to the right place
b) Simplify calc_shared_perm() even more: Remove the variable "int shared"
c) Remove calc_shared_perm_dir(), the functionality is baked into
   adjust_shared_perm()
