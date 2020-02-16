Return-Path: <SRS0=2Qsv=4E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8035BC7619E
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 21:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD5C2084E
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 21:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvlhkPgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgBPVjP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 16:39:15 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56058 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgBPVjP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 16:39:15 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so15228086wmj.5
        for <git@vger.kernel.org>; Sun, 16 Feb 2020 13:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3ut+zzuNw5A43I9v+2Qn46rQb2uhSvRXnz2OEh0owEo=;
        b=CvlhkPgCknKowVsdyKurFfySHHfyfbPcUiXZUUduRn80jREfMPp7ucaDNNK+AoIwip
         7/Wn7D8eGSh6AjA2HDf0PLtvQ9bE3gcLjqyBaNFtFCm9LtSYegFoFm9g+eppMvgJ1iSa
         j8LPFndjm9jo10h+72RsxtpD3lqjv3j+opBzjUo4zv519XUjYA/g07hn3N0YcfsYiIav
         VSozfgp8mvkXFhg2uVsm8lHCXtCJ0h+lidBGYpuxu2/mnMKGgH4fNdHfI0MMHVMrlXuQ
         fUKOoyXOMtA3ADQW8QdJ8Ff7lYORUmbcJpsOoJXeamt8PEDxTxfMjBr2hj/8WhIEnPTX
         cyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3ut+zzuNw5A43I9v+2Qn46rQb2uhSvRXnz2OEh0owEo=;
        b=b+e0FI5pAvLDmWNJVfZU5OJYoZRJy1Zh7wgbkTNmjoA+9pRbhrCpUB20pDpNOQmISm
         i5IbiGjvHNikgiYS4HrihQM52BSi9k08Wl/psDUry/kp3kCqnmdA+JSD1xlAmmbrAni2
         SHAIVMUER7FXty2Ckc0lVkM7c3YmZQalCql5iebUhb8Mregzkb6eX2vTI7QLgUU9NlIl
         KHeqFbH3bBkB3TKkCEuGRoCpPQs5CyQVPISV/Nlqdz0UWO29lQ+CBFCf2KxXtpkPX7OY
         zEyrU0Wis73EUcy1aPHegVqEwlZHHRVkyjzOZSRjURaNU8DwlKwp9ygBuY2h0S7rECZ1
         IcMg==
X-Gm-Message-State: APjAAAWNA9+G18mW88h4XgziLVJUUo/tAaGiDBuNX1sie3NoQLfUtRrR
        o8WOvtcIGQp03PDPgVTiHRBRBcjy
X-Google-Smtp-Source: APXvYqyLsrBAm/CKewys3uyqc2Mh7s/XYGv4ArlSWOl6aUUw+u6DGgnsyiQT2uHVcI7AVHeIm7OI+Q==
X-Received: by 2002:a05:600c:54e:: with SMTP id k14mr17158770wmc.115.1581889152730;
        Sun, 16 Feb 2020 13:39:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l132sm18372280wmf.16.2020.02.16.13.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 13:39:12 -0800 (PST)
Message-Id: <3e4f52e55268727815990b9a96daffc365bd99e0.1581889150.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.548.v2.git.1581889150.gitgitgadget@gmail.com>
References: <pull.548.git.1581311049547.gitgitgadget@gmail.com>
        <pull.548.v2.git.1581889150.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Feb 2020 21:39:09 +0000
Subject: [PATCH v2 2/2] advice: extract vadvise() from advise()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

extract a version of advise() that uses an explict 'va_list' parameter.
Call it from advise() and advise_if_enabled() for a functionally
equivalent version.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 advice.c | 45 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/advice.c b/advice.c
index 8cedc649afa..6c0be19a7c5 100644
--- a/advice.c
+++ b/advice.c
@@ -128,15 +128,20 @@ static const char *advice_config_keys[] = {
 	[SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = "submoduleAlternateErrorStrategyDie"
 };
 
-void advise(const char *advice, ...)
+static const char turn_off_instructions[] =
+N_("\n"
+   "Disable this message with \"git config %s false\"");
+
+static void vadvise(const char *advice, va_list params,
+		    int display_instructions, char *key)
 {
 	struct strbuf buf = STRBUF_INIT;
-	va_list params;
 	const char *cp, *np;
 
-	va_start(params, advice);
 	strbuf_vaddf(&buf, advice, params);
-	va_end(params);
+
+	if(display_instructions)
+		strbuf_addf(&buf, turn_off_instructions, key);
 
 	for (cp = buf.buf; *cp; cp = np) {
 		np = strchrnul(cp, '\n');
@@ -165,37 +170,25 @@ int advice_push_update_rejected_enabled(void)
 	
 }
 
-static const char turn_off_instructions[] =
-N_("\n"
-   "Disable this message with \"git config %s false\"");
+void advise(const char *advice, ...)
+{
+	va_list params;
+	va_start(params, advice);
+	vadvise(advice, params, 0, "");
+	va_end(params);
+}
 
 void advise_if_enabled(enum advice_type type, const char *advice, ...)
 {
-	struct strbuf buf = STRBUF_INIT;
-	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
 	va_list params;
-	const char *cp, *np;
-	
+	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
+
 	if(!advice_enabled(type))
 		return;
 
 	va_start(params, advice);
-	strbuf_vaddf(&buf, advice, params);
+	vadvise(advice, params, 1, key);
 	va_end(params);
-
-	strbuf_addf(&buf, turn_off_instructions, key);
-	
-	for (cp = buf.buf; *cp; cp = np) {
-		np = strchrnul(cp, '\n');
-		fprintf(stderr,	_("%shint: %.*s%s\n"),
-			advise_get_color(ADVICE_COLOR_HINT),
-			(int)(np - cp), cp,
-			advise_get_color(ADVICE_COLOR_RESET));
-		if (*np)
-			np++;
-	}
-	strbuf_release(&buf);
-
 }
 
 int git_default_advice_config(const char *var, const char *value)
-- 
gitgitgadget
