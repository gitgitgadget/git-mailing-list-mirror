Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61C9D1F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 02:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfHNCt6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 22:49:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43338 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfHNCt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 22:49:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so1269766pgb.10
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 19:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LZp0A5hnKE1PAhqph/dlff/n8clNazxm+wkW/sFUCd0=;
        b=jZY3QSYl0I7w3XsP3yESu3q8YHpD+4YSVteo1FcaEBTtB9I/WzwJMnJQysfjqd5GHo
         qDlV16lG1LbBWHlwWg92C3npU/32EjLB4kBOe2aLMNNbR0pgb7LlL2lZCKfoppgvvOP4
         DFxFPXWSAbZ1uQvxzwm2Ss4noLYYevW/QrHO6EBPK8vrHNpAktG8GO99Hu5TGCcaDZuM
         pkc9r9TF9ENFxtcpK2A5Aj7we8QNETZwvKE/zFWqWOLrVjB5asTu7853Qd/oA+zfYoHY
         foKjsGyW0XCcxwQafkfLSUpaZon0zP0frS4VMD1ip4nN4fksFdSFJeAgoE/6p8WoohhK
         KpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LZp0A5hnKE1PAhqph/dlff/n8clNazxm+wkW/sFUCd0=;
        b=SdtGpKsydBx+vncJleyBUcpSgSEZmRbJwDTEf5LQEIcAPMEIddikyn+0Vrp6LERJhe
         RcNHAp4O1AfKgj73HgyfA1YamXc4Zi1QzTnSipygG/HpiwsoecDpA1NVzoSS+BKhh1i2
         F2htoq/uzMTcxrYYqkq0ABGB0CSm8OoCOKPgN/sPRjjrevdoQpwDBcfmwxek/+Qn0Z9d
         dHbC5JabKnwJGiRqTAy3J/C+lBaM4HpIo4eBd6feQer6BicI8LaMxv44U8a5GQ2lQ37x
         IX7YyLGcmmMKJjUmVMUJywQHX8VQ5IcdEybE01J5XOe/uZfHs2x40aw2W8WvVs0EetoO
         fOVA==
X-Gm-Message-State: APjAAAW6tlelXSrlIUx9K0+N7yWH6uDOn53w2MuiUs+fYe53SscnjWh9
        Qkiq3TmZp+ab1JP1CgYyj+yjRjOU
X-Google-Smtp-Source: APXvYqwO5zH3irnulMwAxVvxw5uzrr0nX2LcN6DyPymRN5X3r/d/0pfKeLsxBm8WNwn4GNxn1qUgDQ==
X-Received: by 2002:a17:90a:8403:: with SMTP id j3mr4805170pjn.3.1565750996769;
        Tue, 13 Aug 2019 19:49:56 -0700 (PDT)
Received: from phord-x1.purestorage.com ([64.84.68.252])
        by smtp.gmail.com with ESMTPSA id d3sm3587375pjz.31.2019.08.13.19.49.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 19:49:55 -0700 (PDT)
From:   Phil Hord <phil.hord@gmail.com>
X-Google-Original-From: Phil Hord
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phil Hord <phil.hord@gmail.com>
Subject: [PATCH v2] use delete_refs when deleting tags or branches
Date:   Tue, 13 Aug 2019 19:49:27 -0700
Message-Id: <20190814024927.13167-1-phil.hord@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.174.g4cc1b04b4c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phil Hord <phil.hord@gmail.com>

'git tag -d' and 'git branch -d' both accept one or more refs to
delete, but each deletion is done by calling `delete_ref` on each argv.
This is very slow when removing from packed refs as packed-refs is
locked and rewritten each time. Use delete_refs instead so all the
removals can be done inside a single transaction with a single update.

Since delete_refs performs all the packed-refs delete operations
inside a single transaction, if any of the deletes fail then all
them will be skipped. In practice, none of them should fail since
we verify the hash of each one before calling delete_refs, but some
network error or odd permissions problem could have different results
after this change.

Also, since the file-backed deletions are not performed in the same
transaction, those could succeed even when the packed-refs transaction
fails.

After deleting refs, report the deletion's success only if the ref was
actually deleted. For branch deletion, remove the branch config only
if the branch ref is actually removed.

A manual test deleting 24,000 tags took about 30 minutes using
delete_ref.  It takes about 5 seconds using delete_refs.

Signed-off-by: Phil Hord <phil.hord@gmail.com>
---
This reroll adds the same delete_refs change to 'git branch'. It checks 
individual refs after the operation to report correctly on each whether
it was successfully deleted or not. Maybe this is an unnecessary step,
though. This handles the weird case where some file system error
prevented us from deleting refs, leaving us with an error from 
delete_refs but without any idea which refs might have been affected.

 builtin/branch.c | 50 +++++++++++++++++++++++++++++-------------------
 builtin/tag.c    | 45 +++++++++++++++++++++++++++++++++----------
 2 files changed, 65 insertions(+), 30 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 2ef214632f..2273239f41 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -202,6 +202,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	int remote_branch = 0;
 	struct strbuf bname = STRBUF_INIT;
 	unsigned allowed_interpret;
+	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+	int refname_pos = 0;
 
 	switch (kinds) {
 	case FILTER_REFS_REMOTES:
@@ -209,12 +212,13 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		/* For subsequent UI messages */
 		remote_branch = 1;
 		allowed_interpret = INTERPRET_BRANCH_REMOTE;
-
+		refname_pos = 13;
 		force = 1;
 		break;
 	case FILTER_REFS_BRANCHES:
 		fmt = "refs/heads/%s";
 		allowed_interpret = INTERPRET_BRANCH_LOCAL;
+		refname_pos = 11;
 		break;
 	default:
 		die(_("cannot use -a with -d"));
@@ -265,30 +269,36 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
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
 
+	delete_refs(NULL, &refs_to_delete, REF_NO_DEREF);
+
+	for_each_string_list_item(item, &refs_to_delete) {
+		char * describe_ref = item->util;
+		char * name = item->string;
+		if (ref_exists(name))
+			ret = 1;
+		else {
+			char * refname = name + refname_pos;
+			if (!quiet)
+				printf(remote_branch
+					? _("Deleted remote-tracking branch %s (was %s).\n")
+					: _("Deleted branch %s (was %s).\n"),
+					name + refname_pos, describe_ref);
+
+			delete_branch_config(refname);
+		}
+		free(describe_ref);
+	}
+	string_list_clear(&refs_to_delete, 0);
+
 	free(name);
 	strbuf_release(&bname);
 
diff --git a/builtin/tag.c b/builtin/tag.c
index e0a4c25382..0d11ffcd04 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
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
@@ -97,18 +97,43 @@ static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
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
+	delete_refs(NULL, &refs_to_delete, REF_NO_DEREF);
+
+	for_each_string_list_item(item, &refs_to_delete) {
+		const char * name = item->string;
+		struct object_id * oid = item->util;
+		if (ref_exists(name))
+			result = 1;
+		else
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
@@ -511,7 +536,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (filter.merge_commit)
 		die(_("--merged and --no-merged options are only allowed in list mode"));
 	if (cmdmode == 'd')
-		return for_each_tag_name(argv, delete_tag, NULL);
+		return delete_tags(argv);
 	if (cmdmode == 'v') {
 		if (format.format && verify_ref_format(&format))
 			usage_with_options(git_tag_usage, options);
-- 
2.23.0.rc1.174.g4cc1b04b4c

