Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4497C433E6
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC9B02086A
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkVQRKEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbgH1Mrg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729388AbgH1MrS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 08:47:18 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1B6C061233
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 05:47:14 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w2so818624wmi.1
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 05:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6SFHZnVCeS0qHqgRhbltpkrDBqLd+6jSYWAfeJlUWPM=;
        b=EkVQRKEINIdkD+odhYKpo3s9bFedhs9VwPHhUkbwUs9Ub6ucE+IYi14InxchEpN0Pq
         zCPJLrCKEecraOLEX6hopXFCPM7cBTceoYaG1tNZXtVdpFGtB0BVNWbgDhVdCUiza1AL
         hLKpdpYhTq6yooRYNr4esCM8Ye/oQTnhXebHvu/S45YmIsHb1DUz5C62XWrHhxMSNzck
         AITHVF3sh9RoJR1OJ5Fuzt5Z0Q0/eekUSz4t47yjTiymSVo28t+s5jhaKb3BigVucC/p
         3Bhqu8O5E8xvibSqePr9UL6D6sMMMoEVK03L55jJoBbTO0I79V4jT+wvYNAU5g9LEAzP
         zrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6SFHZnVCeS0qHqgRhbltpkrDBqLd+6jSYWAfeJlUWPM=;
        b=OzoDi4DzAbUkuKY8oGqN53l/gKPDHd9lnMj7OfZykUwHYfD0DHHeT7suCmSf5qx+gM
         HF6Qznt3SS5kiLd6DOj9hAKsTk9OWHAXcdLK+wQxXd9lkcRrNBfjdVIzzOGP0PcyprT2
         IRtVbo6AqP/+md4y99F2SHWzCJShz983MavXRKOoEAMn4rKOiWRWh0XPAVmq9/9IIqZw
         OIGzcNhINEBuyW2yKee/RDy2bNFo6LNUomA1nmqu5H5C1kqwDfmJI/XAX5mq0OcJ5Ho9
         wsbtV3thzdpS2bWcEmEYC/NqH8K1fal99Z4xKx6C29fNMRZ5Np5opVCy2pBObYX4yyHY
         pACw==
X-Gm-Message-State: AOAM533/6d0BsbQ0ZBvC8RDYK+dpWMJVe8afZtb+2TosHl27+ZZ/nCry
        P8GOhe4SIKuvF235pWkuPEbUi5/EHIM=
X-Google-Smtp-Source: ABdhPJx9EtR+WIouFCVoKkuPMIuRfKORcIjRHk/sZhH740f2j2A8Ivjk0yclzdvd+EO3Jy7okiqtQg==
X-Received: by 2002:a05:600c:228e:: with SMTP id 14mr1533487wmf.17.1598618833372;
        Fri, 28 Aug 2020 05:47:13 -0700 (PDT)
Received: from localhost.localdomain ([178.237.236.228])
        by smtp.gmail.com with ESMTPSA id o66sm2176878wmb.27.2020.08.28.05.47.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Aug 2020 05:47:12 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v6 03/13] bisect--helper: introduce new `write_in_file()` function
Date:   Fri, 28 Aug 2020 14:46:07 +0200
Message-Id: <20200828124617.60618-4-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200828124617.60618-1-mirucam@gmail.com>
References: <20200828124617.60618-1-mirucam@gmail.com>
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

