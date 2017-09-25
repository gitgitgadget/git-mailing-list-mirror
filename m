Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B48B20281
	for <e@80x24.org>; Mon, 25 Sep 2017 08:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934047AbdIYIAv (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 04:00:51 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:58309 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934043AbdIYIAt (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Sep 2017 04:00:49 -0400
X-AuditID: 12074412-1fdff7000000748d-ae-59c8b7b0a6f3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id DD.11.29837.0B7B8C95; Mon, 25 Sep 2017 04:00:48 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDF6.dip0.t-ipconnect.de [87.188.205.246])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8P80N6U027347
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 25 Sep 2017 04:00:46 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 10/21] mmapped_ref_iterator: add iterator over a packed-refs file
Date:   Mon, 25 Sep 2017 10:00:07 +0200
Message-Id: <29ee72916bcc64af347c6306df8c74502f2a1015.1506325610.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1506325610.git.mhagger@alum.mit.edu>
References: <cover.1506325610.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqLth+4lIg95dphZrn91hsni+/gS7
        RdeVbiaLht4rzBb9y7vYLG6vmM9s0T3lLaPFj5YeZovNm9tZHDg9/r7/wOSxc9Zddo8PH+M8
        Fmwq9XjWu4fR4+IlZY/Pm+QC2KO4bFJSczLLUov07RK4Ms5sPMNesM++Ytup22wNjB3GXYwc
        HBICJhJ/jmZ3MXJxCAnsYJL4MbmRFcI5xSTx+dZs9i5GTg42AV2JRT3NTCC2iICaxMS2Qywg
        RcwCK5klJm29wgqSEBYIkXjWeJ4ZxGYRUJX433oGrJlXIEri3Ie3YHEJAXmJcw9ug9mcAhYS
        b84cYQOxhQTMJc7fuMU6gZFnASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdM73czBK91JTS
        TYyQkBPawbj+pNwhRgEORiUe3oh/xyOFWBPLiitzDzFKcjApifLe5TsRKcSXlJ9SmZFYnBFf
        VJqTWnyIUYKDWUmE99hqoBxvSmJlVWpRPkxKmoNFSZz352J1PyGB9MSS1OzU1ILUIpisDAeH
        kgTv721AjYJFqempFWmZOSUIaSYOTpDhPEDDl4PU8BYXJOYWZ6ZD5E8x6nJ03Lz7h0mIJS8/
        L1VKnHcDSJEASFFGaR7cHFiqeMUoDvSWMG8aSBUPMM3ATXoFtIQJaEnvVLAlJYkIKakGRs2P
        c58aTb7jvst41n/PL5FcEaZ+p3apfPsdaTVr0qeCLYuuVy26fWPFj/t+smoRH8I/O1a+TvM/
        ucO+pLPdxCvZNvzwJGmWTe0SrkrCpw2CVpWfUV8fxvcsyZhzp/X0tO+SLFZLHPsmCXwzC3ho
        8Ia30GFBT6Xo+5vxPGtffTH7pnf+S028uRJLcUaioRZzUXEiAI8UC3LwAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new `mmapped_ref_iterator`, which can iterate over the
references in an mmapped `packed-refs` file directly. Use this
iterator from `read_packed_refs()` to fill the packed refs cache.

Note that we are not yet willing to promise that the new iterator
generates its output in order. That doesn't matter for now, because
the packed refs cache doesn't care what order it is filled.

This change adds a lot of boilerplate without providing any obvious
benefits. The benefits will come soon, when we get rid of the
`ref_cache` for packed references altogether.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 207 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 152 insertions(+), 55 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index ae276f3445..312116a99d 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -163,6 +163,141 @@ static NORETURN void die_invalid_line(const char *path,
 
 }
 
