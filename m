Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F626C35242
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 19:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2262469C
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 19:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hTg/jWi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbgBKTgg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:36:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54630 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730003AbgBKTgg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 14:36:36 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A4124CE21;
        Tue, 11 Feb 2020 14:36:34 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=s/MJERWtabyYG+dBDj5O3KZdF
        Xw=; b=hTg/jWi0ZXGBg3Je2uY96S/O3mt7M+7IY//AVSAMnl7TnXAuC0y2qnbRX
        rjqTnnJeGrsjXEYitiEqDQrztqdg8rs7rweY664dtMgwIsrm2m5GuyZCuDsIgUbn
        aiShVecZjIo24cq0lthsWOGEyXJ+PNfbfT55Nb+QCyB97gyKRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=ogQAdx1o+QH7JEm7DMf
        At3K65SrN01WBciDM25sbCTdCkBDXD+WgjV0M6HAdjB9apyNthN+jd6yEAYCc9EG
        SWRsDa10A8kDvDTntdZNBSHg+6A5/9PX7Sl8R4FvgkccG88ob1rlMkdLWp3pjHU+
        0QcscGCMuchu2QWhhiGQa94o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 626C54CE20;
        Tue, 11 Feb 2020 14:36:34 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9EEF24CE1E;
        Tue, 11 Feb 2020 14:36:32 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Eyal Soha <shawarmakarma@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 2/3] color.c: support bright aixterm colors
Date:   Tue, 11 Feb 2020 11:36:24 -0800
Message-Id: <20200211193625.231492-3-gitster@pobox.com>
X-Mailer: git-send-email 2.25.0-453-g769eb9f0f1
In-Reply-To: <20200211193625.231492-1-gitster@pobox.com>
References: <20200121165623.151880-1-shawarmakarma@gmail.com>
 <20200211193625.231492-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: CEB9D4B4-4D05-11EA-B913-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eyal Soha <shawarmakarma@gmail.com>

These colors are the bright variants of the 3-bit colors.  Instead of
30-37 range for the foreground and 40-47 range for the background,
they live in 90-97 and 100-107 range, respectively.

Signed-off-by: Eyal Soha <shawarmakarma@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |  4 +++-
 color.c                  | 36 ++++++++++++++++++++++++++++--------
 t/t4026-color.sh         |  8 ++++++++
 3 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 83e7bba872..08b13ba72b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -263,7 +263,9 @@ color::
 +
 The basic colors accepted are `normal`, `black`, `red`, `green`, `yellow=
`,
 `blue`, `magenta`, `cyan` and `white`.  The first color given is the
-foreground; the second is the background.
+foreground; the second is the background.  All the basic colors except
+`normal` have a bright variant that can be speficied by prefixing the
+color with `bright`, like `brightred`.
 +
 Colors may also be given as numbers between 0 and 255; these use ANSI
 256-color mode (but note that not all terminals may support this).  If
diff --git a/color.c b/color.c
index 4ee690bd4e..0c0ec4672f 100644
--- a/color.c
+++ b/color.c
@@ -29,6 +29,7 @@ enum {
 	COLOR_FOREGROUND_ANSI =3D 30,
 	COLOR_FOREGROUND_RGB =3D 38,
 	COLOR_FOREGROUND_256 =3D 38,
+	COLOR_FOREGROUND_BRIGHT_ANSI =3D 90,
 };
=20
 /* Ignore the RESET at the end when giving the size */
@@ -68,15 +69,38 @@ static int get_hex_color(const char *in, unsigned cha=
r *out)
 	return 0;
 }
=20
-static int parse_color(struct color *out, const char *name, int len)
+/*
+ * If an ANSI color is recognized in "name", fill "out" and return 0.
+ * Otherwise, leave out unchanged and return -1.
+ */
+static int parse_ansi_color(struct color *out, const char *name, int len=
)
 {
 	/* Positions in array must match ANSI color codes */
 	static const char * const color_names[] =3D {
 		"black", "red", "green", "yellow",
 		"blue", "magenta", "cyan", "white"
 	};
-	char *end;
 	int i;
+	int color_offset =3D COLOR_FOREGROUND_ANSI;
+
+	if (strncasecmp(name, "bright", 6) =3D=3D 0) {
+		color_offset =3D COLOR_FOREGROUND_BRIGHT_ANSI;
+		name +=3D 6;
+		len -=3D 6;
+	}
+	for (i =3D 0; i < ARRAY_SIZE(color_names); i++) {
+		if (match_word(name, len, color_names[i])) {
+			out->type =3D COLOR_ANSI;
+			out->value =3D i + color_offset;
+			return 0;
+		}
+	}
+	return -1;
+}
+
+static int parse_color(struct color *out, const char *name, int len)
+{
+	char *end;
 	long val;
=20
 	/* First try the special word "normal"... */
@@ -96,12 +120,8 @@ static int parse_color(struct color *out, const char =
*name, int len)
 	}
=20
 	/* Then pick from our human-readable color names... */
-	for (i =3D 0; i < ARRAY_SIZE(color_names); i++) {
-		if (match_word(name, len, color_names[i])) {
-			out->type =3D COLOR_ANSI;
-			out->value =3D i + COLOR_FOREGROUND_ANSI;
-			return 0;
-		}
+	if (parse_ansi_color(out, name, len) =3D=3D 0) {
+		return 0;
 	}
=20
 	/* And finally try a literal 256-color-mode number */
diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index 671e951ee5..78c69de90a 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -30,6 +30,14 @@ test_expect_success 'attribute before color name' '
 	color "bold red" "[1;31m"
 '
=20
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
--=20
2.25.0-453-g769eb9f0f1

