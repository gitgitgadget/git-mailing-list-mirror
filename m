From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 0/4] grep: add more information to hunk separators
Date: Mon, 26 Mar 2012 23:12:12 +0200
Message-ID: <4F70DBAC.4010609@lsrfire.ath.cx>
References: <1332729705-9283-1-git-send-email-lodatom@gmail.com> <4F709664.1060206@lsrfire.ath.cx> <7vobrjp7gu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 23:12:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCHDK-00005B-4Q
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 23:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756814Ab2CZVMR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Mar 2012 17:12:17 -0400
Received: from india601.server4you.de ([85.25.151.105]:33460 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756556Ab2CZVMO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 17:12:14 -0400
Received: from [192.168.2.105] (p4FFD8F84.dip.t-dialin.net [79.253.143.132])
	by india601.server4you.de (Postfix) with ESMTPSA id 3237D2F8038;
	Mon, 26 Mar 2012 23:12:13 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120312 Thunderbird/11.0
In-Reply-To: <7vobrjp7gu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193976>

Am 26.03.2012 20:01, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe<rene.scharfe@lsrfire.ath.cx>  writes:
>
>> Looking at the above, I thought: We have unified diffs between two
>> files, we have combined diffs between more than two, what about
>> showing grep results as one-sided unified diffs?  ("What's the sound
>> of one hand clapping?" :-)
>>
>> 	--- a/git.c
>> 	@ -570,3 @ int main(int argc, const char **argv)
>> 	-		printf("usage: %s\n\n", git_usage_string);
>> 	:		list_common_cmds_help();
>> 	-		printf("\n%s\n", git_more_info_string);
>>
>> Pro: Generalization of an established format for showing interesting
>> parts of a file.  Less duplication of meta-information.  Markers tha=
t
>> tell us the kind of the shown lines are kept ("-" for context, ":" f=
or
>> matches).  Machine parsable.
>>
>> Con: Why the "a/" prefix?  One-sided diffs, srsly?
>
> Cute, and I tend to agree that this is probably easier to read if you=
 are
> used to reading unified diffs.
>
> Wouldn't it make more sense to replace your '-/:' with ' /=3D', so th=
at at
> least ' ' SP retains the meaning of "this is shown merely to give you
> context, it is not a proper part of what you are looking for"?

Ah, good idea, the space makes for a less cluttered output.  For=20
completeness sake, I have to mention that the current grep output uses=20
'-/:/=3D', however, for context/match/function line ("especially=20
interesting context").  Even function lines that happen to fall within=20
the --context are marked with an equal sign.  That's not the case for=20
unified diffs; they simply get shown as normal context.

> The reasoning behind '=3D' is that it is not either -/+ as we are not=
 really
> comparing anything with anything.

Mapping the '-/:/=3D' of grep to ' /:/=3D' or ' /:/ ' might be easier t=
o=20
understand.  However, seeing a line starting with a colon or an equal=20
sign feels both strange, because they are normally used as binary=20
operators.  Normal grep output shows a filename or a line number before=
=20
the separator, so it doesn't invoke that strange feeling.

Perhaps mapping to ' /!/ ' is better instead, similar to context diffs?

> It may also make sense to replace the
> per-file header line with "=3D=3D=3D git.c" to be consistent.

A context diffs would have '*** git.c', but they are ugly IMHO, overall=
=2E

What we also could do: Produce a valid unified diff that would remove=20
the matching lines if we were to apply it (or the --reverse, i.e. +=20
instead of -).  Then we wouldn't need to invent a special format, but=20
the output would be a bit more verbose due to the added +++ lines.

I guess it's time to implement these options in order to try them out=20
against real code.  Won't have time to do so before the second half of=20
the week, however.

Ren=C3=A9
