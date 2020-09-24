Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F41C4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 12:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FA50238E4
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 12:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuahN31K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgIXMeF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 08:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgIXMeC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 08:34:02 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03B2C0613CE
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 05:34:01 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l15so6707757wmh.1
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 05:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6RIDM9yzJVsduW37sLu4RYCMYtjNJRoj3YnsK67/z0s=;
        b=ZuahN31Kl9lKmnQkVKnigJhIUA6TxNZ/WgErPO99eizUta2mGGkstvzz1Mk4fBEKn9
         ev42fg3z0e77pa23YEkSK9rEwZ3igiyy753dkJUcQzOiENOS7IDH5aDuX1qpw+ZU0dY1
         ZKqiLRLicoTzSh+U2EvjrZqHKYimom43/SDngGA8WvSU5Czgi2YeTXADb4MQq0+AgTNa
         +0RoJg8B6AZVV2y0hgqd9hl4/LGP2dxFLWYjC1MTbxy/BUc13/Vq2qM32Vl0mBTO+UTX
         f8YmdropzByz0cM/J50WPPT6XumfqjKhabdW1c2GY5HHIDZVYVtdvRSVKJk2Jll1rzRK
         3tiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6RIDM9yzJVsduW37sLu4RYCMYtjNJRoj3YnsK67/z0s=;
        b=IidmQSHIG35OBKEF4R5nolRz6QNdrGbukH3lvWI4LzzVIWmVTwrruq62X/AzsiRq2S
         O5a5rRw3MlNMM3tdxbgl1Z5VLeFThAY3DxdYsSRBWqlRVKXgpRrEOvNCdAQ9vU/nPNd4
         cA70IDBxlLhZpN/FB9tH3ZA+FICZ0lr3bZLJqdNaTuarN1TLag/ZIOxTWNizObelWv5N
         PLS7jQ7p1PX0yF6mFPTWZRNibYlP+USSX59/UoMwVNNs3RrVcjJYN5cFCgf82wsRjQOc
         ED8rvGOC1RBVOH1ZhMMFVgo8IVIUH0aSkjSboWlYyskmy4I6uE547DZOY90SnhHqzZEH
         QCng==
X-Gm-Message-State: AOAM5318skUj4Dd+VDM24cAukBkkC/ERT4q6SJBa6hnjIcZ2OH1e0BUw
        +IrTU1PI6y61NpcilHAisgj6ki4wxL0=
X-Google-Smtp-Source: ABdhPJz9qKThYNtSDZl+6YDT7GjnznP51hPK1zh/Q7lKhnoKo0A1QRqPjQYpHTLnYPlmM+wfxz1e0w==
X-Received: by 2002:a1c:e3c3:: with SMTP id a186mr4838070wmh.189.1600950840323;
        Thu, 24 Sep 2020 05:34:00 -0700 (PDT)
Received: from localhost.localdomain ([178.237.235.60])
        by smtp.gmail.com with ESMTPSA id i83sm3485457wma.22.2020.09.24.05.33.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 05:33:59 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v9 3/6] bisect--helper: introduce new `write_in_file()` function
Date:   Thu, 24 Sep 2020 14:33:37 +0200
Message-Id: <20200924123340.52632-4-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200924123340.52632-1-mirucam@gmail.com>
References: <20200924123340.52632-1-mirucam@gmail.com>
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

