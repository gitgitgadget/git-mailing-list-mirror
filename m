Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39340C433E0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 05:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE60C23884
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 05:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbhAUF5k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 00:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733219AbhAUDYT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 22:24:19 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79C2C061575
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 19:23:53 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id d1so320419otl.13
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 19:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LI1MPhDKxIIsgcZSOohdpbVdpN/6ESo4GQixqvOYNhk=;
        b=W3OZooGVfg2RHVyV1Dt2ag+5/ysfQvbFOMeLmx4+NoPHRejCWup/mo281LhD9jRN/p
         C1wZ+wputvlZge8fPovXnjF+LFxxMAbQfDgbA+xKJmaQcp798E598UryCmdbXkFqdGtx
         z6/Y5BAJlYpwhQ8aO24yIMho3cbTxemoVPe+wxIYpcGbJgwnXrTMmojgADPWtHZhR4oC
         l+ii+l/ghJbpFPp8ysUX3QiGRx2yb7Rf4RVEdqc9lDsRFKaQg0kVmWemVb0+F+N+fvi/
         EFcGJIuhpJbMRDpvJu/2zJl4A1iclNiHrT5Yg3R8i7cUmGy4vJxbb7iRGMor3Rm8/Ckl
         Zj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LI1MPhDKxIIsgcZSOohdpbVdpN/6ESo4GQixqvOYNhk=;
        b=oQdjt57ehKmycJxRszdZHr4eh2ubDAK/68wSy3X+JJVybpnhwOcy2ltcM7kTQKKIus
         1V/k5jlGDKsHsKodc5FX3gADKj7SunecM5wiDUkEAQOgJvqq2IztcsqFVaxxgHT2/E/5
         JeG1NY9xmkCulABEwJrg7WybtAvHEeBeQMfs5k+4YssANK6ITh/8FUSR/HWltYQm/9dF
         QsPLiKnZPHeiBulZNU0XBNNiNZ3Yus2YhYgVu0pcRsOIG3pzZNNHH43zRNYBsPAIuZim
         ngdEUMT4/xOT9c0TK5kMsPRidcIi4WpNPvx+8L2RvMdLZsfHdUolkNUSpDcRZoAGNCJ/
         PnCA==
X-Gm-Message-State: AOAM533Cw1DNI++pXNbNq3APKIEpLiKgJpyfm4Cbj7Z8FkJLF6GY/iEv
        ZYrWDV3ULEHkyZGC9WevLiB1G3UhSYGKgLtV
X-Google-Smtp-Source: ABdhPJwFnLELRMAtfikGU1b73aLEi+60zZ8E9lpDJpah2fjQukcTNaTF18mweLeWm0c1aQrCdKZAhQ==
X-Received: by 2002:a05:6830:185:: with SMTP id q5mr9293168ota.359.1611199432905;
        Wed, 20 Jan 2021 19:23:52 -0800 (PST)
Received: from phord-x1.purestorage.com ([2600:1700:3ec7:4a10::32])
        by smtp.gmail.com with ESMTPSA id n16sm802289oop.9.2021.01.20.19.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 19:23:52 -0800 (PST)
From:   Phil Hord <phil.hord@gmail.com>
X-Google-Original-From: Phil Hord
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phil Hord <phil.hord@gmail.com>
Subject: [PATCH v3] use delete_refs when deleting tags or branches
Date:   Wed, 20 Jan 2021 19:23:32 -0800
Message-Id: <20210121032332.658991-1-phil.hord@gmail.com>
X-Mailer: git-send-email 2.30.0.281.g914876b2ce
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phil Hord <phil.hord@gmail.com>

'git tag -d' accepts one or more tag refs to delete, but each deletion
is done by calling `delete_ref` on each argv. This is very slow when
removing from packed refs. Use delete_refs instead so all the removals
can be done inside a single transaction with a single update.

Do the same for 'git branch -d'.

Since delete_refs performs all the packed-refs delete operations
inside a single transaction, if any of the deletes fail then all
them will be skipped. In practice, none of them should fail since
we verify the hash of each one before calling delete_refs, but some
network error or odd permissions problem could have different results
after this change.

Also, since the file-backed deletions are not performed in the same
transaction, those could succeed even when the packed-refs transaction
fails.

After deleting branches, remove the branch config only if the branch
ref was removed and was not subsequently added back in.

A manual test deleting 24,000 tags took about 30 minutes using
delete_ref.  It takes about 5 seconds using delete_refs.

Acked-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Phil Hord <phil.hord@gmail.com>
---

This version translates a nonzero return code from delete_refs into an 
error return value of 1. It also has style cleanups suggested from v2.

 builtin/branch.c | 47 ++++++++++++++++++++++++++++-------------------
 builtin/tag.c    | 44 ++++++++++++++++++++++++++++++++++----------
 2 files changed, 62 insertions(+), 29 deletions(-)

diff --git builtin/branch.c builtin/branch.c
index 8c0b428104..bcc00bcf18 100644
--- builtin/branch.c
+++ builtin/branch.c
@@ -202,6 +202,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	int remote_branch = 0;
 	struct strbuf bname = STRBUF_INIT;
 	unsigned allowed_interpret;
