Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD73C2BA2B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531E9207FF
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oloV0xMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgDGO2f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:28:35 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:33736 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbgDGO2a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:28:30 -0400
Received: by mail-qv1-f65.google.com with SMTP id p19so1912285qve.0
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hzwahygR6Ex6Vj2E9Vg3hIxPiu91jEJXpBDe0r5S+gQ=;
        b=oloV0xMNcoh9RlZfg8uWBay0OYwL6KoZ4EljMXd6aYdBvfKZj9sU/potdWrX+EDilG
         6yACGIcWzzaSSwA/zG3L5dDrWAWEmaArhkZwc8B6KJH4NHGmRQeK5VtyTSBxzSSy870u
         qCh89EqRI2J+uJVJBJjWJPNNo6x8M5RkEPqyfBBGeReNnFzEH7ggUlPq4vuHt6lb0zJw
         mULdv6Zupg+vUnLyleFij65a7l/v8juO8CGWb8yWuuU8uGQ7O1lAOtl4PeJtTcayW08w
         RVRO3BsYe37qjmjOGUnCGBUdPQZ6qdRShfMnSC2G7e8k0p0xHFQSSJu92WDuuclArPuE
         UBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hzwahygR6Ex6Vj2E9Vg3hIxPiu91jEJXpBDe0r5S+gQ=;
        b=TkLqghrZSXs0JK0ackwo1JF/s4f35uxS0aCedKPwAwf63GGMt90c4snIGejnjShx2q
         BVNwOrTsN+GAWOb77txcC7bbSlARI3emYhZkEalPDZWanpGlyTGPIheuytMjxaAXmfWu
         jhQcl+taojK3OTbohXfXQBYYpk+DOePMgZuhWDeI984yTy/UzEOF+minYXJQb+G+pb0k
         H/bDOtiC1MDGPoJ7X1jmljVCT/ZgObpcHGe70zqzSmpfKpUGzMXI9jeT17glJfD4P4k1
         3K7AhaPxPN1ifAOIFDpIa527iHEsnCo6RmauXpyBRlAZBhxywQY4vIUf1VQIIlaJnerZ
         PHvw==
X-Gm-Message-State: AGi0PuYGnZe7qj5cdpsWfy1rxatl4v3QQqOchTC8LY5VvDXez7+AStNV
        T4dqHSUX7K6Jdu+2LKWJio2ezlAJ
X-Google-Smtp-Source: APiQypI8Jr2BGLiHnD4InrI2hTIaXMuCMLQn8ye6Gti71w70GPVxZdHwLFeWvoqLw4jFri3eBOP7CQ==
X-Received: by 2002:a0c:9aea:: with SMTP id k42mr2445872qvf.91.1586269708065;
        Tue, 07 Apr 2020 07:28:28 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id j6sm17051736qti.25.2020.04.07.07.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:28:27 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v5 08/22] rebase: use read_oneliner()
Date:   Tue,  7 Apr 2020 10:27:55 -0400
Message-Id: <0cc279fc14dd27ed2606064d236115aa72551dce.1586269543.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1586269542.git.liu.denton@gmail.com>
References: <cover.1585962672.git.liu.denton@gmail.com> <cover.1586269542.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since in sequencer.c, read_one() basically duplicates the functionality
of read_oneliner(), reduce code duplication by replacing read_one() with
read_oneliner().

This was done with the following Coccinelle script

	@@
	expression a, b;
	@@
	- read_one(a, b)
	+ !read_oneliner(b, a, READ_ONELINER_WARN_NON_EXISTENCE)

and long lines were manually broken up.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/rebase.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index bff53d5d16..57dbfd2a4f 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -586,15 +586,6 @@ static const char *state_dir_path(const char *filename, struct rebase_options *o
 	return path.buf;
 }
 
