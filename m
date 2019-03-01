Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FFCA20248
	for <e@80x24.org>; Fri,  1 Mar 2019 17:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389548AbfCARuq (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 12:50:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40249 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389525AbfCARup (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 12:50:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id q1so26823667wrp.7
        for <git@vger.kernel.org>; Fri, 01 Mar 2019 09:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uD2/GGmxvDd8L/mIQPckKtUmJpahwkmq1sK8JXYTvJQ=;
        b=KKA82mA7aZWz+/nAAKv6P1v3/GVk7asY0kXIjzgS/u2VY1H0YED89vf5LTZevk0mCq
         M2Ldhm63+Q9c6ky1mA3LaFnqfyWPyP2yhLq+DT+ds+qjChDU8zhMYLP+iPtozCc6h67P
         jwdX+A/Atbibj/NCDfJDpNnJ2Tizm64rrTNdWXzLdZipZayNAC+lHNKrUVi75C4TGnEm
         1C4PGgTd2+eZAKNONtXDcl6fVpuLMt0vpy0zA5VSF3K3G6GfxmrydxuHrtkKGRbebuPM
         MEe8jepMLBeZiJLvcpsDeUVEBLMmXocdhNCdZekosq0Djjt1WVtLtjfj4aLfNLWkee8Y
         sK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uD2/GGmxvDd8L/mIQPckKtUmJpahwkmq1sK8JXYTvJQ=;
        b=deFRwjvAocrSxT+hc6PUiJ3F53TEiuZDc3qvfDOp/G6YsAfGLNkBkjoHX6XiMxUcwP
         GH0myQk/iQYN+QExwlrl064KHHRDjPoJcFhBxF+w5hcqkIhE+ecVRVuqarmzCKBF+llf
         84xANQT/4f+KkT4mVpOdQtOLRla3SmzocJmB4VO+uhxIKncvApx9Bstg17EKGtDmq8Jj
         8fy2nnrlO6iczeSYp3Su2DKXTX0/PE1/29g7UJX6qwSNzYHeKhoKZL/s/AFyKe/MxWKN
         1NfUHX1cREOha70B2Lcz5535hcUsGWtXISHMZ9r4wj+aAu+WZ/OGyktmeMLLWAlOOt7K
         LRVg==
X-Gm-Message-State: APjAAAVyFXVimxPp22kVC9I/R5mBjeo3moSiuDPW9zH9+dc6sZFDJW0Y
        bAMbaD7aHaorKZBTv6sAL8EVjamK
X-Google-Smtp-Source: APXvYqx80UGaY8dBEJcFTVIs4XHHl3bMVRL6L+lz7K2cSjlCkwCiUZWRxmhvvj2pAjU8QU+MiKddiw==
X-Received: by 2002:a5d:6983:: with SMTP id g3mr4422346wru.286.1551462643334;
        Fri, 01 Mar 2019 09:50:43 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-112-206.w86-199.abo.wanadoo.fr. [86.199.35.206])
        by smtp.googlemail.com with ESMTPSA id o8sm11672247wma.1.2019.03.01.09.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 09:50:42 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH 4/4] =?UTF-8?q?name-rev:=20avoid=20naming=20from=20a?= =?UTF-8?q?=20ref=20if=20it=E2=80=99s=20not=20a=20descendant=20of=20any=20?= =?UTF-8?q?commit?=
Date:   Fri,  1 Mar 2019 18:50:24 +0100
Message-Id: <20190301175024.17337-5-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190301175024.17337-1-alban.gruin@gmail.com>
References: <20190301175024.17337-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A ref may not be the descendant of all of the commits mentionned in
stdin.  In this case, we want to avoid naming its parents.

To do this, find_commits_in_strbuf() is created.  It returns a raw list
of all the commits that have been found in the input buffer.  ishex() is
converted to an inlined function.  Then, we add a raw list of commits in
the name_ref_data structure, and call find_commits_in_strbuf() before
for_each_ref() if the user wants name-ref to process stdin.  Then, for
each ref, we check if the reachable subset of this commit list is empty
or not.  If it is, we do not call name_rev(), so we don’t name its
parents.

The code dealing with stdin after calling for_each_ref() is no longer
needed as we already read it.  name_rev_line() is renamed name_rev_buf()
to reflect its new role better.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/name-rev.c | 91 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 76 insertions(+), 15 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 2f89ed50a1..f5860f5625 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -8,6 +8,7 @@
 #include "parse-options.h"
 #include "sha1-lookup.h"
 #include "commit-slab.h"
+#include "commit-reach.h"
 
 #define CUTOFF_DATE_SLOP 86400 /* one day */
 
@@ -183,6 +184,8 @@ struct name_ref_data {
 	int name_only;
 	struct string_list ref_filters;
 	struct string_list exclude_filters;
+	struct commit **commits;
+	int commits_nr;
 };
 
 static struct tip_table {
@@ -279,13 +282,21 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 	}
 	if (o && o->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)o;
