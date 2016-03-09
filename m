From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 16/48] builtin/apply: move 'cached' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:48:44 +0100
Message-ID: <1457545756-20616-17-git-send-email-chriscool@tuxfamily.org>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 18:52:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiHz-0007oT-Cl
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:52:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933712AbcCIRws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:52:48 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33888 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933697AbcCIRwo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:52:44 -0500
Received: by mail-wm0-f43.google.com with SMTP id p65so203114493wmp.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2pH5jx1kccsBv63HsEQzioUie8c0BSFJ4gSjOPjNzYA=;
        b=yiruGlaOmWaFUxRXX2DaqLOuLqClEvII7K11rlSo1Yat/GgAFiynqzvGIfyXo2OUwD
         v58UrExgu8/3EBDxiKdMAuf86JHUNa599Mt/d7tUehIfgPWqD+QDb8fKc2S5YvI+4PCg
         4/chnWB+ZB89L3eDe2iCnFHRcEM9hKCcl4OIq8DkvJE1T32OLjdyTGPAXp0pzyFlm3lY
         Y7c+YifpIaeO9fO0Vej433E5XDn5ZjFFDtlrBz+ubtt6n4qq40WZILnWNHqTNEGJQ7H2
         XOjjFjq3Q/YI76xhaJQqpK9PWUx/z5JA4XIQyphRyES14+kF4VaflAsFVlytWCJ6Wio8
         sWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2pH5jx1kccsBv63HsEQzioUie8c0BSFJ4gSjOPjNzYA=;
        b=a9BG7uVKDqnZHtR18yZiVXDPrNqG9YSbvI2kh9cKaVdmld61L6kCAmMSyqfG3UV70v
         cbdwGtcSNsWRwBn5318vWPZd0V/yXqk6kVkitRUEHsSn6Of9ESqi4ZyATFDEljKXKTUT
         nL6b5nX8vDx79Rp9mv+1Rk5jG6n5NwSFnVFrxTxxr7tlIjz8Fb+Rj9eLb7lQJE13rMt9
         pjHksKQPQz8DVkaCo87geJ7T5q664RGiIp4xG6lsJZZ5dcdXL7KxUhVG0bGD7KERCWJA
         n9hPdUNErEAeUPcEUYtCh4ZhMTrfJeRtSiCDQUBxxMX4UlDrBytxlWymQFWA0K1Hr/M2
         /S5A==
X-Gm-Message-State: AD7BkJJ2nAdP2HT7rSXCTpVPSv0PB8Z/tN3dJQoOib18LqQ3FcZqwOz7a9FMepiaQ4Cb7A==
X-Received: by 10.28.176.200 with SMTP id z191mr336296wme.91.1457545962633;
        Wed, 09 Mar 2016 09:52:42 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:52:41 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288503>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index e3ca5c9..85aa817 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -31,6 +31,9 @@ struct apply_state {
 	int apply_with_reject;
 	int apply_verbosely;
 
+	/* --cached updates only the cache without ever touching the working tree. */
+	int cached;
+
 	/*
 	 *  --check turns on checking that the working tree matches the
 	 *    files that are being modified, but doesn't apply the patch
@@ -49,12 +52,10 @@ struct apply_state {
  *  --stat does just a diffstat, and doesn't actually apply
  *  --numstat does numeric diffstat, and doesn't actually apply
  *  --index-info shows the old and new index info for paths if available.
- *  --cached updates only the cache without ever touching the working tree.
  */
 
 static int p_value = 1;
 static int p_value_known;
-static int cached;
 static int diffstat;
 static int numstat;
 static int summary;
@@ -3274,7 +3275,7 @@ static int load_patch_target(struct apply_state *state,
 			     const char *name,
 			     unsigned expected_mode)
 {
-	if (cached || state->check_index) {
+	if (state->cached || state->check_index) {
 		if (read_file_or_gitlink(ce, buf))
 			return error(_("read of %s failed"), name);
 	} else if (name) {
@@ -3547,7 +3548,7 @@ static int check_preimage(struct apply_state *state,
 		return error(_("path %s has been renamed/deleted"), old_name);
 	if (previous) {
 		st_mode = previous->new_mode;
-	} else if (!cached) {
+	} else if (!state->cached) {
 		stat_ret = lstat(old_name, st);
 		if (stat_ret && errno != ENOENT)
 			return error(_("%s: %s"), old_name, strerror(errno));
@@ -3565,9 +3566,9 @@ static int check_preimage(struct apply_state *state,
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
@@ -3575,7 +3576,7 @@ static int check_preimage(struct apply_state *state,
 		return error(_("%s: %s"), old_name, strerror(errno));
 	}
 
-	if (!cached && !previous)
+	if (!state->cached && !previous)
 		st_mode = ce_mode_from_stat(*ce, st->st_mode);
 
 	if (patch->is_new < 0)
@@ -3613,7 +3614,7 @@ static int check_to_create(struct apply_state *state,
 	    cache_name_pos(new_name, strlen(new_name)) >= 0 &&
 	    !ok_if_exists)
 		return EXISTS_IN_INDEX;
-	if (cached)
+	if (state->cached)
 		return 0;
 
 	if (!lstat(new_name, &nst)) {
@@ -4107,7 +4108,7 @@ static void remove_file(struct apply_state *state, struct patch *patch, int rmdi
 		if (remove_file_from_cache(patch->old_name) < 0)
 			die(_("unable to remove %s from index"), patch->old_name);
 	}
-	if (!cached) {
+	if (!state->cached) {
 		if (!remove_or_warn(patch->old_mode, patch->old_name) && rmdir_empty) {
 			remove_path(patch->old_name);
 		}
@@ -4140,7 +4141,7 @@ static void add_index_file(struct apply_state *state,
 		    get_sha1_hex(s, ce->sha1))
 			die(_("corrupt patch for submodule %s"), path);
 	} else {
-		if (!cached) {
+		if (!state->cached) {
 			if (lstat(path, &st) < 0)
 				die_errno(_("unable to stat newly created file '%s'"),
 					  path);
@@ -4192,9 +4193,13 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
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
@@ -4272,7 +4277,7 @@ static void create_file(struct apply_state *state, struct patch *patch)
 
 	if (!mode)
 		mode = S_IFREG | 0644;
-	create_one_file(path, mode, buf, size);
+	create_one_file(state, path, mode, buf, size);
 
 	if (patch->conflicted_threeway)
 		add_conflicted_stages_file(state, patch);
@@ -4598,7 +4603,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("instead of applying the patch, see if the patch is applicable")),
 		OPT_BOOL(0, "index", &state.check_index,
 			N_("make sure the patch is applicable to the current index")),
-		OPT_BOOL(0, "cached", &cached,
+		OPT_BOOL(0, "cached", &state.cached,
 			N_("apply a patch without touching the working tree")),
 		OPT_BOOL(0, "unsafe-paths", &unsafe_paths,
 			N_("accept a patch that touches outside the working area")),
@@ -4659,7 +4664,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 
 	if (state.apply_with_reject && threeway)
 		die("--reject and --3way cannot be used together.");
-	if (cached && threeway)
+	if (state.cached && threeway)
 		die("--cached and --3way cannot be used together.");
 	if (threeway) {
 		if (is_not_gitdir)
@@ -4672,7 +4677,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		apply = 0;
 	if (state.check_index && is_not_gitdir)
 		die(_("--index outside a repository"));
-	if (cached) {
+	if (state.cached) {
 		if (is_not_gitdir)
 			die(_("--cached outside a repository"));
 		state.check_index = 1;
-- 
2.8.0.rc1.49.gca61272
