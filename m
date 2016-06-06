From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 1/2] builtin/apply: add 'lock_file' pointer into 'struct apply_state'
Date: Mon,  6 Jun 2016 11:56:57 +0200
Message-ID: <20160606095658.1815-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 11:57:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9rI9-00061e-Vp
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 11:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbcFFJ5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 05:57:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34835 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbcFFJ5m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 05:57:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id k184so8695544wme.2
        for <git@vger.kernel.org>; Mon, 06 Jun 2016 02:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=lh5Rw4QbcDCr68VOdsXHCsT0m7aXyYECwQkFYO1j+rs=;
        b=fEmmY9Afx1qji9SZDFeJNagbUblGKejiRmsspWGQrTOi8pkvMSrYpQsFDt+89LskTm
         tPfJVXEmaAKFJoFXu1jn5Av8P4nvabnPODYDPaWh6KT7vSYggNAotIq0JXp6u73o49dL
         m91aq5kXuKSlbr85nxaVNsQzGsaxO3wubzn1AYkcj9B0QpSQzAA6+SKVvcdkPJLDJdPs
         xYCqNjXISixSIigUb2X2SpAsx5UN9DwR75pT9+wsnGT7Nr+ZZPmj6RzVJUiM8bg3cjRb
         pOBF5q9KdOppuMSt8QVxiR//F/2gqZF4xLl4yq2hdymck5km0qQi/ClfhHG4/82PmzH1
         8h0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lh5Rw4QbcDCr68VOdsXHCsT0m7aXyYECwQkFYO1j+rs=;
        b=gfdrn3j58xidwfrAjKbMvGsbm+sfCfXQB+Yz2lJFwFGzpyhOqZP/HMZ2YcAlB8LrV/
         mco1rHt1tTo5E8vrXZ5JWy/zYSVcv/Na8UjzAsSEuqnDChFs6eQKk9x2pgqR0LcmVYaN
         MHAS6+MJWNlJtUtZUZTHoU8wag/9e7hZUi+QB+vwgU09QI8bPHk/q/BRuwjNgbtEyy8x
         Cla0hEjC6rWTaRsaZ1qlH1bGhQtxpdWJUZscXkNqSbK9nrg7y13foO+Bex4reNBviejp
         fiYAYnDZvsjg6dzDhPmmLJ0ycBd9oKyLoC0t1IDhlybtdbuEImVSj3mJLhim3Lz0A/ct
         Eq2Q==
X-Gm-Message-State: ALyK8tLUB5VbOBAfMXRdAH6bel7gofs20Cug/dxrlXMr0xwputFj7vIPwtA85sApRLdfSg==
X-Received: by 10.194.92.113 with SMTP id cl17mr14762350wjb.176.1465207061139;
        Mon, 06 Jun 2016 02:57:41 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id q189sm13325568wmd.19.2016.06.06.02.57.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jun 2016 02:57:40 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.445.g4623162
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296490>

From: Christian Couder <christian.couder@gmail.com>

We cannot have a 'struct lock_file' allocated on the stack, as lockfile.c
keeps a linked list of all created lock_file structures.

Also 'struct apply_state' users might later want the same 'struct lock_file'
instance to be reused by different series of calls to the apply api.

So let's add a 'struct lock_file *lock_file' pointer into 'struct apply_state'
and have the user of 'struct apply_state' allocate memory for the actual
'struct lock_file' instance.

Let's also add an argument to init_apply_state(), so that the caller can
easily supply a pointer to the allocated instance.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

This is to replace:

"[PATCH v3 48/49] builtin/apply: move 'lock_file' global into 'struct apply_state'"

from the "libify apply and use lib in am, part 1" patch series, and

"[PATCH v4 1/2] builtin/apply: add 'lock_file' pointer into 'struct apply_state'"

that was sent previously to replace v3 48/49 above.

See: http://thread.gmane.org/gmane.comp.version-control.git/296350/

The only change compared to v4 1/2 is that the comment above 'struct
lock_file *lock_file' in 'struct apply_state' has been replaced with a
much shorter one.

This 2 patch long patch series on top of the other unchanged commits
from v3 is available here:

https://github.com/chriscool/git/commits/libify-apply64

 builtin/apply.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 5027f1b..bbe0df1 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -52,6 +52,9 @@ struct apply_state {
 	const char *prefix;
 	int prefix_length;
 
+	/* These are lock_file related */
+	struct lock_file *lock_file;
+
 	/* These control what gets looked at and modified */
 	int apply; /* this is not a dry-run */
 	int cached; /* apply to the index only */
@@ -4547,7 +4550,7 @@ static int apply_patch(struct apply_state *state,
 
 	state->update_index = state->check_index && state->apply;
 	if (state->update_index && newfd < 0)
-		newfd = hold_locked_index(&lock_file, 1);
+		newfd = hold_locked_index(state->lock_file, 1);
 
 	if (state->check_index) {
 		if (read_cache() < 0)
@@ -4648,11 +4651,14 @@ static int option_parse_directory(const struct option *opt,
 	return 0;
 }
 
-static void init_apply_state(struct apply_state *state, const char *prefix)
+static void init_apply_state(struct apply_state *state,
+			     const char *prefix,
+			     struct lock_file *lock_file)
 {
 	memset(state, 0, sizeof(*state));
 	state->prefix = prefix;
 	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
+	state->lock_file = lock_file;
 	state->apply = 1;
 	state->line_termination = '\n';
 	state->p_value = 1;
@@ -4705,6 +4711,8 @@ static void check_apply_state(struct apply_state *state, int force_apply)
 	}
 	if (state->check_index)
 		state->unsafe_paths = 0;
+	if (!state->lock_file)
+		die("BUG: state->lock_file should not be NULL");
 }
 
 static int apply_all_patches(struct apply_state *state,
@@ -4769,7 +4777,7 @@ static int apply_all_patches(struct apply_state *state,
 	}
 
 	if (state->update_index) {
-		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+		if (write_locked_index(&the_index, state->lock_file, COMMIT_LOCK))
 			die(_("Unable to write new index file"));
 	}
 
@@ -4852,7 +4860,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	init_apply_state(&state, prefix);
+	init_apply_state(&state, prefix, &lock_file);
 
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
-- 
2.8.2.445.g4623162
