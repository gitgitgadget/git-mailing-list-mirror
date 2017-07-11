Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF1EE202AC
	for <e@80x24.org>; Tue, 11 Jul 2017 14:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932806AbdGKOMy (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 10:12:54 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34680 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932802AbdGKOMx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 10:12:53 -0400
Received: by mail-pg0-f68.google.com with SMTP id j186so95612pge.1
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AgbVbPI11ARhBh+zm3MFjE3S+K/AgPuwCcTHSObLn4Y=;
        b=gpq4ngmmZE2LRN1Hv6ou2i3HqNHkLc4ts1QNZUEghVIZTCPzqMHWzS4jEgNjV6pLu7
         x+Sm39ixp2DV2cPM0quovjZOspNnMA8+Kj5ce1bI5vf9CrdL4JaE/+DhD9ShDnWnxT5Y
         3kjwkBcO1wPn1kI2irhMx7LcpRuwsy8G9NgIn65Gh/YlGEU4Sv2ZRkgiQNwvAXgcPpJP
         5lcwwLVamUzAAZU7SCME2hZYAYaSFBGDvCznSZkXahVOyDNiLLz6RElvLXcy31jxnlBV
         N0ZSMow3RbVo/RmCy4Glx0J8IpExbP5MbSU+fGKgIc4RRFmvKBRfDwJfM7c9Qs4j5bk5
         zUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AgbVbPI11ARhBh+zm3MFjE3S+K/AgPuwCcTHSObLn4Y=;
        b=S/L0rpi4xNwE7L7AeB0fq18NgstyInRWxsEYm7sjuf+OIFfMR1GsM5MFeS0gfPzZD5
         5BNbayu+2/s0wwKqfEZ8Lio/ZAE0zMswI/PZugBshzdJX2xvR1Jf+3raAnoF3ObVS/gk
         Qg5kido9ldfNTzAMxpK6zYfAtaJNGlyy7xj62KRvTTYDpEOA5yqNZuENZt5qXPu2JnQ3
         5GJMLEm3u3DEEqTA8JW8P8SFImWQ2SFN4w+DeZ5Gx/sIT+tI1ucyQWtMXRcIarjMDRnZ
         YcjRez+bduZAwIkNngVAZLLRzX73VfPIH8/ZRepK9lyDxo8kHwteZaqYDhSBxSi9A5H8
         bj1Q==
X-Gm-Message-State: AIVw111W2a3+NPhrbLzkl8x/07S1RW4VDfEfLqgeLeJyTyoqbS+zbhx1
        I0kGOpgNLULTpRMOi1E=
X-Received: by 10.98.17.84 with SMTP id z81mr50688505pfi.38.1499782372769;
        Tue, 11 Jul 2017 07:12:52 -0700 (PDT)
Received: from localhost.localdomain ([117.249.145.113])
        by smtp.gmail.com with ESMTPSA id r1sm89521pgo.42.2017.07.11.07.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jul 2017 07:12:52 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, me@ikke.info
Subject: [PATCH] commit & merge: modularize the empty message validator
Date:   Tue, 11 Jul 2017 19:42:54 +0530
Message-Id: <20170711141254.7747-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.13.2.957.g457671ade
In-Reply-To: <20170706044640.GA11020@alpha.vpn.ikke.info>
References: <20170706044640.GA11020@alpha.vpn.ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the context of "git merge" the meaning of an "empty message"
is one that contains no line of text. This is not in line with
"git commit" where an "empty message" is one that contains only
whitespaces and/or signed-off-by lines. This could cause surprises
to users who are accustomed to the meaning of an "empty message"
of "git commit".

Prevent such surprises by ensuring the meaning of an empty 'merge
message' to be in line with that of an empty 'commit message'. This
is done by separating the empty message validator from 'commit' and
making it stand-alone.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 I have made an attempt to solve the issue by separating the concerned
 function as I found no reason against it.

 I've tried to name them with what felt appropriate and concise to me.
 Let me know if it's alright.
 
 Makefile            |  1 +
 builtin/commit.c    | 39 +++++----------------------------------
 builtin/merge.c     |  3 ++-
 message-validator.c | 34 ++++++++++++++++++++++++++++++++++
 message-validator.h |  6 ++++++
 5 files changed, 48 insertions(+), 35 deletions(-)
 create mode 100644 message-validator.c
 create mode 100644 message-validator.h

diff --git a/Makefile b/Makefile
index ffa6da71b..c1c26e434 100644
--- a/Makefile
+++ b/Makefile
@@ -783,6 +783,7 @@ LIB_OBJS += merge.o
 LIB_OBJS += merge-blobs.o
 LIB_OBJS += merge-recursive.o
 LIB_OBJS += mergesort.o
+LIB_OBJS += message-validator.o
 LIB_OBJS += mru.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += notes.o
diff --git a/builtin/commit.c b/builtin/commit.c
index 8d1cac062..4c3112bb4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -33,6 +33,7 @@
 #include "notes-utils.h"
 #include "mailmap.h"
 #include "sigchain.h"
+#include "message-validator.h"
 
 static const char * const builtin_commit_usage[] = {
 	N_("git commit [<options>] [--] <pathspec>..."),
@@ -979,41 +980,11 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	return 1;
 }
 
-static int rest_is_empty(struct strbuf *sb, int start)
-{
-	int i, eol;
-	const char *nl;
-
-	/* Check if the rest is just whitespace and Signed-of-by's. */
-	for (i = start; i < sb->len; i++) {
-		nl = memchr(sb->buf + i, '\n', sb->len - i);
-		if (nl)
-			eol = nl - sb->buf;
-		else
-			eol = sb->len;
-
-		if (strlen(sign_off_header) <= eol - i &&
-		    starts_with(sb->buf + i, sign_off_header)) {
-			i = eol;
-			continue;
-		}
-		while (i < eol)
-			if (!isspace(sb->buf[i++]))
-				return 0;
-	}
-
-	return 1;
-}
-
-/*
- * Find out if the message in the strbuf contains only whitespace and
- * Signed-off-by lines.
- */
-static int message_is_empty(struct strbuf *sb)
+static int is_empty(struct strbuf *sb)
 {
 	if (cleanup_mode == CLEANUP_NONE && sb->len)
 		return 0;
-	return rest_is_empty(sb, 0);
+	return message_is_empty(sb, 0);
 }
 
 /*
@@ -1035,7 +1006,7 @@ static int template_untouched(struct strbuf *sb)
 	if (!skip_prefix(sb->buf, tmpl.buf, &start))
 		start = sb->buf;
 	strbuf_release(&tmpl);
-	return rest_is_empty(sb, start - sb->buf);
+	return message_is_empty(sb, start - sb->buf);
 }
 
 static const char *find_author_by_nickname(const char *name)
@@ -1744,7 +1715,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		fprintf(stderr, _("Aborting commit; you did not edit the message.\n"));
 		exit(1);
 	}
-	if (message_is_empty(&sb) && !allow_empty_message) {
+	if (is_empty(&sb) && !allow_empty_message) {
 		rollback_index_files();
 		fprintf(stderr, _("Aborting commit due to empty commit message.\n"));
 		exit(1);
diff --git a/builtin/merge.c b/builtin/merge.c
index 703827f00..625cfb848 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -31,6 +31,7 @@
 #include "gpg-interface.h"
 #include "sequencer.h"
 #include "string-list.h"
+#include "message-validator.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -772,7 +773,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	}
 	read_merge_msg(&msg);
 	strbuf_stripspace(&msg, 0 < option_edit);
-	if (!msg.len)
+	if (!msg.len || message_is_empty(&msg, 0))
 		abort_commit(remoteheads, _("Empty commit message."));
 	strbuf_release(&merge_msg);
 	strbuf_addbuf(&merge_msg, &msg);
diff --git a/message-validator.c b/message-validator.c
new file mode 100644
index 000000000..32feb4e26
--- /dev/null
+++ b/message-validator.c
@@ -0,0 +1,34 @@
+#include "git-compat-util.h"
+#include "sequencer.h"
+#include "strbuf.h"
+#include "message-validator.h"
+
+/*
+ * Find out if the message in the strbuf contains only whitespace and
+ * Signed-off-by lines.
+ */
+int message_is_empty(struct strbuf *sb, int start)
+{
+	int i, eol;
+	const char *nl;
+
+	/* Check if the rest is just whitespace and Signed-of-by's. */
+	for (i = start; i < sb->len; i++) {
+		nl = memchr(sb->buf + i, '\n', sb->len - i);
+		if (nl)
+			eol = nl - sb->buf;
+		else
+			eol = sb->len;
+
+		if (strlen(sign_off_header) <= eol - i &&
+		    starts_with(sb->buf + i, sign_off_header)) {
+			i = eol;
+			continue;
+		}
+		while (i < eol)
+			if (!isspace(sb->buf[i++]))
+				return 0;
+	}
+
+	return 1;
+}
diff --git a/message-validator.h b/message-validator.h
new file mode 100644
index 000000000..4caea499c
--- /dev/null
+++ b/message-validator.h
@@ -0,0 +1,6 @@
+#ifndef MESSAGE_VALIDATOR_H
+#define MESSAGE_VALIDATOR_H
+
+extern int message_is_empty(struct strbuf *sb, int start);
+
+#endif
-- 
2.13.2.957.g457671ade

