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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D07C07E9E
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51EBE613AE
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhGEMfS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbhGEMfR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:17 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF887C061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:39 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id x22-20020a9d6d960000b0290474a76f8bd4so16553586otp.5
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/jLPQTiouBn4MiqDgOJYbo1kG+VTEVWMoGGivQV086o=;
        b=UpC3US6elWXvkCE6TyQGZcqE1GjrcLPi8KyRzJAvEMUoQluSzVzxTUhHgMi+5v3Rg2
         iE+28KYnGfS1/5QH8PVi+bQ8p7BNP7lueNAEPk5PFxUuC/WhaTnjJ0kIP7xeGgisv8pQ
         3pQjcGIvXhqYEMd5wjv+ARH8SyrIqFAYf38SRje1VXaXOf9eLYXHLT7SJOPalioNxPjK
         p6s2DNj6HjGT7rLSrX1fehYHqsYSwq7aUA2t+pnLxuUVAFvJS9I6xNMLmSKQ5StXHlWy
         gdkrGOeKfUzew9Bn+yXtOnXb1VIiqXQLXsTS46Un/VXja6Hquk5B8+0PY2IHrS0Nhasw
         SaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/jLPQTiouBn4MiqDgOJYbo1kG+VTEVWMoGGivQV086o=;
        b=rNdM/NkRDisM0cQrH8J836/BIgs0zw4jwmlsG/0tuSg0Mq99FxUjswFo8htNH0RBmt
         m0RfbKzTtAiU3rvzGRO40uxrSoHqxipPFqcbuuOq1k1J8alMBfQ8WdO/9IiF/8aUbUXc
         +cxOtr5NQ9abWftdsoBAQsgCLM7XQqweIwktBUS8ux6rDeOFAqgedxqejhzXUUqTlsSe
         ncplDfGZWTxJFGU3QXXrRd74jh71Ub55gedPbs2iiw+qJd3oQV2u5/nsdBrg8dVOA6YX
         OAo+FXAirogr6eWSkVYh7xrlqN0LzimNaWQioK2nGH9ZAEzhHae57mHS8A+SPn/cydE4
         yXOg==
X-Gm-Message-State: AOAM530M0luDJ7dmYh5f3ZpuoRfvMl5RCE400Jjt38TMWlpCqHRXGK/s
        89p+f4Wsy6iR+XxfD9upqxSQ4L6dMNSrTA==
X-Google-Smtp-Source: ABdhPJwUT8fiHPh44niN+wxaQ315QFBkcIt4AqG1Ha9Npbs0r/LEk5EGIcqTMjGbU65nfAJ5TXF8qw==
X-Received: by 2002:a9d:7dcb:: with SMTP id k11mr10522052otn.107.1625488358976;
        Mon, 05 Jul 2021 05:32:38 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id g1sm2639893otq.22.2021.07.05.05.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:38 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 16/35] update: add --rebase mode
Date:   Mon,  5 Jul 2021 07:31:50 -0500
Message-Id: <20210705123209.1808663-17-felipe.contreras@gmail.com>
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
 t/t5563-update.sh            | 17 +++++++++++++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-update.txt b/Documentation/git-update.txt
index 075653c6fd..0fefda1379 100644
--- a/Documentation/git-update.txt
+++ b/Documentation/git-update.txt
@@ -33,6 +33,10 @@ OPTIONS
 --merge::
 	Forces a merge.
 
+-r::
+--rebase::
+	Forces a rebase.
+
 SEE ALSO
 --------
 linkgit:git-fetch[1], linkgit:git-fast-forward[1],
diff --git a/builtin/update.c b/builtin/update.c
index 94e83532a8..989104421e 100644
--- a/builtin/update.c
+++ b/builtin/update.c
@@ -9,7 +9,8 @@
 
 enum update_mode_type {
 	UPDATE_MODE_FAST_FORWARD = 0,
-	UPDATE_MODE_MERGE
+	UPDATE_MODE_MERGE,
+	UPDATE_MODE_REBASE
 };
 
 static enum update_mode_type mode = UPDATE_MODE_FAST_FORWARD;
@@ -26,6 +27,9 @@ static struct option update_options[] = {
 	OPT_SET_INT_F('m', "merge", &mode,
 		N_("incorporate changes by merging"),
 		UPDATE_MODE_MERGE, PARSE_OPT_NONEG),
+	OPT_SET_INT_F('r', "rebase", &mode,
+		N_("incorporate changes by rebasing"),
+		UPDATE_MODE_REBASE, PARSE_OPT_NONEG),
 
 	OPT_END()
 };
@@ -66,6 +70,18 @@ static int run_merge(void)
 	return ret;
 }
 
+static int run_rebase(void)
+{
+	int ret;
+	struct strvec args = STRVEC_INIT;
+
+	strvec_pushl(&args, "rebase", "FETCH_HEAD", NULL);
+
+	ret = run_command_v_opt(args.v, RUN_GIT_CMD);
+	strvec_clear(&args);
+	return ret;
+}
+
 int cmd_update(int argc, const char **argv, const char *prefix)
 {
 	if (!getenv("GIT_REFLOG_ACTION"))
@@ -86,6 +102,8 @@ int cmd_update(int argc, const char **argv, const char *prefix)
 		return run_fast_forward();
 	if (mode == UPDATE_MODE_MERGE)
 		return run_merge();
+	if (mode == UPDATE_MODE_REBASE)
+		return run_rebase();
 
 	return 1;
 }
diff --git a/t/t5563-update.sh b/t/t5563-update.sh
index aabbf5a965..73e67f9783 100755
--- a/t/t5563-update.sh
+++ b/t/t5563-update.sh
@@ -67,4 +67,21 @@ test_expect_success 'git update non-fast-forward with merge' '
 	)
 '
 
+test_expect_success 'git update non-fast-forward with rebase' '
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
+	git update --rebase &&
+	test_cmp_rev @^ other &&
+	test_must_fail git rev-parse --verify -q @^2
+	)
+'
+
 test_done
-- 
2.32.0.36.g70aac2b1aa

