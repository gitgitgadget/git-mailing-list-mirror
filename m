Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DFD820451
	for <e@80x24.org>; Tue, 13 Dec 2016 23:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752672AbcLMXXx (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 18:23:53 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33118 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751913AbcLMXXw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 18:23:52 -0500
Received: by mail-pg0-f45.google.com with SMTP id 3so868981pgd.0
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 15:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d+D35reW5UME0y1tumHmAdIWjIzT979pHXmiEqG1LQ0=;
        b=VkaeggXdXJ46nukdAgmHZGtLq0KaYtEJ5NBIjf4tp4xTWhnCpvpIFl+7jVFLxhtcG5
         haq3mnW73g5jKbUe9hpsAhgdBCJW+EDduA7KgqDVUGcnH3w0Yap6wW8QN1HaMi8VWaQq
         uXuURREStB8d+PsHahUfEhV0FMPZ/mmDShdnbEGj1ZmAN0RyP0VzhK8KGBqW3LD+1ZXx
         JE9cN9nvAOraxIiQCCc1UqJE4y6opr1BOdny80YDoPCRuo9wBvS9yEsJNPZnxNLbuRT7
         9vNkUIka/8qvzd7wW66cVBsr4UHsqnHQXrzp4qMWCay89VgkeJuTPJ5ywikJMm4ut3nB
         nofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d+D35reW5UME0y1tumHmAdIWjIzT979pHXmiEqG1LQ0=;
        b=lpJTw/DTstcAcqvanAl1B5lv0wiDvwcN/kpOe0cw8tmCzaKXoAjnD/9EghQ8WajM0V
         C/KIEz94BrfLOdgskbmDkk2lbrgnB2Jqbbecod4ifk7gMeD1ot6H4uZaLuR3oHYLCYBf
         B9CkxH2NRB3CUqqFfKQH9xd7yh9r+I0R4riYVMNyNWPPJHXPKeYyv14k9KbTMhs3rovg
         goiww46fiO5ct4yI6mDgcheayxsYpCuxRv7B6Axgr0gqrAskyb0HKryVbV2OhHagfupE
         UnwfgHtZZYr+sjYrlYkWT2emjB4KX0rPjIYvG58u+mJKcFuukvjiFKstJavmmc9ayrPk
         ujBQ==
X-Gm-Message-State: AKaTC00kvU0XGo4FB1VK85/NIzd+z0BTC6fE0TLiTV+mgJx/TiKsoT22ghUonp4zERxDDSfr
X-Received: by 10.99.23.69 with SMTP id 5mr60595974pgx.150.1481670896568;
        Tue, 13 Dec 2016 15:14:56 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id c15sm82308567pfd.36.2016.12.13.15.14.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 15:14:55 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v3 11/16] pathspec: create parse_short_magic function
Date:   Tue, 13 Dec 2016 15:14:25 -0800
Message-Id: <1481670870-66754-12-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481670870-66754-1-git-send-email-bmwill@google.com>
References: <1481223550-65277-1-git-send-email-bmwill@google.com>
 <1481670870-66754-1-git-send-email-bmwill@google.com>
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
index 10ce9c1..94ec201 100644
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

