From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Avoid false positives in label detection in cpp diff
 hunk header regex.
Date: Sat, 23 Mar 2013 00:11:59 +0100
Message-ID: <514CE53F.3080308@kdbg.org>
References: <loom.20130322T144107-601@post.gmane.org> <7vehf78olw.fsf@alter.siamese.dyndns.org> <514CD34F.70107@kdbg.org> <7vhak35ami.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Vadim Zeitlin <vz-git@zeitlins.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 23 00:12:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJB8R-0008Sv-4D
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 00:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423419Ab3CVXMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 19:12:03 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:41050 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1423404Ab3CVXMC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 19:12:02 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id CE95C13004B;
	Sat, 23 Mar 2013 00:11:59 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 1EEC419F542;
	Sat, 23 Mar 2013 00:11:59 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <7vhak35ami.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218867>

Am 22.03.2013 23:32, schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Am 22.03.2013 16:02, schrieb Junio C Hamano:
>>> Vadim Zeitlin <vz-git@zeitlins.org> writes:
>>>
>>>> A C++ method start such as
>>>>
>>>>         void
>>>>         foo::bar()
>>>>
>>>> wasn't recognized by cpp diff driver as it mistakenly included "foo::bar" as a
>>>> label. However the colon in a label can't be followed by another colon, so
>>>> recognize this case specially to correctly detect C++ methods using this style.
>>
>> Much appreciated!
>>
>>>>  PATTERNS("cpp",
>>>>          /* Jump targets or access declarations */
>>>> -        "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:.*$\n"
>>>> +        "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:([^:].*$|$)\n"
>>>
>>> Hmm.  Wouldn't "find a word (possibly after indentation), colon and
>>> then either a non-colon or end of line" be sufficient and simpler?
>>> iow, something like...
>>>
>>>        "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:([^:]|$)"
>>
>> Yes, indeed. We don't need to match more than necessary in a negative
>> pattern. The \n must still remain, though.
> 
> ... because \n is not for matching against the text, but merely to
> separate the regular expressions, right?

Correct.

> I also wonder if 
> 
> 	label :
> 
> should also be caught, or is it too weird format to be worth
> supporting?

It's easy to support, by inserting another [ \t] before the first colon.
So, why not?

-- Hannes
