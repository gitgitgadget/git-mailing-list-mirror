Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99680C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 23:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbiCIXLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 18:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237901AbiCIXLN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 18:11:13 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A009150E0F
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 15:10:13 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E889610E01E;
        Wed,  9 Mar 2022 18:10:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VwKGslOw44spyTWeWB2+vv6ia3+4HhHB8Hx9Q3
        BL1OI=; b=b2LA+6quvkUKtNuRJk9wt3A7SVkBhE3AZdoeR9K16K054e02JlWmqY
        OHVdKLstLl58usKNTFJv8wouI4cUVxQHhyMNLy0hCuT3f+LH5X8SojNks/lIX4OK
        lh0LfYDsVekMsaH0oYM9nF1OrHLW2qkIlqXAtFCFyEbFsoA39M+2s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E0D6E10E01D;
        Wed,  9 Mar 2022 18:10:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3331F10E01C;
        Wed,  9 Mar 2022 18:10:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 0/4] builtin add -p: hopefully final readkey fixes
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
        <20220309110325.36917-1-phillip.wood123@gmail.com>
Date:   Wed, 09 Mar 2022 15:10:10 -0800
In-Reply-To: <20220309110325.36917-1-phillip.wood123@gmail.com> (Phillip
        Wood's message of "Wed, 9 Mar 2022 11:03:21 +0000")
Message-ID: <xmqqilsmlo31.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 127CD74E-9FFE-11EC-80FE-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> V1 Cover Letter:
>
> Fix the remaining issues that I'm aware of when using the built in
> "add -p" with interactive.singlekey that are stopping it from being
> merged to master. The first three patches make sure that we call
> tcsetattr() and the same file descriptor that we use for read() and
> work around poll() being broken when reading from terminals on
> macos. The final patch is more of an improvement rather than a bug fix
> (the same issue already exists in the perl version) and could proceed
> separately.
>
> Unfortunately these patches conflict with
> 'cb/save-term-across-editor-invocation' as well as the textual
> conflicts there is a semantic conflict as the argument to save_term()
> is changed so the code in editor.c will need updating.
>
> These patches are based on 'pw/single-key-interactive'

Is it still true, or does the base only apply to v1?

$ git checkout --detach pw/single-key-interactive
HEAD is now at ac618c418e add -p: disable stdin buffering when interactive.singlekey is set
$ git am -s ./+pw4-v2-add-p-single
Applying: terminal: use flags for save_term()
Applying: terminal: don't assume stdin is /dev/tty
Applying: terminal: work around macos poll() bug
error: patch failed: compat/terminal.c:397
error: compat/terminal.c: patch does not apply
Patch failed at 0003 terminal: work around macos poll() bug
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
$ exit
