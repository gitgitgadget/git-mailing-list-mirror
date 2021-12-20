Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C47C4332F
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 15:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbhLTP5a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 10:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237725AbhLTP53 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 10:57:29 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D9EC061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:57:28 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id i22so20977913wrb.13
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZHHVedAp8W2JuzN7+w7ympjfdkaHVwsh7qOjVXFvtD0=;
        b=T30lNlgVROZoxycxBttUdCaLL8VzDoolzm49j2qLw7PEJfPZqEQpat5uKcKlGJs0Ua
         JxJKJx9ni/cP3jBuvDnqf12usui4V6vGpDRRMEZhs+D3B5VcIg8XZjbXyYDJ6ljEkAwo
         K+QMzH9t75FPjzbY2/CbBlQlVduY9huHlzNcA+yhSsjRc36FMias5kl4wTos9UpsK5F2
         TofrZqlozZwnI9u65qLF9d99b7bWcu41JNN8vzk7FbcZ0+mfREQNpUwnrCW8X6lqQuyY
         FZUy/POz3NOjuLp6/G0cfD3ZOmLCXv3Y9aABx9EIlNkIYOjoBnGMDGQWFwecdfdEGizP
         B2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZHHVedAp8W2JuzN7+w7ympjfdkaHVwsh7qOjVXFvtD0=;
        b=wyV6drCvIEgfdrea4qxjy1jVvOXubLDLJ4PJ1UEpzIC7CRDYt2kvWCA2yo1DwoiKCq
         z5BvxQlK8ZadYfBx/OLyrkAWLcq9ISi8HEUSqtb8jQtxuJuYP6FfNQXnqbr1KgNnomH2
         wJTrxk+9iKEDeh/HTvgfc7yp8XIqHxbGBAWXlhyatr0BACDIP97p/ODcc/JUAYthwcXz
         Jb8NN0DcoAlZNgaYjMMzvd2NQwBaCNvxh0SyUI3hQxu1Hpx21SPZRUkvVF00v2QPEStr
         UX2i+dDtdpt0mkwQbffgT1lao/Dkoyp31b76dw131StHF1jjlLFy+w9T0T+N5UcbB0xR
         xGzw==
X-Gm-Message-State: AOAM530YC4FJxhIcn+L6vu2ZUYzn71MSIBjt1tc90TKfHRUguUg9Gf29
        GBUxw5CLC2I080chP/E64uOOau3+Cz0=
X-Google-Smtp-Source: ABdhPJw5PQm9fFy9hExsfK1hr6zBEKOjj2wOuGKQCh4+U70iPKOYnthwDY/6d+uYn/KhV6Hr95uh1A==
X-Received: by 2002:a5d:60c8:: with SMTP id x8mr8263686wrt.695.1640015847036;
        Mon, 20 Dec 2021 07:57:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2sm6527340wri.50.2021.12.20.07.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 07:57:26 -0800 (PST)
Message-Id: <3b549770eb9133fc78739ecc4eaba274e138076f.1640015844.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Dec 2021 15:57:22 +0000
Subject: [PATCH 2/4] config: make some helpers repo-aware
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
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

