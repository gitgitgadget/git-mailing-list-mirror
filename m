Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFF4D20259
	for <e@80x24.org>; Thu,  8 Dec 2016 18:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932309AbcLHS7n (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 13:59:43 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34343 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932231AbcLHS7k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:59:40 -0500
Received: by mail-pg0-f54.google.com with SMTP id x23so176765494pgx.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 10:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Tt3eKJDD1aICFrqPD/WoiD3byx9yxmmj/olvZFLBUtQ=;
        b=QiHzHpjQfzCqrrt06yhS6AakuQqoFB6ArybeBdIl8qS5q1jwrsJpgesRs2MNV7PCKN
         TK/oWERredoQYKCMWSx4dtK6IGh3/pdS6R5BU4dTfX0BNt2Kx1cLE6wMlO55WZkgESmd
         ow7QxUiMCMc+hEGMScy2HwVgwyUbg4B9ihk50TNpbkgHraz1lUz2ZPJsMsO9gHmsBUSg
         HSmQlb537mSIhi4x3xevSRP/OytZz2H10Hw9P2OuEcEw8yZAhWh4x8oWKx1/1mL8jiDr
         8OqHAtbQSbNWBAUBzTXQvKDSg5nD/HxLyGP3y0xQQwQH+EgzO3BaJKnDr+YCT/sQrIca
         cL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Tt3eKJDD1aICFrqPD/WoiD3byx9yxmmj/olvZFLBUtQ=;
        b=kQTL+wMayErEH7gsnYSMkVBlSO67VZm0ssFoK0h2wFmUVh5aM97vcrlB4fvUSHaL/b
         3XrUrP+guLAW7n2pBwpou8+uM6KfsWPKKTVluHVViiLvSxQIxorRwF9ZrAa6YPorERVt
         FEuyKw90lnQ96DE0b7OKVHwyEsSEhvxB6v+/xhc9xKC08862qGeL7qpjm0+wFpt996hq
         K/mw+FHwKX/6oSuX4CEXRFjxXHZuWzB06CAOjlwQCDFRWWjvid6CyhqkV79V/EX6Ngv7
         LYSibZHVfTowLdJ7WQp1VtXoxJVOpLCFY3EYZRsLbIBdlVzSMVX4kJ/dpPIt45w5EIq5
         1Fag==
X-Gm-Message-State: AKaTC029ax7sMvxGXYqBGHt9sPiwwKFfo2HmzvwlDr4dLVQcNa/mlybu5IUUfG7u1iGbF/py
X-Received: by 10.98.137.153 with SMTP id n25mr75093310pfk.89.1481223579836;
        Thu, 08 Dec 2016 10:59:39 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id p64sm51815634pfi.88.2016.12.08.10.59.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 10:59:38 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v2 11/16] pathspec: create parse_short_magic function
Date:   Thu,  8 Dec 2016 10:59:05 -0800
Message-Id: <1481223550-65277-12-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481223550-65277-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481223550-65277-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out the logic responsible for parsing short magic into its own
function.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 54 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 523d7bf..29054d2 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -157,6 +157,41 @@ static int get_global_magic(int element_magic)
 }
 
 /*
+ * Parse the pathspec element looking for short magic
+ *
+ * saves all magic in 'magic'
+ * returns the position in 'elem' after all magic has been parsed
+ */
+static const char *parse_short_magic(unsigned *magic, const char *elem)
+{
+	const char *pos;
+
+	for (pos = elem + 1; *pos && *pos != ':'; pos++) {
+		char ch = *pos;
+		int i;
+
+		if (!is_pathspec_magic(ch))
+			break;
+
+		for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
+			if (pathspec_magic[i].mnemonic == ch) {
+				*magic |= pathspec_magic[i].bit;
+				break;
+			}
+		}
+
+		if (ARRAY_SIZE(pathspec_magic) <= i)
+			die(_("Unimplemented pathspec magic '%c' in '%s'"),
+			    ch, elem);
+	}
+
+	if (*pos == ':')
+		pos++;
+
+	return pos;
+}
+
+/*
  * Take an element of a pathspec and check for magic signatures.
  * Append the result to the prefix. Return the magic bitmap.
  *
@@ -220,24 +255,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 		copyfrom++;
 	} else {
 		/* shorthand */
-		for (copyfrom = elt + 1;
-		     *copyfrom && *copyfrom != ':';
-		     copyfrom++) {
-			char ch = *copyfrom;
-
-			if (!is_pathspec_magic(ch))
-				break;
-			for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++)
-				if (pathspec_magic[i].mnemonic == ch) {
-					element_magic |= pathspec_magic[i].bit;
-					break;
-				}
-			if (ARRAY_SIZE(pathspec_magic) <= i)
-				die(_("Unimplemented pathspec magic '%c' in '%s'"),
-				    ch, elt);
-		}
-		if (*copyfrom == ':')
-			copyfrom++;
+		copyfrom = parse_short_magic(&element_magic, elt);
 	}
 
 	magic |= element_magic;
-- 
2.8.0.rc3.226.g39d4020

