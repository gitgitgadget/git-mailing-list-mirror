Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B8711F461
	for <e@80x24.org>; Thu, 20 Jun 2019 16:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbfFTQio (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 12:38:44 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:37768 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731974AbfFTQio (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 12:38:44 -0400
Received: by mail-qt1-f202.google.com with SMTP id g56so4360256qte.4
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 09:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=k+qVOvEoLg452cO5ev0b1305aLPkQsAjh+71utxKwWY=;
        b=rxTcObiiT3Y1lj0HWAvdmkMwUtzINDwMh32GcSo+hVMiAVGEW26cP9rMA7Ayz+5y8i
         GlUPvfQJhe1QTWSGqoPKOWTaikBbKI6jBdaWwZYkATtInTYrc+5KpdtLmp8DFNx0jxiy
         Yr2zurthZbz5+9Ma3EKcPETFDUNli1jFXh9PQzzMWWbul9mlt2iQtC/yO3tyoQYG+rub
         usckZLf4swihjhaTasFIXj5nL6DrHy96Y/z4VZpOL9s2oRiJ+GzX81izS1qeW0H/8QUZ
         Gxk9IVJNAvMKq8Cpx6NSGZLf2CRvz0J71y0Risl6Vyj2bP2OADn7ffqtsrSAPQcNwd3P
         O+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=k+qVOvEoLg452cO5ev0b1305aLPkQsAjh+71utxKwWY=;
        b=cPJBj9gAEEtqB+kys0amUv9LTkidaBifn23wnVDM7IDotTF7mRsfZYlhLwxoPv2938
         iz2HgFC9ygs12ne7QiQYV7mF9M4Y96Ih5HfrUN+U8NrmIU1+dbt6g1OA2bhrdpQH0z9R
         wCrbK8RMozofj9Bjz/vwV1NT7yeLifjeOcIDu/SCOzv1lYEuDOg9MYoAt0dSSpKKhzlx
         S7BdREv9l6GKs1bt5O/tT4Za3DLwQgAC/CPRpPEeJAJTuwhTbqebTFpI/kvYwji/XTv5
         IwGoTtjpqu/E3iGcb16sEoipLXM04cR3uKrnmznEmBk9hrhNF2Evp/RA0mZV2M/wZ+u4
         CKcQ==
X-Gm-Message-State: APjAAAW8w2bAn3cOhtQVkHxj3DnyGrww0KcN9DAmJDk42vcPWaK5H9Hx
        eOz/vrPVd+D5aSb9cT28gtCLDsAvJq/QR7RJ/OJL1iwPF+bNwyHTYlQTlGCJrlsEjBMEF8q5KKa
        6rzPHwnFblOVIbyZ7AuLeYE0rBv1kljFryYLRYF8awTw23WRlO9av
X-Google-Smtp-Source: APXvYqzYNIUs1tMaK/aKe3d5eir1VEZOstcOU8b9UQO1pFBZj3ipwcXSfyTKY0rHWHjBq//vMKMAGB/J
X-Received: by 2002:a37:9f0a:: with SMTP id i10mr38132742qke.91.1561048722792;
 Thu, 20 Jun 2019 09:38:42 -0700 (PDT)
Date:   Thu, 20 Jun 2019 12:38:16 -0400
In-Reply-To: <20190620163820.231316-1-brho@google.com>
Message-Id: <20190620163820.231316-6-brho@google.com>
Mime-Version: 1.0
References: <20190620163820.231316-1-brho@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v9 5/9] blame: add config options for the output of ignored or
 unblamable lines
From:   Barret Rhoden <brho@google.com>
To:     git@vger.kernel.org
Cc:     "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Ren=C3=A9=20Scharfe?=" <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Michael Platings <michael@platin.gs>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When ignoring commits, the commit that is blamed might not be
responsible for the change, due to the inaccuracy of our heuristic.
Users might want to know when a particular line has a potentially
inaccurate blame.

Furthermore, guess_line_blames() may fail to find any parent commit for
a given line touched by an ignored commit.  Those 'unblamable' lines
remain blamed on an ignored commit.  Users might want to know if a line
is unblamable so that they do not spend time investigating a commit they
know is uninteresting.

This patch adds two config options to mark these two types of lines in
the output of blame.

The first option can identify ignored lines by specifying
blame.markIgnoredLines.  When this option is set, each blame line that
was blamed on a commit other than the ignored commit is marked with a
'?'.

For example:
	278b6158d6fdb (Barret Rhoden  2016-04-11 13:57:54 -0400 26)
appears as:
	?278b6158d6fd (Barret Rhoden  2016-04-11 13:57:54 -0400 26)

where the '?' is placed before the commit, and the hash has one fewer
characters.

Sometimes we are unable to even guess at what ancestor commit touched a
line.  These lines are 'unblamable.'  The second option,
blame.markUnblamableLines, will mark the line with '*'.

For example, say we ignore e5e8d36d04cbe, yet we are unable to blame
this line on another commit:
	e5e8d36d04cbe (Barret Rhoden  2016-04-11 13:57:54 -0400 26)
appears as:
	*e5e8d36d04cb (Barret Rhoden  2016-04-11 13:57:54 -0400 26)

When these config options are used together, every line touched by an
ignored commit will be marked with either a '?' or a '*'.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 Documentation/blame-options.txt |  7 +++-
 Documentation/config/blame.txt  |  9 +++++
 blame.c                         | 14 ++++++-
 blame.h                         |  2 +
 builtin/blame.c                 | 18 +++++++++
 t/t8013-blame-ignore-revs.sh    | 71 +++++++++++++++++++++++++++++++++
 6 files changed, 119 insertions(+), 2 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 2c2d1ceb5653..5d122db6e9e6 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -115,7 +115,12 @@ take effect.
 	change never happened.  Lines that were changed or added by an ignored
 	commit will be blamed on the previous commit that changed that line or
 	nearby lines.  This option may be specified multiple times to ignore
-	more than one revision.
+	more than one revision.  If the `blame.markIgnoredLines` config option
+	is set, then lines that were changed by an ignored commit and attributed to
+	another commit will be marked with a `?` in the blame output.  If the
+	`blame.markUnblamableLines` config option is set, then those lines touched
+	by an ignored commit that we could not attribute to another revision are
+	marked with a '*'.
 
 --ignore-revs-file <file>::
 	Ignore revisions listed in `file`, which must be in the same format as an
diff --git a/Documentation/config/blame.txt b/Documentation/config/blame.txt
index 4da2788f306d..9468e8599c0c 100644
--- a/Documentation/config/blame.txt
+++ b/Documentation/config/blame.txt
@@ -26,3 +26,12 @@ blame.ignoreRevsFile::
 	`#` are ignored.  This option may be repeated multiple times.  Empty
 	file names will reset the list of ignored revisions.  This option will
 	be handled before the command line option `--ignore-revs-file`.
+
+blame.markUnblamables::
+	Mark lines that were changed by an ignored revision that we could not
+	attribute to another commit with a '*' in the output of
+	linkgit:git-blame[1].
+
+blame.markIgnoredLines::
+	Mark lines that were changed by an ignored revision that we attributed to
+	another commit with a '?' in the output of linkgit:git-blame[1].
diff --git a/blame.c b/blame.c
index 290bc97f31db..21ae76603f5c 100644
--- a/blame.c
+++ b/blame.c
@@ -480,7 +480,9 @@ void blame_coalesce(struct blame_scoreboard *sb)
 
 	for (ent = sb->ent; ent && (next = ent->next); ent = next) {
 		if (ent->suspect == next->suspect &&
-		    ent->s_lno + ent->num_lines == next->s_lno) {
+		    ent->s_lno + ent->num_lines == next->s_lno &&
+		    ent->ignored == next->ignored &&
+		    ent->unblamable == next->unblamable) {
 			ent->num_lines += next->num_lines;
 			ent->next = next->next;
 			blame_origin_decref(next->suspect);
@@ -730,8 +732,14 @@ static void split_overlap(struct blame_entry *split,
 			  struct blame_origin *parent)
 {
 	int chunk_end_lno;
+	int i;
 	memset(split, 0, sizeof(struct blame_entry [3]));
 
+	for (i = 0; i < 3; i++) {
+		split[i].ignored = e->ignored;
+		split[i].unblamable = e->unblamable;
+	}
+
 	if (e->s_lno < tlno) {
 		/* there is a pre-chunk part not blamed on parent */
 		split[0].suspect = blame_origin_incref(e->suspect);
@@ -852,6 +860,8 @@ static struct blame_entry *split_blame_at(struct blame_entry *e, int len,
 	struct blame_entry *n = xcalloc(1, sizeof(struct blame_entry));
 
 	n->suspect = new_suspect;
+	n->ignored = e->ignored;
+	n->unblamable = e->unblamable;
 	n->lno = e->lno + len;
 	n->s_lno = e->s_lno + len;
 	n->num_lines = e->num_lines - len;
@@ -940,12 +950,14 @@ static void ignore_blame_entry(struct blame_entry *e,
 					      blame_origin_incref(e->suspect));
 		}
 		if (line_blames[i].is_parent) {
+			e->ignored = 1;
 			blame_origin_decref(e->suspect);
 			e->suspect = blame_origin_incref(parent);
 			e->s_lno = line_blames[i - entry_len + 1].s_lno;
 			e->next = *ignoredp;
 			*ignoredp = e;
 		} else {
+			e->unblamable = 1;
 			/* e->s_lno is already in the target's address space. */
 			e->next = *diffp;
 			*diffp = e;
diff --git a/blame.h b/blame.h
index bd2f23ca36cf..2458b68f0e22 100644
--- a/blame.h
+++ b/blame.h
@@ -92,6 +92,8 @@ struct blame_entry {
 	 * scanning the lines over and over.
 	 */
 	unsigned score;
+	int ignored;
+	int unblamable;
 };
 
 /*
diff --git a/builtin/blame.c b/builtin/blame.c
index b8ef1e547cae..ce5b0f283843 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -54,6 +54,8 @@ static int show_progress;
 static char repeated_meta_color[COLOR_MAXLEN];
 static int coloring_mode;
 static struct string_list ignore_revs_file_list = STRING_LIST_INIT_NODUP;
+static int mark_unblamable_lines;
+static int mark_ignored_lines;
 
 static struct date_mode blame_date_mode = { DATE_ISO8601 };
 static size_t blame_date_width;
@@ -481,6 +483,14 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 			}
 		}
 
+		if (mark_unblamable_lines && ent->unblamable) {
+			length--;
+			putchar('*');
+		}
+		if (mark_ignored_lines && ent->ignored) {
+			length--;
+			putchar('?');
+		}
 		printf("%.*s", length, hex);
 		if (opt & OUTPUT_ANNOTATE_COMPAT) {
 			const char *name;
@@ -707,6 +717,14 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 		string_list_insert(&ignore_revs_file_list, str);
 		return 0;
 	}
+	if (!strcmp(var, "blame.markunblamablelines")) {
+		mark_unblamable_lines = git_config_bool(var, value);
+		return 0;
+	}
+	if (!strcmp(var, "blame.markignoredlines")) {
+		mark_ignored_lines = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "color.blame.repeatedlines")) {
 		if (color_parse_mem(value, strlen(value), repeated_meta_color))
 			warning(_("invalid color '%s' in color.blame.repeatedLines"),
diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
index fdb2fa879781..36dc31eb3913 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -121,6 +121,77 @@ test_expect_success bad_files_and_revs '
 	test_must_fail git blame file --ignore-revs-file ignore_norev 2>err &&
 	test_i18ngrep "invalid object name: NOREV" err
 	'
+
+# For ignored revs that have added 'unblamable' lines, mark those lines with a
+# '*'
+# 	A--B--X--Y
+# Lines 3 and 4 are from Y and unblamable.  This was set up in
+# ignore_rev_adding_unblamable_lines.
+test_expect_success mark_unblamable_lines '
+	git config --add blame.markUnblamableLines true &&
+
+	git blame --ignore-rev Y file >blame_raw &&
+	echo "*" >expect &&
+
+	sed -n "3p" blame_raw | cut -c1 >actual &&
+	test_cmp expect actual &&
+
+	sed -n "4p" blame_raw | cut -c1 >actual &&
+	test_cmp expect actual
+	'
+
+# Commit Z will touch the first two lines.  Y touched all four.
+# 	A--B--X--Y--Z
+# The blame output when ignoring Z should be:
+# ?Y ... 1)
+# ?Y ... 2)
+# Y  ... 3)
+# Y  ... 4)
+# We're checking only the first character
+test_expect_success mark_ignored_lines '
+	git config --add blame.markIgnoredLines true &&
+
+	test_write_lines line-one-Z line-two-Z y3 y4 >file &&
+	git add file &&
+	test_tick &&
+	git commit -m Z &&
+	git tag Z &&
+
+	git blame --ignore-rev Z file >blame_raw &&
+	echo "?" >expect &&
+
+	sed -n "1p" blame_raw | cut -c1 >actual &&
+	test_cmp expect actual &&
+
+	sed -n "2p" blame_raw | cut -c1 >actual &&
+	test_cmp expect actual &&
+
+	sed -n "3p" blame_raw | cut -c1 >actual &&
+	! test_cmp expect actual &&
+
+	sed -n "4p" blame_raw | cut -c1 >actual &&
+	! test_cmp expect actual
+	'
+
+# For ignored revs that added 'unblamable' lines and more recent commits changed
+# the blamable lines, mark the unblamable lines with a
+# '*'
+# 	A--B--X--Y--Z
+# Lines 3 and 4 are from Y and unblamable, as set up in
+# ignore_rev_adding_unblamable_lines.  Z changed lines 1 and 2.
+test_expect_success mark_unblamable_lines_intermediate '
+	git config --add blame.markUnblamableLines true &&
+
+	git blame --ignore-rev Y file >blame_raw 2>stderr &&
+	echo "*" >expect &&
+
+	sed -n "3p" blame_raw | cut -c1 >actual &&
+	test_cmp expect actual &&
+
+	sed -n "4p" blame_raw | cut -c1 >actual &&
+	test_cmp expect actual
+	'
+
 # The heuristic called by guess_line_blames() tries to find the size of a
 # blame_entry 'e' in the parent's address space.  Those calculations need to
 # check for negative or zero values for when a blame entry is completely outside
-- 
2.22.0.410.gd8fdbe21b5-goog

