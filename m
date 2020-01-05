Return-Path: <SRS0=oqjl=22=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE352C47409
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 13:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA70C207FD
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 13:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="INI/rMfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgAEN4h (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jan 2020 08:56:37 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39332 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgAEN4g (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jan 2020 08:56:36 -0500
Received: by mail-pj1-f66.google.com with SMTP id t101so6635714pjb.4
        for <git@vger.kernel.org>; Sun, 05 Jan 2020 05:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bLM8QK2C5if6y0he/V6koJU3K5H17mtsvkgtTJOYFCo=;
        b=INI/rMfOzaYNGlhPRztEpl0y/oZH0F7rMFiUF/5hnbHL7OJIG3yvD0TG+c5cfoNTw7
         lcsDT8pCJ9heJX6VIQcrSM2CTOmB+B13v+rKyi0sc9K+v5f2jttuKh1Kwd7O6eemAmnB
         5wPu0Bo+sx75FvhC7gxy4t/nKS9tCM16MB6O+tR3CZSkKcjmODcCfDBo62lFIDByi5IM
         4AFAA54JEOJobYNx+dGwS3JsB5UXxsYXUY7Z8mjAnoCRlFOYvdC3d2R5RtEwh9LwA6oe
         vdvBKGS6oliWzSi5b/nbDyNFEWtrgxN4k9dUem+OH2+7/IKKg4uow8qT6jIQlBnc+55T
         kkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bLM8QK2C5if6y0he/V6koJU3K5H17mtsvkgtTJOYFCo=;
        b=stuvkU232wCzMPyAcHLWD5Jyj3TbNshDu7fd1oeO/zAPHaUoWqgFxtGLL2b15PKwdt
         dOtoAZb5fgXD69Z6jAaZc1HpOeMK8f5Rxwb4Rl+qDJ5ad347X/SnONAgCsw3618AapkM
         gzzNxXkeo6iLgGUnZLNhEUpjSsCFTdGtD2uo8PU0cRbymGQppLMx8xLhFHkqmrhchGtL
         ykBkFyt+1ZwFVfbCjRikWIVgSWpWctBlPY76LQfmqLr63K54tOLcFoHwmLOKr4ivKdax
         mLYLDGYtxFowRwP96qtv+gsyEiZOtFW0DquresS5NJ2jrLZfYq/E35yzpPtrNMaF4Tx8
         fpPA==
X-Gm-Message-State: APjAAAXjiugIXbwfizrmKi2XJyqitZVVOJJ1pPG9BeOGG7iOihFUXTPy
        /3wOO+w2XDSBlwhU3bOgMqUzkoMf1y4=
X-Google-Smtp-Source: APXvYqz220hmTMWNzZSwF8cqr1C5IMnPivocU6xZVxFnN5Bq/2icnRTidCrs17y42rbZWgd83ulsBw==
X-Received: by 2002:a17:902:7603:: with SMTP id k3mr51189811pll.93.1578232595092;
        Sun, 05 Jan 2020 05:56:35 -0800 (PST)
Received: from localhost ([202.62.47.81])
        by smtp.gmail.com with ESMTPSA id a9sm46688328pfn.38.2020.01.05.05.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 05:56:34 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH 5/5] clone: support signature verification
Date:   Sun,  5 Jan 2020 13:56:16 +0000
Message-Id: <20200105135616.19102-6-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200105135616.19102-1-hji@dyntopia.com>
References: <20200105135616.19102-1-hji@dyntopia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The merge operation (and as a consequence, pull) has had support for
signature verification for quite some time.  However, there were no
support for verifying GPG signatures for the initial clone.

Without signature verification for clone operations, users are forced to
checkout a repository before using verify-commit or verify-tag on the
tree.  This is potentially problematic for a few reasons:

- It's possible to forget to verify the tree when there's nothing that
  enforce signature verification before a cloned repository is used.

- Software on the users system might process the tree before it has been
  successfully verified -- for example, file managers that automagically
  creates thumbnails for images, videos and documents.

Now, this could be worked around with a --no-checkout clone followed by
signature verification and checkout.  There are also various scripts
floating around that more-or-less re-implements 'git clone' with
signature verification by using a combination of init + remote add +
fetch + verify-commit + merge [1].  But none of these options are
particularly user-friendly.

This patch implements signature verification for the clone builtin to
accommodate use-cases where the tree should be verified before use.