+/*
+ * An iterator over a packed-refs file that is currently mmapped.
+ */
+struct mmapped_ref_iterator {
+	struct ref_iterator base;
+
+	struct packed_ref_cache *packed_refs;
+
+	/* The current position in the mmapped file: */
+	const char *pos;
+
+	/* The end of the mmapped file: */
+	const char *eof;
+
+	struct object_id oid, peeled;
+
+	struct strbuf refname_buf;
+};
+
+static int mmapped_ref_iterator_advance(struct ref_iterator *ref_iterator)
+{
+	struct mmapped_ref_iterator *iter =
+		(struct mmapped_ref_iterator *)ref_iterator;
+	const char *p = iter->pos, *eol;
+
+	strbuf_reset(&iter->refname_buf);
+
+	if (iter->pos == iter->eof)
+		return ref_iterator_abort(ref_iterator);
+
+	iter->base.flags = REF_ISPACKED;
+
+	if (iter->eof - p < GIT_SHA1_HEXSZ + 2 ||
+	    parse_oid_hex(p, &iter->oid, &p) ||
+	    !isspace(*p++))
+		die_invalid_line(iter->packed_refs->refs->path,
+				 iter->pos, iter->eof - iter->pos);
+
+	eol = memchr(p, '\n', iter->eof - p);
+	if (!eol)
+		die_unterminated_line(iter->packed_refs->refs->path,
+				      iter->pos, iter->eof - iter->pos);
+
+	strbuf_add(&iter->refname_buf, p, eol - p);
+	iter->base.refname = iter->refname_buf.buf;
+
+	if (check_refname_format(iter->base.refname, REFNAME_ALLOW_ONELEVEL)) {
+		if (!refname_is_safe(iter->base.refname))
+			die("packed refname is dangerous: %s",
+			    iter->base.refname);
+		oidclr(&iter->oid);
+		iter->base.flags |= REF_BAD_NAME | REF_ISBROKEN;
+	}
+	if (iter->packed_refs->peeled == PEELED_FULLY ||
+	    (iter->packed_refs->peeled == PEELED_TAGS &&
+	     starts_with(iter->base.refname, "refs/tags/")))
+		iter->base.flags |= REF_KNOWS_PEELED;
+
+	iter->pos = eol + 1;
+
+	if (iter->pos < iter->eof && *iter->pos == '^') {
+		p = iter->pos + 1;
+		if (iter->eof - p < GIT_SHA1_HEXSZ + 1 ||
+		    parse_oid_hex(p, &iter->peeled, &p) ||
+		    *p++ != '\n')
+			die_invalid_line(iter->packed_refs->refs->path,
+					 iter->pos, iter->eof - iter->pos);
+		iter->pos = p;
+
+		/*
+		 * Regardless of what the file header said, we
+		 * definitely know the value of *this* reference:
+		 */
+		iter->base.flags |= REF_KNOWS_PEELED;
+	} else {
+		oidclr(&iter->peeled);
+	}
+
+	return ITER_OK;
+}
+
+static int mmapped_ref_iterator_peel(struct ref_iterator *ref_iterator,
+				    struct object_id *peeled)
+{
+	struct mmapped_ref_iterator *iter =
+		(struct mmapped_ref_iterator *)ref_iterator;
+
+	if ((iter->base.flags & REF_KNOWS_PEELED)) {
+		oidcpy(peeled, &iter->peeled);
+		return is_null_oid(&iter->peeled) ? -1 : 0;
+	} else if ((iter->base.flags & (REF_ISBROKEN | REF_ISSYMREF))) {
+		return -1;
+	} else {
+		return !!peel_object(iter->oid.hash, peeled->hash);
+	}
+}
+
+static int mmapped_ref_iterator_abort(struct ref_iterator *ref_iterator)
+{
+	struct mmapped_ref_iterator *iter =
+		(struct mmapped_ref_iterator *)ref_iterator;
+
+	release_packed_ref_cache(iter->packed_refs);
+	strbuf_release(&iter->refname_buf);
+	base_ref_iterator_free(ref_iterator);
+	return ITER_DONE;
+}
+
+static struct ref_iterator_vtable mmapped_ref_iterator_vtable = {
+	mmapped_ref_iterator_advance,
+	mmapped_ref_iterator_peel,
+	mmapped_ref_iterator_abort
+};
+
+struct ref_iterator *mmapped_ref_iterator_begin(
+		const char *packed_refs_file,
+		struct packed_ref_cache *packed_refs,
+		const char *pos, const char *eof)
+{
+	struct mmapped_ref_iterator *iter = xcalloc(1, sizeof(*iter));
+	struct ref_iterator *ref_iterator = &iter->base;
+
+	base_ref_iterator_init(ref_iterator, &mmapped_ref_iterator_vtable, 0);
+
+	iter->packed_refs = packed_refs;
+	acquire_packed_ref_cache(iter->packed_refs);
+	iter->pos = pos;
+	iter->eof = eof;
+	strbuf_init(&iter->refname_buf, 0);
+
+	iter->base.oid = &iter->oid;
+
+	return ref_iterator;
+}
+
 /*
  * Read from the `packed-refs` file into a newly-allocated
  * `packed_ref_cache` and return it. The return value will already
@@ -199,9 +334,10 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 	struct stat st;
 	size_t size;
 	char *buf;
-	const char *pos, *eol, *eof;
-	struct strbuf tmp = STRBUF_INIT;
+	const char *pos, *eof;
 	struct ref_dir *dir;
+	struct ref_iterator *iter;
+	int ok;
 
 	packed_refs->refs = refs;
 	acquire_packed_ref_cache(packed_refs);
@@ -235,7 +371,9 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 
 	/* If the file has a header line, process it: */
 	if (pos < eof && *pos == '#') {
+		struct strbuf tmp = STRBUF_INIT;
 		char *p;
+		const char *eol;
 		struct string_list traits = STRING_LIST_INIT_NODUP;
 
 		eol = memchr(pos, '\n', eof - pos);
@@ -259,69 +397,28 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 		pos = eol + 1;
 
 		string_list_clear(&traits, 0);
-		strbuf_reset(&tmp);
+		strbuf_release(&tmp);
 	}
 
 	dir = get_ref_dir(packed_refs->cache->root);
