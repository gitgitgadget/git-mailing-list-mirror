Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24CC420209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbdGAScL (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:32:11 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:45228 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752092AbdGAScG (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2017 14:32:06 -0400
X-AuditID: 12074412-b7fff70000000fed-d5-5957ea9ce21c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id CE.65.04077.C9AE7595; Sat,  1 Jul 2017 14:31:56 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCCEF.dip0.t-ipconnect.de [87.188.204.239])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v61IVBBV010294
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 1 Jul 2017 14:31:54 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 18/30] packed_read_raw_ref(): new function, replacing `resolve_packed_ref()`
Date:   Sat,  1 Jul 2017 20:30:56 +0200
Message-Id: <1c34d58b9f371e7a57f27cbf947eeef3fea31146.1498933362.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498933362.git.mhagger@alum.mit.edu>
References: <cover.1498933362.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqDvnVXikwZGNEhZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntljy8DWzRfeUt4wWP1p6mC02b25nceD0+Pv+A5PHzll32T0WbCr1
        6Go/wubxrHcPo8fFS8oenzfJBbBHcdmkpOZklqUW6dslcGWs3zSbpWCZUEXv+v1sDYz7+LoY
        OTkkBEwk9k/8y9TFyMUhJLCDSeLehJdQzkkmifVnljGDVLEJ6Eos6mlmArFFBNQkJrYdYgEp
        YhaYxCzx9tpCsISwQLzE9Iln2bsYOThYBFQlHl3iBwnzCkRJvP65lwVim7zErraLrCA2p4CF
        xJ+29WDzhQTMJZoP9rFMYORZwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXTC83s0QvNaV0
        EyMk6IR2MK4/KXeIUYCDUYmHd0NIWKQQa2JZcWXuIUZJDiYlUd6V10IjhfiS8lMqMxKLM+KL
        SnNSiw8xSnAwK4nw5j4PjxTiTUmsrEotyodJSXOwKInz/lys7ickkJ5YkpqdmlqQWgSTleHg
        UJLgnfQSqFGwKDU9tSItM6cEIc3EwQkynAdo+MK7IMOLCxJzizPTIfKnGHU5Xk34/41JiCUv
        Py9VSpy3FWSQAEhRRmke3BxYsnjFKA70ljAvAzB1CPEAEw3cpFdAS5iAlgjPCAFZUpKIkJJq
        YNy4sSu+0O7h3LwF60/mf5dpNe74GfXTgDfstNNC5X2HinZ026dem/P7XP8UXd1KTumXaxu0
        Fk+Ke9AaKzylIm3inN98c1WaD/87JLBt/+n3n8MaXqZfnmFpHTTz+6f+Vqs2k37mWMGXzb1n
        T+b5/2SOi/wvx7um2brbu/7XwpSX4TK9k/VF3ZRYijMSDbWYi4oTAaN1GY/xAgAA
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
index 0490cc087e..346794cf7c 100644
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

