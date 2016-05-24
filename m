From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 18/49] builtin/apply: move 'cached' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:10:55 +0200
Message-ID: <20160524081126.16973-19-chriscool@tuxfamily.org>
References: <20160524081126.16973-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 10:15:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57VO-00024m-1T
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905AbcEXIPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:15:54 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34562 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932280AbcEXIMM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id n129so3658667wmn.1
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sTucQkinmzdSTYm34ULU3LITetU6XXWmnftRLB0by1k=;
        b=xH9D1ZWlk7VQFWcs16Fibv4QD4gsdkeBae5geLy+XWNvYQlDXGwiat9tJIOyy/Oqzx
         vyjGVOhy/w63Bt/2S8392pynmAulvwXuytsJ1Vb1uRjVGjxNSQ12EvnTGnTp/uUVDJFO
         z9E2txfA6Xbo3Q4hhrBEeaXZg9KZw1hyFS6OgFkDqjCuoS+zQXoxh9qhO3dqzSnWKk3I
         f3ccEI4V2bCk5wLzE8V4M6pIDlO4+/xEfsJCV2LqhJTEb6C4R4EL139ZskpswO6Dj7oG
         5tnsVwIDRCZ2NizlNJu+tPqWnWGieMb0BPtVzTjaXJbgdfDXymoOoyfZU9S8qq6S+N1s
         0qQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sTucQkinmzdSTYm34ULU3LITetU6XXWmnftRLB0by1k=;
        b=a/25BhWvBcohR9iA+9yQ5bZ64sJgXQYRl8WPXXEp8gRwecac5LzX8E/jRdCbbphEOz
         l+NFF9LTLHThWsKBkWs82G+8xanv3qBDj8pFCa9C41qli31M5ZgMBd0uWmfmLknRDeJd
         totU2eZb7SKJIySBwKkzJuI+OCnnQWd4O0WvqGuQVa9Jm4FyibInUOUxJNFzHT6v1moY
         BCyIl87fGerPIuNIhsDunCDyK4mo1TsoatkDmCv2B8UzPDzcYTRHCrltPvc9NHpvuWah
         7spzy5/oh/ZGgByU1ZUmfwuhhLhSnBI48hJ9jXC9/IMGYFLUDp5eNRqNFNtMLP4Ku82F
         NGUw==
X-Gm-Message-State: AOPr4FUQgBLgr/KqH9HQoSp5MiSq5dhZV8nEqpr6wbBSdQUNmrfwGEYJaEeB7Mk6SvkF1A==
X-Received: by 10.28.230.137 with SMTP id e9mr22811397wmi.0.1464077531018;
        Tue, 24 May 2016 01:12:11 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:10 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295468>

