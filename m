Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D61020401
	for <e@80x24.org>; Fri, 23 Jun 2017 07:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754671AbdFWHCj (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 03:02:39 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:56356 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754588AbdFWHCd (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Jun 2017 03:02:33 -0400
X-AuditID: 12074414-4f7ff70000001c95-58-594cbd06e77c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id E0.60.07317.60DBC495; Fri, 23 Jun 2017 03:02:31 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5B4.dip0.t-ipconnect.de [87.188.197.180])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5N71o61001300
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 23 Jun 2017 03:02:28 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 16/29] packed_peel_ref(): new function, extracted from `files_peel_ref()`
Date:   Fri, 23 Jun 2017 09:01:34 +0200
Message-Id: <de697adb88cabeb9c5e6906862a6e2486da79068.1498200513.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498200513.git.mhagger@alum.mit.edu>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqMux1yfS4KKLxdpnd5gsnq8/wW7R
        daWbyaKh9wqzxe0V85ktljx8zWzRPeUto8WPlh5mi82b21kcOD3+vv/A5LFz1l12jwWbSj26
        2o+weTzr3cPocfGSssfnTXIB7FFcNimpOZllqUX6dglcGfdnvGcr2MxdsWvDXJYGxkmcXYwc
        HBICJhKNM227GLk4hAR2MEk8O7qTGcI5xSRxYlMHkMPJwSagK7Gop5kJxBYRUJOY2HaIBaSI
        WWASs8TbawvBEsICMRI3361hB7FZBFQlJhy7BGbzCkRJrJjeBVYjISAvsavtIiuIzSlgIdEz
        cTlYjZCAucSq36tZJzDyLGBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6GXm1mil5pSuokR
        EnIiOxiPnJQ7xCjAwajEw5tw1jtSiDWxrLgy9xCjJAeTkiivZqRPpBBfUn5KZUZicUZ8UWlO
        avEhRgkOZiURXp1VQDnelMTKqtSifJiUNAeLkjjvt8XqfkIC6YklqdmpqQWpRTBZGQ4OJQle
        0T1AjYJFqempFWmZOSUIaSYOTpDhPEDDPTaDDC8uSMwtzkyHyJ9iVJQS592wGyghAJLIKM2D
        64WlhFeM4kCvCPMmglTxANMJXPcroMFMQINnrAEbXJKIkJJqYOT4wH1r06drvz43bpl4P85k
        +XrGOZn3+WPN92bFfF6/UivcMedfgo54qsr3yMMHhX8/LWkU3fFxdduxmYq/Llpd3Jp2Y7lj
        4POZf/3nrq70nSBssu6R14LkNQ0N4Z8zJfkEayN3PPZ4vinWdtmjQ3ZtZ+1yF+VbSTn/dbp7
        asZW6wNzgxQ/fnZTYinOSDTUYi4qTgQAyCAffuQCAAA=
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

