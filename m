Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCF4C43334
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 07:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiGPHlh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 03:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiGPHlg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 03:41:36 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D0231906
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 00:41:35 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c3so5521022pfb.13
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 00:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cXU28ChBPwNPp34PUokCn8IiZZbY9kZSLNJKtYqKrgs=;
        b=jzpcUUVW3nSEK3CYmpSZdYA9lRUp0zASUnfp8veAl4e/JMJyZeiQLm9Lktq5eEAjRg
         hEvD6w/qgtMPMPwZX22v/lDBraDRCYhTlUvF/T4dpWnJRwO6VObQr74TXQVd2calJeC0
         Mhjh1nhkY9z+WwJ/L9aI5Puiaweh1P4PE9nqr11icVojKKnrFh6qbcYtjsaYP6a2ZOgE
         gIbp2LrIHerPHzqUOO/3ydUf1FLYK+89euhzQnZjxUU7XY+CSZka4tYkOzf2LDgaplmS
         L99+T2SxKvMw0eo/0es5g71T3WT50PRIhYQLDrtTdTHWsKYVuvQPI1LORPJ1eywxcjIg
         IjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cXU28ChBPwNPp34PUokCn8IiZZbY9kZSLNJKtYqKrgs=;
        b=HdQtJMqSjv5hbyH8xryE/CMo+IWLvFpPyTOI0ce90sivHPGBXueonOR0hrJA7eCI3C
         /PMDPhFludcwmaLNIchRYttBJibrXbhSoFWJdAmMbz9y/3qM91vGvTwL/l1+C7YyICPX
         Pyu+D4DBK2/HT4Kmyuvo8s7I8N/1HM5+HOiFn2RIUEe3/IuYu7W5GOHga0t9MLITMu3A
         z3wBAl4y9hVDAkvEk5NI4Y2sQYQL3MYD/AO4w0XBT5qDTIYD9jWfl4wxQlIqjWLBNXHq
         r/u2BK/EW3k9E7eK7rRJH4SRqtiGuNGxZBUeOhLDyh7QIZK8D908nycpZLOuM4YHUFjZ
         8M1g==
X-Gm-Message-State: AJIora/iTn6C8sPS/92++Z/pU27Xk2rfjHaynDFTk/v8j9dnh1YigXDM
        49kRPFc26GOvAOi8fCSr9rnDTvSsNnjuMzAu
X-Google-Smtp-Source: AGRyM1ubhFqKnuZJhtORPuU0YA7FwlO+Ha7siz7jyfJbRBzofjhDiUwbBz5kgal7+kEoFXqyQMIDfQ==
X-Received: by 2002:a63:6bc4:0:b0:40d:fd98:bb21 with SMTP id g187-20020a636bc4000000b0040dfd98bb21mr15310930pgc.249.1657957294554;
        Sat, 16 Jul 2022 00:41:34 -0700 (PDT)
Received: from HB2.. ([110.225.168.189])
        by smtp.gmail.com with ESMTPSA id i27-20020a63541b000000b004161e62a3a5sm4325923pgb.78.2022.07.16.00.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 00:41:34 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, congdanhqx@gmail.com,
        christian.couder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 4/4] cat-file: add mailmap support
Date:   Sat, 16 Jul 2022 13:10:55 +0530
Message-Id: <20220716074055.1786231-5-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.1.120.g001f220fb8
In-Reply-To: <20220716074055.1786231-1-siddharthasthana31@gmail.com>
References: <20220712160634.213956-1-siddharthasthana31@gmail.com>
 <20220716074055.1786231-1-siddharthasthana31@gmail.com>
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

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: John Cai <johncai86@gmail.com>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/git-cat-file.txt |  6 ++++
 builtin/cat-file.c             | 43 ++++++++++++++++++++++++-
 t/t4203-mailmap.sh             | 59 ++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 1 deletion(-)

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
index 0b2d21ec55..cd1cab3e54 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -963,4 +963,63 @@ test_expect_success SYMLINKS 'symlinks not respected in-tree' '
 	test_cmp expect actual
 '
 
+test_expect_success 'prepare for cat-file --mailmap' '
+	rm -f .mailmap &&
+	git commit --allow-empty -m foo --author="Orig <orig@example.com>"
+'
+
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
2.37.1.120.g001f220fb8

