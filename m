Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C607C282DD
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 15:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613B12080D
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 15:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAI6LPEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgAJPGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:06:05 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43008 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgAJPGF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 10:06:05 -0500
Received: by mail-qt1-f193.google.com with SMTP id d18so2130141qtj.10
        for <git@vger.kernel.org>; Fri, 10 Jan 2020 07:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ni1DLPfGBgVWGFdfiw8QjKBc7JajUqvf1fS0IRqthVc=;
        b=KAI6LPEJzYx6SnSQT6nLHpZFYYtqRYGFbLopdUVJqzKWNHQugh39dUo82Rq8JIH0h6
         IxGEdAFYAq+ZBC8L9HMnOgUDmjkIGEsNqIsSF/HWSSRUsN9ncVF3Uy3p8T2Z1bv8ax3P
         49pRJNE54eS1xfGEpYuP8tL51prO1LewL/cYlO707/GjA7JG5SuhH5Pu/2ZJwmtzBIrp
         ytGlxh3uTl4oz6vrgFYnBwN4vyynaJJh+XFTBpS1rxx9r0fVy0V+zzfHmraqXGKJJMdW
         M3G6cT/HKhWM/ZmGCAdnMGJI0F71uMt/aSQkJxtwu5pFnn/SiYc4N11dpxosCed8OyDc
         41lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ni1DLPfGBgVWGFdfiw8QjKBc7JajUqvf1fS0IRqthVc=;
        b=jCzkk79cAWAXzbn2tSMsH50DlZU2L5FCQcRj/USRaupYo5HBc0jE8fzBziQaLkWB1d
         FNHr4QtTDKxKz0cAGmkg2eBGUtxtGROo5OuVn8QDshG1pY6u7E/IjkDs+a9uiS95G2o9
         WnlC2GG7cjcd8IENg6BACfNn42jOOQlDQMYGS5hisEEiPHz4hQSqB6t5lTC4fya1DKiy
         m0pDIj5iTwdqtjbi5MonOiIW+EjUSqySOO56meMaSfgi5KMIYaO7rn6xon1zAwRBp4+4
         lGPlkgac3rQETP7xQwnWVmjIygsdTpWAkjpszmRvPsc0a9rbgCwhOz7fYK4s8XTyHrFC
         IjTA==
X-Gm-Message-State: APjAAAUQydY85oWuaxlRQFPPcaKoaKsPQ4FcRZMeWEEhK4GciNDtXZFj
        4j1zsKdTR04E943F996u/DI=
X-Google-Smtp-Source: APXvYqwgblcySzQ6EZfoVkri0VLmJTA0lC+pR2ZwhGjXxzUmahTCjpBY9ARP/hhj+1iFImCYk+BFDQ==
X-Received: by 2002:aed:2022:: with SMTP id 31mr2647861qta.321.1578668764152;
        Fri, 10 Jan 2020 07:06:04 -0800 (PST)
Received: from eyalsoha.corp.google.com ([2620:0:1003:512:ad66:81e4:4335:3c9d])
        by smtp.gmail.com with ESMTPSA id s20sm956258qkg.131.2020.01.10.07.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 07:06:03 -0800 (PST)
From:   Eyal Soha <shawarmakarma@gmail.com>
To:     peff@peff.net, git@vger.kernel.org
Cc:     Eyal Soha <shawarmakarma@gmail.com>
Subject: [PATCH 2/3] color.c: Support bright aixterm colors
Date:   Fri, 10 Jan 2020 10:05:46 -0500
Message-Id: <20200110150547.221314-2-shawarmakarma@gmail.com>
X-Mailer: git-send-email 2.24.1.591.g12029dc57d.dirty
In-Reply-To: <20200110150547.221314-1-shawarmakarma@gmail.com>
References: <20200110111516.GA474613@coredump.intra.peff.net>
 <20200110150547.221314-1-shawarmakarma@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These colors are the bright variants of the 3-bit colors.

Signed-off-by: Eyal Soha <shawarmakarma@gmail.com>
---
 color.c          | 30 +++++++++++++++++++++++-------
 t/t4026-color.sh |  8 ++++++++
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/color.c b/color.c
index 0549501f47..4dbf12eff8 100644
--- a/color.c
+++ b/color.c
@@ -29,6 +29,7 @@ enum {
 	COLOR_FOREGROUND_ANSI = 30,
 	COLOR_FOREGROUND_RGB = 38,
 	COLOR_FOREGROUND_256 = 38,
+	COLOR_FOREGROUND_BRIGHT_ANSI = 90,
 };
 
 /* Ignore the RESET at the end when giving the size */
@@ -68,13 +69,32 @@ static int get_hex_color(const char *in, unsigned char *out)
 	return 0;
 }
 
-static int parse_color(struct color *out, const char *name, int len)
+static int parse_ansi_color(struct color *out, const char *name, int len)
 {
 	/* Positions in array must match ANSI color codes */
 	static const char * const color_names[] = {
 		"black", "red", "green", "yellow",
 		"blue", "magenta", "cyan", "white"
 	};
+
+	int color_offset = COLOR_FOREGROUND_ANSI;
+	if (strncasecmp(name, "bright", 6) == 0) {
+		color_offset = COLOR_FOREGROUND_BRIGHT_ANSI;
+		name += 6;
+		len -= 6;
+	}
+	for (int i = 0; i < ARRAY_SIZE(color_names); i++) {
+		if (match_word(name, len, color_names[i])) {
+			out->type = COLOR_ANSI;
+			out->value = i + color_offset;
+			return 1;
+		}
+	}
+	return 0;
+}
+
+static int parse_color(struct color *out, const char *name, int len)
+{
 	char *end;
 	int i;
 	long val;
@@ -96,12 +116,8 @@ static int parse_color(struct color *out, const char *name, int len)
 	}
 
 	/* Then pick from our human-readable color names... */
-	for (i = 0; i < ARRAY_SIZE(color_names); i++) {
-		if (match_word(name, len, color_names[i])) {
-			out->type = COLOR_ANSI;
-			out->value = i + COLOR_FOREGROUND_ANSI;
-			return 0;
-		}
+	if (parse_ansi_color(out, name, len)) {
+		return 0;
 	}
 
 	/* And finally try a literal 256-color-mode number */
diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index 671e951ee5..78c69de90a 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -30,6 +30,14 @@ test_expect_success 'attribute before color name' '
 	color "bold red" "[1;31m"
 '
 
+test_expect_success 'aixterm bright fg color' '
+	color "brightred" "[91m"
+'
+
+test_expect_success 'aixterm bright bg color' '
+	color "green brightblue" "[32;104m"
+'
+
 test_expect_success 'color name before attribute' '
 	color "red bold" "[1;31m"
 '
-- 
2.24.1.591.g12029dc57d.dirty

