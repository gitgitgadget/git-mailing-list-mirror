Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E33CF1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 21:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732636AbfI3VKa (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 17:10:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43952 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732627AbfI3VK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 17:10:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id v27so8030960pgk.10
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 14:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GFKgcZauxsdso775qOgmHA1C2fKfz0Ftwuh6j+795w0=;
        b=KxpuMEML1vRfcGlRW0y5F9x5FgXBai9xQxtKVAagpGp48Ysdmj/ZXpjP3OWAsRaAXf
         oHTDP1QYxa6E41jOgCrGwBf3LvTJQAn/edYRNkxQPJkxm97rVcMIjGiFon9AQ0gqmuwI
         RNxO2bNwRUVhFtRES0Gkb24pBf3ILTUY1L5FkFmvNdHatjiq7ZgQ7x5R8HanSMfMV+M/
         O5168usQxtAqehzKQT2dXpjbUfWxU78K783juEiuk9BiCeImrKJWXt6dpWwmJQy7tu+y
         C3e29pSEiRg9RR8KfR7CHfodaUXq7sZ9I/jeILg1lASZLZSnyE6uqjV2lPUEH7OMpfJL
         Zjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GFKgcZauxsdso775qOgmHA1C2fKfz0Ftwuh6j+795w0=;
        b=e+Va3xmM7gqSUrCh69VwHloDN/oNbjfENdmMcaVFEObXH6dJ9tspdybq/QzsXdcFMX
         +48rfrdb1OYeFHE9trk7VlWhjsqK9DWioLQjmQ9ruBSAfP6P9QEo9CA5T0wUcXXTzXuo
         DvGv22QrcbPVi++vvYjRWXeav/Cmn82GDTjxD3nctvz26aSzsbsm3NlrzVhM+1WevP0L
         9pXxcM2eZCx3ykb1AgS1zKWGCjTn2nwGRZMjlgMDrTbSErVPTHDky+hFX3e1QmF+RLQY
         RB4JN2a4Nc0F8xSqHjQzWKtgewwwxzI6hRafhPvJB5u/3o+Ev0b3U8ELJHx064ILAwmN
         epUw==
X-Gm-Message-State: APjAAAVXUZxEIpS838df8ZxT5yJftqUKcGXngJoGNmNCRpp49+xy/YZP
        uODqsK58ikAqagtybKM22Lpb/UUhUls=
X-Google-Smtp-Source: APXvYqy/SP23qbDjmKyGIJJJUwTmqJDJ9h2jpsCz8BGd386EHzB2dPthSZH6tSeNc8C8gaDi4wS6Ig==
X-Received: by 2002:a65:6102:: with SMTP id z2mr26135164pgu.391.1569877827361;
        Mon, 30 Sep 2019 14:10:27 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id w11sm13404609pfd.116.2019.09.30.14.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Sep 2019 14:10:26 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 4/8] fast-import: add support for new 'alias' command
Date:   Mon, 30 Sep 2019 14:10:14 -0700
Message-Id: <20190930211018.23633-5-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.264.gac739dbb79
In-Reply-To: <20190930211018.23633-1-newren@gmail.com>
References: <20190925014005.17056-1-newren@gmail.com>
 <20190930211018.23633-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fast-export and fast-import have nice --import-marks flags which allow
for incremental migrations.  However, if there is a mark in
fast-export's file of marks without a corresponding mark in the one for
fast-import, then we run the risk that fast-export tries to send new
objects relative to the mark it knows which fast-import does not,
causing fast-import to fail.

This arises in practice when there is a filter of some sort running
between the fast-export and fast-import processes which prunes some
commits programmatically.  Provide such a filter with the ability to
alias pruned commits to their most recent non-pruned ancestor.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-fast-import.txt | 22 +++++++++++
 fast-import.c                     | 62 ++++++++++++++++++++++++++-----
 t/t9300-fast-import.sh            |  5 +++
 3 files changed, 79 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 4977869465..a3f1e0c5e4 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -337,6 +337,13 @@ and control the current import process.  More detailed discussion
 	`commit` command.  This command is optional and is not
 	needed to perform an import.
 
+`alias`::
+	Record that a mark refers to a given object without first
+	creating any new object.  Using --import-marks and referring
+	to missing marks will cause fast-import to fail, so aliases
+	can provide a way to set otherwise pruned commits to a valid
+	value (e.g. the nearest non-pruned ancestor).
+
 `checkpoint`::
 	Forces fast-import to close the current packfile, generate its
 	unique SHA-1 checksum and index, and start a new packfile.
@@ -914,6 +921,21 @@ a data chunk which does not have an LF as its last byte.
 +
 The `LF` after `<delim> LF` is optional (it used to be required).
 
+`alias`
+~~~~~~~
+Record that a mark refers to a given object without first creating any
+new object.
+
+....
+	'alias' LF
+	mark
+	'to' SP <commit-ish> LF
+	LF?
+....
+
+For a detailed description of `<commit-ish>` see above under `from`.
+
+
 `checkpoint`
 ~~~~~~~~~~~~
 Forces fast-import to close the current packfile, start a new one, and to
diff --git a/fast-import.c b/fast-import.c
index 0042440487..9a12850d16 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2491,18 +2491,14 @@ static void parse_from_existing(struct branch *b)
 	}
 }
 
