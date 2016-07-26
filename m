Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 779AC203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 19:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756936AbcGZToj (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 15:44:39 -0400
Received: from siwi.pair.com ([209.68.5.199]:55330 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756109AbcGZToh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 15:44:37 -0400
Received: from [10.160.15.137] (unknown [167.220.24.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 5CC57845F7;
	Tue, 26 Jul 2016 15:44:35 -0400 (EDT)
Subject: Re: [PATCH v2 7/8] status: update git-status.txt for --porcelain=v2
To:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
	Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org
References: <1469474750-49075-1-git-send-email-jeffhost@microsoft.com>
 <1469474750-49075-8-git-send-email-jeffhost@microsoft.com>
 <57969607.9080206@gmail.com>
Cc:	peff@peff.net, gitster@pobox.com, Johannes.Schindelin@gmx.de
From:	Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <5797BD1E.2010800@jeffhostetler.com>
Date:	Tue, 26 Jul 2016 15:42:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <57969607.9080206@gmail.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 07/25/2016 06:43 PM, Jakub Narêbski wrote:
> W dniu 2016-07-25 o 21:25, Jeff Hostetler pisze:
>
>> +Porcelain Format Version 2
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +Version 2 format adds more detailed information about the state of
>> +the worktree and the changed items.
>
> I think it should be "and changed items", but I am not a native speaker.

fixed.

>> +If `--branch` is given, a header line showing branch tracking information
>> +is printed.  This line begins with "### branch: ".  Fields are separated
>> +by a single space.
>> +
>> +    Field                    Meaning
>> +    --------------------------------------------------------
>> +    <sha> | (initial)        Current commit
>> +    <branch> | (detached)    Current branch
>> +    <upstream>               Upstream branch, if set
>> +    +<ahead>                 Ahead count, if upstream present
>> +    -<behind>                Behind count, if upstream present
>> +    --------------------------------------------------------
>> +
>> +A series of lines are then displayed for the tracked entries.
>> +Ordinary changed entries have the following format; the first
>> +character is a 'c' to distinguish them from unmerged entries.
>
> It would be nice (though not necessary) to have an example, either
> here or at the end.

I'll try to fit that in at the bottom.

>> +
>> +    c <xy> <sub> <mH> <mI> <mW> <hH> <hI> R<nr> <path>[\t<pathSrc>]
>> +
>> +    Field       Meaning
>> +    --------------------------------------------------------
>> +    <xy>        A 2 character field containing the staged and
>> +                unstaged XY values described in the short format,
>> +                with unchanged indicated by a "." rather than
>> +                a space.
>> +    <sub>       A 4 character field describing the submodule state.
>> +                "N..." when the entry is not a submodule.
>> +                "S<c><m><u>" when the entry is a submodule.
>> +                <c> is "C" if the commit changed; otherwise ".".
>> +                <m> is "M" if it has tracked changes; otherwise ".".
>> +                <u> is "U" if there are untracked changes; otherwise ".".
>> +    <m*>        The 6 character octal file modes for head, index,
>> +                and worktree.
>
> I think it might be more readable to be explicit: "for HEAD (<mH>),
> index (<mI>), and worktree (<mW>)."

I'll try to clarify that.


>> +    <h*>        The head and index SHA1 values.
>> +    R<nr>       The rename percentage score.
>
> I assume this would be C<nr> copy detection heuristics percentage
> score in case of copy detection, and B<br> break percentage score
> in case of breaking change into addition and deletion of file.
> Or am I confused?

I'm updating to include rename and copied scores.  I haven't seen
anything in the code about a break percentage in this context.  I
see it listed with -B in the git-diff-* pages, but not in status.

>
>
>> +    <path>      The current pathname. It is C-Quoted if it contains
>> +                special control characters.
>
> I assume that "\t" tab character between <path> and <pathSrc> is here
> to be able to not C-Quote sane filenames with internal whitespace,
> isn't it?

I'm using the same quoting routines as the existing porcelain
format.  So yes, that looks to be the case.  It only converts
if there are insane characters in pathnames.

>
>> +    <pathSrc>   The original path. This is only present for staged renames.
>> +                It is C-Quoted if necessary.
>
> I assume that "C-Quoted if necessary" is the same as "C-Quoted if
> it contains special control characters"; also: '"' quote character,
> '\' backlash escape character and "\t" horizontal tab are not control
> characters per se., but still need C-Quoting.  The rules are the same
> as for the rest of Git, e.g. for `git diff`, isn't it?

yes, i'm using the same quoting routine.  i'll clarify.  thanks.

>
>> +    --------------------------------------------------------
>> +
>> +Unmerged entries have the following format; the first character is
>> +a "u" to distinguish from ordinary changed entries.
>> +
>> +    u <xy> <sub> <m1> <m2> <m3> <h1> <h2> <h3> <path>
>> +
>> +    Field       Meaning
>> +    --------------------------------------------------------
>> +    <xy>        A 2 character field describing the conflict type
>> +                as described in the short format.
>> +    <sub>       A 4 character field describing the submodule state
>> +                as described above.
>> +    <m*>        The 6 character octal file modes for the stage 1,
>> +                stage 2, stage 3, and worktree.
>
> Errr... the pattern has only _3_ character octal modes, <m1> <m2> <m3>.
> A question: what happens during octopus merge?
>
>> +                For regular entries, these are the head, index, and
>> +                worktree modes; the fourth is zero.
>
> This is remnant of the previous version of "v2" format, isn't it?

yes, sorry.  I missed that one.

>
>> +    <h*>        The stage 1, stage 2, and stage 3 SHA1 values.
>> +    <path>      The current pathname. It is C-Quoted if necessary.
>> +    --------------------------------------------------------
>> +
>> +A series of lines are then displayed for untracked and ignored entries.
>> +
>> +    <x> <path>
>> +
>> +Where <x> is "?" for untracked entries and "!" for ignored entries.
>
> I assume that here also <path> is C-Quoted if necessary.

yes.

>
>> +
>> +When the `-z` option is given, a NUL (zero) byte follows each pathname;
>> +serving as both a separator and line termination. No pathname quoting
>> +or backslash escaping is performed. All fields are output in the same
>> +order.
>> +
>>   CONFIGURATION
>>   -------------
>>
>>
>
>
