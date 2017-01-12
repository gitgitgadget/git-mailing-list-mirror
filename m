Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6BA51FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 23:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750979AbdALXz7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 18:55:59 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34103 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbdALXz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 18:55:26 -0500
Received: by mail-pf0-f178.google.com with SMTP id 127so20410499pfg.1
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 15:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uUCiDL5StgPmNqKHa3lEP79CiBcQCKb74ARCwIl3u2U=;
        b=uGP9zEStEslS8jKTda/BWplpnIRA4bJ0+Ooo6liBE53mi4HOQR4GJy9np7Lbhjk9jC
         Y9v1EtFK7VnP55gvqqb6vslEf9bcVhIq1rVkCumWnXk+OlNwZZRkGTxRr1ipurqrC9VV
         BNny1hwSBCd31TerAByrnx43umrGJ+2M0/6uYDwtiQ8fqoWTranvHqafh5bIk6Ngb+4r
         EVbUjCJp2b4LR/tV2jfxBSK0NAOHzac+WsgPJTTCK9RQ6StUV9R8O/8EPG6Hg+NOg4EW
         0YYCoEwLRL2oy0PQhU+kaZ7meWbnTVLdJ65e3fEL4uXn7l3kh+w6OxkpJIDf2IZ3wO/I
         6oHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uUCiDL5StgPmNqKHa3lEP79CiBcQCKb74ARCwIl3u2U=;
        b=b02+W46FMrSXepkKvLgrmpWC9uXg6tVtp6nIEXGwzJw30bOXXkoMgzHDuKPWC1A5Jk
         i1kJyazcPJQt50FvWKswpP9j77ZiPpI23xXCWYeUMgKhK9HhbZFJAOwGdQwQa27/DxCe
         cXgbkXW5vlc/rqA+j45jhN3yyjU66LCCE31fQpSDZo8dIq4/kUh+b/wiJacENwYG+qVg
         1BI/f1qMlMd2H/d16PTWfkfmPi4PlDcYLGz5utyLu+MAN0A4S1mCX8LOq9ZTQxlj7u5z
         I8h/jglok8NQiWlc5yoqGhQd5e5/bbDeLr830Q5iNkpNhtkPW3YodSrs+fdJA7+Qx6IQ
         fmHQ==
X-Gm-Message-State: AIkVDXJjqIaVWxAglSvzFdE5xhuMGqWYt6m5XNojw4BCSnmncwwb+886XoPGUtXZaUFjMNcf
X-Received: by 10.98.160.140 with SMTP id p12mr19224649pfl.97.1484265284535;
        Thu, 12 Jan 2017 15:54:44 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id e6sm24312192pgf.4.2017.01.12.15.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jan 2017 15:54:43 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        pclouds@gmail.com, sbeller@google.com
Subject: [PATCH 26/27] attr: push the bare repo check into read_attr()
Date:   Thu, 12 Jan 2017 15:53:53 -0800
Message-Id: <20170112235354.153403-27-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170112235354.153403-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Push the bare repository check into the 'read_attr()' function.  This
avoids needing to have extra logic which creates an empty stack frame
when inside a bare repo as a similar bit of logic already exists in the
'read_attr()' function.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/attr.c b/attr.c
index 78562592b..cbb07d25d 100644
--- a/attr.c
+++ b/attr.c
@@ -591,25 +591,29 @@ static struct attr_stack *read_attr_from_index(const char *path, int macro_ok)
 
 static struct attr_stack *read_attr(const char *path, int macro_ok)
 {
-	struct attr_stack *res;
+	struct attr_stack *res = NULL;
 
-	if (direction == GIT_ATTR_CHECKOUT) {
+	if (direction == GIT_ATTR_INDEX) {
 		res = read_attr_from_index(path, macro_ok);
-		if (!res)
-			res = read_attr_from_file(path, macro_ok);
-	}
-	else if (direction == GIT_ATTR_CHECKIN) {
-		res = read_attr_from_file(path, macro_ok);
-		if (!res)
-			/*
-			 * There is no checked out .gitattributes file there, but
-			 * we might have it in the index.  We allow operation in a
-			 * sparsely checked out work tree, so read from it.
-			 */
+	} else if (!is_bare_repository()) {
+		if (direction == GIT_ATTR_CHECKOUT) {
 			res = read_attr_from_index(path, macro_ok);
+			if (!res)
+				res = read_attr_from_file(path, macro_ok);
+		}
+		else if (direction == GIT_ATTR_CHECKIN) {
+			res = read_attr_from_file(path, macro_ok);
+			if (!res)
+				/*
+				 * There is no checked out .gitattributes file
+				 * there, but we might have it in the index.
+				 * We allow operation in a sparsely checked out
+				 * work tree, so read from it.
+				 */
+				res = read_attr_from_index(path, macro_ok);
+		}
 	}
-	else
-		res = read_attr_from_index(path, macro_ok);
+
 	if (!res)
 		res = xcalloc(1, sizeof(*res));
 	return res;
@@ -796,11 +800,7 @@ static const struct attr_stack *core_attr_stack(void)
 		}
 
 		/* root directory */
-		if (!is_bare_repository() || direction == GIT_ATTR_INDEX) {
-			e = read_attr(GITATTRIBUTES_FILE, 1);
-		} else {
-			e = xcalloc(1, sizeof(struct attr_stack));
-		}
+		e = read_attr(GITATTRIBUTES_FILE, 1);
 		key = "";
 		push_stack(&core, e, key, strlen(key));
 	}
-- 
2.11.0.390.gc69c2f50cf-goog

