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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3620EC2BA19
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D17F20787
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syvUAGNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgDDBMH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:12:07 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44150 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgDDBMG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:12:06 -0400
Received: by mail-qt1-f196.google.com with SMTP id x16so8115456qts.11
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=grx6/aD7ArEongb9HzfT1qUQDXyZt7oCnPOOYVD57xk=;
        b=syvUAGNbcoyTq33aGjs469uGmT8Ntqsmg/2vFuYmyjQanVWQQqr4DKmKzas6xmJ18A
         l9fLZdpB139OnUDVhdLR6ZGtO/dwqWew2rGaM0TeKFf0NR26c9RELoIJJF25K78Wy/0s
         BcKnXvD7oMIQ1KmxG3NY/B6Lp0dHe6EC6omNgaXZwr8DciroyvzhcilDv1prkJYRP8wX
         SBQQ9dwrfDq7IL+tZEZ5Ta3qiCHqDWhKnIFHNqrvVCrYbyIgtLFij7GBBlEH/Vo/Lnxa
         nopz8u/tw4Fzzq8XT7BFsCCZE/sI+RZ0uXvscaE9rOinC4ZMtNM11chGBP7IOOITPyQw
         FpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=grx6/aD7ArEongb9HzfT1qUQDXyZt7oCnPOOYVD57xk=;
        b=ks2YrxRsGmYRE3Dg6NA8eBpDBwosFJRCFn+woS1gOINhNOQQVkgssYdqBw0CWFwCvP
         CUi+lQ0s9SyQ1ppe7b9uGY2NKeGWtVTqhRrnao0aw0SyC+wRqqoApMcn8Tujn0HpeGmy
         ycNAy+OJaOCvPIQ8zIVxLVxGTV6Ouhqd2Su6yaEfnCHbMwqjDRy+SALUz2EmFvdqUV0U
         x3lmWY+0rNTc7/zg2YC0qXAQRPE/3uxDcdVDLrINTIn2SWydOBj0a1suPhMb5Ts1DrYU
         grqy7j99SuEHzRf8r8GKWzc6cKbsmR7lGINlvwvI1AQFqZJVqTwuac4droqS4eSJ4ESD
         9WCA==
X-Gm-Message-State: AGi0Pubn1DjsJ4sXugJAKuEVvezlHQ+t+MzBhsG83HEUj2UOaWSJ5Tm9
        DksXZl8zBKOj28Grs5k3u73aA4o/
X-Google-Smtp-Source: APiQypJFEpZ8k1ZULma97esE3a1TjHsnjBzCGJbLVEcD53rEBYoh/DB2Ys3e4hzOvmeK7MeuYhhj1Q==
X-Received: by 2002:ac8:3ac7:: with SMTP id x65mr742658qte.45.1585962725081;
        Fri, 03 Apr 2020 18:12:05 -0700 (PDT)
Received: from localhost.localdomain (ktnron0919w-grc-01-76-68-143-128.dsl.bell.ca. [76.68.143.128])
        by smtp.gmail.com with ESMTPSA id a136sm3297503qkc.75.2020.04.03.18.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 18:12:04 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 06/23] sequencer: make read_oneliner() accept flags
Date:   Fri,  3 Apr 2020 21:11:19 -0400
Message-Id: <6ead240957da808be1261bc960227c4183da3dd9.1585962672.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585962672.git.liu.denton@gmail.com>
References: <cover.1584782450.git.liu.denton@gmail.com> <cover.1585962672.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future commit, we will need read_oneliner() to accept flags other
than just `skip_if_empty`. Instead of having an argument for each flag,
teach read_oneliner() to accept the bitfield `flags` instead. For now,
only recognize the `READ_ONELINER_SKIP_IF_EMPTY` flag. More flags will
be added in a future commit.

The result of this is that parallel topics which introduce invocations
of read_oneliner() will still be compatible with this new function
signature since, instead of passing 1 or 0 for `skip_if_empty`, they'll
be passing 1 or 0 to `flags`, which gives equivalent behavior.

