Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE7FC433EF
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 15:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350566AbiAaPBG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 10:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349242AbiAaPBE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 10:01:04 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C029C061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 07:01:04 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id k6-20020a05600c1c8600b003524656034cso6521394wms.2
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 07:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uyMDAyf4BzO629nUhVYIK18MvIpf6a1gpCToHf8x+fw=;
        b=FVtpVTB7w6ab6zLJzL5NAnMLJ36CAvwRINhZyuhyTQKg8fS9nK3rg11zCl24b2cn0s
         +fODqKicDYUPF/Pi/8CjWzDXec2VD7ksq/h1b5zSTsyy2NDl432goZFp21/ZCdR1S7I4
         ilIvJNhn0eskzV510VySBdcbHaXg3qb5VAl4c8k9/NWH/acCT0+qF0Aizyl2x7Maf7Kn
         XHBaNFZcMKya0YJ5vIk3AlZ9cwy1B5NTsRJofCzYcNUOL/FtNfn13WzrdOioohZEZATQ
         hFrsv4rwKOvTUDQJ2my2M0pCaOxWAzWXfHmUasb7Tb+xC73s3rqKU9Uz6YNOpEQoSsII
         EciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uyMDAyf4BzO629nUhVYIK18MvIpf6a1gpCToHf8x+fw=;
        b=Hf8ZnZdDIGIXJR6vs1w++JotD+tYWHgISJ/ztgUpfkuWNRf55ZMAlLaskg++jRedE6
         7VK07IdSzBic0v3F7p73XYW6hVz2d0rFgSwAM6VLCWAuLdHyFZGtAU3+Lbpa1pzB+0rb
         bisCYdXRXIay0Nticmg6N91B4rVgmVEjNYt1eOdimh9t69osiUFd3XR8GkXFuj6QBAvj
         u5EVB8bgZuyXhN+dqTqKjduwKzRe20eSD8VXwecBzBUumibcBmOTG86jm+cL45ufH+UX
         +wWSmqUHvlKAhhsFICZxe1i41Tc6qqbpArL+LFXnIrC3OAk7OO/X8m7HRH/KdgTifUA6
         9qzg==
X-Gm-Message-State: AOAM532vL+pGCE9qX8wYJykkSHEjhuxj0gZK15X+GVyXic5Q3Iv6XU4O
        nJS5TSbxRs0jRve0dqI4agq5IAIgRt8=
X-Google-Smtp-Source: ABdhPJxlee8zU2+mhUJzJFYEn5zj6jeZ/r3bCs3EB+QmeycLQIHFAciZyozJosxMhnuqbs1n5gEGvw==
X-Received: by 2002:a1c:1f0c:: with SMTP id f12mr18787508wmf.44.1643641262441;
        Mon, 31 Jan 2022 07:01:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15sm9308205wmr.26.2022.01.31.07.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 07:01:02 -0800 (PST)
Message-Id: <2a2c350112e647510c5f7c81e831661948cfb68d.1643641259.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
References: <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com>
        <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 Jan 2022 15:00:56 +0000
Subject: [PATCH v5 2/5] worktree: create init_worktree_config()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Upgrading a repository to use extensions.worktreeConfig is non-trivial.
There are several steps involved, including moving some config settings
from the common config file to the main worktree's config.worktree file.
The previous change updated the documentation with all of these details.

Commands such as 'git sparse-checkout set' upgrade the repository to use
extensions.worktreeConfig without following these steps, causing some
user pain in some special cases.

Create a helper method, init_worktree_config(), that will be used in a
later change to fix this behavior within 'git sparse-checkout set'. The
method is carefully documented in worktree.h.

Note that we do _not_ upgrade the repository format version to 1 during
this process. The worktree config extension must be considered by Git
and third-party tools even if core.repositoryFormatVersion is 0 for
historical reasons documented in 11664196ac ("Revert
"check_repository_format_gently(): refuse extensions for old
repositories"", 2020-07-15). This is a special case for this extension,
and newer extensions (such as extensions.objectFormat) still need to
upgrade the repository format version.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 worktree.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 worktree.h | 21 ++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/worktree.c b/worktree.c
index 6f598dcfcdf..dc4ead4c8fb 100644
--- a/worktree.c
+++ b/worktree.c
@@ -5,6 +5,7 @@
 #include "worktree.h"
 #include "dir.h"
 #include "wt-status.h"
