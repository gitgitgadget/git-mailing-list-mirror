Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 426C11F404
	for <e@80x24.org>; Sun,  7 Jan 2018 18:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754488AbeAGSPy (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 13:15:54 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43407 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754372AbeAGSPL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 13:15:11 -0500
Received: by mail-qt0-f194.google.com with SMTP id w10so11265889qtb.10
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 10:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s7Lhz81WITP8/j2N4r0VunsCOjYYvwrh2Aprqf5nidw=;
        b=XoF9gwZOxW5kTqHbhKENuwx7kVn+5ye7PsHTas5yrpzR9iYDH9d2dqHp6ci94VD+nm
         ouKt3gA88xaKHWbglPBGvyneWY9E8PPEf2G75aeA714gomUsa5N4EOLOwqbBNkzl0PV4
         Phn1f1X0yKEI916XO5HjRyz7rNST8FP3rXcERfj3+YNEVpfD2ivEINFX/x0p9eJ0M/X7
         gZGJxlRfzNVjyrv1/Bg6cOrSnWm+aQYxbBM8262+qAlFZx0HmY0F4g/bmmzgclt4PxxE
         G0ksvSuMOlLuUTc5zjTnvex+UXF2TW9WLQEVQrMAXzKRDDR1fgZwduV2HpzJ5NpFQSAn
         liSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s7Lhz81WITP8/j2N4r0VunsCOjYYvwrh2Aprqf5nidw=;
        b=U2T0l72okSCcJZcxDrj1MExOxm1v7OWG8U23Mkcl0b6INBQ/YAgM7M2qAH4s35fUKr
         wM0c0vmt67meMS8rg4l++N7AKw+M2Fs5Y2tW11NlGTjQ/k6Oxlm6+nHfsQ7PiMXufYcL
         rcecL8lB0JkJwz3c9QGzIrAozM/+BtxgMsYzOtk0jjhSPjH4SjRg7eC1325rfiLzcLwL
         0YuZi+SYE9rGI+bb/0cNquvkOVKaxNsZj3aU9o1gPQQu26n/FYKPPh3XCgEIyZPBTujf
         J2tGuAE3TveLCrqnMxU7ROeoD0VscSaZaveie0URZG0Fvy2dUMvjc+LRCCAGxFD1JjP+
         7ieQ==
X-Gm-Message-State: AKwxytfB68Qr9XVyv8V029GeOwIPDFfOqvXs7Hw0DnhAmkHzpb+2wkGV
        /6tbd2JnJrKrLoRfBiH9yYpJfdpc9ZQ=
X-Google-Smtp-Source: ACJfBotiWVTlJT95+8PzisGH14gQIKQ08Ch4Tq20nMg+GM5VMUVELDCJ0f8U4YKoO/aktP6se0mzGw==
X-Received: by 10.200.51.179 with SMTP id c48mr12877619qtb.90.1515348910734;
        Sun, 07 Jan 2018 10:15:10 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id f38sm6599763qtc.73.2018.01.07.10.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jan 2018 10:15:10 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, stolee@gmail.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, Johannes.Shindelin@gmx.de,
        jrnieder@gmail.com
Subject: [RFC PATCH 05/18] midx: create midx builtin with --write mode
Date:   Sun,  7 Jan 2018 13:14:46 -0500
Message-Id: <20180107181459.222909-6-dstolee@microsoft.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180107181459.222909-1-dstolee@microsoft.com>
References: <20180107181459.222909-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commentary: As we extend the function of the midx builtin, I expand the
SYNOPSIS row of "git-midx.txt" but do not create multiple rows. If this
builtin doesn't change too much, I will rewrite the SYNOPSIS to be multi-
lined, such as in "git-branch.txt".

-- >8 --

Create, document, and implement the first ability of the midx builtin.

The --write subcommand creates a multi-pack-index for all indexed
packfiles within a given pack directory. If none is provided, the
objects/pack directory is implied. The arguments allow specifying the
pack directory so we can add MIDX files to alternates.

The packfiles are expected to be paired with pack-indexes and are
otherwise ignored. This simplifies the implementation and also keeps
compatibility with older versions of Git (or changing core.midx to
false).

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 .gitignore                 |   1 +
 Documentation/git-midx.txt |  54 +++++++++++++
 Makefile                   |   1 +
 builtin.h                  |   1 +
 builtin/midx.c             | 195 +++++++++++++++++++++++++++++++++++++++++++++
 command-list.txt           |   1 +
 git.c                      |   1 +
 7 files changed, 254 insertions(+)
 create mode 100644 Documentation/git-midx.txt
 create mode 100644 builtin/midx.c

diff --git a/.gitignore b/.gitignore
index 833ef3b0b7..545e195f2a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -95,6 +95,7 @@
 /git-merge-subtree
 /git-mergetool
 /git-mergetool--lib
+/git-midx
 /git-mktag
 /git-mktree
 /git-name-rev
diff --git a/Documentation/git-midx.txt b/Documentation/git-midx.txt
new file mode 100644
index 0000000000..17464222c1
--- /dev/null
+++ b/Documentation/git-midx.txt
@@ -0,0 +1,54 @@
+git-midx(1)
+============
+
+NAME
+----
+git-midx - Write and verify multi-pack-indexes (MIDX files).
+
+
+SYNOPSIS
+--------
+[verse]
+'git midx' --write [--pack-dir <pack_dir>]
+
+DESCRIPTION
+-----------
+Write a MIDX file.
+
+OPTIONS
+-------
+
+--pack-dir <pack_dir>::
+	Use given directory for the location of packfiles, pack-indexes,
+	and MIDX files.
+
+--write::
+	If specified, write a new midx file to the pack directory using
+	the packfiles present. Outputs the hash of the result midx file.
+
+EXAMPLES
+--------
+
+* Write a MIDX file for the packfiles in your local .git folder.
++
+------------------------------------------------
+$ git midx --write
+------------------------------------------------
+
+* Write a MIDX file for the packfiles in a different folder
++
+---------------------------------------------------------
+$ git midx --write --pack-dir ../../alt/pack/
+---------------------------------------------------------
+
+CONFIGURATION
+-------------
+
+core.midx::
+	The midx command will fail if core.midx is false.
+	Also, the written MIDX files will be ignored by other commands
+	unless core.midx is true.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index d0d810951f..5c458705c1 100644
--- a/Makefile
+++ b/Makefile
@@ -980,6 +980,7 @@ BUILTIN_OBJS += builtin/merge-index.o
 BUILTIN_OBJS += builtin/merge-ours.o
 BUILTIN_OBJS += builtin/merge-recursive.o
 BUILTIN_OBJS += builtin/merge-tree.o
+BUILTIN_OBJS += builtin/midx.o
 BUILTIN_OBJS += builtin/mktag.o
 BUILTIN_OBJS += builtin/mktree.o
 BUILTIN_OBJS += builtin/mv.o
diff --git a/builtin.h b/builtin.h
index 42378f3aa4..880383e341 100644
--- a/builtin.h
+++ b/builtin.h
@@ -188,6 +188,7 @@ extern int cmd_merge_ours(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_file(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_midx(int argc, const char **argv, const char *prefix);
 extern int cmd_mktag(int argc, const char **argv, const char *prefix);
 extern int cmd_mktree(int argc, const char **argv, const char *prefix);
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
diff --git a/builtin/midx.c b/builtin/midx.c
new file mode 100644
index 0000000000..4aae14cf8e
--- /dev/null
+++ b/builtin/midx.c
@@ -0,0 +1,195 @@
+#include "builtin.h"
+#include "cache.h"
+#include "config.h"
+#include "dir.h"
+#include "git-compat-util.h"
+#include "lockfile.h"
+#include "packfile.h"
+#include "parse-options.h"
+#include "midx.h"
+
+static char const * const builtin_midx_usage[] = {
+	N_("git midx --write [--pack-dir <packdir>]"),
+	NULL
+};
+
+static struct opts_midx {
+	const char *pack_dir;
+	int write;
+} opts;
+
+static int build_midx_from_packs(
+	const char *pack_dir,
+	const char **pack_names, uint32_t nr_packs,
+	const char **midx_id)
+{
+	struct packed_git **packs;
+	const char **installed_pack_names;
+	uint32_t i, j, nr_installed_packs = 0;
+	uint32_t nr_objects = 0;
+	struct pack_midx_entry *objects;
+	struct pack_midx_entry **obj_ptrs;
+	uint32_t nr_total_packs = nr_packs;
+	uint32_t pack_offset = 0;
+	struct strbuf pack_path = STRBUF_INIT;
+	int baselen;
+
+	if (!nr_total_packs) {
+		*midx_id = NULL;
+		return 0;
+	}
+
+	ALLOC_ARRAY(packs, nr_total_packs);
+	ALLOC_ARRAY(installed_pack_names, nr_total_packs);
+
+	strbuf_addstr(&pack_path, pack_dir);
+	strbuf_addch(&pack_path, '/');
+	baselen = pack_path.len;
+	for (i = 0; i < nr_packs; i++) {
+		strbuf_setlen(&pack_path, baselen);
+		strbuf_addstr(&pack_path, pack_names[i]);
+
+		strbuf_strip_suffix(&pack_path, ".pack");
+		strbuf_addstr(&pack_path, ".idx");
+
+		packs[nr_installed_packs] = add_packed_git(pack_path.buf, pack_path.len, 0);
+
+		if (packs[nr_installed_packs] != NULL) {
+			if (open_pack_index(packs[nr_installed_packs]))
+				continue;
+
+			nr_objects += packs[nr_installed_packs]->num_objects;
+			installed_pack_names[nr_installed_packs] = pack_names[i];
+			nr_installed_packs++;
+		}
+	}
+	strbuf_release(&pack_path);
+
+	if (!nr_objects || !nr_installed_packs) {
+		FREE_AND_NULL(packs);
+		FREE_AND_NULL(installed_pack_names);
+		*midx_id = NULL;
+		return 0;
+	}
+
+	ALLOC_ARRAY(objects, nr_objects);
+	nr_objects = 0;
+
+	for (i = pack_offset; i < nr_installed_packs; i++) {
+		struct packed_git *p = packs[i];
+
+		for (j = 0; j < p->num_objects; j++) {
+			struct pack_midx_entry entry;
+
+			if (!nth_packed_object_oid(&entry.oid, p, j))
+				die("unable to get sha1 of object %u in %s",
+				    i, p->pack_name);
+
+			entry.pack_int_id = i;
+			entry.offset = nth_packed_object_offset(p, j);
+
+			objects[nr_objects] = entry;
+			nr_objects++;
+		}
+	}
+
+	ALLOC_ARRAY(obj_ptrs, nr_objects);
+	for (i = 0; i < nr_objects; i++)
+		obj_ptrs[i] = &objects[i];
+
+	*midx_id = write_midx_file(pack_dir, NULL,
+		installed_pack_names, nr_installed_packs,
+		obj_ptrs, nr_objects);
+
+	FREE_AND_NULL(packs);
+	FREE_AND_NULL(installed_pack_names);
+	FREE_AND_NULL(obj_ptrs);
+	FREE_AND_NULL(objects);
+
+	return 0;
+}
+
+static int midx_write(void)
+{
+	const char **pack_names = NULL;
+	uint32_t i, nr_packs = 0;
+	const char *midx_id = 0;
+	DIR *dir;
+	struct dirent *de;
+
+	dir = opendir(opts.pack_dir);
+	if (!dir) {
+		error_errno("unable to open object pack directory: %s",
+			    opts.pack_dir);
+		return 1;
+	}
+
+	nr_packs = 256;
+	ALLOC_ARRAY(pack_names, nr_packs);
+
+	i = 0;
+	while ((de = readdir(dir)) != NULL) {
+		if (is_dot_or_dotdot(de->d_name))
+			continue;
+
+		if (ends_with(de->d_name, ".pack")) {
+			ALLOC_GROW(pack_names, i + 1, nr_packs);
+			pack_names[i++] = xstrdup(de->d_name);
+		}
+	}
+
+	nr_packs = i;
+	closedir(dir);
+
+	if (!nr_packs)
+		goto cleanup;
+
+	if (build_midx_from_packs(opts.pack_dir, pack_names, nr_packs, &midx_id))
+		die("failed to build MIDX");
+
+	if (midx_id == NULL)
+		goto cleanup;
+
+	printf("%s\n", midx_id);
+
+cleanup:
+	if (pack_names)
+		FREE_AND_NULL(pack_names);
+	return 0;
+}
+
+int cmd_midx(int argc, const char **argv, const char *prefix)
+{
+	static struct option builtin_midx_options[] = {
+		{ OPTION_STRING, 'p', "pack-dir", &opts.pack_dir,
+			N_("dir"),
+			N_("The pack directory containing set of packfile and pack-index pairs.") },
+		OPT_BOOL('w', "write", &opts.write,
+			N_("write midx file")),
+		OPT_END(),
+	};
+
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(builtin_midx_usage, builtin_midx_options);
+
+	git_config(git_default_config, NULL);
+	if (!core_midx)
+		die(_("git-midx requires core.midx=true"));
+
+	argc = parse_options(argc, argv, prefix,
+			     builtin_midx_options,
+			     builtin_midx_usage, 0);
+
+	if (!opts.pack_dir) {
+		struct strbuf path = STRBUF_INIT;
+		strbuf_addstr(&path, get_object_directory());
+		strbuf_addstr(&path, "/pack");
+		opts.pack_dir = strbuf_detach(&path, NULL);
+	}
+
+	if (opts.write)
+		return midx_write();
+
+	usage_with_options(builtin_midx_usage, builtin_midx_options);
+	return 0;
+}
diff --git a/command-list.txt b/command-list.txt
index a1fad28fd8..a7b9412182 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -87,6 +87,7 @@ git-merge-index                         plumbingmanipulators
 git-merge-one-file                      purehelpers
 git-mergetool                           ancillarymanipulators
 git-merge-tree                          ancillaryinterrogators
+git-midx                                plumbingmanipulators
 git-mktag                               plumbingmanipulators
 git-mktree                              plumbingmanipulators
 git-mv                                  mainporcelain           worktree
diff --git a/git.c b/git.c
index c870b9719c..87fbda8463 100644
--- a/git.c
+++ b/git.c
@@ -431,6 +431,7 @@ static struct cmd_struct commands[] = {
 	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
 	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
 	{ "merge-tree", cmd_merge_tree, RUN_SETUP },
+	{ "midx", cmd_midx, RUN_SETUP },
 	{ "mktag", cmd_mktag, RUN_SETUP },
 	{ "mktree", cmd_mktree, RUN_SETUP },
 	{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
-- 
2.15.0

