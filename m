Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A50652095B
	for <e@80x24.org>; Mon, 20 Mar 2017 16:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755540AbdCTQds (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 12:33:48 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:60962 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753245AbdCTQdp (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 12:33:45 -0400
X-AuditID: 12074414-807ff70000002bfd-01-58d0046299e0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id DD.86.11261.26400D85; Mon, 20 Mar 2017 12:33:38 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906F9B.dip0.t-ipconnect.de [87.144.111.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2KGXV9C010511
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 20 Mar 2017 12:33:36 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 02/20] refs_read_raw_ref(): new function
Date:   Mon, 20 Mar 2017 17:33:07 +0100
Message-Id: <3962e229cf0eb9daad8b5ed55b98fc9dbdd0d64a.1490026594.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490026594.git.mhagger@alum.mit.edu>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsUixO6iqJvEciHC4FertkXXlW4mi4beK8wW
        t1fMZ7ZY8vA1s0X3lLeMFj9aepgd2Dz+vv/A5LFz1l12j672I2wez3r3MHpcvKTs8XmTXABb
        FJdNSmpOZllqkb5dAlfGif+7GAsO8ld8v9jP2MC4laeLkZNDQsBE4szu7SxdjFwcQgI7mCT+
        bnnPDuGcYpK433SDBaSKTUBXYlFPMxOILSKgJjGx7RBYB7PAI0aJq/PvsoMkhAUsJC7NbGIG
        sVkEVCXOXX7ACGLzCkRJTFxyjglinbzErraLrCA2J1D9l/uNYAuEBMwlOhf0sk9g5FnAyLCK
        US4xpzRXNzcxM6c4NVm3ODkxLy+1SNdCLzezRC81pXQTIySgRHYwHjkpd4hRgINRiYd3xZXz
        EUKsiWXFlbmHGCU5mJREeZ/eBgrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4a16CZTjTUmsrEot
        yodJSXOwKInzflus7ickkJ5YkpqdmlqQWgSTleHgUJLgffkfqFGwKDU9tSItM6cEIc3EwQky
        nAdo+CqQGt7igsTc4sx0iPwpRkUpcd7vIAkBkERGaR5cLyziXzGKA70izGsEUsUDTBZw3a+A
        BjMBDV524wzI4JJEhJRUA2NjPVP2pm2yBpEtc0/Ebq9Qq/XqyBDhinxw7H2a4F8+seuq/Sxs
        vu3VXZn5lmkGBzi0S0+u3TBdgGPy3Lv1JScEPxxSF1G05NbdY57H9GBndwp70ManXjXB17wM
        /96Za3afQUhx1X713U7pcZlyfV4WgcvfOiozrn932TH+4rlVnzoqdzjGKLEUZyQaajEXFScC
        ANQf17DTAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract a new function from `refs_resolve_ref_unsafe()`. It will be
useful elsewhere.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 11 +++++++++--
 refs/refs-internal.h |  4 ++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 77a39f8b17..0ed6c3c7a4 100644
--- a/refs.c
+++ b/refs.c
@@ -1326,6 +1326,13 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 	return refs_for_each_rawref(get_main_ref_store(), fn, cb_data);
 }
 
+int refs_read_raw_ref(struct ref_store *ref_store,
+		      const char *refname, unsigned char *sha1,
+		      struct strbuf *referent, unsigned int *type)
+{
+	return ref_store->be->read_raw_ref(ref_store, refname, sha1, referent, type);
+}
+
 /* This function needs to return a meaningful errno on failure */
 const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 				    const char *refname,
@@ -1362,8 +1369,8 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 	for (symref_count = 0; symref_count < SYMREF_MAXDEPTH; symref_count++) {
 		unsigned int read_flags = 0;
 
-		if (refs->be->read_raw_ref(refs, refname,
-					   sha1, &sb_refname, &read_flags)) {
+		if (refs_read_raw_ref(refs, refname,
+				      sha1, &sb_refname, &read_flags)) {
 			*flags |= read_flags;
 			if (errno != ENOENT || (resolve_flags & RESOLVE_REF_READING))
 				return NULL;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 690498698e..6ee9f20dbc 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -165,6 +165,10 @@ struct ref_update {
 	const char refname[FLEX_ARRAY];
 };
 
+int refs_read_raw_ref(struct ref_store *ref_store,
+		      const char *refname, unsigned char *sha1,
+		      struct strbuf *referent, unsigned int *type);
+
 /*
  * Add a ref_update with the specified properties to transaction, and
  * return a pointer to the new object. This function does not verify
-- 
2.11.0

