Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C744FC2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 16:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AAB821569
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 16:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ix7sblMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgAUQ4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:56:55 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40184 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgAUQ4z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 11:56:55 -0500
Received: by mail-pf1-f195.google.com with SMTP id q8so1779114pfh.7
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 08:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TV3mbvWcaqeDbATsmsle2Y8wFLs61YU48+eI9Mr8A28=;
        b=ix7sblMfwySn1EI674yJqSldrkvXbcVmkf2VjP6rM7+Iou93Y2Am0dbNoKs4Lc9b3A
         GGHsZVljJ9MV5+l1DSJMto6sJ8CvaxHj9wNViM20XJE4dUsbLv8bt72hdfGBV6+emFLX
         sdO4hWN1kh7jznh9ioUHNraHW6voSuFhULI8qoCexoLC4fW/tF1TZYudfG3L7Dh53HKH
         YIRyduBa2GIFHBrFA3mxqkqgTUXvsyOaho0Qf5gli33GqchuNXadWzRRZWufIPHG0DlA
         1KXIjV7bsEz2ZQBlhLTs3n3FuBh0gl7Pw4UEp2vWLE+0t1HGFXt/lI32+HiNf+VFVcA6
         YIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TV3mbvWcaqeDbATsmsle2Y8wFLs61YU48+eI9Mr8A28=;
        b=RjJvli1hKJtBGqqwBOMvF4OGpozF9U1KWHWCaY93cqds2oDw5b3zE7tAWkGJo+HpHP
         RsOrHeqKW3MfhdmVLy4YBvSKfjqoKvkQz95MqArO/gwynN22boDsxZbcubxTMGdAEGyx
         OtcRoo0zwOLlSGfP7f5ZfMPol+TI3ilTIqBPB74g6fA5GUL+MzY1Y4zTAEKLAzjl7pkG
         q9fjUaACf/enm7qQV2E6LaVULTuFZnILq4HEzSGnVXny4B5gyRXxn+ww50oKq+y3nfZM
         RAa1EqjjzgGI+LfeLQbMrl7LpCfgtbtyoisJ1mNGqAWSPW7zf2SSLWl/nhhkLANHamZZ
         bErQ==
X-Gm-Message-State: APjAAAUw/SES86G05BhDbpAmovwKP5PK8xeQ/SnewkJuqMUh+0mfAqZE
        jlyWQMu5PtIQV4YDde7UUxs=
X-Google-Smtp-Source: APXvYqzikXJPT6kzZ+z74H5gRJxjesElhLj3u2tz6VEH0DlIsjeXeRPeNUow4Q6vWX1W/Xgjik3Mdg==
X-Received: by 2002:a65:4c82:: with SMTP id m2mr6214858pgt.432.1579625814678;
        Tue, 21 Jan 2020 08:56:54 -0800 (PST)
Received: from eyalsoha.corp.google.com ([2620:0:1000:5e10:e008:c42d:32e0:39dc])
        by smtp.gmail.com with ESMTPSA id r66sm45688491pfc.74.2020.01.21.08.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 08:56:53 -0800 (PST)
From:   Eyal Soha <shawarmakarma@gmail.com>
To:     gitster@pobox.com, peff@peff.net, git@vger.kernel.org
Cc:     Eyal Soha <shawarmakarma@gmail.com>
Subject: [PATCH 1/3] color.c: refactor color_output arguments
Date:   Tue, 21 Jan 2020 08:56:21 -0800
Message-Id: <20200121165623.151880-1-shawarmakarma@gmail.com>
X-Mailer: git-send-email 2.25.0.rc2.3.g8712c6e7f0
In-Reply-To: <CANsz78+-Z89d8E=n3cjfnXaGVFXpchdG7EjtdQuFjzo-=2aPeA@mail.gmail.com>
References: <CANsz78+-Z89d8E=n3cjfnXaGVFXpchdG7EjtdQuFjzo-=2aPeA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

color_output() now uses a more descriptive "background" argument
instead of "type".

Signed-off-by: Eyal Soha <shawarmakarma@gmail.com>
---
 color.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/color.c b/color.c
index ebb222ec33..3b734ccffd 100644
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
@@ -166,23 +173,26 @@ int color_parse(const char *value, char *dst)
  * already have the ANSI escape code in it. "out" should have enough
  * space in it to fit any color.
  */
-static char *color_output(char *out, int len, const struct color *c, char type)
+static char *color_output(char *out, int len, const struct color *c, int background)
 {
+	int offset = 0;
+	if (background) {
+		offset = COLOR_BACKGROUND_OFFSET;
+	}
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
@@ -279,14 +289,12 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 		if (!color_empty(&fg)) {
 			if (sep++)
 				OUT(';');
-			/* foreground colors are all in the 3x range */
-			dst = color_output(dst, end - dst, &fg, '3');
+			dst = color_output(dst, end - dst, &fg, 0);
 		}
 		if (!color_empty(&bg)) {
 			if (sep++)
 				OUT(';');
-			/* background colors are all in the 4x range */
-			dst = color_output(dst, end - dst, &bg, '4');
+			dst = color_output(dst, end - dst, &bg, 1);
 		}
 		OUT('m');
 	}
-- 
2.25.0.rc2.3.g8712c6e7f0

