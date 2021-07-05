Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6845C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D6E5613AA
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhGEMfK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhGEMfI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:08 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90587C061760
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:31 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id t3so20599542oic.5
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cI4CQbjfeh+xCuoXPHJxuDfMmH/tcw6xDyctCs528Qk=;
        b=Z0Fs5yXyUNJ5/CKbIK3v7HlmBaJxdp+vL1HVMMf0CyzsfT3Aq13efg7o138Ufr21xx
         8SSgqkmABsGTgXnzRQX589pcMCCYl/RHQkcgtoDu+iU6AU+O2YrdCJcNbq8lDd7p6hGx
         tKWPQA8fNt7UW0UA71FCQjcCwuVehUF0tf0SBALlXCX7U5S4XL8+qIX+DLcMxJzXCeyv
         QzZ1Gw1iUUCaSwjdxMuE8JlBoe7hhN+ibmivTW4Tl13m2+S2o8TtXZzNb6G9jXoQv3AP
         7PIEky5Rdi1HXXDbiE2VQMpib3qazwVSUo97EeqUlpF8hk1ExY2XNr50bcbO9xQ4hFso
         TfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cI4CQbjfeh+xCuoXPHJxuDfMmH/tcw6xDyctCs528Qk=;
        b=pvvVo6ytMPIZQnpAQzYHP/sIGPzb6UFVtTpYpHTK1w32EV3E8PSBD6b8rqXG3r4chw
         SoFlBVadSinA96cqbPVhu7x8ykH2aIGzTkzveS8k5ZWvp/f4h5MgVzrrcVCrcNcRm5r+
         aQ20KJ9eWefP66srQaItCPhBvgZtrS1Py+TZ8FIkk2JnecnRQHpxGEc6Ih+98gy4347F
         DmY7QfiOh1JvI6YOJvYMMYCwvwJltdQtQLf2MaWnhN6pJIFOSkvsfEVPlwcV2G+tG5FS
         9aBQAoqU5xt0gpo6NEx/GldKoZ6eI0OoFhW2zXuzGzd3rVst54v5d/29xpN5VFWJrkVM
         UQqg==
X-Gm-Message-State: AOAM533Ld4fUiFAYi6940V6vltlsqQ/OX0W148dzyjAqU82dq68egLN8
        2T9VVOW2hMzSY/eMIeZbwwfsa8GsvMzDcg==
X-Google-Smtp-Source: ABdhPJyb2C6KQyMLJZ5AvbjPInTsTTkPdJ+hs/D5rr3OOQ+uSNL/NTR0G5Kl7QqRg+4/yHv8vi5RJg==
X-Received: by 2002:a05:6808:113:: with SMTP id b19mr9715412oie.48.1625488350412;
        Mon, 05 Jul 2021 05:32:30 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id 59sm2600441oto.3.2021.07.05.05.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:29 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 11/35] update: add --merge mode
Date:   Mon,  5 Jul 2021 07:31:45 -0500
Message-Id: <20210705123209.1808663-12-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-update.txt |  4 ++++
 builtin/update.c             | 20 +++++++++++++++++++-
 t/t5563-update.sh            | 15 +++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-update.txt b/Documentation/git-update.txt
index df778b7ef4..075653c6fd 100644
--- a/Documentation/git-update.txt
+++ b/Documentation/git-update.txt
@@ -29,6 +29,10 @@ OPTIONS
 --ff::
 	Forces a fast-forward.
 
+-m::
+--merge::
+	Forces a merge.
+
 SEE ALSO
 --------
 linkgit:git-fetch[1], linkgit:git-fast-forward[1],
diff --git a/builtin/update.c b/builtin/update.c
index 34681fe21a..5946b383f5 100644
--- a/builtin/update.c
+++ b/builtin/update.c
@@ -8,7 +8,8 @@
 #include "dir.h"
 
 enum update_mode_type {
-	UPDATE_MODE_FAST_FORWARD = 0
+	UPDATE_MODE_FAST_FORWARD = 0,
+	UPDATE_MODE_MERGE
 };
 
 static enum update_mode_type mode = UPDATE_MODE_FAST_FORWARD;
@@ -22,6 +23,9 @@ static struct option update_options[] = {
 	OPT_SET_INT_F('f', "ff", &mode,
 		N_("incorporate changes by fast-forwarding"),
 		UPDATE_MODE_FAST_FORWARD, PARSE_OPT_NONEG),
+	OPT_SET_INT_F('m', "merge", &mode,
+		N_("incorporate changes by merging"),
+		UPDATE_MODE_MERGE, PARSE_OPT_NONEG),
 
 	OPT_END()
 };
@@ -50,6 +54,18 @@ static int run_fast_forward(void)
 	return ret;
 }
 
+static int run_merge(void)
+{
+	int ret;
+	struct strvec args = STRVEC_INIT;
+
+	strvec_pushl(&args, "merge", "FETCH_HEAD", NULL);
+
+	ret = run_command_v_opt(args.v, RUN_GIT_CMD);
+	strvec_clear(&args);
+	return ret;
+}
+
 int cmd_update(int argc, const char **argv, const char *prefix)
 {
 	if (!getenv("GIT_REFLOG_ACTION"))
@@ -68,6 +84,8 @@ int cmd_update(int argc, const char **argv, const char *prefix)
 
 	if (mode == UPDATE_MODE_FAST_FORWARD)
 		return run_fast_forward();
+	if (mode == UPDATE_MODE_MERGE)
+		return run_merge();
 
 	return 1;
 }
diff --git a/t/t5563-update.sh b/t/t5563-update.sh
index 951df41ac4..833a5285da 100755
--- a/t/t5563-update.sh
+++ b/t/t5563-update.sh
@@ -42,4 +42,19 @@ test_expect_success 'non-fast-forward update' '
 	)
 '
 
+test_expect_success 'git update non-fast-forward with merge' '
+	test_when_finished "rm -rf test" &&
+	(
+	git clone . test &&
+	cd test &&
+	git checkout -b other master^ &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	git update --merge
+	)
+'
+
 test_done
-- 
2.32.0.36.g70aac2b1aa

