Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6001B20248
	for <e@80x24.org>; Wed,  3 Apr 2019 16:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfDCQCX (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 12:02:23 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:43004 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfDCQCX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 12:02:23 -0400
Received: by mail-qt1-f201.google.com with SMTP id n10so17224088qtk.9
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 09:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3dyMHnqAjwUFinA6RxKtg0TlKX7tnV1KwyqZGhcxxyE=;
        b=Je7Im8b8KgRZE6X+0WJgQY+MilwqD95QFRhqOKbk04kQRwaKFmqmWzLtHJF7hYNyBS
         3v4VtxQIaNZYSLS9aDwabgoOBvrr5aSpulobwpusrHVVEr1rU9FZ7CwTp90CwzMYiZ+j
         GwmxddbCANTcalhkBV/S7LT1Xg61HEqopAOAbXRIyRGSfqvKtNXlfUyBL6H/kgFeij4Q
         WwRp1+DAHieK/PhNJg6fu3rtWQJ+dAkhXu26lVDr5CB8aFD9OyO8JyWz1fzRQwVRLH4c
         1kpLDtVPhG6yU/B3bUKlVPzl6w0ZVGxFNj44jSmFWe3LpP5uNehI/ZZ8dX4dJ8eRcFbS
         ni6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3dyMHnqAjwUFinA6RxKtg0TlKX7tnV1KwyqZGhcxxyE=;
        b=ScDq1PMwOBOcQxm7atfRRQ3/5wUFEsq0U2gV+SLfTy5vaDMEDhb+8hM/20eLvI/or/
         cCKElFbkXBSmvkv65Slbg7YCgrS4IDeTSPfAeUGfZW79e/ahnlNyKncGxVmQl2Suq/Ff
         B/slBrj/7Gfng3g5YBvJKKvx0u3QEkdl7IFZCdfQYpgUswNgWSJl9rlrfYHzJPQ5fUjz
         y6eUPC/TBdbV56NKEU+607yqs8IdEuAZrj9YErgNTp5B1SMgRWgZ0MKyZgIgfL/xrsle
         jnlnq5C6v7xz34RMgiLI956hxQEtBveR7CMpRyPwqbm4/UQfn53KuKp/TiQZEUaycidS
         FHcQ==
X-Gm-Message-State: APjAAAXC3Bg/Elp6vTuUxgQZOK5t5jOEIajQae+6GyFsHXnvuK1rEgfe
        JmJXhMys6CiCfLZHEWHAJcU7IOcba9cSYjLfo6a5QCbmam7XoE/kld4HHRL+zzpQU7HscT8hmbo
        gBJlEGtMVwE9mzKBQzb1bFPETTBt2Xtql/b5JfzjLuVrUo2zhusmE
X-Google-Smtp-Source: APXvYqzTF/oXu/hld4iiqWNXFJvBcXdPL4GeWYiNdbDn7Zbg8rC8d3As3Qjiolbb2rzSxkEXrbefXCN4
X-Received: by 2002:a0c:9596:: with SMTP id s22mr42683qvs.16.1554307341518;
 Wed, 03 Apr 2019 09:02:21 -0700 (PDT)
Date:   Wed,  3 Apr 2019 12:02:06 -0400
In-Reply-To: <20190403160207.149174-1-brho@google.com>
Message-Id: <20190403160207.149174-6-brho@google.com>
Mime-Version: 1.0
References: <20190403160207.149174-1-brho@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v5 5/6] blame: add a config option to mark ignored lines
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
line has a potentially inaccurate blame.

This patch adds a config option to identify these lines by specifying
blame.markIgnoredFiles.  When this option is set, each blame line is
marked with an '*'.  For example:

278b6158d6fdb (Barret Rhoden  2016-04-11 13:57:54 -0400 26)

appears as:

*278b6158d6fd (Barret Rhoden  2016-04-11 13:57:54 -0400 26)

where the '*' is placed before the commit, and the hash has one fewer
characters.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 Documentation/config/blame.txt |  4 ++++
 blame.c                        |  4 ++++
 blame.h                        |  1 +
 builtin/blame.c                |  9 +++++++++
 t/t8013-blame-ignore-revs.sh   | 33 +++++++++++++++++++++++++++++++++
 5 files changed, 51 insertions(+)

