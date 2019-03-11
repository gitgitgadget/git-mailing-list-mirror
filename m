Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EA5F20248
	for <e@80x24.org>; Mon, 11 Mar 2019 03:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfCKDmk (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 23:42:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45797 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfCKDmj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 23:42:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id v21so2671097pfm.12
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 20:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s9JDpsN+/VR9ShyIryOD4OP47xRyqsogbFPXFWGCh0I=;
        b=og8bqjDXv0Mh9c+BNEKQtHdUxGH/zonbNEmUBGHjeh18mUfCRolXmhSUA7A2UCQl6z
         qQC74nAu1eQwB71vM4zIQGHM9405B+6Sm56nCm9inyDoEAuOBpaE1cNOBEspD4tCdu81
         BxEVA9CQmEv2aCh2D8HoyZsFq/0rxCwmdHNyYS4wmH6lSv5TRf8wwTJfwW+8OS81274O
         Q+3bis6tDocACVvkq+ftx64zWtOxhcvi6/fai3wrK32rNLccQqIU+yUWPHHNYIxjwkqU
         mOGirbz4JQkFiPOKr6QAaoly9ML/QfZCCBLAbKisznZsEGEZJM2sx++JldhVOIdU2M6q
         ApVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s9JDpsN+/VR9ShyIryOD4OP47xRyqsogbFPXFWGCh0I=;
        b=qkvWPawZS+62Bq/Lp+MKbW6b/HPpgf1MIOhFMes944eHwxCeHyPlPBBV/AmutzLfgI
         nJcBsUVAoSYNpbIqOFzmXjyRKmuVfyRhMSj8eEYMR/GulTN+fabMLsxUhlOmSEjLsw2+
         /p8OZx7MzjRsgZtY+lL7/qwlZZxEzlEVZoyNoginE1IPj5llWErY0v5kOrJqtk1jGYms
         AnN0vcbjQeItkABj6szV0sCq55Uy3N1nbw2BwovWCkfjpNpZ+P+ANhhKZTusCxxeS3fg
         +1LRwqlggv2EK4ew6qYi3CgzHb+8y//pw8w3nnJUYERxAgzNFq5Net/xCGPT2+EveqDQ
         e/+A==
X-Gm-Message-State: APjAAAW2uixnsFE9Z1JGzJxMYaSSSRUpx3t0dJIOncDl+fy15OwaR40J
        tzsvZJeTUF01dQ+Qj+bDBdAk4MF6
X-Google-Smtp-Source: APXvYqyYWCprDYDNN7pbjK9/A9IPLL1lYRt1tlwpnNtcnQpm9Ga2UssLegkN899V/OFvN0n1n2qvDQ==
X-Received: by 2002:a62:4389:: with SMTP id l9mr32249620pfi.170.1552275758562;
        Sun, 10 Mar 2019 20:42:38 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id j9sm6769508pfc.67.2019.03.10.20.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 20:42:38 -0700 (PDT)
Date:   Sun, 10 Mar 2019 20:42:36 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 3/8] commit: extract cleanup_mode functions to sequencer
Message-ID: <9a6ad0b890b3ad5169854122f5bd429ce5ce8324.1552275703.git.liu.denton@gmail.com>
References: <cover.1548219737.git.liu.denton@gmail.com>
 <cover.1552275703.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1552275703.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index 95dda23eee..224c823b43 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -511,6 +511,25 @@ static int fast_forward_to(struct repository *r,
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
@@ -1013,6 +1032,16 @@ static int rest_is_empty(const struct strbuf *sb, int start)
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
index 4d505b3590..eb9bd97ef3 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -116,6 +116,12 @@ int rearrange_squash(struct repository *r);
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
2.21.0.370.g4fdb13b891

