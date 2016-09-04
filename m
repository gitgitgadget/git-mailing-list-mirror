Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4C821F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754512AbcIDQM2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:12:28 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:54584 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754387AbcIDQLz (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:11:55 -0400
X-AuditID: 1207440d-be3ff700000008af-33-57cc47553a2e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id B7.86.02223.5574CC75; Sun,  4 Sep 2016 12:09:57 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5u026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:55 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        David Turner <dturner@twopensource.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 34/38] refs: make delete_refs() virtual
Date:   Sun,  4 Sep 2016 18:08:40 +0200
Message-Id: <dabafdf7ac61460fd0b0edbaf40e655b1f60a222.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsUixO6iqBvqfibcYFOXssX8TScYLbqudDNZ
        NPReYba4vWI+s8WSh6+ZLbqnvGW0+NHSw2wx86q1xZk3jYwOnB5/339g8tg56y67R1f7ETaP
        Z717GD0uXlL22L90G5vH4gdeHgue32f3+LxJLoAzissmJTUnsyy1SN8ugSvj1fMtzAV3RCt+
        PP/E3MD4VbCLkZNDQsBEYs/jXaxdjFwcQgJbGSXW/3vFAuGcZJJYd3AZE0gVm4CuxKKeZjBb
        REBNYmLbIbAiZoHfTBIXtj5n72Lk4BAWsJI4fiYRpIZFQFXi75+tjCBhXoEoiQ3PlCCWyUlc
        2vaFGcTmFLCQOLN7LjNIiZCAuUT7i+wJjDwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuka
        6eVmluilppRuYoSEIO8Oxv/rZA4xCnAwKvHwWmifCRdiTSwrrsw9xCjJwaQkyjvr4MlwIb6k
        /JTKjMTijPii0pzU4kOMEhzMSiK82i5A5bwpiZVVqUX5MClpDhYlcV61Jep+QgLpiSWp2amp
        BalFMFkZDg4lCd7rrkCNgkWp6akVaZk5JQhpJg5OkOE8QMNvgtTwFhck5hZnpkPkTzEqSonz
        vgRJCIAkMkrz4HphKeIVozjQK8K8im5AVTzA9ALX/QpoMBPQ4HW7T4MMLklESEk1MBaxtOnL
        KMkfbDtue3K1QLtz5Ul1Yeej2hejL064xSV+QCCCiSm9rtotKm9HxcF1lR8/pOxZeSij8mzc
        1p3XxOac/XOKTyiBcX7WUh8rlbbtco+fzzRUU7Rq611Q8Hkao6dArP3cx+dmPIvo/LOxaRVP
        5N8638igXfzxuqw3Y5nXMfLOXvthvhJLcUaioRZzUXEiAKy9kxvsAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: David Turner <dturner@twopensource.com>

In the file-based backend, delete_refs has some special optimization
to deal with packed refs.  In other backends, we might be able to make
ref deletion faster by putting all deletions into a single
transaction.  So we need a special backend function for this.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               | 7 +++++++
 refs/files-backend.c | 6 ++++--
 refs/refs-internal.h | 3 +++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 3830918..6efa859 100644
--- a/refs.c
+++ b/refs.c
@@ -1532,3 +1532,10 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 
 	return refs->be->initial_transaction_commit(refs, transaction, err);
 }
+
+int delete_refs(struct string_list *refnames, unsigned int flags)
+{
+	struct ref_store *refs = get_ref_store(NULL);
+
+	return refs->be->delete_refs(refs, refnames, flags);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 81008d7..bcaa958 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2451,10 +2451,11 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 	return 0;
 }
 
-int delete_refs(struct string_list *refnames, unsigned int flags)
+static int files_delete_refs(struct ref_store *ref_store,
+			     struct string_list *refnames, unsigned int flags)
 {
 	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "delete_refs");
+		files_downcast(ref_store, 0, "delete_refs");
 	struct strbuf err = STRBUF_INIT;
 	int i, result = 0;
 
@@ -4077,6 +4078,7 @@ struct ref_storage_be refs_be_files = {
 	files_pack_refs,
 	files_peel_ref,
 	files_create_symref,
+	files_delete_refs,
 
 	files_ref_iterator_begin,
 	files_read_raw_ref,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 08c8586..ade6501 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -490,6 +490,8 @@ typedef int create_symref_fn(struct ref_store *ref_store,
 			     const char *ref_target,
 			     const char *refs_heads_master,
 			     const char *logmsg);
+typedef int delete_refs_fn(struct ref_store *ref_store,
+			   struct string_list *refnames, unsigned int flags);
 
 /*
  * Iterate over the references in the specified ref_store that are
@@ -587,6 +589,7 @@ struct ref_storage_be {
 	pack_refs_fn *pack_refs;
 	peel_ref_fn *peel_ref;
 	create_symref_fn *create_symref;
+	delete_refs_fn *delete_refs;
 
 	ref_iterator_begin_fn *iterator_begin;
 	read_raw_ref_fn *read_raw_ref;
-- 
2.9.3

