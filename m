Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F58B1FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 19:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757335AbcLPTDl (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 14:03:41 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34252 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756428AbcLPTDi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 14:03:38 -0500
Received: by mail-pf0-f180.google.com with SMTP id c4so15498739pfb.1
        for <git@vger.kernel.org>; Fri, 16 Dec 2016 11:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EtkhYPARJqF7GiEKpdwmbtJ8qvBYlQACgzvi+253WKA=;
        b=Toz+UGg86ahB75hudNw32tsaOYDXYGB1EHvIaG9I0+3ybIe7n0zBAeCUEOD9SdSsM5
         s2whhCM8HaabbtBn1BncvpjfrRDvTyIPznhxbMfpNXRb4qF+4kXqDvjct8WrcPtLhJle
         ltVyTJ5a4hFds667Z2MfGUrABV5YHxlXYCfvt/mQh5KtOjttOMQxjDdRfSUmH+n3Oog7
         CAuhTb/Ciz7Y96gZA8yv8q4X2x9udHjVIQXKd5+Qa3BzUA1opMEH17x6Wxa/FWSI1g6q
         y0uPqUXHjge02HnQiMLp8sKW7nt0x+RAdMWflXFdlSgmTgtNKLms2osGS7iWeeLNuSGI
         0ZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EtkhYPARJqF7GiEKpdwmbtJ8qvBYlQACgzvi+253WKA=;
        b=YczDIPu4NtOCFK++C1DNHOeU9hUTMND6bn8UAomrnkssAkWMWm58pwlI3upxcFV2NT
         Nf5cD/j8j+tBer554+eWnVejas8WNRQwCCC48d9fBChorUGMNp+KviTXRI4CWGLN0nrj
         95DEWT5R6Uw4tfCRo/7UT3wNpmU+qUyo1Sve57gzJP9KyBmLgfP8SpdTemTVKfUDAi/T
         CBZJBifVSWDvU7TnS33aGe91Zunk4ECigQDUvT6hnT9Bh+JR9apFxae3ci9R6YG+1et+
         ADYY1MsNZKlsnDZDhkjSvvWHQDvpNbHG8z/Tusi5PhKbwHLHhuJyxlJhmAxl1tVTJlHc
         k5cg==
X-Gm-Message-State: AKaTC02gsCjGzeSUmPmojMj7BUKgckP89P3zbD6wTrLaUWwYwToh71rEd+2gsdfxKVlpK0RQ
X-Received: by 10.84.211.7 with SMTP id b7mr9823048pli.83.1481915017918;
        Fri, 16 Dec 2016 11:03:37 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id x90sm13573389pfk.73.2016.12.16.11.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Dec 2016 11:03:36 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, sbeller@google.com, jonathantanmy@google.com,
        gitster@pobox.com, jacob.keller@gmail.com, j6t@kdbg.org,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v7 3/7] submodules: load gitmodules file from commit sha1
Date:   Fri, 16 Dec 2016 11:03:18 -0800
Message-Id: <1481915002-162130-4-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481915002-162130-1-git-send-email-bmwill@google.com>
References: <1480555714-186183-1-git-send-email-bmwill@google.com>
 <1481915002-162130-1-git-send-email-bmwill@google.com>
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
index e12a5d9..de237ca 100644
--- a/cache.h
+++ b/cache.h
@@ -1693,6 +1693,8 @@ extern int git_default_config(const char *, const char *, void *);
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
index edffaa1..2600908 100644
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

