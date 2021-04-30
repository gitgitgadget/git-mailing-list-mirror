Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC394C43460
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 21:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6B8361476
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 21:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhD3Vlu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 17:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbhD3Vlq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 17:41:46 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A156FC06138F
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 14:40:55 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id t17so43798835qkg.4
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 14:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2EnM5QDr7FoNgrYUhohEVPq46wiDviob4V3QvwYbMTk=;
        b=KPTdmqNmpV1cMQFVkJsC4s/zByarIo2d/qeYCZB2OO0iJ5Ii7O+jcoLRwFW70Dzq4j
         3FJ+Evm0vJ/UeaN5li5nxYqfrkN+WGbYj/t95BmXmsRKoOEkyYQ5V8sphKkZ5e+B8V3d
         qG6vKBzJVf4ApFgNLbhBCBtbA/XiiIS+bgrk8rtVr4QgV5H4DG7bOPl0rq/XfzopqRX5
         F9cYYlA1IuEyag351Qr7hoc1hXmvRNOh2xbpB1BFftZ4qYLXWQ1eDwDz8qNxfZJthxOm
         vSJ7pdRzmVSHUxOKY/dHzVB9ktnuZG+Gt4IuMsQjU8qBR4McwelLaJj1sKbQKE/pkPZS
         7Y7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2EnM5QDr7FoNgrYUhohEVPq46wiDviob4V3QvwYbMTk=;
        b=DKQOS9wh8NQ1rG1I4vpxiw2NNdzKdNWI2U6mj8ZR8xQenuUMq9oNObPAiaq0YVq1bM
         4dTdsLf3n/VXo2ut7CvP8jA1RiIqu92gVH8SEMwpY8h6MMkTM1ChA471GbdV/fLmAUNW
         rPmxWAwy6xOiDiOobD92J7f37J30eIe2KbMTACB2kSr6Ujv3ca16R2x7bCPTbvbDgt/5
         22FPVMbtuoS6YqXHBEPkhOO404IunYA5d0KLOI0wKdVe7U7jykbS4Dww2E4Ik7Mfryf0
         3nI8hC+Ub33vX3iD2Grfd5FORyBdc7rFVAlQFjyrNG03t5OFfS3/QtOGBaJ9fH94IdD4
         Uk6Q==
X-Gm-Message-State: AOAM533Pbw2DH9Di03rPdhxIY1KOVOnRwLlzy6iULErrrr5rArPiGT0T
        tSiz7s6rE85cM0FP9KWwzLRC5PmQV69bdQ==
X-Google-Smtp-Source: ABdhPJxL30+TIklWi9V/HMc7huKrKUCGLTHtinnmThhNh+dO6pPKhE0A32eVZMErcbwSWY0wAQjUNQ==
X-Received: by 2002:a37:9507:: with SMTP id x7mr7934234qkd.1.1619818854636;
        Fri, 30 Apr 2021 14:40:54 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j13sm3123718qth.57.2021.04.30.14.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 14:40:54 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com, stolee@gmail.com
Subject: [PATCH v2 6/8] t0028: extract encoding helpers to lib-encoding.sh
Date:   Fri, 30 Apr 2021 18:40:33 -0300
Message-Id: <9161cd1503cc1a43b91bd899746b406e460b427b.1619818517.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1619818517.git.matheus.bernardino@usp.br>
References: <cover.1619818517.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following patch will add tests outside t0028 which will also need to
re-encode some strings. Extract the auxiliary encoding functions from
t0028 to a common lib file so that they can be reused.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/lib-encoding.sh                | 25 +++++++++++++++++++++++++
 t/t0028-working-tree-encoding.sh | 25 +------------------------
 2 files changed, 26 insertions(+), 24 deletions(-)
 create mode 100644 t/lib-encoding.sh

diff --git a/t/lib-encoding.sh b/t/lib-encoding.sh
new file mode 100644
index 0000000000..2dabc8c73e
--- /dev/null
+++ b/t/lib-encoding.sh
@@ -0,0 +1,25 @@
+# Encoding helpers
+
+test_lazy_prereq NO_UTF16_BOM '
+	test $(printf abc | iconv -f UTF-8 -t UTF-16 | wc -c) = 6
+'
+
+test_lazy_prereq NO_UTF32_BOM '
+	test $(printf abc | iconv -f UTF-8 -t UTF-32 | wc -c) = 12
+'
+
+write_utf16 () {
+	if test_have_prereq NO_UTF16_BOM
+	then
+		printf '\376\377'
+	fi &&
+	iconv -f UTF-8 -t UTF-16
+}
+
+write_utf32 () {
+	if test_have_prereq NO_UTF32_BOM
+	then
+		printf '\0\0\376\377'
+	fi &&
+	iconv -f UTF-8 -t UTF-32
+}
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index f970a9806b..82905a2156 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -6,33 +6,10 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-encoding.sh"
 
 GIT_TRACE_WORKING_TREE_ENCODING=1 && export GIT_TRACE_WORKING_TREE_ENCODING
 
-test_lazy_prereq NO_UTF16_BOM '
-	test $(printf abc | iconv -f UTF-8 -t UTF-16 | wc -c) = 6
-'
-
-test_lazy_prereq NO_UTF32_BOM '
-	test $(printf abc | iconv -f UTF-8 -t UTF-32 | wc -c) = 12
-'
-
-write_utf16 () {
-	if test_have_prereq NO_UTF16_BOM
-	then
-		printf '\376\377'
-	fi &&
-	iconv -f UTF-8 -t UTF-16
-}
-
-write_utf32 () {
-	if test_have_prereq NO_UTF32_BOM
-	then
-		printf '\0\0\376\377'
-	fi &&
-	iconv -f UTF-8 -t UTF-32
-}
-
 test_expect_success 'setup test files' '
 	git config core.eol lf &&
 
-- 
2.30.1

