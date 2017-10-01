Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4152D20A10
	for <e@80x24.org>; Sun,  1 Oct 2017 14:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751320AbdJAO4z (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 10:56:55 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:47358 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbdJAO4y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 10:56:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id t69so6430345wmt.2
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 07:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xiqnLI5gwK0VhWEWUg5kADr8u8zB3ytxLdKYktIYkCE=;
        b=ePRiLSLk7GvNUv4tr6dHnrQV8Mk0T0bA0J6lWELW3IJNbnidFQyCTjWN62D0WUpBYQ
         6ZG339Z5AAujfhLdUvvlWhwRK69EcGYejk/BlOArvvPIjOnrtbAxfg/8J7p20niQv/6m
         U9DZ9ZUapCP7aHhJJQxXVmAKfCcqzHaTl7f1KctqvAyS9vkDUAu6oEKa/Wac6fXBJQWV
         yoZ+5yvTEklh76ognZ5/Ofi0pQXgYuyqFiVRvHN+PDXohVGPk+OIDvzLjtuavM38yMFM
         vql7C3ucyo7tlEVbpMii1gFVxmfm7k5kTuSYBemwsEcHVUlSN0+B3HPoCSEKQyghEXp8
         imMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xiqnLI5gwK0VhWEWUg5kADr8u8zB3ytxLdKYktIYkCE=;
        b=BswRhD0/VZ707TCzDsj8G4zBDNoPdt6EuXaDAXf3oG3JrNGGwQWnUqmeRTTB0B5dt9
         7XCKjgsyt2fjeFJR24+wKHS/UxN71BAr+tfWHqrAu/fDe3rtiFT5GeK8eFXhPMUU+/Pq
         aJVPSnMHUXvkTBIoe0prhscMBh5Vd0U2Ui+Xbt8GM32mEkkHpbxCtNdsXWcoRxRyB00f
         p/T0DEB2pUHtrv1Yn2peyP/t7SssX/kxRfsh+iKzfzbTuOabJ0TOocA3KAP2X4aOJszW
         2UZx2ke9thu+iuZvfRhJJ68OhhVSrDfFDKy8/V4ivkDO6ga7ypECi98kgx7ks6scXcTk
         RqDA==
X-Gm-Message-State: AMCzsaUgUiVxDAVRcioK/bW9k2ZL0z8zhmhm6ar8pjCiS5KTHT3C2ztB
        R3PatFJ37XoCusBcgKtq6exMxw==
X-Google-Smtp-Source: AOwi7QCD7RYvHg3TY5z8+Dp/S5pwlZhh/eStfmEqtoIIItmiJOP4+DE35J4GhxkeaNUV6RtBurV5pw==
X-Received: by 10.28.238.193 with SMTP id j62mr7389147wmi.44.1506869812619;
        Sun, 01 Oct 2017 07:56:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id w82sm10473516wme.5.2017.10.01.07.56.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Oct 2017 07:56:51 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 06/11] apply: move lockfile into `apply_state`
Date:   Sun,  1 Oct 2017 16:56:07 +0200
Message-Id: <e8b32d47ccc6c3fe3aadd70fdc280fad13f46fd8.1506862824.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.727.g9ddaf86
In-Reply-To: <cover.1506862824.git.martin.agren@gmail.com>
References: <cover.1506862824.git.martin.agren@gmail.com>
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
---
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
2.14.1.727.g9ddaf86

