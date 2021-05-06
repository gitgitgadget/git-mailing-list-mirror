Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614B6C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 277A161177
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbhEFQxl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 12:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236072AbhEFQxl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 12:53:41 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D76C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 09:52:42 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v12so6345317wrq.6
        for <git@vger.kernel.org>; Thu, 06 May 2021 09:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bKLz9YgU+E+1QH0x93PER+OPkHX2Qopkv+2Q71QSacI=;
        b=g794zA9/D2nHzKnNqPTrC2d21G3vmY/mWeqIHvrtB3k+33Z9CSEqgdZCRl5YTuD3cO
         6ufZb4ns36LQxm37E/9aC7Yvbjd1UMYRwTviEv72PyvbsIZrK8dXO4OSKt7XfMIwXIye
         r5+9P5iuknlTuAEBskI1ZMDE9pYSg04ZG0MDpsJYPPPh1bAMKq/tEY2MVxCcLJByA3ix
         66r713G5GKup9XS1UH/s3If1Bj2DnpU/62wzbdCeZeOhrZojQy8PssWkTOnTOqJZmRgy
         dll2QyKi1cV3sUW8AFWHnxwciyeIkN17ZL/CyD+BhG3LyBhaRypD7CFQ9FWSd3Oxr+jV
         5wQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bKLz9YgU+E+1QH0x93PER+OPkHX2Qopkv+2Q71QSacI=;
        b=hLTk+ymHIe5OFMag9IQeb8DeHehqcLN76oc15l6Vt8VdqZjoVjekuJ0frQAwWL62x2
         PS9KyKbdIOIusQiHbw2qNGPun6eHUznstIf29hWfG2yzGjYJR5aZNmJZg2zkl/XrAb0J
         BonPBAbbV7VY+MacIK8VSHRE+rRWjaSGnh5yJJ4IbmaoCNupaCq1f69HzziPbOh+7D1e
         bqYXG/vUZmevobH9DL6o9sUVuIifGX20zHhXSMNmAq0yH10B4pgxGWn3b8Aw3pg4RhMu
         oVfqmOktloMhYKCShVLs+a+/ncvtP8o010bjGvTV4fogpRZ35ST/0l4LuXWTDCCxlMn2
         CyGA==
X-Gm-Message-State: AOAM531DlC1G6a7N1ViOfrHLTTCWwLhICsviNrF42WPD0IzubR2IpX8B
        utOP0Z6Vu3PubugbEluJVIQ=
X-Google-Smtp-Source: ABdhPJxhpI3eKzzN3W9nxYRAgwlcc5/7AhfIiJfk6eO4vkKJT0BE4WOKajTh2+yIHeNwjmb4QZBj+g==
X-Received: by 2002:adf:ed07:: with SMTP id a7mr6735342wro.113.1620319961757;
        Thu, 06 May 2021 09:52:41 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c42006d71140a7638f172.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:6d71:140a:7638:f172])
        by smtp.gmail.com with ESMTPSA id y14sm5354482wrr.82.2021.05.06.09.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 09:52:41 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: [PATCH v1 1/8] compat/terminal: let prompt accept input from pipe
Date:   Thu,  6 May 2021 18:50:55 +0200
Message-Id: <20210506165102.123739-2-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.450.g14fbf8793d
In-Reply-To: <20210506165102.123739-1-firminmartin24@gmail.com>
References: <20210506165102.123739-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, git_prompt ignores input coming from anywhere other than
terminal (pipe, redirection etc.) meaning that standard prompt
auto-answering methods would have no effect:

        echo 'Y' | git ...
        yes 'Y' | git ...
        git ... <input.txt

It also prevents git subcommands using git_prompt to be tested using
such methods.

This patch fixes this issue by considering standard input when !isatty(0).
It also rearranges the control flow to close input and output file handlers.

Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 compat/terminal.c | 47 ++++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index 43b73ddc75..c12e0b9ab9 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -202,41 +202,50 @@ static int mingw_getchar(void)
 char *git_terminal_prompt(const char *prompt, int echo)
 {
 	static struct strbuf buf = STRBUF_INIT;
-	int r;
-	FILE *input_fh, *output_fh;
+	int r, input_not_from_tty = !isatty(STDIN_FILENO);
+	FILE *input_fh = NULL, *output_fh = NULL;
+	char* ret = NULL;
+
+	if (input_not_from_tty) 
+		input_fh = stdin;
+	else
+		input_fh = fopen(INPUT_PATH, "r" FORCE_TEXT);
 
-	input_fh = fopen(INPUT_PATH, "r" FORCE_TEXT);
 	if (!input_fh)
-		return NULL;
+		goto done;
 
 	output_fh = fopen(OUTPUT_PATH, "w" FORCE_TEXT);
-	if (!output_fh) {
-		fclose(input_fh);
-		return NULL;
-	}
 
-	if (!echo && disable_echo()) {
-		fclose(input_fh);
-		fclose(output_fh);
-		return NULL;
-	}
+	if (!output_fh) 
+		goto done;
+
+	if (!echo && disable_echo()) 
+		goto done;
 
 	fputs(prompt, output_fh);
 	fflush(output_fh);
 
 	r = strbuf_getline_lf(&buf, input_fh);
-	if (!echo) {
+
+	if (input_not_from_tty) 
+		fputs(buf.buf, output_fh);
+
+	if (!echo || input_not_from_tty) {
 		putc('\n', output_fh);
 		fflush(output_fh);
 	}
 
 	restore_term();
-	fclose(input_fh);
-	fclose(output_fh);
 
-	if (r == EOF)
-		return NULL;
-	return buf.buf;
+	if (r != EOF)
+		ret = buf.buf;
+done:
+	if (input_fh && input_fh != stdin) 
+		fclose(input_fh);
+	if (output_fh)
+		fclose(output_fh);
+
+	return ret;
 }
 
 /*
-- 
2.31.1.449.g4a44fa8106

