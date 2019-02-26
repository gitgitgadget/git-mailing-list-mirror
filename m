Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 469EB20248
	for <e@80x24.org>; Tue, 26 Feb 2019 17:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfBZRHK (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 12:07:10 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:35369 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbfBZRHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 12:07:09 -0500
Received: by mail-yw1-f74.google.com with SMTP id d18so9343747ywb.2
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 09:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=scu3Yn/hcUDiT48ITxJVWp9vHkNTIdf3V+s9ocbLyS8=;
        b=XAghpTjHsSx0b5VjmmFn88gJZD79Vr4r1fQNJ6rmWIFOn7cBQbVWp6entqTGSRvhuZ
         NU2Bm2LuuSU5oAS1E7KoT+4uexm4Wf4674PgWrfGfxTEmQZHfycafbg3dQCzRD6M4ZIE
         rdJWfmnG315G5Ey7PdYKZGNxPYatQ2U63i232ZQFNf5LJK4cD2TriJa9dC5C9E4JDYr+
         AYJ8u6AxWz3c5CJdeFsTX9d94SpOIOsUCdu2bwCDDRGyE2ylunstJ3AFkfB1AwmLte2p
         HXF8SeNrMR+QUddd7M62yME3n9LPkyfEidMjITimS+dI9pUYEd0l0muGalfn/xZc7wrr
         l94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=scu3Yn/hcUDiT48ITxJVWp9vHkNTIdf3V+s9ocbLyS8=;
        b=QEmORjEWL80rEU9Dv3iGg+13h7GyoAEprEsLv7dbpKj04q1I9EAHGxyCf7ZNtz8ec1
         sAKQR8P0tIMn5t7dn6S1Ct2IQQST1GThNlEJJN8XVjdLkPbAnvfEVMJ6lDKTHn2ybvLY
         k6XncK5DUsr4eu7lGh97HO4OSBX83M4R6VQKOkrnx1hEXHBBm57u/YIc291S9YT4PI1F
         vEeLBcFMk2u89toMOkRCAUM1G+KbFQNQUTg3ZCOLiMuHuzzMOTpJIdKZ4RnzG4IqBAC5
         Lz9SRVHKsA1ViT5MMbJHwApt8pkLqVm0KhAxSarWe5hCjRQJPd901m1J78LGPHqaVl1Z
         3giw==
X-Gm-Message-State: AHQUAubXKoLbiX/vmQ3gsiKCOYl+XKJscwrW8HEOegPbx1IYhW6hlmyY
        Q1J0uMfDeZmq1d6EGQw8hc+FTaIobAxaFX6d0MQ2F+1ZZUntbZWHmherJLl08idEbb+DiPdwYMd
        +0qNJ/L5l7J5Ze2lcbkutkNBUQciTKXYQUOReCIFKjKOLY+AYOprK
X-Google-Smtp-Source: AHgI3IaMYFkEO3pMqhJOkFME4gwhbkqldPhhpX12InZONaXibOHMiCHAK4R25n++p5nPleWUawWiSn4p
X-Received: by 2002:a25:34cb:: with SMTP id b194mr4978172yba.98.1551200828085;
 Tue, 26 Feb 2019 09:07:08 -0800 (PST)
Date:   Tue, 26 Feb 2019 12:06:48 -0500
In-Reply-To: <20190226170648.211847-1-brho@google.com>
Message-Id: <20190226170648.211847-5-brho@google.com>
Mime-Version: 1.0
References: <20190226170648.211847-1-brho@google.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [PATCH v4 4/4] blame: add a config option to mark ignored lines
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
index 4427cde95dc5..34debdba1a7f 100644
--- a/blame.c
+++ b/blame.c
@@ -480,6 +480,7 @@ void blame_coalesce(struct blame_scoreboard *sb)
 	for (ent = sb->ent; ent && (next = ent->next); ent = next) {
 		if (ent->suspect == next->suspect &&
 		    ent->s_lno + ent->num_lines == next->s_lno &&
+		    ent->ignored == next->ignored &&
 		    ent->unblamable == next->unblamable) {
 			ent->num_lines += next->num_lines;
 			ent->next = next->next;
@@ -732,6 +733,7 @@ static void split_overlap(struct blame_entry *split,
 	int chunk_end_lno;
 	memset(split, 0, sizeof(struct blame_entry [3]));
 
+	split[0].ignored = split[1].ignored = split[2].ignored = e->ignored;
 	split[0].unblamable = e->unblamable;
 	split[1].unblamable = e->unblamable;
 	split[2].unblamable = e->unblamable;
@@ -854,6 +856,7 @@ static struct blame_entry *split_blame_at(struct blame_entry *e, int len,
 	struct blame_entry *n = xcalloc(1, sizeof(struct blame_entry));
 
 	n->suspect = new_suspect;
+	n->ignored = e->ignored;
 	n->unblamable = e->unblamable;
 	n->lno = e->lno + len;
 	n->s_lno = e->s_lno + len;
@@ -951,6 +954,7 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 			blame_origin_decref(e->suspect);
 			e->suspect = blame_origin_incref(parent);
 			e->s_lno += offset;
+			e->ignored = 1;
 			/* The top part of any ignored diff will not exist in
 			 * the parent, and we will never be able to accurately
 			 * blame it.  We'll keep it on the blame list for the
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
index c5ef1e4b1b00..6bd17febec3a 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -121,6 +121,39 @@ test_expect_success bad_files_and_revs '
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
+	test_write_lines line-one-Z line-two-Z new_line3 new_line4 >file &&
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
2.21.0.rc2.261.ga7da99ff1b-goog

