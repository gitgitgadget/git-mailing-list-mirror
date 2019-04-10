Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85D3A20248
	for <e@80x24.org>; Wed, 10 Apr 2019 16:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbfDJQYl (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 12:24:41 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:36409 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbfDJQYl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 12:24:41 -0400
Received: by mail-yw1-f74.google.com with SMTP id j62so2263217ywe.3
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 09:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QLlXN3I+bp5KCEJluQJtM8Yn9PL6gAMSYHPWxkqoTfQ=;
        b=Ce7xBj+hKsG8a9izSuXnmp7jrNewzi534esvmt2iUNndMhfPOdSAMQfllIEeRJ160z
         ayonQQmwl+xnjIGMXXKkzgHuf+cyLvHfl+Q1bvhus+7FxtOjwAvnJs6bra6lTW9rFpVr
         DXzVJStVng3S94zuFmiX/ybpSi6z4NS7cozT/NrC6RmiKjpBMjjBHmrFpo9nuBtqJjYW
         HMhjaUUxDIX2PoOPoUndAwC7gkYqavkedHuboJGcb7AQAIrrj7a2+PSw+MBJaunRgqhd
         YU2zPwS8OR5VuCBimd0xZTqwgthIPSv9xFDA/tVESkNKZWlP3WRwdVZVLl+wic9LKOfM
         nKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QLlXN3I+bp5KCEJluQJtM8Yn9PL6gAMSYHPWxkqoTfQ=;
        b=BuGQByCqml0Sq35pGXx2tmmyaPJran4WXyj1x98cME1//IM/D9cdKKur6fzqUsuNUb
         /Ut4cl+FccZz3J5/3d9V26tBkBCUOwAECjGNPXnroCtSjQP1X1KGHa/jn80lghO2ji3Z
         Hfo01vvAmQP4qEAK6mEVSAQPWaAITaKpm9r0rCMTBLS+VxFda9xvHzg9LCDbrMIO97RD
         GHJ+JLRXuwwpfLO79iwEyH9dMqCLvdd0SmxzqgRXb2LboI5sOUknQFJcLbK9pXDaASGp
         cNu3CuPiaKQRA0eJw9fn4jTEHh7fz7ExSQEqAoJ2Kbq0jJnZe7QUOVYm3fm0QxaSuDWb
         fM0A==
X-Gm-Message-State: APjAAAUobB3JFSZ+waShL8y7G9+u/d5GoygpWKxJBilQJWnvJc7jCh1L
        hQ8hu4CWaJPe2CnpvgluY1cl4bWWua6JiprEf0EKojKjUDWbDASjCTrgutaML3dchPkvKR9jmu+
        TxlsN2G5rZEIOnmTwf/Ad30NOFLmGgjTzKP09SqcdIwE2wNVBCjWx
X-Google-Smtp-Source: APXvYqxsz1PF3nrblFMgz8NQ9V4eJFnzr2Qw9qN2/nJU2L+jg83jlzNH9M09GmRo14/LBdRbMB9qR8UK
X-Received: by 2002:a25:6a08:: with SMTP id f8mr4442424ybc.3.1554913480062;
 Wed, 10 Apr 2019 09:24:40 -0700 (PDT)
Date:   Wed, 10 Apr 2019 12:24:07 -0400
In-Reply-To: <20190410162409.117264-1-brho@google.com>
Message-Id: <20190410162409.117264-5-brho@google.com>
Mime-Version: 1.0
References: <20190410162409.117264-1-brho@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v6 4/6] blame: add config options to handle output for ignored lines
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
responsible for the change.  Users might want to know when a particular
line has a potentially inaccurate blame.  Furthermore, they might never
want to see the object hash of an ignored commit.

This patch adds two config options to control the output behavior.

The first option can identify ignored lines by specifying
blame.markIgnoredFiles.  When this option is set, each blame line is
marked with an '*'.

For example:
	278b6158d6fdb (Barret Rhoden  2016-04-11 13:57:54 -0400 26)
appears as:
	*278b6158d6fd (Barret Rhoden  2016-04-11 13:57:54 -0400 26)

where the '*' is placed before the commit, and the hash has one fewer
characters.

Sometimes we are unable to even guess at what commit touched a line.
These lines are 'unblamable.'  The second option,
blame.maskIgnoredUnblamables, will zero the hash of any unblamable line.

For example, say we ignore e5e8d36d04cbe:
	e5e8d36d04cbe (Barret Rhoden  2016-04-11 13:57:54 -0400 26)
appears as:
	0000000000000 (Barret Rhoden  2016-04-11 13:57:54 -0400 26)

Signed-off-by: Barret Rhoden <brho@google.com>
---
 Documentation/blame-options.txt |  6 +++++-
 Documentation/config/blame.txt  |  9 +++++++++
 blame.c                         |  4 ++++
 blame.h                         |  1 +
 builtin/blame.c                 | 18 +++++++++++++++--
 t/t8013-blame-ignore-revs.sh    | 34 +++++++++++++++++++++++++++++++++
 6 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 8f155196c6fe..e7b8b5e4b87b 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -115,7 +115,11 @@ take effect.
 	change never happened.  Lines that were changed or added by an ignored
 	commit will be blamed on the previous commit that changed that line or
 	nearby lines.  This option may be specified multiple times to ignore
-	more than one revision.
+	more than one revision.  If the `blame.markIgnoredLines` config option
+	is set, then lines that were changed by an ignored commit will be
+	marked with a `*` in the blame output.  If the
+	`blame.maskIgnoredUnblamables` config option is set, then those lines that
+	we could not attribute to another revision are outputted as all zeros.
 
 --ignore-revs-file <file>::
 	Ignore revisions listed in `file`, one unabbreviated object name per line.
