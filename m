Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E48720281
	for <e@80x24.org>; Mon, 25 Sep 2017 08:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934042AbdIYIAs (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 04:00:48 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:58079 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934039AbdIYIAr (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Sep 2017 04:00:47 -0400
X-AuditID: 12074411-f95ff70000007f0a-0c-59c8b7aefe74
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 83.22.32522.EA7B8C95; Mon, 25 Sep 2017 04:00:46 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDF6.dip0.t-ipconnect.de [87.188.205.246])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8P80N6T027347
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 25 Sep 2017 04:00:44 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 09/21] packed_ref_cache: remember the file-wide peeling state
Date:   Mon, 25 Sep 2017 10:00:06 +0200
Message-Id: <0b66a2eb80f9ae8e67e06ac73e10e21d170eb875.1506325610.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1506325610.git.mhagger@alum.mit.edu>
References: <cover.1506325610.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqLtu+4lIg5cXNSzWPrvDZPF8/Ql2
        i64r3UwWDb1XmC36l3exWdxeMZ/ZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4fPsZ5
        LNhU6vGsdw+jx8VLyh6fN8kFsEdx2aSk5mSWpRbp2yVwZbx7/4WpYKdIxZVNb5kaGC8KdDFy
        ckgImEg0TbrN1sXIxSEksINJov/VN0YI5xSTxJeGj0wgVWwCuhKLeprBbBEBNYmJbYdYQIqY
        BVYyS0zaeoUVJCEsECDxYm4TWBGLgKrE9ZWzweK8AlES/zrmskOsk5c49+A2M4jNKWAh8ebM
        ETYQW0jAXOL8jVusExh5FjAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdXLzSzRS00p3cQI
        CTrBHYwzTsodYhTgYFTi4Y34dzxSiDWxrLgy9xCjJAeTkijvXb4TkUJ8SfkplRmJxRnxRaU5
        qcWHGCU4mJVEeI+tBsrxpiRWVqUW5cOkpDlYlMR5+Zao+wkJpCeWpGanphakFsFkZTg4lCR4
        920DahQsSk1PrUjLzClBSDNxcIIM5wEavhykhre4IDG3ODMdIn+KUZej4+bdP0xCLHn5ealS
        4rwbQIoEQIoySvPg5sCSxStGcaC3hHnvgVTxABMN3KRXQEuYgJb0TgVbUpKIkJJqYLSYLnzT
        qOhawPz29P8rZJqXBH8onVKeGhPu3dPB1izZ8vT/w89hTXMFLho03r937lL81wvvhQ5y+R2X
        z1fd7rh5C/+/6UInvpk+m9ZaXcn2WNa0v7vG6cep7/F/Zv7s3fSIXcbNoFwv5XSYzIIFAZ8s
        CjpnTdznEHlN5ddWxdfykjME98RzPVdiKc5INNRiLipOBACbegnK8QIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than store the peeling state (i.e., the one defined by traits
in the `packed-refs` file header line) in a local variable in
`read_packed_refs()`, store it permanently in `packed_ref_cache`. This
will be needed when we stop reading all packed refs at once.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 2b80f244c8..ae276f3445 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -18,6 +18,12 @@ struct packed_ref_cache {
 
 	struct ref_cache *cache;
 
+	/*
+	 * What is the peeled state of this cache? (This is usually
+	 * determined from the header of the "packed-refs" file.)
+	 */
+	enum { PEELED_NONE, PEELED_TAGS, PEELED_FULLY } peeled;
+
 	/*
 	 * Count of references to the data structure in this instance,
 	 * including the pointer from files_ref_store::packed if any.
@@ -195,13 +201,13 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 	char *buf;
 	const char *pos, *eol, *eof;
 	struct strbuf tmp = STRBUF_INIT;
-	enum { PEELED_NONE, PEELED_TAGS, PEELED_FULLY } peeled = PEELED_NONE;
 	struct ref_dir *dir;
 
 	packed_refs->refs = refs;
 	acquire_packed_ref_cache(packed_refs);
 	packed_refs->cache = create_ref_cache(NULL, NULL);
 	packed_refs->cache->root->flag &= ~REF_INCOMPLETE;
+	packed_refs->peeled = PEELED_NONE;
 
 	fd = open(refs->path, O_RDONLY);
 	if (fd < 0) {
@@ -244,9 +250,9 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 		string_list_split_in_place(&traits, p, ' ', -1);
 
 		if (unsorted_string_list_has_string(&traits, "fully-peeled"))
-			peeled = PEELED_FULLY;
+			packed_refs->peeled = PEELED_FULLY;
 		else if (unsorted_string_list_has_string(&traits, "peeled"))
-			peeled = PEELED_TAGS;
+			packed_refs->peeled = PEELED_TAGS;
 		/* perhaps other traits later as well */
 
 		/* The "+ 1" is for the LF character. */
@@ -282,8 +288,9 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 			oidclr(&oid);
 			flag |= REF_BAD_NAME | REF_ISBROKEN;
 		}
-		if (peeled == PEELED_FULLY ||
-		    (peeled == PEELED_TAGS && starts_with(refname, "refs/tags/")))
+		if (packed_refs->peeled == PEELED_FULLY ||
+		    (packed_refs->peeled == PEELED_TAGS &&
+		     starts_with(refname, "refs/tags/")))
 			flag |= REF_KNOWS_PEELED;
 		entry = create_ref_entry(refname, &oid, flag);
 		add_ref_entry(dir, entry);
-- 
2.14.1

