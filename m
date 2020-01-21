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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8125C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 16:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE7324653
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 16:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmpLdzxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgAUQ47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:56:59 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36354 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgAUQ47 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 11:56:59 -0500
Received: by mail-pf1-f195.google.com with SMTP id x184so1792993pfb.3
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 08:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zmGmA8lKEX47bitNrdLA9u2ZrSmJYYcvfDXA9GwoOgM=;
        b=NmpLdzxz4BdtKLw/t2d9fiTF6YfGWO+gH54uCOPZqmgLTKGzvgnU2P9wiyd85YCs4i
         GcGz3AIQdcD5yPPrHsYkEFAUMEKCWt0YBwbVAs1LqP/ntIgCgV+o1Ss6sN090CalekSN
         6RP026B1YrWVZmEolGo4dYTSsoVylGBkZg1pX+ICLJYj9KGr5k+BiLFe1BP3YnM+buFQ
         TvjNySUzPImZB0n0F8c1AtkGESyHqqo91NCtKu6B+nJuTarLHtgkcJ0GVpbWdPP1xbNv
         8Wj4G6O21YvuL2dP2HSZ1jcge03/O1aswm9qQf7GTuRYRIA9NwrCGRBOLSt3fGyTg+Ir
         WxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zmGmA8lKEX47bitNrdLA9u2ZrSmJYYcvfDXA9GwoOgM=;
        b=Kifs8PcxV6zsB9TcP+Ie6Z1Wdrv7/YqyitC3zVbFEPVghbhmz/VpZT9G4Wh5KnOdi+
         AB63eI6xPcjhysoqtvEF+ejYrSnRB5kpprrJ7SKfL6hKpl/cN/w5X1TlyNbXJldZa9ao
         Pb+B8lsx5Oqo9uZF0Uvo0IfGVWJo84FLKN0+GxJXcICQTlBjNIRbe0tMOIKGqD6xFUUK
         7fwXZuTQrFkgVmcD4sqtC72cxZU3VRzcLUeO0kVbkzB+iRutGqJEgEJaDJ9O8HkPvCFk
         TFd7tcw1JBvSZ+iArqWE93/G1OhXbM9dQrFN43JJ7MofcFirSJOjPuVQ4LF5aabQsCjp
         Xtig==
X-Gm-Message-State: APjAAAXjElWCyea8zg0XRxWaQU4Er6WOv9ZNjIpGk+MOd8SDfS+cLMd1
        PBmwAehPcNBzLC0/IOLPmvFYDwTHtjg=
X-Google-Smtp-Source: APXvYqw9p/PlbD8xviqRqfKWSRD+KofcTkoDpm/NKHSrsQjzGnTP7DvbAEaEufN+dg0jFzI0W7F8jw==
X-Received: by 2002:a63:2a8b:: with SMTP id q133mr6265701pgq.72.1579625818837;
        Tue, 21 Jan 2020 08:56:58 -0800 (PST)
Received: from eyalsoha.corp.google.com ([2620:0:1000:5e10:e008:c42d:32e0:39dc])
        by smtp.gmail.com with ESMTPSA id r66sm45688491pfc.74.2020.01.21.08.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 08:56:58 -0800 (PST)
From:   Eyal Soha <shawarmakarma@gmail.com>
To:     gitster@pobox.com, peff@peff.net, git@vger.kernel.org
Cc:     Eyal Soha <shawarmakarma@gmail.com>
Subject: [PATCH 2/3] color.c: support bright aixterm colors
Date:   Tue, 21 Jan 2020 08:56:22 -0800
Message-Id: <20200121165623.151880-2-shawarmakarma@gmail.com>
X-Mailer: git-send-email 2.25.0.rc2.3.g8712c6e7f0
In-Reply-To: <20200121165623.151880-1-shawarmakarma@gmail.com>
References: <CANsz78+-Z89d8E=n3cjfnXaGVFXpchdG7EjtdQuFjzo-=2aPeA@mail.gmail.com>
 <20200121165623.151880-1-shawarmakarma@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These colors are the bright variants of the 3-bit colors.  Instead of
30-37 range for the foreground and 40-47 range for the background,
they live in 90-97 and 100-107 range, respectively.

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

