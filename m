Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C5AF20401
	for <e@80x24.org>; Thu, 15 Jun 2017 14:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbdFOOsR (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 10:48:17 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49177 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752323AbdFOOsP (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Jun 2017 10:48:15 -0400
X-AuditID: 12074411-f47ff70000007ac9-3f-59429e2e3156
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 42.B6.31433.E2E92495; Thu, 15 Jun 2017 10:48:14 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCC0A.dip0.t-ipconnect.de [87.188.204.10])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5FElbR9014537
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 15 Jun 2017 10:48:12 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 15/28] packed_peel_ref(): new function, extracted from `files_peel_ref()`
Date:   Thu, 15 Jun 2017 16:47:20 +0200
Message-Id: <f9c4c47e52c076c42896d22d89591a93163afda3.1497534157.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1497534157.git.mhagger@alum.mit.edu>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqKs3zynS4MlTfYu1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDLuz3jPVrCZu2LXhrksDYyTOLsY
        OTgkBEwkHs7I7mLk4hAS2MEksfH/CTYI5ySTRN+LvYxdjJwcbAK6Eot6mplAbBEBNYmJbYdY
        QIqYBSYxS7y9thAsISwQKdF3aA8LiM0ioCpx6eEzVhCbVyBK4sbhFewgtoSAvMSutotgcU4B
        C4nZX9Yxg1whJGAucWy5xgRGngWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdE31cjNL9FJT
        SjcxQkJOcAfjjJNyhxgFOBiVeHgVGpwihVgTy4orcw8xSnIwKYny8ssBhfiS8lMqMxKLM+KL
        SnNSiw8xSnAwK4nwTp0DlONNSaysSi3Kh0lJc7AoifPyLVH3ExJITyxJzU5NLUgtgsnKcHAo
        SfAazwVqFCxKTU+tSMvMKUFIM3FwggznARr+F2x4cUFibnFmOkT+FKOilDivB0hCACSRUZoH
        1wtLCa8YxYFeEeZVBlnBA0wncN2vgAYzAQ0OuuAAMrgkESEl1cBYc4a5mF1ltu2HU+3nBeR8
        eD5ofO+KnORSv+YIc+bLvatfnmu4UJXUI/j6x94FLGfiX9Sv4HXu37vBYCqXc+y2u9dfNB5b
        USR0SP6IwaYHxUtOre7duWQZx0W+7J1Zu5zqk5x7BFVNz9kyqa1TmXv68auy3xF+OdNu+Mfs
        U5qmuDm84XZ8Uf49JZbijERDLeai4kQAEwpkxeQCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will later become a method of `packed_ref_store`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index c206791b91..185d05e1d6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1013,6 +1013,18 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	return ret;
 }
 
+static int packed_peel_ref(struct packed_ref_store *refs,
+			   const char *refname, unsigned char *sha1)
+{
+	struct ref_entry *r = get_packed_ref(refs, refname);
+
+	if (!r || peel_entry(r, 0))
+		return -1;
+
+	hashcpy(sha1, r->u.value.peeled.hash);
+	return 0;
+}
+
 static int files_peel_ref(struct ref_store *ref_store,
 			  const char *refname, unsigned char *sha1)
 {
@@ -1043,17 +1055,9 @@ static int files_peel_ref(struct ref_store *ref_store,
 	 * be expensive and (b) loose references anyway usually do not
 	 * have REF_KNOWS_PEELED.
 	 */
-	if (flag & REF_ISPACKED) {
-		struct ref_entry *r =
-			get_packed_ref(refs->packed_ref_store, refname);
-
-		if (r) {
-			if (peel_entry(r, 0))
-				return -1;
-			hashcpy(sha1, r->u.value.peeled.hash);
-			return 0;
-		}
-	}
+	if (flag & REF_ISPACKED &&
+	    !packed_peel_ref(refs->packed_ref_store, refname, sha1))
+		return 0;
 
 	return peel_object(base, sha1);
 }
-- 
2.11.0

