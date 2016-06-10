From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 06/44] builtin/apply: make parse_single_patch() return -1 on error
Date: Fri, 10 Jun 2016 22:10:40 +0200
Message-ID: <20160610201118.13813-7-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:12:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSmc-00039B-5v
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973AbcFJULv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:11:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34850 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917AbcFJULt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:11:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id k184so1047144wme.2
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9aqdqCYvG75HKXYZpKfPKPFPQgVmwk7PmO421t85M+Y=;
        b=OBR188V7WBjRkVpKEnaOupoty9AelUm/m9nAejRqJ8csn+7e/O/YNK5t7Ky8cpLVQi
         dI1GQan1YOKJfz6d5LKJlBus8H5jIqUun8xHXKq7XkaFoO/9rF4KpFVwPW3gmYiHb0BY
         eKIrhyhUWupQ5eLKCRwggg0E3CHM9wJiu9LBuzsaz0yhk0ZezevSbs4Ka9WP5Siwkfs8
         4UvDIihk6RLPXcvEOnMUfQmb4Z/pCoOydqEhJIgSi+60wFBPZr1x+kA+IJF5TMiEA+iD
         LfMeL8vyMXQ8SB424KcSJN48Xil4Dcp7gT4eRWCt0CCTZHGRyTkB6pZB53b8Oo0YniuW
         3Mjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9aqdqCYvG75HKXYZpKfPKPFPQgVmwk7PmO421t85M+Y=;
        b=bunpOvzVSetU7g8zU9sNbxPrMEKG86DWVoCnOFSKyFHQdzRhk+V/rWXGhMv5opz+fM
         vmroBQW5U6sdT1IkKRKeex17sxYop8Upm6VyZCmlqbl5frFpE/G8RwFXQYu++DQaw2Ic
         I/amLlk3KVOS4Izn7FDQtUfgsgQ5fKGCcNZ0psNStQz0pYwm53/35HOwOVRsA1uvB71Y
         aTCPNDoy2FtqOkZptEa5CzP5NXcxYnlbwA3HonX9QxEb2SG2SOa9D97vvCAm9j6x9BuI
         Asbh33dZtVlZL5mGxNCTNErCMAIEa3l/N0mjR5vNo/n63jdRMKX4EZIKhVujHQ/BB4tC
         e0Kw==
X-Gm-Message-State: ALyK8tKfFP2elD8cEyOKjUHze1ftucbLfHQLklpzgcb8rcHubXy863lY6Po3i6mQMvUQ9A==
X-Received: by 10.194.246.129 with SMTP id xw1mr3775731wjc.142.1465589508094;
        Fri, 10 Jun 2016 13:11:48 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.11.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:11:47 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297027>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in builtin/apply.c, parse_single_patch() should return -1 instead of
calling die().

Let's do that by using error() and let's adjust the related test
cases accordingly.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c        | 17 +++++++++++++----
 t/t4012-diff-binary.sh |  4 ++--
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index a160338..2671586 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1666,6 +1666,10 @@ static int parse_fragment(struct apply_state *state,
  *
  * The (fragment->patch, fragment->size) pair points into the memory given
  * by the caller, not a copy, when we return.
+ *
+ * Returns:
+ *   -1 in case of error,
+ *   the number of bytes in the patch otherwise.
  */
 static int parse_single_patch(struct apply_state *state,
 			      const char *line,
@@ -1683,8 +1687,10 @@ static int parse_single_patch(struct apply_state *state,
 		fragment = xcalloc(1, sizeof(*fragment));
 		fragment->linenr = state->linenr;
 		len = parse_fragment(state, line, size, patch, fragment);
-		if (len <= 0)
-			die(_("corrupt patch at line %d"), state->linenr);
+		if (len <= 0) {
+			free(fragment);
+			return error(_("corrupt patch at line %d"), state->linenr);
+		}
 		fragment->patch = line;
 		fragment->size = len;
 		oldlines += fragment->oldlines;
@@ -1720,9 +1726,9 @@ static int parse_single_patch(struct apply_state *state,
 		patch->is_delete = 0;
 
 	if (0 < patch->is_new && oldlines)
-		die(_("new file %s depends on old contents"), patch->new_name);
+		return error(_("new file %s depends on old contents"), patch->new_name);
 	if (0 < patch->is_delete && newlines)
-		die(_("deleted file %s still has contents"), patch->old_name);
+		return error(_("deleted file %s still has contents"), patch->old_name);
 	if (!patch->is_delete && !newlines && context)
 		fprintf_ln(stderr,
 			   _("** warning: "
@@ -2024,6 +2030,9 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 				       size - offset - hdrsize,
 				       patch);
 
+	if (patchsize < 0)
+		return -1;
+
 	if (!patchsize) {
 		static const char git_binary[] = "GIT binary patch\n";
 		int hd = hdrsize + offset;
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 643d729..0a8af76 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -68,7 +68,7 @@ test_expect_success C_LOCALE_OUTPUT 'apply detecting corrupt patch correctly' '
 	sed -e "s/-CIT/xCIT/" <output >broken &&
 	test_must_fail git apply --stat --summary broken 2>detected &&
 	detected=$(cat detected) &&
-	detected=$(expr "$detected" : "fatal.*at line \\([0-9]*\\)\$") &&
+	detected=$(expr "$detected" : "error.*at line \\([0-9]*\\)\$") &&
 	detected=$(sed -ne "${detected}p" broken) &&
 	test "$detected" = xCIT
 '
@@ -77,7 +77,7 @@ test_expect_success C_LOCALE_OUTPUT 'apply detecting corrupt patch correctly' '
 	git diff --binary | sed -e "s/-CIT/xCIT/" >broken &&
 	test_must_fail git apply --stat --summary broken 2>detected &&
 	detected=$(cat detected) &&
-	detected=$(expr "$detected" : "fatal.*at line \\([0-9]*\\)\$") &&
+	detected=$(expr "$detected" : "error.*at line \\([0-9]*\\)\$") &&
 	detected=$(sed -ne "${detected}p" broken) &&
 	test "$detected" = xCIT
 '
-- 
2.9.0.rc2.362.g3cd93d0
