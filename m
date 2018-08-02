Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C076D1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 11:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732330AbeHBNix (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 09:38:53 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:46089 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbeHBNix (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 09:38:53 -0400
Received: by mail-io0-f202.google.com with SMTP id c5-v6so1365722ioi.13
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 04:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dFSBkC9HJP6PC5wekDeE2+19rOw64GPa/1q6Je87Fq0=;
        b=sd1EaRaj5CfkYYXLDbR6VqSLXhdK8x+8TWAuDoYi5Td6MIkQQHK+U9VMbg9Pdzqde7
         ExV09atXE24KANaxmnBE22RQOAXI/rEUQYWr3OeHFu9rFvYGAL5k3fstDncB2OuzWhTr
         QELP3J6E0fkHycjSuNVFpSVnm6hFPDqdNIcqev2FARbZaq32EzBYB4WGJ7r3Qf8f2M3T
         nj2p1lQiD5307oWldlFK5/B7vKgLXo0ItP3c3waUJQumC2Vx9hxgqHOau+/5J3tZvqyi
         034yd47ty1W+dmKBkfwY9ngQR6RfT+ajDktkeqfP/BJwgAVIKacKSuuYb1l5e1PkyNig
         7huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dFSBkC9HJP6PC5wekDeE2+19rOw64GPa/1q6Je87Fq0=;
        b=h5ARINrFy97WP6X/4a9qz8eXSYyTE6hLDdCXXuFeDqkr4FxFXot5K1oZ5zwdzQ2L3/
         3Dq47KLxrQQ8L15VDO0cu1hEAamOa8/c7wzZnT237xc3gICrYjfeSbMEXoox9AKc/zDK
         EY4+eedFAguLG4Om9iTZGzhseKTu7PVWv6zDNGeCtGckOGPQYutd2PQBUcQYiyo8T5CO
         tIpt/In68BJEf3NQZWq9RjtcTf1fA3h2ZZUEx/xaCx6sRzLeQLCt+Wdc+knIbKjeCZ5w
         sP6XFo5bu8mv5A/Byjh+5Y65JXtrF9Z9nRl1AmkLNZHVFzCEao1LlNsi4NVVk/BlQi0X
         6Gbg==
X-Gm-Message-State: AOUpUlGDJLBu7pzZV/i9wy1VGtup6OoFIYP2q6iHM0W10Hd1BuufFXpV
        BcS6VDmL/aTowFWKUEYA0Nur+yfD6YA=
X-Google-Smtp-Source: AAOMgpdyw4erRD+S59Ta7DssYzi5M4yB0ethZH32xRBTJQDa3L3A1jbkXoVNnI2QyXk0AAfbQIXyKIzeud8=
X-Received: by 2002:a6b:3708:: with SMTP id e8-v6mr961744ioa.92.1533210484151;
 Thu, 02 Aug 2018 04:48:04 -0700 (PDT)
Date:   Thu,  2 Aug 2018 13:47:53 +0200
In-Reply-To: <20180802114753.9715-1-hanwen@google.com>
Message-Id: <20180802114753.9715-3-hanwen@google.com>
Mime-Version: 1.0
References: <20180802114753.9715-1-hanwen@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 2/2] sideband: highlight keywords in remote sideband output
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The colorization is controlled with the config setting "color.remote".

Supported keywords are "error", "warning", "hint" and "success". They
are highlighted if they appear at the start of the line, which is
common in error messages, eg.

   ERROR: commit is missing Change-Id

The rationale for this change is that Gerrit does server-side
processing to create or update code reviews, and actionable error
messages (eg. missing Change-Id) must be communicated back to the user
during the push. User research has shown that new users have trouble
seeing these messages.

The Git push process itself prints lots of non-actionable messages
(eg. bandwidth statistics, object counters for different phases of the
process), and my hypothesis is that these obscure the actionable error
messages that our server sends back. Highlighting keywords in the
draws more attention to actionable messages.

The highlighting is done on the client rather than server side, so
servers don't have to grow capabilities to understand terminal escape
codes and terminal state. It also consistent with the current state
where Git is control of the local display (eg. prefixing messages with
"remote: ").

Finally, this solution is backwards compatible: many servers already
prefix their messages with "error", and they will benefit from this
change without requiring a server update. By contrast, a server-side
solution would likely require plumbing the TERM variable through the
git protocol, so it would require changes to both server and client.

Helped-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Documentation/config.txt            |   9 +++
 help.c                              |   1 +
 help.h                              |   1 +
 sideband.c                          | 119 +++++++++++++++++++++++++---
 t/t5409-colorize-remote-messages.sh |  47 +++++++++++
 5 files changed, 168 insertions(+), 9 deletions(-)
 create mode 100644 t/t5409-colorize-remote-messages.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 43b2de7b5..0783323be 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1229,6 +1229,15 @@ color.push::
 color.push.error::
 	Use customized color for push errors.
 
+color.remote::
+	A boolean to enable/disable colored remote output. If unset,
+	then the value of `color.ui` is used (`auto` by default).
+
+color.remote.<slot>::
+	Use customized color for each remote keywords. `<slot>` may be
+	`hint`, `warning`, `success` or `error` which match the
+	corresponding keyword.
+
 color.showBranch::
 	A boolean to enable/disable color in the output of
 	linkgit:git-show-branch[1]. May be set to `always`,
diff --git a/help.c b/help.c
index 3ebf0568d..b6cafcfc0 100644
--- a/help.c
+++ b/help.c
@@ -425,6 +425,7 @@ void list_config_help(int for_human)
 		{ "color.diff", "<slot>", list_config_color_diff_slots },
 		{ "color.grep", "<slot>", list_config_color_grep_slots },
 		{ "color.interactive", "<slot>", list_config_color_interactive_slots },
+		{ "color.remote", "<slot>", list_config_color_sideband_slots },
 		{ "color.status", "<slot>", list_config_color_status_slots },
 		{ "fsck", "<msg-id>", list_config_fsck_msg_ids },
 		{ "receive.fsck", "<msg-id>", list_config_fsck_msg_ids },
diff --git a/help.h b/help.h
index f8b15323a..9eab6a3f8 100644
--- a/help.h
+++ b/help.h
@@ -83,6 +83,7 @@ void list_config_color_diff_slots(struct string_list *list, const char *prefix);
 void list_config_color_grep_slots(struct string_list *list, const char *prefix);
 void list_config_color_interactive_slots(struct string_list *list, const char *prefix);
 void list_config_color_status_slots(struct string_list *list, const char *prefix);
+void list_config_color_sideband_slots(struct string_list *list, const char *prefix);
 void list_config_fsck_msg_ids(struct string_list *list, const char *prefix);
 
 #endif /* HELP_H */
diff --git a/sideband.c b/sideband.c
index 325bf0e97..5c72db83c 100644
--- a/sideband.c
+++ b/sideband.c
@@ -1,6 +1,103 @@
 #include "cache.h"
+#include "color.h"
+#include "config.h"
 #include "pkt-line.h"
 #include "sideband.h"
+#include "help.h"
+
+struct kwtable {
+	/*
+	 * We use keyword as config key so it can't contain funny chars like
+	 * spaces. When we do that, we need a separate field for slot name in
+	 * load_sideband_colors().
+	 */
+	const char *keyword;
+	char color[COLOR_MAXLEN];
+};
+
+static struct kwtable keywords[] = {
+	{ "hint",	GIT_COLOR_YELLOW },
+	{ "warning",	GIT_COLOR_BOLD_YELLOW },
+	{ "success",	GIT_COLOR_BOLD_GREEN },
+	{ "error",	GIT_COLOR_BOLD_RED },
+};
+
+// Returns a color setting (GIT_COLOR_NEVER, etc).
+static int use_sideband_colors(void)
+{
+	static int use_sideband_colors_cached = -1;
+
+	const char *key = "color.remote";
+	struct strbuf sb = STRBUF_INIT;
+	char *value;
+	int i;
+
+	if (use_sideband_colors_cached >= 0)
+		return use_sideband_colors_cached;
+
+	if (!git_config_get_string(key, &value))
+		use_sideband_colors_cached = git_config_colorbool(key, value);
+
+	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "%s.%s", key, keywords[i].keyword);
+		if (git_config_get_string(sb.buf, &value))
+			continue;
+		if (color_parse(value, keywords[i].color))
+			die(_("expecting a color: %s"), value);
+	}
+	strbuf_release(&sb);
+	return use_sideband_colors_cached;
+}
+
+void list_config_color_sideband_slots(struct string_list *list, const char *prefix)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(keywords); i++)
+		list_config_item(list, prefix, keywords[i].keyword);
+}
+
+/*
+ * Optionally highlight some keywords in remote output if they appear at the
+ * start of the line. This should be called for a single line only.
+ */
+void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
+{
+	int i;
+ 	if (!want_color_stderr(use_sideband_colors())) {
+		strbuf_add(dest, src, n);
+		return;
+	}
+
+	while (isspace(*src)) {
+		strbuf_addch(dest, *src);
+		src++;
+		n--;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
+		struct kwtable* p = keywords + i;
+		int len = strlen(p->keyword);
+                /*
+                 * Match case insensitively, so we colorize output from existing
+                 * servers regardless of the case that they use for their
+                 * messages. We only highlight the word precisely, so
+                 * "successful" stays uncolored.
+                 */
+		if (!strncasecmp(p->keyword, src, len) && !isalnum(src[len])) {
+			strbuf_addstr(dest, p->color);
+			strbuf_add(dest, src, len);
+			strbuf_addstr(dest, GIT_COLOR_RESET);
+			n -= len;
+			src += len;
+			break;
+		}
+	}
+
+	strbuf_add(dest, src, n);
+}
+
 
 /*
  * Receive multiplexed output stream over git native protocol.
@@ -48,8 +145,10 @@ int recv_sideband(const char *me, int in_stream, int out)
 		len--;
 		switch (band) {
 		case 3:
-			strbuf_addf(&outbuf, "%s%s%s", outbuf.len ? "\n" : "",
-				    DISPLAY_PREFIX, buf + 1);
+			strbuf_addf(&outbuf, "%s%s", outbuf.len ? "\n" : "",
+				    DISPLAY_PREFIX);
+			maybe_colorize_sideband(&outbuf, buf + 1, len);
+
 			retval = SIDEBAND_REMOTE_ERROR;
 			break;
 		case 2:
@@ -69,20 +168,22 @@ int recv_sideband(const char *me, int in_stream, int out)
 				if (!outbuf.len)
 					strbuf_addstr(&outbuf, DISPLAY_PREFIX);
 				if (linelen > 0) {
-					strbuf_addf(&outbuf, "%.*s%s%c",
-						    linelen, b, suffix, *brk);
-				} else {
-					strbuf_addch(&outbuf, *brk);
+					maybe_colorize_sideband(&outbuf, b, linelen);
+					strbuf_addstr(&outbuf, suffix);
 				}
+
+				strbuf_addch(&outbuf, *brk);
 				xwrite(2, outbuf.buf, outbuf.len);
 				strbuf_reset(&outbuf);
 
 				b = brk + 1;
 			}
 
-			if (*b)
-				strbuf_addf(&outbuf, "%s%s", outbuf.len ?
-					    "" : DISPLAY_PREFIX, b);
+			if (*b) {
+				strbuf_addstr(&outbuf, outbuf.len ?
+					    "" : DISPLAY_PREFIX);
+				maybe_colorize_sideband(&outbuf, b, strlen(b));
+			}
 			break;
 		case 1:
 			write_or_die(out, buf + 1, len);
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
new file mode 100644
index 000000000..4e1bd421f
--- /dev/null
+++ b/t/t5409-colorize-remote-messages.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+
+test_description='remote messages are colorized on the client'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir .git/hooks &&
+	cat << EOF > .git/hooks/update &&
+#!/bin/sh
+echo error: error
+echo hint: hint
+echo success: success
+echo warning: warning
+echo prefixerror: error
+exit 0
+EOF
+	chmod +x .git/hooks/update &&
+	echo 1 >file &&
+	git add file &&
+	git commit -m 1 &&
+	git clone . child &&
+	cd child &&
+	echo 2 > file &&
+	git commit -a -m 2
+'
+
+test_expect_success 'push' '
+	git -c color.remote=always push -f origin HEAD:refs/heads/newbranch 2>output &&
+	test_decode_color <output >decoded &&
+	grep "<BOLD;RED>error<RESET>:" decoded &&
+	grep "<YELLOW>hint<RESET>:" decoded &&
+	grep "<BOLD;GREEN>success<RESET>:" decoded &&
+	grep "<BOLD;YELLOW>warning<RESET>:" decoded &&
+	grep "prefixerror: error" decoded
+'
+
+test_expect_success 'push with customized color' '
+	git -c color.remote=always -c color.remote.error=white push -f origin HEAD:refs/heads/newbranch2 2>output &&
+	test_decode_color <output >decoded &&
+	grep "<WHITE>error<RESET>:" decoded &&
+	grep "<YELLOW>hint<RESET>:" decoded &&
+	grep "<BOLD;GREEN>success<RESET>:" decoded &&
+	grep "<BOLD;YELLOW>warning<RESET>:" decoded
+'
+
+test_done
-- 
2.18.0.597.ga71716f1ad-goog

