Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8013F20370
	for <e@80x24.org>; Thu,  5 Oct 2017 20:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbdJEUcy (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 16:32:54 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36385 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbdJEUcu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 16:32:50 -0400
Received: by mail-wr0-f195.google.com with SMTP id l10so1951024wre.3
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 13:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Mth3z2aobXBUYAPlxw1ZS1CuNKyZWHYxTe54hC+kc0=;
        b=SB4iFBXP6+OVlqpEmzFOlQitHMckFVY9Imyi8WWI4TNqvAfKavGDOb3YI87giy4Xwb
         uRRvZz2ExF6U6WcNGY57NEjvLdiJmo16FyTp8dRxLhZelWmQXFIre7bFL0l5FDLU4qUb
         0d7Bl5b4/XpvMmCHdEmW0X1ydqR8qdCiI/aDtgpa4hC3mXlA6S5D9GWUFaNczMlRzYAA
         ReS5h9F+bbfK99ulyON8le2jPy1hdQP6B7f5WI6VMT4DZnqb6/vy+uqNmQ0l9Y3hwfpx
         6hR8R+lGTagrtvZlnb55hgQZ7PPY9bzPoQr+InNWz4h1hJAbj4XimNkMqSfio8tZYOFk
         ad8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Mth3z2aobXBUYAPlxw1ZS1CuNKyZWHYxTe54hC+kc0=;
        b=BKZeA4P6ENs9zBy5uHruKox5jsosxA5jcQwsaUz7gQ6ijN6bILpUv1EIlr3vz8llMW
         z7zuxYIT6BTbgnRclS6azadokV3ujMY45QxpHBBhVz1dfrWSIhvcCuE2JmM71HW+sLev
         8fZ2LvQU1sY2SFuw+0IJU3sLRUo27DemrZPkGyewHNXXE1q1ak68FFYUtjJEJq0gvN7F
         0RaVfRaFfoIrclE3bF6cOf6pV2880chCS/0xe/2tdfzcmxOvjtMacuKjGLIL88WQ7res
         uiKQ1YH/QQgP+gNLTxBWF8srZaAlWhLV5YXSYUXQwn5ZwJFt9+VQNZ0OQSTbNaC4wzbh
         ub5g==
X-Gm-Message-State: AHPjjUhrRU32QGdDEwMWwN4DIXO90SOu+Jq8VLsbSEcqzbUrEZ1uvkkg
        qT5O+j6Bp3iXVB4eC+bMK40gCNA1
X-Google-Smtp-Source: AOwi7QCZ73VkglQmfuW04jED2C3PXuHbRFSFcgC9hJ/P9JqNpmQwO9LsYNSYdVhO0kRJwIOKV4n04Q==
X-Received: by 10.223.157.139 with SMTP id p11mr26760892wre.28.1507235569083;
        Thu, 05 Oct 2017 13:32:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id i76sm698424wmd.2.2017.10.05.13.32.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Oct 2017 13:32:48 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/12] apply: move lockfile into `apply_state`
Date:   Thu,  5 Oct 2017 22:32:09 +0200
Message-Id: <c8426ab17ccdd07d75282b612c19a88d5d292c5f.1507228170.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.2.666.gea220ee40
In-Reply-To: <cover.1507228170.git.martin.agren@gmail.com>
References: <xmqqy3osiwe6.fsf@gitster.mtv.corp.google.com> <cover.1507228170.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have two users of `struct apply_state` and the related functionality
in apply.c. Each user sets up its `apply_state` by handing over a
pointer to its static `lock_file`. (Before 076aa2cbd (tempfile:
auto-allocate tempfiles on heap, 2017-09-05), we could never free
lockfiles, so making them static was a reasonable approach.)

Other than that, they never directly access their `lock_file`s, which
are instead handled by the functionality in apply.c.

To make life easier for the caller and to make it less tempting for a
future caller to mess with the lock, make apply.c fully responsible for
setting up the `lock_file`. As mentioned above, it is now safe to free a
`lock_file`, so we can make the `struct apply_state` contain an actual
`struct lock_file` instead of a pointer to one.

The user in builtin/apply.c is rather simple. For builtin/am.c, we might
worry that the lock state is actually meant to be inherited across
calls. But the lock is only taken as `apply_all_patches()` executes, and
code inspection shows that it will always be released.

Alternatively, we can observe that the lock itself is never queried
directly. When we decide whether we should lock, we check a related
variable `newfd`. That variable is not inherited, so from the point of
view of apply.c, the state machine really is reset with each call to
`init_apply_state()`. (It would be a bug if `newfd` and the lock status
were not in sync. The duplication of information in `newfd` and the lock
will be addressed in the next patch.)

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
v2: Identical.

 apply.c         | 14 +++++---------
 apply.h         |  5 ++---
 builtin/am.c    |  3 +--
 builtin/apply.c |  4 +---
 4 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/apply.c b/apply.c
