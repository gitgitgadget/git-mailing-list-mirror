Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E67C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD5E7610A1
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244135AbhIAN2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 09:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244094AbhIAN2u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 09:28:50 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F238FC061760
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 06:27:53 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b6so4492007wrh.10
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 06:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=GdYra/d0wtC8djGHmTOZ0mlSBTH89OdnWPILMLYrC1E=;
        b=P/AvkHRLDLyxayZ8GsXbYx0p1NIFdbN3bsYG1yOBKY/iwJzK1611sD2CUVqZrHPd1v
         lOaR6kHMnKzJEn+fp5mUxa6CsMXYoDLKYbil7Y6xwr1NtB9L276FLaLLTlogwO3x2zq6
         sUvpoFN7pVa5k0J2SoxFa4YWpSbsA6lOPdXCdVdgMTeL2rfgwcHiPGI3kfVPr43l96Gm
         qnGJNr1PuN+N7WZwaEZ4Up+A7gycbCpS/O7XLEOqZHh/nzENT/FkQweGMQnFchOSJD7a
         Bapx+XyQtvjL0t/Bs639WaUQT8WP2q00K/c5gmY2AJIHi3vYbyJ7Fxwhm6J5ZiUbFYfi
         ZCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=GdYra/d0wtC8djGHmTOZ0mlSBTH89OdnWPILMLYrC1E=;
        b=QnhNH50DRt3WXLWiriRVGuCunoXViOM55y5kBe6Q9Ujr/hBZygn6tD2O43iSRqZMrh
         Ln4jGvd6gBrnuSP45ElTDSaw5AsfU4EAdrHsNnegqgW4Yn+xGaocbbpCtgIOoXlnuSi+
         5BZRbksPod7HXnzN798QZTOVKOeSC4ExVgbiSzgPwgex4YE6EOfkAEwgy8i9L7UKFI+I
         QTpgnFjZEiVCtS4XDKjt2F3MNOEEUU6ZJaBDGSiuxuZqvXscwl0ZJjD+z7FN+DmIr0EX
         /awbw6dUTvRyNN0Xv9beWQXHSdu+FdXRxxL2osz2t/l1zqGDMP2bzPjWEukWcA916mjH
         rrEQ==
X-Gm-Message-State: AOAM530GEJWHbR2827zlVRB/nmqQYWQEw45hMKpbEKGS1t/rVrfIyySK
        zI7Tj1CFmIRGMbORvAnWDuU=
X-Google-Smtp-Source: ABdhPJz4tFP8TmSthr4uKBCBx9pgBtnStHvOEKVpm2mnjPk6TFskYTfPD9TNOoaQNXKTt6Pz7oPtug==
X-Received: by 2002:adf:a29c:: with SMTP id s28mr36813104wra.318.1630502872595;
        Wed, 01 Sep 2021 06:27:52 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g76sm5325991wme.16.2021.09.01.06.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 06:27:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 3/7] tests: stop testing `git rebase --preserve-merges`
Date:   Wed, 01 Sep 2021 15:26:38 +0200
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
 <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
 <cdb9fae4b939d4ce81372c0a0d81458eeb9b6299.1630497435.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <cdb9fae4b939d4ce81372c0a0d81458eeb9b6299.1630497435.git.gitgitgadget@gmail.com>
Message-ID: <87wno0v31k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 01 2021, Johannes Schindelin via GitGitGadget wrote:


> diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
> index e78c7e37969..3bb023d7669 100755
> --- a/t/t3427-rebase-subtree.sh
> +++ b/t/t3427-rebase-subtree.sh
> @@ -69,25 +69,6 @@ test_expect_success 'setup' '
>  	git commit -m "Empty commit" --allow-empty
>  '

The comment at the start should be changed too, e.g. something like this
to squash in:

diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index e78c7e37969..74e67b817f6 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -36,11 +36,8 @@ commit_message() {
 # where the root commit adds three files: topic_1.t, topic_2.t and topic_3.t.
 #
 # This commit history is then rebased onto `topic_3` with the
-# `-Xsubtree=files_subtree` option in three different ways:
-#
-# 1. using `--preserve-merges`
-# 2. using `--preserve-merges` and --keep-empty
-# 3. without specifying a rebase backend
+# `-Xsubtree=files_subtree` option, both with and without
+# specifying a rebase backend
 
 test_expect_success 'setup' '
        test_commit README &&
