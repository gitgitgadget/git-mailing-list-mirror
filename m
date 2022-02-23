Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF37C433FE
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243883AbiBWSbq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243868AbiBWSbh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:31:37 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A644B414
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:09 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d17so6223522wrc.9
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1jvZERtSPiben/T2+8gaCUWFMGf3l9m8EC+gogi8QVY=;
        b=eq2XT1Oyl8P6ixtt93znC1LP7RuodgsmRWsU9avMQMtLbwUdMiCDbLxAqrC9Qz4i1a
         zU3A2v2MzTq6mVvk5X4mpvHCw9poQDLsjAl40uUfb1e/jnRfXaDSBI64nj96zqtPjHRl
         ky0v5h06wZp1Io3QXMfFLDL03cw+b/Ua7J1yO3Q6X0iTf1YGb7Xrj4btAFBaq3btyxmQ
         i54WPb8V1HXkviyD92tcMZO4bzlPekkfGyqSLzY9zKAmWc4A3DvfHvEEhIlyIRo5tqNS
         wJfuGyO2MVEhyz6qqpczcnjdwHeH74z2ZDPSNjDkYP3eEOck2PYPwf/YdMM+2M/6QetU
         C6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1jvZERtSPiben/T2+8gaCUWFMGf3l9m8EC+gogi8QVY=;
        b=cTHMnn7ZK0etv3nyhZInoT7Boy36IZt3fUgGRi0lbAXoEEF+9trU9ZlsuQaptIqeIf
         /WPn3QrCAAsPuZPracJPjacYH1Nknmjho1XnwWyz0h4vVuemlgOwofHIuoNSE/jOdann
         r+BNbh2JQ1k+IhOsWq3gXyaWZZ9Fwao+TdEu9a6NrAEoWDaqNC85iMbFpfcwH0yu68v/
         0SWF+IfZd+skiWmFx3XBWDq3y1mrch7uS9UlBN+Dh9DeclhsBsoYRWGITZjgeJ7+F8Z8
         oxrRYA6GKsDnard9eHuWXR/+6OrncPQXa7zxWUJkABOF7EpBw1ayyDbd8SlhuLapv5v+
         eskA==
X-Gm-Message-State: AOAM5305TOty6vYKCTNlAcjhAQ0zOapVc4DgeD0dHjrUb/nAbSNURkVO
        dP5IrKzNt5PwFh3iKbGzeC2c3Mvrv0k=
X-Google-Smtp-Source: ABdhPJwiwfaXX1AJ6EnrD7LzJvmx8ls2ufGxghdkkQ5tYAmcn0xjLdfMkKNy8Cj6QGULnOFMFyoxkQ==
X-Received: by 2002:adf:bc14:0:b0:1e2:b035:9c46 with SMTP id s20-20020adfbc14000000b001e2b0359c46mr674191wrg.386.1645641067835;
        Wed, 23 Feb 2022 10:31:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s7sm322644wri.5.2022.02.23.10.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:31:07 -0800 (PST)
Message-Id: <fcd51a650217c4344e2ac79b53f06bc3eca3adb3.1645641063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:30:41 +0000
Subject: [PATCH 03/25] dir: extract starts_with_dot[_dot]_slash()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, aevar@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

We will want to use this logic to assist checking if paths are absolute
or relative, so extract it into a helpful place. This creates a
collision with similar methods in builtin/fsck.c, but those methods have
important differences. Prepend "fsck_" to those methods to emphasize
that they are custom to the fsck builtin.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/submodule--helper.c | 10 ----------
 dir.h                       | 11 +++++++++++
 fsck.c                      | 14 +++++++-------
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c5d3fc3817f..c17dde4170f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -70,16 +70,6 @@ static int print_default_remote(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int starts_with_dot_slash(const char *str)
-{
-	return str[0] == '.' && is_dir_sep(str[1]);
-}
-
-static int starts_with_dot_dot_slash(const char *str)
-{
-	return str[0] == '.' && str[1] == '.' && is_dir_sep(str[2]);
-}
-
 /*
  * Returns 1 if it was the last chop before ':'.
  */
diff --git a/dir.h b/dir.h
index 8e02dfb505d..5e38d1ba536 100644
--- a/dir.h
+++ b/dir.h
@@ -578,4 +578,15 @@ void connect_work_tree_and_git_dir(const char *work_tree,
 void relocate_gitdir(const char *path,
 		     const char *old_git_dir,
 		     const char *new_git_dir);
+
+static inline int starts_with_dot_slash(const char *str)
+{
+	return str[0] == '.' && is_dir_sep(str[1]);
+}
+
+static inline int starts_with_dot_dot_slash(const char *str)
+{
+	return str[0] == '.' && str[1] == '.' && is_dir_sep(str[2]);
+}
+
 #endif
diff --git a/fsck.c b/fsck.c
index 3ec500d707a..32cd3bc081f 100644
--- a/fsck.c
+++ b/fsck.c
@@ -976,31 +976,31 @@ done:
 }
 
 /*
- * Like builtin/submodule--helper.c's starts_with_dot_slash, but without
+ * Like dir.h's starts_with_dot_slash, but without
  * relying on the platform-dependent is_dir_sep helper.
  *
  * This is for use in checking whether a submodule URL is interpreted as
  * relative to the current directory on any platform, since \ is a
  * directory separator on Windows but not on other platforms.
  */
-static int starts_with_dot_slash(const char *str)
+static int fsck_starts_with_dot_slash(const char *str)
 {
 	return str[0] == '.' && (str[1] == '/' || str[1] == '\\');
 }
 
 /*
- * Like starts_with_dot_slash, this is a variant of submodule--helper's
- * helper of the same name with the twist that it accepts backslash as a
+ * Like fsck_starts_with_dot_slash, this is a variant of dir.h's
+ * helper with the twist that it accepts backslash as a
  * directory separator even on non-Windows platforms.
  */
-static int starts_with_dot_dot_slash(const char *str)
+static int fsck_starts_with_dot_dot_slash(const char *str)
 {
-	return str[0] == '.' && starts_with_dot_slash(str + 1);
+	return str[0] == '.' && fsck_starts_with_dot_slash(str + 1);
 }
 
 static int submodule_url_is_relative(const char *url)
 {
-	return starts_with_dot_slash(url) || starts_with_dot_dot_slash(url);
+	return fsck_starts_with_dot_slash(url) || fsck_starts_with_dot_dot_slash(url);
 }
 
 /*
-- 
gitgitgadget

