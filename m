Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BC2A1F404
	for <e@80x24.org>; Sat, 24 Mar 2018 00:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751993AbeCXA4H (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 20:56:07 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:38473 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbeCXA4F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 20:56:05 -0400
Received: by mail-qk0-f195.google.com with SMTP id 132so14825055qkd.5
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 17:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=keJfkodfgbfXurqmbhAKw00ovigS9sH5Ec3xKDeDSAw=;
        b=Gjcg0ZmYKXKYnPHzdVLK0hJ2yTJcJ34FTSFqoCdSzzszBd2tsIs43FybmJKknQ1fI9
         w91LbSXN0FS1dIkkc3ihX31moQIwyaGmG2R7M/kfrdHVkfEnd/DoMAFEmqrllx+MBr20
         P3Yl8+NM6pxJr+FrvBtboU0haoTu3nAJkARxMFqcCpIh4nfXwkc2nt3lP9zeKi9fj7hZ
         mVqPquWI0T9qv9Rc3Km32cvhvmneIhdOxeg3TitE7P9IxyoM3E2RmsKwcD2yhWWjUxEF
         tJTarl4mxF+GvH/P69usPekt5kHuVxZkG/i1u8haXVEvg84VmsbXdjw7iLVFTmbWD9UN
         Js/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=keJfkodfgbfXurqmbhAKw00ovigS9sH5Ec3xKDeDSAw=;
        b=lZ1qJtvvj9t0TtlkcURD209JSee3AOJga4Em+fTQeTVLpGzPXIw+8PA1AX9QFuG0kz
         2548QD/Qaymh/n+pOYZhHlOxWGCCVUL9AQqkiLovSOk4gdXP2QdN2EKntJjlpsUVw/82
         nVtynUHNX48WUY3QcuEbAOi6pfqUg+CTg+wzxS4n2BpSgj7WNxBDsdmF0tBBLLPn1HdH
         p7DZJ/wPMtEcqDHxucMz4DsY5XD+rnP2lFYvjSQEbkR6fBYQNVJtaZMrWWUvmeyQ0DxY
         +YIBxH+n6wXOUqhbCEmHKrtJi+j5ImIdUBK6uKvu6i7N2S8+EFT3ImnflNmH6GCbzpZV
         DyWQ==
X-Gm-Message-State: AElRT7HeBMe93c4tGYUylzSTrNzBADQKCPldauh5RkHF+Rv/nW6pMUc/
        HAY+6LLHN+/6BVosidntjWJZpg==
X-Google-Smtp-Source: AG47ELs2y48Yf/3vLkq0acVKDulhFbuWN7c9g+nUqn/q+OKENqdMFcGnHENG0PHcI8TrpsColJZH2Q==
X-Received: by 10.55.123.197 with SMTP id w188mr44789740qkc.70.1521852964630;
        Fri, 23 Mar 2018 17:56:04 -0700 (PDT)
Received: from localhost (u-of-rochester-128-151-150-17.wireless.rochester.edu. [128.151.150.17])
        by smtp.gmail.com with ESMTPSA id a12sm7356043qtm.74.2018.03.23.17.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 17:56:03 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        sunshine@sunshineco.com
Subject: [PATCH v2 3/4] config.c: introduce 'git_config_color' to parse ANSI colors
Date:   Fri, 23 Mar 2018 20:55:55 -0400
Message-Id: <20180324005556.8145-4-me@ttaylorr.com>
X-Mailer: git-send-email 2.16.2.440.gc6284da4f
In-Reply-To: <20180324005556.8145-1-me@ttaylorr.com>
References: <20180306021729.45813-1-me@ttaylorr.com>
 <20180324005556.8145-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for adding `--color` to the `git-config(1)` builtin,
let's introduce a color parsing utility, `git_config_color` in a similar
fashion to `git_config_<type>`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 config.c | 10 ++++++++++
 config.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/config.c b/config.c
index b0c20e6cb..33366b52c 100644
--- a/config.c
+++ b/config.c
@@ -16,6 +16,7 @@
 #include "string-list.h"
 #include "utf8.h"
 #include "dir.h"
+#include "color.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -1000,6 +1001,15 @@ int git_config_expiry_date(timestamp_t *timestamp, const char *var, const char *
 	return 0;
 }
 
+int git_config_color(char *dest, const char *var, const char *value)
+{
+	if (!value)
+		return config_error_nonbool(var);
+	if (color_parse(value, dest) < 0)
+		return -1;
+	return 0;
+}
+
 static int git_default_core_config(const char *var, const char *value)
 {
 	/* This needs a better name */
diff --git a/config.h b/config.h
index ef70a9cac..0e060779d 100644
--- a/config.h
+++ b/config.h
@@ -59,6 +59,7 @@ extern int git_config_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
 extern int git_config_pathname(const char **, const char *, const char *);
 extern int git_config_expiry_date(timestamp_t *, const char *, const char *);
+extern int git_config_color(char *, const char *, const char *);
 extern int git_config_set_in_file_gently(const char *, const char *, const char *);
 extern void git_config_set_in_file(const char *, const char *, const char *);
 extern int git_config_set_gently(const char *, const char *);
-- 
2.16.2.440.gc6284da4f

