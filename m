From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v17 1/7] bisect: move argument parsing before state modification.
Date: Wed, 07 Sep 2011 20:07:46 +0200
Message-ID: <4E67B2F2.9070806@kdbg.org>
References: <1312459263-16911-1-git-send-email-jon.seymour@gmail.com> <1312459263-16911-2-git-send-email-jon.seymour@gmail.com> <201109070816.16655.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, jnareb@gmail.com, jrnieder@gmail.com
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Sep 07 20:07:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1MXW-0006cf-1m
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 20:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888Ab1IGSHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 14:07:52 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:15502 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751278Ab1IGSHv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 14:07:51 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 5CC2E130049;
	Wed,  7 Sep 2011 20:07:47 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id AB30E19F454;
	Wed,  7 Sep 2011 20:07:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.20) Gecko/20110804 SUSE/3.1.12 Thunderbird/3.1.12
In-Reply-To: <201109070816.16655.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180891>

Am 07.09.2011 08:16, schrieb Christian Couder:
> If we start bisecting like this:
> 
> $ git bisect start HEAD HEAD~20
> 
> and then we decide that it was not optimum and we want to start again like 
> this:
> 
> $ git bisect start HEAD HEAD~6
> 
> then issuing the latter command might not work as it did before this patch.
>  
> Before this patch the latter command would do a "git checkout $start_head" 
> before the repeated rev=$(git rev-parse -q --verify "$arg^{commit}") to 
> convert arguments into sha1. And after this patch the order is reversed.
> 
> This means that before this patch "HEAD" in the arguments to "git bisect 
> start" would refer to $start_head because the "git checkout $start_head" 
> changes HEAD. After this patch "HEAD" in the arguments to "git bisect start" 
> would refer to the current HEAD.

But isn't this an improvement? HEAD denotes the current head. After the
first 'bisect start HEAD HEAD~20', HEAD is somewhere in the middle, not
the original HEAD anymore; I would *expect* that a different commit is
checked out if I just repeat the command.

IOW, I think the new behavior is *much* better than the old behavior.

-- Hannes
