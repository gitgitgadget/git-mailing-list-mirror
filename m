Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7D4C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 06:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbiLTGSe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 01:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbiLTGS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 01:18:29 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED3412AB2
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 22:18:28 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id gt4so11426640pjb.1
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 22:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/G4MFYbHdD+bP5XP2IKaGRkgRJZLzf2CZWEAX8o1us=;
        b=NqZ2y5X4Lrj/tlg0SFbywn6ydkXzROSwG7sewV9lm1ylX1TTkxJvEYapDK7a/UGu3h
         Zy2P4sC0dl1osSQgg9N3pCnyfn08TOzChEveBZ7vgHNNp6kzUmgwAjfgvL3V+gkjr/Uc
         FTz1MwxSmYrwoaQFEyZy+vFSMjNqd6s2FUwfThZrNItOCmOzCS2WMNjaR34fNKV1Gkyy
         v0Ma7RcjoxDghF+qvu9Ncu1IGIhXLmWDJpoYQHwxOFPOQJqpbB3MIh9aozClajN2rb99
         FcinUF7suINSLP+8Gg8gzP/W7FiPcufM1gYESNnSeb0JCDLibIAOaf+3wLWNHhDF+WVO
         g3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3/G4MFYbHdD+bP5XP2IKaGRkgRJZLzf2CZWEAX8o1us=;
        b=z08hCahPYBacahyrcv/1HvonM9KdyNA7zVcsfAG0Z67E/7yYSkx9ZlnZIy+eTQ0gzl
         r3hOG4TfR00QfauexyVcuBeTVhzE3i5BueuXGq/AaJmWABywvXlO+A6EfVYT7AgtNy+1
         +6we6BuyQFJr/9tT0epycZDF4BLtODWVL4nUCYTe1nnH/3nyfPsElyVdXcdL3emYEA6q
         wscQXp7j1Wic2K6J8jHvz9Ibm2gOWgqEpeYbW0UWSETFQrr3kD66iLFeQUdw9+VCpg3j
         3YhAstcU025m6VhAjUY3IatKFLPofbKZlwBBlXfKiUeNICUZuUiX+HMDju5swGJFKlD3
         5TcQ==
X-Gm-Message-State: ANoB5pk8DhdUSbc9xMw9cL+7oeXIMqb62h2YOn4FNwlwfcecLx9YJMRm
        q0acb/tRaPyLucJvtbuyzQM=
X-Google-Smtp-Source: AA0mqf47I8HzO4xQVGduIbCWhPkOeh5rVIN1hmABOHDMhdoYhDqG9RhIrSgsSzlb1sF91alLhfP0tA==
X-Received: by 2002:a05:6a20:a028:b0:9d:efbe:52b2 with SMTP id p40-20020a056a20a02800b0009defbe52b2mr63577892pzj.34.1671517107896;
        Mon, 19 Dec 2022 22:18:27 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u31-20020a63235f000000b00488b8ad57bfsm4918062pgm.54.2022.12.19.22.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 22:18:27 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v5 4/4] worktree add: Add hint to use --orphan when bad ref
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
        <20221104213401.17393-1-jacobabel@nullpo.dev>
        <20221110233137.10414-1-jacobabel@nullpo.dev>
        <20221212014003.20290-1-jacobabel@nullpo.dev>
        <20221220023637.29042-1-jacobabel@nullpo.dev>
        <20221220023637.29042-5-jacobabel@nullpo.dev>
Date:   Tue, 20 Dec 2022 15:18:27 +0900
In-Reply-To: <20221220023637.29042-5-jacobabel@nullpo.dev> (Jacob Abel's
        message of "Tue, 20 Dec 2022 02:38:20 +0000")
Message-ID: <xmqqfsdawqbw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Abel <jacobabel@nullpo.dev> writes:

> Subject: Re: [PATCH v5 4/4] worktree add: Add hint to use --orphan when bad ref

Incomplete sentence that invites "when bad ref, what?"

> +			"	git worktree add --orphan %s %s\n"), new_branch, path

OK.  "git worktree add -b <name-of-branch> <path>" is how you create
a worktree and have it on a named branch.  And instead of saying -b, 
you would say --orphan.  This sounds like a fairly easy-to-understand
parallel to how "git checkout [-b/-B/--orphan] name-of-branch" takes
its parameters.

> +test_wt_add_empty_repo_orphan_hint() {
> +	local context="$1"
> +	shift
> +	local opts="$@"
> +	test_expect_success "'worktree add' show orphan hint in empty repo w/ $context" '
> +		test_when_finished "rm -rf empty_repo" &&
> +		GIT_DIR="empty_repo" git init --bare &&
> +		test_must_fail git -C empty_repo worktree add $opts foobar/ 2> actual &&

The comments on "$@" (vs "$*") in an earlier step equally applies here.
