Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D0022018E
	for <e@80x24.org>; Fri,  5 Aug 2016 18:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946292AbcHES3Z (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 14:29:25 -0400
Received: from siwi.pair.com ([209.68.5.199]:59633 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936889AbcHES3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 14:29:24 -0400
Received: from [10.160.15.137] (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 82398845EE;
	Fri,  5 Aug 2016 14:29:22 -0400 (EDT)
Subject: Re: [PATCH v4 7/8] git-status.txt: describe --porcelain=v2 format
To:	Junio C Hamano <gitster@pobox.com>
References: <1470147137-17498-1-git-send-email-git@jeffhostetler.com>
 <1470147137-17498-8-git-send-email-git@jeffhostetler.com>
 <xmqq60rfxfyl.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	Jeff Hostetler <jeffhost@microsoft.com>
From:	Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <57A4DA85.2010809@jeffhostetler.com>
Date:	Fri, 5 Aug 2016 14:27:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq60rfxfyl.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 08/05/2016 01:50 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
>
>> +Porcelain Format Version 2
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +Version 2 format adds more detailed information about the state of
>> +the worktree and changed items.  Version 2 also defines an extensible
>> +set of easy to parse optional headers.
>> +
>> +Header lines start with "#" and are added in response to specific
>> +command line arguments.  Parsers should ignore headers they
>> +don't recognize.
>> +
>> +### Branch Headers
>> +
>> +If `--branch` is given, a series of header lines are printed with
>> +information about the current branch.
>> +
>> +    Line                                     Notes
>> +    ------------------------------------------------------------
>> +    # branch.oid <commit> | (initial)        Current commit.
>> +    # branch.head <branch> | (detached)      Current branch.
>
> In an earlier review I made a noise about "branch.head", but reading
> this together with others in a context, "branch.head" is good and I
> do not see a need to bikeshed it into "branch.name".

right.


>> +    # branch.upstream <upstream_branch>      If upstream is set.
>> +    # branch.ab +<ahead> -<behind>           If upstream is set and
>> +                                             the commit is present.
>> +    ------------------------------------------------------------
>> +
>> +### Changed Tracked Entries
>> +
>> +Following the headers, a series of lines are printed for tracked
>> +entries.  One of three different line formats may be used to describe
>> +an entry depending on the type of change.  Tracked entries are printed
>> +in an undefined order; parsers should allow for a mixture of the 3
>> +line types in any order.
>> +
>> +Ordinary changed entries have the following format:
>> +
>> +    1 <XY> <sub> <mH> <mI> <mW> <hH> <hI> <path>
>> +
>> +Renamed or copied entries have the following format:
>> +
>> +    2 <XY> <sub> <mH> <mI> <mW> <hH> <hI> <X><nr> <path><sep><pathSrc>
>> +
>> +    Field       Meaning
>> +    --------------------------------------------------------
>> +    <XY>        A 2 character field containing the staged and
>> +                unstaged XY values described in the short format,
>> +                with unchanged indicated by a "." rather than
>> +                a space.
>> +    <sub>       A 4 character field describing the submodule state.
>> +                "N..." when the entry is not a submodule.
>> +                "S<c><m><u>" when the entry is a submodule.
>> +                <c> is "C" if the commit changed; otherwise ".".
>> +                <m> is "M" if it has tracked changes; otherwise ".".
>> +                <u> is "U" if there are untracked changes; otherwise ".".
>> +    <mH>        The 6 character octal file mode in the HEAD.
>
> We do want "octal" to be spelled out, but I doubt that we want to
> guarantee to the reading scripts that this will always be 6
> characters.

good point. "octal" is sufficient.


>> +    <mI>        The octal file mode in the index.
>> +    <mW>        The octal file mode in the worktree.
>> +    <hH>        The SHA1 value in the HEAD.
>> +    <hI>        The SHA1 value in the index.
>
> Please avoid inventing a word "SHA1 value" that does not appear in
> Documentation/glossary-content.txt; s/SHA1 value/object name/g.
> This comment applies to the desciption for "U" lines below, too.

ok.


>> +    <X><nr>     The rename or copied percentage score. For example "R100"
>> +                or "C75".
>
> Documentation/diff-format.txt seems to call this differently.
>
> 	The rename or copy "score" number, e.g. "R100", "C75".
>
> perhaps?

right, this is the same score.


>> +    <path>      The current pathname.
>
> Unless you are talking about "2" line, saying "current" is somewhat
> weird.  I _think_ <path> is the name in the index and in the working
> tree, as opposed to the original path in the HEAD, but the
> distinction does not matter for "1" or "U" lines.

Right.  The index path, since we only report renames for
head-vs-index.


> As this table is meant to be shared between "1" and "2", perhaps
>
> 	<path>     The pathname.  In a renamed/copied entry, this
> 		   is the path in the index and in the working tree.
> 	<origPath> The pathname in the commit at HEAD.  This is only
>                     present in a renamed/copied entry, and tells
>                     where the renamed/copied contents came from.
>
> or something like that may clarify it a bit better.  Then in the
> table for "U" lines, we can just say "The pathname".
>
>> +    <sep>       When the `-z` option is used, the 2 pathnames are separated
>> +                with a NUL (ASCII 0x00) byte; otherwise, a tab (ASCII 0x09)
>> +                byte separates them.
>> +    <pathSrc>   The original path. This is only present when the entry
>> +                has been renamed or copied.
>
> If it is explained as "the original path", wouldn't it be easier to
> read if it were called "<origPath>" instead of "<pathSrc>"?

yes.


>> +When the `-z` option is given, pathnames are printed as is and
>> +without any quoting and lines are terminated with a NUL (ASCII 0x00)
>> +byte.
>> +
>> +Otherwise, all pathnames will be "C-quoted" if they contain any tab,
>> +linefeed, double quote, or backslash characters. In C-quoting, these
>> +characters will be replaced with the corresponding C-style escape
>> +sequences and the resulting pathname will be double quoted.
>
> Looks good.
>
> I think I saw "C-Quoted" elsewhere (perhaps in a in-code comment),
> which should be spelled consistently i.e. "C-quoted".

Right.

Thanks,
Jeff



