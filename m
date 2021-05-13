Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA99C43461
	for <git@archiver.kernel.org>; Thu, 13 May 2021 21:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D692D61421
	for <git@archiver.kernel.org>; Thu, 13 May 2021 21:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhEMVnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 17:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbhEMVnN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 17:43:13 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98074C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 14:42:01 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id n2so28272651wrm.0
        for <git@vger.kernel.org>; Thu, 13 May 2021 14:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j7cVPMYmKHqo1ZZti20sD0smfrN/cVQBfhS95mLoa+w=;
        b=VbTpbE7ttrOmUXuCYjxd1W1NkQCDRXUYm+rlvAjBV59jiWcmu9giOofhnRrVSp4ssk
         pE0U/0cNF00IvZlxLhGy3Qs9ueYsykWpXE02jjQvUM3xfIrvbM4Znu4odVSKPuPRGG8E
         s9evL8BJqXzd6Rk9ktZzQCsmeLN5mhGGJlsnJEFae6F2TI11ovWsCw+/OeeG4j2MZ+CI
         UVpMqKvtjm+cySV+8sMhSkiXsc7gslJFg3B57X9YILhePUd5VuEztI5KffS2mbbMF/Ni
         TkkBgGDXnbUR3PwMtWm7CVKBmYXL/DmFapndL7/IF9SPHrewJMsuP3kQ21yfuH5sAaqT
         Lg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j7cVPMYmKHqo1ZZti20sD0smfrN/cVQBfhS95mLoa+w=;
        b=XhkiaYT4nsSKIVXMakl009CRkrjzdiq1QHLoIrtTSFIdwh5JOCfhGSZvL7w1ybItYH
         t+ITrY5OO8+wG71K8j4Om92Ct3eWneH4ma0a9ahZThC7jXlGkWihPxhN8vyWU6H3kjbq
         8I2/iL7S9gE4KnaiCsRbLCsV6eNNnjn68IVcTiyFfRZJkZDr7XQ/orBwz1F19VAFzewX
         8kcPnikw908lTj6n3BJ01ymDKN/5HuHAjALHRaO6h3YWwCdPsCdyceSk+QqWvLqQ4x54
         TNhU10GTUZjIjQDP0nNL8PO1zgs1HTZs56T44mUhAb2w+3tveHUDJYLb4eGNL0XY/g/p
         ScyA==
X-Gm-Message-State: AOAM532LJxqCu0s7iasNWwb6/r+pDlyU/jj0aKZuP6NORxVHNIvtY7aX
        Hy6Ecq9Bnwb07PsPXdk0RPOcfTCAq1jfIA==
X-Google-Smtp-Source: ABdhPJy9TmaQVaoYV9cXVye2LvHlbgSMxzXWtJkWnbxghfTe88ZZ1MWPNXfx9pflzRcu2uMB3A5OPw==
X-Received: by 2002:a5d:598f:: with SMTP id n15mr54149067wri.21.1620942120332;
        Thu, 13 May 2021 14:42:00 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c42001c07d070726df7f9.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:1c07:d070:726d:f7f9])
        by smtp.gmail.com with ESMTPSA id p14sm4273606wrx.88.2021.05.13.14.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 14:41:59 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 2/2] builtin: use git_read_line_interactively to prompt
Date:   Thu, 13 May 2021 23:41:52 +0200
Message-Id: <20210513214152.34792-3-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.443.g67a420f573
In-Reply-To: <20210513214152.34792-1-firminmartin24@gmail.com>
References: <20210513214152.34792-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor prompts using the helper function git_read_line_interactively
as done in 08d383f23e (interactive: refactor code asking the user for
interactive input, 2020-04-10).

