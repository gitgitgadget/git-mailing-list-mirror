Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C73C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CA0E64DF0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhBPMCL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 07:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbhBPL7j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 06:59:39 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D568FC061794
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:21 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id 7so12649935wrz.0
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hTC465d5iNclGrU6oP/TfLZe8Tzs98pFq0U4cxtmNk0=;
        b=G8Lsjk68BV3PHieYzGFplyc+BGN4K3GNj/iYY5EcwmU+6KlBTKX6s9aZJz5iad6hy4
         1aBGJzjTovZ09tt9FSQ6wlD3sEIOXhNOj+9TkYqV4gYtekjMNFBBf+uYuAtzt14yMVa+
         ihjbgq3Ma3KCGMQHTO7Bemm7nhOMozpGLsN0D3dmi9GrWn6z3inQp29lhGRGY7+hg4ZP
         L7Lf3e/bGvTPe/bFwg5GIn39FVjIEDJDPkiHn4SVjyMDnNFxf1sEkGo99wEUR28dlLB7
         F+gQdiH36Q0paNMDALMAbSyEb8PuOP3jVQ1hdRX9jkVRkwodmj+7Fy7OhTAnnRkinbH2
         lLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hTC465d5iNclGrU6oP/TfLZe8Tzs98pFq0U4cxtmNk0=;
        b=BT58KVA6TGWYaOQzbAaFybtcpZhhfTDg7Pa322/vT6DGwG5/GSpladFYb1l1hPH5Bu
         FYXP+TmIcWNIpIadRWuoDAni/uZ5G0Udxf19rkevZDxo5UJcwzHLdxnDxT7YQRuA4suK
         RA7r/PtiUpQ5/g3LVZNm0b+m3w/qjKyHJLnkHT8UZivy456dVa2yv75D0sAZJ83Wv3tK
         z8fvs9Ydzn38Bc1NHbSImUHLteZnlZRXhzWWSTeic2burcyb17P82MmmbbC5xERXm3G5
         lEovGH1J1PWVvJIjB2hE8yP4KdyYpUDYBGrPCqkjV7FcBE6pQGi+q8XsSY46G353+lHr
         ctWQ==
X-Gm-Message-State: AOAM533z9fX8Nh+VvWuPk74+v3jCX9adpBakRQ/PZiHCzqFrLjoOxwSk
        Vc4Un57wfSLRyY/yhqos4lIGT4ta2AhRUg==
X-Google-Smtp-Source: ABdhPJwtLAqagEM8QkG1DApL81tC7WpEMAoi1kDblGBPpFXjG3ughIABM1CqH4odzORHLw6X1fkpeQ==
X-Received: by 2002:a05:6000:18f:: with SMTP id p15mr15202563wrx.27.1613476700352;
        Tue, 16 Feb 2021 03:58:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b2sm27968246wrv.73.2021.02.16.03.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 03:58:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/22] pickaxe: die when -G and --pickaxe-regex are combined
Date:   Tue, 16 Feb 2021 12:57:48 +0100
Message-Id: <20210216115801.4773-10-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the -G and --pickaxe-regex options are combined we simply ignore
the --pickaxe-regex option. Let's die instead as suggested by our
documentation, since -G is always a regex.

When --pickaxe-regex was added in d01d8c6782 (Support for pickaxe
matching regular expressions, 2006-03-29) only the -S option
existed. Then when -G was added in f506b8e8b5 (git log/diff: add
-G<regexp> that greps in the patch text, 2010-08-23) neither the
documentation for --pickaxe-regex was updater accordingly, nor was
something like this assertion added.

Since 5bc3f0b567 (diffcore-pickaxe doc: document -S and -G properly,
2013-05-31) we've claimed that --pickaxe-regex should only be used
with -S, but have silently toileted combining it with -G, let's die
instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diff.c                 | 3 +++
 diff.h                 | 2 ++
 t/t4209-log-pickaxe.sh | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/diff.c b/diff.c
index bf2cbf15e77..96da1fe6167 100644
--- a/diff.c
+++ b/diff.c
@@ -4630,6 +4630,9 @@ void diff_setup_done(struct diff_options *options)
 	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
 		die(_("-G, -S and --find-object are mutually exclusive"));
 
+	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_G_REGEX_MASK))
+		die(_("-G and --pickaxe-regex are mutually exclusive, use --pickaxe-regex with -S"));
+
 	/*
 	 * Most of the time we can say "there are changes"
 	 * only by checking if there are changed paths, but
diff --git a/diff.h b/diff.h
index 527fb56d851..668d496d7a5 100644
--- a/diff.h
+++ b/diff.h
@@ -535,6 +535,8 @@ int git_config_rename(const char *var, const char *value);
 #define DIFF_PICKAXE_KINDS_MASK (DIFF_PICKAXE_KIND_S | \
 				 DIFF_PICKAXE_KIND_G | \
 				 DIFF_PICKAXE_KIND_OBJFIND)
+#define DIFF_PICKAXE_KINDS_G_REGEX_MASK (DIFF_PICKAXE_KIND_G | \
+					 DIFF_PICKAXE_REGEX)
 
 #define DIFF_PICKAXE_IGNORE_CASE	32
 
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 5ad4fad964c..46dc5f14b3b 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -59,6 +59,9 @@ test_expect_success 'usage' '
 	test_expect_code 128 git log -Gregex -Sstring 2>err &&
 	test_i18ngrep "mutually exclusive" err &&
 
+	test_expect_code 128 git log -Gregex --pickaxe-regex 2>err &&
+	test_i18ngrep "mutually exclusive" err &&
+
 	test_expect_code 128 git log -Gregex --find-object=HEAD 2>err &&
 	test_i18ngrep "mutually exclusive" err &&
 
-- 
2.30.0.284.gd98b1dd5eaa7