-/* Read one file, then strip line endings */
-static int read_one(const char *path, struct strbuf *buf)
-{
-	if (strbuf_read_file(buf, path, 0) < 0)
-		return error_errno(_("could not read '%s'"), path);
-	strbuf_trim_trailing_newline(buf);
-	return 0;
-}
-
 /* Initialize the rebase options from the state directory. */
 static int read_basic_state(struct rebase_options *opts)
 {
@@ -602,8 +593,10 @@ static int read_basic_state(struct rebase_options *opts)
 	struct strbuf buf = STRBUF_INIT;
 	struct object_id oid;
 
-	if (read_one(state_dir_path("head-name", opts), &head_name) ||
-	    read_one(state_dir_path("onto", opts), &buf))
+	if (!read_oneliner(&head_name, state_dir_path("head-name", opts),
+			   READ_ONELINER_WARN_MISSING) ||
+	    !read_oneliner(&buf, state_dir_path("onto", opts),
+			   READ_ONELINER_WARN_MISSING))
 		return -1;
 	opts->head_name = starts_with(head_name.buf, "refs/") ?
 		xstrdup(head_name.buf) : NULL;
@@ -619,9 +612,11 @@ static int read_basic_state(struct rebase_options *opts)
 	 */
 	strbuf_reset(&buf);
 	if (file_exists(state_dir_path("orig-head", opts))) {
-		if (read_one(state_dir_path("orig-head", opts), &buf))
+		if (!read_oneliner(&buf, state_dir_path("orig-head", opts),
+				   READ_ONELINER_WARN_MISSING))
 			return -1;
-	} else if (read_one(state_dir_path("head", opts), &buf))
+	} else if (!read_oneliner(&buf, state_dir_path("head", opts),
+				  READ_ONELINER_WARN_MISSING))
 		return -1;
 	if (get_oid(buf.buf, &opts->orig_head))
 		return error(_("invalid orig-head: '%s'"), buf.buf);
@@ -641,8 +636,8 @@ static int read_basic_state(struct rebase_options *opts)
 
 	if (file_exists(state_dir_path("allow_rerere_autoupdate", opts))) {
 		strbuf_reset(&buf);
-		if (read_one(state_dir_path("allow_rerere_autoupdate", opts),
-			    &buf))
+		if (!read_oneliner(&buf, state_dir_path("allow_rerere_autoupdate", opts),
+				   READ_ONELINER_WARN_MISSING))
 			return -1;
 		if (!strcmp(buf.buf, "--rerere-autoupdate"))
 			opts->allow_rerere_autoupdate = RERERE_AUTOUPDATE;
@@ -655,8 +650,8 @@ static int read_basic_state(struct rebase_options *opts)
 
 	if (file_exists(state_dir_path("gpg_sign_opt", opts))) {
 		strbuf_reset(&buf);
-		if (read_one(state_dir_path("gpg_sign_opt", opts),
-			    &buf))
+		if (!read_oneliner(&buf, state_dir_path("gpg_sign_opt", opts),
+				   READ_ONELINER_WARN_MISSING))
 			return -1;
 		free(opts->gpg_sign_opt);
 		opts->gpg_sign_opt = xstrdup(buf.buf);
@@ -664,7 +659,8 @@ static int read_basic_state(struct rebase_options *opts)
 
 	if (file_exists(state_dir_path("strategy", opts))) {
 		strbuf_reset(&buf);
-		if (read_one(state_dir_path("strategy", opts), &buf))
+		if (!read_oneliner(&buf, state_dir_path("strategy", opts),
+				   READ_ONELINER_WARN_MISSING))
 			return -1;
 		free(opts->strategy);
 		opts->strategy = xstrdup(buf.buf);
@@ -672,7 +668,8 @@ static int read_basic_state(struct rebase_options *opts)
 
 	if (file_exists(state_dir_path("strategy_opts", opts))) {
 		strbuf_reset(&buf);
-		if (read_one(state_dir_path("strategy_opts", opts), &buf))
+		if (!read_oneliner(&buf, state_dir_path("strategy_opts", opts),
+				   READ_ONELINER_WARN_MISSING))
 			return -1;
 		free(opts->strategy_opts);
 		opts->strategy_opts = xstrdup(buf.buf);
@@ -724,7 +721,7 @@ static int apply_autostash(struct rebase_options *opts)
 	if (!file_exists(path))
 		return 0;
 
-	if (read_one(path, &autostash))
+	if (!read_oneliner(&autostash, path, READ_ONELINER_WARN_MISSING))
 		return error(_("Could not read '%s'"), path);
 	/* Ensure that the hash is not mistaken for a number */
 	strbuf_addstr(&autostash, "^0");
-- 
2.26.0.159.g23e2136ad0