Also fix two git_prompt instances, introduced in 09535f056b
(bisect--helper: reimplement `bisect_autostart` shell function in C,
2020-09-24). See 97387c8bdd (am: read interactive input from stdin,
2019-05-20) for a detailed motivation to do so.

Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 builtin/am.c             | 14 +++++++-------
 builtin/bisect--helper.c | 15 ++++++++-------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 8355e3566f..32eae4eb2e 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1643,7 +1643,7 @@ static int do_interactive(struct am_state *state)
 	assert(state->msg);
 
 	for (;;) {
-		char reply[64];
+		struct strbuf reply = STRBUF_INIT;
 
 		puts(_("Commit Body is:"));
 		puts("--------------------------");
@@ -1656,17 +1656,17 @@ static int do_interactive(struct am_state *state)
 		 * input at this point.
 		 */
 		printf(_("Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all: "));
-		if (!fgets(reply, sizeof(reply), stdin))
+		if (git_read_line_interactively(&reply) == EOF)
 			die("unable to read from stdin; aborting");
 
-		if (*reply == 'y' || *reply == 'Y') {
+		if (reply.len && !strncasecmp(reply.buf, "yes", reply.len)) {
 			return 0;
-		} else if (*reply == 'a' || *reply == 'A') {
+		} else if (*reply.buf == 'a' || *reply.buf == 'A') {
 			state->interactive = 0;
 			return 0;
-		} else if (*reply == 'n' || *reply == 'N') {
+		} else if (reply.len && !strncasecmp(reply.buf, "no", reply.len)) {
 			return 1;
-		} else if (*reply == 'e' || *reply == 'E') {
+		} else if (*reply.buf == 'e' || *reply.buf == 'E') {
 			struct strbuf msg = STRBUF_INIT;
 
 			if (!launch_editor(am_path(state, "final-commit"), &msg, NULL)) {
@@ -1674,7 +1674,7 @@ static int do_interactive(struct am_state *state)
 				state->msg = strbuf_detach(&msg, &state->msg_len);
 			}
 			strbuf_release(&msg);
-		} else if (*reply == 'v' || *reply == 'V') {
+		} else if (*reply.buf == 'v' || *reply.buf == 'V') {
 			const char *pager = git_pager(1);
 			struct child_process cp = CHILD_PROCESS_INIT;
 
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1fdb7d9d10..134347eb39 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -340,7 +340,7 @@ static int decide_next(const struct bisect_terms *terms,
 
 	if (missing_good && !missing_bad &&
 	    !strcmp(current_term, terms->term_good)) {
-		char *yesno;
+		struct strbuf yesno = STRBUF_INIT;
 		/*
 		 * have bad (or new) but not good (or old). We could bisect
 		 * although this is less optimum.
@@ -353,8 +353,9 @@ static int decide_next(const struct bisect_terms *terms,
 		 * translation. The program will only accept English input
 		 * at this point.
 		 */
-		yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);
-		if (starts_with(yesno, "N") || starts_with(yesno, "n"))
+		printf(_("Are you sure [Y/n]? "));
+		git_read_line_interactively(&yesno);
+		if (yesno.len && !strncasecmp(yesno.buf, "no", yesno.len))
 			return -1;
 		return 0;
 	}
@@ -805,7 +806,7 @@ static inline int file_is_not_empty(const char *path)
 static int bisect_autostart(struct bisect_terms *terms)
 {
 	int res;
-	const char *yesno;
+	struct strbuf yesno = STRBUF_INIT;
 
 	if (file_is_not_empty(git_path_bisect_start()))
 		return 0;
@@ -821,9 +822,9 @@ static int bisect_autostart(struct bisect_terms *terms)
 	 * translation. The program will only accept English input
 	 * at this point.
 	 */
-	yesno = git_prompt(_("Do you want me to do it for you "
-			     "[Y/n]? "), PROMPT_ECHO);
-	res = tolower(*yesno) == 'n' ?
+	printf(_("Do you want me to do it for you [Y/n]? "));
+	git_read_line_interactively(&yesno);
+	res = (yesno.len && strncasecmp(yesno.buf, "no", yesno.len)) ?
 		-1 : bisect_start(terms, empty_strvec, 0);
 
 	return res;
-- 
2.31.1.443.g67a420f573

