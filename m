Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14CF71FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 18:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753767AbdFVSpF (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 14:45:05 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34359 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753657AbdFVSo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 14:44:27 -0400
Received: by mail-pg0-f50.google.com with SMTP id e187so11355746pgc.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 11:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3sraXUeRUzuDC7OyYltSl/KN0ZTZm+8T8rBqTtHKDVw=;
        b=Lb+mqXK8jtgJn9gX+AWhsnKdiiNvQIcCtKtmLbOwvRZTl70E6yt7FE9vsIZgZ/AQN/
         +fMgq9PNSsCb6OT5V25grJulkd9JB8SEjB3s4X65t4ojC3vSrWx4PUXGcXZjTFRxCAm6
         IXDB8Wocq8SLVlD1RDLQrQbmHrWjPREtXjvkuZWTDcutai45d5LUW+/jICKeOOwib6Nc
         uXTJ6uG4v0ss69VMJQSDWsYsdEftzLAHgncOBgIC40GlZnwvqYdydbjt51L+i8UzCAY0
         rbuwVX6r/z4SOpqhevP6nJfqHFaCan387hlT9ONBG1G5Cq/6EtEG5ell7Nii5+Qzx1jM
         JMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3sraXUeRUzuDC7OyYltSl/KN0ZTZm+8T8rBqTtHKDVw=;
        b=blEdB/TKjG5HV/ETs7+mxHA4FWs0NtBu3H+fZ6NEiEwBOXG/cTmLfl/Un2K7nxqwsw
         oU8laO+Sn9JlWbnkYBetnY+XMj2YBzABsPFBAd2AzR2gEWLKpwcrg59uiYYOmdFOf49K
         irkpyyEHgcce/n2RPkWwuY9SnuzepDLAw5c4uqji4s7PWCxaje80M9YjLBjEVOij2skR
         yoHwW8Jf3/7vQ8p/SHvLSx/0+phZew5txLnPfwFKoFNGcnOQxueR9ft40M7vhrTzbGh2
         fioEkO9y7a/anrvAViF0HD4YhKEf2wPKirr4OcmvE2KYKVBUjv9xTdcWimf+LgCx/cOd
         aPig==
X-Gm-Message-State: AKS2vOyaYPbv+AWUq03trQphDh+DT9h5dajq0tXbUcRpREGj8kjd0jY+
        sl3eA0MpMRW4iPAUOKfveA==
X-Received: by 10.98.73.205 with SMTP id r74mr4021747pfi.166.1498157061538;
        Thu, 22 Jun 2017 11:44:21 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id g78sm5222211pfb.122.2017.06.22.11.44.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 11:44:20 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 12/20] path: add repo_git_path and strbuf_repo_git_path
Date:   Thu, 22 Jun 2017 11:43:40 -0700
Message-Id: <20170622184348.56497-13-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.704.gde00cce3c-goog
In-Reply-To: <20170622184348.56497-1-bmwill@google.com>
References: <20170620191951.84791-1-bmwill@google.com>
 <20170622184348.56497-1-bmwill@google.com>
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
index 2bdd0044f..ffc0f10fd 100644
--- a/path.c
+++ b/path.c
@@ -416,6 +416,27 @@ static void do_git_path(const struct repository *repo,
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
2.13.1.704.gde00cce3c-goog

