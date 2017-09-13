Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFBEA20A21
	for <e@80x24.org>; Wed, 13 Sep 2017 17:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbdIMRRa (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 13:17:30 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:59516 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751279AbdIMRQy (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Sep 2017 13:16:54 -0400
X-AuditID: 12074412-1fdff7000000748d-a3-59b96805b01f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 87.27.29837.50869B95; Wed, 13 Sep 2017 13:16:53 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC855.dip0.t-ipconnect.de [87.188.200.85])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8DHGIid001379
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 13 Sep 2017 13:16:51 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 15/20] packed_read_raw_ref(): read the reference from the mmapped buffer
Date:   Wed, 13 Sep 2017 19:16:09 +0200
Message-Id: <30512c0e9071af73af34fbdde8b591b07161fdc8.1505319366.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505319366.git.mhagger@alum.mit.edu>
References: <cover.1505319366.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsUixO6iqMuasTPS4HqnmcXaZ3eYLJ6vP8Fu
        0XWlm8miofcKs8XtFfOZLbqnvGW0+NHSw2yxeXM7iwOHx9/3H5g8ds66y+6xYFOpx7PePYwe
        Fy8pe3zeJBfAFsVlk5Kak1mWWqRvl8CVcbPnNmNBF2fFzacLmRsYt7F3MXJySAiYSMw9co+5
        i5GLQ0hgB5PE/o13WSCck0wSs9bfZwapYhPQlVjU08wEYosIqElMbDsEVsQs8JRJYufJu6wg
        CWGBCImnbx8BJTg4WARUJeZPSAAJ8wpESUyf/5YVYpu8xLkHt8FmcgpYSGzc8YQRxBYSMJdo
        nLOTcQIjzwJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFumZ6uZkleqkppZsYIQEmtINx/Um5
        Q4wCHIxKPLwPLHdGCrEmlhVX5h5ilORgUhLl3asLFOJLyk+pzEgszogvKs1JLT7EKMHBrCTC
        GxQFlONNSaysSi3Kh0lJc7AoifP+XKzuJySQnliSmp2aWpBaBJPV4OAQ6F2z+gKjFEtefl6q
        kgSvUzrQEMGi1PTUirTMnBKEUiYOTpBFPECLLqSBLCouSMwtzkyHyJ9i1OXouHn3D5MQ2CAp
        cd6/qUBFAiBFGaV5cHNgCeMVozjQi8K8LCDreIDJBm7SK6AlTEBLzpzeAbKkJBEhJdXAaNKf
        usL01/KMY+Kt+5W3T/22kufcIr/Ee+mLbKdsO97Gf4HDwXVVCc8xluxXNw9cdqtf9zPrYKwD
        o1keh0rL3xDl5+XLL3W6bz0esHJ6cdTid+dZ9vwoLZ50bsojo2Jb0xWm04pFDsU+EDl2bN4D
        rd3vt3z9uVDmm0Y644oEzko1ode/lpm1HVZiKc5INNRiLipOBAAoK7jV8wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of reading the reference from the `ref_cache`, read it
directly from the mmapped buffer.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a018a6c8ad..9b10532eb3 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -806,18 +806,22 @@ static int packed_read_raw_ref(struct ref_store *ref_store,
 {
 	struct packed_ref_store *refs =
 		packed_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
-
-	struct ref_entry *entry;
+	struct packed_ref_cache *packed_refs = get_packed_ref_cache(refs);
+	const char *rec;
 
 	*type = 0;
 
-	entry = get_packed_ref(refs, refname);
-	if (!entry) {
+	rec = find_reference_location(packed_refs, refname, 1);
+
+	if (!rec) {
+		/* refname is not a packed reference. */
 		errno = ENOENT;
 		return -1;
 	}
 
-	hashcpy(sha1, entry->u.value.oid.hash);
+	if (get_sha1_hex(rec, sha1))
+		die_invalid_line(refs->path, rec, packed_refs->eof - rec);
+
 	*type = REF_ISPACKED;
 	return 0;
 }
-- 
2.14.1

