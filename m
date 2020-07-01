Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3DEC433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D79206BE
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHP8elnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbgGANfg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731148AbgGANff (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 09:35:35 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA37FC08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 06:35:34 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q5so23854581wru.6
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 06:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Iyoj9eRjykHyPqCeAP3BVjxxch5usuj5tsEK3bI5qg=;
        b=cHP8elnrl5zLSDMQSJQ1UY0Kzp7PJdMKbWBLrDj7IJoEEsLY1F7tZpY6t1Y2WFKIW+
         yyORtk4iI0pFOw3WSvn35/u1sL1ejzHrRTGUIkTRVXw5rwaToMSYm4uvdzc1w4uvo+E4
         LvWzhbpWnSeGzQfMHz2NAyzXwNyaRllgoPYDlcGkggYmczHr4/CW6AvAc+qoq5fhMXMk
         jLdiqBoNxSe68Gk5RffZ6OlsVw8HmkJHwgnIANNF+J/UWeJnJur3EGmS+UQh2Q8rUy2K
         11aXCy+sIVAL7UAliBxEPZGOhbL9RFERhd88V+zbO1JM8JHaoe7Ny+0BF2lUgqKbSKeY
         MJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Iyoj9eRjykHyPqCeAP3BVjxxch5usuj5tsEK3bI5qg=;
        b=dWxZmWjJfx3mneQMagIu4bq5h/cNS5dgwYnC/KRkqJXepO1PwhUN2HfwKMpj+n1eeH
         jw6r/Hlp0E37wF2hsIqpT6zIUJ2MwMJ/IThHQl726P5GUSezr5qwz8dHanVep3zKk4S5
         Hv+fqA2pgSs71qSi2hGKAeSQNnup7IqWsn+bF1NzEmlnHPkuy6tlWh/E+4E/QhcUO/Y/
         OmXHx/honncRnb3Cil1lB26N5lN2U6D9Nz0ArBzfKw/wdXlFM0YBG9waVwutiiSei8an
         Ohq4MdRxHlQT1DQJdAnBCgS3UUbWENR1hboHZzE2gt5fh44ig8Ro9vdjo/NJi6bAIhJh
         8Gkg==
X-Gm-Message-State: AOAM5317c/iV+eS8HjhYv5PHUFCsqdHcsOBAsUArqAh0MzU/H4CGsrtA
        FnKIqssD38WedERklATGHq9mixCD6/g=
X-Google-Smtp-Source: ABdhPJw8hJkmQ300epENYOrM7zLWyi0zJmleINgTF1fW8IZUJfeMFsidkJlVe9mt60JLCCHUEx3Vvw==
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr28401024wru.12.1593610533315;
        Wed, 01 Jul 2020 06:35:33 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.178])
        by smtp.gmail.com with ESMTPSA id 30sm7928840wrm.74.2020.07.01.06.35.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 06:35:32 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v4 03/13] bisect--helper: introduce new `write_in_file()` function
Date:   Wed,  1 Jul 2020 15:34:54 +0200
Message-Id: <20200701133504.18360-4-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200701133504.18360-1-mirucam@gmail.com>
References: <20200701133504.18360-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's refactor code adding a new `write_in_file()` function
that opens a file for writing a message and closes it and a
wrapper for writting mode.

This helper will be used in later steps and makes the code
simpler and easier to understand.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 0466b07a43..b421056546 100644
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
+	if (!strcmp(mode, "a") && !strcmp(mode, "w"))
+		return error(_("wrong writing mode '%s'"), mode);
+	fp = fopen(path, mode);
+	if (!fp)
+		return error_errno(_("cannot open file '%s' in mode '%s'"), path, mode);
+	res = vfprintf(fp, format, args);
+
+	if (!res) {
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
@@ -113,12 +144,8 @@ static int write_terms(const char *bad, const char *good)
 	if (check_term_format(bad, "bad") || check_term_format(good, "good"))
 		return -1;
 
-	fp = fopen(git_path_bisect_terms(), "w");
-	if (!fp)
-		return error_errno(_("could not open the file BISECT_TERMS"));
+	res = write_to_file(git_path_bisect_terms(), "%s\n%s\n", bad, good);
 
-	res = fprintf(fp, "%s\n%s\n", bad, good);
-	res |= fclose(fp);
 	return (res < 0) ? -1 : 0;
 }
 
-- 
2.25.0

