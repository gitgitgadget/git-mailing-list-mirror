Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB562C433E3
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8101F20758
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+cUpvhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388818AbgHQRkm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731457AbgHQRkR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 13:40:17 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F81C061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 10:40:16 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k20so14596343wmi.5
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 10:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=QbfriR7PmDJ3HmsXjw7jjpzCKF2wwbqWyTGwDM7f/8g=;
        b=S+cUpvhU5m0y9TgB+CQTPv3s2L5xNXmTykTfDXALY1fj16t7QjMatBT694NRWobp+3
         c6kWWEMeA9pnXK2quKupT2Boxnc26CP76C08MjIOod4KyAL9CzK8aaujP2yog28zgD2D
         Om/E78Xp7CGlMtdxa1pUldEO3ARXrD5k1sol3cI5rvKrXGMwRBFifwogV/4sAqt17Zaw
         aE7CFn5iKFn5vafH1GW0YHq5PrzIg55u/nLsWxSRAKjXaIFrXP4VrIavNkYnsQ/OU7nz
         XMpltf2mLzHKrOezknv1Op2tdT9lBId27zRBvIHkQJqwfCXBUUhTBU1czK+PlNr+Exb3
         2QfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=QbfriR7PmDJ3HmsXjw7jjpzCKF2wwbqWyTGwDM7f/8g=;
        b=CSiAcLZR9VgE5wPKpdd5EPtx026S0U0tt1Itfsl1btZ65KzENPHKti+lJpMirUss6U
         yoNIR6vzabGHj3S48nT7GMv7IhtXue/eTwUliy19Dak2DejThQOaSeT8995twyktTwfp
         W6/YKQd87K6/kOhIHJsWRZ/TZ2eegOB3fiUFOrd8VO1bxvBMx6+vHQqeHSmfd7aQv8mD
         Viw4QGmLhKu3UG9hFiuO5NVjxO8lndJMmO/+mO+daWMcFiCSctnBlIpnnrvL2xmFWJ9W
         gA3Tok+e4coQrUKtHL2KSv0kqLOnJCqQfmsyCosOzz1nKIF1fqnbhyCABH2gjEvlRTzR
         VPYA==
X-Gm-Message-State: AOAM531MZnzeVGa2xlrQf0pCjZH+Wl/xcN4qsnM2vuRztxI1GR5Q9Gt9
        OUZutLISWG2sCK7SgefYPnA=
X-Google-Smtp-Source: ABdhPJyvJ1afitxnoRE78yn4dGZVTuDK51mh9f/Z6xULylfQ++chDfCLyZtI1H986NMOGviolfwuvA==
X-Received: by 2002:a1c:7915:: with SMTP id l21mr16296415wme.50.1597686015578;
        Mon, 17 Aug 2020 10:40:15 -0700 (PDT)
Received: from localhost.localdomain (192.252.189.80.dyn.plus.net. [80.189.252.192])
        by smtp.gmail.com with ESMTPSA id l10sm31252058wru.3.2020.08.17.10.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 10:40:15 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v8 2/5] am: stop exporting GIT_COMMITTER_DATE
