Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B25D020281
	for <e@80x24.org>; Mon, 25 Sep 2017 08:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934045AbdIYIAt (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 04:00:49 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:58079 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933979AbdIYIAp (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Sep 2017 04:00:45 -0400
X-AuditID: 12074411-f95ff70000007f0a-06-59c8b7aca039
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id B2.22.32522.CA7B8C95; Mon, 25 Sep 2017 04:00:44 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDF6.dip0.t-ipconnect.de [87.188.205.246])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8P80N6S027347
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 25 Sep 2017 04:00:42 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 08/21] read_packed_refs(): read references with minimal copying
Date:   Mon, 25 Sep 2017 10:00:05 +0200
Message-Id: <6fc5f32b6c526c9f6a0aa983b977b946723b61e0.1506325610.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1506325610.git.mhagger@alum.mit.edu>
References: <cover.1506325610.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqLtm+4lIgyVb5SzWPrvDZPF8/Ql2
        i64r3UwWDb1XmC36l3exWdxeMZ/ZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4fPsZ5
        LNhU6vGsdw+jx8VLyh6fN8kFsEdx2aSk5mSWpRbp2yVwZTxvvcNccFS7ondJM0sDY4tSFyMn
        h4SAicTU30tZuxi5OIQEdjBJbGvfxQzhnGKSuL2rkxGkik1AV2JRTzMTiC0ioCYxse0QC0gR
        s8BKZolJW68AtXNwCAsESTS1W4LUsAioSlw4th+snlcgSmL/onksENvkJc49uM0MYnMKWEi8
        OXOEDcQWEjCXOH/jFusERp4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3RN9XIzS/RSU0o3
        MUJCTnAH44yTcocYBTgYlXh4I/4djxRiTSwrrsw9xCjJwaQkynuX70SkEF9SfkplRmJxRnxR
        aU5q8SFGCQ5mJRHeY6uBcrwpiZVVqUX5MClpDhYlcV6+Jep+QgLpiSWp2ampBalFMFkZDg4l
        Cd5924AaBYtS01Mr0jJzShDSTBycIMN5gIYvB6nhLS5IzC3OTIfIn2LU5ei4efcPkxBLXn5e
        qpQ47waQIgGQoozSPLg5sFTxilEc6C1h3nsgVTzANAM36RXQEiagJb1TwZaUJCKkpBoYg+LO
        /7P6vrD78Az95HX/X6/MSFiypLE4RsuqfPKP+r4pIbc8n6Vr1wQnz1o+iy1315vId3MuR8jl
        TGa9GjO/6JX098TKcz48Ct8ulU6v2vc+oHn3Pb4FvTd3fVF4ojrV66GWoHrw1vBM8xsG2+9u
        tzr4/9PzS5Urtz8vOmrO+FmPQ8hWdc3Bv0osxRmJhlrMRcWJAGUX7qbwAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of copying data from the `packed-refs` file one line at time
and then processing it, process the data in place as much as possible.

Also, instead of processing one line per iteration of the main loop,
process a reference line plus its corresponding peeled line (if
present) together.

Note that this change slightly tightens up the parsing of the
`packed-refs` file. Previously, the parser would have accepted
multiple "peeled" lines for a single reference (ignoring all but the
last one). Now it would reject that.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 101 ++++++++++++++++++++------------------------------
 1 file changed, 40 insertions(+), 61 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a45e3ff92f..2b80f244c8 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -134,33 +134,6 @@ static void clear_packed_ref_cache(struct packed_ref_store *refs)
 	}
 }
 
