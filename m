Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0043920401
	for <e@80x24.org>; Thu, 15 Jun 2017 14:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbdFOOsX (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 10:48:23 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49177 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752671AbdFOOsT (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Jun 2017 10:48:19 -0400
X-AuditID: 12074411-f2fff70000007ac9-44-59429e32f7c7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 43.B6.31433.23E92495; Thu, 15 Jun 2017 10:48:18 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCC0A.dip0.t-ipconnect.de [87.188.204.10])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5FElbRB014537
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 15 Jun 2017 10:48:17 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 17/28] packed_read_raw_ref(): new function, replacing `resolve_packed_ref()`
Date:   Thu, 15 Jun 2017 16:47:22 +0200
Message-Id: <5b565b2eced3b91819090707779e63908970833d.1497534157.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1497534157.git.mhagger@alum.mit.edu>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqGs8zynSYPsxJou1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDIuPO5lLlgmVLHt8gTmBsZ9fF2M
        nBwSAiYSC7d8Y+pi5OIQEtjBJHGn4QgjhHOSSeJs7w5GkCo2AV2JRT3NTCC2iICaxMS2Qywg
        RcwCk5gl3l5bCJYQFoiRmLp8IRuIzSKgKjF70iNmEJtXIEri5tOXzBDr5CV2tV1kBbE5BSwk
        Zn9ZBxTnANpmLnFsucYERp4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3RN9XIzS/RSU0o3
        MUKCTnAH44yTcocYBTgYlXh4FRqcIoVYE8uKK3MPMUpyMCmJ8vLLAYX4kvJTKjMSizPii0pz
        UosPMUpwMCuJ8E6dA5TjTUmsrEotyodJSXOwKInz8i1R9xMSSE8sSc1OTS1ILYLJynBwKEnw
        Gs8FahQsSk1PrUjLzClBSDNxcIIM5wEa/hdseHFBYm5xZjpE/hSjopQ4rwdIQgAkkVGaB9cL
        SwqvGMWBXhHmVQZZwQNMKHDdr4AGMwENDrrgADK4JBEhJdXAKFnv7p7TciT79exzARuOfwws
        nLP/BqeoxL/brw5NVgveJ19jX7W64LXYzj/ey56t2uW/g99l8dEfb60ubVhlvtdC4GPhJvUZ
        cdFXD04QbXi/6E/2Gs8Gq///lwRZ8q7h3t8udm23VZNs94ZSseVpBz6umtXDuFmQ7cqqTI3O
        bLtHe9Y/C/WKf6LEUpyRaKjFXFScCADbx0+N5QIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new function, `packed_read_raw_ref()`, which is nearly a
`read_raw_ref_fn`. Use it in place of `resolve_packed_ref()`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index e57cdeba36..ac4764f6f7 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -608,27 +608,23 @@ static struct ref_entry *get_packed_ref(struct packed_ref_store *refs,
 	return find_ref_entry(get_packed_refs(refs), refname);
 }
 
-/*
- * A loose ref file doesn't exist; check for a packed ref.
- */
-static int resolve_packed_ref(struct files_ref_store *refs,
-			      const char *refname,
-			      unsigned char *sha1, unsigned int *flags)
+static int packed_read_raw_ref(struct packed_ref_store *refs,
+			       const char *refname, unsigned char *sha1,
+			       struct strbuf *referent, unsigned int *type)
 {
 	struct ref_entry *entry;
 
-	/*
-	 * The loose reference file does not exist; check for a packed
-	 * reference.
-	 */
-	entry = get_packed_ref(refs->packed_ref_store, refname);
-	if (entry) {
-		hashcpy(sha1, entry->u.value.oid.hash);
-		*flags |= REF_ISPACKED;
-		return 0;
+	*type = 0;
+
+	entry = get_packed_ref(refs, refname);
+	if (!entry) {
+		errno = ENOENT;
+		return -1;
 	}
-	/* refname is not a packed reference. */
-	return -1;
+
+	hashcpy(sha1, entry->u.value.oid.hash);
+	*type = REF_ISPACKED;
+	return 0;
 }
 
 static int files_read_raw_ref(struct ref_store *ref_store,
@@ -674,7 +670,8 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	if (lstat(path, &st) < 0) {
 		if (errno != ENOENT)
 			goto out;
-		if (resolve_packed_ref(refs, refname, sha1, type)) {
+		if (packed_read_raw_ref(refs->packed_ref_store, refname,
+					sha1, referent, type)) {
 			errno = ENOENT;
 			goto out;
 		}
@@ -713,7 +710,8 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 		 * ref is supposed to be, there could still be a
 		 * packed ref:
 		 */
-		if (resolve_packed_ref(refs, refname, sha1, type)) {
+		if (packed_read_raw_ref(refs->packed_ref_store, refname,
+					sha1, referent, type)) {
 			errno = EISDIR;
 			goto out;
 		}
-- 
2.11.0

