Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28AE92013A
	for <e@80x24.org>; Thu, 16 Feb 2017 00:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756265AbdBPAit (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 19:38:49 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36519 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753008AbdBPAid (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 19:38:33 -0500
Received: by mail-pf0-f177.google.com with SMTP id 189so781989pfu.3
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 16:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0/FMUmBMrti5fPmFvdOcI0rAGSwT2c6nlwZa/IS/+Zc=;
        b=ki4WDWvxR23sJuM8KRQy8U0sC0hJnMbvNffBoSWAHNJ0C8YgHbB69UT0wkhnL8Ru4F
         oX3ifTXDa/d93mLYIkCgwaPn88nuR6C4uVXAvQdSJ9tnoLb+ML7ryCMXQAGpIkSi1lA6
         u6XRT/icyRO13Ewl6hUWfSUBIzuPhnfTNOHUKVEwuGq92GQ5bz+6PVOuR/r19Bi/N+qX
         t6wKvUcdveZSJ3ypeevdlhCjDMBzHCz1JYsS9ke28y85IVyzwoR6gPmV3faLB1oTsugN
         tNouV3jufpfV44mWzHxzP69HOxvyxlKUbheH5F9Y8lnU36LMsqk1HjWLgB6Xh68UCXTP
         HIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0/FMUmBMrti5fPmFvdOcI0rAGSwT2c6nlwZa/IS/+Zc=;
        b=ViwbxBpQ1xeDQuLpGk4W9aKD4tfe0Pas12x8dMqV6f9VD6GPFR/heCQNXmT3avxc4X
         pw99W7aryn7GkDMY9EnPPlb5uZEDvUbM8pGx/dNTGDnaG/bmQpNSAdugGQjsVJfJKjl4
         a0zOmfZIX7V7zKLRLj1L+ksdzaaU3NdjSYaUnzxQSe6XBrVTJ/heyhHNSwYAOAtRlzl0
         HLg62BYWHTaVZBWH26fu40OP7YzsJudQRIkbDi7p1Ma3WVQYRr9ZQS6fM5YjPBTtiZ9s
         AqYAVje7hCLKfsNSsH7bN+ZnYmv+17vyi1UrrLju/qvT1a6WH7dYZh6XGkhhaSyKtiN3
         Mhsw==
X-Gm-Message-State: AMke39nm+sSUPubctCDq6vI6FgvcR40yTli1q08neTwz13VyOWuehT5kOU8Yv/kKK2Y9aqkr
X-Received: by 10.98.192.72 with SMTP id x69mr41103451pff.129.1487205507126;
        Wed, 15 Feb 2017 16:38:27 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2ca1:506:4965:89ed])
        by smtp.gmail.com with ESMTPSA id n70sm9577506pfg.34.2017.02.15.16.38.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 16:38:26 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 06/15] update submodules: add submodule config parsing
Date:   Wed, 15 Feb 2017 16:38:02 -0800
Message-Id: <20170216003811.18273-7-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <20170216003811.18273-1-sbeller@google.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com>
 <20170216003811.18273-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
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
 submodule-config.c | 22 ++++++++++++++++++++++
 submodule-config.h | 17 +++++++++--------
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 93453909cf..93f01c4378 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -234,6 +234,28 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
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
+		if (!strcmp(arg, "checkout"))
+			return RECURSE_SUBMODULES_ON;
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
2.12.0.rc1.16.ge4278d41a0.dirty

