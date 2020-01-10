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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6081FC282DD
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 15:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326732080D
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 15:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+eAJaS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgAJPGB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:06:01 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34861 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgAJPGA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 10:06:00 -0500
Received: by mail-qt1-f196.google.com with SMTP id e12so2168683qto.2
        for <git@vger.kernel.org>; Fri, 10 Jan 2020 07:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NMs+mb6lFIu35mWCREXzjjIUxNIovxKh81QiEK5wE0M=;
        b=B+eAJaS8U+Pz8UJjM9VrdMK2lNrNOTEWJcw0UhpJem0v6DBWTo2+VxU8ZugOuDUGal
         RehaDkbciZ+ajEMN7pnUE+zsl7BJ6TQ/VzBfW6WE3zNiQN3JQy0jZ2zltv/wk0NAsle1
         sGwszc6OZlM4KQh/yyI6wsZDP8tOMVG/F5w90qwalbnT72MCOodq3PB0qKONW3H4QlRj
         xsZrBVVcdhRnqiUbMfXgWqXE0CC7TB60ghEmGrBP7seuUNo3tEYUXfJ+LNbx3OfbYdq3
         YYRe5NuZ0atUDW7zc6njFNqbxXt6IOjkOpv+6Jsq7hBMZs4hturHOvBnHDyXpD2+/Wpp
         IVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NMs+mb6lFIu35mWCREXzjjIUxNIovxKh81QiEK5wE0M=;
        b=VGwWABEc1/oVN7/RX8qLS7syzggSQ6Go5tPQezHPx+wQPDP+GR2PY5eNhGcsntLoCY
         QK2jz3JNBhEQUPorf1Hd9kT+uVrc58NJP8rcPtW7NKSifPfp/7ThOwbZ8mLxq/UzNkfN
         H/x2gjIP3agfI39y0MWVmpTpTyq18k7/V9iQIFKrNPAAlUe59QouTc34POshIotB+Koz
         g9l+ndz1SxXNELNvKlpa/a2CdII/Ye2QZ3gUzjB3hCpH6dFPRXAeYjSW2ho2kqufGT/Q
         IrZ4gBCTT0CG1fApHldmLWfiP+kjMfgNllsJELn874gQqssVWWubJriu3ksQ50jdXaTm
         B0SA==
X-Gm-Message-State: APjAAAXO6r/oup7sjweTBUvSW3TA76X26y/1SkGhf/mYqa/GNSQqi3vI
        PfL5kJkSRvPeNZ7GmoKPy1o=
X-Google-Smtp-Source: APXvYqzsolaGyDWEAxpaBUBGBncTzyvRhWcoyZw3FK0E83vGAgoKNz1Koe4JtqMMPa5cGPYmbb0P6A==
X-Received: by 2002:ac8:440b:: with SMTP id j11mr2779616qtn.283.1578668759835;
        Fri, 10 Jan 2020 07:05:59 -0800 (PST)
Received: from eyalsoha.corp.google.com ([2620:0:1003:512:ad66:81e4:4335:3c9d])
        by smtp.gmail.com with ESMTPSA id s20sm956258qkg.131.2020.01.10.07.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 07:05:58 -0800 (PST)
From:   Eyal Soha <shawarmakarma@gmail.com>
To:     peff@peff.net, git@vger.kernel.org
Cc:     Eyal Soha <shawarmakarma@gmail.com>
Subject: [PATCH 1/3] color.c: Refactor color_output to use enums
Date:   Fri, 10 Jan 2020 10:05:45 -0500
Message-Id: <20200110150547.221314-1-shawarmakarma@gmail.com>
X-Mailer: git-send-email 2.24.1.591.g12029dc57d.dirty
In-Reply-To: <20200110111516.GA474613@coredump.intra.peff.net>
References: <20200110111516.GA474613@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Eyal Soha <shawarmakarma@gmail.com>
---
 color.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/color.c b/color.c
index ebb222ec33..0549501f47 100644
--- a/color.c
+++ b/color.c
@@ -24,6 +24,13 @@ const char *column_colors_ansi[] = {
 	GIT_COLOR_RESET,
 };
 
+enum {
+	COLOR_BACKGROUND_OFFSET = 10,
+	COLOR_FOREGROUND_ANSI = 30,
+	COLOR_FOREGROUND_RGB = 38,
+	COLOR_FOREGROUND_256 = 38,
+};
+
 /* Ignore the RESET at the end when giving the size */
 const int column_colors_ansi_max = ARRAY_SIZE(column_colors_ansi) - 1;
 
@@ -92,7 +99,7 @@ static int parse_color(struct color *out, const char *name, int len)
 	for (i = 0; i < ARRAY_SIZE(color_names); i++) {
 		if (match_word(name, len, color_names[i])) {
 			out->type = COLOR_ANSI;
-			out->value = i;
+			out->value = i + COLOR_FOREGROUND_ANSI;
 			return 0;
 		}
 	}
@@ -112,7 +119,7 @@ static int parse_color(struct color *out, const char *name, int len)
 		/* Rewrite low numbers as more-portable standard colors. */
 		} else if (val < 8) {
 			out->type = COLOR_ANSI;
-			out->value = val;
+			out->value = val + COLOR_FOREGROUND_ANSI;
 			return 0;
 		} else if (val < 256) {
 			out->type = COLOR_256;
@@ -166,23 +173,22 @@ int color_parse(const char *value, char *dst)
  * already have the ANSI escape code in it. "out" should have enough
  * space in it to fit any color.
  */
-static char *color_output(char *out, int len, const struct color *c, char type)
+static char *color_output(char *out, int len, const struct color *c, int offset)
 {
 	switch (c->type) {
 	case COLOR_UNSPECIFIED:
 	case COLOR_NORMAL:
 		break;
 	case COLOR_ANSI:
-		if (len < 2)
-			BUG("color parsing ran out of space");
-		*out++ = type;
-		*out++ = '0' + c->value;
+		out += xsnprintf(out, len, "%d", c->value + offset);
 		break;
 	case COLOR_256:
-		out += xsnprintf(out, len, "%c8;5;%d", type, c->value);
+		out += xsnprintf(out, len, "%d;5;%d", COLOR_FOREGROUND_256 + offset,
+				 c->value);
 		break;
 	case COLOR_RGB:
-		out += xsnprintf(out, len, "%c8;2;%d;%d;%d", type,
+		out += xsnprintf(out, len, "%d;2;%d;%d;%d",
+				 COLOR_FOREGROUND_RGB + offset,
 				 c->red, c->green, c->blue);
 		break;
 	}
@@ -280,13 +286,13 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 			if (sep++)
 				OUT(';');
 			/* foreground colors are all in the 3x range */
-			dst = color_output(dst, end - dst, &fg, '3');
+			dst = color_output(dst, end - dst, &fg, 0);
 		}
 		if (!color_empty(&bg)) {
 			if (sep++)
 				OUT(';');
 			/* background colors are all in the 4x range */
-			dst = color_output(dst, end - dst, &bg, '4');
+			dst = color_output(dst, end - dst, &bg, COLOR_BACKGROUND_OFFSET);
 		}
 		OUT('m');
 	}
-- 
2.24.1.591.g12029dc57d.dirty

