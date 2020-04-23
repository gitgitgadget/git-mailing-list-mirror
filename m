Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F83EC2BA19
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C789208E4
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+B8fQm9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgDWHJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgDWHJj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 03:09:39 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DA0C03C1AF
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:09:39 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u127so5348586wmg.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NOXbS34irrxI9f7XExooH+K1aBCXSlH3jCrBenNNPjs=;
        b=u+B8fQm9m4FF4Ius9+xm6+S4w33Q9vI7ZYJ9t6u6WdcSWNn1RxzMfyK6KX88/+Tw8H
         gdPd2IyDzW6hY5tYF60nUrv4xz7CIOkpcc0UGGCI9oETo/MKdRd775AsnSssDyj3fy+g
         TbIRjYa14m9pgvHZGu57dGJDIG/eDjSvupmgjvvjFkJlK+f/u9fek0wEqHMeEJMv8//l
         YeZD4Vw/ecQJ1rX0GmjmlBL4s7Dtof8sLeJFbGPze5HZv0D6Eln649a5KKefgifQOHCf
         R/2J0mzbUFHxkxR3U2wI/JyshtXocaQ8eG3cGP8pMp6C0YuMewZCgUb2h9A6O44GZF9q
         AdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NOXbS34irrxI9f7XExooH+K1aBCXSlH3jCrBenNNPjs=;
        b=HrAFN6vQN9y2ubzS+Tbj51uTe977+JimlFusURNDHjSy55UsGnLholzjgY5awoC3gv
         ITXAoX4R7rXdmVGoWb2Ri6J2xAkn0ck+dC1kRlaxyDkdvfAaLCAHidhsyI9CU/QYpsgz
         eFz49yPXZzwn0GO9cz9bNSw9a4ncd5T1tedd08RuWhX1NNs1PBDF0dajcIIZKp5lqf2A
         LZKkROOXAph7uHDMkwi+S/doJ9BBYTKnbYJIQ5xNFRxaDxq1MHYESGGG1AXgUSyaFkNV
         03sUjogldoc+OveP4OpCoBYaRkj1qiJm9tS5mgig91sozWV3nswMDXqexUWk/hnsJFpC
         sXIQ==
X-Gm-Message-State: AGi0PubYstQJdWpnIzpaPgvIv9Je9ftlqgQDiBiHYOgaAZw2sgy/iOP8
        JU5/t5WxRSLQlZYgl+48YvbQSGjlxJ8=
X-Google-Smtp-Source: APiQypJQ7NNNW9/pEJfZpcp7m6Tfr0ISJEIqrwi4aK/tf2Mc5MCICwrHeQU9m3CXjpQiUsS/qBcNUw==
X-Received: by 2002:a7b:c772:: with SMTP id x18mr2603645wmk.39.1587625777905;
        Thu, 23 Apr 2020 00:09:37 -0700 (PDT)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u17sm2518585wra.63.2020.04.23.00.09.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 00:09:37 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 03/12] bisect--helper: introduce new `write_in_file()` function
Date:   Thu, 23 Apr 2020 09:06:55 +0200
Message-Id: <20200423070704.39872-4-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200423070704.39872-1-mirucam@gmail.com>
References: <20200423070704.39872-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's refactor code adding a new `write_in_file()` function
that opens a file for writing a message and closes it.

This helper will be used in later steps and makes the code
simpler and easier to understand.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 0fbd924aac..d3b2b33df0 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -74,6 +74,28 @@ static int one_of(const char *term, ...)
 	return res;
 }
 
+static int write_in_file(const char *path, const char *mode, const char *format,...)
+{
+	FILE *fp = NULL;
+	va_list args;
+	int res = 0;
+
+	if (!strcmp(mode, "a") && !strcmp(mode, "w"))
+		return error(_("wrong writing mode '%s'"), mode);
+	fp = fopen(path, mode);
+	if (!fp)
+		return error_errno(_("cannot open file '%s' in mode '%s'"), path, mode);
+	va_start(args, format);
+	res = vfprintf(fp, format, args);
+	va_end(args);
+	if (!res) {
+		fclose(fp);
+		return error_errno(_("could not write to file '%s'"), path);
+	}
+
+	return fclose(fp);
+}
+
 static int check_term_format(const char *term, const char *orig_term)
 {
 	int res;
@@ -104,7 +126,6 @@ static int check_term_format(const char *term, const char *orig_term)
 
 static int write_terms(const char *bad, const char *good)
 {
-	FILE *fp = NULL;
 	int res;
 
 	if (!strcmp(bad, good))
@@ -113,12 +134,8 @@ static int write_terms(const char *bad, const char *good)
 	if (check_term_format(bad, "bad") || check_term_format(good, "good"))
 		return -1;
 
-	fp = fopen(git_path_bisect_terms(), "w");
-	if (!fp)
-		return error_errno(_("could not open the file BISECT_TERMS"));
+	res = write_in_file(git_path_bisect_terms(), "w", "%s\n%s\n", bad, good);
 
-	res = fprintf(fp, "%s\n%s\n", bad, good);
-	res |= fclose(fp);
 	return (res < 0) ? -1 : 0;
 }
 
-- 
2.25.0

