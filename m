Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52B1320248
	for <e@80x24.org>; Wed, 17 Apr 2019 10:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbfDQKZG (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 06:25:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46405 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731542AbfDQKZG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 06:25:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so31159534wrw.13
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 03:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=dUiAuHh5+V5sVeMpE7JpQiksXS7fBvsIW9gmTC91rRg=;
        b=G/vamAMcIWGtDojyPs28uzcbQaA1LcsDVDTZOKIrMnLdCNKNirsSm4/OtoVitkdglF
         xE3mU+S/yEntS9RHyqJpMr4poG++myPGGIb0BKpJAQ3rpgAae5P7z3Wby4v6Q4b/JyNY
         qm7FtoYOkK3gxa12o6vjVzn999l14q6lynUUc84BQhzFy2COHbsOZjH1wWGivjjRB8r0
         k1mSP6Rwzvo8p9giRqmR/HtntpbbCLJ37pHumKaQn2K6hhbNhcWmxuvFK57FEgi+LxMl
         vOxMevWfq/HPinz7Z688JqwHrCQhI7jqGE6e5tRJIgcrT44Na4y5Woh92vnIk1ul+cPH
         NFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=dUiAuHh5+V5sVeMpE7JpQiksXS7fBvsIW9gmTC91rRg=;
        b=oF5JOQj/pptnLgTVyrFiBXXn3OWPHbFe8LW6jWxOPX3rFTRdqJzLMraff/wsWGZjTa
         2n7wAMIAu1IU/a9t6WVtezAmydwFu0qdBByBXLSw4u9CncB+oBM3aQIOS8+MeHO6kYdo
         i0tiQf25/6l/1gLh0+Fw8f7EOa+DTj0YZmgC+kgI+CegW90QnSYYdummWiPPMfkiL5gJ
         y55+zJ6LaOdjM4RTgRSwkA3CqXUELWNGqranqex8qPkWj20evd04D/0bBIJbUixI/vOA
         wZUnNOdIlpxYSVpLGvka+ySw9vrwpjBwpcPN/TRuqhcrf453d1Man0fv18k5eyIoK+Yl
         BjQQ==
X-Gm-Message-State: APjAAAU+9YN/hjKIGsnS7xaT5BNrkjxlHR7AAzdtwsKMjlb+WKSRb/Mh
        6MX3rAKpph2plwTd0fuN6kfV4ytzY40=
X-Google-Smtp-Source: APXvYqz1kNQaCgllUZTV/3751JeRTuRjHFdXSH7tuYXfF5GeoXdToV1aHd7A92vM4uIt2wl4fHBAZQ==
X-Received: by 2002:a5d:4d42:: with SMTP id a2mr57037615wru.130.1555496704091;
        Wed, 17 Apr 2019 03:25:04 -0700 (PDT)
Received: from lindisfarne.localdomain (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id a11sm53399903wrx.5.2019.04.17.03.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 03:24:58 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v10 05/10] commit: extract cleanup_mode functions to sequencer
Date:   Wed, 17 Apr 2019 11:23:25 +0100
Message-Id: <20190417102330.24434-6-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417102330.24434-1-phillip.wood123@gmail.com>
References: <cover.1553150827.git.liu.denton@gmail.com>
 <20190417102330.24434-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Denton Liu <liu.denton@gmail.com>

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/commit.c | 25 ++-----------------------
 sequencer.c      | 29 +++++++++++++++++++++++++++++
 sequencer.h      |  6 ++++++
 3 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index f17537474a..0df15e4851 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1172,24 +1172,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
 	if (argc == 0 && (also || (only && !amend && !allow_empty)))
 		die(_("No paths with --include/--only does not make sense."));
-	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
-		cleanup_mode = use_editor ? COMMIT_MSG_CLEANUP_ALL :
-					    COMMIT_MSG_CLEANUP_SPACE;
-	else if (!strcmp(cleanup_arg, "verbatim"))
-		cleanup_mode = COMMIT_MSG_CLEANUP_NONE;
-	else if (!strcmp(cleanup_arg, "whitespace"))
-		cleanup_mode = COMMIT_MSG_CLEANUP_SPACE;
-	else if (!strcmp(cleanup_arg, "strip"))
-		cleanup_mode = COMMIT_MSG_CLEANUP_ALL;
-	else if (!strcmp(cleanup_arg, "scissors"))
-		cleanup_mode = use_editor ? COMMIT_MSG_CLEANUP_SCISSORS :
-					    COMMIT_MSG_CLEANUP_SPACE;
-	/*
-	 * Please update _git_commit() in git-completion.bash when you
-	 * add new options.
-	 */
-	else
-		die(_("Invalid cleanup mode %s"), cleanup_arg);
+	cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor);
 
 	handle_untracked_files_arg(s);
 