-/* The length of a peeled reference line in packed-refs, including EOL: */
-#define PEELED_LINE_LENGTH 42
-
-/*
- * Parse one line from a packed-refs file.  Write the SHA1 to sha1.
- * Return a pointer to the refname within the line (null-terminated),
- * or NULL if there was a problem.
- */
-static const char *parse_ref_line(struct strbuf *line, struct object_id *oid)
-{
-	const char *ref;
-
-	if (parse_oid_hex(line->buf, oid, &ref) < 0)
-		return NULL;
-	if (!isspace(*ref++))
-		return NULL;
-
-	if (isspace(*ref))
-		return NULL;
-
-	if (line->buf[line->len - 1] != '\n')
-		return NULL;
-	line->buf[--line->len] = 0;
-
-	return ref;
-}
-
 static NORETURN void die_unterminated_line(const char *path,
 					   const char *p, size_t len)
 {
@@ -221,8 +194,7 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 	size_t size;
 	char *buf;
 	const char *pos, *eol, *eof;
-	struct ref_entry *last = NULL;
-	struct strbuf line = STRBUF_INIT;
+	struct strbuf tmp = STRBUF_INIT;
 	enum { PEELED_NONE, PEELED_TAGS, PEELED_FULLY } peeled = PEELED_NONE;
 	struct ref_dir *dir;
 
@@ -264,9 +236,9 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 		if (!eol)
 			die_unterminated_line(refs->path, pos, eof - pos);
 
-		strbuf_add(&line, pos, eol - pos);
+		strbuf_add(&tmp, pos, eol - pos);
 
-		if (!skip_prefix(line.buf, "# pack-refs with:", (const char **)&p))
+		if (!skip_prefix(tmp.buf, "# pack-refs with:", (const char **)&p))
 			die_invalid_line(refs->path, pos, eof - pos);
 
 		string_list_split_in_place(&traits, p, ' ', -1);
@@ -281,61 +253,68 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 		pos = eol + 1;
 
 		string_list_clear(&traits, 0);
-		strbuf_reset(&line);
+		strbuf_reset(&tmp);
 	}
 
 	dir = get_ref_dir(packed_refs->cache->root);
 	while (pos < eof) {
+		const char *p = pos;
 		struct object_id oid;
 		const char *refname;
+		int flag = REF_ISPACKED;
+		struct ref_entry *entry = NULL;
 
-		eol = memchr(pos, '\n', eof - pos);
+		if (eof - pos < GIT_SHA1_HEXSZ + 2 ||
+		    parse_oid_hex(p, &oid, &p) ||
+		    !isspace(*p++))
+			die_invalid_line(refs->path, pos, eof - pos);
+
+		eol = memchr(p, '\n', eof - p);
 		if (!eol)
 			die_unterminated_line(refs->path, pos, eof - pos);
 
-		strbuf_add(&line, pos, eol + 1 - pos);
+		strbuf_add(&tmp, p, eol - p);
+		refname = tmp.buf;
+
+		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+			if (!refname_is_safe(refname))
+				die("packed refname is dangerous: %s", refname);
+			oidclr(&oid);
+			flag |= REF_BAD_NAME | REF_ISBROKEN;
+		}
+		if (peeled == PEELED_FULLY ||
+		    (peeled == PEELED_TAGS && starts_with(refname, "refs/tags/")))
+			flag |= REF_KNOWS_PEELED;
+		entry = create_ref_entry(refname, &oid, flag);
+		add_ref_entry(dir, entry);
 
-		refname = parse_ref_line(&line, &oid);
-		if (refname) {
-			int flag = REF_ISPACKED;
+		pos = eol + 1;
+
+		if (pos < eof && *pos == '^') {
+			p = pos + 1;
+			if (eof - p < GIT_SHA1_HEXSZ + 1 ||
+			    parse_oid_hex(p, &entry->u.value.peeled, &p) ||
+			    *p++ != '\n')
+				die_invalid_line(refs->path, pos, eof - pos);
 
-			if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-				if (!refname_is_safe(refname))
-					die("packed refname is dangerous: %s", refname);
-				oidclr(&oid);
-				flag |= REF_BAD_NAME | REF_ISBROKEN;
-			}
-			last = create_ref_entry(refname, &oid, flag);
-			if (peeled == PEELED_FULLY ||
-			    (peeled == PEELED_TAGS && starts_with(refname, "refs/tags/")))
-				last->flag |= REF_KNOWS_PEELED;
-			add_ref_entry(dir, last);
-		} else if (last &&
-		    line.buf[0] == '^' &&
-		    line.len == PEELED_LINE_LENGTH &&
-		    line.buf[PEELED_LINE_LENGTH - 1] == '\n' &&
-		    !get_oid_hex(line.buf + 1, &oid)) {
-			oidcpy(&last->u.value.peeled, &oid);
 			/*
 			 * Regardless of what the file header said,
 			 * we definitely know the value of *this*
 			 * reference:
 			 */
-			last->flag |= REF_KNOWS_PEELED;
-		} else {
-			die_invalid_line(refs->path, line.buf, line.len);
+			entry->flag |= REF_KNOWS_PEELED;
+
+			pos = p;
 		}
 
-		/* The "+ 1" is for the LF character. */
-		pos = eol + 1;
-		strbuf_reset(&line);
+		strbuf_reset(&tmp);
 	}
 
 	if (munmap(buf, size))
 		die_errno("error ummapping packed-refs file");
 	close(fd);
 
-	strbuf_release(&line);
+	strbuf_release(&tmp);
 	return packed_refs;
 }
 
-- 
2.14.1