diff --git a/Documentation/config/blame.txt b/Documentation/config/blame.txt
index 4da2788f306d..9f7f0fcf42c9 100644
--- a/Documentation/config/blame.txt
+++ b/Documentation/config/blame.txt
@@ -26,3 +26,7 @@ blame.ignoreRevsFile::
 	`#` are ignored.  This option may be repeated multiple times.  Empty
 	file names will reset the list of ignored revisions.  This option will
 	be handled before the command line option `--ignore-revs-file`.
+
+blame.markIgnoredLines::
+	Mark lines that were changed by an ignored revision with a '*' in the
+	output of linkgit:git-blame[1].
diff --git a/blame.c b/blame.c
index e0612ac34ba7..c06cbd906658 100644
--- a/blame.c
+++ b/blame.c
@@ -515,6 +515,7 @@ void blame_coalesce(struct blame_scoreboard *sb)
 	for (ent = sb->ent; ent && (next = ent->next); ent = next) {
 		if (ent->suspect == next->suspect &&
 		    ent->s_lno + ent->num_lines == next->s_lno &&
+		    ent->ignored == next->ignored &&
 		    ent->unblamable == next->unblamable) {
 			ent->num_lines += next->num_lines;
 			ent->next = next->next;
@@ -767,6 +768,7 @@ static void split_overlap(struct blame_entry *split,
 	int chunk_end_lno;
 	memset(split, 0, sizeof(struct blame_entry [3]));
 
+	split[0].ignored = split[1].ignored = split[2].ignored = e->ignored;
 	split[0].unblamable = e->unblamable;
 	split[1].unblamable = e->unblamable;
 	split[2].unblamable = e->unblamable;
@@ -891,6 +893,7 @@ static struct blame_entry *split_blame_at(struct blame_entry *e, int len,
 	struct blame_entry *n = xcalloc(1, sizeof(struct blame_entry));
 
 	n->suspect = new_suspect;
+	n->ignored = e->ignored;
 	n->unblamable = e->unblamable;
 	n->lno = e->lno + len;
 	n->s_lno = e->s_lno + len;
@@ -954,6 +957,7 @@ static void ignore_blame_entry(struct blame_entry *e,
 	struct blame_line_tracker *line_blames;
 	int entry_len, nr_lines;
 
+	e->ignored = 1;
 	line_blames = xcalloc(sizeof(struct blame_line_tracker),
 			      e->num_lines);
 	guess_line_blames(e, parent, target, offset, delta, line_blames);
diff --git a/blame.h b/blame.h
index 93780b01504c..f7755920c90d 100644
--- a/blame.h
+++ b/blame.h
@@ -94,6 +94,7 @@ struct blame_entry {
 	 * scanning the lines over and over.
 	 */
 	unsigned score;
+	int ignored;
 	int unblamable;
 };
 
diff --git a/builtin/blame.c b/builtin/blame.c
index 5f38e9dccddd..46d96905de75 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -53,6 +53,7 @@ static int show_progress;
 static char repeated_meta_color[COLOR_MAXLEN];
 static int coloring_mode;
 static struct string_list ignore_revs_file_list = STRING_LIST_INIT_NODUP;
+static int mark_ignored_lines;
 
 static struct date_mode blame_date_mode = { DATE_ISO8601 };
 static size_t blame_date_width;
@@ -482,6 +483,10 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 			}
 		}
 
+		if (mark_ignored_lines && ent->ignored) {
+			length--;
+			putchar('*');
+		}
 		if (ent->unblamable)
 			memset(hex, '0', length);
 		printf("%.*s", length, hex);
@@ -710,6 +715,10 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 		string_list_insert(&ignore_revs_file_list, str);
 		return 0;
 	}
+	if (!strcmp(var, "blame.markignoredlines")) {
+		mark_ignored_lines = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "color.blame.repeatedlines")) {
 		if (color_parse_mem(value, strlen(value), repeated_meta_color))
 			warning(_("invalid color '%s' in color.blame.repeatedLines"),
diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
index df4993f98682..c4cd9a6c54be 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -123,6 +123,39 @@ test_expect_success bad_files_and_revs '
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

