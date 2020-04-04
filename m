Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D950C2BA15
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438BA20731
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMSTryUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgDDBMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:12:09 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41441 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgDDBME (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:12:04 -0400
Received: by mail-qt1-f195.google.com with SMTP id i3so8135698qtv.8
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zoSZ85dusfySIzDfKdbJZOvwhBY4tPgDxaFqCM2Bk3E=;
        b=NMSTryUNrPzKzWP4gKkaUIrEe7oXdeyLPGVQ/6cay3oXPZ+rpmEd+LZaJ8wF5Epjxj
         1dsBMY9eMZKASy5ln0aTh6YwNDR3RnFQMS591rzyyilgcGT5Svl4zXgsJPj0tG2tUbe9
         JE8PQO8XK7DlKhNwmbSZfI3NXJBJ50csNAFMaB6OJnHNxweX+y/3S/WYARNcn77Mt3vh
         aJch1ZcOiCCsD/qIQtSvB4qQPCTWJvlP6/fLd6BeEfqNEn4F35diALhCZGtYkIEl+DZ8
         6MzD0kQBpVNPIE/dlqzDFe1sytjp7nbDRiGiPv39j3K+yakUa4spIItmT7ycSR91PL0X
         igWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zoSZ85dusfySIzDfKdbJZOvwhBY4tPgDxaFqCM2Bk3E=;
        b=OZFnNxk00+8fKXkCZ8khriBZl3+jU4A0c2wN54SqdB5l1B7+C/oOm0pXwjGroA4Eet
         IR/15WLRJbumdTD8h2KSorhEvC83X+MbpTthnjXGqhHLb8kM+E9SLh5XoYMJDc8+smtY
         MJ9ULvkkx0imDr9MuFaGYoMX70l/FC8efkbBK+RPFhzSzIsrOOndorkL86IL0Cq3wNhJ
         Qw8bxe2ltZTqjfxZ8pjDoF6rEVLRasrI5AG4awAI/vpXCAavPX4EVF5zXu+F9CZRjT2J
         IasA0UpVDBwKlavvUeTACdHR3LCUiUc153iJNdB6HwqASlbf/AsxIp9tHOyMPQ9VR+hq
         ZqPg==
X-Gm-Message-State: AGi0PuZ4ZnUA6emOYbn/FlcAwuS2B0Ouk75H1ThZHj3LZAbgqISoXKpB
        5ZI0BA496VXL2GTlfqdiePwj+iU8
X-Google-Smtp-Source: APiQypLT0cHzEoPl5v9US1kVoTbcLGsjoTN8pNblr3pYZ7CQbCRgdvSNkOEiKlJHYTGXbG419F/edA==
X-Received: by 2002:ac8:fe9:: with SMTP id f38mr11236695qtk.130.1585962723182;
        Fri, 03 Apr 2020 18:12:03 -0700 (PDT)
Received: from localhost.localdomain (ktnron0919w-grc-01-76-68-143-128.dsl.bell.ca. [76.68.143.128])
        by smtp.gmail.com with ESMTPSA id a136sm3297503qkc.75.2020.04.03.18.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 18:12:02 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 04/23] sequencer: reuse strbuf_trim() in read_oneliner()
Date:   Fri,  3 Apr 2020 21:11:17 -0400
Message-Id: <c7a3cfa20005aeeedc27d2eb4af1e2c4470ad73d.1585962672.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585962672.git.liu.denton@gmail.com>
References: <cover.1584782450.git.liu.denton@gmail.com> <cover.1585962672.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the original read_oneliner() logic, we duplicated the logic for
strbuf_trim_trailing_newline() with one exception: instead of preventing
buffer accesses below index 0, it would prevent buffer accesses below
index `orig_len`. Although this is correct, it isn't worth having the
duplicated logic around.

Reset `buf` before using it then replace the trimming logic with
strbuf_trim().

As a cleanup, remove all reset_strbuf()s that happen before
read_oneliner() is called.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index faab0b13e8..09ca68f540 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -420,8 +420,8 @@ static int write_message(const void *buf, size_t len, const char *filename,
 }
 
 /*
- * Reads a file that was presumably written by a shell script, i.e. with an
- * end-of-line marker that needs to be stripped.
+ * Resets a strbuf then reads a file that was presumably written by a shell
+ * script, i.e. with an end-of-line marker that needs to be stripped.
  *
  * Note that only the last end-of-line marker is stripped, consistent with the
  * behavior of "$(cat path)" in a shell script.
@@ -431,23 +431,19 @@ static int write_message(const void *buf, size_t len, const char *filename,
 static int read_oneliner(struct strbuf *buf,
 	const char *path, int skip_if_empty)
 {
-	int orig_len = buf->len;
 
 	if (!file_exists(path))
 		return 0;
 
+	strbuf_reset(buf);
 	if (strbuf_read_file(buf, path, 0) < 0) {
 		warning_errno(_("could not read '%s'"), path);
 		return 0;
 	}
 
-	if (buf->len > orig_len && buf->buf[buf->len - 1] == '\n') {
-		if (--buf->len > orig_len && buf->buf[buf->len - 1] == '\r')
-			--buf->len;
-		buf->buf[buf->len] = '\0';
-	}
+	strbuf_trim(buf);
 
-	if (skip_if_empty && buf->len == orig_len)
+	if (skip_if_empty && !buf->len)
 		return 0;
 
 	return 1;
@@ -2471,7 +2467,6 @@ void parse_strategy_opts(struct replay_opts *opts, char *raw_opts)
 
 static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
 {
-	strbuf_reset(buf);
 	if (!read_oneliner(buf, rebase_path_strategy(), 0))
 		return;
 	opts->strategy = strbuf_detach(buf, NULL);
@@ -2494,7 +2489,6 @@ static int read_populate_opts(struct replay_opts *opts)
 				free(opts->gpg_sign);
 				opts->gpg_sign = xstrdup(buf.buf + 2);
 			}
-			strbuf_reset(&buf);
 		}
 
 		if (read_oneliner(&buf, rebase_path_allow_rerere_autoupdate(), 1)) {
@@ -2526,7 +2520,6 @@ static int read_populate_opts(struct replay_opts *opts)
 			opts->keep_redundant_commits = 1;
 
 		read_strategy_opts(opts, &buf);
-		strbuf_reset(&buf);
 
 		if (read_oneliner(&opts->current_fixups,
 				  rebase_path_current_fixups(), 1)) {
@@ -4006,7 +3999,6 @@ static int pick_commits(struct repository *r,
 				res = error(_("could not read orig-head"));
 				goto cleanup_head_ref;
 			}
-			strbuf_reset(&buf);
 			if (!read_oneliner(&buf, rebase_path_onto(), 0)) {
 				res = error(_("could not read 'onto'"));
 				goto cleanup_head_ref;
-- 
2.26.0.159.g23e2136ad0

