Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9940A20209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbdGASbm (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:31:42 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:48709 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751919AbdGASbl (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2017 14:31:41 -0400
X-AuditID: 1207440e-8a7ff70000006f9a-be-5957ea82e4a1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 76.A9.28570.28AE7595; Sat,  1 Jul 2017 14:31:31 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCCEF.dip0.t-ipconnect.de [87.188.204.239])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v61IVBBK010294
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 1 Jul 2017 14:31:29 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 07/30] validate_packed_ref_cache(): take a `packed_ref_store *` parameter
Date:   Sat,  1 Jul 2017 20:30:45 +0200
Message-Id: <3b93dc4d38ce71a367ad9c28b7ca55bb4c274eb7.1498933362.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498933362.git.mhagger@alum.mit.edu>
References: <cover.1498933362.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqNv8KjzSYG4bm8XaZ3eYLJ6vP8Fu
        0XWlm8miofcKs8XtFfOZLZY8fM1s0T3lLaPFj5YeZovNm9tZHDg9/r7/wOSxc9Zddo8Fm0o9
        utqPsHk8693D6HHxkrLH501yAexRXDYpqTmZZalF+nYJXBlXd2gXTOWvON6zjbWB8QNPFyMn
        h4SAicSv/ifsXYxcHEICO5gkOl42skI4J5kkbi/cyQZSxSagK7Gop5kJxBYRUJOY2HaIBaSI
        WWASs8TbawvBEsICMRKnX+1kBrFZBFQl7jy4A9bMKxAl0Th9LzvEOnmJXW0XWUFsTgELiT9t
        68HqhQTMJZoP9rFMYORZwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXWC83s0QvNaV0EyMk
        6Ph2MLavlznEKMDBqMTDuyEkLFKINbGsuDL3EKMkB5OSKO/Ka6GRQnxJ+SmVGYnFGfFFpTmp
        xYcYJTiYlUR4c5+HRwrxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4
        J70EahQsSk1PrUjLzClBSDNxcIIM5wEavvAuyPDigsTc4sx0iPwpRl2OVxP+f2MSYsnLz0uV
        EudtBRkkAFKUUZoHNweWLF4xigO9Jcwb8QKoigeYaOAmvQJawgS0RHhGCMiSkkSElFQDY5b4
        x2sqXryfTWxCAxiNH/lMkr4623vnhGVvNKy+XLjsH6TyYc40pw0OYvxp6jeyv2owlf7+KvrV
        /NBpoxdtz7VfflddJhbWtlruZGai3otqId7qaXxKyfHzpv5nVzcTMpTyifJ7kfXrsWbbw2Ne
        YjluIlFPQ6bc+WZy2pI7RXTn7pazlYf3KrEUZyQaajEXFScCAJvlqNnxAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It only cares about the packed-refs part of the reference store.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2b0db60b2b..f061506bf0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -396,12 +396,11 @@ static void files_ref_path(struct files_ref_store *refs,
  * Check that the packed refs cache (if any) still reflects the
  * contents of the file. If not, clear the cache.
  */
-static void validate_packed_ref_cache(struct files_ref_store *refs)
+static void validate_packed_ref_cache(struct packed_ref_store *refs)
 {
-	if (refs->packed_ref_store->cache &&
-	    !stat_validity_check(&refs->packed_ref_store->cache->validity,
-				 refs->packed_ref_store->path))
-		clear_packed_ref_cache(refs->packed_ref_store);
+	if (refs->cache &&
+	    !stat_validity_check(&refs->cache->validity, refs->path))
+		clear_packed_ref_cache(refs);
 }
 
 /*
@@ -417,7 +416,7 @@ static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *ref
 	const char *packed_refs_file = refs->packed_ref_store->path;
 
 	if (!is_lock_file_locked(&refs->packed_ref_store->lock))
-		validate_packed_ref_cache(refs);
+		validate_packed_ref_cache(refs->packed_ref_store);
 
 	if (!refs->packed_ref_store->cache)
 		refs->packed_ref_store->cache = read_packed_refs(packed_refs_file);
@@ -1364,7 +1363,7 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 	 * cache is still valid. We've just locked the file, but it
 	 * might have changed the moment *before* we locked it.
 	 */
-	validate_packed_ref_cache(refs);
+	validate_packed_ref_cache(refs->packed_ref_store);
 
 	packed_ref_cache = get_packed_ref_cache(refs);
 	/* Increment the reference count to prevent it from being freed: */
-- 
2.11.0

