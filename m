Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC5CC4332F
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 19:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241719AbhLUTOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 14:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237395AbhLUTOO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 14:14:14 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D922C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 11:14:13 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q16so29099wrg.7
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 11:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=k+Pm7SGau0A6FfYjEsnntJGGNVfvsDtk+S+0iUpQIRE=;
        b=XwuJzTzcUcTBqgEj2DMehBbtYD4xgEA9PDDMcWSpPb7iDO2ST9S4GXMpXE0emrOHJh
         gaLxvdMDAlP2BitjP/Q/OaFqVqZblAvY5lpy9KpRtUrOfeAC4eGOcGu+iTeVrNbGe0Qd
         tSvcPA0hk7wIjY71xuG7PTA3FJ69AjFZ3LPQN/wc+vicT2ZmHe3nduGj3RtQaJk5jt6x
         eIacT2M/3IuwDhqKMMtZVbV7naaKOKSQ9q6dNIK+zkpvX19SDUa96GfwZ80mJoPdD48v
         THDLf07O5JiD7ip0JIaX/hgWhItT9E9LAWdwuBkPAarxMz6NxkvbclWM9wuMbxg2bqb9
         Z+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=k+Pm7SGau0A6FfYjEsnntJGGNVfvsDtk+S+0iUpQIRE=;
        b=3ZTEZAb6JB4aXoIOpSOYsepJEuOyDuWxlan2r3oUTez1aPg5bcSA1CEjMKbebmZ+G5
         lVgwnTM17PEtLmpudljSoWwwUquZWokCyC/dZcf3EVwsvCa61igVY7HPsDMlie0Z1irg
         n3vrmJrdsi5fEjfiZxnMmFQmvICO0d0+sbSrKIJYtUb0Nqjkzu4N+BTHmvWJjwCPPFhC
         YP845tMmBEub0E8GIgPFq2uZqdOrZjyxX+k6uqJYSI4KMP2xMOhJRvZArsZRBOqymJSE
         hI2lDCL+ivVlQU/xrtXEUiuEN2Nwmkl5I8rA6L71PA7/Ghijl/+wZgQx+elYPYoF84uM
         yH+A==
X-Gm-Message-State: AOAM531M/+3JdbT3FF7+bPj+D+2wM+9PZIz+v92IOM6U+T6UryPCjIt8
        gCzQ9ZRsNmRBdwbs8xcLcDAll3w5gTA=
X-Google-Smtp-Source: ABdhPJzjPaTuTtqYIMFRgU+15t72ncL3jB2go/gh4F5/uszPOf6r4ZwJY8jG3MP3eYYGFSakWiVSnw==
X-Received: by 2002:adf:f90d:: with SMTP id b13mr3847820wrr.524.1640114052128;
        Tue, 21 Dec 2021 11:14:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m15sm18900083wrw.27.2021.12.21.11.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 11:14:11 -0800 (PST)
Message-Id: <22896e9bb04cdf022cc13468d60808df69a6854f.1640114048.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
        <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 19:14:07 +0000
Subject: [PATCH v2 4/5] config: add repo_config_set_worktree_gently()
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

The previous change added upgrade_to_worktree_config() to assist
creating a worktree-specific config for the first time. However, this
requires every config writer to care about that upgrade before writing
to the worktree-specific config. In addition, callers need to know how
to generate the name of the config.worktree file and pass it to the
config API.

To assist, create a new repo_config_set_worktree_gently() method in the
config API that handles the upgrade_to_worktree_config() method in
addition to assigning the value in the worktree-specific config. This
will be consumed by an upcoming change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 config.c | 10 ++++++++++
 config.h |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/config.c b/config.c
index 9c9eef16018..81f3a689c11 100644
--- a/config.c
+++ b/config.c
@@ -21,6 +21,7 @@
 #include "dir.h"
 #include "color.h"
 #include "refs.h"
+#include "worktree.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -2880,6 +2881,15 @@ int git_config_set_gently(const char *key, const char *value)
 	return git_config_set_multivar_gently(key, value, NULL, 0);
 }
 
+int repo_config_set_worktree_gently(struct repository *r,
+				    const char *key, const char *value)
+{
+	return upgrade_to_worktree_config(r) ||
+	       git_config_set_multivar_in_file_gently(
+			 repo_git_path(r, "config.worktree"),
+			 key, value, NULL, 0);
+}
+
 void git_config_set(const char *key, const char *value)
 {
 	repo_config_set(the_repository, key, value);
diff --git a/config.h b/config.h
index 5531fc018e3..b05c51b3528 100644
--- a/config.h
+++ b/config.h
@@ -253,6 +253,13 @@ void git_config_set_in_file(const char *, const char *, const char *);
 
 int git_config_set_gently(const char *, const char *);
 
+/**
+ * Write a config value into the config.worktree file for the current
+ * worktree. This will initialize extensions.worktreeConfig if necessary,
+ * which might trigger some changes to the root repository's config file.
+ */
+int repo_config_set_worktree_gently(struct repository *, const char *, const char *);
+
 /**
  * write config values to `.git/config`, takes a key/value pair as parameter.
  */
-- 
gitgitgadget