There is one major quirk in this patch; namely, recursive clones of
submodules.  It is worked around by passing --no-verify-signatures in
clone_submodule().  The rationale for this approach is that:

- The object ID for submodules are stored in the super repository.
  Thus, if the super is trusted and signed (and the hash function is
  secure), then it seems reasonable to also trust the submodules
  referenced in the super repository.

- Propagating signature verification to recursive clones of submodules
  would lessen the use of signature verification for clones, because
  then users would need the keys for each submodule author in their
  keyring.  Also, not all submodule refs may be signed.

[1] https://gist.github.com/tribut/50c0f7d0b8341fa6d1784c317d5275f0

Signed-off-by: Hans Jerry Illikainen <hji@dyntopia.com>
---
 Documentation/config.txt           |   2 +
 Documentation/config/clone.txt     |   3 +
 Documentation/git-clone.txt        |   4 +
 builtin/clone.c                    |  46 ++++
 builtin/submodule--helper.c        |   6 +
 t/t5619-clone-verify-signatures.sh | 411 +++++++++++++++++++++++++++++
 tag.c                              |  10 +-
 7 files changed, 478 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/config/clone.txt
 create mode 100755 t/t5619-clone-verify-signatures.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 83e7bba872..fda69e660e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -331,6 +331,8 @@ include::config/checkout.txt[]
 
 include::config/clean.txt[]
 
+include::config/clone.txt[]
+
 include::config/color.txt[]
 
 include::config/column.txt[]
diff --git a/Documentation/config/clone.txt b/Documentation/config/clone.txt
new file mode 100644
index 0000000000..9fd2ee3395
--- /dev/null
+++ b/Documentation/config/clone.txt
@@ -0,0 +1,3 @@
+clone.verifySignatures::
+	If true, this is equivalent to the --verify-signatures command
+	line option. See linkgit:git-clone[1] for details.
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index bf24f1813a..47a9d1e182 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -285,6 +285,10 @@ or `--mirror` is given)
 	The number of submodules fetched at the same time.
 	Defaults to the `submodule.fetchJobs` option.
 
+--verify-signatures::
+--no-verify-signatures::
+	Verify that the newly created HEAD is signed with a valid key.
+
 <repository>::
 	The (possibly remote) repository to clone from.  See the
 	<<URLS,GIT URLS>> section below for more information on specifying
diff --git a/builtin/clone.c b/builtin/clone.c
index 0fc89ae2b9..037953bc4b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -32,6 +32,8 @@
 #include "connected.h"
 #include "packfile.h"
 #include "list-objects-filter-options.h"