diff --git a/Documentation/config/blame.txt b/Documentation/config/blame.txt
index 4da2788f306d..bb6674227da1 100644
--- a/Documentation/config/blame.txt
+++ b/Documentation/config/blame.txt
@@ -26,3 +26,12 @@ blame.ignoreRevsFile::
 	`#` are ignored.  This option may be repeated multiple times.  Empty
 	file names will reset the list of ignored revisions.  This option will
 	be handled before the command line option `--ignore-revs-file`.
+
+blame.maskIgnoredUnblamables::
+	Output an object hash of all zeros for lines that were changed by an ignored
+	revision and that we could not attribute to another revision in the output
+	of linkgit:git-blame[1].
+
+blame.markIgnoredLines::
+	Mark lines that were changed by an ignored revision with a '*' in the
+	output of linkgit:git-blame[1].
diff --git a/blame.c b/blame.c
index 0bbb86ad5985..a98ae00e2cfc 100644
--- a/blame.c
+++ b/blame.c
@@ -481,6 +481,7 @@ void blame_coalesce(struct blame_scoreboard *sb)
 	for (ent = sb->ent; ent && (next = ent->next); ent = next) {
 		if (ent->suspect == next->suspect &&
 		    ent->s_lno + ent->num_lines == next->s_lno &&
+		    ent->ignored == next->ignored &&
 		    ent->unblamable == next->unblamable) {
 			ent->num_lines += next->num_lines;
 			ent->next = next->next;
@@ -733,6 +734,7 @@ static void split_overlap(struct blame_entry *split,
 	int chunk_end_lno;
 	memset(split, 0, sizeof(struct blame_entry [3]));
 
+	split[0].ignored = split[1].ignored = split[2].ignored = e->ignored;
 	split[0].unblamable = e->unblamable;
 	split[1].unblamable = e->unblamable;
 	split[2].unblamable = e->unblamable;
@@ -857,6 +859,7 @@ static struct blame_entry *split_blame_at(struct blame_entry *e, int len,
 	struct blame_entry *n = xcalloc(1, sizeof(struct blame_entry));
 
 	n->suspect = new_suspect;
+	n->ignored = e->ignored;
 	n->unblamable = e->unblamable;
 	n->lno = e->lno + len;
 	n->s_lno = e->s_lno + len;
@@ -922,6 +925,7 @@ static void ignore_blame_entry(struct blame_entry *e,
 	struct blame_line_tracker *line_blames;
 	int entry_len, nr_lines, i;
 
+	e->ignored = 1;
 	line_blames = xcalloc(sizeof(struct blame_line_tracker),
 			      e->num_lines);
 	guess_line_blames(e, parent, target, offset, parent_slno, parent_len,
diff --git a/blame.h b/blame.h
index 91664913d7c4..53df8b4c5b3f 100644
--- a/blame.h
+++ b/blame.h
@@ -92,6 +92,7 @@ struct blame_entry {
 	 * scanning the lines over and over.
 	 */
 	unsigned score;
+	int ignored;
 	int unblamable;
 };
 
diff --git a/builtin/blame.c b/builtin/blame.c
index b48842d8459b..c10a6a802240 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -53,6 +53,8 @@ static int show_progress;
 static char repeated_meta_color[COLOR_MAXLEN];
 static int coloring_mode;
 static struct string_list ignore_revs_file_list = STRING_LIST_INIT_NODUP;
+static int mask_ignored_unblamables;
+static int mark_ignored_lines;
 
 static struct date_mode blame_date_mode = { DATE_ISO8601 };
 static size_t blame_date_width;
@@ -347,7 +349,7 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
 	char hex[GIT_MAX_HEXSZ + 1];
 
 	oid_to_hex_r(hex, &suspect->commit->object.oid);
-	if (ent->unblamable)
+	if (mask_ignored_unblamables && ent->unblamable)
 		memset(hex, '0', strlen(hex));
 	printf("%s %d %d %d\n",
 	       hex,
@@ -482,7 +484,11 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 			}
 		}
 
-		if (ent->unblamable)
+		if (mark_ignored_lines && ent->ignored) {
+			length--;
+			putchar('*');
+		}
+		if (mask_ignored_unblamables && ent->unblamable)
 			memset(hex, '0', length);
 		printf("%.*s", length, hex);
 		if (opt & OUTPUT_ANNOTATE_COMPAT) {
@@ -710,6 +716,14 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 		string_list_insert(&ignore_revs_file_list, str);
 		return 0;
 	}
+	if (!strcmp(var, "blame.maskignoredunblamables")) {
+		mask_ignored_unblamables = git_config_bool(var, value);
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
index df4993f98682..cc049a390b0d 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -53,6 +53,7 @@ test_expect_success ignore_rev_changing_lines '
 # to have nothing in common with "line-one" or "line-two", to keep any
 # heuristics from matching them with any lines in the parent.
 test_expect_success ignore_rev_adding_unblamable_lines '
+	git config --add blame.maskIgnoredUnblamables true &&
 	test_write_lines line-one-change line-two-changed y3 y4 >file &&
 	git add file &&
 	test_tick &&
@@ -123,6 +124,39 @@ test_expect_success bad_files_and_revs '
 	test_i18ngrep "Invalid object name: NOREV" err
 	'
 
+# Commit Z will touch the first two lines.  Y touched all four.
+# 	A--B--X--Y--Z
+# The blame output when ignoring Z should be:
+# ^Y ... 1)
+# ^Y ... 2)
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
+	echo "*" >expect &&
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
 # Resetting the repo and creating:
 #
 # A--B--M
-- 
2.21.0.392.gf8f6787159e-goog

