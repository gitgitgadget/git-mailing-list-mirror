Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A5231F453
	for <e@80x24.org>; Thu, 17 Jan 2019 20:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfAQU3i (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 15:29:38 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:48794 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbfAQU3h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 15:29:37 -0500
Received: by mail-qt1-f202.google.com with SMTP id q3so10298033qtq.15
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 12:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gzK1800BibhtAjTI2teyeWflF9LmM+2lkvkjJ9wvJFU=;
        b=vcpwje+wIQ7T+xT/f+J8xIJZy5mpM1sAY3J6ujG/ReaxYLJQD1HG3TjaYSu4F6lHop
         I8AwOGTpW9xheUEiWfV+Sg1okshMPn7gBT8Sj9YJ/8AjvQIxOf80c7rqoLrANEc3aUFw
         naUjbBmfH39KMeeVFn4YdJWUSxyt+NbmZWNgdgDk0nQ9qnm87I1AJwnSJs7vVo3yfXBI
         VAFvYYgAwzwCf1mh3x4TW3+VmdtJR9O85ug1W0JIMw02u99qWzgcbUEXeNllcvfPhlaO
         wN7N5KNmFCrX+dlEq+5HxMMlOcLHXWgcPad8gadCsW9I+0TfWZZmcz/3TjyWaTih4h30
         sqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gzK1800BibhtAjTI2teyeWflF9LmM+2lkvkjJ9wvJFU=;
        b=R/xHHYrSrmS9k5TMS8FxvgWxZ++FefRAD0s+D+lk+4ntVHeLBJC//s+jrW10V5KQ1s
         VHA67JVbQsGgSq39jopDcqSovRHNqO3Zkpaw4Hr54zQhxA5P5HCu7D+Il1woGsCWfqgh
         CeSYZkiHdLc5WgHUID1to6dKrF7z0vq1QPiOYB9VXYT3UR2rsSw2VJ12192mUQ+PTQ97
         AwLlxquozUJBDNv2A4PVyn/bKQXo+SKhWktrpTnYFK3HkI3TkhJe/L65+64MGEpqEwpc
         WfbszPoeHMi8HkZzlwhMM227gaoMDP5uHx6kD5agjZ7VweWq3i7sIwGvbsX9KVi7so+l
         P/6g==
X-Gm-Message-State: AJcUukeQNnnFNg4JUKLw7hQJD8SLZip4kd9aoYldSnoj/bKO4QnEKAtT
        seyDbaAjRRNcvl3MMlowP/abTBWbmnshm2t2nnwHlmpX4i1ssETqySiMmikBfv6np84OULR6haE
        tBPEZjnG6oDQ86/QiLo9l/btca3ms3tsqnhk1t6KgqLDjUn8S+Van
X-Google-Smtp-Source: ALg8bN46kxchF8S2ejDig3eAwQTVnTWX3B2qXls7JOtn5dPogNKzdGKMIBssr/xi6p0VOcmMBecTh48c
X-Received: by 2002:a0c:b988:: with SMTP id v8mr9157413qvf.29.1547756976559;
 Thu, 17 Jan 2019 12:29:36 -0800 (PST)
Date:   Thu, 17 Jan 2019 15:29:19 -0500
In-Reply-To: <20190117202919.157326-1-brho@google.com>
Message-Id: <20190117202919.157326-4-brho@google.com>
Mime-Version: 1.0
References: <20190107213013.231514-1-brho@google.com> <20190117202919.157326-1-brho@google.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH v2 3/3] blame: add a config option to mark ignored lines
From:   Barret Rhoden <brho@google.com>
To:     git@vger.kernel.org
Cc:     "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
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

When ignoring commits, the commit that is blamed might not be
responsible for the change.  Users might want to know when a particular
line has a potentially inaccurate blame.

By specifying blame.markIgnoredFiles, each blame line is marked with an
'*'.  For example:

278b6158d6fdb (Barret Rhoden  2016-04-11 13:57:54 -0400 26)

appears as:

*278b6158d6fd (Barret Rhoden  2016-04-11 13:57:54 -0400 26)

