Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A711420A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 23:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbeLKXth (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 18:49:37 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]:39750 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbeLKXth (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 18:49:37 -0500
Received: by mail-qk1-f179.google.com with SMTP id q70so9736530qkh.6
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 15:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IALSmofIaWf1vFuXc45WCy6UQ2PMILhIWN78E2vXyv4=;
        b=ZpZwVopPduG06TSLIK8dc6Ys0tizIFr9ZsykaF1cNmjuRPILE0ZBquwgneuvDA1OoB
         BdPDS5dSMYJbkdd7rW5M00hCjxBhzStvgqWBxI6oYLAJSY8hui1VqBFSW3nVYuxOqUp8
         P/uGQiu7cUbrtWpJX2WtfEuVR/P+WhBRU9VpB1warjTGtod7Jzo+svgAI1Y5glX7bPem
         kwSeVW/5OblLfwsZ/Y7lHdeP6ToNwqJgzVdwCUyDY1RMDs6AiKtKXZLp+1FmnDLfMTLS
         1pdffGIJzi2BLMLU1G43tp2wQ+du9g9F+/f17gqemXD3GuFHlZA9VOVHELK/a0dEBn9S
         WEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=IALSmofIaWf1vFuXc45WCy6UQ2PMILhIWN78E2vXyv4=;
        b=HPQyEcoJs8ER3ow95hICvqxEEAVzLig5847MLkEI/IZMcQ8gLcPJswt2B6bMXo3vX2
         zSmgzl8lf8Q+HmX+NuLVj3Tp2cbg6TVCu3PcXTJtRz87LxZks1+Hjr+zGKDhmn0E/H6P
         5DCinOyMbsra4VJZCEwXcdolKlXTNDv59QKruw9HRpLz+SnZPbDzpTC7+cy+HRyPREOv
         hD2fBgkj5mi3kfIrbjRGeS68/NUPoHw4BzgzD/z18YBncbNHMSRJzdco2QuFvJa5cTyg
         SJHcwnaYsFklLO7Q+KZzpCBpLxMbLsdSd4z20K826llsd9fpHFXYSJLR163EtiCYa4MK
         p9Wg==
X-Gm-Message-State: AA+aEWZ1CtxLpix3BZYJXAzXcgXhW7oIpLtWH7UaF3eyhCr07kgF64Hc
        9I5jWTSQAZVrK0HxEyx1am+m02j1
X-Google-Smtp-Source: AFSGD/Wsn7jgD9YCBeYUiqwqvv4IOe3yCi7Z6/ZKSDlizY82lTAbRiOvQYcy28D9i/yWWXkyAZVmIg==
X-Received: by 2002:a37:688c:: with SMTP id d134mr16540855qkc.57.1544572175408;
        Tue, 11 Dec 2018 15:49:35 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:fd8f])
        by smtp.gmail.com with ESMTPSA id v186sm8666802qkd.13.2018.12.11.15.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 15:49:34 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     git@vger.kernel.org, Junio C Hamano <jch2355@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     kernel-team@fb.com, Tejun Heo <htejun@fb.com>
Subject: [PATCH 3/5] notes: Implement git-reverse-trailer-xrefs
Date:   Tue, 11 Dec 2018 15:49:07 -0800
Message-Id: <20181211234909.2855638-4-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211234909.2855638-1-tj@kernel.org>
References: <20181211234909.2855638-1-tj@kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tejun Heo <htejun@fb.com>

Some trailers refer to other commits.  Let's call them xrefs
(cross-references).  For example, a cherry pick trailer points to the
source commit.  It is sometimes useful to build a reverse map of these
xrefs - ie. source -> cherry-pick instead of cherry-pick -> source.

This patch implements git-reverse-trailer-xrefs which can process a
given trailer for the specified commits and generate and update the
matching refs/notes/xref- notes.

The command reverse-maps trailers beginning with --trailer-prefix and
stores them in --ref notes with each line tagged with --tag.  It also
has a refs/notes/xref-cherry-picks preset for the three params.

Signed-off-by: Tejun Heo <htejun@fb.com>
---
 Documentation/git-reverse-trailer-xrefs.txt | 136 +++++++++++++++++
 Makefile                                    |   1 +
 builtin.h                                   |   1 +
 builtin/reverse-trailer-xrefs.c             | 160 ++++++++++++++++++++
 git.c                                       |   1 +
 5 files changed, 299 insertions(+)
 create mode 100644 Documentation/git-reverse-trailer-xrefs.txt
 create mode 100644 builtin/reverse-trailer-xrefs.c

