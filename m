Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3B371F462
	for <e@80x24.org>; Mon, 10 Jun 2019 15:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391207AbfFJPak (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 11:30:40 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:53959 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391203AbfFJPak (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 11:30:40 -0400
Received: by mail-qk1-f201.google.com with SMTP id i196so8420543qke.20
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 08:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RDMCWX2W+I4gjws2GTKhX+a+eu8n/9EjXkX8oEe7Gcs=;
        b=Uxox9tqQgyLw/xH5pqiJXyQx/1qTATuvjwAPmjwOvJHdmZkiE1xec0aClADTKE5hmC
         G6Okp8TH7XwJbx+b23Tary+Ga9v8yKSyUKIYM37mBfkCz1kUkpr8VSF/vTzRUu6B5SS/
         oYNw1bPNskS0U68Z0hLM8IkN2vRPooWckYt4Jf/O6Wc0zWo4gEAyWlNwjoLLtrffi0dJ
         nGiVilohaxcLxtZYMxKX/DSp3bVGm9VILgEfMK3DEjbxbP4FA4zK/WwFO1RpRmapQn2k
         Z9DFY3v8/qWlz6dLyj9dz6FV4Ogsa0rePSKxVuO5xO7NHFhZ09ypn9MBfmWLe/Zx0NoT
         CMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RDMCWX2W+I4gjws2GTKhX+a+eu8n/9EjXkX8oEe7Gcs=;
        b=sQkLxbQYUtWcXsiXh91laDzm7mm8QRVRIk+g4X9q+8nCfUcrr9jPY6ffRnheFjPgXm
         WE34NviNtk8bRV/0JHBx8Ro2Cs+v58Nf3Fo4wdyxEr9qBDOauDSqF39LRlp8FpzXf+h5
         Cwg4cTGQQv0vrE9rhmXi8ldEvahKQEihVU4VtTofEXTDmc+p9cO5qXOBVg2A8wqxdLFN
         Fvy8S806aF9TbYkhJkEjnGWHEXsDVXZvXfuVvgVAMFflFYBaFoKcyHpi1Sv3m2XPlOBv
         jTua/x1iYw5Phw3cp9c46PSQ7qGrc8+Hi3B0/L1X1KotcHbjUY9cXXaeXzGI2tgh6hQq
         4QqQ==
X-Gm-Message-State: APjAAAUPFBHLj5beT9bYB4lbH//ZNtz/c0QFBhjNOFR7CsPPiauR+dto
        dcG/4fhj0R9vZlbVuHhEiRcaGcc5WYPGTD/G+1vxGduToruH368cn0fn0FszK4Jalh+7kIn7egQ
        LOZnPcDvueBlrk3uu8LQczAu84gz5zGl/AtDS1QPeqOg3VZRcQcby
X-Google-Smtp-Source: APXvYqxSzPmumJ2q8DLSdSfkefRoS/zZ1h9GxPk8kLQ8r32P0ourJPVFnOayNckaxnTx0MrkpiIRWnLG
X-Received: by 2002:ac8:2ac5:: with SMTP id c5mr56060334qta.332.1560180639321;
 Mon, 10 Jun 2019 08:30:39 -0700 (PDT)
Date:   Mon, 10 Jun 2019 11:30:11 -0400
In-Reply-To: <20190610153014.42055-1-brho@google.com>
Message-Id: <20190610153014.42055-7-brho@google.com>
Mime-Version: 1.0
References: <20190610153014.42055-1-brho@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v8 6/9] blame: optionally track line fingerprints during fill_blame_origin()
From:   Barret Rhoden <brho@google.com>
To:     git@vger.kernel.org
Cc:     Michael Platings <michael@platin.gs>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Ren=C3=A9=20Scharfe?=" <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fill_blame_origin() is a convenient place to store data that we will use
throughout the lifetime of a blame_origin.  Some heuristics for
ignoring commits during a blame session can make use of this storage.
In particular, we will calculate a fingerprint for each line of a file
for blame_origins involved in an ignored commit.

In this commit, we only calculate the line_starts, reusing the existing
code from the scoreboard's line_starts.  In an upcoming commit, we will
actually compute the fingerprints.

This feature will be used when we attempt to pass blame entries to
parents when we "ignore" a commit.  Most uses of fill_blame_origin()
will not require this feature, hence the flag parameter.  Multiple calls
to fill_blame_origin() are idempotent, and any of them can request the
creation of the fingerprints structure.

Suggested-by: Michael Platings <michael@platin.gs>
Signed-off-by: Barret Rhoden <brho@google.com>
---
 blame.c | 90 ++++++++++++++++++++++++++++++++++++++-------------------
 blame.h |  2 ++
 2 files changed, 62 insertions(+), 30 deletions(-)

diff --git a/blame.c b/blame.c
index 21ae76603f5c..49698a306e5a 100644
--- a/blame.c
+++ b/blame.c
@@ -311,12 +311,58 @@ static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
 	return xdi_diff(file_a, file_b, &xpp, &xecfg, &ecb);
 }
 
