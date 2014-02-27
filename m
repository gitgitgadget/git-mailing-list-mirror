From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Branch Name Case Sensitivity
Date: Thu, 27 Feb 2014 21:32:01 +0100
Message-ID: <530FA0C1.3000109@web.de>
References: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com> <xmqqvbw0xrl6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Lee Hopkins <leerhop@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 21:32:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ7cr-0005vp-Fu
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 21:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbaB0UcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 15:32:09 -0500
Received: from mout.web.de ([212.227.15.14]:51655 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979AbaB0UcI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 15:32:08 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0M6Df8-1XBWjQ1WtG-00y5nw; Thu, 27 Feb 2014 21:32:02
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <xmqqvbw0xrl6.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:p841SQb8+pGN498y+rr8PckqUysdM5rc3tHEGKlASZSaagszjku
 qoIF1PsXLCIRKk+/mRuJ3dxFmFzOjtNR2jPsTwgwTQ5fJmV84Tb29myGo9jPn9nuWVHaDcX
 smNtff0RsqGR+1dwHQ8R5my7XaHHphvLTZw8V77AHpgMVo5fQDatI7XBgV8d1OyjSE+5WO8
 iGnGGIy8q3juFcXjIeH5Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242852>

On 2014-02-27 20.50, Junio C Hamano wrote:
> Lee Hopkins <leerhop@gmail.com> writes:
> 
>> Last week I ran across a potential bug with branch names on case
>> insensitive file systems, the complete scenario can be found here:
>>
>> https://groups.google.com/forum/#!topic/msysgit/ugKL-sVMiqI
>>
>> The tldr is because refs are stored as plain text files except when
>> packed into packed-refs, Git occasionally cannot tell the difference
>> between branches whose names only differ in case, and this could
>> potentially lead to the loss of history.
>>
>> It sounds like this is a known issue, and after some more digging I
>> did find some older threads related to this topic, but nothing recent.
> 
> Yes, it is not limited to branch names but also applies to tags and
> filenames in your working tree.
> 
> Perhaps git-{branch,tag}.txt and possibly gitrepository-layout.txt
> in Documentation/ may need a new "*Note*" section to warn against
> this.
> 
> Thanks.
There is a possible workaround:
git pack-refs --all --prune

If this can be triggered by a hook, I don't know (I never used a hook)

It uses the C-function pack_refs(flags) in builtin/pack-refs.c
Or we can possibly trigger this function at the the of
"checkout -b" or "fetch" commands ?
Only when core.ignorecase == true ?
