Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B34C433E2
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 18:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34410214F1
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 18:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NV7Q+/Y6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgIKSZu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 14:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgIKSZd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 14:25:33 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53B4C061786
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 11:25:32 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id m6so12420557wrn.0
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 11:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VRhngF81EV1+XQU88GXGk0pdQCPViCPjvTA/3RNRBJE=;
        b=NV7Q+/Y6RDFhA6HXG94rl8iFAriEOehMPohbVNBX6BL54Rqml8Ngd0zaxOSHyjI+cJ
         ohaky6UtPNe2viPK4l2faowR7NhCAwYOZQnJpoqfcAalC3YbrKU5DvgYJWykBvwDpz2i
         wo+9LauDdd8pPEtJmYCrn+7v1QY1+d1Iq5CyQQSuykOXfuiOOD9Lb4w2Zs8Q5DkF5SCd
         5GYJj2W4Y2yzXATmhQFK/toQ7xVOahIuUSVg0YAEN5H+xMdjmc9FXzkItGKKu0KvYgj3
         nimTeEIIhlPAjGALjfAw2lZJyV7FHapl0G3rtggSNVnE6xmJ1fXUBOTjzBeD4sFWE3Z8
         Y08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VRhngF81EV1+XQU88GXGk0pdQCPViCPjvTA/3RNRBJE=;
        b=CIDfs3NXlwAkhbCtS/tYakhKJzFkjjgso3njRwoqkKBrCs7lRsEQW4AArwbMatHKu5
         EQ1LnoGXQYNH4qx0MH1UAYMy/M3r4QbfZQoAx6pUQJpWPrYzLWeSGGxUTgfhDShOQhDB
         pf4phIoAUhC851TXqLBB1v4c/NGlLQqckU5W5CyOe8UU9ZPOVjl/tY+M+RYjSB21cEYD
         O9De9pEoYUiqmGa374p58u29mSV5DMa7OnzLEiUWw7frvZbkyUr9v5HXuPlxXBp/q+Nl
         MODzkbB62nfnbn3JBLflmJ8DSnSNbW5ColqELE1zNdEGxQx6riVOSu5V2MpEG6K4XKjV
         ZWpA==
X-Gm-Message-State: AOAM531CnQUgaVXv7tn2WE9FYPfwzCAfzRaVOtwXRouV8ILk6omWrPQk
        Y/6P5t/AT+SajJ5X7eSzFQyDU8ZQl4s=
X-Google-Smtp-Source: ABdhPJx9nqO83Iez+neGUuNn76Dky9tFbcmdByq+Rg2dLo3EoE6OVCuLSy0W9FBNgBYrgfvkKBdwDQ==
X-Received: by 2002:a5d:4581:: with SMTP id p1mr3354713wrq.345.1599848731104;
        Fri, 11 Sep 2020 11:25:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y2sm5570095wmg.23.2020.09.11.11.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 11:25:30 -0700 (PDT)
Message-Id: <5c519376c29a28bd89a712cf0b8125fc1c2c81be.1599848727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.727.git.1599848727.gitgitgadget@gmail.com>
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
From:   "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Sep 2020 18:25:27 +0000
Subject: [PATCH 4/4] clone: allow configurable default for `-o`/`--origin`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Sean Barag <sean@barag.org>, Sean Barag <sean@barag.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Barag <sean@barag.org>

While the default remote name of "origin" can be changed at clone-time
with `git clone`'s `--origin` option, it was previously not possible
to specify a default value for the name of that remote.  This commit
adds support for a new `clone.defaultRemoteName` config.

It's resolved in the expected priority order:

1. (Highest priority) A remote name passed directly to `git clone -o`
2. A `clone.defaultRemoteName=new_name` in config `git clone -c`
3. A `clone.defaultRemoteName` value set in `/path/to/template/config`,
   where `--template=/path/to/template` is provided
3. A `clone.defaultRemoteName` value set in a non-template config file
4. The default value of `origin`

Signed-off-by: Sean Barag <sean@barag.org>
Thanks-to: Junio C Hamano <gitster@pobox.com>
Thanks-to: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt       |  2 ++
 Documentation/config/clone.txt |  5 ++++
 Documentation/git-clone.txt    |  5 ++--
 builtin/clone.c                | 42 +++++++++++++++++++---------------
 t/t5606-clone-options.sh       | 29 +++++++++++++++++------
 5 files changed, 56 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/config/clone.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3042d80978..354874facf 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -334,6 +334,8 @@ include::config/checkout.txt[]
 
 include::config/clean.txt[]
 
