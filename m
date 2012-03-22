From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH] Demonstrate failure of 'core.ignorecase = true'
Date: Thu, 22 Mar 2012 21:00:31 +0100
Message-ID: <4F6B84DF.8040806@in.waw.pl>
References: <1332370222-5123-1-git-send-email-pj@irregularexpressions.net> <4F6ACB67.1080503@viscovery.net> <4F6B0C3E.8090501@in.waw.pl> <20120322141245.GB8803@sigill.intra.peff.net> <7vbonozi8c.fsf@alter.siamese.dyndns.org> <20120322173701.GA11928@sigill.intra.peff.net> <7viphwxyp1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	"Peter J. Weisberg" <pj@irregularexpressions.net>,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 21:00:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAoBk-0003E8-V2
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 21:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030599Ab2CVUAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 16:00:44 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:56089 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030419Ab2CVUAn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 16:00:43 -0400
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.0.12])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SAoBZ-0003MY-21; Thu, 22 Mar 2012 21:00:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <7viphwxyp1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193709>

On 03/22/2012 07:44 PM, Junio C Hamano wrote:
> Jeff King<peff@peff.net>  writes:
>
>> On Thu, Mar 22, 2012 at 09:57:23AM -0700, Junio C Hamano wrote:
>>
>>> Hrm, replacing unclear part with clarified text may make sense, but it
>>> would not help adding new text if the existing description is not clear
>>> enough.
>>>
>>> How about doing it like this?
>>>
>>>     Case-insensitive filesystems like FAT and HFS+ have various strange
>>>     behaviours, like reporting that a file "Makefile" already exists when
>>>     the file that actually exists on them is "makefile". By setting this
>>>     variable to `true`, Git employs logic to work around them.
I think that this paragraph is too judgemental. While case-insensitive 
filesystems may be a pain, they are not "strange" to their users, but 
rather natural, and don't require "working around".

> I guess we really need to make the description foolproof then.
>
>                     ... exists on them is "makefile". By setting this
> 	variable to `true`, Git employs logic to work around them.
>          Setting this to `true` on a case insensitive filesystem does
> 	not make any sense, because it would not magically make your
> 	system to treat your filesystem case insensitively.
Even this updated text does not say _what_ happens when core.ignorecase 
is set on a case-insensitive filesystem. Once that's cleared up, then 
the corner case of core.ignorecase=true on case-sensitive fs can be tackled.

Maybe:
--- 8< ---
When set, case-insensitive comparisons will be used when internally 
comparing file names.

The default is false, but when a new repository is created by 
git-clone[1] or git-init[1], git will probe the filesystem and set it to 
`true` if the filesystem is case-insensitive.

On case-insensitive filesystems like FAT, NTFS and HSF+, names that 
differ only in capitalization, like "Makefile" and "makefile", refer to 
the same file. While such filesystems usually preserve the 
capitalization used during file creation, tools designed for such 
filesystems will often modify capitalization when saving files and when 
displaying filenames. Enabling core.ignorecase causes git to ignore 
case-only differences in file names.

Enabling core.ignorecase on a case insensitive filesystem does
not make sense, because filenames with different capitalization will 
still be treated as different by the filesystem.
--- >8 ---

[+cc Brandon Casey]

zByszek
