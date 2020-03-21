Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B36C4332D
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 16:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C51F20757
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 16:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0DDKEQr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbgCUQNx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 12:13:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37423 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbgCUQNw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 12:13:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so11223989wrm.4
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 09:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=80yv/7meo1EOAH946oEOOLjw/qEOgcPGMrV9jGnWQ4E=;
        b=Y0DDKEQr8yLdXNxPhMu1OaqSvBhd1UjL5UcZkeKWIL9P68bZSVzY7mvLqDqTAAHdcy
         7Ur96A0BxfYUJZBQvVO4hhgce9xe4lyJssVuK1bmxnSyCMysnvxIeIiLNBll0wuzUbpg
         RFJvkIbyRO46Nn72bz5FHjJFl7vw3MZ7sc2TaLH+dak5gt1iCqEHc9cQ71h+betMMERw
         Yay8r/fvkfoAbwO/c/FIzhFtf6iIIG+mFoxLcLiV4MkKo4UKIL1a2jdFG45kxv3qxY8W
         GX7vripAWpxz27PRsK1mrj2X3oioQsyz+kJ3MO2cmLqgnpu6phG2XzrrHf0S6aICy/VI
         sRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=80yv/7meo1EOAH946oEOOLjw/qEOgcPGMrV9jGnWQ4E=;
        b=JAeMC6bCVS8/JV2uRr0qBy7lpMNMLPaz7DvsJdqPTa5lX16IxSKkb5o1ku8zMI7oxj
         hcKCY18nsqgtrDS8pOOYp/j9v5NxA16TlbZr6+aSqb85IDL+SdUQ92/Y+HlIqmpZXVXR
         CazP0iiJDdX0d+CCWxx9eZFCYzo9025RieiGpCHLajDSxP9yihKhq5O5Xt8v1qiqND5n
         C0sqXRFNQXg1n/qM8WLLO8WBE7hjQTlzKJ80niAi9TE/uo2v9VdVhBunKRULvipyDthm
         0O38upAtF9N8O9PCffq0jvj7B3xHbLr8VfidwIKtHKvJH8WZ2u8HRj0bbxy7uH5q6qBN
         dWIw==
X-Gm-Message-State: ANhLgQ2pIq1U1ieKZakwBXrwT/JxJHXh53yt2eS8rE7gGMK8WREV/r5i
        J5o3OB5b7GFLGVnn5/4F2vjAvbY8
X-Google-Smtp-Source: ADFU+vs/wQIrIsQY7Xc9HnUOwCnsw91IlTh9UUIc5ZKU1mP6r2sE7qLEQ6i8AYAxblcWKUKoWmQDrQ==
X-Received: by 2002:adf:ed85:: with SMTP id c5mr19156364wro.41.1584807230703;
        Sat, 21 Mar 2020 09:13:50 -0700 (PDT)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id f22sm13992285wmf.2.2020.03.21.09.13.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 09:13:50 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 02/11] bisect--helper: introduce new `write_in_file()` function
Date:   Sat, 21 Mar 2020 17:10:11 +0100
Message-Id: <20200321161020.22817-3-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200321161020.22817-1-mirucam@gmail.com>
References: <20200321161020.22817-1-mirucam@gmail.com>
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
 builtin/bisect--helper.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1f81cff1d8..e949ea74e2 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -74,6 +74,26 @@ static int one_of(const char *term, ...)
 	return res;
 }
 
+static int write_in_file(const char *filepath, const char *mode, const char *format,...)
+{
+	FILE *fp = NULL;
+	va_list args;
+	int res = 0;
+
+	if (!strcmp(mode, "a") && !strcmp(mode, "w"))
+		return error_errno(_("wrong writing mode '%s'"), mode);
+	fp = fopen(filepath, mode);
+	if (!fp)
+		return error_errno(_("could not open file '%s'"), filepath);
+	va_start(args, format);
+	res = vfprintf(fp, format, args);
+	va_end(args);
+	if (!res)
+		return error_errno(_("could not write to file '%s'"), filepath);
+
+	return fclose(fp);
+}
+
 static int check_term_format(const char *term, const char *orig_term)
 {
 	int res;
@@ -104,7 +124,6 @@ static int check_term_format(const char *term, const char *orig_term)
 
 static int write_terms(const char *bad, const char *good)
 {
-	FILE *fp = NULL;
 	int res;
 
 	if (!strcmp(bad, good))
@@ -113,12 +132,8 @@ static int write_terms(const char *bad, const char *good)
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