index c022af53a..5a6ca10a7 100644
--- a/apply.c
+++ b/apply.c
@@ -75,12 +75,10 @@ static int parse_ignorewhitespace_option(struct apply_state *state,
 }
 
 int init_apply_state(struct apply_state *state,
-		     const char *prefix,
-		     struct lock_file *lock_file)
+		     const char *prefix)
 {
 	memset(state, 0, sizeof(*state));
 	state->prefix = prefix;
-	state->lock_file = lock_file;
 	state->newfd = -1;
 	state->apply = 1;
 	state->line_termination = '\n';
@@ -146,8 +144,6 @@ int check_apply_state(struct apply_state *state, int force_apply)
 	}
 	if (state->check_index)
 		state->unsafe_paths = 0;
-	if (!state->lock_file)
-		return error("BUG: state->lock_file should not be NULL");
 
 	if (state->apply_verbosity <= verbosity_silent) {
 		state->saved_error_routine = get_error_routine();
@@ -4711,11 +4707,11 @@ static int apply_patch(struct apply_state *state,
 	state->update_index = state->check_index && state->apply;
 	if (state->update_index && state->newfd < 0) {
 		if (state->index_file)
-			state->newfd = hold_lock_file_for_update(state->lock_file,
+			state->newfd = hold_lock_file_for_update(&state->lock_file,
 								 state->index_file,
 								 LOCK_DIE_ON_ERROR);
 		else
-			state->newfd = hold_locked_index(state->lock_file, LOCK_DIE_ON_ERROR);
+			state->newfd = hold_locked_index(&state->lock_file, LOCK_DIE_ON_ERROR);
 	}
 
 	if (state->check_index && read_apply_cache(state) < 0) {
@@ -4911,7 +4907,7 @@ int apply_all_patches(struct apply_state *state,
 	}
 
 	if (state->update_index) {
-		res = write_locked_index(&the_index, state->lock_file, COMMIT_LOCK);
+		res = write_locked_index(&the_index, &state->lock_file, COMMIT_LOCK);
 		if (res) {
 			error(_("Unable to write new index file"));
 			res = -128;
@@ -4924,7 +4920,7 @@ int apply_all_patches(struct apply_state *state,
 
 end:
 	if (state->newfd >= 0) {
-		rollback_lock_file(state->lock_file);
+		rollback_lock_file(&state->lock_file);
 		state->newfd = -1;
 	}
 
diff --git a/apply.h b/apply.h
index d9b395770..cf00cda17 100644
--- a/apply.h
+++ b/apply.h
@@ -37,7 +37,7 @@ struct apply_state {
 	const char *prefix;
 
 	/* These are lock_file related */
-	struct lock_file *lock_file;
+	struct lock_file lock_file;
 	int newfd;
 
 	/* These control what gets looked at and modified */
@@ -116,8 +116,7 @@ extern int apply_parse_options(int argc, const char **argv,
 			       int *force_apply, int *options,
 			       const char * const *apply_usage);
 extern int init_apply_state(struct apply_state *state,
-			    const char *prefix,
-			    struct lock_file *lock_file);
+			    const char *prefix);
 extern void clear_apply_state(struct apply_state *state);
 extern int check_apply_state(struct apply_state *state, int force_apply);
 
diff --git a/builtin/am.c b/builtin/am.c
index 4e16fd428..40968428d 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1488,11 +1488,10 @@ static int run_apply(const struct am_state *state, const char *index_file)
 	struct argv_array apply_opts = ARGV_ARRAY_INIT;
 	struct apply_state apply_state;
 	int res, opts_left;
-	static struct lock_file lock_file;
 	int force_apply = 0;
 	int options = 0;
 
-	if (init_apply_state(&apply_state, NULL, &lock_file))
+	if (init_apply_state(&apply_state, NULL))
 		die("BUG: init_apply_state() failed");
 
 	argv_array_push(&apply_opts, "apply");
diff --git a/builtin/apply.c b/builtin/apply.c
index 81b9a61c3..48d398933 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -9,8 +9,6 @@ static const char * const apply_usage[] = {
 	NULL
 };
 
-static struct lock_file lock_file;
-
 int cmd_apply(int argc, const char **argv, const char *prefix)
 {
 	int force_apply = 0;
@@ -18,7 +16,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 	int ret;
 	struct apply_state state;
 
-	if (init_apply_state(&state, prefix, &lock_file))
+	if (init_apply_state(&state, prefix))
 		exit(128);
 
 	argc = apply_parse_options(argc, argv,
-- 
2.14.2.666.gea220ee40

