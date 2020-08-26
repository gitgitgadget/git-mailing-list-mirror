Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92B0C433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 15:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7921320738
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 15:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHoqspyl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgHZPpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgHZPpz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 11:45:55 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56F1C061574
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 08:45:54 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q9so22219wmj.2
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 08:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=/lV90Mz+zFg4gr4xX5cxJ6LedUv6oVuZP6jKy7/4x+E=;
        b=QHoqspylL+oI83Zk5JiqapqZSdD+Z/l3n/TPgqVLa6doj9z53nwkHBH5vbPWHANC16
         NzYmO8ZRirqsyZOklOwtgi8Q6SE1rn9lmlLQHjJ0wu6qndGEYKediCAJ9OIcpjXm+kfP
         7fKCQM3L+sTE2Hxp0N0hza/0Dw1PN3zVkye2PK/er15VnhX8QdhAIDPHvjx48abw3Usc
         e1Z6UiLoU6S9T1jCuvk0S/5iupk+5tAyW5Empe/0kveJsL5wQtwCFsP3A9yUaWyZI2ES
         NKJY2eEUy/lTaRv+jCo+eYeZ0QE4sP+AAq2OKgWaN8lwTLjJm8AZ3DNn/jrxDYcgu1th
         z+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/lV90Mz+zFg4gr4xX5cxJ6LedUv6oVuZP6jKy7/4x+E=;
        b=ZJr7X25pFEFHJmr8va6ghFtHRmiqnP6Kb3Och7nG/5+bpN1AsLu24HbIgKxHd59KtN
         L7FAOUjztFkmdbZHgodMnjhcAbXIJ1j/DGYH7Ozv1W6g6ECR84mgP7qqM4tIub+2jhIX
         408wq2hyRWRaJwnd9DSxd1wmSsdqGfJrWKvgWIcORTYPuNRMjM6E1X03iK8USYwdiiFj
         GyQ3/MRntqVQIElbfmHdOweg2t5N5MT0ZRQqJN36XoMGCdM1AbRgpJol7XGTdIGd8vQ2
         9db9oWl1GKbZqritfGcx46Vu3TxuDqiBQTKuy3Vy5sS7iFS7xN4fnlso0LjXNDUDAkWg
         wkmg==
X-Gm-Message-State: AOAM533dbaCBF0aDPb6H2/KWDvWkaT0Poei6M7LDf139nq/mXY8jhaPl
        bC3uHrtqzga2kSfkH3Hd0T7z5KJXXLY=
X-Google-Smtp-Source: ABdhPJzcMTDUrDcKkj41xKOM03L/bjjODdPhUQZvzjfHjXYueMlmFy5903j/JoQ2evnnV8tUhA2GSQ==
X-Received: by 2002:a7b:c156:: with SMTP id z22mr3679510wmi.101.1598456753018;
        Wed, 26 Aug 2020 08:45:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2sm8175104wrf.78.2020.08.26.08.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 08:45:52 -0700 (PDT)
Message-Id: <pull.710.git.1598456751674.gitgitgadget@gmail.com>
From:   "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Aug 2020 15:45:51 +0000
Subject: [PATCH] clone: add remote.cloneDefault config option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sean Barag <sean@barag.org>, Sean Barag <sean@barag.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Barag <sean@barag.org>

While the default remote name of `origin` can be overridden both
pre-clone (with `git clone --origin foo`) and post-clone (with `git
remote rename origin foo`), it'd be handy to have a configurable
system-wide default for clones!  This commit implements
`remote.cloneDefault` as a parallel to `remote.pushDefault`,
with prioritized name resolution:

1. (Highest priority) `git clone`'s `-o` option
2. `git config`'s `remote.cloneDefault` value
3. `origin`

There should be no impact for existing users, as it's pretty unlikely
that anyone's already configured `remote.cloneDefault` and the porcelain
hasn't changed (as best I can tell at least!).