Mechanically fix up invocations of read_oneliner() with the following
spatch

	@@
	expression a, b;
	@@
	  read_oneliner(a, b,
	- 1
	+ READ_ONELINER_SKIP_IF_EMPTY
	  )

and manually break up long lines in the result.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 6e63224c41..6c26d61670 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -419,6 +419,8 @@ static int write_message(const void *buf, size_t len, const char *filename,
 	return 0;
 }
 
+#define READ_ONELINER_SKIP_IF_EMPTY (1 << 0)
+
 /*
  * Resets a strbuf then reads a file that was presumably written by a shell
  * script, i.e. with an end-of-line marker that needs to be stripped.
@@ -429,7 +431,7 @@ static int write_message(const void *buf, size_t len, const char *filename,
  * Returns 1 if the file was read, 0 if it could not be read or does not exist.
  */
 static int read_oneliner(struct strbuf *buf,
-	const char *path, int skip_if_empty)
+	const char *path, unsigned flags)
 {
 	strbuf_reset(buf);
 	if (strbuf_read_file(buf, path, 0) < 0) {
@@ -440,7 +442,7 @@ static int read_oneliner(struct strbuf *buf,
 
 	strbuf_trim(buf);
 
-	if (skip_if_empty && !buf->len)
+	if ((flags & READ_ONELINER_SKIP_IF_EMPTY) && !buf->len)
 		return 0;
 
 	return 1;
@@ -2479,7 +2481,8 @@ static int read_populate_opts(struct replay_opts *opts)
 		struct strbuf buf = STRBUF_INIT;
 		int ret = 0;
 
-		if (read_oneliner(&buf, rebase_path_gpg_sign_opt(), 1)) {
+		if (read_oneliner(&buf, rebase_path_gpg_sign_opt(),
+				  READ_ONELINER_SKIP_IF_EMPTY)) {
 			if (!starts_with(buf.buf, "-S"))
 				strbuf_reset(&buf);
 			else {
@@ -2488,7 +2491,8 @@ static int read_populate_opts(struct replay_opts *opts)
 			}
 		}
 
-		if (read_oneliner(&buf, rebase_path_allow_rerere_autoupdate(), 1)) {
+		if (read_oneliner(&buf, rebase_path_allow_rerere_autoupdate(),
+				  READ_ONELINER_SKIP_IF_EMPTY)) {
 			if (!strcmp(buf.buf, "--rerere-autoupdate"))
 				opts->allow_rerere_auto = RERERE_AUTOUPDATE;
 			else if (!strcmp(buf.buf, "--no-rerere-autoupdate"))
@@ -2519,7 +2523,8 @@ static int read_populate_opts(struct replay_opts *opts)
 		read_strategy_opts(opts, &buf);
 
 		if (read_oneliner(&opts->current_fixups,
-				  rebase_path_current_fixups(), 1)) {
+				  rebase_path_current_fixups(),
+				  READ_ONELINER_SKIP_IF_EMPTY)) {
 			const char *p = opts->current_fixups.buf;
 			opts->current_fixup_count = 1;
 			while ((p = strchr(p, '\n'))) {
@@ -3660,7 +3665,8 @@ static int apply_autostash(struct replay_opts *opts)
 	struct child_process child = CHILD_PROCESS_INIT;
 	int ret = 0;
 
-	if (!read_oneliner(&stash_sha1, rebase_path_autostash(), 1)) {
+	if (!read_oneliner(&stash_sha1, rebase_path_autostash(),
+			   READ_ONELINER_SKIP_IF_EMPTY)) {
 		strbuf_release(&stash_sha1);
 		return 0;
 	}
@@ -4283,7 +4289,8 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 		struct strbuf buf = STRBUF_INIT;
 		struct object_id oid;
 
-		if (read_oneliner(&buf, rebase_path_stopped_sha(), 1) &&
+		if (read_oneliner(&buf, rebase_path_stopped_sha(),
+				  READ_ONELINER_SKIP_IF_EMPTY) &&
 		    !get_oid_committish(buf.buf, &oid))
 			record_in_rewritten(&oid, peek_command(&todo_list, 0));
 		strbuf_release(&buf);
-- 
2.26.0.159.g23e2136ad0

