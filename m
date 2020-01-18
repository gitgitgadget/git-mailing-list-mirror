Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57916C33CB1
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 14:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24ECF2469D
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 14:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eh2PUqm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgAROzG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jan 2020 09:55:06 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33406 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgAROzG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 09:55:06 -0500
Received: by mail-qk1-f193.google.com with SMTP id d71so25793210qkc.0
        for <git@vger.kernel.org>; Sat, 18 Jan 2020 06:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xyi3un8ozOCID92R1S6Q52/3t/3sFfnQwjXJhouk+Vc=;
        b=eh2PUqm6bi3KLCUJrxYPmsPvMPj78g5DHGcSXlLx673KGQNij9oXf/zSeqhPE7brq9
         /mtrK+grFkmbmt2ZftPgJ5y8Sr0J7Jmj0Vi7OWr+At/VEj5eBVEd+xlIo5qIU7zDgbJ1
         5x1k/iHrSvgsICzAD7aKrplN9X/w5ObFmFoHfQMlrMMmreuBvHrivxragWBKjbPvSoVx
         9yhUF2kYmPSae6YYjKSAKcyyPW9Dpokb1WPd+KRrI2q27cPKyvGDv+TgBi0aWjsYtCPJ
         c54+8dn5UrXQYyuXK8DlB0y7y6tMGLdytuc6xMGxE+ws+mBTeDsPkNm85YVv9wQgaFbh
         tX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xyi3un8ozOCID92R1S6Q52/3t/3sFfnQwjXJhouk+Vc=;
        b=nrF793IVi8CvIaSrEtFT8SyCzQCkSgi6vgT2nkUDPMQdP1bhokovKYEZ8c8++JT807
         KKk5os7vmVysqbPZIJ9T5cBxLD0//1GqJNSB31XIBWHSqM4NQxXrqW9E7SIcHLifWCva
         wV5LHdhJ05oRqMMUwp2WOhmmmaXcjnqo8dHU+dS22sCYO2dbGuOvifaKMso9NKyi937N
         6MoQbU5woCEFyyE/pSI/C3PW4HwME0iWgAzG9R12qzG/XlX2S5N36IZF8rrWCcIZ3kqW
         iAujcPCVStrjFqTE1w+2DWNt70n+R9NofqNeMAU9dzEOd3luOE1ZwXlzNLZsvcDcDBiX
         v3+A==
X-Gm-Message-State: APjAAAVx+qZh2TopLTFB3GspfT1QfsD9s/QjFxmHTHfPRd4aVf/PEIX5
        4N5hFTgSCq0uKyXaEQu3Iv4=
X-Google-Smtp-Source: APXvYqyeP7FEVWH+qME3XSF/jwjlv+ulqCIW7qe4GRFTVBENusnNBnLjch6VE3gIFLQjJffFbX5GfA==
X-Received: by 2002:a05:620a:143b:: with SMTP id k27mr41431145qkj.262.1579359305600;
        Sat, 18 Jan 2020 06:55:05 -0800 (PST)
Received: from eyalsoha.fios-router.home (pool-173-54-220-250.nwrknj.fios.verizon.net. [173.54.220.250])
        by smtp.gmail.com with ESMTPSA id i28sm15122250qtc.57.2020.01.18.06.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 06:55:04 -0800 (PST)
From:   Eyal Soha <shawarmakarma@gmail.com>
To:     peff@peff.net, git@vger.kernel.org, gitster@pobox.com
Cc:     Eyal Soha <shawarmakarma@gmail.com>
Subject: [PATCH 1/3] color.c: Refactor color_output to use enums
Date:   Sat, 18 Jan 2020 09:53:16 -0500
Message-Id: <20200118145318.5177-1-shawarmakarma@gmail.com>
X-Mailer: git-send-email 2.25.0.rc2.3.g8712c6e7f0
In-Reply-To: <CANsz78JyawDpp_SewRQp4_AbZVduSYiazhvCqUcqUV810az5MQ@mail.gmail.com>
References: <CANsz78JyawDpp_SewRQp4_AbZVduSYiazhvCqUcqUV810az5MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