To libify the apply functionality the 'cached' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index ad3bec4..9cba460 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -26,6 +26,7 @@ struct apply_state {
 	int prefix_length;
 
 	/* These control what gets looked at and modified */
+	int cached; /* apply to the index only */
 	int check; /* preimage must match working tree, don't actually apply */
 	int check_index; /* preimage must match the indexed version */
 	int update_index; /* check_index && apply */
@@ -42,13 +43,11 @@ struct apply_state {
  *  --stat does just a diffstat, and doesn't actually apply
  *  --numstat does numeric diffstat, and doesn't actually apply
  *  --index-info shows the old and new index info for paths if available.
- *  --cached updates only the cache without ever touching the working tree.
  */
 static int newfd = -1;
 
 static int state_p_value = 1;
 static int p_value_known;
-static int cached;
 static int diffstat;
 static int numstat;
 static int summary;
@@ -3264,7 +3263,7 @@ static int load_patch_target(struct apply_state *state,
 			     const char *name,
 			     unsigned expected_mode)
 {
-	if (cached || state->check_index) {
+	if (state->cached || state->check_index) {
 		if (read_file_or_gitlink(ce, buf))
 			return error(_("read of %s failed"), name);
 	} else if (name) {
@@ -3537,7 +3536,7 @@ static int check_preimage(struct apply_state *state,
 		return error(_("path %s has been renamed/deleted"), old_name);
 	if (previous) {
 		st_mode = previous->new_mode;
-	} else if (!cached) {
+	} else if (!state->cached) {
 		stat_ret = lstat(old_name, st);
 		if (stat_ret && errno != ENOENT)
 			return error(_("%s: %s"), old_name, strerror(errno));
@@ -3555,9 +3554,9 @@ static int check_preimage(struct apply_state *state,
 			if (checkout_target(&the_index, *ce, st))
 				return -1;
 		}
-		if (!cached && verify_index_match(*ce, st))
+		if (!state->cached && verify_index_match(*ce, st))
 			return error(_("%s: does not match index"), old_name);
-		if (cached)
+		if (state->cached)
 			st_mode = (*ce)->ce_mode;
 	} else if (stat_ret < 0) {
 		if (patch->is_new < 0)
@@ -3565,7 +3564,7 @@ static int check_preimage(struct apply_state *state,
 		return error(_("%s: %s"), old_name, strerror(errno));
 	}
 
-	if (!cached && !previous)
+	if (!state->cached && !previous)
 		st_mode = ce_mode_from_stat(*ce, st->st_mode);
 
 	if (patch->is_new < 0)
@@ -3603,7 +3602,7 @@ static int check_to_create(struct apply_state *state,
 	    cache_name_pos(new_name, strlen(new_name)) >= 0 &&
 	    !ok_if_exists)
 		return EXISTS_IN_INDEX;
-	if (cached)
+	if (state->cached)
 		return 0;
 
 	if (!lstat(new_name, &nst)) {
@@ -4097,7 +4096,7 @@ static void remove_file(struct apply_state *state, struct patch *patch, int rmdi
 		if (remove_file_from_cache(patch->old_name) < 0)
 			die(_("unable to remove %s from index"), patch->old_name);
 	}
-	if (!cached) {
+	if (!state->cached) {
 		if (!remove_or_warn(patch->old_mode, patch->old_name) && rmdir_empty) {
 			remove_path(patch->old_name);
 		}
@@ -4130,7 +4129,7 @@ static void add_index_file(struct apply_state *state,
 		    get_sha1_hex(s, ce->sha1))
 			die(_("corrupt patch for submodule %s"), path);
 	} else {
-		if (!cached) {
+		if (!state->cached) {
 			if (lstat(path, &st) < 0)
 				die_errno(_("unable to stat newly created file '%s'"),
 					  path);
@@ -4182,9 +4181,13 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
  * which is true 99% of the time anyway. If they don't,
  * we create them and try again.
  */
-static void create_one_file(char *path, unsigned mode, const char *buf, unsigned long size)
+static void create_one_file(struct apply_state *state,
+			    char *path,
+			    unsigned mode,
+			    const char *buf,
+			    unsigned long size)
 {
-	if (cached)
+	if (state->cached)
 		return;
 	if (!try_create_file(path, mode, buf, size))
 		return;
@@ -4262,7 +4265,7 @@ static void create_file(struct apply_state *state, struct patch *patch)
 
 	if (!mode)
 		mode = S_IFREG | 0644;
-	create_one_file(path, mode, buf, size);
+	create_one_file(state, path, mode, buf, size);
 
 	if (patch->conflicted_threeway)
 		add_conflicted_stages_file(state, patch);
@@ -4611,7 +4614,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 			N_("instead of applying the patch, see if the patch is applicable")),
 		OPT_BOOL(0, "index", &state.check_index,
 			N_("make sure the patch is applicable to the current index")),
-		OPT_BOOL(0, "cached", &cached,
+		OPT_BOOL(0, "cached", &state.cached,
 			N_("apply a patch without touching the working tree")),
 		OPT_BOOL(0, "unsafe-paths", &unsafe_paths,
 			N_("accept a patch that touches outside the working area")),
@@ -4663,7 +4666,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 
 	if (state.apply_with_reject && threeway)
 		die("--reject and --3way cannot be used together.");
-	if (cached && threeway)
+	if (state.cached && threeway)
 		die("--cached and --3way cannot be used together.");
 	if (threeway) {
 		if (is_not_gitdir)
@@ -4676,7 +4679,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 		apply = 0;
 	if (state.check_index && is_not_gitdir)
 		die(_("--index outside a repository"));
-	if (cached) {
+	if (state.cached) {
 		if (is_not_gitdir)
 			die(_("--cached outside a repository"));
 		state.check_index = 1;
-- 
2.8.3.443.gaeee61e
