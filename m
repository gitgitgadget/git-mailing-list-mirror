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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141CEC433DB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 14:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA15B225AB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 14:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388898AbhAKOsg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 09:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbhAKOsc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 09:48:32 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFD4C061786
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 06:47:51 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id v14so91357wml.1
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 06:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xin5AUvfwizQFAHxqwMxy5gnXJjpkdLKs2dtvOk9mtQ=;
        b=c/h79oGvGT5YaeGqxI+PX2hzqzlQcuGKvQXxQO9SKUQGQ4QoSYVzfipHCe+pUIdVkd
         oSigp8uoOMc2Kh7L+ZTHLWrE4m7/SzAgx3G+oJPxqY6yPycPOjj6zCnkhxkg9I4Yzohj
         xjEUg/ghqpinR5c+RWVviZrtdL54XFP1DBNmmbAWs8J2TIRM+22Yu35Oe6ljdvB44k+4
         1llnB62PsKqSBvCowdG5aCesdC66i5hp2WwQbbOZ6xgsQWoBS9QAdDOgiw22cwxX3cHb
         VtZjvimxPOfh16yCELYMkvin0eyF3O+/fUk7wE7XfVwnvJ3FkeYxbCsJeN8ANZfDjwkn
         a1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xin5AUvfwizQFAHxqwMxy5gnXJjpkdLKs2dtvOk9mtQ=;
        b=i83B8VCcbpeM+n28fwkF70nha5xjRdv3cPc4rUEJpMo4RSwRoVoCCqrdgqsSm3u9cs
         13I2FDZfYmKBx7WSRPwozlM4bS9Eog3BmjZcQJ1pnWQ8C8OwTz4j7APqoFt9SDH5QC/A
         JXXpYEabQyJsjYUmDQDrGVHk5SxrOiXaMuzcw2WdBFvjo4/xE17OSJbj6queGb33iIMF
         qqsTZgrapdlmYYSPdvRD14rjqqnMST/8ErHPhFgzHMliGaTFSmzj5wn9JWbfgrHUUqol
         HW28kBKhrL2ULepGklC2GtSmF2mpwVap7vitt7tt+Os38zwttSJ18MaXkM0j8vu2Ew/d
         Kyrw==
X-Gm-Message-State: AOAM532jYP1fIkTFPNuWC5WdOwDTgslK3rR9rBuL4sXe1jpL3y5i584k
        RsLnD/mDfJ41FdCEEXjGybrjCmDmW1t8NQ==
X-Google-Smtp-Source: ABdhPJxASN4iqOv2E5f87LRvQJ1f6BHkh+lHOU6Z7Vv39sG8SDcpzjhrVpu7B7nmjhpT9FyoKhCR/w==
X-Received: by 2002:a05:600c:224b:: with SMTP id a11mr40561wmm.97.1610376469329;
        Mon, 11 Jan 2021 06:47:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m5sm26132697wrz.18.2021.01.11.06.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 06:47:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/6] tests: remove misc use of test_i18n{cmp,grep}
Date:   Mon, 11 Jan 2021 15:47:37 +0100
Message-Id: <20210111144740.6092-4-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <87pn2b6eyb.fsf@evledraar.gmail.com>
References: <87pn2b6eyb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove miscellaneous use of test_i18n{cmp,grep} from contrib/*,
lib-*.sh and t/*/*.sh etc. noted in an earlier commit we're removing
the GIT_TEST_GETTEXT_POISON=true facility.

This leaves the only users of these functions in t/t[0-9]*.sh tests,
which makes it easier to do a follow-up for-loop search-replacement of
those occurrences at a later date.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh | 2 +-
 t/lib-credential.sh                                  | 2 +-
 t/lib-httpd.sh                                       | 2 +-
 t/lib-log-graph.sh                                   | 4 ++--
 t/lib-submodule-update.sh                            | 2 +-
 t/t5411/test-0026-push-options.sh                    | 3 +--
 t/t5411/test-0027-push-options--porcelain.sh         | 3 +--
 7 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh b/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
index 6187ec67fa..3278334b9b 100755
--- a/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
+++ b/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
@@ -161,7 +161,7 @@ test_expect_success 'git push properly warns about insufficient permissions' '
 		git add foo.forbidden &&
 		git commit -m "add a file" &&
 		git push 2>actual &&
-		test_i18ngrep "foo.forbidden is not a permitted file" actual
+		grep "foo.forbidden is not a permitted file" actual
 	)
 '
 
diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index dea2cbef51..5ea8bc9f1d 100644
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -20,7 +20,7 @@ check() {
 		false
 	fi &&
 	test_cmp expect-stdout stdout &&
-	test_i18ncmp expect-stderr stderr
+	test_cmp expect-stderr stderr
 }
 
 read_chunk() {
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index d2edfa4c50..a3ae0616e6 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -219,7 +219,7 @@ test_http_push_nonff () {
 	'
 
 	test_expect_success 'non-fast-forward push shows help message' '
-		test_i18ngrep "Updates were rejected because" output
+		grep "Updates were rejected because" output
 	'
 
 	test_expect_${EXPECT_CAS_RESULT} 'force with lease aka cas' '
diff --git a/t/lib-log-graph.sh b/t/lib-log-graph.sh
index 1184cceef2..bf952ef920 100644
--- a/t/lib-log-graph.sh
+++ b/t/lib-log-graph.sh
@@ -12,13 +12,13 @@ sanitize_log_output () {
 lib_test_cmp_graph () {
 	git log --graph "$@" >output &&
 	sed 's/ *$//' >output.sanitized <output &&
-	test_i18ncmp expect output.sanitized
+	test_cmp expect output.sanitized
 }
 
 lib_test_cmp_short_graph () {
 	git log --graph --pretty=short "$@" >output &&
 	sanitize_log_output >output.sanitized <output &&
-	test_i18ncmp expect output.sanitized
+	test_cmp expect output.sanitized
 }
 
 lib_test_cmp_colored_graph () {
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index bd3fa3c6da..e04b5c4ba3 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -830,7 +830,7 @@ test_submodule_recursing_with_args_common () {
 			cd submodule_update &&
 			git branch -t invalid_sub1 origin/invalid_sub1 &&
 			test_must_fail $command invalid_sub1 2>err &&
-			test_i18ngrep sub1 err &&
+			grep sub1 err &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
 		)
diff --git a/t/t5411/test-0026-push-options.sh b/t/t5411/test-0026-push-options.sh
index e88edb16a4..a03f9ac5c4 100644
--- a/t/t5411/test-0026-push-options.sh
+++ b/t/t5411/test-0026-push-options.sh
@@ -18,8 +18,7 @@ test_expect_success "proc-receive: not support push options ($PROTOCOL)" '
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	test_i18ngrep "fatal: the receiving end does not support push options" \
-		actual &&
+	grep "fatal: the receiving end does not support push options" actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
diff --git a/t/t5411/test-0027-push-options--porcelain.sh b/t/t5411/test-0027-push-options--porcelain.sh
index 3a6561b5ea..e734247d69 100644
--- a/t/t5411/test-0027-push-options--porcelain.sh
+++ b/t/t5411/test-0027-push-options--porcelain.sh
@@ -19,8 +19,7 @@ test_expect_success "proc-receive: not support push options ($PROTOCOL/porcelain
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
 	make_user_friendly_and_stable_output <out >actual &&
-	test_i18ngrep "fatal: the receiving end does not support push options" \
-		actual &&
+	grep "fatal: the receiving end does not support push options" actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-- 
2.29.2.222.g5d2a92d10f8