+#include "object.h"
+#include "tag.h"
 
 /*
  * Overall FIXMEs:
@@ -54,6 +56,7 @@ static int deepen;
 static char *option_template, *option_depth, *option_since;
 static char *option_origin = NULL;
 static char *option_branch = NULL;
+static int option_verify_signatures = -1;
 static struct string_list option_not = STRING_LIST_INIT_NODUP;
 static const char *real_git_dir;
 static char *option_upload_pack = "git-upload-pack";
@@ -120,6 +123,8 @@ static struct option builtin_clone_options[] = {
 		   N_("use <name> instead of 'origin' to track upstream")),
 	OPT_STRING('b', "branch", &option_branch, N_("branch"),
 		   N_("checkout <branch> instead of the remote's HEAD")),
+	OPT_BOOL(0, "verify-signatures", &option_verify_signatures,
+		 N_("verify the GPG signature of the newly created HEAD")),
 	OPT_STRING('u', "upload-pack", &option_upload_pack, N_("path"),
 		   N_("path to git-upload-pack on the remote")),
 	OPT_STRING(0, "depth", &option_depth, N_("depth"),
@@ -929,6 +934,40 @@ static int path_exists(const char *path)
 	return !stat(path, &sb);
 }
 
+static int verify_signature(const struct ref *our, const struct ref *remote)
+{
+	const struct object_id *oid = our ? &our->old_oid : &remote->old_oid;
+	enum object_type type = oid_object_info(the_repository, oid, NULL);
+	int flags = option_verbosity ? GPG_VERIFY_FULL : GPG_VERIFY_SHORT;
+
+	if (type == OBJ_COMMIT)
+		return gpg_verify_commit(oid, NULL, NULL, flags);
+	if (type == OBJ_TAG)
+		return gpg_verify_tag(oid, NULL, flags);
+	return error(_("%s: unknown object type: %s"),
+		     find_unique_abbrev(oid, DEFAULT_ABBREV), type_name(type));
+}
+
+static int git_clone_config(const char *var, const char *value, void *cb)
+{
+	int status;
+
+	if (!strcmp(var, "clone.verifysignatures")) {
+		option_verify_signatures = git_config_bool(var, value);
+		return 0;
+	}
+
+	if (!strcmp(var, "gpg.verifysignatures") &&
+	    option_verify_signatures < 0)
+		option_verify_signatures = git_config_bool(var, value);
+
+	status = git_gpg_config(var, value, cb);
+	if (status)
+		return status;
+
+	return git_default_config(var, value, cb);
+}
+
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
@@ -952,6 +991,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
 
 	packet_trace_identity("clone");
+
+	git_config(git_clone_config, NULL);
+
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
 
@@ -1267,6 +1309,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	else if (refs && complete_refs_before_fetch)
 		transport_fetch_refs(transport, mapped_refs);
 
+	if (option_verify_signatures > 0)
+		if (verify_signature(our_head_points_at, remote_head))
+			die(_("Signature verification failed"));
+
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
 			   branch_top.buf, reflog_msg.buf, transport,
 			   !is_local, filter_options.choice);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c72931ecd7..9e69c767c9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1248,6 +1248,12 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
 	if (gitdir && *gitdir)
 		argv_array_pushl(&cp.args, "--separate-git-dir", gitdir, NULL);
 
+	/*
+	 * The --no-verify-signatures parameter has to be passed in order to
+	 * make verification of super-repositories work on recursive clones.
+	 */
+	argv_array_push(&cp.args, "--no-verify-signatures");
+
 	argv_array_push(&cp.args, "--");
 	argv_array_push(&cp.args, url);
 	argv_array_push(&cp.args, path);
