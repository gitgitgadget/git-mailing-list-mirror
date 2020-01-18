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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE67C33CB1
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 14:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50BA52469D
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 14:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmQcaCad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgAROzO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jan 2020 09:55:14 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:35675 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgAROzO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 09:55:14 -0500
Received: by mail-qv1-f65.google.com with SMTP id u10so12072491qvi.2
        for <git@vger.kernel.org>; Sat, 18 Jan 2020 06:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dWxfZV27edfVdXXUFNiZBybhEktkPs+VCK1rOgtP4LQ=;
        b=bmQcaCadtp/7pkFTQImo0H0vTY7SWWXA3/BPyNs/GB6qiKhC+T3FOsmQ/94P7Kda9c
         QJV5xfwbqKiDkRqexqa4mHICnV4D0jJ8U+hP5+xlbZQmQQrPwl0SE0lQNe4vqtLUt4ok
         BDpJfUqhEm/JdgNM3siW8B/778Ofck5myYoccqpck9ZHhoSQF+f3x4x+tbw4YgqrE7oY
         p+P/e7mBKFT1LC0tfjQd2aZRzbgmg7tkrDJDRsrVLuswk5Dmxr9dHf4UyjGQbRbmRcYx
         ES0br3sd9O6qywy3e1AWhFAhp9HcwKBWo+VG46+wc/1PgYutrwiackO2Qf95w9SyAbx0
         ITrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dWxfZV27edfVdXXUFNiZBybhEktkPs+VCK1rOgtP4LQ=;
        b=uesy6e9nU2HfI68JnLpcrq0RB40p6Z6qbK+qk7HaoGERDdobpzIrs4OQ3JfhGu8ozI
         KqauINQ4oMDeuu6iNhR99WjaXWaqy3oatDTdxO2oWggTsKz9t9Z1zCwZhDbKdj2QfqNc
         kn6GTCRlsupQnsfpRihSVFIu8qg2231auEDV4FhQNgKWjH4lBVCWcwUDJWepa8DAwk7E
         e8JjytX9UMmB1dsZMmwzzYmhZxQdCltjUDQWnR6y2OH5rW/CaHSwKt5ENtcDEifNsQit
         HzSKbv3sMbCWF8OZdQ7mASLsW4wF5uujeFjqVQ6DtdjJwPfhOE/Nu2+kTqSqU0cRfLyO
         hmvw==
X-Gm-Message-State: APjAAAUXlLiu5/B6ZIIX+9ssLwfVhbi6JPqvsik6giTPnarTw9ib6qkx
        GZfQia1p3B9WxLlJKlV4Lu6koQ/nwQI=
X-Google-Smtp-Source: APXvYqwGh69RA9RSDX5tYkXQzNYpHfKD4K3E8n3sNsEa518TW+X8OumWr0PHX8iIzG8T++ty8NslwA==
X-Received: by 2002:a05:6214:287:: with SMTP id l7mr12901561qvv.142.1579359313005;
        Sat, 18 Jan 2020 06:55:13 -0800 (PST)
Received: from eyalsoha.fios-router.home (pool-173-54-220-250.nwrknj.fios.verizon.net. [173.54.220.250])
        by smtp.gmail.com with ESMTPSA id i28sm15122250qtc.57.2020.01.18.06.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 06:55:12 -0800 (PST)
From:   Eyal Soha <shawarmakarma@gmail.com>
To:     peff@peff.net, git@vger.kernel.org, gitster@pobox.com
Cc:     Eyal Soha <shawarmakarma@gmail.com>
Subject: [PATCH 2/3] color.c: Support bright aixterm colors
Date:   Sat, 18 Jan 2020 09:53:17 -0500
Message-Id: <20200118145318.5177-2-shawarmakarma@gmail.com>
X-Mailer: git-send-email 2.25.0.rc2.3.g8712c6e7f0
In-Reply-To: <20200118145318.5177-1-shawarmakarma@gmail.com>
References: <CANsz78JyawDpp_SewRQp4_AbZVduSYiazhvCqUcqUV810az5MQ@mail.gmail.com>
 <20200118145318.5177-1-shawarmakarma@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These colors are the bright variants of the 3-bit colors.

Signed-off-by: Eyal Soha <shawarmakarma@gmail.com>
---
 Documentation/config.txt |  4 +++-
 color.c                  | 34 +++++++++++++++++++++++++++-------
 t/t4026-color.sh         |  8 ++++++++
 3 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 83e7bba872..08b13ba72b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -263,7 +263,9 @@ color::
 +
 The basic colors accepted are `normal`, `black`, `red`, `green`, `yellow`,
 `blue`, `magenta`, `cyan` and `white`.  The first color given is the
-foreground; the second is the background.
+foreground; the second is the background.  All the basic colors except
+`normal` have a bright variant that can be speficied by prefixing the
+color with `bright`, like `brightred`.
 +
 Colors may also be given as numbers between 0 and 255; these use ANSI
 256-color mode (but note that not all terminals may support this).  If
diff --git a/color.c b/color.c
index 3b734ccffd..66d32e1191 100644
--- a/color.c
+++ b/color.c
@@ -29,6 +29,7 @@ enum {
 	COLOR_FOREGROUND_ANSI = 30,
 	COLOR_FOREGROUND_RGB = 38,
 	COLOR_FOREGROUND_256 = 38,
+	COLOR_FOREGROUND_BRIGHT_ANSI = 90,
 };
 
 /* Ignore the RESET at the end when giving the size */
@@ -68,13 +69,36 @@ static int get_hex_color(const char *in, unsigned char *out)
 	return 0;
 }
 
-static int parse_color(struct color *out, const char *name, int len)
+/*
+ * If an ANSI color is recognized in "name", fill "out" and return 0.
+ * Otherwise, leave out unchanged and return -1.
+ */
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
+			return 0;
+		}
+	}
+	return -1;
+}
+
+static int parse_color(struct color *out, const char *name, int len)
+{
 	char *end;
 	int i;
 	long val;
@@ -96,12 +120,8 @@ static int parse_color(struct color *out, const char *name, int len)
 	}
 
 	/* Then pick from our human-readable color names... */
-	for (i = 0; i < ARRAY_SIZE(color_names); i++) {
-		if (match_word(name, len, color_names[i])) {
-			out->type = COLOR_ANSI;
-			out->value = i + COLOR_FOREGROUND_ANSI;
-			return 0;
-		}
+	if (parse_ansi_color(out, name, len) == 0) {
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
2.25.0.rc2.3.g8712c6e7f0

