Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3B4C19F2B
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 07:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiHBHyb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 03:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbiHBHyY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 03:54:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEA55F5F
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 00:54:22 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2726OCvw001741;
        Tue, 2 Aug 2022 07:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=USfxfDT7RxQdStBlYEFhComwrvuzSsNF1TueW4nau4M=;
 b=SQ16ErW+RHPKMr1JGa+c8pMT5cCI1tk9dRkMDpBC4Ule6PP5TAXnuT6UrT+ht57pPrbu
 XpstfIYMkctak1d8z3x5iw3DPDDfoMIlm9ruz+AGRCxlEKMEHIh84SffUSSzcv4gKrFw
 MaVUx8kXQhE6Ec9JLBMuWaLBpB8Nr/uVbRI3B6ZL+KU33euPcGB0CvsHt3CZXTxJealw
 qJMeP0tAk6zVMebeg7CkmjolRUS+0ZYYCHbcIz4g6cSavGk2cOpxTMBkj3970BSCgjI0
 JyasAq9o1GOV/sO/9Rw2cJY+0snyN9hbnAa2PopPUezGcMkJfVumRulrJhNL4J5dSwul bQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmw6tdy6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 07:54:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2726ZSbq002966;
        Tue, 2 Aug 2022 07:54:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu32239x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 07:54:08 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2727rxPJ034445;
        Tue, 2 Aug 2022 07:54:08 GMT
Received: from t460.home (dhcp-10-175-37-86.vpn.oracle.com [10.175.37.86])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3hmu32239e-1;
        Tue, 02 Aug 2022 07:54:08 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     git@vger.kernel.org
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Johan Herland <johan@herland.net>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Christian Hesse <mail@eworm.de>
Subject: [RFC PATCH 1/2] notes: support fetching notes from an external repo
Date:   Tue,  2 Aug 2022 09:54:00 +0200
Message-Id: <20220802075401.2393-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.35.1.46.g38062e73e0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_04,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208020037
X-Proofpoint-GUID: yedG75Z9fuK0MOZpmv0LG_u8-uwZyqov
X-Proofpoint-ORIG-GUID: yedG75Z9fuK0MOZpmv0LG_u8-uwZyqov
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Notes are currently always fetched from the current repo. However, in
certain situations you may want to keep notes in a separate repository
altogether.

In my specific case, I am using cgit to display notes for repositories
that are owned by others but hosted on a shared machine, so I cannot
really add the notes directly to their repositories.

This patch makes it so that you can do:

    const char *notes_repo_path = "path/to/notes.git";
    const char *notes_ref = "refs/notes/commits";

    struct repository notes_repo;
    struct display_notes_opt notes_opt;

    repo_init(&notes_repo, notes_repo_path, NULL);
    add_to_alternates_memory(notes_repo.objects->odb->path);

    init_display_notes(&notes_opt);
    notes_opt.repo = &notes_repo;
    notes_opt.use_default_notes = 0;

    string_list_append(&notes_opt.extra_notes_refs, notes_ref);
    load_display_notes(&notes_opt);

...and then notes will be taken from the given ref in the external
repository.

Given that the functionality is not exposed through the command line,
there is currently no way to add regression tests for this.

Cc: Johan Herland <johan@herland.net>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Christian Hesse <mail@eworm.de>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 common-main.c |  2 ++
 notes.c       | 15 ++++++++++++---
 notes.h       |  3 +++
 refs.c        | 12 +++++++++---
 refs.h        |  2 ++
 5 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/common-main.c b/common-main.c
index c531372f3f..74b69a4632 100644
--- a/common-main.c
+++ b/common-main.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "exec-cmd.h"
 #include "attr.h"
