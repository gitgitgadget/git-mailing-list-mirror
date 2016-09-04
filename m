Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFC6A1F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754273AbcIDQKa (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:10:30 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:45874 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753937AbcIDQKN (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:10:13 -0400
X-AuditID: 1207440c-217ff700000008d5-4d-57cc472969a7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 69.0A.02261.9274CC75; Sun,  4 Sep 2016 12:09:13 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5W026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:11 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Ronnie Sahlberg <sahlberg@google.com>,
        David Turner <dturner@twopensource.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 10/38] refs: add a transaction_commit() method
Date:   Sun,  4 Sep 2016 18:08:16 +0200
Message-Id: <3265523aca57d95a47120e8886b728fdbabbd768.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsUixO6iqKvpfibc4PMHWYv5m04wWnRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li5lVri38TaizOvGlkdODy+Pv+A5PHzll32T0W
        bCr16Go/wubxrHcPo8fFS8oe+5duY/NY/MDLY8Hz++wenzfJBXBFcdmkpOZklqUW6dslcGW8
        njSTpWCxaEX3v6NMDYzXBbsYOTkkBEwkNk5bw97FyMUhJLCVUWLOk14WCOckk8TjB1tZQarY
        BHQlFvU0M4HYIgJqEhPbDoEVMQusZpY41rSZESQhLOAoceHVbTYQm0VAVeJw00qwOK9AlERj
        z3RWiHVyEpe2fWEGsTkFLCTO7J4LZHMAbTOXaH+RPYGRZwEjwypGucSc0lzd3MTMnOLUZN3i
        5MS8vNQiXUO93MwSvdSU0k2MkLDk2cH4bZ3MIUYBDkYlHl4L7TPhQqyJZcWVuYcYJTmYlER5
        Zx08GS7El5SfUpmRWJwRX1Sak1p8iFGCg1lJhFfbBaicNyWxsiq1KB8mJc3BoiTOq7pE3U9I
        ID2xJDU7NbUgtQgmK8PBoSTBe90VqFGwKDU9tSItM6cEIc3EwQkynAdo+E2QGt7igsTc4sx0
        iPwpRkUpcd6XIAkBkERGaR5cLyxtvGIUB3pFmFfRDaiKB5hy4LpfAQ1mAhq8bvdpkMEliQgp
        qQbG+Teq/HYy5na4XF146ArXpELtF3Jiyyw7PSdZZG2c1SbNt+LjAc+2hPXbwiRiHy76oDbv
        q7B4Ec9BCz0dlT97s/QXOfncXqvvtdBi7qFDB67My3WL6O0+vJDbbG3UhekJ5loXd+zQ1oy2
        Zl7qdiO55/bxOfeY15tcX1A0d/G2qauEPhreDYvfocRSnJFoqMVcVJwIAP7aJyv2AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               |  9 +++++++++
 refs/files-backend.c | 10 ++++++----
 refs/refs-internal.h |  5 +++++
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 9d6bcb1..9475844 100644
--- a/refs.c
+++ b/refs.c
@@ -1377,3 +1377,12 @@ void assert_main_repository(struct ref_store *refs, const char *caller)
 	if (*refs->submodule)
 		die("BUG: %s called for a submodule", caller);
 }
+
+/* backend functions */
+int ref_transaction_commit(struct ref_transaction *transaction,
+			   struct strbuf *err)
+{
+	struct ref_store *refs = get_ref_store(NULL);
+
+	return refs->be->transaction_commit(refs, transaction, err);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6913d45..d896052 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3710,11 +3710,12 @@ static int lock_ref_for_update(struct ref_update *update,
 	return 0;
 }
 
-int ref_transaction_commit(struct ref_transaction *transaction,
-			   struct strbuf *err)
+static int files_transaction_commit(struct ref_store *ref_store,
+				    struct ref_transaction *transaction,
+				    struct strbuf *err)
 {
 	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "ref_transaction_commit");
+		files_downcast(ref_store, 0, "ref_transaction_commit");
 	int ret = 0, i;
 	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
 	struct string_list_item *ref_to_delete;
@@ -4103,5 +4104,6 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 struct ref_storage_be refs_be_files = {
 	NULL,
 	"files",
-	files_ref_store_create
+	files_ref_store_create,
+	files_transaction_commit
 };
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index b952038..b7367ab 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -535,10 +535,15 @@ int read_raw_ref(const char *refname, unsigned char *sha1,
  */
 typedef struct ref_store *ref_store_init_fn(const char *submodule);
 
+typedef int ref_transaction_commit_fn(struct ref_store *refs,
+				      struct ref_transaction *transaction,
+				      struct strbuf *err);
+
 struct ref_storage_be {
 	struct ref_storage_be *next;
 	const char *name;
 	ref_store_init_fn *init;
+	ref_transaction_commit_fn *transaction_commit;
 };
 
 extern struct ref_storage_be refs_be_files;
-- 
2.9.3

