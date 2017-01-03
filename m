Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1D5F209BA
	for <e@80x24.org>; Tue,  3 Jan 2017 19:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934162AbdACTKI (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 14:10:08 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33631 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934067AbdACTKG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 14:10:06 -0500
Received: by mail-pg0-f53.google.com with SMTP id g1so178526401pgn.0
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 11:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jjIlCRP4rsCgXunhteRynwH0YSUm1SWHPtL/iJdnnu0=;
        b=L35gvwKhWaWxlUc6gkzRKkdX4t7f3LSLwAsslF/FK6UAvG7Pp7fj4GPzpHba1IARnz
         Yha/7L4thTjyU1N4dBL+b+cKxWVT/uaTup9oNxT3HF+2hdWZpdmtkqok2PHKPRP0+BOc
         XNRTzsRQ94WUzps8jQjeTIDyzPrXWfp7OOH0RkAp+11q3TioI5+qhSC6B20fVdk6Rch8
         qpj0sPPHLSQVpaA36VnAte++NNYDOExKn8mD+vuG+gHztoRcOxHvbXcJ36T/ShzLb5Rl
         eWbypeUXqu/dWHR16eGfUtBxcfL5Fu/haP8xh8ZpyoKqYPz5PuCaSPyNmvqi+UTDYv3P
         aV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jjIlCRP4rsCgXunhteRynwH0YSUm1SWHPtL/iJdnnu0=;
        b=WbLFj3hOs/h2h/iB/Bc70k6DcsbwQRz1bgQCViwRRhg+USzzHahgiqHv5RqwwLgWYY
         Z0+1xefOUVRbA+4a24Ri5W6ldrtEUczKDe+0GGRBb9qNiV+h7amPoZkl071GYg7aYWfg
         p1HYeYR1/jR+8xxiUbwfHNeshTaFl9rUpEkBgsEylBVFboSNoDbdeYeCh2OAUPaW1MQ3
         AyZW0OT4nITlngU8ZZFsFaynFw4tRD63939bPsy53n3rkmCSuflJ3TvSr/19KG1NPKBa
         LaiGZQMgCsnAvV/5p3XnsuLOq/DS7YRpFFQbzzhlWs27eag9Sxf7hvAcKZ33fKokKF3B
         H4LA==
X-Gm-Message-State: AIkVDXK/Q5Wnt8FEOg1LcjtpXNSLKnLgdCiLpyPsTeg5uPNfzVhgc0R2TJKDbUe7OnlXh2H4
X-Received: by 10.99.119.200 with SMTP id s191mr113898701pgc.172.1483470604877;
        Tue, 03 Jan 2017 11:10:04 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id q5sm66947112pgf.45.2017.01.03.11.10.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 11:10:03 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, tboegi@web.de, pclouds@gmail.com,
        larsxschneider@gmail.com
Subject: [PATCH v4 5/5] real_path: canonicalize directory separators in root parts
Date:   Tue,  3 Jan 2017 11:09:23 -0800
Message-Id: <20170103190923.11882-6-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170103190923.11882-1-bmwill@google.com>
References: <1481566615-75299-1-git-send-email-bmwill@google.com>
 <20170103190923.11882-1-bmwill@google.com>
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
index f4283f465..3562d17bf 100644
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
 #define MAXDEPTH 5
 
@@ -80,14 +93,10 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
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
@@ -95,7 +104,6 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 			else
 				goto error_out;
 		}
-		strbuf_addstr(&remaining, path);
 	}
 
 	/* Iterate over the remaining path components */
@@ -150,10 +158,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 
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

