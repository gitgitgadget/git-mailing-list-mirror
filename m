From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: t6200: avoid path mangling issue on Windows
Date: Fri, 19 Apr 2013 21:46:32 +0200
Message-ID: <51719F18.3020508@kdbg.org>
References: <1365348344-1648-1-git-send-email-ralf.thielow@gmail.com> <1365348344-1648-2-git-send-email-ralf.thielow@gmail.com> <516F95D1.5070209@viscovery.net> <7v38un93br.fsf@alter.siamese.dyndns.org> <5170DA96.9000300@viscovery.net> <7vr4i632fp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 21:46:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTHGZ-0007gy-QI
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 21:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058Ab3DSTqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 15:46:35 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:2654 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753962Ab3DSTqf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 15:46:35 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 6612910011;
	Fri, 19 Apr 2013 21:46:33 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 62C1219F5A8;
	Fri, 19 Apr 2013 21:46:32 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vr4i632fp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221812>

Am 19.04.2013 18:33, schrieb Junio C Hamano:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> Am 4/18/2013 19:05, schrieb Junio C Hamano:
>>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>>
>>>> From: Johannes Sixt <j6t@kdbg.org>
>>>>
>>>> MSYS bash interprets the slash in the argument core.commentchar="/"
>>>> as root directory and mangles it into a Windows style path. Use a
>>>> different core.commentchar to dodge the issue.
>>>>
>>>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>>>> ...
>>>> -	git -c core.commentchar="/" fmt-merge-msg --log=5 <.git/FETCH_HEAD >actual &&
>>>> +	git -c core.commentchar="x" fmt-merge-msg --log=5 <.git/FETCH_HEAD >actual &&
>>>
>>> Sigh... Again?
>>>
>>> Are folks working on Msys bash aware that sometimes the users may
>>> want to say key=value on their command line without the value
>>> getting molested in any way and giving them some escape hatch would
>>> help them?  Perhaps they have already decided that it is not
>>> feasible after thinking about the issue, in which case I do not have
>>> new ideas to offer.
>>
>> What is "the issue"? And in which way would an escape hatch help us here?
> 
> When the user passes key=value and value begins with a slash, value
> may be a path in the filesystem very often, and adjusting it to the
> local filesystem convention helps Windows users a lot.
> 
> But there are cases outside that very often when the user wants the
> value passed literally.  There seems to be no way to do so.
> ...
> if bash could be told with a very unnatural and not so hard to type
> way that the particular value is not to be mangled, e.g.
> 
> 	xyzzy key="""/a/b/c"""

I'll not argue whether such a feature would make sense or not, or
whether it can be implemented, because it is aimed at the user, but
misses one important point: It does in no way help our development process.

A patch auther whose first instinct is to write 'foo=/' will never write
'foo=x', let alone 'foo="""/"""'. Someone will have to discover the
issue eventually and write a patch to fix it, and someone will have to
apply it.

I don't think that we can do anything about it.

-- Hannes
