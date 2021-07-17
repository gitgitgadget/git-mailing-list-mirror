Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FF3C636CE
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 15:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09E816115C
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 15:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbhGQPo5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 11:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbhGQPoz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 11:44:55 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2679BC0613DD
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 08:41:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v5so15655056wrt.3
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 08:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0pmhaTGW/c37alOWpa7m/pGWqT9mj8SFk5KGs1Vt7Ew=;
        b=m10jUUy4Hb9Q1otSIRuwkQF2jpps/ejlrkBW0/HES/4daxYbk74xvPZO7AebB5x3KI
         4MEgzIy2gcdDi6BLeUQCEtomgwWpCAO1XmZkSJktNUcJKQTepz7TGz4h2sBS7lGQzcSP
         5d1GbONUglIGGJ21icHvqm2JeYdqSP3hoppyMt00W2TRKfEqNezTvmL5fmZNA0fHJ7g2
         QwKu5lMWDe6A/i70SHpVMFDoqBk/FK1EW+Fzo+V7niaiHpPjenJRtaMygGsEOi5LuyCZ
         VVuH8SvAFGk8XOM62DccsKZXNHFttW5OWPvjcMTj8kAk/8XF9vwvtJZzi/H87eQ5O+4Q
         wO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0pmhaTGW/c37alOWpa7m/pGWqT9mj8SFk5KGs1Vt7Ew=;
        b=QOW3JsIObVa/zKV1xoIC1ZfXfVCn/6EDiWyCQlP1OB/iwUzOHS47Q6YWFeL9CsxQsu
         JOjZdTHC4NdNIc3WB+4uhS8jY9pJ08t/lz1VENq6i46Zpv4uD+ZKWMfJNA/OkAIcWn65
         W/6938AQv8PUcAwoYhsHTT9SkkgcokO9L+cQlA9dlYrTKoWHZQT0wAG9pYQAdLOO4D2/
         zMQNakUbjxuM1vL8eg3xSjzjRsX3z+Mb02/QvC/wYXrjP8JYav3HRrwqtbzBsKEOaAOm
         TXsrW41Ozuks8zV/UGz1h5urMCxQ+eW2XN6401U9BTkijJUT+I/fwWpfA+O1yhjAIbI8
         eUxA==
X-Gm-Message-State: AOAM532/nKVTD0NZloVlALphCm3aMqqWVLiGH1F5jX99UMUzeOBneNvM
        IcY1bs8nnGHRUNAAzoXzqIogmjCvzxA=
X-Google-Smtp-Source: ABdhPJzn3fx9UK6cavtykUND6KnPZsWw1quliWaI7GgplbnhrpU+jDZBeigMKpgJf4/xefTIow67rw==
X-Received: by 2002:a5d:400c:: with SMTP id n12mr19420064wrp.257.1626536514732;
        Sat, 17 Jul 2021 08:41:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o19sm14247241wmc.12.2021.07.17.08.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 08:41:54 -0700 (PDT)
Message-Id: <d1952f014f20d2770c74a311df27f956c8b95e21.1626536508.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Jul 2021 15:41:46 +0000
Subject: [PATCH 8/9] pull: update docs & code for option compatibility with
 rebasing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

git-pull.txt includes merge-options.txt, which is written assuming
merges will happen.  git-pull has allowed rebases for many years; update
the documentation to reflect that.

While at it, pass any `--signoff` flag through to the rebase backend too
so that we don't have to document it as merge-specific.  Rebase has
supported the --signoff flag for years now as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-pull.txt      |  2 ++
 Documentation/merge-options.txt | 25 +++++++++++++++++++++++++
 builtin/pull.c                  |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index cad3f6bfcee..6e6e95a7595 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -125,6 +125,8 @@ When false, merge the current branch into the upstream branch.
 +
 When `interactive`, enable the interactive mode of rebase.
 +
+Note that `--ff-only` takes precedence over any `--rebase` flag.
++
 See `pull.rebase`, `branch.<name>.rebase` and `branch.autoSetupRebase` in
 linkgit:git-config[1] if you want to make `git pull` always use
 `--rebase` instead of merging.
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index eb0aabd396f..3b70abf3c87 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -2,6 +2,9 @@
 --no-commit::
 	Perform the merge and commit the result. This option can
 	be used to override --no-commit.
+ifdef::git-pull[]
+	Only useful when merging.
+endif::git-pull[]
 +
 With --no-commit perform the merge and stop just before creating
 a merge commit, to give the user a chance to inspect and further
@@ -58,6 +61,10 @@ could instead be resolved as a fast-forward.
 +
 With `--ff-only`, resolve the merge as a fast-forward when possible.
 When not possible, refuse to merge and exit with a non-zero status.
+ifdef::git-pull[]
++
+Note that `--no-ff` and `--ff` are ignored when rebasing is requested.
+endif::git-pull[]
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
@@ -73,6 +80,9 @@ When not possible, refuse to merge and exit with a non-zero status.
 	In addition to branch names, populate the log message with
 	one-line descriptions from at most <n> actual commits that are being
 	merged. See also linkgit:git-fmt-merge-msg[1].
+ifdef::git-pull[]
+	Only useful when merging.
+endif::git-pull[]
 +
 With --no-log do not list one-line descriptions from the
 actual commits being merged.
@@ -102,10 +112,17 @@ With --no-squash perform the merge and commit the result. This
 option can be used to override --squash.
 +
 With --squash, --commit is not allowed, and will fail.
+ifdef::git-pull[]
++
+Only useful when merging.
+endif::git-pull[]
 
 --no-verify::
 	This option bypasses the pre-merge and commit-msg hooks.
 	See also linkgit:githooks[5].
+ifdef::git-pull[]
+	Only useful when merging.
+endif::git-pull[]
 
 -s <strategy>::
 --strategy=<strategy>::
@@ -127,6 +144,10 @@ With --squash, --commit is not allowed, and will fail.
 	default trust model, this means the signing key has been signed by
 	a trusted key.  If the tip commit of the side branch is not signed
 	with a valid key, the merge is aborted.
+ifdef::git-pull[]
++
+Only useful when merging.
+endif::git-pull[]
 
 --summary::
 --no-summary::
@@ -166,3 +187,7 @@ endif::git-pull[]
 	projects that started their lives independently. As that is
 	a very rare occasion, no configuration variable to enable
 	this by default exists and will not be added.
+ifdef::git-pull[]
++
+Only useful when merging.
+endif::git-pull[]
diff --git a/builtin/pull.c b/builtin/pull.c
index 2d7f2d765ab..3a61b92f328 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -893,6 +893,8 @@ static int run_rebase(const struct object_id *newbase,
 	strvec_pushv(&args, opt_strategy_opts.v);
 	if (opt_gpg_sign)
 		strvec_push(&args, opt_gpg_sign);
+	if (opt_signoff)
+		strvec_push(&args, opt_signoff);
 	if (opt_autostash == 0)
 		strvec_push(&args, "--no-autostash");
 	else if (opt_autostash == 1)
-- 
gitgitgadget

