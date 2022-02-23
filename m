Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3CBC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 21:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239510AbiBWVfI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 16:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiBWVfH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 16:35:07 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361914ECE8
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 13:34:39 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0772F11F670;
        Wed, 23 Feb 2022 16:34:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DhU3VEoq0f7HDg6YktPCIPPjmeEkV3MkbqFWct
        kTPu0=; b=f0JzMOjqpYYyw+tfC0nR9GvNXHVs7RhD0NZjao/+IOK0rSqB9Je/tl
        oVsnBkhiFYdmhrm0VCRtLMvyECYMoB3Q6yQEVw+f7lSQUHMHH8bTJUUE8FtPFHGX
        tbTRa6XKwsHGvskj1R/ypzfywdpNsDLHaXYlduOK1DyT0uQrKMW0M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F106211F66F;
        Wed, 23 Feb 2022 16:34:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5660D11F66E;
        Wed, 23 Feb 2022 16:34:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/4] a couple of read_key_without_echo() fixes
References: <pull.1146.git.1645008873.gitgitgadget@gmail.com>
        <pull.1146.v2.git.1645556015.gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 13:34:36 -0800
In-Reply-To: <pull.1146.v2.git.1645556015.gitgitgadget@gmail.com> (Phillip
        Wood via GitGitGadget's message of "Tue, 22 Feb 2022 18:53:31 +0000")
Message-ID: <xmqqv8x5s1w3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6675CE6E-94F0-11EC-B7B9-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> I have added a new patch to the beginning of the series that fixes a case
> where we did not call restore_term() when leaving read_key_without_echo(). I
> have also reworded the commit message to patch 2 as SIGINT is actually
> ignored while the editor is running (we should probably change that code to
> use wait_after_clean instead).

All patches looked good.  Thanks.

Let's mark it for 'next' and below soonish.

>
> Cover letter for V1:
>
> Fix a couple of bugs I noticed when using the builtin "add -p" with
> interactive.singlekey=true. The first patch is a general fix for the
> terminal save/restore functionality which forgot to call sigchain_pop() when
> it restored the terminal. The last two fix reading single keys in
> non-canonical mode by making sure we wait for an initial key press and only
> read one byte at a time from the underlying file descriptor.
>
> Note that these are untested on windows beyond our CI compiling them
>
> Phillip Wood (4):
>   terminal: always reset terminal when reading without echo
>   terminal: pop signal handler when terminal is restored
>   terminal: set VMIN and VTIME in non-canonical mode
>   add -p: disable stdin buffering when interactive.singlekey is set
>
>  add-interactive.c |  2 ++
>  compat/terminal.c | 29 +++++++++++++++++++++++------
>  compat/terminal.h |  8 ++++++++
>  3 files changed, 33 insertions(+), 6 deletions(-)
>
>
> base-commit: b80121027d1247a0754b3cc46897fee75c050b44
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1146%2Fphillipwood%2Fwip%2Fadd-p-vmin-v2-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1146/phillipwood/wip/add-p-vmin-v2-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1146
>
> Range-diff vs v1:
>
>  -:  ----------- > 1:  45609d61afc terminal: always reset terminal when reading without echo
>  1:  9a3c2cea0f9 ! 2:  0020953f1cf terminal: pop signal handler when terminal is restored
>      @@ Commit message
>           external caller was removed by e3f7e01b50 ("Revert "editor: save and
>           reset terminal after calling EDITOR"", 2021-11-22). Any future callers
>           of save_term() should benefit from having the signal handler set up
>      -    for them. For example if we reinstate the code to protect against an
>      -    editor failing to restore the terminal attributes we would want that
>      -    code to restore the terminal attributes on SIGINT. (As an aside
>      -    run_command() installs a signal handler that waits for the child
>      -    before re-raising the signal so we would be guaranteed to restore the
>      -    settings after the child has exited.)
>      +    for them.
>       
>           Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>       
>  2:  02009172e08 = 3:  7ae9b236554 terminal: set VMIN and VTIME in non-canonical mode
>  3:  6d8423b6e1e = 4:  39b061a471b add -p: disable stdin buffering when interactive.singlekey is set