Date:   Mon, 17 Aug 2020 18:40:01 +0100
Message-Id: <20200817174004.92455-3-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817174004.92455-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200817174004.92455-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The implementation of --committer-date-is-author-date exports
GIT_COMMITTER_DATE to override the default committer date but does not
reset GIT_COMMITTER_DATE in the environment after creating the commit
so it is set in the environment of any hooks that get run. We're about
to add the same functionality to the sequencer and do not want to have
GIT_COMMITTER_DATE set when running hooks or exec commands so lets
update commit_tree_extended() to take an explicit committer so we
override the default date without setting GIT_COMMITTER_DATE in the
environment.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/am.c     | 28 +++++++++++++++++++++++-----
 builtin/commit.c |  4 ++--
 commit.c         | 11 +++++++----
 commit.h         |  7 +++----
 ident.c          | 24 ++++++++++++++----------
 sequencer.c      |  4 ++--
 6 files changed, 51 insertions(+), 27 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index e3dfd93c25..896cd0f827 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -98,6 +98,8 @@ struct am_state {
 	char *author_name;
 	char *author_email;
 	char *author_date;
+	char *committer_name;
+	char *committer_email;
 	char *msg;
 	size_t msg_len;
 
@@ -130,6 +132,8 @@ struct am_state {
  */
 static void am_state_init(struct am_state *state)
 {
+	const char *committer;
+	struct ident_split id;
 	int gpgsign;
 
 	memset(state, 0, sizeof(*state));
@@ -150,6 +154,14 @@ static void am_state_init(struct am_state *state)
 
 	if (!git_config_get_bool("commit.gpgsign", &gpgsign))
 		state->sign_commit = gpgsign ? "" : NULL;
+
+	committer = git_committer_info(IDENT_STRICT);
+	if (split_ident_line(&id, committer, strlen(committer)) < 0)
+		die(_("invalid committer: %s"), committer);
+	state->committer_name =
+		xmemdupz(id.name_begin, id.name_end - id.name_begin);
+	state->committer_email =
+		xmemdupz(id.mail_begin, id.mail_end - id.mail_end);
 }
 
 /**
@@ -161,6 +173,8 @@ static void am_state_release(struct am_state *state)
 	free(state->author_name);
 	free(state->author_email);
 	free(state->author_date);
+	free(state->committer_name);
+	free(state->committer_email);
 	free(state->msg);
 	argv_array_clear(&state->git_apply_opts);
 }
@@ -1556,7 +1570,7 @@ static void do_commit(const struct am_state *state)
 	struct object_id tree, parent, commit;
 	const struct object_id *old_oid;
 	struct commit_list *parents = NULL;
-	const char *reflog_msg, *author;
+	const char *reflog_msg, *author, *committer = NULL;
 	struct strbuf sb = STRBUF_INIT;
 
 	if (run_hook_le(NULL, "pre-applypatch", NULL))
@@ -1580,11 +1594,15 @@ static void do_commit(const struct am_state *state)
 			IDENT_STRICT);
 
 	if (state->committer_date_is_author_date)
-		setenv("GIT_COMMITTER_DATE",
-			state->ignore_date ? "" : state->author_date, 1);
+		committer = fmt_ident(state->committer_name,
+				      state->author_email, WANT_COMMITTER_IDENT,
+				      state->ignore_date ? NULL
+							 : state->author_date,
+				      IDENT_STRICT);
 
-	if (commit_tree(state->msg, state->msg_len, &tree, parents, &commit,
-			author, state->sign_commit))
+	if (commit_tree_extended(state->msg, state->msg_len, &tree, parents,
+				 &commit, author, committer, state->sign_commit,
+				 NULL))
 		die(_("failed to write commit object"));
 
 	reflog_msg = getenv("GIT_REFLOG_ACTION");
diff --git a/builtin/commit.c b/builtin/commit.c
index d3e7781e65..2785344fed 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1675,8 +1675,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	}
 
 	if (commit_tree_extended(sb.buf, sb.len, &active_cache_tree->oid,
-				 parents, &oid, author_ident.buf, sign_commit,
-				 extra)) {
+				 parents, &oid, author_ident.buf, NULL,
+				 sign_commit, extra)) {
 		rollback_index_files();
 		die(_("failed to write commit object"));
 	}
diff --git a/commit.c b/commit.c
index c7099daeac..fb63c22cc1 100644
--- a/commit.c
+++ b/commit.c
@@ -1324,8 +1324,8 @@ int commit_tree(const char *msg, size_t msg_len, const struct object_id *tree,
 	int result;
 
 	append_merge_tag_headers(parents, &tail);
-	result = commit_tree_extended(msg, msg_len, tree, parents, ret,
-				      author, sign_commit, extra);
+	result = commit_tree_extended(msg, msg_len, tree, parents, ret, author,
+				      NULL, sign_commit, extra);
 	free_commit_extra_headers(extra);
 	return result;
 }
@@ -1448,7 +1448,8 @@ N_("Warning: commit message did not conform to UTF-8.\n"
 int commit_tree_extended(const char *msg, size_t msg_len,
 			 const struct object_id *tree,
 			 struct commit_list *parents, struct object_id *ret,
-			 const char *author, const char *sign_commit,
+			 const char *author, const char *committer,
+			 const char *sign_commit,
 			 struct commit_extra_header *extra)
 {
 	int result;
@@ -1481,7 +1482,9 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	if (!author)
 		author = git_author_info(IDENT_STRICT);
 	strbuf_addf(&buffer, "author %s\n", author);
-	strbuf_addf(&buffer, "committer %s\n", git_committer_info(IDENT_STRICT));
+	if (!committer)
+		committer = git_committer_info(IDENT_STRICT);
+	strbuf_addf(&buffer, "committer %s\n", committer);
 	if (!encoding_is_utf8)
 		strbuf_addf(&buffer, "encoding %s\n", git_commit_encoding);
 
diff --git a/commit.h b/commit.h
index 008a0fa4a0..8f4227ae5c 100644
--- a/commit.h
+++ b/commit.h
@@ -316,10 +316,9 @@ int commit_tree(const char *msg, size_t msg_len,
 
 int commit_tree_extended(const char *msg, size_t msg_len,
 			 const struct object_id *tree,
-			 struct commit_list *parents,
-			 struct object_id *ret, const char *author,
-			 const char *sign_commit,
-			 struct commit_extra_header *);
+			 struct commit_list *parents, struct object_id *ret,
+			 const char *author, const char *committer,
+			 const char *sign_commit, struct commit_extra_header *);
 
 struct commit_extra_header *read_commit_extra_headers(struct commit *, const char **);
 
diff --git a/ident.c b/ident.c
index e666ee4e59..7cbf223350 100644
--- a/ident.c
+++ b/ident.c
@@ -361,11 +361,15 @@ N_("\n"
 const char *fmt_ident(const char *name, const char *email,
 		      enum want_ident whose_ident, const char *date_str, int flag)
 {
-	static struct strbuf ident = STRBUF_INIT;
+	static int index;
+	static struct strbuf ident_pool[2] = { STRBUF_INIT, STRBUF_INIT };
 	int strict = (flag & IDENT_STRICT);
 	int want_date = !(flag & IDENT_NO_DATE);
 	int want_name = !(flag & IDENT_NO_NAME);
 
+	struct strbuf *ident = &ident_pool[index];
+	index = (index + 1) % ARRAY_SIZE(ident_pool);
+
 	if (!email) {
 		if (whose_ident == WANT_AUTHOR_IDENT && git_author_email.len)
 			email = git_author_email.buf;
@@ -421,25 +425,25 @@ const char *fmt_ident(const char *name, const char *email,
 			die(_("name consists only of disallowed characters: %s"), name);
 	}
 
-	strbuf_reset(&ident);
+	strbuf_reset(ident);
 	if (want_name) {
-		strbuf_addstr_without_crud(&ident, name);
-		strbuf_addstr(&ident, " <");
+		strbuf_addstr_without_crud(ident, name);
+		strbuf_addstr(ident, " <");
 	}
-	strbuf_addstr_without_crud(&ident, email);
+	strbuf_addstr_without_crud(ident, email);
 	if (want_name)
-			strbuf_addch(&ident, '>');
+		strbuf_addch(ident, '>');
 	if (want_date) {
-		strbuf_addch(&ident, ' ');
+		strbuf_addch(ident, ' ');
 		if (date_str && date_str[0]) {
-			if (parse_date(date_str, &ident) < 0)
+			if (parse_date(date_str, ident) < 0)
 				die(_("invalid date format: %s"), date_str);
 		}
 		else
-			strbuf_addstr(&ident, ident_default_date());
+			strbuf_addstr(ident, ident_default_date());
 	}
 
-	return ident.buf;
+	return ident->buf;
 }
 
 const char *fmt_name(enum want_ident whose_ident)
diff --git a/sequencer.c b/sequencer.c
index 6fd2674632..968a2d4ef3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1408,8 +1408,8 @@ static int try_to_commit(struct repository *r,
 
 	reset_ident_date();
 
-	if (commit_tree_extended(msg->buf, msg->len, &tree, parents,
-				 oid, author, opts->gpg_sign, extra)) {
+	if (commit_tree_extended(msg->buf, msg->len, &tree, parents, oid,
+				 author, NULL, opts->gpg_sign, extra)) {
 		res = error(_("failed to write commit object"));
 		goto out;
 	}
-- 
2.28.0

