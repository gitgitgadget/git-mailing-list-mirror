Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82C1320188
	for <e@80x24.org>; Sun, 14 May 2017 03:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751371AbdENDjf (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 23:39:35 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34960 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbdENDje (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 23:39:34 -0400
Received: by mail-pf0-f195.google.com with SMTP id u26so11515751pfd.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 20:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DLh4gP9oK/WTgcFckOYIF7LAMVysX+E5OYvwB9MBxqc=;
        b=ePzdwFdkgSCSKWmLcuNcHn6tKwku5gpHCyH9CIuchY3jQUfrQ0sW8gzVJUJerclwBz
         QNFXM+TGPmtgf3fD3bDJ0PgXJX39BmSLwLuUjTf+67B648gojxKydHHf5noNhshIjhG2
         XdUJu+P+DHmhkgJrBdsX3ggILg96YMcB5/xXBtZJeNneV4L7dVsTB88nz9wbwPXzOhAY
         p7QgBlVafVSQFhUFkKBCKKzSSS+Q83PVllf4XiCkckHMRrT5Gw3fvZP5fu/lUDLJHCBE
         kNUVUlrmkqmzQrhwJB4gRsWIGi7IerDFhnW/FtaiwiDUtGfT+kCR79g3k7YIPT48O3m2
         JddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DLh4gP9oK/WTgcFckOYIF7LAMVysX+E5OYvwB9MBxqc=;
        b=YlCUEwCMde1Ku6dWUj1beDIPeRX0j+SS3nU3UoWH4Mq6XhiAoKWMDSa00E/waMdwqv
         B92dkWVDctsdxdUXRNiTJDoA7TU3iC8Eg0/yNTOTPbu2MPq040sMYDoUhTraS48MCd2+
         MQI+8lS38UeujOfTXdqbeqxWGu8LRC2h1oMLm0B0SMUB/72HxZ/myQ4lqxMWsVePEDNm
         WpXqUpHf8MJvFpkEcXKHh92qZPJdbAIsiR7w47vJeX/Mi3cKLyv0rqwvYWwJNScrOIbI
         SIXMTXEYE3b6IWl14hFomDPUPvcUCOn/RG2vZH5cG/iczkYPvYwAWeYXqYsTIHqVxIwb
         94Gg==
X-Gm-Message-State: AODbwcBye2K6q3gT9GBGof9VgiQAEtD/kS5WFIfqvOWlAYMfI8WELDHe
        xYiMnpSlkDnrNA==
X-Received: by 10.99.232.69 with SMTP id a5mr11930828pgk.167.1494733173866;
        Sat, 13 May 2017 20:39:33 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:3:1ec0:f93c:462:46cc:5c0])
        by smtp.gmail.com with ESMTPSA id z68sm12324626pgz.14.2017.05.13.20.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 May 2017 20:39:32 -0700 (PDT)
From:   Brian Malehorn <bmalehorn@gmail.com>
To:     peff@peff.net
Cc:     bmalehorn@gmail.com, git@vger.kernel.org
Subject: [PATCH] interpret-trailers: obey scissors lines
Date:   Sat, 13 May 2017 20:39:23 -0700
Message-Id: <20170514033923.12870-2-bmalehorn@gmail.com>
X-Mailer: git-send-email 2.12.3.9.g050893b
In-Reply-To: <20170514033923.12870-1-bmalehorn@gmail.com>
References: <20170512090032.coddhlsrs6s3zm2f@sigill.intra.peff.net>
 <20170514033923.12870-1-bmalehorn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a commit message is being editted as "verbose", it will contain a
scissors string ("-- >8 --") and a diff:

    my subject

    # ------------------------ >8 ------------------------
    # Do not touch the line above.
    # Everything below will be removed.
    diff --git a/foo.txt b/foo.txt
    index 5716ca5..7601807 100644
    --- a/foo.txt
    +++ b/foo.txt
    @@ -1 +1 @@
    -bar
    +baz

interpret-trailers doesn't interpret the scissors and therefore places
trailer information after the diff. A simple reproduction is:

    git config commit.verbose true
    GIT_EDITOR='git interpret-trailers --in-place --trailer Acked-by:me' \
        git commit --amend

