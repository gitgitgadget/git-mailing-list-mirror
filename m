Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A66F11F404
	for <e@80x24.org>; Thu, 29 Mar 2018 01:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbeC2BQo (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 21:16:44 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42188 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbeC2BQm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 21:16:42 -0400
Received: by mail-pg0-f66.google.com with SMTP id f10so1988673pgs.9
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 18:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=keJfkodfgbfXurqmbhAKw00ovigS9sH5Ec3xKDeDSAw=;
        b=oEs5wG3ywySWLFPtTLe9U9qHEh6eeZYI1/CudIJtqJQj7Hp5q9SIdz3TA4412CyACR
         fFfB/g2jFqocq4LsM3XV+gRJn9PkgHV30lvkFXerxFAfQ3en488Nk2KRBDJW7MuXpvyD
         sjE7iby6h/Zo9ZBc8GTpSRU+MvgUPlWfhxKyV9cOtSPvBm0G41QDMB8ehYtr2RgE/JmP
         5DN98RePP/LDAdaJofCpDQZPerDKyTF81KeaFt+S8VOxYgj/UNlUkEJccyMRfbONjT+A
         RU0cG7WfZ1tu0Xuomb7la9wrgi5ZNngbNKbhYtrkaFCnr3J6b085KCjV+ZmVAHk2v8E3
         ZEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=keJfkodfgbfXurqmbhAKw00ovigS9sH5Ec3xKDeDSAw=;
        b=DbLJ8spUvUU5ou7lZ/1Wnryjl3fLJ+I1DthKLG9TeLmgFGwP7L9J/R3E4CxyNLB8rd
         eidh7nOqad0GJdbxgoshBdF7tJy2QeLjA9Uh9YKFzCkle712a478sec6pHHGpFKQucsZ
         M43I80lzXdrAlpYuyW7SFzrRxioj+I9mky6cuphoORwEhkWz3h20VD7iHJDJx3nuM0Af
         x3PmDil6CmhtHtWk4VbkmYXKVFC30aqNa8sSBTH9WReW3CQr4h4J2YeKhC9vY0hmyE2e
         xtxF/IEUtR2aIjPdTMPz+PmvwXGJu1xhtJZuRDiQCUF7cU1Zy2nO5PWj0ocHrQYTzYJd
         LGVg==
X-Gm-Message-State: AElRT7F0eCMg0XK+lz/o/t4RkQZXIjAVtvp4T+2ediu5cZaqs3k/LNoE
        e3L/r61ChhVMaRM79lZ8DPQY2deQovI=
X-Google-Smtp-Source: AIpwx490bD4mKqqjoFaVSSf4FAbnQDjZb7mRLac1o34MtNQdSebsAbKvbXNkp2MF3BL2Ilx4syyGUw==
X-Received: by 2002:a17:902:9a82:: with SMTP id w2-v6mr413940plp.6.1522286201706;
        Wed, 28 Mar 2018 18:16:41 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:ec10:419d:d341:c920])
        by smtp.gmail.com with ESMTPSA id z79sm10579171pfa.139.2018.03.28.18.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 18:16:40 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     peff@peff.net, gitster@pobox.com
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 2/3] config.c: introduce 'git_config_color' to parse ANSI colors
Date:   Wed, 28 Mar 2018 18:16:33 -0700
Message-Id: <20180329011634.68582-3-me@ttaylorr.com>
X-Mailer: git-send-email 2.16.2.440.gc6284da4f
In-Reply-To: <20180329011634.68582-1-me@ttaylorr.com>
References: <20180324005556.8145-1-me@ttaylorr.com>
 <20180329011634.68582-1-me@ttaylorr.com>
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