-	while (pos < eof) {
-		const char *p = pos;
-		struct object_id oid;
-		const char *refname;
-		int flag = REF_ISPACKED;
-		struct ref_entry *entry = NULL;
-
-		if (eof - pos < GIT_SHA1_HEXSZ + 2 ||
-		    parse_oid_hex(p, &oid, &p) ||
-		    !isspace(*p++))
-			die_invalid_line(refs->path, pos, eof - pos);
+	iter = mmapped_ref_iterator_begin(refs->path, packed_refs, pos, eof);
+	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
+		struct ref_entry *entry =
+			create_ref_entry(iter->refname, iter->oid, iter->flags);
 
-		eol = memchr(p, '\n', eof - p);
-		if (!eol)
-			die_unterminated_line(refs->path, pos, eof - pos);
-
-		strbuf_add(&tmp, p, eol - p);
-		refname = tmp.buf;
-
-		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-			if (!refname_is_safe(refname))
-				die("packed refname is dangerous: %s", refname);
-			oidclr(&oid);
-			flag |= REF_BAD_NAME | REF_ISBROKEN;
-		}
-		if (packed_refs->peeled == PEELED_FULLY ||
-		    (packed_refs->peeled == PEELED_TAGS &&
-		     starts_with(refname, "refs/tags/")))
-			flag |= REF_KNOWS_PEELED;
-		entry = create_ref_entry(refname, &oid, flag);
+		if ((iter->flags & REF_KNOWS_PEELED))
+			ref_iterator_peel(iter, &entry->u.value.peeled);
 		add_ref_entry(dir, entry);
-
-		pos = eol + 1;
-
-		if (pos < eof && *pos == '^') {
-			p = pos + 1;
-			if (eof - p < GIT_SHA1_HEXSZ + 1 ||
-			    parse_oid_hex(p, &entry->u.value.peeled, &p) ||
-			    *p++ != '\n')
-				die_invalid_line(refs->path, pos, eof - pos);
-
-			/*
-			 * Regardless of what the file header said,
-			 * we definitely know the value of *this*
-			 * reference:
-			 */
-			entry->flag |= REF_KNOWS_PEELED;
-
-			pos = p;
-		}
-
-		strbuf_reset(&tmp);
 	}
 
+	if (ok != ITER_DONE)
+		die("error reading packed-refs file %s", refs->path);
+
 	if (munmap(buf, size))
-		die_errno("error ummapping packed-refs file");
+		die_errno("error ummapping packed-refs file %s", refs->path);
+
 	close(fd);
 
-	strbuf_release(&tmp);
 	return packed_refs;
 }
 
-- 
2.14.1

