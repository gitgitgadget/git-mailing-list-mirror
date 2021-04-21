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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5E2C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 768A16144F
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbhDUKlm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhDUKll (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 06:41:41 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C47FC06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:41:08 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id j7so19970015pgi.3
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uAgvKlDiFMBwraK00hORb5/d2K4tmlBmJvcFeJE2DoE=;
        b=mP6pzffeTGEKpxY3a5p/NwFP8frh5wPyt5Zpi1wKmkpwNu/MhY+juq5s7JQL8DRaoS
         7KUZvPgmqqlNn2C2rAx+A3OI4vgJfJC1JPViUOJ1/AcYV+jxtgisaW3a+mzMvuwiYi5O
         yXH7aHNXw7NXxEaxfB1nUxGUJboi9vtWdtRebRpgAHFc8pV9I0mgOHhxxhDOXxdyzOcL
         pL6/XS58cTgU5IAN7JpLPsw6ZdjvsGjGIyH7+JUeCZx2Kpxf0/32q/ZnehXFMJZrt0Sl
         tImNuegD/vkLtEhoe6wbVlfAfuoyk+AOdxm8BqKRdTZQFuWc/SVT1ZflzXkijSuM5KQm
         +rKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uAgvKlDiFMBwraK00hORb5/d2K4tmlBmJvcFeJE2DoE=;
        b=NFnaeic0ytHuOajk0TL7Rc6P9H34VggGTDI7GMKRX2zi6kZJhOIKlVz5zXubSMbyyo
         y8CVIj/5cZaF/d6Pgnw6u8YoTDjK8tAQl5TTD8lOwMxieL7PpbI3igRJ8XbZgVAF0f+2
         +uEU9/FUK5dwEVdcZbHNKWcztIxT8G236As3qBF3UQhbUu5ILmlBFQvAhZ/qMaG6YCyH
         DxFu5880aANV0Va5TTbQzAmlLAZqv20kr4snICYECP4hUmqsCc5kzlIMJIvwhvdCfrHX
         4BsMO5mIsN3XfuRQlHXfo+XTnUvdAFHs8PqauESCtJvEE73mo66Fc5UfRrW2pYZIhSGM
         LwoQ==
X-Gm-Message-State: AOAM530Gx7uPLieZrKvQ4cTiUpvVMGXafBN7i1cPla3fA/8hni3RkOfN
        TDavUOIEMoxnRQ52dZfaxHiqi/fInvw=
X-Google-Smtp-Source: ABdhPJxGTpkGLqJhdRODoEEZ4XzENrHDRgG84L18JZyKkF2oo+v41qwc4TheT2EAlAL7F8e8D9igAQ==
X-Received: by 2002:a17:90a:7147:: with SMTP id g7mr10094656pjs.225.1619001667696;
        Wed, 21 Apr 2021 03:41:07 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id n20sm1458010pgv.15.2021.04.21.03.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 03:41:07 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 1/2] t6400: check exit status of ls-files
Date:   Wed, 21 Apr 2021 17:41:01 +0700
Message-Id: <20210421104102.3409-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.31.1.192.g0881477623
In-Reply-To: <YIAAzJTG1UitiWyu@danh.dev>
References: <YIAAzJTG1UitiWyu@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We will lose the exit status of "git ls-files" if it's being run in
anywhere-but-not-final part of a pipe.

Let's send the output of "git ls-files" to a file first,
and adjust the expected result for "git ls-files -o" since a new
untracked file will be created as a side effect.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t6400-merge-df.sh | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/t/t6400-merge-df.sh b/t/t6400-merge-df.sh
index 38700d29b5..fd99a78360 100755
--- a/t/t6400-merge-df.sh
+++ b/t/t6400-merge-df.sh
@@ -82,13 +82,16 @@ test_expect_success 'modify/delete + directory/file conflict' '
 	git checkout delete^0 &&
 	test_must_fail git merge modify &&
 
-	test 5 -eq $(git ls-files -s | wc -l) &&
-	test 4 -eq $(git ls-files -u | wc -l) &&
+	git ls-files -s >out &&
+	test_line_count = 5 out &&
+	git ls-files -u >out &&
+	test_line_count = 4 out &&
+	git ls-files -o >out &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 0 -eq $(git ls-files -o | wc -l)
+		test_line_count = 1 out
 	else
-		test 1 -eq $(git ls-files -o | wc -l)
+		test_line_count = 2 out
 	fi &&
 
 	test_path_is_file letters/file &&
@@ -103,13 +106,16 @@ test_expect_success 'modify/delete + directory/file conflict; other way' '
 
 	test_must_fail git merge delete &&
 
-	test 5 -eq $(git ls-files -s | wc -l) &&
-	test 4 -eq $(git ls-files -u | wc -l) &&
+	git ls-files -s >out &&
+	test_line_count = 5 out &&
+	git ls-files -u >out &&
+	test_line_count = 4 out &&
+	git ls-files -o >out &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 0 -eq $(git ls-files -o | wc -l)
+		test_line_count = 1 out
 	else
-		test 1 -eq $(git ls-files -o | wc -l)
+		test_line_count = 2 out
 	fi &&
 
 	test_path_is_file letters/file &&
-- 
2.31.1.192.g0881477623