+		struct commit_list *reachable_commits = NULL;
 		int from_tag = starts_with(path, "refs/tags/");
 
-		if (taggerdate == TIME_MAX)
-			taggerdate = ((struct commit *)o)->date;
-		path = name_ref_abbrev(path, can_abbreviate_output);
-		name_rev(commit, xstrdup(path), taggerdate, 0, 0,
-			 from_tag, deref, NULL);
+		reachable_commits = get_reachable_subset(&commit, 1,
+							 data->commits, data->commits_nr, 0);
+
+		if (commit_list_count(reachable_commits) > 0 || data->commits_nr == 0) {
+			if (taggerdate == TIME_MAX)
+				taggerdate = ((struct commit *)o)->date;
+			path = name_ref_abbrev(path, can_abbreviate_output);
+			name_rev(commit, xstrdup(path), taggerdate, 0, 0,
+				 from_tag, deref, reachable_commits);
+		}
+
+		free_commit_list(reachable_commits);
 	}
 	return 0;
 }
@@ -369,13 +380,53 @@ static char const * const name_rev_usage[] = {
 	NULL
 };
 
-static void name_rev_line(char *p, struct name_ref_data *data)
+static inline int ishex(char p)
+{
+	return isdigit(p) || (p >= 'a' && p <= 'f');
+}
+
+static struct commit **find_commits_in_strbuf(struct strbuf *buf, int *count)
+{
+	int forty = 0;
+	char *p;
+	struct commit **commits = NULL;
+
+	*count = 0;
+
+	for (p = buf->buf; *p; p++) {
+		if (!ishex(*p))
+			forty = 0;
+		else if (++forty == GIT_SHA1_HEXSZ &&
+			 !ishex(*(p+1))) {
+			struct object_id oid;
+			char c = *(p+1);
+
+			*(p+1) = 0;
+			if (!get_oid(p - (GIT_SHA1_HEXSZ -1), &oid)) {
+				struct object *o =
+					parse_object(the_repository, &oid);
+
+				if (o && o->type == OBJ_COMMIT) {
+					struct commit *c = (struct commit *) o;
+
+					REALLOC_ARRAY(commits, (*count) + 1);
+					commits[(*count)++] = c;
+					set_commit_rev_name(c, NULL);
+				}
+			}
+			*(p+1) = c;
+		}
+	}
+
+	return commits;
+}
+
+static void name_rev_buf(char *p, struct name_ref_data *data)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int forty = 0;
 	char *p_start;
 	for (p_start = p; *p; p++) {
-#define ishex(x) (isdigit((x)) || ((x) >= 'a' && (x) <= 'f'))
 		if (!ishex(*p))
 			forty = 0;
 		else if (++forty == GIT_SHA1_HEXSZ &&
@@ -419,7 +470,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 {
 	struct object_array revs = OBJECT_ARRAY_INIT;
 	int all = 0, transform_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
-	struct name_ref_data data = { 0, 0, STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP };
+	struct name_ref_data data = { 0, 0, STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP, NULL, 0 };
 	struct option opts[] = {
 		OPT_BOOL(0, "name-only", &data.name_only, N_("print only names (no SHA-1)")),
 		OPT_BOOL(0, "tags", &data.tags_only, N_("only use tags to name the commits")),
@@ -496,20 +547,27 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 
 	if (cutoff)
 		cutoff = cutoff - CUTOFF_DATE_SLOP;
-	for_each_ref(name_ref, &data);
 
 	if (transform_stdin) {
-		char buffer[2048];
+		struct strbuf buf = STRBUF_INIT;
 
-		while (!feof(stdin)) {
-			char *p = fgets(buffer, sizeof(buffer), stdin);
-			if (!p)
-				break;
-			name_rev_line(p, &data);
+		strbuf_read(&buf, STDIN_FILENO, 0);
+		data.commits = find_commits_in_strbuf(&buf, &data.commits_nr);
+
+		if (data.commits_nr > 0) {
+			for_each_ref(name_ref, &data);
+			name_rev_buf(buf.buf, &data);
+		} else {
+			fwrite(buf.buf, buf.len, 1, stdout);
 		}
+
+		free(data.commits);
+		strbuf_release(&buf);
 	} else if (all) {
 		int i, max;
 
+		for_each_ref(name_ref, &data);
+
 		max = get_max_object_index();
 		for (i = 0; i < max; i++) {
 			struct object *obj = get_indexed_object(i);
@@ -520,6 +578,9 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		}
 	} else {
 		int i;
+
+		for_each_ref(name_ref, &data);
+
 		for (i = 0; i < revs.nr; i++)
 			show_name(revs.objects[i].item, revs.objects[i].name,
 				  always, allow_undefined, data.name_only);
-- 
2.20.1

