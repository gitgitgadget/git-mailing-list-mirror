Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E24031FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 18:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760678AbdACSxJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 13:53:09 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36190 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760598AbdACSxG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 13:53:06 -0500
Received: by mail-pg0-f54.google.com with SMTP id f188so217408800pgc.3
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 10:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LcPlpIKsl6pFuneIH7ZbwfqVFX3FdEx6Oe4KinRc5GE=;
        b=jG4owRP0aWiAos8x0iOk6+ePFWGokPMWG7tKqeXUt0YK+CxZUSQ2ucP5pKFZ2YwJAv
         I5nyMogmF7qVCq9y9IpymZsRn2kw6Fdp3uOuzT8W4FGhDMKjTG51HCsJ7XXKWA4qyALN
         /bVdg2Mb7pnjM9CVJZWjNo6ooxRSM7JYv77kupzQ8PQwVwvjYvrWoEbrnX6SaTYKSXcq
         x1I57h5Bp/DPaMrsTL8loiMDAuHxJz5099vzhxsWBE+wNxtXOBdmDNsBtR9gE0eaxghu
         zl7RanZz+Y5Htgxtzy6WWgL/WHICV6l/ht3wYRxRERPPb04z8Jx0YHAZgZc2y6CkqhpA
         BZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LcPlpIKsl6pFuneIH7ZbwfqVFX3FdEx6Oe4KinRc5GE=;
        b=H0YqLLePEV3FchOA9WsAk/8aw4EBWzNOiZo0cpTKBEX+WiBw8r924E/creTenGyLQf
         azTlHRTrll90PrboQxqfQIT2NlB687XXlGP0EpScrALtm2fiL66w1OKxFKIPpYzJCSc3
         pnLD4TIXuqNYtam5Em5kvt2gDGeb1CdrHNRHvXQndv0hrVTsxBu/+5UQXT23yzD1B0qr
         aLpqfdpIRRugMmuoEONpLU3xP2M+IwEprfAfoRIKHMLUavbAmeGFHkCZAccWqVQzQPGD
         vtz+FbffFS/D3waAA6EB+uQ+keIXgRYw5iJpEtB6wbNB1T6ltcDX3zAKeattLIGULG5v
         4kLQ==
X-Gm-Message-State: AIkVDXKNWUapI7F7OsZvn3dzvwAnYldBkmBQkMH5BaQaOFyJq/S+uRFq1acOojOZjjDvH/Il
X-Received: by 10.99.237.69 with SMTP id m5mr117635395pgk.94.1483468995602;
        Tue, 03 Jan 2017 10:43:15 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id e5sm141421338pfd.77.2017.01.03.10.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 10:43:14 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v4 11/16] pathspec: create parse_short_magic function
Date:   Tue,  3 Jan 2017 10:42:36 -0800
Message-Id: <20170103184241.128409-12-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170103184241.128409-1-bmwill@google.com>
References: <1481670870-66754-1-git-send-email-bmwill@google.com>
 <20170103184241.128409-1-bmwill@google.com>
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
index f760f44f9..8574010d5 100644
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
2.11.0.390.gc69c2f50cf-goog

