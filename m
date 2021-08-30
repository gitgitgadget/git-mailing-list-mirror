Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E2FC4320E
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 14:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0F160E73
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 14:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbhH3Otr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 10:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbhH3Otp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 10:49:45 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F417CC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 07:48:51 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q14so22854014wrp.3
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 07:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9wEFCiyqZ+7d0TJ/o6WMRvjIVsMZmjxTyc3Mwm3+qus=;
        b=eTjck3vqdJjPsuAn3lxJ9rIwVVwrdTD490/zUKtsrPIwi14wSRltuJJsikUBSXR9iL
         JSGOS9y8yx5cWtjeN3qbxhgJl9kmmYfInncT1Lr01p0ZREFaGcZBWiPl5DfxmNVe2551
         1kVxEJz/dnaIrBedoRrKv/hICXBSUcSLRbh5oEzG4Y2e8ZnTy0mYIEz8LvfalWmfl5Iu
         9DkqkCgKU1/ICgCDngNTLID6/Wx/sRzbHCt1k9H3YgM6GsLvCPWrO+KtVkcdQ2iKBYsq
         DkmPC23jospPp8Ow7JWfPznrx+cPJylYcKxF9aQUeXrtelGReKrVsw58U7TvYdyd6LVw
         /pSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9wEFCiyqZ+7d0TJ/o6WMRvjIVsMZmjxTyc3Mwm3+qus=;
        b=IzzlyILBkZvAXW4CS8Urv1elapYJIJBvX8D4mynzQ1BrCb73EjZ6JF0M9U8tUm7K9t
         +gQ3WHViGr9bu8XDDLm7CWwmL0fUXyfTEfR2e93S1PuBcaYuEKX9ozrZTA5HC7bTTaLR
         oWSNanPqAiA9gXan4DvMXsyjpmAJgGO4EFJ3b5CvFO+alxmFtyrR7YXeehq0zYrMBWy+
         TBKynDYMoEaqfiU47hkC8gzjLBTiKiSYahA0VlhojXcMiLdAtH+0R96Az5WxRPk5QAtq
         8mjn7axigArqMgBZ7E27KyxCXMjf1sBjDeyE9OTHgtWe+bS1vLIRtuOOr4r0ydsc3BKZ
         B+9w==
X-Gm-Message-State: AOAM530xiuQ1J0nZVyYcf6icpA30KR92EwKv+JRrYBU/9Z0fgrUw78iV
        CChYBE+h7mI+WUYFAGg28dZ1bxOGdTQ=
X-Google-Smtp-Source: ABdhPJw42VEPjB4QOtTbCTsjqRtCB13sqFDv8IUiZBgITt13hlU7yamS1+NWoqh3eB9t2VCXj4u9Jw==
X-Received: by 2002:a05:6000:350:: with SMTP id e16mr5285473wre.197.1630334930593;
        Mon, 30 Aug 2021 07:48:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l187sm14057377wml.39.2021.08.30.07.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 07:48:50 -0700 (PDT)
Message-Id: <d48207d6858502f04fd501a24ff7c2a80062dfbe.1630334929.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
References: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Aug 2021 14:48:45 +0000
Subject: [PATCH 1/4] test-ref-store: tweaks to for-each-reflog-ent format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Follow the reflog format more closely, so it can be used for comparing
reflogs in tests without using inspecting files under .git/logs/

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/helper/test-ref-store.c      | 6 +++---
 t/t1405-main-ref-store.sh      | 5 +++--
 t/t1406-submodule-ref-store.sh | 4 ++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index b314b81a45b..d7bbb20e614 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -151,9 +151,9 @@ static int each_reflog(struct object_id *old_oid, struct object_id *new_oid,
 		       const char *committer, timestamp_t timestamp,
 		       int tz, const char *msg, void *cb_data)
 {
-	printf("%s %s %s %"PRItime" %d %s\n",
-	       oid_to_hex(old_oid), oid_to_hex(new_oid),
-	       committer, timestamp, tz, msg);
+	const char *newline = strchr(msg, '\n') ? "" : "\n";
+	printf("%s %s %s %" PRItime " %+05d\t%s%s", oid_to_hex(old_oid),
+	       oid_to_hex(new_oid), committer, timestamp, tz, msg, newline);
 	return 0;
 }
 
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 49718b7ea7f..16a99382770 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -88,14 +88,15 @@ test_expect_success 'for_each_reflog()' '
 
 test_expect_success 'for_each_reflog_ent()' '
 	$RUN for-each-reflog-ent HEAD >actual &&
+	cat actual &&
 	head -n1 actual | grep one &&
-	tail -n2 actual | head -n1 | grep recreate-main
+	tail -n1 actual | grep recreate-main
 '
 
 test_expect_success 'for_each_reflog_ent_reverse()' '
 	$RUN for-each-reflog-ent-reverse HEAD >actual &&
 	head -n1 actual | grep recreate-main &&
-	tail -n2 actual | head -n1 | grep one
+	tail -n1 actual | grep one
 '
 
 test_expect_success 'reflog_exists(HEAD)' '
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index 0a87058971e..b0365c1fee0 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -74,13 +74,13 @@ test_expect_success 'for_each_reflog()' '
 test_expect_success 'for_each_reflog_ent()' '
 	$RUN for-each-reflog-ent HEAD >actual &&
 	head -n1 actual | grep first &&
-	tail -n2 actual | head -n1 | grep main.to.new
+	tail -n1 actual | grep main.to.new
 '
 
 test_expect_success 'for_each_reflog_ent_reverse()' '
 	$RUN for-each-reflog-ent-reverse HEAD >actual &&
 	head -n1 actual | grep main.to.new &&
-	tail -n2 actual | head -n1 | grep first
+	tail -n1 actual | grep first
 '
 
 test_expect_success 'reflog_exists(HEAD)' '
-- 
gitgitgadget

