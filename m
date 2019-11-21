Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED42C432C3
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF942068E
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAOUnSH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfKUWFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:05:00 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52329 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfKUWFA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:05:00 -0500
Received: by mail-wm1-f66.google.com with SMTP id l1so5424877wme.2
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=suGgwvchBkO3S3lXVcP+pqRoztUaFjvojE6ACC2GhY8=;
        b=rAOUnSH9w1T/U13S7LyfsEjxSiPTPjhFTdUJQLglHd0Y356KymGyiMrE0HIy03C1F3
         t0BPmZhdT8hE+CQ357iI550nBYb0rnlbCvD/uega3UJuSWahM6GIeYlSDujvwpxI2mHx
         ZSs4G+RA6vjoz/5yl4nwOjmkvHeO3uTVMnA6JaelJT2acQtECsyfeqZwBrVeq0bYcWsq
         SKTkQLjyTmbP8ys9XXR2iYZwjbGA4h3wf1x3DzJDs0J8W+U8+icJ5J7EhltCOlJEIDl/
         k0V18A9CzrtBm7T2VMIFyL+i9aLD7j98SBUqWKICvOheUrTo1JOFL1CnD1SUpLZyAuUO
         Ce3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=suGgwvchBkO3S3lXVcP+pqRoztUaFjvojE6ACC2GhY8=;
        b=kZnzx6uWj8Uvhijy1YPAc6g6wM+ha7fwhZf2fblwKjMcJn1ffL2MTPJZNK4QMuw6Eo
         mud7+6Cyg/RnHvKwb2JbuDugxHBZgcE7ywN4C+7vLLOdF0UXPgPsWHOGb/iiiw0jjk7O
         fg6NRUMYPPsnsKbwAbQMZ90hxB+69018hTFAQkYPm9UO2gxawjcDy2rj+LvpI6JgLKD2
         etvuIYaRWUQMBr1pPFPIcpczQafV3R6YWgHqRTtC3mcNVDtz0/Qn1jHsSlft/YtgdAVJ
         m5kOl5cZxtGzK0aXU/vMTFosdQSxTd0BakVGOc5s1oAmzW56TR+W4MmUyoBaOiXqa1HH
         zsxQ==
X-Gm-Message-State: APjAAAUkfnaCrCsfSi724mybAm3nqVBoyoxUd9nB6bUjah3g+1dYCxGF
        1iHVfLzBBDWX8nGbQkeb8nz+BrpN
X-Google-Smtp-Source: APXvYqw5dzPbHmIxvaESnrqsAcjX4QOBAPQvwgGbg7lSC7wvv8kQishk9/cK7nWkGbGN/mJWN484lw==
X-Received: by 2002:a1c:f415:: with SMTP id z21mr13119853wma.140.1574373896903;
        Thu, 21 Nov 2019 14:04:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v128sm1247932wmb.14.2019.11.21.14.04.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:04:56 -0800 (PST)
Message-Id: <7ef5f2ef693153a0f786e1d913d4258059cd587a.1574373892.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
References: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
        <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:04:35 +0000
Subject: [PATCH v6 03/19] clone: add --sparse mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When someone wants to clone a large repository, but plans to work
using a sparse-checkout file, they either need to do a full
checkout first and then reduce the patterns they included, or
clone with --no-checkout, set up their patterns, and then run
a checkout manually. This requires knowing a lot about the repo
shape and how sparse-checkout works.

Add a new '--sparse' option to 'git clone' that initializes the
sparse-checkout file to include the following patterns:

	/*
	!/*/

These patterns include every file in the root directory, but
no directories. This allows a repo to include files like a
README or a bootstrapping script to grow enlistments from that
point.

During the 'git sparse-checkout init' call, we must first look
to see if HEAD is valid, since 'git clone' does not have a valid
HEAD at the point where it initializes the sparse-checkout. The
following checkout within the clone command will create the HEAD
ref and update the working directory correctly.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-clone.txt        |  8 +++++++-
 builtin/clone.c                    | 27 +++++++++++++++++++++++++++
 builtin/sparse-checkout.c          |  6 ++++++
 t/t1091-sparse-checkout-builtin.sh | 13 +++++++++++++
 4 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 34011c2940..0fe91d2f04 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
 	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
