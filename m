Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C88C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D5BF61108
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbhIPKeb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 06:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbhIPKea (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 06:34:30 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047D5C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 03:33:10 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c4so3530758pls.6
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 03:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HP8XnJZ9umqYMyOZqaS4wWyOIaomOst6k3OEPStAMl8=;
        b=gY6MXAmnEdEUDb7YHq7rMP8WFT4RGkffMtiT/41LlBnFZ4ZD27I3p3XXbLchjScD71
         GiNP6XnPILHrBFSNP/zkDs24WX6Xohfmfi0bQjTPk7Q1EY8/DofMN7TJevl0qsRUezbG
         qexn/ugHp+tboidq8NmvdPu1hEdd0GZNOsOUFf/ngRe67j58mryZ6qvmar3yiYQKDZfX
         pNGZcueJnnMK9/Is2CvjnUPtvi/DQbd0vhmFy9m/dkHIIan+yzQCc0HlRDdYwONmBZcI
         U3jQL/GSCaRQqoAn3fdhfZD4+Uvq/Gv8xUDnNbpc/ikGZe+J4Dsnzjw/D60u+EZGiK8M
         WydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HP8XnJZ9umqYMyOZqaS4wWyOIaomOst6k3OEPStAMl8=;
        b=wmINke4O8Rb0rtwkzqTxxIilZoiaGffRvmlC/jE/3SmBy5x7mX0z06bvXFCeq4Fiv+
         IRYkZzqlXOc8rQj/509Ea765qW3E+jCm6PGBCz4afY8tpwzIzl9xTU0NRT1mcINuMBM6
         qyB+ozxfGh/vRZO57jFL1qFicsg/VSLp1VRUaZP7PRhP6vN17jQn3LobIFd799WAHGjT
         iSDSXwCPNFlXGjx9HEyPzM8P9PiDnAYjNwrrSTwBKlszFVvfVhSc4D+O0FZUp44NThCA
         qrepat4O1fMtbfw3DLxWrzKiwin6Z4tSkB1Mu7xmYkioSA5YIfCGLYLZz5rgcvo4le6x
         leqA==
X-Gm-Message-State: AOAM532j8ih/VJ/zoohdeDnVakU9z++NwiOKVRmOzQ50vU3ylssg2RmL
        LnQlAiNkghZ3LgxTimUSjHM=
X-Google-Smtp-Source: ABdhPJwzlKwsDOaWqaT9yYuOTsHNyn3w9xjQmZXHGouH0u1XhE+VZv3TEYog3+Sbny3IPn8Upp8CYw==
X-Received: by 2002:a17:902:a407:b0:138:849b:56f6 with SMTP id p7-20020a170902a40700b00138849b56f6mr4127536plq.0.1631788389594;
        Thu, 16 Sep 2021 03:33:09 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.182])
        by smtp.gmail.com with ESMTPSA id c199sm2642605pfb.152.2021.09.16.03.33.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 03:33:09 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: [PATCH v2 2/8] submodule--helper: get remote names from any repository
Date:   Thu, 16 Sep 2021 16:02:35 +0530
Message-Id: <20210916103241.62376-3-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210916103241.62376-1-raykar.ath@gmail.com>
References: <20210907115932.36068-1-raykar.ath@gmail.com>
 <20210916103241.62376-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`get_default_remote()` retrieves the name of a remote by resolving the
refs from of the current repository's ref store.

Thus in order to use it for retrieving the remote name of a submodule,
we have to start a new subprocess which runs from the submodule
directory.

Let's instead introduce a function called `repo_get_default_remote()`
which takes any repository object and retrieves the remote accordingly.

`get_default_remote()` is then defined as a call to
`repo_get_default_remote()` with 'the_repository' passed to it.

Now that we have `repo_get_default_remote()`, we no longer have to start
a subprocess that called `submodule--helper get-default-remote` from
within the submodule directory.

So let's make a function called `get_default_remote_submodule()` which
takes a submodule path, and returns the default remote for that
submodule, all within the same process.

We can now use this function to save an unnecessary subprocess spawn in
`sync_submodule()`, and also in the next patch, which will require this
functionality.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 builtin/submodule--helper.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 97512ccf0b..f6c4fc349b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -29,11 +29,10 @@
 typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
 				  void *cb_data);
 
-static char *get_default_remote(void)
+static char *repo_get_default_remote(struct repository *repo, const char *refname)
 {
 	char *dest = NULL, *ret;
 	struct strbuf sb = STRBUF_INIT;
-	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
 
 	if (!refname)
 		die(_("No such ref: %s"), "HEAD");
@@ -46,7 +45,7 @@ static char *get_default_remote(void)
 		die(_("Expecting a full ref name, got %s"), refname);
 
 	strbuf_addf(&sb, "branch.%s.remote", refname);
-	if (git_config_get_string(sb.buf, &dest))
+	if (repo_config_get_string(repo, sb.buf, &dest))
 		ret = xstrdup("origin");
 	else
 		ret = dest;
@@ -55,6 +54,25 @@ static char *get_default_remote(void)
 	return ret;
 }
 
+static char *get_default_remote_submodule(const char *module_path)
+{
+	const char *refname;
+	const struct submodule *sub;
+	struct repository subrepo;
+
+	refname = refs_resolve_ref_unsafe(get_submodule_ref_store(module_path),
+					  "HEAD", 0, NULL, NULL);
+	sub = submodule_from_path(the_repository, null_oid(), module_path);
+	repo_submodule_init(&subrepo, the_repository, sub);
+	return repo_get_default_remote(&subrepo, refname);
+}
+
+static char *get_default_remote(void)
+{
+	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
+	return repo_get_default_remote(the_repository, refname);
+}
+
 static int print_default_remote(int argc, const char **argv, const char *prefix)
 {
 	char *remote;
@@ -1369,7 +1387,6 @@ static void sync_submodule(const char *path, const char *prefix,
 	char *remote_key = NULL;
 	char *sub_origin_url, *super_config_url, *displaypath;
 	struct strbuf sb = STRBUF_INIT;
-	struct child_process cp = CHILD_PROCESS_INIT;
 	char *sub_config_path = NULL;
 
 	if (!is_submodule_active(the_repository, path))
@@ -1418,14 +1435,9 @@ static void sync_submodule(const char *path, const char *prefix,
 	if (!is_submodule_populated_gently(path, NULL))
 		goto cleanup;
 
-	prepare_submodule_repo_env(&cp.env_array);
-	cp.git_cmd = 1;
-	cp.dir = path;
-	strvec_pushl(&cp.args, "submodule--helper",
-		     "print-default-remote", NULL);
-
 	strbuf_reset(&sb);
-	if (capture_command(&cp, &sb, 0))
+	strbuf_addstr(&sb, get_default_remote_submodule(path));
+	if (!sb.buf)
 		die(_("failed to get the default remote for submodule '%s'"),
 		      path);
 
-- 
2.32.0

