Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A56720248
	for <e@80x24.org>; Wed,  3 Apr 2019 16:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfDCQCX (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 12:02:23 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:50476 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDCQCU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 12:02:20 -0400
Received: by mail-qt1-f201.google.com with SMTP id g17so17085965qte.17
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 09:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vqpSvSVgsjiBDoqCJmRFvEvI1PO2DZZSVEUwTTuYrHc=;
        b=vmKDvrW6L9p6SxgeQnbn1UAcFCXksvbrgM52HL4ERM7B2GkRPB6W7ETAKVG7b9KxTJ
         lLHYZzxWV3reERpy3bOmc1s3/++TnCxjxaf+5eut+wLNLfJkl7xdnayGSfkTLpwWh6D6
         2+g0CX9oRPLbsJZ5EqkxYQ36RWKeD2zg+joEZlz3eAPq26XN1IuJ9IJNcgaoODZtCz1a
         8cgSBkvJv7ggAQXi2+u5G3oX++afcfa4y93kFQWcJDbAiNsuClXJluHQWsP+y7+ja+X8
         oNjUkTQN+7pXOOVP6XsXprLbj9NXw5T3/Ye2swkwotiwtpoHyctmVe6KgDwIz3Vsp/x4
         o+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vqpSvSVgsjiBDoqCJmRFvEvI1PO2DZZSVEUwTTuYrHc=;
        b=cvlO1fg0Sr5avZuZQYgYB4b0RwNepbn3TsOotDQPTRsF2EBhPCWpavUhDgQnAB4FE3
         Ouo1yZ6PE+V7FQZZexrTernvBThsltg9hOimPpv0/QgDk+251z7s42jYdbfkD/Cul6j0
         alR7AEdsajNPukQjmIMyTMQcpIdDNu1Ty+B0tL6NBy/UnVR56HjsLT3uJzoA3ZCHja2k
         x8BuQsfbEhvvm0GQjj6NA1LTMuDj1CmFbSMmnSQKDUJiDqJ352NedSNZpguN1lABOMSg
         jxvjxbquvuF2cXd5VSA2nZ8gd8NH9L6rE56qeO0gjmaHUlCOGJA5m23VASwuqC3rL39Z
         tKvA==
X-Gm-Message-State: APjAAAXjMuGSuQUQm2aQCJUm9ZPMfabW7ZNPox9xTg3XYBYPWCRE647/
        YDIROyMBFGWsWptlM/u8GkHc34EeZ78VOWoaFJI/64kUW9fNlChID5Rl++snisfhRRuNq96QbfP
        n2e5NYdpVFDKrzdkqKTEl2uR2hX31JLAyN8QrwPOjcc0OLd8pSCWU
X-Google-Smtp-Source: APXvYqwPhgXMhwwGgiBUH+FoolZ4y10KRB7Eqgi9F0FUIz8zaBwhKIup+GNn0RXhdWwRn4ExBJpzocZp
X-Received: by 2002:a0c:ad17:: with SMTP id u23mr30667qvc.41.1554307339375;
 Wed, 03 Apr 2019 09:02:19 -0700 (PDT)
Date:   Wed,  3 Apr 2019 12:02:04 -0400
In-Reply-To: <20190403160207.149174-1-brho@google.com>
Message-Id: <20190403160207.149174-4-brho@google.com>
Mime-Version: 1.0
References: <20190403160207.149174-1-brho@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v5 3/6] blame: optionally track the line starts during fill_blame_origin()
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

The line_starts array is an index of line number to file offset, so that
we can quickly find where a particular line begins in a file.  Prior to
this commit, we only tracked this information for the final file image,
i.e. the current version of the file.

This commit adds the ability to track this information for any version
of the file throughout the file's history.  In particular, we track this
info when we load the file's image into memory: fill_blame_origin().

