Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A3ACCA480
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 14:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbiF3OgF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 10:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbiF3Ofq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 10:35:46 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24700B8C
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 07:25:13 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id go6so18991755pjb.0
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 07:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MOHyAkLaFCdYMfvI4co0D9brN8xm91XShNRVrCVea68=;
        b=qeCpu6uS+hcaDoH/YtJEL0q3pDnbcc2PofDrnR2wZiY/aFB7kJVjsr5kbMUArcozQT
         f7VTy+ZzlIoqguB0xgVdGpyPO4yoAKPNTLOv7jnzSCeAHaHSRDmSS3mB0eHzh/itkGOe
         c3erSiW6LYwv165+JbjmlI0QUF+gD73vziDJ5gg/WzxlosAFE6iqVw02P5YSd4TNZG1X
         FxVNh8I3kIfE+TThjobu9Uf4bbeo3sybAymeVPa46+X76FEXTivtS0fkXwoj9bRpcArE
         fH4v3I+aHDt0lnyteJPsERU87QUAnjML9HCKw0vsegJ9WP92l8D2wjrAUK7mEupQceZq
         P6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MOHyAkLaFCdYMfvI4co0D9brN8xm91XShNRVrCVea68=;
        b=VhrSDizi5q2/J4fj/bru1dKgtQc654/HutZDjQCjGGvVw1FFGrHLQ66r1P8LFikFVB
         MoXdJPiXO66Sjfbv7RyLhRJlzawjxuxsVbdELSLFH/s9igEt55M0X2dSkTLokwmEiy9i
         SEqdnviQ7IDMEIUniNex+txT8Y2qQp9KPl5LIs0B058AJrFp/hdR81UUZ8LmCQYX/Ffx
         tbJggUN8qhGrr5cWbS33ADtW5LspNUNLKMRnepSXNTHTd66NbuniDiHzDmDeY2H3+5tk
         GMTvQq6VGBGs8zPGXgegs+g2pp1XBjkufdI/VwddDBiCi7Fs6TOl8nYk9RwsysBLBBzk
         Xopw==
X-Gm-Message-State: AJIora9prVc4pHF2BF8lBlZWCP4Kfy29HQud8yDMrfwZEEzQVK2w7et9
        p1U+Wl8N8+2fjZqXEqmKBgiwD0jZ93iUNLev
X-Google-Smtp-Source: AGRyM1sE0DYFttD0K/snhdUDFx5f1aaHMMGiRLm6vzO/veh454eCX0XPfNq+8dv6ek44/2BOu8FH8g==
X-Received: by 2002:a17:90b:4f89:b0:1ec:a57c:eee8 with SMTP id qe9-20020a17090b4f8900b001eca57ceee8mr12243207pjb.220.1656599112092;
        Thu, 30 Jun 2022 07:25:12 -0700 (PDT)
Received: from HB2.. ([106.212.243.72])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b0016909678e2csm13647377ple.292.2022.06.30.07.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 07:25:11 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: [PATCH 3/3] cat-file: add mailmap support
Date:   Thu, 30 Jun 2022 19:54:44 +0530
Message-Id: <20220630142444.651948-4-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.0.3.gdab82d6f0b
In-Reply-To: <20220630142444.651948-1-siddharthasthana31@gmail.com>
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git cat-file is not a plumbing command anymore, especially as it gained
more and more high level features like its `--batch-command` mode. So
tools do use it to get commit and tag contents that are then displayed
to users. This content which has author, committer or tagger
information, could benefit from passing through the mailmap mechanism,
before being sent or displayed.

This patch adds --[no-]use-mailmap command line option to the git
cat-file command. It also adds --[no-]mailmap option as an alias to
--[no-]use-mailmap.

