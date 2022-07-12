Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A473C433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 16:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbiGLQHc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 12:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbiGLQHL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 12:07:11 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD81C84CB
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 09:07:10 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id o12so7846148pfp.5
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FBuJyKZhgWkLGgD0Rnbj4lGJBfJ9y5BUbI3MJC8ywjM=;
        b=o2rpD4j40058DG6uzttnIHjmgVIak5K9qd/pMGMEamfEsQH3+BW9qdSG4OIDtNXsLw
         f468dx+nPjLYDq1J+ldZ9Qb2VCVOStqOUKy4A6xd1uLHD4bUcw6aY6JDNBaQYJjtZOX4
         Wrt37UMvRdrwVFpg2dpAR+2/mTDnP1W4rWOZr2EsAp2X+W68trB8kSaNi2P9ADGITqmh
         tJ9BhMlqDG47b2r2uZsfg4Ijq3jo2mo8iFlM/MS6eBFONghugxpngqVN6pNoNKooxTNU
         S3+/J80z10Fkp5NDK87B4nDGFFeCwX48O8n7SQrUaT0/J7ujmOTnQLTfk87CNNjZxi8H
         q5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FBuJyKZhgWkLGgD0Rnbj4lGJBfJ9y5BUbI3MJC8ywjM=;
        b=Ji0IsJE2+IF4QHa+5nkI4ntD423/y6KU1knjKCrM7joxcZgo6/wAfaANzQjSnAbLw4
         btFA6O4H1Yj/eK2N9Zr5owhzkfhH8Jkt7JhG8pZc2MWlE7DWJ3z0OB/vu2jC3S1yBTt7
         ukgwyziHYgpThTA7nbESNWtQfiimO2vDyqvuQkPm9gYRviAbqCFIAgvvppr56WRBKAlA
         jedaI5l+ubin208CGQJAAkvJMX2GiBzjk6SpfBzGwhL11UTM31uAa6dfaZYc/KjMK5Bc
         m5oIgZDWwOdVQH3CcJIXWrX2QcKzth1p0ValCWWg4Fxok+Sv42SUawOoOKTQ5fSkKlKZ
         gmAQ==
X-Gm-Message-State: AJIora+jQ9TrrGSlFa1TAY3zllTsivuAxeNdGpVkg5Ck03relSCsyfix
        NNUSkluiFL7Jj8NPoY/gqnpnAmOk33cf+nsI
X-Google-Smtp-Source: AGRyM1tZoxCBguF7RWZ+H8o7uBUAIWmd64c7f3vj2lANc8++7cJMBXBLeoefRGEkwKnukSeL8wAnFg==
X-Received: by 2002:a65:6b92:0:b0:39c:c97b:1b57 with SMTP id d18-20020a656b92000000b0039cc97b1b57mr21306597pgw.517.1657642029096;
        Tue, 12 Jul 2022 09:07:09 -0700 (PDT)
Received: from HB2.. ([223.230.62.254])
        by smtp.gmail.com with ESMTPSA id u188-20020a6260c5000000b0050dc7628183sm7232376pfb.93.2022.07.12.09.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:07:07 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, congdanhqx@gmail.com,
        christian.couder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 4/4] cat-file: add mailmap support
Date:   Tue, 12 Jul 2022 21:36:34 +0530
Message-Id: <20220712160634.213956-5-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.0.6.g69b7ad898b
In-Reply-To: <20220712160634.213956-1-siddharthasthana31@gmail.com>
References: <20220709154149.165524-1-siddharthasthana31@gmail.com>
 <20220712160634.213956-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-cat-file is used by tools like GitLab to get commit tag contents
that are then displayed to users. This content which has author,
committer or tagger information, could benefit from passing through the
mailmap mechanism before being sent or displayed.

This patch adds --[no-]use-mailmap command line option to the git
cat-file command. It also adds --[no-]mailmap option as an alias to
--[no-]use-mailmap.

This patch also introduces new test cases to test the mailmap mechanism in
git cat-file command.

The tests added in this patch series rely on the side effects of the earlier
test case `set up symlink tests`. However, that test case is guarded behind the
`SYMLINKS` prereq, therefore it is not run e.g. on Windows which can cause the
added tests to fail on Windows. So, fix that by removing the prereq from the
`set up` test case, and adjusting its title to reflect its broadened responsibility.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: John Cai <johncai86@gmail.com>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/git-cat-file.txt |  6 ++++
 builtin/cat-file.c             | 43 +++++++++++++++++++++++++-
 t/t4203-mailmap.sh             | 56 +++++++++++++++++++++++++++++++++-
 3 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 24a811f0ef..1880e9bba1 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -63,6 +63,12 @@ OPTIONS
 	or to ask for a "blob" with `<object>` being a tag object that
 	points at it.
 
