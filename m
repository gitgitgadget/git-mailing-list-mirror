Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02FCC2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 07:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55BE22223E
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 07:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s41U09dN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgIWH2J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 03:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgIWH2G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 03:28:06 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C044C061755
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 00:28:06 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x14so19770720wrl.12
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 00:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6RIDM9yzJVsduW37sLu4RYCMYtjNJRoj3YnsK67/z0s=;
        b=s41U09dNJwyprGTb4vOq7X5WlhP6Hm3siGpJRjvJTn/9goqGiESRMLpz+oDGb/L86V
         a2NwPM5TZxs/z6Ek4J0VvawPORiK3TNSl2X1TsYrHNr2QRTEOr1TE68mtOPUJFpyN90x
         99PqYoTXoPjBZ+5HqsNskvI+cuQO3lRWGIcl58lnxMpbb/LgAwZAbujGsIU7NiVplh7j
         7Dy1Ba7NP15Fs34X2vgd5UhsVTXLo/0ChA53yEhnpaJIFg3SYn4SyuABUjVpTqtIfn7e
         TYFF8ioF1Vg5m6CNZ15d4Ilsc6jYG4ZzBxlVJTvaHevAatdCV+oDJPqmt8WUv2PU2RPG
         3yvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6RIDM9yzJVsduW37sLu4RYCMYtjNJRoj3YnsK67/z0s=;
        b=nnOOJ0cszvLTwKlGN+IxMYUQN8C5OOY1Dx8WzqkSMp1BUGbJ7/eIzQ8FAnPZYUX701
         CbedT/EcrCUBBQK+uXi/JL1UPzrF3EAUEW/Lbl+fG354Ghiyl9vcoqVmk7PDSBolv1jZ
         EZdRILGgy7tWEYwMEJ6deYfRQzvXrJTl4l1/1F0d/G0NjtWBkhnu/fXhsHrjQcYYjRHR
         LndBNBmJhHcNJHu81nKQu7ULnUgegexVuPcc4LAEpWENWsIhqG2UjjZgceDzEzjZvRGJ
         jqLLLC3LRMfgn3r8BzkzUf3g+tvyfp7eIVNj8BzqP+ZojE8+Qv1BB8v0UPut0Diy1EL3
         5xKA==
X-Gm-Message-State: AOAM532mpa3BME8vXUkniurc82DJidkbdrsS8BsrUn7HWdk4EDkBwhsC
        V87DHhCYE40e+Z4ym/1HTsW27gStY98=
X-Google-Smtp-Source: ABdhPJx/qOr6JBSti/BKowlojkWchu4KBPk1aIYFnCPRIB+5hCpxwNnxEJK2xcj4m5jP75Ihqa1lAw==
X-Received: by 2002:a5d:4d51:: with SMTP id a17mr9474185wru.248.1600846084704;
        Wed, 23 Sep 2020 00:28:04 -0700 (PDT)
Received: from localhost.localdomain ([178.237.235.60])
        by smtp.gmail.com with ESMTPSA id j14sm30046838wrr.66.2020.09.23.00.28.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 00:28:03 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v8 3/6] bisect--helper: introduce new `write_in_file()` function
Date:   Wed, 23 Sep 2020 09:27:37 +0200
Message-Id: <20200923072740.20772-4-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200923072740.20772-1-mirucam@gmail.com>
References: <20200923072740.20772-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's refactor code adding a new `write_in_file()` function
that opens a file for writing a message and closes it and a
wrapper for writing mode.

This helper will be used in later steps and makes the code
simpler and easier to understand.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 43 +++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 8037888ae2..46d2abb36f 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -74,6 +74,40 @@ static int one_of(const char *term, ...)
 	return res;
 }
 
+static int write_in_file(const char *path, const char *mode, const char *format, va_list args)
+{
+	FILE *fp = NULL;
+	int res = 0;
+
+	if (strcmp(mode, "w"))
+		BUG("write-in-file does not support '%s' mode", mode);
+	fp = fopen(path, mode);
+	if (!fp)
+		return error_errno(_("cannot open file '%s' in mode '%s'"), path, mode);
+	res = vfprintf(fp, format, args);
+
+	if (res < 0) {
+		int saved_errno = errno;
+		fclose(fp);
+		errno = saved_errno;
+		return error_errno(_("could not write to file '%s'"), path);
+	}
+
+	return fclose(fp);
+}
+
+static int write_to_file(const char *path, const char *format, ...)
+{
+	int res;
+	va_list args;
+
+	va_start(args, format);
+	res = write_in_file(path, "w", format, args);
+	va_end(args);
+
+	return res;
+}
+
 static int check_term_format(const char *term, const char *orig_term)
 {
 	int res;
@@ -104,7 +138,6 @@ static int check_term_format(const char *term, const char *orig_term)
 
 static int write_terms(const char *bad, const char *good)
 {
-	FILE *fp = NULL;
 	int res;
 
 	if (!strcmp(bad, good))
@@ -113,13 +146,9 @@ static int write_terms(const char *bad, const char *good)
 	if (check_term_format(bad, "bad") || check_term_format(good, "good"))
 		return -1;
 
-	fp = fopen(git_path_bisect_terms(), "w");
-	if (!fp)
-		return error_errno(_("could not open the file BISECT_TERMS"));
+	res = write_to_file(git_path_bisect_terms(), "%s\n%s\n", bad, good);
 
-	res = fprintf(fp, "%s\n%s\n", bad, good);
-	res |= fclose(fp);
-	return (res < 0) ? -1 : 0;
+	return res;
 }
 
 static int is_expected_rev(const char *expected_hex)
-- 
2.25.0