where the '*' is placed before the commit, and the hash has one fewer
characters.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 Documentation/blame-options.txt | 4 +++-
 blame.c                         | 8 +++++++-
 blame.h                         | 1 +
 builtin/blame.c                 | 9 +++++++++
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 424a63f0b45c..92787ae951ac 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -115,7 +115,9 @@ take effect.
 	change never happened.  Lines that were changed or added by an ignored
 	commit will be blamed on the previous commit that changed that line or
 	nearby lines.  This option may be specified multiple times to ignore
-	more than one revision.
+	more than one revision.  If the `blame.markIgnoredLines` config option
+	is set, then lines that were changed by an ignored commit will be
+	marked with a `*` in the blame output.
 
 --ignore-revs-file <file>::
 	Ignore revisions listed in `file`, one full SHA-1 hash per line.
diff --git a/blame.c b/blame.c
index 0b91fba2d04c..b1805633fb23 100644
--- a/blame.c
+++ b/blame.c
@@ -474,7 +474,8 @@ void blame_coalesce(struct blame_scoreboard *sb)
 
 	for (ent = sb->ent; ent && (next = ent->next); ent = next) {
 		if (ent->suspect == next->suspect &&
-		    ent->s_lno + ent->num_lines == next->s_lno) {
+		    ent->s_lno + ent->num_lines == next->s_lno &&
+		    ent->ignored == next->ignored) {
 			ent->num_lines += next->num_lines;
 			ent->next = next->next;
 			blame_origin_decref(next->suspect);
@@ -726,6 +727,8 @@ static void split_overlap(struct blame_entry *split,
 	int chunk_end_lno;
 	memset(split, 0, sizeof(struct blame_entry [3]));
 
+	split[0].ignored = split[1].ignored = split[2].ignored = e->ignored;
+
 	if (e->s_lno < tlno) {
 		/* there is a pre-chunk part not blamed on parent */
 		split[0].suspect = blame_origin_incref(e->suspect);
@@ -862,6 +865,7 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 			int len = tlno - e->s_lno;
 			struct blame_entry *n = xcalloc(1, sizeof (struct blame_entry));
 			n->suspect = e->suspect;
+			n->ignored = e->ignored;
 			n->lno = e->lno + len;
 			n->s_lno = e->s_lno + len;
 			n->num_lines = e->num_lines - len;
@@ -916,6 +920,7 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 			int len = same - e->s_lno;
 			struct blame_entry *n = xcalloc(1, sizeof (struct blame_entry));
 			n->suspect = blame_origin_incref(e->suspect);
+			n->ignored = e->ignored;
 			n->lno = e->lno + len;
 			n->s_lno = e->s_lno + len;
 			n->num_lines = e->num_lines - len;
@@ -930,6 +935,7 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 			blame_origin_decref(e->suspect);
 			e->suspect = blame_origin_incref(parent);
 			e->s_lno += offset;
+			e->ignored = 1;
 			e->next = ignoredp;
 			ignoredp = e;
 		} else {
diff --git a/blame.h b/blame.h
index 086b92915e4b..56aeff582b01 100644
--- a/blame.h
+++ b/blame.h
@@ -92,6 +92,7 @@ struct blame_entry {
 	 * scanning the lines over and over.
 	 */
 	unsigned score;
+	int ignored;
 };
 
 /*
diff --git a/builtin/blame.c b/builtin/blame.c
index 2f9183fb5fbd..8c3c5e435c9c 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -53,6 +53,7 @@ static int show_progress;
 static char repeated_meta_color[COLOR_MAXLEN];
 static int coloring_mode;
 static const char *ignore_revs_file;
+static int mark_ignored_lines;
 
 static struct date_mode blame_date_mode = { DATE_ISO8601 };
 static size_t blame_date_width;
@@ -480,6 +481,10 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 			}
 		}
 
+		if (mark_ignored_lines && ent->ignored) {
+			length--;
+			putchar('*');
+		}
 		printf("%.*s", length, hex);
 		if (opt & OUTPUT_ANNOTATE_COMPAT) {
 			const char *name;
@@ -698,6 +703,10 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp(var, "blame.ignorerevsfile"))
 		return git_config_pathname(&ignore_revs_file, var, value);
+	if (!strcmp(var, "blame.markignoredlines")) {
+		mark_ignored_lines = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "color.blame.repeatedlines")) {
 		if (color_parse_mem(value, strlen(value), repeated_meta_color))
 			warning(_("invalid color '%s' in color.blame.repeatedLines"),
-- 
2.20.1.321.g9e740568ce-goog