diff --git a/Documentation/git-reverse-trailer-xrefs.txt b/Documentation/git-reverse-trailer-xrefs.txt
new file mode 100644
index 000000000..20d260486
--- /dev/null
+++ b/Documentation/git-reverse-trailer-xrefs.txt
@@ -0,0 +1,136 @@
+git-reverse-trailer-xrefs(1)
+============================
+
+NAME
+----
+git-reverse-trailer-xrefs - Record reverse-map of trailer commit references into notes
+
+SYNOPSIS
+--------
+[verse]
+`git reverse_trailer_xrefs` --xref-cherry-picks [--clear] [<options>] [<commit-ish>...]
+`git reverse_trailer_xrefs` --trailer-prefix=<prefix> --ref=<notes-ref> [--tag=<tag>] [<options>] [<commit-ish>...]
+`git reverse_trailer_xrefs` --ref=<notes-ref> --clear [<options>] [<commit-ish>...]
+
+
+DESCRIPTION
+-----------
+Record or clear reverse-map of trailer commit references in the
+specified notes ref.
+
+Some commit trailers reference other commits. For example,
+`git-cherry-pick -x` adds the following trailer to record the source
+commit.
+----------
+(cherry picked from commit <source-commit-id>)
+----------
+The reverse mappings of such cross references can be useful. For
+cherry-picks, it would allow finding all the cherry-picked commits of
+a given source commit.  `git-reverse-trailer-xrefs` can be used to
+create and maintain such reverse mappings in notes.
+
+When used with `--xref-cherry-picks`, the cherry-pick trailers are
+parsed from the specified commits and the reverse mappings are
+recorded in the `refs/notes/xref-cherry-picks` notes of the source
+commits in the following format.
+----------
+Cherry-picked-to: <destination-commit-id>
+----------
+
+When a note with its notes ref starting with `refs/notes/xref-` is
+formatted to be displayed with the commit for, e.g., `git-show` or
+`git-log`, the destination commit is followed recursively and the
+matching notes are shown with increasing level of indentations.
+
+`--trailer-prefix`, `--notes` and `--tag` can be used to use a custom
+set of trailer, notes ref and reverse mapping tag.
+
+OPTIONS
+-------
+<commit-ish>...::
+	Commit-ish object names to describe.  Defaults to HEAD if omitted.
+
+--xref-cherry-picks::
+	Use the preset to reverse map `git-cherry-pick -x`
+	trailers. `--trailer-prefix` is set to `(cherry-picked from
+	commit `, `--notes` is set to `refs/notes/xref-cherry-picks`
+	and `--tag` is set to `Cherry-picked-to`. This option can't be
+	specified with the three preset options.
+
+--trailer-prefix=<prefix>::
+	Process trailers which start with <prefix>. It is matched
+	character-by-character and should be followed by the
+	referenced commit ID. When there are multiple matching
+	trailers, the last one is used.
+
+--notes=<notes-ref>::
+	The notes ref to use for the reverse mapping. While this can
+	be any notes ref, it is recommented to use ones starting with
+	`refs/notes/xref-` as they are recognized as cross-referencing
+	notes and handled specially when updating and showing.
+
+--tag=<tag>::
+	Optional tag to use when generating reverse reference
+	notes. If specified, each note line is formatted as `<tag>:
+	<commit-id>`; otherwise, `<commit-id>`.
+
+--clear::
+	Instead of creating reverse mapping notes, clear them from the
+	specified commits.
+
+
+EXAMPLES
+--------
+
+Assume the following history. Development is happening in "master" and
+releases are branched off and fixes are cherry-picked into them.
+
+------------
+	D'---E'' release-B
+       /
+      C'      E' release-D
+     /       /
+A---B---C---D---E master
+------------
+
+The following cherry-picks took place.
+
+------------
+C -> C'
+D -> D'
+E -> E' -> E''
+------------
+
+The reverse mappings for all commits can be created using the
+following command.
+
+------------
+$ git reverse-trailer-xrefs --all --xref-cherry-picks
+------------
+
+With the notes added, where each commit ended up can be easily
+determined.
+
+------------
+$ git log --notes=xref-cherry-picks --oneline | git name-rev --name-only --stdin
+4b165af commit E
+Notes (xref-cherry-picks):
+    Cherry-picked-to: release-D
+    Cherry-picked-to:   release-B
+
+82bf1f3 commit D
+Notes (xref-cherry-picks):
+    Cherry-picked-to: release-B~1
+
+364eccf commit C
+Notes (xref-cherry-picks):
+    Cherry-picked-to: release-B~2
+
+ed3adf3 commit B
+ddd1bf2 commit A
+------------
+
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 1a44c811a..3c23ecf9d 100644
--- a/Makefile
+++ b/Makefile
@@ -1086,6 +1086,7 @@ BUILTIN_OBJS += builtin/multi-pack-index.o
 BUILTIN_OBJS += builtin/mv.o
 BUILTIN_OBJS += builtin/name-rev.o
 BUILTIN_OBJS += builtin/notes.o
