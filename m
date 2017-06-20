Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D9C320D2B
	for <e@80x24.org>; Tue, 20 Jun 2017 19:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbdFTTUe (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 15:20:34 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34175 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbdFTTUb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 15:20:31 -0400
Received: by mail-pg0-f48.google.com with SMTP id e187so14378756pgc.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 12:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4nlYWum2/VcU0Kk4y/HKTnFUwzRXDV8FmBOCOj5QKyY=;
        b=C9gZRKaaIcMwI8UPNoQEn+gsNEyfzh+kiZBEIh19Rv0pKg6kfRRzL4H3vZHkN5Su+8
         7ExYq6BOwofXFAR1X1JW+qFObHthA0f6U+1wUD5hMukSZ7S/2YIN8O/32G5AHDCrkrP7
         RGHtGaDZ+zgVrf7Z5AC2Lu191wFGFFcEjuXg0ycYkXPoJQgWgxCLOTpsEL/2+XbCG7ll
         ecl1HxCAnIjNeWt7jVvKLTV9Fbc8gRusMGSQiyxH0Enb8Dw9g7Fbdp/3iUFQARLjL5Fx
         sDpZL6ecAC1ZRI1CS2ZFXea0Pd44edHJ5tsy1BOczKm9qjdib2b3FeoEHCxMGNqPYr4s
         YMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4nlYWum2/VcU0Kk4y/HKTnFUwzRXDV8FmBOCOj5QKyY=;
        b=ginpQzbvMVFU13xGMNwpQxOmBCiyJOaguzC7R9R0BNlHCfK+/4fy86j62s2kfXq/kc
         dCjpdiJgaTbCHA4OllcPg8RpESV1TaPuHD17O9fyIboH6+w3t93hdv5v562Qygw90mTm
         G+5QVKvK/lxkhaPiP41g47C5nitoQ6/2whBJqGeMpkXaxspItiwRW+Jvyd4nt5YXhufk
         OTaxGaBkWBpNIq9jr7A23FqnBhoOo8ewbvfxbQHKOb7/khMp8IGlFcIPQwZmQSuGsCc3
         X9BQTmSoacW6lvQhPQitAC85MCmGw4UxyiZZXyJM6+fQuOLSBBGFPggdu1AXnP0lpZ9k
         Qwvw==
X-Gm-Message-State: AKS2vOyykND5Nr7CMvV0cU4PrkG0saX8tc2aJwZ9q1qEjRHETukiMdNl
        ZJte2JaWaOBx4D4Y1Eo6pg==
X-Received: by 10.98.166.18 with SMTP id t18mr31923159pfe.66.1497986430771;
        Tue, 20 Jun 2017 12:20:30 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t6sm18680500pgs.33.2017.06.20.12.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 12:20:29 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 12/20] path: add repo_git_path and strbuf_repo_git_path
Date:   Tue, 20 Jun 2017 12:19:43 -0700
Message-Id: <20170620191951.84791-13-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <20170620191951.84791-1-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
 <20170620191951.84791-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce 'repo_git_path' and 'strbuf_repo_git_path' which take a
repository struct and constructs a path into the repository's git
directory.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 path.c | 21 +++++++++++++++++++++
 path.h |  8 ++++++++
 2 files changed, 29 insertions(+)

diff --git a/path.c b/path.c
index c6832a30e..3d223e0b2 100644
--- a/path.c
+++ b/path.c
@@ -422,6 +422,27 @@ static void do_git_path(const struct repository *repo,
 	strbuf_cleanup_path(buf);
 }
 
+char *repo_git_path(const struct repository *repo,
+		    const char *fmt, ...)
+{
+	struct strbuf path = STRBUF_INIT;
+	va_list args;
+	va_start(args, fmt);
+	do_git_path(repo, NULL, &path, fmt, args);
+	va_end(args);
+	return strbuf_detach(&path, NULL);
+}
+
+void strbuf_repo_git_path(struct strbuf *sb,
+			  const struct repository *repo,
+			  const char *fmt, ...)
+{
+	va_list args;
+	va_start(args, fmt);
+	do_git_path(repo, NULL, sb, fmt, args);
+	va_end(args);
+}
+
 char *git_path_buf(struct strbuf *buf, const char *fmt, ...)
 {
 	va_list args;
diff --git a/path.h b/path.h
index 568d63be5..c779c4aa2 100644
--- a/path.h
+++ b/path.h
@@ -35,6 +35,14 @@ extern char *mkpathdup(const char *fmt, ...)
 extern char *git_pathdup_submodule(const char *path, const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
+extern char *repo_git_path(const struct repository *repo,
+			   const char *fmt, ...)
+	__attribute__((format (printf, 2, 3)));
+extern void strbuf_repo_git_path(struct strbuf *sb,
+				 const struct repository *repo,
+				 const char *fmt, ...)
+	__attribute__((format (printf, 3, 4)));
+
 extern void report_linked_checkout_garbage(void);
 
 /*
-- 
2.13.1.611.g7e3b11ae1-goog

