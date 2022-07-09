Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CE5C43334
	for <git@archiver.kernel.org>; Sat,  9 Jul 2022 15:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiGIPm5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jul 2022 11:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiGIPmu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jul 2022 11:42:50 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1923D5AA
        for <git@vger.kernel.org>; Sat,  9 Jul 2022 08:42:49 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y9so1396358pff.12
        for <git@vger.kernel.org>; Sat, 09 Jul 2022 08:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yqf4H0DsuAVRlZz1akSmzJ4bXsQNsN/5xsq25XpKVN4=;
        b=GFC5VxPqFdV+kUfY58YAl1Pfo1PrGBtQz8f94Sq7s2TEVwObdLPAZC1pCs+M6Bpu6X
         P3yPgq9eFsobjACwOYnLLHlVbky22Fu1PwTEal3LGC8T6GymbuXshE/kKMmXXRSaoqBy
         wtI5RmjXifU5xwn7e2jc26GZpfh37lP4yBOSVOT7ewH972A2BrlNxtXT/O7e0HVFYMFu
         s9FFXp01VUwR9BjaL3YcBnrWQaM8r+E1kWxlNyPOFehmQFJnQ7lNx/CRzHL5PeZTCI6e
         c/ZpD4Z572h4gugZTnC7jr8l054hX4kRtWxAcDWO7a4RkOhLW+gu8KZO+CKFYsdbYKWv
         Zggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yqf4H0DsuAVRlZz1akSmzJ4bXsQNsN/5xsq25XpKVN4=;
        b=SUk+cMTRE6VgieCpYv9S26FOdgYIK75F73a32mOI8p5Y5kPWc8B6mwoQD+Ful1q0YY
         5pQLbuky69Mzb6jUcs4Ms5e+r6+6ItnN4/5KxKpPRGMzkL1e2VI1lsAV5F+S6KcgyNoU
         A2ac5xqfIZKhtl0jkMBY3UbLrL2abB63zZ+t0O72dlvJYr7alxrHlkrt2nlYQzIZGIUo
         GQogIHS4kjYAXQLPqYVP15hJiVwkwd0w8QKIhQLuRxw0mP3nko0rucqp3vkjhMDGxEiZ
         SLOeP3TyH0IjoKzs/KS7OkEP2Il5c5/uw90YVU2dDv+L3a8N7AxymI31hG5ExZPD9lp/
         5Ogg==
X-Gm-Message-State: AJIora+W/wNFfs4gL4QeEoBIdwJLDafMRWxmoBpPrT9I4u87h3A8tAJm
        jTYLTEFCDUMkOmrCs0vD3oDjPjBooa//hjRR
X-Google-Smtp-Source: AGRyM1tKAic0tqob7Qia8EKDvcjs0kV5JtgaLW4DivrQDs02FrgGdnFgHVKe0E3EP1L5behbO8X1Fg==
X-Received: by 2002:aa7:8649:0:b0:52a:baae:16c9 with SMTP id a9-20020aa78649000000b0052abaae16c9mr3329656pfo.26.1657381368802;
        Sat, 09 Jul 2022 08:42:48 -0700 (PDT)
Received: from HB2.. ([122.175.103.204])
        by smtp.gmail.com with ESMTPSA id jj9-20020a170903048900b0016be4d78792sm1473833plb.257.2022.07.09.08.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 08:42:48 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, congdanhqx@gmail.com,
        christian.couder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 4/4] cat-file: add mailmap support
Date:   Sat,  9 Jul 2022 21:11:49 +0530
Message-Id: <20220709154149.165524-5-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.0.6.g69b7ad898b
In-Reply-To: <20220709154149.165524-1-siddharthasthana31@gmail.com>
References: <20220707161554.6900-1-siddharthasthana31@gmail.com>
 <20220709154149.165524-1-siddharthasthana31@gmail.com>
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

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: John Cai <johncai86@gmail.com>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/git-cat-file.txt |  6 ++++
 builtin/cat-file.c             | 43 ++++++++++++++++++++++++++-
 t/t4203-mailmap.sh             | 54 ++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 1 deletion(-)

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
index 0b2d21ec55..c60a90615c 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
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