At this time, this patch only adds a command line
option, but perhaps a `cat-file.mailmap` config option could be added as
well in the same way as for `git log`.

Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: John Cai <johncai86@gmail.com>
---
 Documentation/git-cat-file.txt |  6 ++++++
 builtin/cat-file.c             | 32 +++++++++++++++++++++++++++++++-
 t/t4203-mailmap.sh             | 30 ++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 24a811f0ef..887739c41f 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -63,6 +63,12 @@ OPTIONS
 	or to ask for a "blob" with `<object>` being a tag object that
 	points at it.
 
+--[no-]mailmap::
+--[no-]use-mailmap::
+	Use mailmap file to map author, committer and tagger names
+	and email addresses to canonical real names and email addresses.
+	See linkgit:git-shortlog[1].
+
 --textconv::
 	Show the content as transformed by a textconv filter. In this case,
 	`<object>` has to be of the form `<tree-ish>:<path>`, or `:<path>` in
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 50cf38999d..fc02b9f487 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -16,6 +16,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "promisor-remote.h"
+#include "mailmap.h"
 
 enum batch_mode {
 	BATCH_MODE_CONTENTS,
@@ -36,6 +37,20 @@ struct batch_options {
 
 static const char *force_path;
 
+static struct string_list mailmap = STRING_LIST_INIT_NODUP;
+static int use_mailmap;
+
+char *replace_idents_using_mailmap(char *object_buf, size_t *size)
+{
+	struct strbuf sb = STRBUF_INIT;
+	strbuf_attach(&sb, object_buf, *size, *size + 1);
+	rewrite_ident_line(&sb, "\nauthor ", &mailmap);
+	rewrite_ident_line(&sb, "\ncommitter ", &mailmap);
+	rewrite_ident_line(&sb, "\ntagger ", &mailmap);
+	*size = sb.len;
+	return strbuf_detach(&sb, NULL);
+}
+
 static int filter_object(const char *path, unsigned mode,
 			 const struct object_id *oid,
 			 char **buf, unsigned long *size)
@@ -152,6 +167,9 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		if (!buf)
 			die("Cannot read object %s", obj_name);
 
+		if (use_mailmap)
+			buf = replace_idents_using_mailmap(buf, &size);
+
 		/* otherwise just spit out the data */
 		break;
 
@@ -183,6 +201,9 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		}
 		buf = read_object_with_reference(the_repository, &oid,
 						 exp_type_id, &size, NULL);
+
+		if (use_mailmap)
+			buf = replace_idents_using_mailmap(buf, &size);
 		break;
 	}
 	default:
@@ -348,11 +369,15 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
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
@@ -843,6 +868,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE('s', NULL, &opt, N_("show object size"), 's'),
 		OPT_BOOL(0, "allow-unknown-type", &unknown_type,
 			  N_("allow -s and -t to work with broken/corrupt objects")),
+		OPT_BOOL(0, "use-mailmap", &use_mailmap, N_("use mail map file")),
+		OPT_ALIAS(0, "mailmap", "use-mailmap"),
 		/* Batch mode */
 		OPT_GROUP(N_("Batch objects requested on stdin (or --batch-all-objects)")),
 		OPT_CALLBACK_F(0, "batch", &batch, N_("format"),
@@ -885,6 +912,9 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	opt_cw = (opt == 'c' || opt == 'w');
 	opt_epts = (opt == 'e' || opt == 'p' || opt == 't' || opt == 's');
 
+	if (use_mailmap)
+		read_mailmap(&mailmap);
+
 	/* --batch-all-objects? */
 	if (opt == 'b')
 		batch.all_objects = 1;
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 0b2d21ec55..bfddc35d9d 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -963,4 +963,34 @@ test_expect_success SYMLINKS 'symlinks not respected in-tree' '
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
+	grep author log >actual &&
+	sed -e "/^author/q" actual >log &&
+	sed -e "s/ [0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$//" log >actual &&
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
+	grep author log >actual &&
+	sed -e "/^author/q" actual >log &&
+	sed -e "s/ [0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$//" log >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.37.0.3.g2093cce7fe.dirty