+static const char *get_next_line(const char *start, const char *end)
+{
+	const char *nl = memchr(start, '\n', end - start);
+
+	return nl ? nl + 1 : end;
+}
+
+static int find_line_starts(int **line_starts, const char *buf,
+			    unsigned long len)
+{
+	const char *end = buf + len;
+	const char *p;
+	int *lineno;
+	int num = 0;
+
+	for (p = buf; p < end; p = get_next_line(p, end))
+		num++;
+
+	ALLOC_ARRAY(*line_starts, num + 1);
+	lineno = *line_starts;
+
+	for (p = buf; p < end; p = get_next_line(p, end))
+		*lineno++ = p - buf;
+
+	*lineno = len;
+
+	return num;
+}
+
+static void fill_origin_fingerprints(struct blame_origin *o, mmfile_t *file)
+{
+	int *line_starts;
+
+	if (o->fingerprints)
+		return;
+	o->num_lines = find_line_starts(&line_starts, o->file.ptr,
+					o->file.size);
+	/* TODO: Will fill in fingerprints in a future commit */
+	free(line_starts);
+}
+
+static void drop_origin_fingerprints(struct blame_origin *o)
+{
+}
+
 /*
  * Given an origin, prepare mmfile_t structure to be used by the
  * diff machinery
  */
 static void fill_origin_blob(struct diff_options *opt,
-			     struct blame_origin *o, mmfile_t *file, int *num_read_blob)
+			     struct blame_origin *o, mmfile_t *file,
+			     int *num_read_blob, int fill_fingerprints)
 {
 	if (!o->file.ptr) {
 		enum object_type type;
@@ -340,11 +386,14 @@ static void fill_origin_blob(struct diff_options *opt,
 	}
 	else
 		*file = o->file;
+	if (fill_fingerprints)
+		fill_origin_fingerprints(o, file);
 }
 
 static void drop_origin_blob(struct blame_origin *o)
 {
 	FREE_AND_NULL(o->file.ptr);
+	drop_origin_fingerprints(o);
 }
 
 /*
@@ -1141,8 +1190,10 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 	d.ignore_diffs = ignore_diffs;
 	d.dstq = &newdest; d.srcq = &target->suspects;
 
-	fill_origin_blob(&sb->revs->diffopt, parent, &file_p, &sb->num_read_blob);
-	fill_origin_blob(&sb->revs->diffopt, target, &file_o, &sb->num_read_blob);
+	fill_origin_blob(&sb->revs->diffopt, parent, &file_p,
+			 &sb->num_read_blob, ignore_diffs);
+	fill_origin_blob(&sb->revs->diffopt, target, &file_o,
+			 &sb->num_read_blob, ignore_diffs);
 	sb->num_get_patch++;
 
 	if (diff_hunks(&file_p, &file_o, blame_chunk_cb, &d, sb->xdl_opts))
@@ -1353,7 +1404,8 @@ static void find_move_in_parent(struct blame_scoreboard *sb,
 	if (!unblamed)
 		return; /* nothing remains for this target */
 
-	fill_origin_blob(&sb->revs->diffopt, parent, &file_p, &sb->num_read_blob);
+	fill_origin_blob(&sb->revs->diffopt, parent, &file_p,
+			 &sb->num_read_blob, 0);
 	if (!file_p.ptr)
 		return;
 
@@ -1482,7 +1534,8 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 			norigin = get_origin(parent, p->one->path);
 			oidcpy(&norigin->blob_oid, &p->one->oid);
 			norigin->mode = p->one->mode;
-			fill_origin_blob(&sb->revs->diffopt, norigin, &file_p, &sb->num_read_blob);
+			fill_origin_blob(&sb->revs->diffopt, norigin, &file_p,
+					 &sb->num_read_blob, 0);
 			if (!file_p.ptr)
 				continue;
 
@@ -1822,37 +1875,14 @@ void assign_blame(struct blame_scoreboard *sb, int opt)
 	}
 }
 
-static const char *get_next_line(const char *start, const char *end)
-{
-	const char *nl = memchr(start, '\n', end - start);
-	return nl ? nl + 1 : end;
-}
-
 /*
  * To allow quick access to the contents of nth line in the
  * final image, prepare an index in the scoreboard.
  */
 static int prepare_lines(struct blame_scoreboard *sb)
 {
-	const char *buf = sb->final_buf;
-	unsigned long len = sb->final_buf_size;
-	const char *end = buf + len;
-	const char *p;
-	int *lineno;
-	int num = 0;
-
-	for (p = buf; p < end; p = get_next_line(p, end))
-		num++;
-
-	ALLOC_ARRAY(sb->lineno, num + 1);
-	lineno = sb->lineno;
-
-	for (p = buf; p < end; p = get_next_line(p, end))
-		*lineno++ = p - buf;
-
-	*lineno = len;
-
-	sb->num_lines = num;
+	sb->num_lines = find_line_starts(&sb->lineno, sb->final_buf,
+					 sb->final_buf_size);
 	return sb->num_lines;
 }
 
diff --git a/blame.h b/blame.h
index 2458b68f0e22..4a9e1270b036 100644
--- a/blame.h
+++ b/blame.h
@@ -51,6 +51,8 @@ struct blame_origin {
 	 */
 	struct blame_entry *suspects;
 	mmfile_t file;
+	int num_lines;
+	void *fingerprints;
 	struct object_id blob_oid;
 	unsigned short mode;
 	/* guilty gets set when shipping any suspects to the final
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

