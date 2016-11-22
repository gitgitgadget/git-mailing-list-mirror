Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E4CD1FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 18:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756099AbcKVSrw (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 13:47:52 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33512 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755786AbcKVSro (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 13:47:44 -0500
Received: by mail-pg0-f44.google.com with SMTP id 3so10249777pgd.0
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 10:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+/IT5Ac+yvGgSA/i8P7uoRqoVK1Y957kVHQYraF7wq4=;
        b=aw3f+JBsZz1oEt6FtgwGVSsurjqYdww8ExwN6Od8Ex2uzqERip0g0wJUwwL9wzPM9R
         aud1Qlu4d78AR1H2VIn+FO82NrUeXDXuI/tLUVcv+hmnKT22v+PfhTklgr3j1Yh0Hr7P
         pMXvNEccUIVzceTpYyio9KifIGLAuNnS6A0LJsQ24FQTzXw1N8xLhgm5LXhXsk2ODMal
         JMpQvqALGnJiv3qYIrhpGdotk8hebXHP1URJQ/6h/XDJuL4s8BGLlhOJBR4hJ4BL3fJz
         egVXDhbFflfiDqAgY9YoK2QTIYqp4NqS6hKdLW1RcENmliWoITYP0yMRla4Iff9SNmyX
         rwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+/IT5Ac+yvGgSA/i8P7uoRqoVK1Y957kVHQYraF7wq4=;
        b=mG4xhaaoMzqLWuGkD0x1ebc3pl3bYK5GFJ+uRp+Se01fLlJCdVuT4Jns1DDYEdtWg4
         Hg0vie/NDJ/hTwgyJmJCjaN/3XDtUaUGIA0FknOjM89oeARQ4vEwX5NPl8Rv4gjgNEO1
         ozF3qF0RVP6QcPdIbMNZm0H6aNe892gNdc7GkH3nBPRpd+510Ps9VVffpCve32ujeQj5
         W7iE2YUBzAvluvd5iu9U/MMGjVdTnKu8b9UeKVddjbSYipvwS62UrPkidRkn+fq7lCWY
         2gyLarY5fVwgWx3n30OFD9+V3TInbMzowWuJESONm8+5+PkFtDHtRpGz+ZbWV/WmwxLf
         glDw==
X-Gm-Message-State: AKaTC01CBi1P5mV6NhrEho/4dhcY4zIA6nYPYlNjeI5woQrwkf1aEBdG233rkqbVVKgdua82
X-Received: by 10.84.216.25 with SMTP id m25mr2455365pli.117.1479840409011;
        Tue, 22 Nov 2016 10:46:49 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id w5sm46932072pfl.31.2016.11.22.10.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Nov 2016 10:46:48 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH v5 2/6] submodules: load gitmodules file from commit sha1
Date:   Tue, 22 Nov 2016 10:46:33 -0800
Message-Id: <1479840397-68264-3-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1479840397-68264-1-git-send-email-bmwill@google.com>
References: <1479499135-64269-1-git-send-email-bmwill@google.com>
 <1479840397-68264-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

teach submodules to load a '.gitmodules' file from a commit sha1.  This
enables the population of the submodule_cache to be based on the state
of the '.gitmodules' file from a particular commit.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 cache.h            |  2 ++
 config.c           |  8 ++++----
 submodule-config.c |  6 +++---
 submodule-config.h |  3 +++
 submodule.c        | 12 ++++++++++++
 submodule.h        |  1 +
 6 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 1be6526..559a461 100644
--- a/cache.h
+++ b/cache.h
@@ -1690,6 +1690,8 @@ extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
 extern int git_config_from_mem(config_fn_t fn, const enum config_origin_type,
 					const char *name, const char *buf, size_t len, void *data);
+extern int git_config_from_blob_sha1(config_fn_t fn, const char *name,
+				     const unsigned char *sha1, void *data);
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
 extern void git_config(config_fn_t fn, void *);
diff --git a/config.c b/config.c
index 83fdecb..4d78e72 100644
--- a/config.c
+++ b/config.c
@@ -1214,10 +1214,10 @@ int git_config_from_mem(config_fn_t fn, const enum config_origin_type origin_typ
 	return do_config_from(&top, fn, data);
 }
 
-static int git_config_from_blob_sha1(config_fn_t fn,
-				     const char *name,
-				     const unsigned char *sha1,
-				     void *data)
+int git_config_from_blob_sha1(config_fn_t fn,
+			      const char *name,
+			      const unsigned char *sha1,
+			      void *data)
 {
 	enum object_type type;
 	char *buf;
diff --git a/submodule-config.c b/submodule-config.c
index 098085b..8b9a2ef 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -379,9 +379,9 @@ static int parse_config(const char *var, const char *value, void *data)
 	return ret;
 }
 
-static int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
-				      unsigned char *gitmodules_sha1,
-				      struct strbuf *rev)
+int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
+			       unsigned char *gitmodules_sha1,
+			       struct strbuf *rev)
 {
 	int ret = 0;
 
diff --git a/submodule-config.h b/submodule-config.h
index d05c542..78584ba 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -29,6 +29,9 @@ const struct submodule *submodule_from_name(const unsigned char *commit_sha1,
 		const char *name);
 const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
 		const char *path);
+extern int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
+				      unsigned char *gitmodules_sha1,
+				      struct strbuf *rev);
 void submodule_free(void);
 
 #endif /* SUBMODULE_CONFIG_H */
diff --git a/submodule.c b/submodule.c
index f5107f0..062e58b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -198,6 +198,18 @@ void gitmodules_config(void)
 	}
 }
 
+void gitmodules_config_sha1(const unsigned char *commit_sha1)
+{
+	struct strbuf rev = STRBUF_INIT;
+	unsigned char sha1[20];
+
+	if (gitmodule_sha1_from_commit(commit_sha1, sha1, &rev)) {
+		git_config_from_blob_sha1(submodule_config, rev.buf,
+					  sha1, NULL);
+	}
+	strbuf_release(&rev);
+}
+
 /*
  * Determine if a submodule has been initialized at a given 'path'
  */
diff --git a/submodule.h b/submodule.h
index 6ec5f2f..9203d89 100644
--- a/submodule.h
+++ b/submodule.h
@@ -37,6 +37,7 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		const char *path);
 int submodule_config(const char *var, const char *value, void *cb);
 void gitmodules_config(void);
+extern void gitmodules_config_sha1(const unsigned char *commit_sha1);
 extern int is_submodule_initialized(const char *path);
 extern int is_submodule_populated(const char *path);
 int parse_submodule_update_strategy(const char *value,
-- 
2.8.0.rc3.226.g39d4020

