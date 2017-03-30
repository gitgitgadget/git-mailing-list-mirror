Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7425C20969
	for <e@80x24.org>; Thu, 30 Mar 2017 01:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933350AbdC3Bmt (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 21:42:49 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33624 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933281AbdC3Bmr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 21:42:47 -0400
Received: by mail-pg0-f53.google.com with SMTP id x125so23646109pgb.0
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 18:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C1BuR7ki5JvpRKDyJk36vAG82Qc2wbtPSy49T1DKdKY=;
        b=F+iZAMYmeNfuZMiL4xpZQijGkJKvvET1u5mQvgT2/d3ow7Tt3sqyT5DY4+Ntlb4+uN
         7xb2eSRo5YrWSdgY5EUMqQt78OuD0ez3V4J96w6B5LqYxD/2OPi+jKaJP33kGhKsBg/B
         die0CK+nuFe0VXzALwJVWZV/Fu2kssm733Y8Ipc+L9TGoGCD9POjs4Tu5tT+P/3SDKks
         9e7aPC5/7CYBqAq2XyHV6ke/+GEX2nyBrDyOPwJTtRvhExscOK4jJ9802/gbp27wG0z6
         wO12MJ451a1GasK0eBIzSH/chYPTOeYrdpOlPq3jqS33S8JNfSVBzNfMGEZQrG9wtjEL
         pKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C1BuR7ki5JvpRKDyJk36vAG82Qc2wbtPSy49T1DKdKY=;
        b=PvzX339xslql0Lrz48uh2jt23ZcyDX2Cloo2wO4wfYd5iVUdnAF1rXl+SVpa2ktbXU
         MCB+Byvo7H/qWhg8zBW1UxttgtqlOZvEjTgn3DQHtuG/SPDyWSd5J2qw9lRhfM2CDRL6
         JYmY1Fc8XqQ3GQ/SzdpAfabZP6T5GFqjEXgHWWG8244bBVu1v9IojtzgV1Tyt3laVtHc
         CXhDfFjdN3tUxsLpvEAoYRhup5ATEUGRnz/rdTwgx3nFQhqTafO4/22PLTXo+vnfHnFS
         a5f7L7OkC/JJdN4H1AP0BOKpzk90IEMCJoFdBn7e1IuO4MqiXE5JsxRNVD0GSrIqhml9
         Plkg==
X-Gm-Message-State: AFeK/H0PpEKCzDdLmpi58VrXO5fNuZLfc41M6tkcbf9wp+juGYDY3e4C/Fd5Sp2VqK+F40tD
X-Received: by 10.84.238.9 with SMTP id u9mr3955908plk.174.1490838165821;
        Wed, 29 Mar 2017 18:42:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:cc96:1eab:fd67:9864])
        by smtp.gmail.com with ESMTPSA id i81sm584534pfi.23.2017.03.29.18.42.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 18:42:45 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, peff@peff.net
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] WIP - Allow custom printf function for column printing
Date:   Wed, 29 Mar 2017 18:42:38 -0700
Message-Id: <20170330014238.30032-4-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.511.g2abb8caf66
In-Reply-To: <20170330014238.30032-1-sbeller@google.com>
References: <20170330014238.30032-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever wondered why column.ui applies the untracked files in git-status,
but not for the help text comment in git-commit? Nobody wrote the code!

This is marked as WIP, as it barely demonstrates how the code may look
like. No tests, no documentation.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/commit.c |  1 -
 wt-status.c      | 29 ++++++++++++++++++++++++-----
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 4e288bc513..f482150df8 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1649,7 +1649,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	status_init_config(&s, git_commit_config);
 	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
-	s.colopts = 0;
 
 	if (get_sha1("HEAD", oid.hash))
 		current_head = NULL;
diff --git a/wt-status.c b/wt-status.c
index 308cf3779e..cfba352683 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -43,12 +43,13 @@ static const char *color(int slot, struct wt_status *s)
 	return c;
 }
 
-static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
+static int status_vprintf(struct wt_status *s, int at_bol, const char *color,
 		const char *fmt, va_list ap, const char *trail)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf linebuf = STRBUF_INIT;
 	const char *line, *eol;
+	int ret = 0;
 
 	strbuf_vaddf(&sb, fmt, ap);
 	if (!sb.len) {
@@ -59,9 +60,9 @@ static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
 		}
 		color_print_strbuf(s->fp, color, &sb);
 		if (trail)
-			fprintf(s->fp, "%s", trail);
+			ret += fprintf(s->fp, "%s", trail);
 		strbuf_release(&sb);
-		return;
+		return ret;
 	}
 	for (line = sb.buf; *line; line = eol + 1) {
 		eol = strchr(line, '\n');
@@ -78,15 +79,16 @@ static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
 			strbuf_addstr(&linebuf, line);
 		color_print_strbuf(s->fp, color, &linebuf);
 		if (eol)
-			fprintf(s->fp, "\n");
+			ret += fprintf(s->fp, "\n");
 		else
 			break;
 		at_bol = 1;
 	}
 	if (trail)
-		fprintf(s->fp, "%s", trail);
+		ret += fprintf(s->fp, "%s", trail);
 	strbuf_release(&linebuf);
 	strbuf_release(&sb);
+	return ret;
 }
 
 void status_printf_ln(struct wt_status *s, const char *color,
@@ -834,6 +836,20 @@ static void wt_longstatus_print_submodule_summary(struct wt_status *s, int uncom
 	strbuf_release(&summary);
 }
 
+static struct wt_status *global_wt_status_hack;
+static int column_status_printf(const char *fmt, ...)
+{
+	va_list ap;
+	struct wt_status *s = global_wt_status_hack;
+	int ret;
+
+	va_start(ap, fmt);
+	ret = status_vprintf(s, 0, "", fmt, ap, NULL);
+	va_end(ap);
+
+	return ret;
+}
+
 static void wt_longstatus_print_other(struct wt_status *s,
 				      struct string_list *l,
 				      const char *what,
@@ -856,6 +872,7 @@ static void wt_longstatus_print_other(struct wt_status *s,
 		path = quote_path(it->string, s->prefix, &buf);
 		if (column_active(s->colopts)) {
 			string_list_append(&output, path);
+			global_wt_status_hack = s;
 			continue;
 		}
 		status_printf(s, color(WT_STATUS_HEADER, s), "\t");
@@ -876,6 +893,8 @@ static void wt_longstatus_print_other(struct wt_status *s,
 	copts.indent = buf.buf;
 	if (want_color(s->use_color))
 		copts.nl = GIT_COLOR_RESET "\n";
+
+	copts._printf = column_status_printf;
 	print_columns(&output, s->colopts, &copts);
 	string_list_clear(&output, 0);
 	strbuf_release(&buf);
-- 
2.12.2.511.g2abb8caf66

