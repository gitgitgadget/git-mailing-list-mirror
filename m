Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA15020951
	for <e@80x24.org>; Tue, 14 Mar 2017 21:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbdCNVrX (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 17:47:23 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33011 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752501AbdCNVrM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 17:47:12 -0400
Received: by mail-pg0-f54.google.com with SMTP id n190so7622742pga.0
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 14:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ln2AiZcLJ0ggDheoPkmLsXGc/AjT+3JSWO7KGOQ4oSM=;
        b=XoLMcGf8sPNLT+KgAJ0CcSprLX0uKZX751lr17yfMnQK6NakojlCs4s9/J/O7C1Fp7
         Vka/awsjcAhsO+5sPu4cUdMtK0FwM30ROY24GwR/oSJWzVtKv0813qvIx70yZpHZsgPj
         sdK7p7APN3oXmkWhvs4Z6/nv9J1/D5duk2Aq8FFCg+3B6kXY0ak9HMgrGGxfzoojD6q3
         P3nJ8FkeAOCuTzlUtsRFKSYW2CwYVgyEqTmDixkdjEAK5xLw0IyXKqWfOrlaHFZxgw1H
         +VSBvBTmhk/UzHS4DZ/+7nQkXSSnAT4fLAgDXkSiqhE633R/cTtESO2nZc2H8I40wyR6
         P7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ln2AiZcLJ0ggDheoPkmLsXGc/AjT+3JSWO7KGOQ4oSM=;
        b=XwVqjpG0uYO81bFJY2ajh2E0EuaNaB2EqbjCVquLn8Jzx7Mm2Y4R1lmAj64ZsMR0w0
         713u6QPfXVQbhCtpYn7/ORWwwm0QiRSC89audZkNdeaOUHD24s2LPTi6AIXSW3ZMexa5
         7bx7aDlfD/hSeEyK2eKegVKsHKz3cl3n7Xr8+yHvxK4umm18cEuHalSjRFpFcZJehcxL
         fX3hl56PG7nr6z5T575iLFh6QhcIO/EmTgmp96E9jaf09M5MWPpP5tGOkzFDI5TmltGk
         kk0wD+qkC10QNNHSKPrAy/CVaFPsMYU81LnnVqE/9Dp+c+A8IJaRoEWPxcwU6j8pG5IT
         zQ6A==
X-Gm-Message-State: AMke39neT1QW7ygg7QdNtzdEmIvAkKy9zK6fDZotBGKd2pS53w5wzAk8RFIocUBXJV3qvlYI
X-Received: by 10.98.20.8 with SMTP id 8mr46925356pfu.10.1489528020621;
        Tue, 14 Mar 2017 14:47:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:8559:2c0d:dab3:f802])
        by smtp.gmail.com with ESMTPSA id u80sm40492061pgb.32.2017.03.14.14.46.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 14:46:59 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 09/19] update submodules: add submodule config parsing
Date:   Tue, 14 Mar 2017 14:46:32 -0700
Message-Id: <20170314214642.7701-10-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.49.g0cfd38c5f6.dirty
In-Reply-To: <20170314214642.7701-1-sbeller@google.com>
References: <20170309221543.15897-1-sbeller@google.com>
 <20170314214642.7701-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to b33a15b08 (push: add recurseSubmodules config option,
2015-11-17) and 027771fcb1 (submodule: allow erroneous values for the
fetchRecurseSubmodules option, 2015-08-17), we add submodule-config code
that is later used to parse whether we are interested in updating
submodules.

We need the `die_on_error` parameter to be able to call this parsing
function for the config file as well, which if incorrect lets Git die.

As we're just touching the header file, also mark all functions extern.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 20 ++++++++++++++++++++
 submodule-config.h | 17 +++++++++--------
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 93453909cf..3e8e380d98 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -234,6 +234,26 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
 	return parse_fetch_recurse(opt, arg, 1);
 }
 
+static int parse_update_recurse(const char *opt, const char *arg,
+				int die_on_error)
+{
+	switch (git_config_maybe_bool(opt, arg)) {
+	case 1:
+		return RECURSE_SUBMODULES_ON;
+	case 0:
+		return RECURSE_SUBMODULES_OFF;
+	default:
+		if (die_on_error)
+			die("bad %s argument: %s", opt, arg);
+		return RECURSE_SUBMODULES_ERROR;
+	}
+}
+
+int parse_update_recurse_submodules_arg(const char *opt, const char *arg)
+{
+	return parse_update_recurse(opt, arg, 1);
+}
+
 static int parse_push_recurse(const char *opt, const char *arg,
 			       int die_on_error)
 {
diff --git a/submodule-config.h b/submodule-config.h
index 70f19363fd..d434ecdb45 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -22,16 +22,17 @@ struct submodule {
 	int recommend_shallow;
 };
 
-int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
-int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
-int parse_submodule_config_option(const char *var, const char *value);
-const struct submodule *submodule_from_name(const unsigned char *commit_or_tree,
-		const char *name);
-const struct submodule *submodule_from_path(const unsigned char *commit_or_tree,
-		const char *path);
+extern int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
+extern int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
+extern int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
+extern int parse_submodule_config_option(const char *var, const char *value);
+extern const struct submodule *submodule_from_name(
+		const unsigned char *commit_or_tree, const char *name);
+extern const struct submodule *submodule_from_path(
+		const unsigned char *commit_or_tree, const char *path);
 extern int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
 				      unsigned char *gitmodules_sha1,
 				      struct strbuf *rev);
-void submodule_free(void);
+extern void submodule_free(void);
 
 #endif /* SUBMODULE_CONFIG_H */
-- 
2.12.0.rc1.49.g0cfd38c5f6.dirty

