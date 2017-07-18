Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E648B20387
	for <e@80x24.org>; Tue, 18 Jul 2017 19:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752194AbdGRTFs (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 15:05:48 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35305 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752191AbdGRTFp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 15:05:45 -0400
Received: by mail-pg0-f45.google.com with SMTP id v190so17594703pgv.2
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 12:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P3935vV9g8D8pbeh19xXnrymkTfJP0lyBP4+O3vTJyI=;
        b=L4NjTJux/6gnDum6Gr47oeWKXSahh9nwzQm+LgvHFmPUqbwZr4q5sXZrz2m9f6fOwo
         sWLF8r8nx1D30PiFSiwij8p7BtIxVTp5r++PQ3zscR/lhnY8DJGfet9cbyR7WhApmp5v
         IA1J5xAGyVwxbYV17SgwLoU4nTH64PFgupcVbgk1KA1OwONM7TpuZc9oLN06aNZE+wIW
         OgVzJSyY5cfIUNzNR0GUabFEO+t3vJK8z/bjubmW3/VWvgMxGMQru3FNjMcA6gIi9/Ye
         ZRvic9InEsoXZHekMvta49GTRr+38kPavk93HP4SpmVrId9ktb1uYTx3onNHZC0dso+n
         +tFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P3935vV9g8D8pbeh19xXnrymkTfJP0lyBP4+O3vTJyI=;
        b=Dmn/zDRez/NAr4++ooUcjc8nGqPf9qS3flV9JV8DmYvWK3EdH3X9F9gKtNi76kRLBo
         4uKhngq/jyP4VSpcsy2B+/uVjkmrz+gOJE6WRSzIOp6p5EU+3Y57eqpL6swnw4p8H9kq
         PqfqbQK823RG+YMzWnRgoLlZjJ+7XiFGdZ+2REYZb71i7UmSZ/l8PEMLnthIcyMP8BVL
         p7nLQfR01+pTwKzJea3LY86CZpZBZ/0jJC2I54KVtbM/UmxFPfejy9HbBAZ0QtARf9dT
         ctfDcy+34RSwtV+BlF4deVUuYBXIuOXVSkpwwOmAPUArkb3cN6ovJUim6FIvZ02vacxQ
         sb+g==
X-Gm-Message-State: AIVw111lwA/P5Cxp+nSxLHNYH8ApjURj+ZIff0o2rqjnx78kXC9nwGnr
        RR7qT5PcVHj98o85sdufvw==
X-Received: by 10.84.212.2 with SMTP id d2mr3449853pli.24.1500404744384;
        Tue, 18 Jul 2017 12:05:44 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t11sm6894649pfi.66.2017.07.18.12.05.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Jul 2017 12:05:42 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 04/10] config: add config_from_gitmodules
Date:   Tue, 18 Jul 2017 12:05:21 -0700
Message-Id: <20170718190527.78049-5-bmwill@google.com>
X-Mailer: git-send-email 2.13.2.932.g7449e964c-goog
In-Reply-To: <20170718190527.78049-1-bmwill@google.com>
References: <20170714222826.81148-1-bmwill@google.com>
 <20170718190527.78049-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add 'config_from_gitmodules()' function which can be used by 'fetch' and
'update_clone' in order to maintain backwards compatibility with
configuration being stored in .gitmodules' since a future patch will
remove reading these values in the submodule-config.

This function should not be used anywhere other than in 'fetch' and
'update_clone'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 config.c | 17 +++++++++++++++++
 config.h | 10 ++++++++++
 2 files changed, 27 insertions(+)

diff --git a/config.c b/config.c
index 231f9a750..06645a325 100644
--- a/config.c
+++ b/config.c
@@ -2053,6 +2053,23 @@ int git_config_get_pathname(const char *key, const char **dest)
 	return repo_config_get_pathname(the_repository, key, dest);
 }
 
+/*
+ * Note: This function exists solely to maintain backward compatibility with
+ * 'fetch' and 'update_clone' storing configuration in '.gitmodules' and should
+ * NOT be used anywhere else.
+ *
+ * Runs the provided config function on the '.gitmodules' file found in the
+ * working directory.
+ */
+void config_from_gitmodules(config_fn_t fn, void *data)
+{
+	if (the_repository->worktree) {
+		char *file = repo_worktree_path(the_repository, GITMODULES_FILE);
+		git_config_from_file(fn, file, data);
+		free(file);
+	}
+}
+
 int git_config_get_expiry(const char *key, const char **output)
 {
 	int ret = git_config_get_string_const(key, output);
diff --git a/config.h b/config.h
index 0352da117..6998e6645 100644
--- a/config.h
+++ b/config.h
@@ -187,6 +187,16 @@ extern int repo_config_get_maybe_bool(struct repository *repo,
 extern int repo_config_get_pathname(struct repository *repo,
 				    const char *key, const char **dest);
 
+/*
+ * Note: This function exists solely to maintain backward compatibility with
+ * 'fetch' and 'update_clone' storing configuration in '.gitmodules' and should
+ * NOT be used anywhere else.
+ *
+ * Runs the provided config function on the '.gitmodules' file found in the
+ * working directory.
+ */
+extern void config_from_gitmodules(config_fn_t fn, void *data);
+
 extern int git_config_get_value(const char *key, const char **value);
 extern const struct string_list *git_config_get_value_multi(const char *key);
 extern void git_config_clear(void);
-- 
2.13.2.932.g7449e964c-goog

