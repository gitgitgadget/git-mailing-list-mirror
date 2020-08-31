Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6E2C433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 10:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34D0620936
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 10:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbJow04o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgHaKvj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgHaKvN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 06:51:13 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C03C061236
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 03:51:13 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z1so1980870wrt.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 03:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6SFHZnVCeS0qHqgRhbltpkrDBqLd+6jSYWAfeJlUWPM=;
        b=mbJow04oKlBALfadvsg4HOyPZggj4aY9lQ8Mn1peIyTl4ZU3gpAMsVkO0C88V2WuQ3
         bfr16CUUngYusa/r9cKLO3+1pU22H9YVsiN5TVaXckYbJlIErGDV3QGnM7FxY0fGMrvP
         jeXi9yN5qaTCwEJpMjX0Scb8yucC0vtl4W0LbBYKsYhnVIx7TE8WHzO1faPh5Hx0oSwb
         7GDxJFAybwXZuFQYULvw1Hyib9sJzUWz2ADmUaq6apc5H1l7USTiLll/ivp9YGgzjtB7
         9iKNsOF4iYGG7vBj7hlW4KgzIAY5ZZodxxK4BzAHMEHTvyHRXtAl0UQxl4xLTr4zFuZ+
         gvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6SFHZnVCeS0qHqgRhbltpkrDBqLd+6jSYWAfeJlUWPM=;
        b=k4U6fre0xJdv7cp35nsleGY/Iy37XpnHs8+kxmRhvDX5vFc1VMAXyYPs+JQWY690BG
         /9cgj+ckBCy+vTUyza2KuRmFHFDLWk9PcRGsnZW2v06fmya8rwMcDiCMwBbPEe1ZwmrQ
         4PxV17Bpkahsq/Y8rqBqYgwGl9SdnpUyFP3R9Ur/54dLonfYfCOaGezl4p6zGTuwCIEQ
         bR1JdjbYJPIffysIO5LUzeGfYOPvgHYrKSmNE0TIjSRuVOvg5784YIZG3RQekCdbcsct
         YrQQp/U3bn+4g5FJwwMGqlM2XrorIDr1rKXk62nRl0BVcL4CjauDGTpjZiouAKoja6fm
         LIYg==
X-Gm-Message-State: AOAM531g6XklMUnfJ6PWP6RD861rWe6VTbcb5BaRwugTELzJ9rhpimtC
        usi08rVRXniDECpsNugks15hOaOay1Y=
X-Google-Smtp-Source: ABdhPJyP7kIEzceO0EZQubAIYKgBArsasPFnFX8tnjyAR0ROD7x2id1EXUnt5tyF+ChWq5SG6oItPQ==
X-Received: by 2002:adf:cf01:: with SMTP id o1mr1077320wrj.421.1598871071584;
        Mon, 31 Aug 2020 03:51:11 -0700 (PDT)
Received: from localhost.localdomain ([178.237.236.228])
        by smtp.gmail.com with ESMTPSA id k84sm7674454wmf.6.2020.08.31.03.51.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 03:51:11 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v7 03/13] bisect--helper: introduce new `write_in_file()` function
Date:   Mon, 31 Aug 2020 12:50:33 +0200
Message-Id: <20200831105043.97665-4-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200831105043.97665-1-mirucam@gmail.com>
References: <20200831105043.97665-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
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
index b7345be3a5..bae09ce65d 100644
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

