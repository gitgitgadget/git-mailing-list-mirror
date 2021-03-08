Return-Path: <SRS0=iBdC=IG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AD5C433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 13:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2E5C6512C
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 13:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhCHNHs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 08:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhCHNHc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 08:07:32 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559F6C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 05:07:32 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id l12so14682858edt.3
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 05:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=EVMzp2FeHVYNDmaysjdR3KSbpyT+3jNhzXfiW/t+bXU=;
        b=KJY5myRxiSspPVF7fUZi/VB6ikYP/QpgOe7JcnQqrqiSgYaH1B1Q1wDDo7SRvh/XqP
         Ih/g8EpDheMyO/u1AnRCdV3jGRfQBTRTCmWdB/PdXk7FoNPY1+d6UDdpo1pn5iSqvYkV
         kLpvEtHl3gzfTSTQrD08jvmt+HNxaro7OPvAF872vcGAdJNCGkxuf/e/g5CyreicOHTb
         PZY/0GSuO79oc3Jl/ZMfQLsBmGC7CmkS2rDdGC4WqdPcHlMUj8Mm8bCO+sHaS7aDxpww
         pMJgcwe2QatoNMsO3DHk/R4P/LEDL2K0yOlhdKO87WMoXJODup3RGws/f5ApbE7U0Ic+
         cJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=EVMzp2FeHVYNDmaysjdR3KSbpyT+3jNhzXfiW/t+bXU=;
        b=fcfaY4Gv7YJXDvqeOb0V0Ug0R/GqwdEX8T2x5XW8+WLRfMTPx5qFn0aJ9ZVlN+LZ9h
         ckYPPLjQFn9Mv2aCMVvNfdFawFUj5xWtZ8Y5ZADSme+XtrwNrz0Fah/K08VOHjhcgB2h
         nv8l2A1BSHh7ZZ0rdUTe1rcjYQa7+zjN7gWWygkWfy4RLWNySkPkLd8qtS9BKb+zQYnD
         UZqMzsvrxNRceCGo6n0YgA/a3h7rqv7jOvnTEQWUYKHCY0GpAPAkEfjZBrteo04iUwYH
         fisiQ+E7q/jLHPtaX+5zy12EdlyJEX5JODmoXDOoo9p25vhzQiLrwhC6nP+XbJujX0Nw
         r3CA==
X-Gm-Message-State: AOAM530Oc5nXyCfjr9LXu+B7CVCnFgGOXcm1XL9+DelVvVxgRDOv5ahW
        KpN4bBPrc9U5O0k+re9Tu2QTYUg23zCarA==
X-Google-Smtp-Source: ABdhPJxeibd0Yq84C+TEqf32bIp4oWfNIwOtnR+8iYoiyg4U1j2QIBY4oUZmCUTvibK3WR1TQHJa0Q==
X-Received: by 2002:a05:6402:1157:: with SMTP id g23mr2065842edw.303.1615208850871;
        Mon, 08 Mar 2021 05:07:30 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id r13sm7113776edy.3.2021.03.08.05.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 05:07:30 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 09/11] t: mark several submodule merging tests as fixed
 under merge-ort
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
 <95a6c0abe558f6fe2c570602650b4511d33296b2.1614905738.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <95a6c0abe558f6fe2c570602650b4511d33296b2.1614905738.git.gitgitgadget@gmail.com>
Date:   Mon, 08 Mar 2021 14:07:29 +0100
Message-ID: <87y2exiyjy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 05 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> merge-ort handles submodules (and directory/file conflicts in general)
> differently than merge-recursive does; it basically puts all the special
> handling for different filetypes into one place in the codebase instead
> of needing special handling for different filetypes in many different
> code paths.  This one code path in merge-ort could perhaps use some work
> still (there are still test_expect_failure cases in the testsuite), but
> it passes all the tests that merge-recursive does as well as 12
> additional ones that merge-recursive fails.  Mark those 12 tests as
> test_expect_success under merge-ort.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t3512-cherry-pick-submodule.sh              | 9 +++++++--
>  t/t3513-revert-submodule.sh                   | 7 ++++++-
>  t/t5572-pull-submodule.sh                     | 9 +++++++--
>  t/t6437-submodule-merge.sh                    | 5 +++--
>  t/t6438-submodule-directory-file-conflicts.sh | 9 +++++++--
>  5 files changed, 30 insertions(+), 9 deletions(-)
>
> diff --git a/t/t3512-cherry-pick-submodule.sh b/t/t3512-cherry-pick-submodule.sh
> index 822f2d4bfbd5..eb7a47b9d98a 100755
> --- a/t/t3512-cherry-pick-submodule.sh
> +++ b/t/t3512-cherry-pick-submodule.sh
> @@ -8,8 +8,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-submodule-update.sh
>  
> -KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
> -KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
> +if test "$GIT_TEST_MERGE_ALGORITHM" = ort
> +then
> +	:  # No special additional KNOWN_FAILURE knobs to set
> +else
> +	KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
> +	KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
> +fi

nit: I think this and the rest would be just as readable/obvious without
the comment as:

    if test "$x" != ort
    then
            some_vars=xyz
    fi
