From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 2/2] builtin/apply: move 'newfd' global into 'struct apply_state'
Date: Mon,  6 Jun 2016 11:56:58 +0200
Message-ID: <20160606095658.1815-2-chriscool@tuxfamily.org>
References: <20160606095658.1815-1-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Mon Jun 06 11:57:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9rIA-00061e-HA
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 11:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbcFFJ5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 05:57:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32968 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbcFFJ5t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 05:57:49 -0400
Received: by mail-wm0-f68.google.com with SMTP id c74so6874157wme.0
        for <git@vger.kernel.org>; Mon, 06 Jun 2016 02:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bCac2IltVTFmQ4Hz2Lj4bRbuSogMfDBWsBUiIQ1Rh1w=;
        b=jS4L+m3wRPR1K0wSfpJ76ZnMMUkV4N2CjntGxGGIkTn363Ozosp1YjgR3uf963bu7I
         sXdIW7lmDLelfGLdIW2wz3VLkPfcCTzfjEhFsNWmJe12jTjQz6cnAV5JzZ/i9FABiLH7
         2DmbKUHZkj3+KXzfNHgwUCpM1Hf/Wl61fO1iPekgbdlbvzwIHfR3u9YKeIB5pCfU8xfp
         EbSn3iLF2KIA1fD6qfIQc47R17hmsSjiCwgcGIRJHNpLXh2O697wvZZHVDmnk9r8/uyU
         OhRJsEnY6waCSpt/aKV7AE5rcHTCb+o0YJj6c3ccnQucldndHVs04acYd/oZbd5/jk89
         FZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bCac2IltVTFmQ4Hz2Lj4bRbuSogMfDBWsBUiIQ1Rh1w=;
        b=F/lUIG0zEIEeX5ReQtqH2lYoTfloZDnrQTKF9S1sGbrZIpIbtJ3nd4w3rK8X66LIbw
         Q/P6uZ0kkfwv8bY/5niAqZkG9sZyAXHnHUZXATOZHY9574PF0+7CuPu5uFSEuHtRQM7i
         yD6luvMFPWkQI3WKMUcyPvbZ5VWOV7GYaRhHzyWGdnUknuvVMU04To8TB9V0QjztASHj
         ad9vIHEp76ekjOrn2/L/KsV7lcUUykuhrOxGiZEA/vBFjkKAYORYO5xQ8Gn+LxWDckWl
         TLdkMYlxO1l1YKCJiTaBYltTjiY3Yhhq1ECtUPRUvSj5HUQXw0vjpryIRSKVuYfKkJHa
         T47w==
X-Gm-Message-State: ALyK8tKwtCvUJziKo/W7rJzFrlYKBCJZynmSflVi/v6llCrw9BDIeE7PhwHWXRq26JG0Eg==
X-Received: by 10.194.102.202 with SMTP id fq10mr14504105wjb.153.1465207067811;
        Mon, 06 Jun 2016 02:57:47 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id q189sm13325568wmd.19.2016.06.06.02.57.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jun 2016 02:57:46 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.445.g4623162
In-Reply-To: <20160606095658.1815-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296491>

From: Christian Couder <christian.couder@gmail.com>

To libify the apply functionality the 'newfd' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

This is to replace:

"[PATCH v3 49/49] builtin/apply: move 'newfd' global into 'struct apply_state'"

from the "libify apply and use lib in am, part 1" patch series, and

"[PATCH v4 2/2] builtin/apply: move 'newfd' global into 'struct apply_state'"

that was sent previously to replace v3 49/49 above.

There is no change compared to both previous version except that this
patch should apply cleanly on top of PATCH v5 1/2.

 builtin/apply.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index bbe0df1..b3eb704 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -54,6 +54,7 @@ struct apply_state {
 
 	/* These are lock_file related */
 	struct lock_file *lock_file;
+	int newfd;
 
 	/* These control what gets looked at and modified */
 	int apply; /* this is not a dry-run */
@@ -117,8 +118,6 @@ struct apply_state {
 	int applied_after_fixing_ws;
 };
 
-static int newfd = -1;
-
 static const char * const apply_usage[] = {
 	N_("git apply [<options>] [<patch>...]"),
 	NULL
@@ -4549,8 +4548,8 @@ static int apply_patch(struct apply_state *state,
 		state->apply = 0;
 
 	state->update_index = state->check_index && state->apply;
-	if (state->update_index && newfd < 0)
-		newfd = hold_locked_index(state->lock_file, 1);
+	if (state->update_index && state->newfd < 0)
+		state->newfd = hold_locked_index(state->lock_file, 1);
 
 	if (state->check_index) {
 		if (read_cache() < 0)
@@ -4659,6 +4658,7 @@ static void init_apply_state(struct apply_state *state,
 	state->prefix = prefix;
 	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
 	state->lock_file = lock_file;
+	state->newfd = -1;
 	state->apply = 1;
 	state->line_termination = '\n';
 	state->p_value = 1;
@@ -4779,6 +4779,7 @@ static int apply_all_patches(struct apply_state *state,
 	if (state->update_index) {
 		if (write_locked_index(&the_index, state->lock_file, COMMIT_LOCK))
 			die(_("Unable to write new index file"));
+		state->newfd = -1;
 	}
 
 	return !!errs;
-- 
2.8.2.445.g4623162