Signed-off-by: Sean Barag <sean@barag.org>
---
    clone: add remote.cloneDefault config option
    
    While the default remote name of origin can be overridden both pre-clone
    (with git clone --origin foo) and post-clone (with git remote rename
    origin foo), it'd be handy to have a configurable system-wide default
    for clones! This implementsremote.cloneDefault as a parallel to 
    remote.pushDefault, with prioritized name resolution:
    
     1. (Highest priority) git clone's -o option
     2. git config's remote.cloneDefault value
     3. origin
    
    There should be no impact for existing users, as it's pretty unlikely
    that anyone's already configured remote.cloneDefault and the porcelain
    hasn't changed (as best I can tell at least!).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-710%2Fsjbarag%2Fadd-remote.cloneDefault-config-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-710/sjbarag/add-remote.cloneDefault-config-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/710

 Documentation/config/remote.txt |  4 ++++
 Documentation/git-clone.txt     |  5 +++--
 builtin/clone.c                 | 34 +++++++++++++++++++++++++++++++--
 t/t5606-clone-options.sh        | 14 ++++++++++++++
 4 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
index a8e6437a90..debb21ecbf 100644
--- a/Documentation/config/remote.txt
+++ b/Documentation/config/remote.txt
@@ -3,6 +3,10 @@ remote.pushDefault::
 	`branch.<name>.remote` for all branches, and is overridden by
 	`branch.<name>.pushRemote` for specific branches.
 
+remote.cloneDefault::
+	The name of the remote to create during `git clone <url>`.
+	Defaults to "origin".
+
 remote.<name>.url::
 	The URL of a remote repository.  See linkgit:git-fetch[1] or
 	linkgit:git-push[1].
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index c898310099..2e101ba4f4 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -183,8 +183,9 @@ objects from the source repository into a pack in the cloned repository.
 
 -o <name>::
 --origin <name>::
-	Instead of using the remote name `origin` to keep track
-	of the upstream repository, use `<name>`.
+	The remote name used to keep track of the upstream repository.
+	Overrides `remote.cloneDefault` from the config, and defaults
+	to `origin`.
 
 -b <name>::
 --branch <name>::
diff --git a/builtin/clone.c b/builtin/clone.c
index b087ee40c2..b0dbb848c6 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -941,6 +941,29 @@ static int path_exists(const char *path)
 	return !stat(path, &sb);
 }
 
+struct clone_default_info
+{
+	enum config_scope scope;
+	struct strbuf remote_name;
+	int linenr;
+};
+
+static int config_read_clone_default(const char *key, const char *value,
+	void *cb)
+{
+	struct clone_default_info* info = cb;
+	if (strcmp(key, "remote.clonedefault") || !value) {
+		return 0;
+	}
+
+	info->scope = current_config_scope();
+	strbuf_reset(&info->remote_name);
+	strbuf_addstr(&info->remote_name, value);
+	info->linenr = current_config_line();
+
+	return 0;
+}
+
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
@@ -992,8 +1015,15 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_no_checkout = 1;
 	}
 
-	if (!option_origin)
-		option_origin = "origin";
+	if (!option_origin) {
+		struct clone_default_info clone_default = { CONFIG_SCOPE_UNKNOWN, STRBUF_INIT, -1 };
+		git_config(config_read_clone_default, &clone_default);
+		if (strcmp("", (const char*) clone_default.remote_name.buf))
+			option_origin = clone_default.remote_name.buf;
+		else
+			option_origin = "origin";
+	}
+
 
 	repo_name = argv[0];
 
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index e69427f881..8aac67b385 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -19,6 +19,20 @@ test_expect_success 'clone -o' '
 
 '
 
+test_expect_success 'clone respects remote.cloneDefault' '
+
+	git -c remote.cloneDefault=bar clone parent clone-config &&
+	(cd clone-config && git rev-parse --verify refs/remotes/bar/master)
+
+'
+
+test_expect_success 'clone chooses correct remote name' '
+
+	git -c remote.cloneDefault=bar clone -o foo parent clone-o-and-config &&
+	(cd clone-o-and-config && git rev-parse --verify refs/remotes/foo/master)
+
+'
+
 test_expect_success 'redirected clone does not show progress' '
 
 	git clone "file://$(pwd)/parent" clone-redirected >out 2>err &&

base-commit: e9b77c84a0a0df029f2a3a8114e9f22186e7da24
-- 
gitgitgadget