This commit resolves the issue by teaching "git interpret-trailers" to
obey scissors the same way "git commit" does.
---
 builtin/commit.c              |  3 ++-
 commit.c                      |  6 ++++--
 t/t7513-interpret-trailers.sh | 17 +++++++++++++++++
 wt-status.c                   | 11 ++++++-----
 wt-status.h                   |  2 +-
 5 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 2de5f6cc6..2ce9c339d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1735,7 +1735,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	if (verbose || /* Truncate the message just before the diff, if any. */
 	    cleanup_mode == CLEANUP_SCISSORS)
-		wt_status_truncate_message_at_cut_line(&sb);
+		strbuf_setlen(&sb,
+			      wt_status_last_nonscissors_index(sb.buf, sb.len));
 
 	if (cleanup_mode != CLEANUP_NONE)
 		strbuf_stripspace(&sb, cleanup_mode == CLEANUP_ALL);
diff --git a/commit.c b/commit.c
index fab826973..5d791b703 100644
--- a/commit.c
+++ b/commit.c
@@ -11,6 +11,7 @@
 #include "commit-slab.h"
 #include "prio-queue.h"
 #include "sha1-lookup.h"
+#include "wt-status.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -1662,8 +1663,9 @@ int ignore_non_trailer(const char *buf, size_t len)
 	int boc = 0;
 	int bol = 0;
 	int in_old_conflicts_block = 0;
+	size_t cutoff = wt_status_last_nonscissors_index(buf, len);
 
-	while (bol < len) {
+	while (bol < cutoff) {
 		const char *next_line = memchr(buf + bol, '\n', len - bol);
 
 		if (!next_line)
@@ -1689,5 +1691,5 @@ int ignore_non_trailer(const char *buf, size_t len)
 		}
 		bol = next_line - buf;
 	}
-	return boc ? len - boc : 0;
+	return boc ? len - boc : len - cutoff;
 }
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 4dd1d7c52..d88d4a4ff 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -1258,4 +1258,21 @@ test_expect_success 'with no command and no key' '
 	test_cmp expected actual
 '
 
+test_expect_success 'with scissors' '
+	cat >expected <<-EOF &&
+		my subject
+
+		review: Brian
+		sign: A U Thor <author@example.com>
+		# ------------------------ >8 ------------------------
+		ignore this
+	EOF
+	git interpret-trailers --trailer review:Brian >actual <<-EOF &&
+		my subject
+		# ------------------------ >8 ------------------------
+		ignore this
+	EOF
+	test_cmp expected actual
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index 4bb46781c..8b807d11f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -883,17 +883,18 @@ static void wt_longstatus_print_other(struct wt_status *s,
 	status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
 }
 
-void wt_status_truncate_message_at_cut_line(struct strbuf *buf)
+size_t wt_status_last_nonscissors_index(const char *s, size_t len)
 {
 	const char *p;
 	struct strbuf pattern = STRBUF_INIT;
 
 	strbuf_addf(&pattern, "\n%c %s", comment_line_char, cut_line);
-	if (starts_with(buf->buf, pattern.buf + 1))
-		strbuf_setlen(buf, 0);
-	else if ((p = strstr(buf->buf, pattern.buf)))
-		strbuf_setlen(buf, p - buf->buf + 1);
+	if (starts_with(s, pattern.buf + 1))
+		len = 0;
+	else if ((p = strstr(s, pattern.buf)))
+		len = p - s + 1;
 	strbuf_release(&pattern);
+	return len;
 }
 
 void wt_status_add_cut_line(FILE *fp)
diff --git a/wt-status.h b/wt-status.h
index 54fec7703..36a21b492 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -112,7 +112,7 @@ struct wt_status_state {
 	unsigned char cherry_pick_head_sha1[20];
 };
 
-void wt_status_truncate_message_at_cut_line(struct strbuf *);
+size_t wt_status_last_nonscissors_index(const char *s, size_t len);
 void wt_status_add_cut_line(FILE *fp);
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
-- 
2.12.3.9.g050893b

