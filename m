From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 19/40] builtin/apply: make remove_file() return -1 on error
Date: Mon, 13 Jun 2016 18:09:21 +0200
Message-ID: <20160613160942.1806-20-chriscool@tuxfamily.org>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 18:11:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCUSq-0004h1-7C
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425002AbcFMQLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:11:36 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35954 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424871AbcFMQKY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:24 -0400
Received: by mail-wm0-f65.google.com with SMTP id m124so15999047wme.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J/i6hD7ntnF+zft2wFkj8XpDaYlVuFTdVHisTYMy4Rw=;
        b=KlIt25zwCVi/VFQ3s9QuXeiSkjNQgEmfhfN4LBigKj9fOBgvwZZsfYd0b8EAZVIqs7
         /SZCQ5ZDJffDAvQO8lL0KRfpJeMRuOJBxpsv38CaULiiZlWenv0WmIOtkRxNuJz3II9W
         bmiOlwUEWzvkQggmxr2D0LXnK0VtTSg/KLCujqyFJoHpHdgeez2gufheYZDnqWwdzykO
         Py1R2lNshv3vZ6Im8VQtyqsXRFnx+SQQFABDID+C4stvl4BomPm2xBv4xRbJU/5Jdenv
         CmgVcjbNlZVVkUYjAHyEFHuvzVMEAEcUc5PwClG5CG9/no5T2gc+RbInQxOzvGce0Xt8
         Jf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J/i6hD7ntnF+zft2wFkj8XpDaYlVuFTdVHisTYMy4Rw=;
        b=Y2t/kQ9kwtwVmByraWQ4lbNiTiGfA4C+3ASMl8Khc2bDyZJq8JhxHoNZZrxMDOTccB
         nTL64D2/I00nbv3xvKXMBC8fEqyx6/zOiS+lvJGHXbIygbf7wt4oC5uZxYyvIui6WV3Q
         iBmRA+CKGvIu0dpb/nfPVICaBhnqHPv0/VkmufgKQ3jNu8+ByMOwcH4Gem+58hOQfA1s
         DNvyD0KqXc5gGesX8wA+nKAcNHpizD/5ljWl3n4nFI8kyY2D2JR/oZ74Zzz1EEEhYJm/
         0lpHZk5pW67pwNpS8mTDWyC84lj0k5vRC76UDkD/8ySTuApBrqouEcbnkZQhKbix04EH
         xrTw==
X-Gm-Message-State: ALyK8tJDY+7DpkEGWHcAiyrKsZ8hb/Furq5pZ/EdqTpWfLTGseh2+cqUMxHgoGHvGeD1bw==
X-Received: by 10.194.242.163 with SMTP id wr3mr1878483wjc.1.1465834222739;
        Mon, 13 Jun 2016 09:10:22 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:22 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297228>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", remove_file() should return -1 instead of
calling die().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index e74b068..694c65b 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4074,17 +4074,18 @@ static void patch_stats(struct apply_state *state, struct patch *patch)
 	}
 }
 
-static void remove_file(struct apply_state *state, struct patch *patch, int rmdir_empty)
+static int remove_file(struct apply_state *state, struct patch *patch, int rmdir_empty)
 {
 	if (state->update_index) {
 		if (remove_file_from_cache(patch->old_name) < 0)
-			die(_("unable to remove %s from index"), patch->old_name);
+			return error(_("unable to remove %s from index"), patch->old_name);
 	}
 	if (!state->cached) {
 		if (!remove_or_warn(patch->old_mode, patch->old_name) && rmdir_empty) {
 			remove_path(patch->old_name);
 		}
 	}
+	return 0;
 }
 
 static void add_index_file(struct apply_state *state,
@@ -4263,8 +4264,10 @@ static void write_out_one_result(struct apply_state *state,
 				 int phase)
 {
 	if (patch->is_delete > 0) {
-		if (phase == 0)
-			remove_file(state, patch, 1);
+		if (phase == 0) {
+			if (remove_file(state, patch, 1))
+				exit(1);
+		}
 		return;
 	}
 	if (patch->is_new > 0 || patch->is_copy) {
@@ -4276,8 +4279,10 @@ static void write_out_one_result(struct apply_state *state,
 	 * Rename or modification boils down to the same
 	 * thing: remove the old, write the new
 	 */
-	if (phase == 0)
-		remove_file(state, patch, patch->is_rename);
+	if (phase == 0) {
+		if (remove_file(state, patch, patch->is_rename))
+			exit(1);
+	}
 	if (phase == 1)
 		create_file(state, patch);
 }
-- 
2.9.0.rc2.411.g3e2ca28
