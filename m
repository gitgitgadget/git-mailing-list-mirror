Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B93C433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 16:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A86FA611AD
	for <git@archiver.kernel.org>; Tue,  4 May 2021 16:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhEDQ3B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 12:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbhEDQ24 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 12:28:56 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A1FC061761
        for <git@vger.kernel.org>; Tue,  4 May 2021 09:28:01 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 8so9112987qkv.8
        for <git@vger.kernel.org>; Tue, 04 May 2021 09:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2EnM5QDr7FoNgrYUhohEVPq46wiDviob4V3QvwYbMTk=;
        b=zXOmvi6S/g9e1+uX+dyYmrrTqw6gUFQR/YktCbrg1FmTrCnOWCjPnbuUJc6PwLfyeU
         n9biQi2mLsWI8xXNvFPhaUcSEGFyB5+1VV4EYeIU1Cn6xJZ02f2OiCtlWFagBwKQccyR
         dmerQB+UPOg+U9so/MzCvVZEmx+yYMhIc4ezn73g2md3L9PhDp6YFwSdsgJSAbdjkxtQ
         LFf4PFYm77u6/ybUv8wzDoHMRgGMvjiAbwl5RrV8NNO+hPI7FLSwK2J+7GGbDeqiBluj
         hSWfx+ZeCJG80N8XsJZhQUZdcn18aRo1ynuBJu7FVYwTESjc2TMs/2vcY7CsFpz/cobP
         a+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2EnM5QDr7FoNgrYUhohEVPq46wiDviob4V3QvwYbMTk=;
        b=P9mx7KR01/vRzp5vabrZASInAKor8sZ+iOUO1Kpos4JxefxMXMgVx9WRsrE0TdliiP
         JOO3/eh96ElKd0xFk6LfViwXzZE0HmGriHZ/2ub3niFwNOwW425ObuVCTORhL3XhTq6I
         zo661ArzRKrlRPqENcdv9kmZ6GF1AUlViHkv8WD1vWqABrxuayiDvknptR6CY6K9qaqH
         ITmKd/z5LTvPaGZlv2sP7qYZKePn2SKzxUtzpjvSg1q2/fvcYbjLdRsemHJIpBxQve8e
         OIpcR//CnROyusmG78eUN+RhKuW/2Kx51wkgHaovhfBi6iOtnnQ/OslCq6EFle423hie
         wjcw==
X-Gm-Message-State: AOAM530MioS+Uj4t8aqw7coADEQlq4iCYu3nA2+Mlv0DOjbGAQspHbAK
        jlHWT09/yvSZ63GCl5S7vaSJEzElmBlK0A==
X-Google-Smtp-Source: ABdhPJyiEX+QFXRBZEC6RC2kOhBQQLTjwbIzfttW1eSYrpiR1slw6PvQhDBJHL01DWLSna6hpqbmgQ==
X-Received: by 2002:a37:7a05:: with SMTP id v5mr26028568qkc.266.1620145679984;
        Tue, 04 May 2021 09:27:59 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id x19sm11202689qkx.107.2021.05.04.09.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:27:59 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com,
        stolee@gmail.com, tboegi@web.de
Subject: [PATCH v3 6/8] t0028: extract encoding helpers to lib-encoding.sh
Date:   Tue,  4 May 2021 13:27:33 -0300
Message-Id: <6141c460517b3fd15e8052730dd180df7e445e12.1620145501.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1620145501.git.matheus.bernardino@usp.br>
References: <cover.1620145501.git.matheus.bernardino@usp.br>
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