+#include "notes.h"
 
 /*
  * Many parts of Git have subprograms communicate via pipe, expect the
@@ -43,6 +44,7 @@ int main(int argc, const char **argv)
 	git_setup_gettext();
 
 	initialize_the_repository();
+	init_default_notes_repository();
 
 	attr_start();
 
diff --git a/notes.c b/notes.c
index 7452e71cc8..90ec625192 100644
--- a/notes.c
+++ b/notes.c
@@ -73,11 +73,17 @@ struct non_note {
 #define SUBTREE_SHA1_PREFIXCMP(key_sha1, subtree_sha1) \
 	(memcmp(key_sha1, subtree_sha1, subtree_sha1[KEY_INDEX]))
 
+struct repository *default_notes_repo;
 struct notes_tree default_notes_tree;
 
 static struct string_list display_notes_refs = STRING_LIST_INIT_NODUP;
 static struct notes_tree **display_notes_trees;
 
+void init_default_notes_repository()
+{
+	default_notes_repo = the_repository;
+}
+
 static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 		struct int_node *node, unsigned int n);
 
@@ -940,10 +946,10 @@ void string_list_add_refs_by_glob(struct string_list *list, const char *glob)
 {
 	assert(list->strdup_strings);
 	if (has_glob_specials(glob)) {
-		for_each_glob_ref(string_list_add_one_ref, glob, list);
+		repo_for_each_glob_ref_in(default_notes_repo, string_list_add_one_ref, glob, NULL, list);
 	} else {
 		struct object_id oid;
-		if (get_oid(glob, &oid))
+		if (repo_get_oid(default_notes_repo, glob, &oid))
 			warning("notes ref %s is invalid", glob);
 		if (!unsorted_string_list_has_string(list, glob))
 			string_list_append(list, glob);
@@ -1019,7 +1025,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	t->dirty = 0;
 
 	if (flags & NOTES_INIT_EMPTY || !notes_ref ||
-	    get_oid_treeish(notes_ref, &object_oid))
+	    repo_get_oid_treeish(default_notes_repo, notes_ref, &object_oid))
 		return;
 	if (flags & NOTES_INIT_WRITABLE && read_ref(notes_ref, &object_oid))
 		die("Cannot use notes ref %s", notes_ref);
@@ -1088,6 +1094,9 @@ void load_display_notes(struct display_notes_opt *opt)
 
 	assert(!display_notes_trees);
 
+	if (opt->repo)
+		default_notes_repo = opt->repo;
+
 	if (!opt || opt->use_default_notes > 0 ||
 	    (opt->use_default_notes == -1 && !opt->extra_notes_refs.nr)) {
 		string_list_append(&display_notes_refs, default_notes_ref());
diff --git a/notes.h b/notes.h
index c1682c39a9..c7aae85ea6 100644
--- a/notes.h
+++ b/notes.h
@@ -6,6 +6,8 @@
 struct object_id;
 struct strbuf;
 
+void init_default_notes_repository();
+
 /*
  * Function type for combining two notes annotating the same object.
  *
@@ -256,6 +258,7 @@ void free_notes(struct notes_tree *t);
 struct string_list;
 
 struct display_notes_opt {
+	struct repository *repo;
 	int use_default_notes;
 	struct string_list extra_notes_refs;
 };
diff --git a/refs.c b/refs.c
index 90bcb27168..cf0dc85872 100644
--- a/refs.c
+++ b/refs.c
@@ -468,8 +468,8 @@ void normalize_glob_ref(struct string_list_item *item, const char *prefix,
 	strbuf_release(&normalized_pattern);
 }
 
-int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
-	const char *prefix, void *cb_data)
+int repo_for_each_glob_ref_in(struct repository *r, each_ref_fn fn,
+	const char *pattern, const char *prefix, void *cb_data)
 {
 	struct strbuf real_pattern = STRBUF_INIT;
 	struct ref_filter filter;
@@ -492,12 +492,18 @@ int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 	filter.prefix = prefix;
 	filter.fn = fn;
 	filter.cb_data = cb_data;
-	ret = for_each_ref(filter_refs, &filter);
+	ret = refs_for_each_ref(get_main_ref_store(r), filter_refs, &filter);
 
 	strbuf_release(&real_pattern);
 	return ret;
 }
 
+int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
+	const char *prefix, void *cb_data)
+{
+	return repo_for_each_glob_ref_in(the_repository, fn, pattern, prefix, cb_data);
+}
+
 int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
 {
 	return for_each_glob_ref_in(fn, pattern, NULL, cb_data);
diff --git a/refs.h b/refs.h
index 47cb9edbaa..1375c8531f 100644
--- a/refs.h
+++ b/refs.h
@@ -366,6 +366,8 @@ int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_dat
 /* iterates all refs that match the specified glob pattern. */
 int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
 
+int repo_for_each_glob_ref_in(struct repository *r, each_ref_fn fn, const char *pattern,
+			 const char *prefix, void *cb_data);
 int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 			 const char *prefix, void *cb_data);
 
-- 
2.35.1.46.g38062e73e0

