Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 140A120899
	for <e@80x24.org>; Wed,  2 Aug 2017 19:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbdHBTth (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 15:49:37 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34325 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbdHBTtf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 15:49:35 -0400
Received: by mail-pg0-f51.google.com with SMTP id u185so25075272pgb.1
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 12:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MXebssRQ4dbYgPM+vkPrU/TykpJvYpgCk4Bh7iZWX3U=;
        b=lvg2oMseLyXsx6GK0Buz2u5jP12MG8+iM8fLuxSV/jH1yFs/5Se22q+zmV7j2pvkc5
         vkjbpd/FVn9vRgdBOwUpqEtZCFQ8LEcuSuHhRSjQSUGrA6qkBBnBg07yOK3sxtdAjqGX
         sqjbIfp0xwWaf0cDlDliji8HXL475Sj4f5wPSMVtQ3KHfHazOsDmweE2acW4cqccmvKd
         v2E9XK9Or+bn75dUSF3mkY4Xs+GUopA+XbQdGShmmWvBsklgLhYhf1kOWPv/H+uBRBzI
         R3JEs+8TtRJksa2Xu3Qkv+0kut6ECm0rhh7/J7BVuKiaAcWRVkWRCpvXelIZxvrhcWWB
         Y9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MXebssRQ4dbYgPM+vkPrU/TykpJvYpgCk4Bh7iZWX3U=;
        b=anD8+xOZKqL6K/pM0FXowDmH9scTgnvxMCOFkuMMwxgTPCtZqmdz96474rSr7OvyTQ
         nXkRYKiFECxMGbj30IClzcGRjrSOD/uB3xMVC/XhAyDf5wmfiR6a2mKiWBqvthk03mW9
         qcZ1septQxHzNC8n4l8ZgztlPQp9lneiSeDStlZagq2no4NcR6dGhUZ+avuE9JEqbnQ7
         y/unPhj6b7dzltsBmMaKiORKf7W62Ej51Yd8uKmbg3xc+yPkokKydbkHnzYVrfyvlBAU
         3Smn5ZGutl5T9+SzJq+gG9/K4qOzjdIMRZ9Ew4Mk2aQFj7goGXsrtQXq4q4j3VtJX2Sj
         oTCw==
X-Gm-Message-State: AIVw110rrGR0MgGOPSUtlol1IXC1U9Csn/eES0MN/PsOnjgLZyaeRi66
        1w0WAJFR0aWWbF1soPosag==
X-Received: by 10.84.168.131 with SMTP id f3mr25878060plb.220.1501703374689;
        Wed, 02 Aug 2017 12:49:34 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id e64sm63401460pfb.129.2017.08.02.12.49.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Aug 2017 12:49:33 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 04/10] config: add config_from_gitmodules
Date:   Wed,  2 Aug 2017 12:49:17 -0700
Message-Id: <20170802194923.88239-5-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <20170802194923.88239-1-bmwill@google.com>
References: <20170718190527.78049-1-bmwill@google.com>
 <20170802194923.88239-1-bmwill@google.com>
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
2.14.0.rc1.383.gd1ce394fe2-goog

