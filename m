Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE1761F516
	for <e@80x24.org>; Sun,  1 Jul 2018 01:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752057AbeGABZP (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 21:25:15 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:39575 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbeGABZM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 21:25:12 -0400
Received: by mail-ot0-f195.google.com with SMTP id l15-v6so13847434oth.6
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 18:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nZ+63z2A69cC2bPhd4RGVwByNooKY92NcmhGnKgHhJo=;
        b=gJ5ywG1xPJtwdZ2rw9OUOrjhChzBJqMpXWC35kZasDIc4+W8BsId5jQgqZew1+mmQy
         vA0mwkOVYCUqRKfxApLG0cFO6bSGF+TqH8+kVoEz7wXrQP/zol0DuSgsBidP7SClfIfE
         BXup2cSKd+GLQl0rJXBBFOelu6T4tnt36l8ktlG+OrEhAZ/OUL2516VZkfiXdRhzQHoq
         cG7vq2ZspT1dHvWEaS7uYtn+q+mGPBOnJI7iw7eWVGKZFYPZYli5QJcCVmVJvF0cZXcj
         x3HH615hzrTYDObJ/UjGLyCnoU06U3ygU+bCHT1tMjuvBsBSwRKlO+FvfXNRiTeiV00+
         p+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nZ+63z2A69cC2bPhd4RGVwByNooKY92NcmhGnKgHhJo=;
        b=oc/yU9a5/CEWsPInFYIcAukOwV+479YKW25QuTW5dhbRUzNWssmEHnr6DHOIdXzKIr
         0C7lzQ81tZgbTqHLRnlSA7oU2dWokh6ff3uLkUyaB+t7vDCQfSzJoVaiiSb0iFAaaoZJ
         817K1gFjfnOKu3xi9nM8EkvgUFJQaMYS/4jYUufqootlMUl89aUWmW+chnH0fxnfwegN
         BeunuwlqRSAFrHL2s/qlRaS4FR9oPHu1QIh8Y6teMkM/WWb82BQ2CN3XV1kwernHb10v
         MXRHaaVUogZDw8xdP88Q/liVZdmOXSxWDE/e7CRlOfW0lcX/DItmr/+VfmdWYudvuec+
         YvIw==
X-Gm-Message-State: APt69E0vI0fhwQIrXxCNsF7qwGwSAg4U/+ebcWvW/zUstqrnYlfzK6Jy
        +GbXosYg2tTjo25J/YbeuStuhw==
X-Google-Smtp-Source: AAOMgpd6OpUg+1HcyZ5FuvQUWI9G/ASuZM91OPYz1zmOJONojbBhLLVYsqNIo6o+vt2iUCjifilYXQ==
X-Received: by 2002:a9d:5e84:: with SMTP id f4-v6mr11670473otl.74.1530408311754;
        Sat, 30 Jun 2018 18:25:11 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id g20-v6sm3509394ote.38.2018.06.30.18.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 18:25:11 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 1/9] read-cache.c: move index_has_changes() from merge.c
Date:   Sat, 30 Jun 2018 18:24:55 -0700
Message-Id: <20180701012503.14382-2-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.137.g2a11d05a6.dirty
In-Reply-To: <20180701012503.14382-1-newren@gmail.com>
References: <20180603065810.23841-1-newren@gmail.com>
 <20180701012503.14382-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since index_has_change() is an index-related function, move it to
read-cache.c, only modifying it to avoid uses of the active_cache and
active_nr macros.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge.c      | 31 -------------------------------
 read-cache.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/merge.c b/merge.c
index 078385873..e30e03fb8 100644
--- a/merge.c
+++ b/merge.c
@@ -14,37 +14,6 @@ static const char *merge_argument(struct commit *commit)
 	return oid_to_hex(commit ? &commit->object.oid : the_hash_algo->empty_tree);
 }
 
-int index_has_changes(struct strbuf *sb)
-{
-	struct object_id head;
-	int i;
-
-	if (!get_oid_tree("HEAD", &head)) {
-		struct diff_options opt;
-
-		diff_setup(&opt);
-		opt.flags.exit_with_status = 1;
-		if (!sb)
-			opt.flags.quick = 1;
-		do_diff_cache(&head, &opt);
-		diffcore_std(&opt);
-		for (i = 0; sb && i < diff_queued_diff.nr; i++) {
-			if (i)
-				strbuf_addch(sb, ' ');
-			strbuf_addstr(sb, diff_queued_diff.queue[i]->two->path);
-		}
-		diff_flush(&opt);
-		return opt.flags.has_changes != 0;
-	} else {
-		for (i = 0; sb && i < active_nr; i++) {
-			if (i)
-				strbuf_addch(sb, ' ');
-			strbuf_addstr(sb, active_cache[i]->name);
-		}
-		return !!active_nr;
-	}
-}
-
 int try_merge_command(const char *strategy, size_t xopts_nr,
 		      const char **xopts, struct commit_list *common,
 		      const char *head_arg, struct commit_list *remotes)
diff --git a/read-cache.c b/read-cache.c
index 372588260..5a9a93da3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -6,6 +6,8 @@
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
+#include "diff.h"
+#include "diffcore.h"
 #include "tempfile.h"
 #include "lockfile.h"
 #include "cache-tree.h"
@@ -1984,6 +1986,37 @@ int unmerged_index(const struct index_state *istate)
 	return 0;
 }
 
+int index_has_changes(struct strbuf *sb)
+{
+	struct object_id head;
+	int i;
+
+	if (!get_oid_tree("HEAD", &head)) {
+		struct diff_options opt;
+
+		diff_setup(&opt);
+		opt.flags.exit_with_status = 1;
+		if (!sb)
+			opt.flags.quick = 1;
+		do_diff_cache(&head, &opt);
+		diffcore_std(&opt);
+		for (i = 0; sb && i < diff_queued_diff.nr; i++) {
+			if (i)
+				strbuf_addch(sb, ' ');
+			strbuf_addstr(sb, diff_queued_diff.queue[i]->two->path);
+		}
+		diff_flush(&opt);
+		return opt.flags.has_changes != 0;
+	} else {
+		for (i = 0; sb && i < the_index.cache_nr; i++) {
+			if (i)
+				strbuf_addch(sb, ' ');
+			strbuf_addstr(sb, the_index.cache[i]->name);
+		}
+		return !!the_index.cache_nr;
+	}
+}
+
 #define WRITE_BUFFER_SIZE 8192
 static unsigned char write_buffer[WRITE_BUFFER_SIZE];
 static unsigned long write_buffer_len;
-- 
2.18.0.137.g2a11d05a6.dirty