+BUILTIN_OBJS += builtin/reverse-trailer-xrefs.o
 BUILTIN_OBJS += builtin/pack-objects.o
 BUILTIN_OBJS += builtin/pack-redundant.o
 BUILTIN_OBJS += builtin/pack-refs.o
diff --git a/builtin.h b/builtin.h
index 6538932e9..51089e258 100644
--- a/builtin.h
+++ b/builtin.h
@@ -195,6 +195,7 @@ extern int cmd_multi_pack_index(int argc, const char **argv, const char *prefix)
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
 extern int cmd_notes(int argc, const char **argv, const char *prefix);
+extern int cmd_reverse_trailer_xrefs(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_redundant(int argc, const char **argv, const char *prefix);
 extern int cmd_patch_id(int argc, const char **argv, const char *prefix);
diff --git a/builtin/reverse-trailer-xrefs.c b/builtin/reverse-trailer-xrefs.c
new file mode 100644
index 000000000..0edb3b91a
--- /dev/null
+++ b/builtin/reverse-trailer-xrefs.c
@@ -0,0 +1,160 @@
+#include "builtin.h"
+#include "cache.h"
+#include "strbuf.h"
+#include "repository.h"
+#include "config.h"
+#include "commit.h"
+#include "blob.h"
+#include "notes.h"
+#include "notes-utils.h"
+#include "trailer.h"
+#include "revision.h"
+#include "list-objects.h"
+#include "object-store.h"
+#include "parse-options.h"
+
+static const char * const reverse_trailer_xrefs_usage[] = {
+	N_("git reverse_trailer_xrefs --xref-cherry-picks [--clear] [<options>] [<commit-ish>...]"),
+	N_("git reverse_trailer_xrefs --trailer-prefix=<prefix> --notes=<notes-ref> --tag=<tag> [<options>] [<commit-ish>...]"),
+	N_("git reverse_trailer_xrefs --notes=<notes-ref> --clear [<options>] [<commit-ish>...]"),
+	NULL
+};
+
+#define CHERRY_PICKED_PREFIX	"(cherry picked from commit "
+#define CHERRY_PICKS_REF	"refs/notes/xref-cherry-picks"
+#define CHERRY_PICKED_TO_TAG	"Cherry-picked-to"
+
+static int verbose;
+
+static void clear_trailer_xref_note(struct commit *commit, void *data)
+{
+	struct notes_tree *tree = data;
+	int status;
+
+	status = remove_note(tree, commit->object.oid.hash);
+
+	if (verbose) {
+		if (status)
+			fprintf(stderr, "Object %s has no note\n",
+				oid_to_hex(&commit->object.oid));
+		else
+			fprintf(stderr, "Removing note for object %s\n",
+				oid_to_hex(&commit->object.oid));
+	}
+}
+
+static void record_trailer_xrefs(struct commit *commit, void *data)
+{
+	trailer_rev_xrefs_record(data, commit);
+}
+
+static int note_trailer_xrefs(struct notes_tree *tree,
+			      struct commit *dst_commit,
+			      struct object_array *src_objs, const char *tag)
+{
+	char dst_hex[GIT_MAX_HEXSZ + 1];
+	struct strbuf note = STRBUF_INIT;
+	struct object_id note_oid;
+	int i, ret;
+
+	oid_to_hex_r(dst_hex, &dst_commit->object.oid);
+
+	for (i = 0; i < src_objs->nr; i++) {
+		const char *hex = src_objs->objects[i].name;
+
+		if (tag)
+			strbuf_addf(&note, "%s: %s\n", tag, hex);
+		else
+			strbuf_addf(&note, "%s\n", tag);
+		if (verbose)
+			fprintf(stderr, "Adding note %s -> %s\n", dst_hex, hex);
+	}
+
+	ret = write_object_file(note.buf, note.len, blob_type, &note_oid);
+	strbuf_release(&note);
+	if (ret)
+		return ret;
+
+	ret = add_note(tree, &dst_commit->object.oid, &note_oid, NULL);
+	return ret;
+}
+
+static int reverse_trailer_xrefs(struct rev_info *revs, int clear,
+				 const char *trailer_prefix,
+				 const char *notes_ref, const char *tag)
+{
+	struct notes_tree tree = { };
+	int i, ret;
+
+	init_notes(&tree, notes_ref, NULL, NOTES_INIT_WRITABLE);
+
+	if (prepare_revision_walk(revs))
+		die("revision walk setup failed");
+
+	if (clear) {
+		traverse_commit_list(revs, clear_trailer_xref_note, NULL, &tree);
+	} else {
+		struct trailer_rev_xrefs rxrefs;
+		struct commit *dst_commit;
+		struct object_array *src_objs;
+
+		trailer_rev_xrefs_init(&rxrefs, trailer_prefix);
+		traverse_commit_list(revs, record_trailer_xrefs, NULL, &rxrefs);
+
+		trailer_rev_xrefs_for_each(&rxrefs, i, dst_commit, src_objs) {
+			ret = note_trailer_xrefs(&tree, dst_commit, src_objs,
+						 tag);
+			if (ret)
+				return ret;
+		}
+
+		trailer_rev_xrefs_release(&rxrefs);
+	}
+
+	commit_notes(&tree, "Notes updated by 'git reverse-trailer-xrefs'");
+	return 0;
+}
+
+int cmd_reverse_trailer_xrefs(int argc, const char **argv, const char *prefix)
+{
+	struct rev_info revs;
+	struct setup_revision_opt s_r_opt = {
+		.def = "HEAD",
+		.revarg_opt = REVARG_CANNOT_BE_FILENAME
+	};
+	int cherry = 0, clear = 0;
+	const char *trailer_prefix = NULL, *notes_ref = NULL, *tag = NULL;
+	struct option options[] = {
+		OPT_BOOL(0, "xref-cherry-picks", &cherry, N_("use preset for xref-cherry-picks notes")),
+		OPT_STRING(0, "trailer-prefix", &trailer_prefix, N_("prefix"), N_("process trailers starting with <prefix>")),
+		OPT_STRING(0, "notes", &notes_ref, N_("notes-ref"), N_("update notes in <notes-ref>")),
+		OPT_STRING(0, "tag", &tag, N_("tag"), N_("tag xref notes with <tag>")),
+		OPT_BOOL(0, "clear", &clear, N_("clear trailer xref notes from the specified commits")),
+		OPT__VERBOSE(&verbose, N_("verbose")),
+		OPT_END()
+	};
+
+	git_config(git_default_config, NULL);
+
+	argc = parse_options(argc, argv, prefix, options,
+			     reverse_trailer_xrefs_usage,
+			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN);
+
+	init_revisions(&revs, prefix);
+	argc = setup_revisions(argc, argv, &revs, &s_r_opt);
+
+	if (cherry) {
+		trailer_prefix = CHERRY_PICKED_PREFIX;
+		notes_ref = CHERRY_PICKS_REF;
+		tag = CHERRY_PICKED_TO_TAG;
+	}
+
+	if (!notes_ref || (!clear && (!trailer_prefix || !tag)))
+		die(_("insufficient arguments"));
+
+	if (argc > 1)
+		die(_("unrecognized argument: %s"), argv[1]);
+
+	return reverse_trailer_xrefs(&revs, clear,
+				     trailer_prefix, notes_ref, tag);
+}
diff --git a/git.c b/git.c
index 2f604a41e..4948c8e01 100644
--- a/git.c
+++ b/git.c
@@ -515,6 +515,7 @@ static struct cmd_struct commands[] = {
 	{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 	{ "name-rev", cmd_name_rev, RUN_SETUP },
 	{ "notes", cmd_notes, RUN_SETUP },
+	{ "reverse-trailer-xrefs", cmd_reverse_trailer_xrefs, RUN_SETUP },
 	{ "pack-objects", cmd_pack_objects, RUN_SETUP },
 	{ "pack-redundant", cmd_pack_redundant, RUN_SETUP | NO_PARSEOPT },
 	{ "pack-refs", cmd_pack_refs, RUN_SETUP },
-- 
2.17.1

