Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28CFC433F5
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 22:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbiBIWsx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:48:53 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbiBIWsw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 17:48:52 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2411FE01976B
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 14:48:55 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 49D47FF394;
        Wed,  9 Feb 2022 17:48:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OVK9O6x0zYZo
        +OM8P/7/1MCrpQiyIN9wwJZOds4vqHc=; b=c4DPpLmj5Q9yEEUCgqQaCjdSBEfS
        VlBw4iBVok8b8TXOdVEfuwrQFdt+zPmGyh6slEBkm+aK85KrCgDvlXCiOTt2gHpS
        bo/1EUWwJ8GsormRIIRvtz6S+H684MZNtyi/EgEnrFyPRJCHT4vnwg76RojwTuqO
        /1iREQiY1oSG4II=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C7F8FF392;
        Wed,  9 Feb 2022 17:48:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 91FC9FF391;
        Wed,  9 Feb 2022 17:48:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/6] archive: optionally add "virtual" files
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
        <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
        <49ff3c1f2b32b16df2b4216aa016d715b6de46bc.1644187146.git.gitgitgadget@gmail.com>
        <d1e333b6-3ec1-8569-6ea9-4abd3dee1947@web.de>
        <xmqqbkzigspr.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2202081406520.347@tvgsbejvaqbjf.bet>
        <xmqqbkzhdzib.fsf@gitster.g>
        <b49d396d-a433-51a4-2d19-55e175af571a@web.de>
Date:   Wed, 09 Feb 2022 14:48:52 -0800
In-Reply-To: <b49d396d-a433-51a4-2d19-55e175af571a@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 8 Feb 2022 21:58:16 +0100")
Message-ID: <xmqqk0e364h7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 74CF1124-89FA-11EC-9D12-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>>> Nevertheless, it is still the most elegant way that I can think of to
>>> generate a diagnostic `.zip` file without messing up the very things =
that
>>> are to be diagnosed: the repository and the worktree.
>>
>> Puzzled.  Are you feeding contents of a .zip file from the command
>> line?
>
> Kind of.  Command line arguments are built and handed to write_archive(=
)
> in-process.  It's done by patch 3 and extended by 5 and 6.

I meant to ask if this is doing

    git archive --store-contents-at-path=3D"report.zip:$(cat diag.zip)"

as I misunderstood what 'the diagnostic .zip file' referred to.
That was a reference to the output of the "git archive" command.

> The number of files is relatively low and they aren't huge, right?

As long as it is expected to fit on the command line, that's fine.
But if the question is "it is OK to add a new option with known
limitation", then it should be stated a bit differently.

"We add this option for use cases where we handle only small number
of one-liner files", and it is OK.  We may however want to do
something imilar to what we do to the "-m '<message>'" option used
by "git commit" and "git merge", i.e. add the final LF when it is
missing to make it a complete line, to hint the fact that this is
meant to add a small number of single liner files.

>> Another worry was that when <contents> can have
>> arbitrary bytes, with --opt=3D<path>:<contents> syntax, the input
>> becomes ambiguous (i.e. "which colon is the <path> separator?"),
>> without some way to escape a colon in the payload.
>
> The first colon is the separator here.

Meaning you cannot have a colon in the path, which is not exactly
pleasing limitation.  I know you may not be able to do so on Windows
or CIFS mounted on non-Windows, but we do not limit ourselves to
portable filename character set (POSIX.1 3.282), either.

>> This will throw another monkey wrench to Konstantin's plan [*] to
>> make "git archive" output verifiable with the signature on original
>> Git objects, but it is not a new problem ;-)
>>
>>
>> [Reference]
>>
>> * https://lore.kernel.org/git/20220207213449.ljqjhdx4f45a3lx5@meerkat.=
local/
>
> I don't see the conflict: If an untracked file is added to an archive
> using --add-file, --add-file-with-content, or ZIP or tar then we'd
> *want* the verification against a signed commit or tag to fail, no?  A
> different signature would be required for the non-tracked parts.

Yes, which is exactly how this (and existing --add-file) makes
Konstantin's plan much less useful.

Thanks.
