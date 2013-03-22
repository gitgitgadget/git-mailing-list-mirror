From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Avoid false positives in label detection in cpp diff
 hunk header regex.
Date: Fri, 22 Mar 2013 22:55:27 +0100
Message-ID: <514CD34F.70107@kdbg.org>
References: <loom.20130322T144107-601@post.gmane.org> <7vehf78olw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Vadim Zeitlin <vz-git@zeitlins.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 22:56:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ9wR-0000Lv-JZ
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 22:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933590Ab3CVVzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 17:55:36 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:24012 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1423062Ab3CVVzf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 17:55:35 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 241A8A7EB9;
	Fri, 22 Mar 2013 22:55:29 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 4F08419F542;
	Fri, 22 Mar 2013 22:55:28 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <7vehf78olw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218853>

Am 22.03.2013 16:02, schrieb Junio C Hamano:
> Vadim Zeitlin <vz-git@zeitlins.org> writes:
> 
>> A C++ method start such as
>>
>>         void
>>         foo::bar()
>>
>> wasn't recognized by cpp diff driver as it mistakenly included "foo::bar" as a
>> label. However the colon in a label can't be followed by another colon, so
>> recognize this case specially to correctly detect C++ methods using this style.

Much appreciated!

>>  PATTERNS("cpp",
>>          /* Jump targets or access declarations */
>> -        "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:.*$\n"
>> +        "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:([^:].*$|$)\n"
> 
> Hmm.  Wouldn't "find a word (possibly after indentation), colon and
> then either a non-colon or end of line" be sufficient and simpler?
> iow, something like...
> 
>        "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:([^:]|$)"

Yes, indeed. We don't need to match more than necessary in a negative
pattern. The \n must still remain, though.

-- Hannes