-	  [--[no-]remote-submodules] [--jobs <n>] [--] <repository>
+	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--] <repository>
 	  [<directory>]
 
 DESCRIPTION
@@ -156,6 +156,12 @@ objects from the source repository into a pack in the cloned repository.
 	used, neither remote-tracking branches nor the related
 	configuration variables are created.
 
+--sparse::
+	Initialize the sparse-checkout file so the working
+	directory starts with only the files in the root
+	of the repository. The sparse-checkout file can be
+	modified to grow the working directory as needed.
+
 --mirror::
 	Set up a mirror of the source repository.  This implies `--bare`.
 	Compared to `--bare`, `--mirror` not only maps local branches of the
diff --git a/builtin/clone.c b/builtin/clone.c
index c46ee29f0a..4348d962c9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -59,6 +59,7 @@ static const char *real_git_dir;
 static char *option_upload_pack = "git-upload-pack";
 static int option_verbosity;
 static int option_progress = -1;
+static int option_sparse_checkout;
 static enum transport_family family;
 static struct string_list option_config = STRING_LIST_INIT_NODUP;
 static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
@@ -146,6 +147,8 @@ static struct option builtin_clone_options[] = {
 	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 	OPT_BOOL(0, "remote-submodules", &option_remote_submodules,
 		    N_("any cloned submodules will use their remote-tracking branch")),
+	OPT_BOOL(0, "sparse", &option_sparse_checkout,
+		    N_("initialize sparse-checkout file to include only files at root")),
 	OPT_END()
 };
 
@@ -733,6 +736,27 @@ static void update_head(const struct ref *our, const struct ref *remote,
 	}
 }
 
+static int git_sparse_checkout_init(const char *repo)
+{
+	struct argv_array argv = ARGV_ARRAY_INIT;
+	int result = 0;
+	argv_array_pushl(&argv, "-C", repo, "sparse-checkout", "init", NULL);
+
+	/*
+	 * We must apply the setting in the current process
+	 * for the later checkout to use the sparse-checkout file.
+	 */
+	core_apply_sparse_checkout = 1;
+
+	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
+		error(_("failed to initialize sparse-checkout"));
+		result = 1;
+	}
+
+	argv_array_clear(&argv);
+	return result;
+}
+
 static int checkout(int submodule_progress)
 {
 	struct object_id oid;
@@ -1106,6 +1130,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
 
+	if (option_sparse_checkout && git_sparse_checkout_init(repo))
+		return 1;
+
 	remote = remote_get(option_origin);
 
 	strbuf_addf(&default_refspec, "+%s*:%s*", src_ref_prefix,
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index fcf97e9df8..e3418fbe2a 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -102,6 +102,7 @@ static int sparse_checkout_init(int argc, const char **argv)
 	char *sparse_filename;
 	FILE *fp;
 	int res;
+	struct object_id oid;
 
 	if (set_config(MODE_ALL_PATTERNS))
 		return 1;
@@ -126,6 +127,11 @@ static int sparse_checkout_init(int argc, const char **argv)
 	fprintf(fp, "/*\n!/*/\n");
 	fclose(fp);
 
+	if (get_oid("HEAD", &oid)) {
+		/* assume we are in a fresh repo */
+		return 0;
+	}
+
 reset_dir:
 	return update_working_directory();
 }
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 21143c529c..78c20cb7e3 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -82,4 +82,17 @@ test_expect_success 'init with existing sparse-checkout' '
 	test_cmp expect dir
 '
 
+test_expect_success 'clone --sparse' '
+	git clone --sparse repo clone &&
+	git -C clone sparse-checkout list >actual &&
+	cat >expect <<-EOF &&
+		/*
+		!/*/
+	EOF
+	test_cmp expect actual &&
+	ls clone >dir &&
+	echo a >expect &&
+	test_cmp expect dir
+'
+
 test_done
-- 
gitgitgadget