-static int parse_from(struct branch *b)
+static int parse_objectish(struct branch *b, const char *objectish)
 {
-	const char *from;
 	struct branch *s;
 	struct object_id oid;
 
-	if (!skip_prefix(command_buf.buf, "from ", &from))
-		return 0;
-
 	oidcpy(&oid, &b->branch_tree.versions[1].oid);
 
-	s = lookup_branch(from);
+	s = lookup_branch(objectish);
 	if (b == s)
 		die("Can't create a branch from itself: %s", b->name);
 	else if (s) {
@@ -2510,8 +2506,8 @@ static int parse_from(struct branch *b)
 		oidcpy(&b->oid, &s->oid);
 		oidcpy(&b->branch_tree.versions[0].oid, t);
 		oidcpy(&b->branch_tree.versions[1].oid, t);
-	} else if (*from == ':') {
-		uintmax_t idnum = parse_mark_ref_eol(from);
+	} else if (*objectish == ':') {
+		uintmax_t idnum = parse_mark_ref_eol(objectish);
 		struct object_entry *oe = find_mark(idnum);
 		if (oe->type != OBJ_COMMIT)
 			die("Mark :%" PRIuMAX " not a commit", idnum);
@@ -2525,13 +2521,13 @@ static int parse_from(struct branch *b)
 			} else
 				parse_from_existing(b);
 		}
-	} else if (!get_oid(from, &b->oid)) {
+	} else if (!get_oid(objectish, &b->oid)) {
 		parse_from_existing(b);
 		if (is_null_oid(&b->oid))
 			b->delete = 1;
 	}
 	else
-		die("Invalid ref name or SHA1 expression: %s", from);
+		die("Invalid ref name or SHA1 expression: %s", objectish);
 
 	if (b->branch_tree.tree && !oideq(&oid, &b->branch_tree.versions[1].oid)) {
 		release_tree_content_recursive(b->branch_tree.tree);
@@ -2542,6 +2538,26 @@ static int parse_from(struct branch *b)
 	return 1;
 }
 
+static int parse_from(struct branch *b)
+{
+	const char *from;
+
+	if (!skip_prefix(command_buf.buf, "from ", &from))
+		return 0;
+
+	return parse_objectish(b, from);
+}
+
+static int parse_objectish_with_prefix(struct branch *b, const char *prefix)
+{
+	const char *base;
+
+	if (!skip_prefix(command_buf.buf, prefix, &base))
+		return 0;
+
+	return parse_objectish(b, base);
+}
+
 static struct hash_list *parse_merge(unsigned int *count)
 {
 	struct hash_list *list = NULL, **tail = &list, *n;
@@ -3089,6 +3105,28 @@ static void parse_progress(void)
 	skip_optional_lf();
 }
 
+static void parse_alias(void)
+{
+	struct object_entry *e;
+	struct branch b;
+
+	skip_optional_lf();
+	read_next_command();
+
+	/* mark ... */
+	parse_mark();
+	if (!next_mark)
+		die(_("Expected 'mark' command, got %s"), command_buf.buf);
+
+	/* to ... */
+	memset(&b, 0, sizeof(b));
+	if (!parse_objectish_with_prefix(&b, "to "))
+		die(_("Expected 'to' command, got %s"), command_buf.buf);
+	e = find_object(&b.oid);
+	assert(e);
+	insert_mark(next_mark, e);
+}
+
 static char* make_fast_import_path(const char *path)
 {
 	if (!relative_marks_paths || is_absolute_path(path))
@@ -3216,6 +3254,8 @@ static int parse_one_feature(const char *feature, int from_stream)
 		option_import_marks(arg, from_stream, 1);
 	} else if (skip_prefix(feature, "export-marks=", &arg)) {
 		option_export_marks(arg);
+	} else if (!strcmp(feature, "alias")) {
+		; /* Don't die - this feature is supported */
 	} else if (!strcmp(feature, "get-mark")) {
 		; /* Don't die - this feature is supported */
 	} else if (!strcmp(feature, "cat-blob")) {
@@ -3372,6 +3412,8 @@ int cmd_main(int argc, const char **argv)
 			parse_checkpoint();
 		else if (!strcmp("done", command_buf.buf))
 			break;
+		else if (!strcmp("alias", command_buf.buf))
+			parse_alias();
 		else if (starts_with(command_buf.buf, "progress "))
 			parse_progress();
 		else if (skip_prefix(command_buf.buf, "feature ", &v))
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 3ad2b2f1ba..41f2a1dad9 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -111,6 +111,10 @@ test_expect_success 'A: create pack from stdin' '
 	Tag of tag of our lovely commit
 	EOF
 
+	alias
+	mark :8
+	to :5
+
 	INPUT_END
 	git fast-import --export-marks=marks.out <input &&
 	git whatchanged master
@@ -195,6 +199,7 @@ test_expect_success 'A: verify marks output' '
 	:5 $(git rev-parse --verify master^0)
 	:6 $(git cat-file tag nested | grep object | cut -d" " -f 2)
 	:7 $(git rev-parse --verify nested)
+	:8 $(git rev-parse --verify master^0)
 	EOF
 	test_cmp expect marks.out
 '
-- 
2.23.0.264.gac739dbb79

