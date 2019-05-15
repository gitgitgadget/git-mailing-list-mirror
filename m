Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8164B1F461
	for <e@80x24.org>; Wed, 15 May 2019 21:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfEOVpa (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 17:45:30 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:40209 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfEOVpa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 17:45:30 -0400
Received: by mail-ot1-f73.google.com with SMTP id h4so697764otl.7
        for <git@vger.kernel.org>; Wed, 15 May 2019 14:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wGfyj3hXgqecSTYeiZqNObLe0SuA19+hNpeLif/rvnQ=;
        b=vu8qABItsaVyH1tnJZjx5hLzkm9I+/pDeI6epLGFU79+YN0/9e0FjHNQp8QkIE+3+Y
         dWH0rV8u2QhMTTEzyjlbi3Mk4ZWiaRQNOlGf+o1hrgcPNTPGiiFQcCt0Za/IjuZ6ttfv
         0XwBGTUgDQSxuxfRykV/XnZsK2hUW8934iyGcLidIndMY3M8EcljBy94hL76d85EiYcq
         lwOESoBEObQPD3yVEfmqZpe4zuG/cqlDQNryNdUxjkJm7WLpK10sOeZIlIY0NyA/0UFq
         7AiIyzwNLXp7rsUiF0gij1m7N4Rkn5tuQESc5rhVkqDBzhQaXedtZm/HPRdN2dfvAjVg
         6Ibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wGfyj3hXgqecSTYeiZqNObLe0SuA19+hNpeLif/rvnQ=;
        b=G/i9Fi/Wd2jLYdDFO8MkwhNoeFRWTicmk9ArNmXgUcYKqT4cUgXi8m9GDpBdMAeuOA
         0oB5SRX1AEofW+W7XRZ2R7W8BYfue/Q0DuwJ/BuH33udaTDNW9SCOBuXn4afIIY4u+fn
         7YVGIJ8LKXQZVtRZeCduIzeD4ahV+DTj7w9p/njwO66+n9KTQt34zS9vQXaXfOYFmKgR
         q9AG3GnZ7ygEga8E7ENzZDxXxAiZFWxlJ6ZhpOIcE6LOGtnM/yzujl7RK/mdkrgIS42t
         vb55VSRh0bjq1A79ocB1GL2wNG2Boj0kw1fP/cU90B83RFXC7CWu0+4m0iPJI/WbpcQS
         UNCQ==
X-Gm-Message-State: APjAAAUnMcEX5eyuIncstvJbV9gCVPln3X7Rf8TwGU4t/nuyc41QKKaD
        hAwcYhd0SpBLoz6Ab6xt+dPjy0laJOJ4qh1lJbQuUyFlZiBLnL4J4GCJDPXElT/l4WOKCHki0BK
        jlviCxzUKW3N2L5IISFRJb3sNQ20k3ttXp6kmLYPFJ2U3PhATFFq+
X-Google-Smtp-Source: APXvYqwsVbb2HoOkoXKr/2NhQHafyPmdzCRf+f60NCCfCa1LdDYn/HV9c3eX8bvQKqo/d+QRSd+NIme+
X-Received: by 2002:aca:1208:: with SMTP id 8mr3059325ois.45.1557956729054;
 Wed, 15 May 2019 14:45:29 -0700 (PDT)
Date:   Wed, 15 May 2019 17:45:01 -0400
In-Reply-To: <20190515214503.77162-1-brho@google.com>
Message-Id: <20190515214503.77162-7-brho@google.com>
Mime-Version: 1.0
References: <20190515214503.77162-1-brho@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v7 6/8] blame: optionally track line fingerprints during fill_blame_origin()
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
2.21.0.1020.gf2820cf01a-goog

