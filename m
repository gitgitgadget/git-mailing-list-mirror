Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA9DD201A7
	for <e@80x24.org>; Tue, 16 May 2017 06:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751316AbdEPGHB (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 02:07:01 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34019 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbdEPGG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 02:06:59 -0400
Received: by mail-pf0-f196.google.com with SMTP id w69so18709577pfk.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 23:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RPuiwak1NJXbp0rFShJp2RgDiewYkfP471m35He7Z90=;
        b=c/LsiA6MTDcFpteXlMRfZznIltI1fNpDWdMGyiv207V291YAx/oWu3MTquu8lV9Br4
         3mi3Pk9HAdLAWV/+ZzJpqG9QjMN8xT2ujETyN5kSlkTooaAmo7vTYRwkJg1krAf+JFFh
         4dQh0Mi2f++bhQdLcqRllAoaJPqlqQR21FcUIONouxTSBNVEQC8IcHR39dLmNMTAduB+
         FvkQRc2eYom8s4PvIPZTywvTR8/xX/KACughNzaP1DmvIuF6zKx892+w9u/ItIE6plxp
         HtX/CuYpCOxfLdAeBIo86mGVToXBEUQ5zwDDLaALcTL9VVFGV43P0W9rx90oZd7lKwRG
         G3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RPuiwak1NJXbp0rFShJp2RgDiewYkfP471m35He7Z90=;
        b=MX4fsex2YYIunVnsS/ZNrfLcBYbPVmucBp/KaP5BdFoj9FUaJ6xh7OsYOsYQndv/j4
         uDviOe8Pfy8ZyVb+fwUjYSiRE2VNLPaqYFFz/IcKFZyjRuMbwrILoYCsTE8Bs9wcf7MN
         f06n8KX4KXpCtq7gDvNChPIQuFpPjtqC11v8l/q2HoRFF6dOx5wpcoWYhYSvzKJepnXu
         1hyZtg3HgaLw21veb0hy0K4rDM0r7hBzU2KTK5LD85jIlHPKdS7TPIn2WBLPy221M5zh
         tb2ibx/BSieRcFqmxsLlpHF2q7TDcU76SGTKkBEDPLCh8hwZ8sHl9R37H4WmPmdXxoeA
         CcdQ==
X-Gm-Message-State: AODbwcCjpQX3jY+2tzDuAvKQ6PDNlZQxdEuIWLsBuHu+ihc22SoaTEiO
        wVMDF9s2AXHPTg==
X-Received: by 10.84.168.69 with SMTP id e63mr13505238plb.124.1494914819079;
        Mon, 15 May 2017 23:06:59 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:3:1ec0:3967:8bec:86da:f675])
        by smtp.gmail.com with ESMTPSA id z68sm21587736pgz.14.2017.05.15.23.06.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 May 2017 23:06:58 -0700 (PDT)
From:   Brian Malehorn <bmalehorn@gmail.com>
To:     gitster@pobox.com
Cc:     bmalehorn@gmail.com, git@vger.kernel.org, peff@peff.net
Subject: [PATCH] interpret-trailers: honor the cut line
Date:   Mon, 15 May 2017 23:06:49 -0700
Message-Id: <20170516060649.29110-2-bmalehorn@gmail.com>
X-Mailer: git-send-email 2.12.3.9.g050893b
In-Reply-To: <20170516060649.29110-1-bmalehorn@gmail.com>
References: <xmqq7f1iwxxd.fsf@gitster.mtv.corp.google.com>
 <20170516060649.29110-1-bmalehorn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a commit message is edited with the "verbose" option, the buffer will
have a cut line and diff after the log message, like so:

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

"git interpret-trailers" is unaware of the cut line, and assumes the
trailer block would be at the end of the whole thing.  This can easily
be seen with:

     $ GIT_EDITOR='git interpret-trailers --in-place --trailer Acked-by:me' \
       git commit --amend -v

Teach "git interpret-trailers" to notice the cut-line and ignore the
remainder of the input when looking for a place to add new trailer
block.  This makes it consistent with how "git commit -v -s" inserts a
new Signed-off-by: line.