+#include "config.h"
 
 void free_worktrees(struct worktree **worktrees)
 {
@@ -826,3 +827,72 @@ int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath,
 	*wtpath = path;
 	return 0;
 }
+
+static int move_config_setting(const char *key, const char *value,
+			       const char *from_file, const char *to_file)
+{
+	if (git_config_set_in_file_gently(to_file, key, value))
+		return error(_("unable to set %s in '%s'"), key, to_file);
+	if (git_config_set_in_file_gently(from_file, key, NULL))
+		return error(_("unable to unset %s in '%s'"), key, from_file);
+	return 0;
+}
+
+int init_worktree_config(struct repository *r)
+{
+	int res = 0;
+	int bare = 0;
+	struct config_set cs = { { 0 } };
+	const char *core_worktree;
+	char *common_config_file = xstrfmt("%s/config", r->commondir);
+	char *main_worktree_file = xstrfmt("%s/config.worktree", r->commondir);
+
+	/*
+	 * If the extension is already enabled, then we can skip the
+	 * upgrade process.
+	 */
+	if (repository_format_worktree_config)
+		return 0;
+	if ((res = git_config_set_gently("extensions.worktreeConfig", "true")))
+		return error(_("failed to set extensions.worktreeConfig setting"));
+
+	git_configset_init(&cs);
+	git_configset_add_file(&cs, common_config_file);
+
+	/*
+	 * If core.bare is true in the common config file, then we need to
+	 * move it to the base worktree's config file or it will break all
+	 * worktrees. If it is false, then leave it in place because it
+	 * _could_ be negating a global core.bare=true.
+	 */
+	if (!git_configset_get_bool(&cs, "core.bare", &bare) && bare) {
+		if ((res = move_config_setting("core.bare", "true",
+					       common_config_file,
+					       main_worktree_file)))
+			goto cleanup;
+	}
+	/*
+	 * If core.worktree is set, then the base worktree is located
+	 * somewhere different than the parent of the common Git dir.
+	 * Relocate that value to avoid breaking all worktrees with this
+	 * upgrade to worktree config.
+	 */
+	if (!git_configset_get_string_tmp(&cs, "core.worktree", &core_worktree)) {
+		if ((res = move_config_setting("core.worktree", core_worktree,
+					       common_config_file,
+					       main_worktree_file)))
+			goto cleanup;
+	}
+
+	/*
+	 * Ensure that we use worktree config for the remaining lifetime
+	 * of the current process.
+	 */
+	repository_format_worktree_config = 1;
+
+cleanup:
+	git_configset_clear(&cs);
+	free(common_config_file);
+	free(main_worktree_file);
+	return res;
+}
diff --git a/worktree.h b/worktree.h
index 9e06fcbdf3d..e9e839926b0 100644
--- a/worktree.h
+++ b/worktree.h
@@ -183,4 +183,25 @@ void strbuf_worktree_ref(const struct worktree *wt,
 			 struct strbuf *sb,
 			 const char *refname);
 
+/**
+ * Enable worktree config for the first time. This will make the following
+ * adjustments:
+ *
+ * 1. Add extensions.worktreeConfig=true in the common config file.
+ *
+ * 2. If the common config file has a core.worktree value, then that value
+ *    is moved to the main worktree's config.worktree file.
+ *
+ * 3. If the common config file has a core.bare enabled, then that value
+ *    is moved to the main worktree's config.worktree file.
+ *
+ * If extensions.worktreeConfig is already true, then this method
+ * terminates early without any of the above steps. The existing config
+ * arrangement is assumed to be intentional.
+ *
+ * Returns 0 on success. Reports an error message and returns non-zero
+ * if any of these steps fail.
+ */
+int init_worktree_config(struct repository *r);
+
 #endif
-- 
gitgitgadget