+include::config/clone.txt[]
+
 include::config/color.txt[]
 
 include::config/column.txt[]
diff --git a/Documentation/config/clone.txt b/Documentation/config/clone.txt
new file mode 100644
index 0000000000..20755d413a
--- /dev/null
+++ b/Documentation/config/clone.txt
@@ -0,0 +1,5 @@
+clone.defaultRemoteName::
+	The name of the remote to create when cloning a repository.  Defaults to
+	`origin`, and can be overridden by passing the `--origin` command-line
+	option to linkgit:git-clone[1].
+
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index c898310099..f04bf6e6ba 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -183,8 +183,9 @@ objects from the source repository into a pack in the cloned repository.
 
 -o <name>::
 --origin <name>::
-	Instead of using the remote name `origin` to keep track
-	of the upstream repository, use `<name>`.
+	Instead of using the remote name `origin` to keep track of the upstream
+	repository, use `<name>`.  Overrides `clone.defaultRemoteName` from the
+	config.
 
 -b <name>::
 --branch <name>::
diff --git a/builtin/clone.c b/builtin/clone.c
index 1cd62d0001..aeb41f15f3 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -53,6 +53,7 @@ static int option_shallow_submodules;
 static int deepen;
 static char *option_template, *option_depth, *option_since;
 static char *option_origin = NULL;
+static char *remote_name = "origin";
 static char *option_branch = NULL;
 static struct string_list option_not = STRING_LIST_INIT_NODUP;
 static const char *real_git_dir;
@@ -721,7 +722,7 @@ static void update_head(const struct ref *our, const struct ref *remote,
 		if (!option_bare) {
 			update_ref(msg, "HEAD", &our->old_oid, NULL, 0,
 				   UPDATE_REFS_DIE_ON_ERR);
-			install_branch_config(0, head, option_origin, our->name);
+			install_branch_config(0, head, remote_name, our->name);
 		}
 	} else if (our) {
 		struct commit *c = lookup_commit_reference(the_repository,
@@ -853,16 +854,18 @@ static int checkout(int submodule_progress)
 
 static int git_clone_config(const char *k, const char *v, void *cb)
 {
+	if (!strcmp(k, "clone.defaultremotename") && !option_origin)
+		remote_name = xstrdup(v);
 	return git_default_config(k, v, cb);
 }
 
 static int write_one_config(const char *key, const char *value, void *data)
 {
 	/*
-	 * give git_config_default a chance to write config values back to the environment, since
+	 * give git_clone_config a chance to write config values back to the environment, since
 	 * git_config_set_multivar_gently only deals with config-file writes
 	 */
-	int apply_failed = git_default_config(key, value, data);
+	int apply_failed = git_clone_config(key, value, data);
 	if (apply_failed)
 		return apply_failed;
 
@@ -918,12 +921,12 @@ static void write_refspec_config(const char *src_ref_prefix,
 		}
 		/* Configure the remote */
 		if (value.len) {
-			strbuf_addf(&key, "remote.%s.fetch", option_origin);
+			strbuf_addf(&key, "remote.%s.fetch", remote_name);
 			git_config_set_multivar(key.buf, value.buf, "^$", 0);
 			strbuf_reset(&key);
 
 			if (option_mirror) {
-				strbuf_addf(&key, "remote.%s.mirror", option_origin);
+				strbuf_addf(&key, "remote.%s.mirror", remote_name);
 				git_config_set(key.buf, "true");
 				strbuf_reset(&key);
 			}
@@ -1009,13 +1012,16 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_no_checkout = 1;
 	}
 
-	if (!option_origin)
-		option_origin = "origin";
+	if (option_origin)
+		remote_name = option_origin;
 
-	strbuf_addf(&resolved_refspec, "refs/heads/test:refs/remotes/%s/test", option_origin);
+	strbuf_addf(&resolved_refspec, "refs/heads/test:refs/remotes/%s/test", remote_name);
 	if (!valid_fetch_refspec(resolved_refspec.buf))
-		/* TRANSLATORS: %s will be the user-provided --origin / -o option */
-		die(_("'%s' is not a valid origin name"), option_origin);
+		/*
+		 * TRANSLATORS: %s will be the user-provided --origin / -o option, or the value
+		 * of clone.defaultremotename from the config.
+		 */
+		die(_("'%s' is not a valid origin name"), remote_name);
 	strbuf_release(&resolved_refspec);
 
 	repo_name = argv[0];
@@ -1167,15 +1173,15 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 		git_config_set("core.bare", "true");
 	} else {
-		strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
+		strbuf_addf(&branch_top, "refs/remotes/%s/", remote_name);
 	}
 
-	strbuf_addf(&key, "remote.%s.url", option_origin);
+	strbuf_addf(&key, "remote.%s.url", remote_name);
 	git_config_set(key.buf, repo);
 	strbuf_reset(&key);
 
 	if (option_no_tags) {
-		strbuf_addf(&key, "remote.%s.tagOpt", option_origin);
+		strbuf_addf(&key, "remote.%s.tagOpt", remote_name);
 		git_config_set(key.buf, "--no-tags");
 		strbuf_reset(&key);
 	}
@@ -1186,7 +1192,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_sparse_checkout && git_sparse_checkout_init(dir))
 		return 1;
 
-	remote = remote_get(option_origin);
+	remote = remote_get(remote_name);
 
 	strbuf_addf(&default_refspec, "+%s*:%s*", src_ref_prefix,
 		    branch_top.buf);
@@ -1299,7 +1305,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 			if (!our_head_points_at)
 				die(_("Remote branch %s not found in upstream %s"),
-				    option_branch, option_origin);
+				    option_branch, remote_name);
 		}
 		else
 			our_head_points_at = remote_head_points_at;