This can be done by the same logic as the existing helper function,
wt_status_truncate_message_at_cut_line(), uses, but it wants the caller
to pass a strbuf to it.  Because the helper function
ignore_non_trailer() used by the command takes a <pointer, length> pair,
not a strbuf, steal the logic from
wt_status_truncate_message_at_cut_line() to create a new
wt_status_locate_end() helper function that takes <pointer, length>
pair, and make ignore_non_trailer() call it to help
"interpret-trailers".  Since there is only one caller of
wt_status_truncate_message_at_cut_line() in cmd_commit(), rewrite it to
call wt_status_locate_end() helper instead and remove the old helper
that no longer has any caller.

Signed-off-by: Brian Malehorn <bmalehorn@gmail.com>
---
 builtin/commit.c              |  2 +-
 commit.c                      | 13 +++++++------
 t/t7513-interpret-trailers.sh | 17 +++++++++++++++++
 wt-status.c                   | 11 ++++++-----
 wt-status.h                   |  2 +-
 5 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 2de5f6cc6..6c606d965 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1735,7 +1735,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	if (verbose || /* Truncate the message just before the diff, if any. */
 	    cleanup_mode == CLEANUP_SCISSORS)
-		wt_status_truncate_message_at_cut_line(&sb);
+		strbuf_setlen(&sb, wt_status_locate_end(sb.buf, sb.len));
 
 	if (cleanup_mode != CLEANUP_NONE)
 		strbuf_stripspace(&sb, cleanup_mode == CLEANUP_ALL);
diff --git a/commit.c b/commit.c
index fab826973..fa353acac 100644
--- a/commit.c
+++ b/commit.c
@@ -11,6 +11,7 @@
 #include "commit-slab.h"
 #include "prio-queue.h"
 #include "sha1-lookup.h"
+#include "wt-status.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -1649,10 +1650,9 @@ const char *find_commit_header(const char *msg, const char *key, size_t *out_len
 /*
  * Inspect the given string and determine the true "end" of the log message, in
  * order to find where to put a new Signed-off-by: line.  Ignored are
- * trailing comment lines and blank lines, and also the traditional
- * "Conflicts:" block that is not commented out, so that we can use
- * "git commit -s --amend" on an existing commit that forgot to remove
- * it.
+ * trailing comment lines and blank lines.  To support "git commit -s
+ * --amend" on an existing commit, we also ignore "Conflicts:".  To
+ * support "git commit -v", we truncate at cut lines.
  *
  * Returns the number of bytes from the tail to ignore, to be fed as
  * the second parameter to append_signoff().
@@ -1662,8 +1662,9 @@ int ignore_non_trailer(const char *buf, size_t len)
 	int boc = 0;
 	int bol = 0;
 	int in_old_conflicts_block = 0;
+	size_t cutoff = wt_status_locate_end(buf, len);
 
-	while (bol < len) {
+	while (bol < cutoff) {
 		const char *next_line = memchr(buf + bol, '\n', len - bol);
 
 		if (!next_line)
@@ -1689,5 +1690,5 @@ int ignore_non_trailer(const char *buf, size_t len)
 		}
 		bol = next_line - buf;
 	}
-	return boc ? len - boc : 0;
+	return boc ? len - boc : len - cutoff;
 }
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 4dd1d7c52..0c6f91c43 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -1258,4 +1258,21 @@ test_expect_success 'with no command and no key' '
 	test_cmp expected actual
 '
 
+test_expect_success 'with cut line' '
+	cat >expected <<-\EOF &&
+		my subject
+
+		review: Brian
+		sign: A U Thor <author@example.com>
+		# ------------------------ >8 ------------------------
+		ignore this
+	EOF
+	git interpret-trailers --trailer review:Brian >actual <<-\EOF &&
+		my subject
+		# ------------------------ >8 ------------------------
+		ignore this
+	EOF
+	test_cmp expected actual
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index 4bb46781c..afff86c18 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -883,17 +883,18 @@ static void wt_longstatus_print_other(struct wt_status *s,
 	status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
 }
 
-void wt_status_truncate_message_at_cut_line(struct strbuf *buf)
+size_t wt_status_locate_end(const char *s, size_t len)
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
index 54fec7703..889a8d682 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -112,7 +112,7 @@ struct wt_status_state {
 	unsigned char cherry_pick_head_sha1[20];
 };
 
-void wt_status_truncate_message_at_cut_line(struct strbuf *);
+size_t wt_status_locate_end(const char *s, size_t len);
 void wt_status_add_cut_line(FILE *fp);
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
-- 
2.12.3.9.g050893b

