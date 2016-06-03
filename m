From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 1/2] builtin/apply: add 'lock_file' pointer into 'struct apply_state'
Date: Fri,  3 Jun 2016 18:58:51 +0200
Message-ID: <20160603165852.12399-1-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Fri Jun 03 19:10:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8sRW-0002zE-7M
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 18:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161051AbcFCQ7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 12:59:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36519 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932538AbcFCQ7T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 12:59:19 -0400
Received: by mail-wm0-f67.google.com with SMTP id a20so723137wma.3
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 09:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=yfG29iAQtL5d/vLhbPn030z2EdWUBkfHoib6cUmX4sA=;
        b=ygtUhukqweqragC+uXl0VDovjme3sB6iN+AiODsihttHIt+uPA04orYuo8qnMFIc9b
         jKBUEUraHXv9tAKro9kgUc5HAGG6Fje+7zdnO3P0CrO219PDcQxo3B/QDMSidRxO9xXx
         N1lu+xG5p14DdxNZtHeYpon9q1rQj4xIu+tEq8Q+596lFXDGIoxG81KVG2Obq/TGeAYS
         yev8D3o18AikXMfNa2t6gFr2OtnOFl5MAeGQgShdOJbfEE41WZRbWVKQI+OEkXXZV+08
         zjDrWELFHqy39djr3NMkD1afPJfkElZsR3b7RRODSaoEt95FfM84+qnnlsMfL0cPUYKF
         hPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yfG29iAQtL5d/vLhbPn030z2EdWUBkfHoib6cUmX4sA=;
        b=F4NqwHovW1rim2ol3eRfrHQxhSVWs85xqvmPciRT/J8GABATdo+BpXpqIpie3mmp9E
         6TQHXmbiVYKePcOqqVCQV47byPOzynx5g0rNuLmWfIKV5UIcDReekhngmlAntjR7Aa7c
         ItKW8hwmLGJvt+xoegYcKqWuQT8E4ilu7dyYGsZsxsujsD7h6cKLvG4YZSSkK6ktIIOn
         4QpH4H1dX9rO5LQ9M5rEMl2jApxmvc744LRvYKwd5c9zwblUb2Wgz6+zkSnUIGVR5wtn
         NTcVeYsoZRRMyysZk0jb24TKSF3NtlMfyMULfpq3kAvtX72tvEGt6lo6FNlubX5CWihJ
         BC4A==
X-Gm-Message-State: ALyK8tJLzGmoNJir+8D6LoNxnAFhy01qLnkQ0ha0fuu2BSBL5aHkS5+jDgvsqDcHtCZijA==
X-Received: by 10.28.139.208 with SMTP id n199mr476384wmd.68.1464973157881;
        Fri, 03 Jun 2016 09:59:17 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id ug8sm6596659wjc.42.2016.06.03.09.59.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jun 2016 09:59:16 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc1.5.gfce4374
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296350>

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

from the "libify apply and use lib in am, part 1" patch series.

The changes are the following:

  - The "static struct lock_file lock_file" is not removed anymore.

  - init_apply_state() doesn't allocate a 'struct lock_file' anymore
    when passed a NULL 'struct lock_file' pointer.

  - A check that state->lock_file is not NULL has been added in
    check_apply_state().

  - Title and commit message have been modified to reflect the above
    changes.

This 2 patch long patch series on top of the other unchanged commits
from v3 is available here:

https://github.com/chriscool/git/commits/libify-apply63

 builtin/apply.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 5027f1b..cc635eb 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -52,6 +52,12 @@ struct apply_state {
 	const char *prefix;
 	int prefix_length;
 
+	/*
+	 * Since lockfile.c keeps a linked list of all created
+	 * lock_file structures, it isn't safe to free(lock_file).
+	 */
+	struct lock_file *lock_file;
+
 	/* These control what gets looked at and modified */
 	int apply; /* this is not a dry-run */
 	int cached; /* apply to the index only */
@@ -4547,7 +4553,7 @@ static int apply_patch(struct apply_state *state,
 
 	state->update_index = state->check_index && state->apply;
 	if (state->update_index && newfd < 0)
-		newfd = hold_locked_index(&lock_file, 1);
+		newfd = hold_locked_index(state->lock_file, 1);
 
 	if (state->check_index) {
 		if (read_cache() < 0)
@@ -4648,11 +4654,14 @@ static int option_parse_directory(const struct option *opt,
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
@@ -4705,6 +4714,8 @@ static void check_apply_state(struct apply_state *state, int force_apply)
 	}
 	if (state->check_index)
 		state->unsafe_paths = 0;
+	if (!state->lock_file)
+		die("BUG: state->lock_file should not be NULL");
 }
 
 static int apply_all_patches(struct apply_state *state,
@@ -4769,7 +4780,7 @@ static int apply_all_patches(struct apply_state *state,
 	}
 
 	if (state->update_index) {
-		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+		if (write_locked_index(&the_index, state->lock_file, COMMIT_LOCK))
 			die(_("Unable to write new index file"));
 	}
 
@@ -4852,7 +4863,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	init_apply_state(&state, prefix);
+	init_apply_state(&state, prefix, &lock_file);
 
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
-- 
2.8.2.444.g74f55c9.dirty
