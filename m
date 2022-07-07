Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D300C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 16:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbiGGQRJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 12:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbiGGQRG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 12:17:06 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BC81114
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 09:17:03 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id bh13so13447191pgb.4
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 09:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bCBwbpnvVcG3k36puu/RKxkaLjeq7Lz6ei2RFDqlNHU=;
        b=N1MJDalJqin0KV+v+BK/IPuTNRsECo6QReYM/nJUNQintv6CGq+2ej7eaDTYrMhd2p
         ZmEkdV3t1iL58Ob2PgWQsP7HeUsFVqaJ6sh0i7dPdpjKtgbdMBBSwgA8T5yv8a2/hzV7
         bNcHuVkOvIKrY/9THAnQJrx17tSaP05u5sJTZP5g7CYc7+JVJpi57L0cLQK6xfiMbWGt
         W7izFJ1J0gzFJUvHn6m75Kpu7LYDSm4+lYXZeF9y/o8V0iigQ0jXpYPLotyBYkHIDZoN
         tur4nHodIRu45YoISzN3/QYIZ/KXHIYSoEnE4mP0nG5oP11VXK9cUzJcd1Z2XDAEmbmL
         GPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bCBwbpnvVcG3k36puu/RKxkaLjeq7Lz6ei2RFDqlNHU=;
        b=oVgeLUzs5LfDioX4GQVbQud1QvjvP8Hcc/vQilqIh6LN4xZstAz4oAzcALUrU1BY1b
         Nj45mD90GEiJObp2ZNajn+jgax2ifiadKAikHiCfHHA0muEuusKCSEbsWIoq8sAu5Yzl
         58v2rsM/doUAipYxjyBdTHNFQNBsDcjvBL+ZSFNhMBKcWl2kW+CXQTt7tmiuUTfeAHwr
         XTJ7sthW4YvOtCq02PzV9m+QTHo3yGeFrr50dqjpfXFvcpnTXjeddJv06x0z1IfjczFz
         fvgXr/YeEZvTPILEcGBVqrrUC2yZ2VO2uYVgyoN/EZjGfmL57osA4GOcuTMuv97ShM4t
         sgCg==
X-Gm-Message-State: AJIora8ZWVfhHZrqw/M+XjGXHOCFFO4mu0pjXxrOB7wjhL2pWA0IrZrX
        IiDOjeGNtLFodZu5ZYokbwdEoMD7A2WBg+PP
X-Google-Smtp-Source: AGRyM1v7dZJRwETUe9X/oV4u2d9jH5NyzpNaM4qwbvzwrXGtsAMYoIEg9YlfTjjXk1ODyFA9m7LANQ==
X-Received: by 2002:a17:902:ba93:b0:16b:f484:65d3 with SMTP id k19-20020a170902ba9300b0016bf48465d3mr14307607pls.39.1657210622784;
        Thu, 07 Jul 2022 09:17:02 -0700 (PDT)
Received: from HB2.. ([122.175.103.204])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902a9c200b0015ee985999dsm27996199plr.97.2022.07.07.09.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 09:17:02 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 4/4] cat-file: add mailmap support
Date:   Thu,  7 Jul 2022 21:45:54 +0530
Message-Id: <20220707161554.6900-5-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.0.6.ga6a61a26c1.dirty
In-Reply-To: <20220707161554.6900-1-siddharthasthana31@gmail.com>
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
 <20220707161554.6900-1-siddharthasthana31@gmail.com>
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
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/git-cat-file.txt |  6 ++++
 builtin/cat-file.c             | 31 ++++++++++++++++++-
 t/t4203-mailmap.sh             | 54 ++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+), 1 deletion(-)

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
index 50cf38999d..6dc750a367 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -16,6 +16,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "promisor-remote.h"
+#include "mailmap.h"
 
 enum batch_mode {
 	BATCH_MODE_CONTENTS,
@@ -36,6 +37,19 @@ struct batch_options {
 
 static const char *force_path;
 
+static struct string_list mailmap = STRING_LIST_INIT_NODUP;
+static int use_mailmap;
+
+char *replace_idents_using_mailmap(char *object_buf, size_t *size)
+{
+	struct strbuf sb = STRBUF_INIT;
+	strbuf_attach(&sb, object_buf, *size, *size + 1);
+	const char *headers[] = { "author ", "committer ", "tagger ", NULL };
+	apply_mailmap_to_header(&sb, headers, &mailmap);
+	*size = sb.len;
+	return strbuf_detach(&sb, NULL);
+}
+
 static int filter_object(const char *path, unsigned mode,
 			 const struct object_id *oid,
 			 char **buf, unsigned long *size)
@@ -152,6 +166,9 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		if (!buf)
 			die("Cannot read object %s", obj_name);
 
+		if (use_mailmap)
+			buf = replace_idents_using_mailmap(buf, &size);
+
 		/* otherwise just spit out the data */
 		break;
 
@@ -183,6 +200,9 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		}
 		buf = read_object_with_reference(the_repository, &oid,
 						 exp_type_id, &size, NULL);
+
+		if (use_mailmap)
+			buf = replace_idents_using_mailmap(buf, &size);
 		break;
 	}
 	default:
@@ -348,11 +368,15 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 		void *contents;
 
 		contents = read_object_file(oid, &type, &size);
+
+		if (use_mailmap)
+			contents = replace_idents_using_mailmap(contents, &size);
+
 		if (!contents)
 			die("object %s disappeared", oid_to_hex(oid));
 		if (type != data->type)
 			die("object %s changed type!?", oid_to_hex(oid));
-		if (data->info.sizep && size != data->size)
+		if (data->info.sizep && size != data->size && !use_mailmap)
 			die("object %s changed size!?", oid_to_hex(oid));
 
 		batch_write(opt, contents, size);
@@ -843,6 +867,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE('s', NULL, &opt, N_("show object size"), 's'),
 		OPT_BOOL(0, "allow-unknown-type", &unknown_type,
 			  N_("allow -s and -t to work with broken/corrupt objects")),
+		OPT_BOOL(0, "use-mailmap", &use_mailmap, N_("use mail map file")),
+		OPT_ALIAS(0, "mailmap", "use-mailmap"),
 		/* Batch mode */
 		OPT_GROUP(N_("Batch objects requested on stdin (or --batch-all-objects)")),
 		OPT_CALLBACK_F(0, "batch", &batch, N_("format"),
@@ -885,6 +911,9 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
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
2.37.0.6.ga6a61a26c1.dirty