diff --git a/t/t5619-clone-verify-signatures.sh b/t/t5619-clone-verify-signatures.sh
new file mode 100755
index 0000000000..7a93d57c2a
--- /dev/null
+++ b/t/t5619-clone-verify-signatures.sh
@@ -0,0 +1,411 @@
+#!/bin/sh
+
+test_description='Test cloning repos with signature verification'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
+
+test_expect_success GPG 'create repositories with signed commits and tags' '
+	echo 0 >a && git add a &&
+	test_tick && git commit -m "initial-unsigned" &&
+	git tag -a -m "unsigned v0" v0-unsigned &&
+
+	git clone . signed &&
+	(
+		cd signed &&
+		echo 1 >b && git add b &&
+		test_tick && git commit -S -m "signed" &&
+		git branch signed-branch &&
+		git tag -s -m "signed v1" v1-signed
+	) &&
+
+	git clone . unsigned &&
+	(
+		cd unsigned &&
+		echo 2 >c && git add c &&
+		test_tick && git commit -m "unsigned" &&
+		git tag v2-unsigned-shallow &&
+		git tag -a -m "unsigned and annotated" v2-unsigned-annotated
+	) &&
+
+	git clone signed unsigned-tip &&
+	(
+		cd unsigned-tip &&
+		echo 3 >d && git add d &&
+		test_tick && git commit -m "unsigned tip" &&
+		git tag -a -m "unsigned v3 tip" v3-unsigned-tip &&
+		git branch signed-branch origin/signed-branch
+	) &&
+
+	git clone signed unsigned-branch &&
+	(
+		cd unsigned-branch &&
+		git checkout -b unsigned-branch &&
+		git commit --amend --no-edit &&
+		git checkout master
+	) &&
+
+	git clone . signed-tag-unsigned-commit &&
+	(
+		cd signed-tag-unsigned-commit &&
+		git tag -s -m "signed/unsigned v4" v4-signed-tag-unsigned-commit
+	) &&
+
+	git clone . bad &&
+	(
+		cd bad &&
+		echo 4 >d && git add d &&
+		test_tick && git commit -S -m "bad" &&
+		git cat-file commit HEAD >raw &&
+		sed -e "s/^bad/forged bad/" raw >forged &&
+		git hash-object -w -t commit forged >forged.commit &&
+		git checkout $(cat forged.commit)
+	) &&
+
+	git clone . untrusted &&
+	(
+		cd untrusted &&
+		echo 5 >e && git add e &&
+		test_tick && git commit -SB7227189 -m "untrusted"
+	) &&
+
+	git clone unsigned unsigned-detached &&
+	(
+		cd unsigned-detached &&
+		echo 6 >f && git add f &&
+		test_tick && git commit -S -m "signed" &&
+		git checkout HEAD^
+	) &&
+
+	git clone signed signed-detached &&
+	(
+		cd signed-detached &&
+		echo 7 >g && git add g &&
+		test_tick && git commit -S -m "signed" &&
+		git checkout HEAD^
+	) &&
+
+	git clone signed signed-with-unsigned-submodule &&
+	(
+		cd signed-with-unsigned-submodule &&
+		git submodule add "file://$PWD/../unsigned" &&
+		git commit -S -m "add submodule"
+	) &&
+
+	git clone signed signed-with-signed-submodule &&
+	(
+		cd signed-with-signed-submodule &&
+		git submodule add "file://$PWD/../signed" &&
+		git commit -S -m "add submodule"
+	) &&
+
+	git clone unsigned unsigned-with-unsigned-submodule &&
+	(
+		cd unsigned-with-unsigned-submodule &&
+		git submodule add "file://$PWD/../unsigned" &&
+		git commit -m "add submodule"
+	) &&
+
+	git clone unsigned unsigned-with-signed-submodule &&
+	(
+		cd unsigned-with-signed-submodule &&
+		git submodule add "file://$PWD/../signed" &&
+		git commit -m "add submodule"
+	)
+'
+
+test_expect_success GPG 'clone signed with --verify-signatures' '
+	test_when_finished "rm -rf dst" &&
+	git clone --verify-signatures signed dst >out &&
+	test_i18ngrep "Commit [0-9a-f]\+ has a good GPG signature by " out
+'
+
+test_expect_success GPG 'clone signed tag with --verify-signatures' '
+	test_when_finished "rm -rf dst" &&
+	git clone -b v1-signed --verify-signatures signed dst >out &&
+	test_i18ngrep "Tag [0-9a-f]\+ has a good GPG signature by " out
+'
+
+test_expect_success GPG 'clone signed with clone.verifySignatures=true' '
+	test_when_finished "rm -rf dst" &&
+	test_config_global clone.verifySignatures true &&
+	git clone signed dst >out &&
+	test_i18ngrep "Commit [0-9a-f]\+ has a good GPG signature by " out
+'
+
+test_expect_success GPG 'clone signed with --depth=1 and clone.verifySignatures=true' '
+	test_when_finished "rm -rf dst" &&
+	test_config_global clone.verifySignatures true &&
+	git clone --depth=1 signed dst >out &&
+	test_i18ngrep "Commit [0-9a-f]\+ has a good GPG signature by " out
+'
+
+test_expect_success GPG 'clone signed with --no-checkout and clone.verifySignatures=true' '
+	test_when_finished "rm -rf dst" &&
+	test_config_global clone.verifySignatures true &&
+	git clone --no-checkout signed dst >out &&
+	test_i18ngrep "Commit [0-9a-f]\+ has a good GPG signature by " out
+'
+
+test_expect_success GPG 'clone signed with --mirror and clone.verifySignatures=true' '
+	test_when_finished "rm -rf dst" &&
+	test_config_global clone.verifySignatures true &&
+	git clone --mirror signed dst >out &&
+	test_i18ngrep "Commit [0-9a-f]\+ has a good GPG signature by " out
+'
+
+test_expect_success GPG 'clone signed without blobs and clone.verifySignatures=true' '
+	test_when_finished "rm -rf dst" &&
+	test_config_global clone.verifySignatures true &&
+	git clone --filter=blob:none signed dst >out &&
+	test_i18ngrep "Commit [0-9a-f]\+ has a good GPG signature by " out
+'
+
+test_expect_success GPG 'clone signed bare with clone.verifySignatures=true' '
+	test_when_finished "rm -rf dst" &&
+	test_config_global clone.verifySignatures true &&
+	git clone --bare signed dst >out &&
+	test_i18ngrep "Commit [0-9a-f]\+ has a good GPG signature by " out
+'
+
+test_expect_success GPG 'clone signed tag with clone.verifySignatures=true' '
+	test_when_finished "rm -rf dst" &&
+	test_config_global clone.verifySignatures true &&
+	git clone -b v1-signed signed dst >out &&
+	test_i18ngrep "Tag [0-9a-f]\+ has a good GPG signature by " out
+'
+
+test_expect_success GPG 'clone unsigned with defaults' '
+	test_when_finished "rm -rf dst" &&
+	git clone unsigned dst >out 2>&1 &&
+	! test_i18ngrep "GPG signature" out
+'
+
+test_expect_success GPG 'clone unsigned with clone.verifySignatures=true' '
+	test_config_global clone.verifySignatures true &&
+	test_must_fail git clone unsigned dst 2>out &&
+	test_path_is_missing dst &&
+	test_i18ngrep "Commit [0-9a-f]\+ does not have a GPG signature." out
+'
+
+test_expect_success GPG 'clone unsigned with --depth=1 and clone.verifySignatures=true' '
+	test_config_global clone.verifySignatures true &&
+	test_must_fail git clone --depth=1 unsigned dst 2>out &&
+	test_path_is_missing dst &&
+	test_i18ngrep "Commit [0-9a-f]\+ does not have a GPG signature." out
+'
+
+test_expect_success GPG 'clone unsigned with --no-checkout and clone.verifySignatures=true' '
+	test_config_global clone.verifySignatures true &&
+	test_must_fail git clone --no-checkout unsigned dst 2>out &&
+	test_path_is_missing dst &&
+	test_i18ngrep "Commit [0-9a-f]\+ does not have a GPG signature." out
+'
+
+test_expect_success GPG 'clone unsigned with --mirror and clone.verifySignatures=true' '
+	test_config_global clone.verifySignatures true &&
+	test_must_fail git clone --no-checkout unsigned dst 2>out &&
+	test_path_is_missing dst &&
+	test_i18ngrep "Commit [0-9a-f]\+ does not have a GPG signature." out
+'
+
+test_expect_success GPG 'clone unsigned without blobs and clone.verifySignatures=true' '
+	test_config_global clone.verifySignatures true &&
+	test_must_fail git clone --filter=blob:none unsigned dst 2>out &&
+	test_path_is_missing dst &&
+	test_i18ngrep "Commit [0-9a-f]\+ does not have a GPG signature." out
+'
+
+test_expect_success GPG 'clone unsigned bare with clone.verifySignatures=true' '
+	test_config_global clone.verifySignatures true &&
+	test_must_fail git clone --bare unsigned dst 2>out &&
+	test_path_is_missing dst &&
+	test_i18ngrep "Commit [0-9a-f]\+ does not have a GPG signature." out
+'
+
+test_expect_success GPG 'clone unsigned with --verify-signatures and clone.verifySignatures=false' '
+	test_config_global clone.verifySignatures false &&
+	test_must_fail git clone --verify-signatures unsigned dst 2>out &&
+	test_path_is_missing dst &&
+	test_i18ngrep "Commit [0-9a-f]\+ does not have a GPG signature." out
+'
+
+test_expect_success GPG 'clone unsigned with --no-verify-signatures and clone.verifySignatures=true' '
+	test_when_finished "rm -rf dst" &&
+	test_config_global clone.verifySignatures true &&
+	git clone --no-verify-signatures unsigned dst >out &&
+	! test_i18ngrep "GPG signature" out
+'
+
+test_expect_success GPG 'clone unsigned with --no-verify-signatures and gpg.verifySignatures=true' '
+	test_when_finished "rm -rf dst" &&
+	test_config_global gpg.verifySignatures true &&
+	git clone --no-verify-signatures unsigned dst >out &&
+	! test_i18ngrep "GPG signature" out
+'
+
+test_expect_success GPG 'clone unsigned with clone.verifySignatures=false and gpg.verifySignatures=true' '
+	test_when_finished "rm -rf dst" &&
+	test_config_global clone.verifySignatures false &&
+	test_config_global gpg.verifySignatures true &&
+	git clone unsigned dst >out &&
+	! test_i18ngrep "GPG signature" out
+'
+
+test_expect_success GPG 'clone unsigned with gpg.verifySignatures=true and clone.verifySignatures=false' '
+	test_when_finished "rm -rf dst" &&
+	test_config_global gpg.verifySignatures true &&
+	test_config_global clone.verifySignatures false &&
+	git clone unsigned dst >out &&
+	! test_i18ngrep "GPG signature" out
+'
+
+test_expect_success GPG 'clone unsigned with gpg.verifySignatures=true' '
+	test_config_global gpg.verifySignatures true &&
+	test_must_fail git clone unsigned dst 2>out &&
+	test_path_is_missing dst &&
+	test_i18ngrep "Commit [0-9a-f]\+ does not have a GPG signature." out
+'
+
+test_expect_success GPG 'clone bad signature with --verbose and clone.verifySignatures=true' '
+	test_config_global clone.verifySignatures true &&
+	test_must_fail git clone --verbose bad dst 2>out &&
+	test_path_is_missing dst &&
+	test_i18ngrep "gpg: BAD signature from " out
+'
+
+test_expect_success GPG 'clone bad signature with clone.verifySignatures=true' '
+	test_config_global clone.verifySignatures true &&
+	test_must_fail git clone bad dst 2>out &&
+	test_path_is_missing dst &&
+	test_i18ngrep "Commit [0-9a-f]\+ has a bad GPG signature " out
+'
+
+test_expect_success GPG 'clone untrusted with clone.verifySignatures=true' '
+	test_when_finished "rm -rf dst" &&
+	test_config_global clone.verifySignatures true &&
+	git clone untrusted dst >out &&
+	test_i18ngrep "Commit [0-9a-f]\+ has a good GPG signature by " out
+'
+
+test_expect_success GPG 'clone untrusted with clone.verifySignatures=true and gpg.minTrustLevel=fully' '
+	test_config_global clone.verifySignatures true &&
+	test_config_global gpg.minTrustLevel fully &&
+	test_must_fail git clone untrusted dst 2>out &&
+	test_path_is_missing dst &&
+	test_i18ngrep "Commit [0-9a-f]\+ has an untrusted GPG signature" out
+'
+
+test_expect_success GPG 'clone unsigned tip with clone.verifySignatures=true' '
+	test_config_global clone.verifySignatures true &&
+	test_must_fail git clone unsigned-tip dst 2>out &&
+	test_path_is_missing dst &&
+	test_i18ngrep "Commit [0-9a-f]\+ does not have a GPG signature." out
+'
+
+test_expect_success GPG 'clone unsigned tip tag with clone.verifySignatures=true' '
+	test_config_global clone.verifySignatures true &&
+	test_must_fail git clone -b v3-unsigned-tip unsigned-tip dst 2>out &&
+	test_path_is_missing dst &&
+	test_i18ngrep "Tag [0-9a-f]\+ does not have a GPG signature." out
+'
+
+test_expect_success GPG 'clone signed tag from unsigned tip tag with clone.verifySignatures=true' '
+	test_when_finished "rm -rf dst" &&
+	test_config_global clone.verifySignatures true &&
+	git clone -b v1-signed unsigned-tip dst >out &&
+	test_i18ngrep "Tag [0-9a-f]\+ has a good GPG signature by " out
+'
+
+test_expect_success GPG 'clone signed branch from unsigned tip tag with clone.verifySignatures=true' '
+	test_when_finished "rm -rf dst" &&
+	test_config_global clone.verifySignatures true &&
+	git clone -b signed-branch unsigned-tip dst >out &&
+	test_i18ngrep "Commit [0-9a-f]\+ has a good GPG signature by " out
+'
+
+test_expect_success GPG 'clone unsigned branch with clone.verifySignatures=true' '
+	test_config_global clone.verifySignatures true &&
+	test_must_fail git clone -b unsigned-branch unsigned-branch dst 2>out &&
+	test_path_is_missing dst &&
+	test_i18ngrep "Commit [0-9a-f]\+ does not have a GPG signature." out
+'
+
+test_expect_success GPG 'clone unsigned shallow tag with clone.verifySignatures=true' '
+	test_config_global clone.verifySignatures true &&
+	test_must_fail git clone -b v2-unsigned-shallow unsigned dst 2>out &&
+	test_path_is_missing dst &&
+	test_i18ngrep "Commit [0-9a-f]\+ does not have a GPG signature." out
+'
+
+test_expect_success GPG 'clone unsigned annotated tag with clone.verifySignatures=true' '
+	test_config_global clone.verifySignatures true &&
+	test_must_fail git clone -b v2-unsigned-annotated unsigned dst 2>out &&
+	test_path_is_missing dst &&
+	test_i18ngrep "Tag [0-9a-f]\+ does not have a GPG signature." out
+'
+
+test_expect_success GPG 'clone signed tag for unsigned commit with clone.verifySignatures=true' '
+	test_when_finished "rm -rf dst" &&
+	test_config_global clone.verifySignatures true &&
+	git clone -b v4-signed-tag-unsigned-commit signed-tag-unsigned-commit dst >out &&
+	test_i18ngrep "Tag [0-9a-f]\+ has a good GPG signature by " out
+'
+
+test_expect_success GPG 'clone unsigned detached HEAD with clone.verifySignatures=true' '
+	test_config_global clone.verifySignatures true &&
+	test_must_fail git clone unsigned-detached dst 2>out &&
+	test_path_is_missing dst &&
+	test_i18ngrep "Commit [0-9a-f]\+ does not have a GPG signature." out
+'
+
+test_expect_success GPG 'clone signed detached HEAD with clone.verifySignatures=true' '
+	test_when_finished "rm -rf dst" &&
+	test_config_global clone.verifySignatures true &&
+	git clone signed-detached dst >out &&
+	test_i18ngrep "Commit [0-9a-f]\+ has a good GPG signature by " out
+'
+
+test_expect_success GPG 'clone signed with unsigned submodules and clone.verifySignatures=true' '
+	test_when_finished "rm -rf dst" &&
+	test_config_global clone.verifySignatures true &&
+	git clone --recurse-submodules signed-with-unsigned-submodule dst >out &&
+	test_i18ngrep "Commit [0-9a-f]\+ has a good GPG signature by " out
+'
+
+test_expect_success GPG 'clone signed with unsigned submodules and --verify-signatures' '
+	test_when_finished "rm -rf dst" &&
+	git clone --recurse-submodules --verify-signatures \
+		signed-with-unsigned-submodule dst >out &&
+	test_i18ngrep "Commit [0-9a-f]\+ has a good GPG signature by " out
+'
+
+test_expect_success GPG 'clone signed with signed submodules and clone.verifySignatures=true' '
+	test_when_finished "rm -rf dst" &&
+	test_config_global clone.verifySignatures true &&
+	git clone --recurse-submodules signed-with-signed-submodule dst >out &&
+	test_i18ngrep "Commit [0-9a-f]\+ has a good GPG signature by " out
+'
+
+test_expect_success GPG 'clone unsigned with signed submodules and clone.verifySignatures=true' '
+	test_config_global clone.verifySignatures true &&
+	test_must_fail git clone --recurse-submodules unsigned-with-signed-submodule dst 2>out &&
+	test_path_is_missing dst &&
+	test_i18ngrep "Commit [0-9a-f]\+ does not have a GPG signature." out
+'
+
+test_expect_success GPG 'clone unsigned with signed submodules and --verify-signatures' '
+	test_must_fail git clone --recurse-submodules --verify-signatures \
+		unsigned-with-signed-submodule dst 2>out &&
+	test_path_is_missing dst &&
+	test_i18ngrep "Commit [0-9a-f]\+ does not have a GPG signature." out
+'
+
+test_expect_success GPG 'clone unsigned with unsigned submodules and clone.verifySignatures=true' '
+	test_config_global clone.verifySignatures true &&
+	test_must_fail git clone --recurse-submodules unsigned-with-unsigned-submodule dst 2>out &&
+	test_path_is_missing dst &&
+	test_i18ngrep "Commit [0-9a-f]\+ does not have a GPG signature." out
+'
+
+test_done
diff --git a/tag.c b/tag.c
index f6ad4171f9..deff55198a 100644
--- a/tag.c
+++ b/tag.c
@@ -13,17 +13,19 @@ const char *tag_type = "tag";
 static int run_gpg_verify(const struct object_id *oid, const char *buf,
 			  unsigned long size, unsigned flags)
 {
-	struct signature_check sigc;
+	struct signature_check sigc = { .result = 'N' };
 	size_t payload_size;
-	int ret;
-
-	memset(&sigc, 0, sizeof(sigc));
+	int ret = 1;
 
 	payload_size = parse_signature(buf, size);
 
 	if (size == payload_size) {
 		if (flags & GPG_VERIFY_VERBOSE)
 			write_in_full(1, buf, payload_size);
+
+		/* maybe print a detailed error message */
+		print_signature_buffer(oid, &sigc, ret, flags);
+
 		return error("no signature found");
 	}
 
-- 
2.25.0.rc1.302.gc71d20beed

