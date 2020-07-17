Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BCEC433E6
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BF0C206BE
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwa3S2bP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgGQKyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgGQKyi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 06:54:38 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB15EC061755
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:54:37 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so14183427wmi.3
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jJwxte9VsAu3DBl1IXtcz1vAHjteLgjRLan4d9CeGNk=;
        b=uwa3S2bPW5eUXi1zZM7560+i9cDe4QbyRFdwTrGhffuntUVyz5qMGUQWE/RNYHkV0Z
         DwNBCdz8MWn8u+iNo9ANb1wB2dY2bmeHdVJhmGWZbHKE5902nH/7qhpewtnGJNV+RPfQ
         hUBohP8EW5DWOYHTtkH4I4B/IWgFuQynccWkdBmvhUBw6S5wi7mJ4rzVqGqOomUB2x4e
         UnqdsE1jsSPquKnjbtfY80LAVb9Ond9DB0fM+Z0F+7mPXKCdmUf++oVhCWGq3hY7vtqn
         mIJX7m9/qDfh/SmWOVaNAo0r8QjIGXZ3HDx1fpih/+Igal0JQaJX6l7SgyVjSX/TG0XZ
         gh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jJwxte9VsAu3DBl1IXtcz1vAHjteLgjRLan4d9CeGNk=;
        b=RXOAoO3ydQLYa1xVR5zVRkgH5A3/HDtsSeQOf9zmOeQOFjM2PlDB12hG89U/3ws/Ny
         un0WPSWcbXUb70fkgIrRI8V2zeVJgsG7h2Ff4TFF8eaU2M8AQVkN7yRE5gzXY8LQig//
         +W9Z9s5dWY1SYfXJRZyA6NinOjtP7VlP/GsL41GIXfQ0H7SPHrFrib8WMx0+G3F0e4r1
         xi17jYLvCVbZ0Vfz0VpRIhZ0s5LuOHsCjNyK1zt2OYwBkdXNQlKrOmKC4EB17ByGpHV9
         WJyeHxt2+c7h74tz8C+aJOD8zFoQwzQp/QJYNCPtP+BKcvMwXqbxjOlAfj0VXQZTn6zd
         hmlg==
X-Gm-Message-State: AOAM533uSI4KDJT40OC+vNlPmo3txIqQvV36c1CiRlU5XV0X/1Vj/6Ia
        BSuKskzMdA/6kY7HOi86+GIbaMEX
X-Google-Smtp-Source: ABdhPJzORbCN9j2DxCSXKqxMMP/tmN96JOXP5brgVFHW6Mql7eC2T6zyrb7HBNukvJSp6sol4q1vWA==
X-Received: by 2002:a05:600c:281:: with SMTP id 1mr8862400wmk.143.1594983276406;
        Fri, 17 Jul 2020 03:54:36 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.178])
        by smtp.gmail.com with ESMTPSA id w14sm13924474wrt.55.2020.07.17.03.54.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 03:54:35 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v5 03/13] bisect--helper: introduce new `write_in_file()` function
Date:   Fri, 17 Jul 2020 12:53:56 +0200
Message-Id: <20200717105406.82226-4-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200717105406.82226-1-mirucam@gmail.com>
References: <20200717105406.82226-1-mirucam@gmail.com>
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
 builtin/bisect--helper.c | 41 +++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 0466b07a43..d620d84d92 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -74,6 +74,38 @@ static int one_of(const char *term, ...)
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
+		fclose(fp);
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
@@ -104,7 +136,6 @@ static int check_term_format(const char *term, const char *orig_term)
 
 static int write_terms(const char *bad, const char *good)
 {
-	FILE *fp = NULL;
 	int res;
 
 	if (!strcmp(bad, good))
@@ -113,13 +144,9 @@ static int write_terms(const char *bad, const char *good)
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

