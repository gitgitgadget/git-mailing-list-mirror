Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 246C920756
	for <e@80x24.org>; Wed,  4 Jan 2017 22:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968486AbdADWBt (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 17:01:49 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34888 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968460AbdADWBl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 17:01:41 -0500
Received: by mail-pg0-f51.google.com with SMTP id i5so166907352pgh.2
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 14:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6Q79Mt8fzK5GxQqTapfqg8aacxWMJzP08rIS1LLhaEc=;
        b=iZ1WzcpkiWLIp5oSJQtf3ixJ0MAzK9bXDsQ6bdE9XbEiWOXQVColFUi8yC6FWctkUN
         JKRNYiK9iA2/nlgMdBDxVM45oFgmO6lEABVsjDtw3gcdEIdhTIwPF4RgalsnKqHp16+w
         VS+pzeZB519xeTVmM7H6S4Ti/TANLkK0eqRPLq1sHFqfwGCN/sgVEeNxnX7NTakLjm09
         Q4PhczaU+5CG/k/txxO3H/tLNksz+UsN4pyg1D+3TLZHWEIGcQJxJayty3xlhRdxaIPb
         EjcUNPUvDIumQWNAYzEjF9uNKTlYR7NO9/d7z6JnFbfXXLR3S6ImHFerNcrbouCqkxWX
         MaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6Q79Mt8fzK5GxQqTapfqg8aacxWMJzP08rIS1LLhaEc=;
        b=I/HRCF2nCYjmYEF1ErGHhXmtjYMiLLQ6ePDh/nEQSgD4jAlVHeA0IwLVn3kUCMDehT
         Khp4RvlWpU5mGxE63XF13xqQgm5QFxUGWONPXB3L3pHSgx1lzyaj7Zd/l3y0aN037jYo
         8qy7h1GzI4Qx4pfJG5l/pHK8w6N6a6nioLTnWBUVqaTScHJYF+TycInKp5ijTGE5VxXy
         vWxJC7omo6ZVYFQtTRqOUHJXkJuJHtB5IKJ7LMGdjPgR1Wl5TpEoLaE9qX7HCiBCLiqj
         wPL0qTU9XB8/4eXHnOLRK+zxvRencznMqy2qbCSTJ5F4fcyEeBG08839S1oBO1fislnr
         YdJQ==
X-Gm-Message-State: AIkVDXKSHc39DQI46iVgJWcUihDclphvdDtAF4byvxtXYAyeyygeBNTlXBBdpLHVmdz4afvw
X-Received: by 10.99.227.81 with SMTP id o17mr128006648pgj.69.1483567300289;
        Wed, 04 Jan 2017 14:01:40 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id n29sm550351pfg.80.2017.01.04.14.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 14:01:39 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, tboegi@web.de, pclouds@gmail.com,
        larsxschneider@gmail.com
Subject: [PATCH v5 5/5] real_path: canonicalize directory separators in root parts
Date:   Wed,  4 Jan 2017 14:01:24 -0800
Message-Id: <20170104220124.145808-6-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170104220124.145808-1-bmwill@google.com>
References: <20170103190923.11882-1-bmwill@google.com>
 <20170104220124.145808-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Sixt <j6t@kdbg.org>

When an absolute path is resolved, resolution begins at the first path
component after the root part. The root part is just copied verbatim,
because it must not be inspected for symbolic links. For POSIX paths,
this is just the initial slash, but on Windows, the root part has the
forms c:\ or \\server\share. We do want to canonicalize the back-slashes
in the root part because these parts are compared to the result of
getcwd(), which does return a fully canonicalized path.

Factor out a helper that splits off the root part, and have it
canonicalize the copied part.

This change was prompted because t1504-ceiling-dirs.sh caught a breakage
in GIT_CEILING_DIRECTORIES handling on Windows.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 abspath.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/abspath.c b/abspath.c
index 72f716f80..fce40fddc 100644
--- a/abspath.c
+++ b/abspath.c
@@ -48,6 +48,19 @@ static void get_next_component(struct strbuf *next, struct strbuf *remaining)
 	strbuf_remove(remaining, 0, end - remaining->buf);
 }
 
+/* copies root part from remaining to resolved, canonicalizing it on the way */
+static void get_root_part(struct strbuf *resolved, struct strbuf *remaining)
+{
+	int offset = offset_1st_component(remaining->buf);
+
+	strbuf_reset(resolved);
+	strbuf_add(resolved, remaining->buf, offset);
+#ifdef GIT_WINDOWS_NATIVE
+	convert_slashes(resolved->buf);
+#endif
+	strbuf_remove(remaining, 0, offset);
+}
+
 /* We allow "recursive" symbolic links. Only within reason, though. */
 #ifndef MAXSYMLINKS
 #define MAXSYMLINKS 32
@@ -82,14 +95,10 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 			goto error_out;
 	}
 
-	strbuf_reset(resolved);
+	strbuf_addstr(&remaining, path);
+	get_root_part(resolved, &remaining);
 
-	if (is_absolute_path(path)) {
-		/* absolute path; start with only root as being resolved */
-		int offset = offset_1st_component(path);
-		strbuf_add(resolved, path, offset);
-		strbuf_addstr(&remaining, path + offset);
-	} else {
+	if (!resolved->len) {
 		/* relative path; can use CWD as the initial resolved path */
 		if (strbuf_getcwd(resolved)) {
 			if (die_on_error)
@@ -97,7 +106,6 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 			else
 				goto error_out;
 		}
-		strbuf_addstr(&remaining, path);
 	}
 
 	/* Iterate over the remaining path components */
@@ -154,10 +162,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 
 			if (is_absolute_path(symlink.buf)) {
 				/* absolute symlink; set resolved to root */
-				int offset = offset_1st_component(symlink.buf);
-				strbuf_reset(resolved);
-				strbuf_add(resolved, symlink.buf, offset);
-				strbuf_remove(&symlink, 0, offset);
+				get_root_part(resolved, &symlink);
 			} else {
 				/*
 				 * relative symlink
-- 
2.11.0.390.gc69c2f50cf-goog

