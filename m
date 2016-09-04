Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE5BB20193
	for <e@80x24.org>; Sun,  4 Sep 2016 16:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754450AbcIDQMG (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:12:06 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:56073 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754341AbcIDQLu (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:11:50 -0400
X-AuditID: 1207440e-dc3ff70000000931-5b-57cc475385a1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id BE.0B.02353.3574CC75; Sun,  4 Sep 2016 12:09:55 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5t026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:53 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        David Turner <dturner@twopensource.com>,
        Ronnie Sahlberg <rsahlberg@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 33/38] refs: add method for initial ref transaction commit
Date:   Sun,  4 Sep 2016 18:08:39 +0200
Message-Id: <fe062b480d491f9c374d4184797f3523716ee681.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsUixO6iqBvsfibcoHeRpsX8TScYLbqudDNZ
        NPReYba4vWI+s8WSh6+ZLbqnvGW0+NHSw2wx86q1RcvTdywWZ940Mjpwefx9/4HJY+esu+we
        CzaVenS1H2HzeNa7h9Hj4iVlj/1Lt7F5LH7g5bHg+X12j8+b5AK4orhsUlJzMstSi/TtErgy
        Ot6cZSx4JVTx5tpxxgbGm/xdjJwcEgImElu6pjJ1MXJxCAlsZZS4eWIFK0hCSOAkk0T3CnEQ
        m01AV2JRTzMTiC0ioCYxse0QC0gDs8AaZolv22cCNXBwCAv4Stxqi+1iZOdgEVCV+F4LUs0r
        ECVxrfsQG8QqOYlL274wg9icAhYSZ3bPZQZpFBIwl2h/kT2BkWcBI8MqRrnEnNJc3dzEzJzi
        1GTd4uTEvLzUIl1jvdzMEr3UlNJNjJCA5NvB2L5e5hCjAAejEg+vhfaZcCHWxLLiytxDjJIc
        TEqivLMOngwX4kvKT6nMSCzOiC8qzUktPsQowcGsJMKr7QJUzpuSWFmVWpQPk5LmYFES51Vb
        ou4nJJCeWJKanZpakFoEk5Xh4FCS4I1yA2oULEpNT61Iy8wpQUgzcXCCDOcBGh4KUsNbXJCY
        W5yZDpE/xagoJc770hUoIQCSyCjNg+uFJYxXjOJArwjzJoC08wCTDVz3K6DBTECD1+0+DTK4
        JBEhJdXAuLW44+kb10zNK4tEe2ezZO1/4sUT0ZoTIP1x69WcgEfOTWYHb/LPrfSIc3j/qUAo
        UHzx6+35kQcO9mg9sJ/YezNB+N6fd0zNL3yjlv5d7HBCpD51R9/muwYOB7lU990Wz/naw8rH
        19X2KTxnSWzu9/63jtqdO0NaKr6JGPe7tiUtS2WsPPJEiaU4I9FQi7moOBEAhoxqvvMCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: David Turner <dturner@twopensource.com>

Signed-off-by: Ronnie Sahlberg <rsahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               | 8 ++++++++
 refs/files-backend.c | 8 +++++---
 refs/refs-internal.h | 1 +
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index cb9d805..3830918 100644
--- a/refs.c
+++ b/refs.c
@@ -1524,3 +1524,11 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 				       prepare_fn, should_prune_fn,
 				       cleanup_fn, policy_cb_data);
 }
+
+int initial_ref_transaction_commit(struct ref_transaction *transaction,
+				   struct strbuf *err)
+{
+	struct ref_store *refs = get_ref_store(NULL);
+
+	return refs->be->initial_transaction_commit(refs, transaction, err);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index a810dfa..81008d7 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3839,11 +3839,12 @@ static int ref_present(const char *refname,
 	return string_list_has_string(affected_refnames, refname);
 }
 
-int initial_ref_transaction_commit(struct ref_transaction *transaction,
-				   struct strbuf *err)
+static int files_initial_transaction_commit(struct ref_store *ref_store,
+					    struct ref_transaction *transaction,
+					    struct strbuf *err)
 {
 	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "initial_ref_transaction_commit");
+		files_downcast(ref_store, 0, "initial_ref_transaction_commit");
 	int ret = 0, i;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
 
@@ -4071,6 +4072,7 @@ struct ref_storage_be refs_be_files = {
 	"files",
 	files_ref_store_create,
 	files_transaction_commit,
+	files_initial_transaction_commit,
 
 	files_pack_refs,
 	files_peel_ref,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index a20b622..08c8586 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -582,6 +582,7 @@ struct ref_storage_be {
 	const char *name;
 	ref_store_init_fn *init;
 	ref_transaction_commit_fn *transaction_commit;
+	ref_transaction_commit_fn *initial_transaction_commit;
 
 	pack_refs_fn *pack_refs;
 	peel_ref_fn *peel_ref;
-- 
2.9.3