+--[no-]mailmap::
+--[no-]use-mailmap::
+       Use mailmap file to map author, committer and tagger names
+       and email addresses to canonical real names and email addresses.
+       See linkgit:git-shortlog[1].
+
 --textconv::
 	Show the content as transformed by a textconv filter. In this case,
 	`<object>` has to be of the form `<tree-ish>:<path>`, or `:<path>` in
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 50cf38999d..4b68216b51 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -16,6 +16,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "promisor-remote.h"
+#include "mailmap.h"
 
 enum batch_mode {
 	BATCH_MODE_CONTENTS,
@@ -36,6 +37,22 @@ struct batch_options {
 
 static const char *force_path;
 
+static struct string_list mailmap = STRING_LIST_INIT_NODUP;
+static int use_mailmap;
+
+static char *replace_idents_using_mailmap(char *, size_t *);
+
+static char *replace_idents_using_mailmap(char *object_buf, size_t *size)
+{
+	struct strbuf sb = STRBUF_INIT;
+	const char *headers[] = { "author ", "committer ", "tagger ", NULL };
+
+	strbuf_attach(&sb, object_buf, *size, *size + 1);
+	apply_mailmap_to_header(&sb, headers, &mailmap);
+	*size = sb.len;
+	return strbuf_detach(&sb, NULL);
+}
+
 static int filter_object(const char *path, unsigned mode,
 			 const struct object_id *oid,
 			 char **buf, unsigned long *size)
@@ -152,6 +169,12 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		if (!buf)
 			die("Cannot read object %s", obj_name);
 
+		if (use_mailmap) {
+			size_t s = size;
+			buf = replace_idents_using_mailmap(buf, &s);
+			size = cast_size_t_to_ulong(s);
+		}
+
 		/* otherwise just spit out the data */
 		break;
 
@@ -183,6 +206,12 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		}
 		buf = read_object_with_reference(the_repository, &oid,
 						 exp_type_id, &size, NULL);
+
+		if (use_mailmap) {
+			size_t s = size;
+			buf = replace_idents_using_mailmap(buf, &s);
+			size = cast_size_t_to_ulong(s);
+		}
 		break;
 	}
 	default:
@@ -348,11 +377,18 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 		void *contents;
 
 		contents = read_object_file(oid, &type, &size);
+
+		if (use_mailmap) {
+			size_t s = size;
+			contents = replace_idents_using_mailmap(contents, &s);
+			size = cast_size_t_to_ulong(s);
+		}
+
 		if (!contents)
 			die("object %s disappeared", oid_to_hex(oid));
 		if (type != data->type)
 			die("object %s changed type!?", oid_to_hex(oid));
-		if (data->info.sizep && size != data->size)
+		if (data->info.sizep && size != data->size && !use_mailmap)
 			die("object %s changed size!?", oid_to_hex(oid));
 
 		batch_write(opt, contents, size);
@@ -843,6 +879,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE('s', NULL, &opt, N_("show object size"), 's'),
 		OPT_BOOL(0, "allow-unknown-type", &unknown_type,
 			  N_("allow -s and -t to work with broken/corrupt objects")),
+		OPT_BOOL(0, "use-mailmap", &use_mailmap, N_("use mail map file")),
+		OPT_ALIAS(0, "mailmap", "use-mailmap"),
 		/* Batch mode */
 		OPT_GROUP(N_("Batch objects requested on stdin (or --batch-all-objects)")),
 		OPT_CALLBACK_F(0, "batch", &batch, N_("format"),
@@ -885,6 +923,9 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	opt_cw = (opt == 'c' || opt == 'w');
 	opt_epts = (opt == 'e' || opt == 'p' || opt == 't' || opt == 's');
 
+	if (use_mailmap)
+		read_mailmap(&mailmap);
+
 	/* --batch-all-objects? */
 	if (opt == 'b')
 		batch.all_objects = 1;
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 0b2d21ec55..dba0a8ac56 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -932,7 +932,7 @@ test_expect_success 'find top-level mailmap from subdir' '
 	test_cmp expect actual
 '
 
-test_expect_success SYMLINKS 'set up symlink tests' '
+test_expect_success 'prepare for symlink/--use-mailmap tests' '
 	git commit --allow-empty -m foo --author="Orig <orig@example.com>" &&
 	echo "New <new@example.com> <orig@example.com>" >map &&
 	rm -f .mailmap
@@ -963,4 +963,58 @@ test_expect_success SYMLINKS 'symlinks not respected in-tree' '
 	test_cmp expect actual
 '
 
+test_expect_success '--no-use-mailmap disables mailmap in cat-file' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-EOF &&
+	A U Thor <author@example.com> Orig <orig@example.com>
+	EOF
+	cat >expect <<-EOF &&
+	author Orig <orig@example.com>
+	EOF
+	git cat-file --no-use-mailmap commit HEAD >log &&
+	sed -n "/^author /s/\([^>]*>\).*/\1/p" log >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--use-mailmap enables mailmap in cat-file' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-EOF &&
+	A U Thor <author@example.com> Orig <orig@example.com>
+	EOF
+	cat >expect <<-EOF &&
+	author A U Thor <author@example.com>
+	EOF
+	git cat-file --use-mailmap commit HEAD >log &&
+	sed -n "/^author /s/\([^>]*>\).*/\1/p" log >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--no-mailmap disables mailmap in cat-file for annotated tag objects' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-EOF &&
+	Orig <orig@example.com> C O Mitter <committer@example.com>
+	EOF
+	cat >expect <<-EOF &&
+	tagger C O Mitter <committer@example.com>
+	EOF
+	git tag -a -m "annotated tag" v1 &&
+	git cat-file --no-mailmap -p v1 >log &&
+	sed -n "/^tagger /s/\([^>]*>\).*/\1/p" log >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--mailmap enables mailmap in cat-file for annotated tag objects' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-EOF &&
+	Orig <orig@example.com> C O Mitter <committer@example.com>
+	EOF
+	cat >expect <<-EOF &&
+	tagger Orig <orig@example.com>
+	EOF
+	git tag -a -m "annotated tag" v2 &&
+	git cat-file --mailmap -p v2 >log &&
+	sed -n "/^tagger /s/\([^>]*>\).*/\1/p" log >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.37.0.6.g69b7ad898b