@@ -1626,11 +1609,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		die(_("could not read commit message: %s"), strerror(saved_errno));
 	}
 
-	if (verbose || /* Truncate the message just before the diff, if any. */
-	    cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
-		strbuf_setlen(&sb, wt_status_locate_end(sb.buf, sb.len));
-	if (cleanup_mode != COMMIT_MSG_CLEANUP_NONE)
-		strbuf_stripspace(&sb, cleanup_mode == COMMIT_MSG_CLEANUP_ALL);
+	cleanup_message(&sb, cleanup_mode, verbose);
 
 	if (message_is_empty(&sb, cleanup_mode) && !allow_empty_message) {
 		rollback_index_files();
diff --git a/sequencer.c b/sequencer.c
index 87079ece5d..b049951c34 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -516,6 +516,25 @@ static int fast_forward_to(struct repository *r,
 	return 0;
 }
 
+enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
+	int use_editor)
+{
+	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
+		return use_editor ? COMMIT_MSG_CLEANUP_ALL :
+				    COMMIT_MSG_CLEANUP_SPACE;
+	else if (!strcmp(cleanup_arg, "verbatim"))
+		return COMMIT_MSG_CLEANUP_NONE;
+	else if (!strcmp(cleanup_arg, "whitespace"))
+		return COMMIT_MSG_CLEANUP_SPACE;
+	else if (!strcmp(cleanup_arg, "strip"))
+		return COMMIT_MSG_CLEANUP_ALL;
+	else if (!strcmp(cleanup_arg, "scissors"))
+		return use_editor ? COMMIT_MSG_CLEANUP_SCISSORS :
+				    COMMIT_MSG_CLEANUP_SPACE;
+	else
+		die(_("Invalid cleanup mode %s"), cleanup_arg);
+}
+
 void append_conflicts_hint(struct index_state *istate,
 			   struct strbuf *msgbuf)
 {
@@ -1018,6 +1037,16 @@ static int rest_is_empty(const struct strbuf *sb, int start)
 	return 1;
 }
 
+void cleanup_message(struct strbuf *msgbuf,
+	enum commit_msg_cleanup_mode cleanup_mode, int verbose)
+{
+	if (verbose || /* Truncate the message just before the diff, if any. */
+	    cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
+		strbuf_setlen(msgbuf, wt_status_locate_end(msgbuf->buf, msgbuf->len));
+	if (cleanup_mode != COMMIT_MSG_CLEANUP_NONE)
+		strbuf_stripspace(msgbuf, cleanup_mode == COMMIT_MSG_CLEANUP_ALL);
+}
+
 /*
  * Find out if the message in the strbuf contains only whitespace and
  * Signed-off-by lines.
diff --git a/sequencer.h b/sequencer.h
index 82bc7a48d5..8295c8406f 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -117,6 +117,12 @@ int rearrange_squash(struct repository *r);
 void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);
 
 void append_conflicts_hint(struct index_state *istate, struct strbuf *msgbuf);
+enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
+	int use_editor);
+
+void cleanup_message(struct strbuf *msgbuf,
+	enum commit_msg_cleanup_mode cleanup_mode, int verbose);
+
 int message_is_empty(const struct strbuf *sb,
 		     enum commit_msg_cleanup_mode cleanup_mode);
 int template_untouched(const struct strbuf *sb, const char *template_file,
-- 
2.21.0

