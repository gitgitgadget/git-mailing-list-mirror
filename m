Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FBAC433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 21:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhL1Vcg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 16:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhL1Vc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 16:32:28 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAFDC061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 13:32:28 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t26so40584662wrb.4
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 13:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZHHVedAp8W2JuzN7+w7ympjfdkaHVwsh7qOjVXFvtD0=;
        b=TEVK/qFTbx1tSC6XxNa2dDh3ledPkG7h6frTig3fw289zbh2K7AEWIls9jGAh7vZae
         nbKMlBwabsifa8WNprMSOCsfWhJMEpCHlPtjmfcHPVlp9m9QdXT8O6fLNXn4jMnAvgl5
         XmqOtI1A0xhQ76mvCw2ZbB3aOOMjbEVrMCwgOytiDQFVy3szmFFUek4v3gVOGF5oHrKD
         NwubTNTTCyoXIX3lgwyMUyApIqfIek358EfVBS8bBA00Lj8+jklAel+DSB9hT4DDrLnA
         QO5Abr0IecRgt50ImyDBNv/GBH1/8kMKoDqECBBlK8g0QyS8IK5Tazh/ykRX6VPxdjEg
         fj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZHHVedAp8W2JuzN7+w7ympjfdkaHVwsh7qOjVXFvtD0=;
        b=OsXYz0+eJZxuXiD79WJuW8//RCjLifj1qAXv/T0MMpQUriedxIxpQ3WZRsOmwk7XtB
         ip6KctiDxKpbDst+YmUmQnaLwNydPuqyLkwWX9OtXj2P9t4Kj92hHUIVecRwyzo7Q0/S
         ARGUcyCfwTNiZjrrSoZ0ZmIWywqtvXfTAO17c3qAU+IpBEaOHiKe9AXLQvvcTRuW0/Fr
         2giJ/SyNnSC6ArunS2yPD0cM0pRAHMGl7pv+sWY6FqQn8AiScJFjSLnrUUExnD3pXSvK
         muw4KNS/JDZpvltuWFyTXaJ1hLcOvJfIjksBYFpDpkyffToHvS95PXCCEqSauawCujvW
         rDPw==
X-Gm-Message-State: AOAM531ObJWrB7awjKzQ5pi8jPlYHrh185YO0P0x6jdUFOyfJMeVbVh7
        IJmwECmKLtrfBg+HKB5WLsODIFTyA/0=
X-Google-Smtp-Source: ABdhPJwP+LGDXycIt2XuUulUtv2186Nostun+cwXfHaHxIeC7vuroJiBQEzl2xsnW46AMd+FyZ8+ZQ==
X-Received: by 2002:a05:6000:18af:: with SMTP id b15mr18222277wri.616.1640727146575;
        Tue, 28 Dec 2021 13:32:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l16sm21302399wrx.117.2021.12.28.13.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 13:32:26 -0800 (PST)
Message-Id: <61b96937016acd61da66deb0d14e93f795eaca51.1640727143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
References: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
        <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Dec 2021 21:32:19 +0000
Subject: [PATCH v3 2/6] config: make some helpers repo-aware
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

As we prepare to add new config helpers to write into a config.worktree,
let's make some existing methods be available for writing to a config
file relative to a repository.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 config.c | 29 ++++++++++++++++++++++++++---
 config.h |  7 +++++++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index c5873f3a706..9c9eef16018 100644
--- a/config.c
+++ b/config.c
@@ -2882,7 +2882,12 @@ int git_config_set_gently(const char *key, const char *value)
 
 void git_config_set(const char *key, const char *value)
 {
-	git_config_set_multivar(key, value, NULL, 0);
+	repo_config_set(the_repository, key, value);
+}
+
+void repo_config_set(struct repository *r, const char *key, const char *value)
+{
+	repo_config_set_multivar(r, key, value, NULL, 0);
 
 	trace2_cmd_set_config(key, value);
 }
@@ -3177,14 +3182,32 @@ void git_config_set_multivar_in_file(const char *config_filename,
 int git_config_set_multivar_gently(const char *key, const char *value,
 				   const char *value_pattern, unsigned flags)
 {
-	return git_config_set_multivar_in_file_gently(NULL, key, value, value_pattern,
+	return repo_config_set_multivar_gently(the_repository, key, value,
+					       value_pattern, flags);
+}
+
+int repo_config_set_multivar_gently(struct repository *r, const char *key,
+				    const char *value,
+				    const char *value_pattern, unsigned flags)
+{
+	return git_config_set_multivar_in_file_gently(repo_git_path(r, "config"),
+						      key, value, value_pattern,
 						      flags);
 }
 
 void git_config_set_multivar(const char *key, const char *value,
 			     const char *value_pattern, unsigned flags)
 {
-	git_config_set_multivar_in_file(NULL, key, value, value_pattern,
+	repo_config_set_multivar(the_repository, key, value,
+				 value_pattern, flags);
+}
+
+void repo_config_set_multivar(struct repository *r, const char *key,
+			      const char *value, const char *value_pattern,
+			      unsigned flags)
+{
+	git_config_set_multivar_in_file(repo_git_path(r, "config"),
+					key, value, value_pattern,
 					flags);
 }
 
diff --git a/config.h b/config.h
index f119de01309..5531fc018e3 100644
--- a/config.h
+++ b/config.h
@@ -258,6 +258,11 @@ int git_config_set_gently(const char *, const char *);
  */
 void git_config_set(const char *, const char *);
 
+/**
+ * write config values to `.git/config`, takes a key/value pair as parameter.
+ */
+void repo_config_set(struct repository *, const char *, const char *);
+
 int git_config_parse_key(const char *, char **, size_t *);
 
 /*
@@ -281,6 +286,8 @@ int git_config_parse_key(const char *, char **, size_t *);
 
 int git_config_set_multivar_gently(const char *, const char *, const char *, unsigned);
 void git_config_set_multivar(const char *, const char *, const char *, unsigned);
+int repo_config_set_multivar_gently(struct repository *, const char *, const char *, const char *, unsigned);
+void repo_config_set_multivar(struct repository *, const char *, const char *, const char *, unsigned);
 int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, unsigned);
 
 /**
-- 
gitgitgadget

