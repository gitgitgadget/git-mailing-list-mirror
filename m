From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Fix "config_error_nonbool" used with value instead of key
Date: Sun, 6 Jul 2008 06:10:04 +0200
Message-ID: <20080706061004.22f6c91c.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Brian Hetro <whee@smaertness.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 06:07:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFLWr-00087M-1O
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 06:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbYGFEGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 00:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbYGFEGJ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 00:06:09 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:46474 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710AbYGFEGI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 00:06:08 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 4C8781AB2BB;
	Sun,  6 Jul 2008 06:06:07 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id D6C831AB2B8;
	Sun,  6 Jul 2008 06:06:06 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87494>

The function "config_error_nonbool", that is defined in "config.c",
is used to report an error when a config key in the config file
should have a corresponding value but it hasn't.

So the parameter to this function should be the key and not the
value, because the value is undefined. And it could crash if the
value is used.

This patches fixes two occurences where the value was passed
instead of the key.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-tag.c |    2 +-
 wt-status.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index e675206..3c97c69 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -260,7 +260,7 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "user.signingkey")) {
 		if (!value)
-			return config_error_nonbool(value);
+			return config_error_nonbool(var);
 		set_signingkey(value);
 		return 0;
 	}
diff --git a/wt-status.c b/wt-status.c
index 28c9e63..e7d42d0 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -399,7 +399,7 @@ int git_status_config(const char *k, const char *v, void *cb)
 	}
 	if (!strcmp(k, "status.showuntrackedfiles")) {
 		if (!v)
-			return config_error_nonbool(v);
+			return config_error_nonbool(k);
 		else if (!strcmp(v, "no"))
 			show_untracked_files = SHOW_NO_UNTRACKED_FILES;
 		else if (!strcmp(v, "normal"))
-- 
1.5.6.1.205.gc094f
