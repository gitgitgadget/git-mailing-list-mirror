Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 265F51FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 21:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbcLFVxj (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 16:53:39 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35594 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751892AbcLFVxN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 16:53:13 -0500
Received: by mail-pg0-f51.google.com with SMTP id p66so153556694pga.2
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 13:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OKnWHv+cYfKOIDH6x9KhuY9TUPX4Q3oPVD7lI83S+kg=;
        b=QaW1zu9UHRLvruU3Z+ruR2buJRnCABoPJQH6uHqb9L/l/cHo5xPCzAe1oC59NUgM4L
         uCwldzxBZPdq93NATbop0T8WDjW47WCgnp5s61cr85aLqOfKLHyEGvQUz/3vdHh7OWmY
         WKO0dFAaEeFheO5o4i9xGbdR1ql9Rvc5Clmyl1jzgTWb/ulq7AdHUAHN6Gbo0DNT/aUK
         OMXOzzNg0gYQ5VINq6xW0CRk49QvG8TGQ144CSbsQ62xcZol0jAGsVbsEA8zIkIYvLL6
         Z2xtaV9bCZr5pICCjA+oZsWpe4DYCnaxiC0aV0GRJF/ldvrIvrqtCMydfxSHo1kY9AvQ
         A6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OKnWHv+cYfKOIDH6x9KhuY9TUPX4Q3oPVD7lI83S+kg=;
        b=UesajUeKneruvfDr002ctTvNynVr+uzFENenjTnT/wJ03zuA4a4C3cIKzAY1yR9ORe
         9teZrKg2JoCzCk1WVAVbbuJvlr0mQOIObI0BD3yNsWG7Ir4xdfSNaOuk9ZXaZXSXzmeM
         suU8GMP1YbhS7oPBVCY94YCi8tH+00yHuFpPd8fqLi5RpaCuWvv63e2lKDDZNaf5jp1D
         JfYD6UrV4Xldc1CT42H2pm1lNFMenMM6oTXbBCN8aeabHo8NNYonf4rh5fd5DTN+K4r0
         uu6Ufr9WACFQzBUOnhWF0eZZy3YenxaqKpxIproyrYhzwnfWG0/t1sBFignagJq/62JT
         yqlQ==
X-Gm-Message-State: AKaTC00cgMgsC9Aye7ZyGkewkqli7KpgDk8+X9yYPBlaM4Sb9XXuI0Fvd0BmwiiJeACr8FRt
X-Received: by 10.84.194.195 with SMTP id h61mr139628980pld.95.1481061153315;
        Tue, 06 Dec 2016 13:52:33 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id y89sm36940228pfk.83.2016.12.06.13.52.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Dec 2016 13:52:32 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 12/17] pathspec: create parse_short_magic function
Date:   Tue,  6 Dec 2016 13:51:41 -0800
Message-Id: <1481061106-117775-13-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481061106-117775-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
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
index 08e76f6..d4d4839 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -156,6 +156,41 @@ static int get_global_magic(int element_magic)
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
@@ -220,24 +255,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
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

