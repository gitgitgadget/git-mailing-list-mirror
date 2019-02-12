Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75C5A1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 22:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731007AbfBLW1j (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 17:27:39 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:49202 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730932AbfBLW1i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 17:27:38 -0500
Received: by mail-qk1-f201.google.com with SMTP id s65so308870qke.16
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 14:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uoU5D34kNTz+Uv+JFrtGEh1wh0zzK6BluWK96zzDW2o=;
        b=GtIAxBmJrpP1qkVAmfFoahn32JDu32Ogl2OHrakPgoT+EyAk+6axiMxOMjwc6zsqTw
         ILwgB76zhiuJm+IpOLVqU08/ruP0n6IIDZnpP+89VSnVCjVlDyBePggcjvvz+y7Af9rT
         1FiLgZDZ6RdDqxIh+84KPz38DtkNp8Qj4dkNyECk/WjK1Oj4f47pr1L9U06ZUYyyLeBZ
         HOGg/2wauD1rzym+FBPNMP6KN82fv9cNe936CNP3hBdkW5CbSKVa1CiIn44P1DRR7oe3
         ST2TglD0u38bWFP5vWvvAtwDnr/gIrgF9XGZcqCyDxGO777kkoU7Zy0ZaPmiUGlIoNNR
         GaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uoU5D34kNTz+Uv+JFrtGEh1wh0zzK6BluWK96zzDW2o=;
        b=QD4toKltaFoAh6w1QoWbUpPpf01Sep3usT31gFBKV+1DI6fiZ4P1Hcy1QnsdDSn5nq
         pylCysR0PsoEzwGUE0Yn153ZhBNrmoa/B66h9FX4DAKidffQk8LbUbVb32QjQeutvL9N
         zapj2tdVgOmnzCsyOFWvnRP7zoDBM81UNzuNWmW8df2cybftQfnn/1Yqu4LabTM4jtTz
         3AmP7Leb5jPGUGFtctfzS4am6J6Pps3B9H/FPUsAnYZHnbcPeeBL9dsEzcgFdsDfRTQT
         tO3c+XI+GZrNUzKfVcdYLpM7Lk5JE4yY+AdjA18Z9XfQ59OWNbYFXGKK5oaGgRrlM4Wx
         S0hQ==
X-Gm-Message-State: AHQUAub+dkud2qaykzh1SUPhgMi1TFumn8KfACi7owsXnuPx9czRxonG
        cNWOwk43oihGZPaac0ZMrv7UmW2tZwuoN7cIT/Ed5Xje3aApVIbfehpGpdOsuF8TuozqWZmh5U6
        CVzIBQy2Fr8Wvpn0lv8a4uyspilpd1K5h0sHhH7hnMP/neuITNYyH
X-Google-Smtp-Source: AHgI3IYYuS3axIzyFYYbdl82Xfz93p3k6FF725nTsImDQHtg/xWzwKbCqPrE/vMIbaXVAh8ztyQz43Up
X-Received: by 2002:a0c:add8:: with SMTP id x24mr3390221qvc.16.1550010456672;
 Tue, 12 Feb 2019 14:27:36 -0800 (PST)
Date:   Tue, 12 Feb 2019 17:27:21 -0500
In-Reply-To: <20190212222722.240676-1-brho@google.com>
Message-Id: <20190212222722.240676-5-brho@google.com>
Mime-Version: 1.0
References: <20190212222722.240676-1-brho@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH v3 4/5] blame: add a config option to mark ignored lines
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
 Documentation/config/blame.txt | 4 ++++
 blame.c                        | 4 ++++
 blame.h                        | 1 +
 builtin/blame.c                | 9 +++++++++
 4 files changed, 18 insertions(+)

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
-- 
2.21.0.rc0.258.g878e2cd30e-goog

