Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6173820451
	for <e@80x24.org>; Tue, 13 Dec 2016 23:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbcLMXVH (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 18:21:07 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33745 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbcLMXVG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 18:21:06 -0500
Received: by mail-pf0-f180.google.com with SMTP id d2so338371pfd.0
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 15:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d8vsGxvT2+9kvqsa8WTLPabtEBqXR9i6/dGNfz4S1jc=;
        b=VoG6BP4ok0jCFHf49+SkJbaYhcj3dFapQ/mmNm38S0hiRnJmg8Maxunl/r47q2fUXC
         V1r4VtxVh13bzV51XDmYSbvGK3mOcstG7N0a33gLBKDu19Mfb+03qfSXMDToPvnJw9aS
         GcB7fXJFd1QEYhvgpcHzGUNS2Tr1PwJGr3exzSdq4Qdl/DhcY+3HIeoSdtTIqCm7qWXJ
         DLBpR8UpjVBvJFHUFkGKGTMSzBaThCLaGxZ6G6KvR0DPAMbtLFKOFTKUjqibNJLNuWbt
         vYXYh8HXokZGQFYYTa80oBLL9D/TaaKVyZ8uszhKwgzpvp1RbKxelAgVRcGFiiXc+ANe
         9gUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d8vsGxvT2+9kvqsa8WTLPabtEBqXR9i6/dGNfz4S1jc=;
        b=HKtfwsBcxymQJ8fVGkky6GKWSso1UuQeC/1esttf2d6t6lBXuoG98yEKnxPegHmk7Z
         1N39mFA9VaOQaSHZXrJzqyaIqMHORjw2zWSVfXO3VTc+EvfblZVxYjLVkFmN1dtI5hZ6
         UDPTHQNgx4JWefjlUITmiGU51C6fgLXm22KI0YQFRFxcepsg4NOWvs/rQ7p2UqB0imeG
         m2CgNg6+Ilrn4OBxQwJZxchkX0fPZaj9amlJxe0Y0vCH6P5EwbJ6lNYvuHW/t+G41e3r
         rgCI6n4Z5PBdkFWmXKta7xZFCfe5WQ0PuLhfaaoWKUrrIXLO0PWQlerMXtjIEyErEdJv
         AdtA==
X-Gm-Message-State: AKaTC03UzUL+Qy/OO8+/7O2VWoztufDPhb8NEJOb/xYm6SlqX0V1D/EqAJQFUyWPOElmv9Oy
X-Received: by 10.99.119.71 with SMTP id s68mr180919801pgc.11.1481670899854;
        Tue, 13 Dec 2016 15:14:59 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id c15sm82308567pfd.36.2016.12.13.15.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 15:14:58 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v3 13/16] pathspec: create parse_element_magic helper
Date:   Tue, 13 Dec 2016 15:14:27 -0800
Message-Id: <1481670870-66754-14-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481670870-66754-1-git-send-email-bmwill@google.com>
References: <1481223550-65277-1-git-send-email-bmwill@google.com>
 <1481670870-66754-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out the logic responsible for the magic in a pathspec element
into its own function.

Also avoid calling into the parsing functions when
`PATHSPEC_LITERAL_PATH` is specified since it causes magic to be
ignored and all paths to be treated as literals.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index c77be17..a0fec49 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -245,6 +245,19 @@ static const char *parse_short_magic(unsigned *magic, const char *elem)
 	return pos;
 }
 
+static const char *parse_element_magic(unsigned *magic, int *prefix_len,
+				       const char *elem)
+{
+	if (elem[0] != ':' || get_literal_global())
+		return elem; /* nothing to do */
+	else if (elem[1] == '(')
+		/* longhand */
+		return parse_long_magic(magic, prefix_len, elem);
+	else
+		/* shorthand */
+		return parse_short_magic(magic, elem);
+}
+
 /*
  * Take an element of a pathspec and check for magic signatures.
  * Append the result to the prefix. Return the magic bitmap.
@@ -267,26 +280,16 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 	char *match;
 	int i, pathspec_prefix = -1;
 
-	if (elt[0] != ':' || get_literal_global() ||
-	    (flags & PATHSPEC_LITERAL_PATH)) {
-		; /* nothing to do */
-	} else if (elt[1] == '(') {
-		/* longhand */
-		copyfrom = parse_long_magic(&element_magic,
-					    &pathspec_prefix,
-					    elt);
-	} else {
-		/* shorthand */
-		copyfrom = parse_short_magic(&element_magic, elt);
-	}
-
-	magic |= element_magic;
-
 	/* PATHSPEC_LITERAL_PATH ignores magic */
-	if (flags & PATHSPEC_LITERAL_PATH)
+	if (flags & PATHSPEC_LITERAL_PATH) {
 		magic = PATHSPEC_LITERAL;
-	else
+	} else {
+		copyfrom = parse_element_magic(&element_magic,
+					       &pathspec_prefix,
+					       elt);
+		magic |= element_magic;
 		magic |= get_global_magic(element_magic);
+	}
 
 	if (pathspec_prefix >= 0 &&
 	    (prefixlen || (prefix && *prefix)))
-- 
2.8.0.rc3.226.g39d4020

