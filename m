Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4932F20193
	for <e@80x24.org>; Thu, 27 Oct 2016 22:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S943043AbcJ0WjM (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 18:39:12 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35818 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942817AbcJ0WjG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 18:39:06 -0400
Received: by mail-pf0-f177.google.com with SMTP id s8so25079247pfj.2
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 15:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GCq7S9OB2QN42RMBxZe996Zb6VDWoZlttWr0JVZvxZ4=;
        b=DTG8At2koRMyq5HWTFSo9P1XjcrnQJIYPqFVvOgYTYSnaKevTIV/XoHm/EKrs4o0MI
         nJhL3aI6MWHSdgSdTBM3cZiFw9Z8euH6hLjriY4KNsu6ApZfX5pfiThdgWMRdiQHi/X/
         XS3aYmrZjPiWXHGdE1N3Y0uT0R2+KBGS6QLGRKwycYec+1lXLIN2KWSS4zrje9VLgsYf
         cSk0LgpOeIVMfRyRMMFm10/lQ2DLc2ajDBuK+ONjOJZSEmakYq6TqJsp+k+cd2AmjsV/
         1bWFZFgNkIG3fawpZwMGYhRwAxujFwAMBs8dxOOtB8cQvBYLTymgS6/DE6mOXD8NVTco
         2kYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GCq7S9OB2QN42RMBxZe996Zb6VDWoZlttWr0JVZvxZ4=;
        b=XIplRqHjynMDtP2RdX6i5cECvwrh8HvtrvdmOGU5J1nNj0nIwdGQQtRE9PXrJFREvA
         3IwWzqzgudfMytc8umc259TQsUcVf7/fAoEqQpPlbkLYp+FlJ5tGI0Eu8TG3F2yyDwnR
         k2RobUtkcEh/R/52t1dnVjq1xKcrmAq83XRRFMlo0i/jTOZp2UY8o/2zowm7rS9ja8bl
         re4/4fPDx8MZKQoQFsEHWdX7Vb/oR+YukBqiW/VqKLNClGZNmCQjZtIBE/eXqaPJSsuH
         ttJ6qp+D7pt40phpiDVFUTdIhgLE2hyLxtHBOURscu8XBJK9Fl3l/sCFbpeqlC2Pk5vn
         k6fg==
X-Gm-Message-State: ABUngve/DUYutNYc/h5tY7EHfGFnMMPN1XR6bMGr4RDVmkPdnAy7klNXGJoBCFWfe2+RlVJr
X-Received: by 10.98.92.68 with SMTP id q65mr18611878pfb.53.1477607945850;
        Thu, 27 Oct 2016 15:39:05 -0700 (PDT)
Received: from nalthis.roam.corp.google.com.com ([172.19.37.191])
        by smtp.gmail.com with ESMTPSA id d2sm8129400pfd.38.2016.10.27.15.39.04
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 27 Oct 2016 15:39:04 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 2/5] submodules: load gitmodules file from commit sha1
Date:   Thu, 27 Oct 2016 15:38:31 -0700
Message-Id: <20161027223834.35312-3-bmwill@google.com>
X-Mailer: git-send-email 2.10.1.613.g6021889
In-Reply-To: <20161027223834.35312-1-bmwill@google.com>
References: <20161027223834.35312-1-bmwill@google.com>
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
index f7ee41456..74b0c3cba 100644
--- a/cache.h
+++ b/cache.h
@@ -1681,6 +1681,8 @@ extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
 extern int git_config_from_mem(config_fn_t fn, const enum config_origin_type,
 					const char *name, const char *buf, size_t len, void *data);
+extern int git_config_from_blob_sha1(config_fn_t fn, const char *name,
+				     const unsigned char *sha1, void *data);
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
 extern void git_config(config_fn_t fn, void *);
diff --git a/config.c b/config.c
index 83fdecb1b..4d78e7227 100644
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
index 098085be6..8b9a2ef28 100644
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
index d05c542d2..78584ba6a 100644
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
index 029b24440..f2a56689f 100644
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
index bd039ca98..9a24ac82e 100644
--- a/submodule.h
+++ b/submodule.h
@@ -37,6 +37,7 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		const char *path);
 int submodule_config(const char *var, const char *value, void *cb);
 void gitmodules_config(void);
+extern void gitmodules_config_sha1(const unsigned char *commit_sha1);
 extern int is_submodule_initialized(const char *path);
 extern int is_submodule_checked_out(const char *path);
 int parse_submodule_update_strategy(const char *value,
-- 
2.10.1.613.g6021889

