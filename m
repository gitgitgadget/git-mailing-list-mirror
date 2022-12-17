Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F99C4167B
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 13:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiLQNaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 08:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiLQNaP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 08:30:15 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5E0CE27
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 05:30:14 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id m29so7281967lfo.11
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 05:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tg7Sc6A7HRHCGAHZaDm1ezvbQt7uXm61tcUxVCYI1k=;
        b=kQYd3ICk+ArqAD0dFNxqapenJfgnssK5xuV6ohEFX+R5S7WkEg+NGpdhV01WqFRlUh
         U6CgbdMyZEoruVksS6OOIQ1303gUYreVPGqrgGHyWdf6OIh7iMKx3qMviCkEakfp7hCa
         9C5I3pC+C0RTdDODUsoqEMPR6X5hr8u+l0Js8hKmHMGTa4obHnRAafQpxIcCo9j1Dy+9
         X+zV9rUbfF1LuRiBJFcmWBITtDo+VQV8GN5J0x4Vqfoct/uZ8NFzLDFSgxPcwllKsrsX
         UglxyoxnPRXWDGHfx/dYSL+b57Xhwxa3BTp261Wf4wNz76qwPRtl3AIqhkB58yyRm+fd
         rdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tg7Sc6A7HRHCGAHZaDm1ezvbQt7uXm61tcUxVCYI1k=;
        b=rplCEkxoxlSt2tNBqO1RnFpL1yDlxSXcNtr0ZVb57Z+Y3lXmUH2wnD7Cc+7L0DuG4w
         +DXq7/mBW5LQD2evmbeq6wQUp5fPvcrFr2NqEn6KC74+OYFp8uzMY0rxzai0ibPGL1+T
         ZkMHXyKND2GrIVWWw71eSFP5oU1kkGNRZfK2mmxzkAdq5eHuzoXmmKATzKTHXcqDoUS9
         RULv9ZynUEFpz9mHnttvTPJE5BipEDsHMDY7biJ/TwjJIeTYiRo60LaGsxJ4EjiJ+M/8
         t20hVrTsA3+7+Nwzzj+Wfp6HMujeOhGCH+3LnuqdfpvgN6sB23XQYto9e/XJJJT6h7LJ
         mFSw==
X-Gm-Message-State: ANoB5pkteiL+XBOajgCQO7OPuoJEKyOMrh2lthaClE9WiFsKr2mBsGGV
        uPQz4zbJNizb74Dpl3v8zmE=
X-Google-Smtp-Source: AA0mqf6d9u3IG1yTjVMShj2o4RUjKLboQifs28DkleBGDc+rlZeqecl1j3VmXBUrBAxK3WS6cuxiLw==
X-Received: by 2002:ac2:5310:0:b0:4b5:b46d:e52 with SMTP id c16-20020ac25310000000b004b5b46d0e52mr8047263lfh.50.1671283812555;
        Sat, 17 Dec 2022 05:30:12 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q6-20020a056512210600b004a100c21eaesm512420lfr.97.2022.12.17.05.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 05:30:12 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 3/5] diff-merges: support list of values for --diff-merges
Date:   Sat, 17 Dec 2022 16:29:53 +0300
Message-Id: <20221217132955.108542-4-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221217132955.108542-1-sorganov@gmail.com>
References: <kl6lilimepli.fsf@chooglen-macbookpro.roam.corp.google.com>
 <20221217132955.108542-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Support comma-separated list of options in --diff-merges=. This allows
for shorter:

  --diff-merges=on,hide

instead of:

  --diff-merges=on --diff-merges=hide

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/diff-options.txt |  5 +++--
 diff-merges.c                  | 22 ++++++++++++++++++----
 t/t4013-diff-various.sh        |  8 ++++++++
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index fe15693492a2..977f9135b0d6 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -38,7 +38,8 @@ ifdef::git-log[]
 --no-diff-merges::
 	Specify diff format to be used for merge commits. Default is
 	{diff-merges-default} unless `--first-parent` is in use, in which case
-	`first-parent` is the default.
+	`first-parent` is the default. Comma-separated list of
+	supported values is accepted as well.
 +
 --diff-merges=(off|none):::
 --no-diff-merges:::
@@ -53,7 +54,7 @@ ifdef::git-log[]
 	`log.diffMerges` configuration parameter, which default value
 	is `separate`.
 +
-	`-m` is a shortcut for '--diff-merges=on --diff-merges=hide'.
+	`-m` is a shortcut for '--diff-merges=on,hide'.
 	In addition it implies `-p` when `log.diffMerges-m-imply-p` is
 	active.
 +
diff --git a/diff-merges.c b/diff-merges.c
index 1fbf476d378e..bb2797ff8cc5 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -1,6 +1,7 @@
 #include "diff-merges.h"
 
 #include "revision.h"
+#include "strbuf.h"
 
 typedef void (*diff_merges_setup_func_t)(struct rev_info *);
 static void set_separate(struct rev_info *revs);
@@ -109,12 +110,25 @@ static diff_merges_setup_func_t func_by_opt(const char *optarg)
 
 static void set_diff_merges(struct rev_info *revs, const char *optarg)
 {
-	diff_merges_setup_func_t func = func_by_opt(optarg);
+	char const delim = ',';
+	struct strbuf **opts = strbuf_split_str(optarg, delim, -1);
+	struct strbuf **p;
 
-	if (!func)
-		die(_("invalid value for '%s': '%s'"), "--diff-merges", optarg);
+	for (p = opts; *p; p++) {
+		diff_merges_setup_func_t func;
+		char *opt = (*p)->buf;
+		int len = (*p)->len;
 
-	func(revs);
+		if (opt[len - 1] == delim)
+			opt[len - 1] = '\0';
+		func = func_by_opt(opt);
+		if (!func) {
+			strbuf_list_free(opts);
+			die(_("invalid value for '%s': '%s'"), "--diff-merges", opt);
+		}
+		func(revs);
+	}
+	strbuf_list_free(opts);
 }
 
 /*
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 1789dd6063c5..a07513e67fd6 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -485,6 +485,14 @@ test_expect_success 'log --diff-merges=on matches --diff-merges=separate' '
 	test_cmp expected actual
 '
 
+test_expect_success 'log --diff-merges=<V1>,<V2>' '
+	git log --diff-merges=1,hide master >result &&
+	process_diffs result >expected &&
+	git log --diff-merges=1 --diff-merges=hide master >result &&
+	process_diffs result >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'deny wrong log.diffMerges config' '
 	test_config log.diffMerges wrong-value &&
 	test_expect_code 128 git log
-- 
2.25.1