This feature will be used when we attempt to pass blame entries to
parents when we "ignore" a commit.  Most uses of fill_blame_origin()
will not require this feature, hence the flag parameter.  Multiple calls
to fill_blame_origin() are idempotent, and any of them can request the
creation of the line_starts array.

Suggested-by: Michael Platings <michael@platin.gs>
Signed-off-by: Barret Rhoden <brho@google.com>
---
 blame.c | 76 ++++++++++++++++++++++++++++++++++-----------------------
 blame.h |  2 ++
 2 files changed, 48 insertions(+), 30 deletions(-)

diff --git a/blame.c b/blame.c
index 31e05c1458d8..cb5806f955a6 100644
--- a/blame.c
+++ b/blame.c
@@ -310,12 +310,42 @@ static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
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
 /*
  * Given an origin, prepare mmfile_t structure to be used by the
  * diff machinery
  */
 static void fill_origin_blob(struct diff_options *opt,
-			     struct blame_origin *o, mmfile_t *file, int *num_read_blob)
+			     struct blame_origin *o, mmfile_t *file,
+			     int *num_read_blob, int fill_line_starts)
 {
 	if (!o->file.ptr) {
 		enum object_type type;
@@ -339,11 +369,16 @@ static void fill_origin_blob(struct diff_options *opt,
 	}
 	else
 		*file = o->file;
+	if (fill_line_starts && !o->line_starts)
+		o->num_lines = find_line_starts(&o->line_starts, o->file.ptr,
+						o->file.size);
 }
 
 static void drop_origin_blob(struct blame_origin *o)
 {
 	FREE_AND_NULL(o->file.ptr);
+	FREE_AND_NULL(o->line_starts);
+	o->num_lines = 0;
 }
 
 /*
@@ -992,8 +1027,10 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 	d.offset = 0;
 	d.dstq = &newdest; d.srcq = &target->suspects;
 
-	fill_origin_blob(&sb->revs->diffopt, parent, &file_p, &sb->num_read_blob);
-	fill_origin_blob(&sb->revs->diffopt, target, &file_o, &sb->num_read_blob);
+	fill_origin_blob(&sb->revs->diffopt, parent, &file_p,
+			 &sb->num_read_blob, 0);
+	fill_origin_blob(&sb->revs->diffopt, target, &file_o,
+			 &sb->num_read_blob, 0);
 	sb->num_get_patch++;
 
 	if (diff_hunks(&file_p, &file_o, blame_chunk_cb, &d, sb->xdl_opts))
@@ -1199,7 +1236,8 @@ static void find_move_in_parent(struct blame_scoreboard *sb,
 	if (!unblamed)
 		return; /* nothing remains for this target */
 
-	fill_origin_blob(&sb->revs->diffopt, parent, &file_p, &sb->num_read_blob);
+	fill_origin_blob(&sb->revs->diffopt, parent, &file_p,
+			 &sb->num_read_blob, 0);
 	if (!file_p.ptr)
 		return;
 
@@ -1328,7 +1366,8 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 			norigin = get_origin(parent, p->one->path);
 			oidcpy(&norigin->blob_oid, &p->one->oid);
 			norigin->mode = p->one->mode;
-			fill_origin_blob(&sb->revs->diffopt, norigin, &file_p, &sb->num_read_blob);
+			fill_origin_blob(&sb->revs->diffopt, norigin, &file_p,
+					 &sb->num_read_blob, 0);
 			if (!file_p.ptr)
 				continue;
 
@@ -1650,37 +1689,14 @@ void assign_blame(struct blame_scoreboard *sb, int opt)
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
index be3a895043e0..b418bd2e480d 100644
--- a/blame.h
+++ b/blame.h
@@ -51,6 +51,8 @@ struct blame_origin {
 	 */
 	struct blame_entry *suspects;
 	mmfile_t file;
+	int num_lines;
+	int *line_starts;
 	struct object_id blob_oid;
 	unsigned mode;
 	/* guilty gets set when shipping any suspects to the final
-- 
2.21.0.392.gf8f6787159e-goog