@@ -1307,7 +1313,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	else {
 		if (option_branch)
 			die(_("Remote branch %s not found in upstream %s"),
-					option_branch, option_origin);
+					option_branch, remote_name);
 
 		warning(_("You appear to have cloned an empty repository."));
 		mapped_refs = NULL;
@@ -1319,7 +1325,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			const char *branch = git_default_branch_name();
 			char *ref = xstrfmt("refs/heads/%s", branch);
 
-			install_branch_config(0, branch, option_origin, ref);
+			install_branch_config(0, branch, remote_name, ref);
 			free(ref);
 		}
 	}
@@ -1328,7 +1334,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			remote_head_points_at, &branch_top);
 
 	if (filter_options.choice)
-		partial_clone_register(option_origin, &filter_options);
+		partial_clone_register(remote_name, &filter_options);
 
 	if (is_local)
 		clone_local(path, git_dir);
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index c865f96def..017c24a454 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -43,13 +43,6 @@ test_expect_success 'disallows --bare with --separate-git-dir' '
 
 '
 
-test_expect_success 'uses "origin" for default remote name' '
-
-	git clone parent clone-default-origin &&
-	(cd clone-default-origin && git rev-parse --verify refs/remotes/origin/master)
-
-'
-
 test_expect_success 'prefers --template config over normal config' '
 
 	template="$TRASH_DIRECTORY/template-with-config" &&
@@ -71,6 +64,28 @@ test_expect_success 'prefers -c config over --template config' '
 
 '
 
+test_expect_success 'uses "origin" for default remote name' '
+
+	git clone parent clone-default-origin &&
+	(cd clone-default-origin && git rev-parse --verify refs/remotes/origin/master)
+
+'
+
+test_expect_success 'prefers config "clone.defaultRemoteName" over default' '
+
+	test_config_global clone.defaultRemoteName from_config &&
+	git clone parent clone-config-origin &&
+	(cd clone-config-origin && git rev-parse --verify refs/remotes/from_config/master)
+
+'
+
+test_expect_success 'prefers --origin over -c config' '
+
+	git clone -c clone.defaultRemoteName=inline --origin from_option parent clone-o-and-inline-config &&
+	(cd clone-o-and-inline-config && git rev-parse --verify refs/remotes/from_option/master)
+
+'
+
 test_expect_success 'redirected clone does not show progress' '
 
 	git clone "file://$(pwd)/parent" clone-redirected >out 2>err &&
-- 
gitgitgadget
