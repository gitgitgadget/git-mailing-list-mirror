Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2097DC433E0
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 19:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EABD020663
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 19:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ayo2mv/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgGMTU6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGMTU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 15:20:57 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611C3C061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 12:20:57 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q15so908290wmj.2
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 12:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=WTruq5ihxxoGfnbdS87doeyErIA4mWIYbNzVbVMnqF4=;
        b=Ayo2mv/uQy1GYsV10c0uWunB9iIuAxRnwalkmu/0Ejj6ebm8v6w7JvivqnTv0ZeZYb
         ONOci39/BefpjAvWJ9aIHE/IotfKcid2+7gX4p/7oT8YLuEBkR/xZrDGOS9ALK03J2YJ
         GMacPO85XMSj4+p5kb1ng7UvmBqgzdwbSh6/NJculumtQU1Hv7cGgPMSWdUgydHTNTN6
         C6CKq5d43/G99PJDusKY5nwvs2VsMEnvZi3YCdYs26tTxuMxKWiCvnNrX5JhnXTrK6Wc
         1nScFtWeamQNbWa0wlnm4D0zmyynsvJ/P6ZwuLHSBx9ZAP9aXUcBjINuM8MAUIRJcnyU
         86sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WTruq5ihxxoGfnbdS87doeyErIA4mWIYbNzVbVMnqF4=;
        b=fz1KITtVgZu8boAmFWSvxnLbnOlLrnLflL9uMZRJMjqAkRUdpghhrrfQhjRF7LxaIs
         bwEcH+UAsc2JMTr+4sRcy4vU+oB8Zdhz11kVEkVaiweLP40x9ifBopokz0xYsXn0b+42
         GesdhQFh2d86vZv9/cLvPsCbr9Yzr4BED8FMyGKooHh0kFsb32RljDIB4BFa1CJcqtml
         r//K5uv3ln6+++GbFs4HFRN2JSY/mSp8XLw17lZQ+dQr5DOH0DJmttftBM09EXME0fQb
         9JCKb7nX/64xWLE0VdJQxuCX73558Ty6Xj9fd2225rPgYytnztl9zBxZudZNGuHv82iV
         LObQ==
X-Gm-Message-State: AOAM532Bnd2gzWGebGa5nqNaxzT7jI1N0RXiSso21k3Q/c1nAxSDS5KK
        HsSY9eu8oEjrtZnM0wliGI/OeSM7
X-Google-Smtp-Source: ABdhPJzIhTtxL7HaHvqDz/Upg6Uk+lp+/uutnIOrL0cCXV2MIjAdGHs+uvSwFrWEnBjMOYLfEahAvg==
X-Received: by 2002:a1c:6384:: with SMTP id x126mr922709wmb.144.1594668052886;
        Mon, 13 Jul 2020 12:20:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c20sm31467615wrb.65.2020.07.13.12.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 12:20:52 -0700 (PDT)
Message-Id: <pull.674.git.1594668051847.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Jul 2020 19:20:51 +0000
Subject: [PATCH] setup: warn if extensions exist on old format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, delphij@google.com, peff@peff.net,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Prior to 14c7fa269e4 (check_repository_format_gently(): refuse extensions
for old repositories, 2020-06-05), Git was honoring configured
extensions, even if core.repositoryFormatVersion was 0 (or unset). This
was incorrect, and is now fixed.

The issue now is that users who relied on that previously bad behavior
will upgrade to the next version of Git and suddently be in a bad
situation. In particular, users of the 'git sparse-checkout' builting
will rely on the extensions.worktreeConfig for the core.sparseCheckout
and core.sparseCheckoutCone config options. Without that extension,
these users will suddenly have repositories stop acting like a sparse
repo.

What is worse is that a user will be confronted with the following
error if they try to run 'git sparse-checkout init' again:

	warning: unable to upgrade repository format from 0 to 1

This is because the logic in 14c7fa269e4 refuses to upgrae repos when
the version is unset but extensions exist.

While it is important to correct this improper behavior, create a
warning so users in this situation can correct themselves without too
much guesswork. By creating a warning in
check_repository_format_gently(), we can alert the user if they have a
ocnfigured extension but not a configured repository version.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    setup: warn if extensions exist on old format
    
    This is based on xl/upgrade-repo-format.
    
    Can this be considered for v2.28.0-rc1? I think this is an important
    shift in behavior that will disrupt many users if they upgrade without
    it!
    
    If not this warning or change, then how else can we help users who are
    in this situation? How can we save those who adopted the sparse-checkout
    builtin in recent versions from terrible post-upgrade headaches?
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-674%2Fderrickstolee%2Fsparse-checkout-warning-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-674/derrickstolee/sparse-checkout-warning-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/674

 setup.c                            | 5 +++++
 t/t1091-sparse-checkout-builtin.sh | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/setup.c b/setup.c
index eb066db6d8..6ff6c54d39 100644
--- a/setup.c
+++ b/setup.c
@@ -542,6 +542,11 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 		}
 	}
 
+	if (candidate->version == 0 && candidate->has_extensions) {
+		warning(_("some extensions are enabled, but core.repositoryFormatVersion=0"));
+		warning(_("if you intended to use extensions, run 'git config core.repositoryFormatVersion 1'"));
+	}
+
 	return 0;
 }
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 88cdde255c..d249428f44 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -68,6 +68,15 @@ test_expect_success 'git sparse-checkout init' '
 	check_files repo a
 '
 
+test_expect_success 'warning about core.repositoryFormatVersion' '
+	test_when_finished git -C repo config core.repositoryFormatVersion 1 &&
+	git -C repo status 2>err &&
+	test_must_be_empty err &&
+	git -C repo config --local core.repositoryFormatVersion 0 &&
+	git -C repo status 2>err &&
+	test_i18ngrep "some extensions are enabled, but core.repositoryFormatVersion=0" err
+'
+
 test_expect_success 'git sparse-checkout list after init' '
 	git -C repo sparse-checkout list >actual &&
 	cat >expect <<-\EOF &&

base-commit: 14c7fa269e42df4133edd9ae7763b678ed6594cd
-- 
gitgitgadget
