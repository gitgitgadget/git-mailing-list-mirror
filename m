Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51D2C20281
	for <e@80x24.org>; Tue, 19 Sep 2017 06:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751377AbdISGWw (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 02:22:52 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:45137 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751283AbdISGWu (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Sep 2017 02:22:50 -0400
X-AuditID: 12074411-f95ff70000007f0a-cf-59c0b7b98612
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 14.50.32522.9B7B0C95; Tue, 19 Sep 2017 02:22:49 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE885.dip0.t-ipconnect.de [84.170.232.133])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8J6MV1d002857
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 19 Sep 2017 02:22:47 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 06/21] read_packed_refs(): only check for a header at the top of the file
Date:   Tue, 19 Sep 2017 08:22:14 +0200
Message-Id: <a1d50f3a452873f3d845742d378887aac14f7cb6.1505799700.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505799700.git.mhagger@alum.mit.edu>
References: <cover.1505799700.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqLtz+4FIg+nHOS3WPrvDZPF8/Ql2
        i64r3UwWDb1XmC36l3exWdxeMZ/ZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4fPsZ5
        LNhU6vGsdw+jx8VLyh6fN8kFsEdx2aSk5mSWpRbp2yVwZVx9d4Gp4IZgxcqlT5kbGN/xdjFy
        ckgImEj0fZjC1sXIxSEksINJonv3AUYI5xSTxMKmT6wgVWwCuhKLepqZQGwRATWJiW2HWECK
        mAVWMktM2noFrEhYIEZiyr+VQDYHB4uAqsTks1YgYV6BKIm595cxQ2yTlzj34DaYzSlgIdG8
        ZzsLSLmQgLnEgaPFExh5FjAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdXLzSzRS00p3cQI
        CTjBHYwzTsodYhTgYFTi4RW4tj9SiDWxrLgy9xCjJAeTkihv2KYDkUJ8SfkplRmJxRnxRaU5
        qcWHGCU4mJVEeA8tAsrxpiRWVqUW5cOkpDlYlMR5+Zao+wkJpCeWpGanphakFsFkZTg4lCR4
        F28DahQsSk1PrUjLzClBSDNxcIIM5wEaXgxSw1tckJhbnJkOkT/FqMvRcfPuHyYhlrz8vFQp
        cd77IEUCIEUZpXlwc2CJ4hWjONBbwrx7QKp4gEkGbtIroCVMQEuyN4AtKUlESEk1MEYq85XK
        rNDnPN20b2b/b8ce4RmRddmOOqrX5r/4z155fKHO9eV9+q/3csx6JZp85rmtg/iOa9diupfv
        1Fxq/kfFxueWqI8w6+PvtnuT3XknvNu8c/Oxy4uUziox1Vxa6beYvfDzLtM5riZnT82USOXq
        2VQgIzplv7bWK8HG9vsp6xse51RWtSqxFGckGmoxFxUnAgCmVnKF7wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This tightens up the parsing a bit; previously, stray header-looking
lines would have been processed.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 154abbd83a..141f02b9c8 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -255,11 +255,34 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 	pos = buf;
 	eof = buf + size;
 
+	/* If the file has a header line, process it: */
+	if (pos < eof && *pos == '#') {
+		const char *traits;
+
+		eol = memchr(pos, '\n', eof - pos);
+		if (!eol)
+			die_unterminated_line(refs->path, pos, eof - pos);
+
+		strbuf_add(&line, pos, eol + 1 - pos);
+
+		if (!skip_prefix(line.buf, "# pack-refs with:", &traits))
+			die_invalid_line(refs->path, pos, eof - pos);
+
+		if (strstr(traits, " fully-peeled "))
+			peeled = PEELED_FULLY;
+		else if (strstr(traits, " peeled "))
+			peeled = PEELED_TAGS;
+		/* perhaps other traits later as well */
+
+		/* The "+ 1" is for the LF character. */
+		pos = eol + 1;
+		strbuf_reset(&line);
+	}
+
 	dir = get_ref_dir(packed_refs->cache->root);
 	while (pos < eof) {
 		struct object_id oid;
 		const char *refname;
-		const char *traits;
 
 		eol = memchr(pos, '\n', eof - pos);
 		if (!eol)
@@ -267,15 +290,6 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 
 		strbuf_add(&line, pos, eol + 1 - pos);
 
-		if (skip_prefix(line.buf, "# pack-refs with:", &traits)) {
-			if (strstr(traits, " fully-peeled "))
-				peeled = PEELED_FULLY;
-			else if (strstr(traits, " peeled "))
-				peeled = PEELED_TAGS;
-			/* perhaps other traits later as well */
-			goto next_line;
-		}
-
 		refname = parse_ref_line(&line, &oid);
 		if (refname) {
 			int flag = REF_ISPACKED;
@@ -307,7 +321,6 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 			die_invalid_line(refs->path, line.buf, line.len);
 		}
 
-	next_line:
 		/* The "+ 1" is for the LF character. */
 		pos = eol + 1;
 		strbuf_reset(&line);
-- 
2.14.1