+	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+	int branch_name_pos;
 
 	switch (kinds) {
 	case FILTER_REFS_REMOTES:
@@ -219,6 +222,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	default:
 		die(_("cannot use -a with -d"));
 	}
+	branch_name_pos = strcspn(fmt, "%");
 
 	if (!force) {
 		head_rev = lookup_commit_reference(the_repository, &head_oid);
@@ -265,30 +269,35 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			goto next;
 		}
 
-		if (delete_ref(NULL, name, is_null_oid(&oid) ? NULL : &oid,
-			       REF_NO_DEREF)) {
-			error(remote_branch
-			      ? _("Error deleting remote-tracking branch '%s'")
-			      : _("Error deleting branch '%s'"),
-			      bname.buf);
-			ret = 1;
-			goto next;
-		}
-		if (!quiet) {
-			printf(remote_branch
-			       ? _("Deleted remote-tracking branch %s (was %s).\n")
-			       : _("Deleted branch %s (was %s).\n"),
-			       bname.buf,
-			       (flags & REF_ISBROKEN) ? "broken"
-			       : (flags & REF_ISSYMREF) ? target
-			       : find_unique_abbrev(&oid, DEFAULT_ABBREV));
-		}
-		delete_branch_config(bname.buf);
+		item = string_list_append(&refs_to_delete, name);
+		item->util = xstrdup((flags & REF_ISBROKEN) ? "broken"
+				    : (flags & REF_ISSYMREF) ? target
+				    : find_unique_abbrev(&oid, DEFAULT_ABBREV));
 
 	next:
 		free(target);
 	}
 
+	if (delete_refs(NULL, &refs_to_delete, REF_NO_DEREF))
+		ret = 1;
+
+	for_each_string_list_item(item, &refs_to_delete) {
+		char *describe_ref = item->util;
+		char *name = item->string;
+		if (!ref_exists(name)) {
+			char *refname = name + branch_name_pos;
+			if (!quiet)
+				printf(remote_branch
+					? _("Deleted remote-tracking branch %s (was %s).\n")
+					: _("Deleted branch %s (was %s).\n"),
+					name + branch_name_pos, describe_ref);
+
+			delete_branch_config(refname);
+		}
+		free(describe_ref);
+	}
+	string_list_clear(&refs_to_delete, 0);
+
 	free(name);
 	strbuf_release(&bname);
 
diff --git builtin/tag.c builtin/tag.c
index 24d35b746d..e8b85eefd8 100644
--- builtin/tag.c
+++ builtin/tag.c
@@ -72,10 +72,10 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 }
 
 typedef int (*each_tag_name_fn)(const char *name, const char *ref,
-				const struct object_id *oid, const void *cb_data);
+				const struct object_id *oid, void *cb_data);
 
 static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
-			     const void *cb_data)
+			     void *cb_data)
 {
 	const char **p;
 	struct strbuf ref = STRBUF_INIT;
@@ -97,18 +97,42 @@ static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
 	return had_error;
 }
 
-static int delete_tag(const char *name, const char *ref,
-		      const struct object_id *oid, const void *cb_data)
+static int collect_tags(const char *name, const char *ref,
+			const struct object_id *oid, void *cb_data)
 {
-	if (delete_ref(NULL, ref, oid, 0))
-		return 1;
-	printf(_("Deleted tag '%s' (was %s)\n"), name,
-	       find_unique_abbrev(oid, DEFAULT_ABBREV));
+	struct string_list *ref_list = cb_data;
+
+	string_list_append(ref_list, ref);
+	ref_list->items[ref_list->nr - 1].util = oiddup(oid);
 	return 0;
 }
 
+static int delete_tags(const char **argv)
+{
+	int result;
+	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+
+	result = for_each_tag_name(argv, collect_tags, (void *)&refs_to_delete);
+	if (delete_refs(NULL, &refs_to_delete, REF_NO_DEREF))
+		result = 1;
+
+	for_each_string_list_item(item, &refs_to_delete) {
+		const char *name = item->string;
+		struct object_id *oid = item->util;
+		if (!ref_exists(name))
+			printf(_("Deleted tag '%s' (was %s)\n"),
+				item->string + 10,
+				find_unique_abbrev(oid, DEFAULT_ABBREV));
+
+		free(oid);
+	}
+	string_list_clear(&refs_to_delete, 0);
+	return result;
+}
+
 static int verify_tag(const char *name, const char *ref,
-		      const struct object_id *oid, const void *cb_data)
+		      const struct object_id *oid, void *cb_data)
 {
 	int flags;
 	const struct ref_format *format = cb_data;
@@ -512,7 +536,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (filter.reachable_from || filter.unreachable_from)
 		die(_("--merged and --no-merged options are only allowed in list mode"));
 	if (cmdmode == 'd')
-		return for_each_tag_name(argv, delete_tag, NULL);
+		return delete_tags(argv);
 	if (cmdmode == 'v') {
 		if (format.format && verify_ref_format(&format))
 			usage_with_options(git_tag_usage, options);
-- 
2.30.0.281.g914876b2ce

