From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 1/3] reintroduce PUSH_DEFAULT_UNSPECIFIED
Date: Mon, 20 Jul 2009 08:36:58 +0200
Message-ID: <1248071820-18289-2-git-send-email-bonzini@gnu.org>
References: <1248071820-18289-1-git-send-email-bonzini@gnu.org>
Cc: gitster@pobox.com
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 08:37:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSmVK-0007ck-Bk
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 08:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbZGTGhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 02:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbZGTGhM
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 02:37:12 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:56006 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbZGTGhI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 02:37:08 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1MSmUm-0003in-Iq; Mon, 20 Jul 2009 02:37:08 -0400
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <1248071820-18289-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123573>

With the next patch, the default refspec for push will depend on
whether --current is being used.  Revert part of bba0fd2 (push:
do not give big warning when no preference is configured, 2009-07-18)
to simplify the code.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 builtin-push.c |    1 +
 cache.h        |    1 +
 environment.c  |    2 +-
 3 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 1d92e22..e678a9d 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -69,6 +69,7 @@ static void setup_default_push_refspecs(void)
 	git_config(git_default_config, NULL);
 	switch (push_default) {
 	default:
+	case PUSH_DEFAULT_UNSPECIFIED:
 	case PUSH_DEFAULT_MATCHING:
 		add_refspec(":");
 		break;
diff --git a/cache.h b/cache.h
index c72f125..f1e5ede 100644
--- a/cache.h
+++ b/cache.h
@@ -543,6 +543,7 @@ enum rebase_setup_type {
 };
 
 enum push_default_type {
+	PUSH_DEFAULT_UNSPECIFIED = -1,
 	PUSH_DEFAULT_NOTHING = 0,
 	PUSH_DEFAULT_MATCHING,
 	PUSH_DEFAULT_TRACKING,
diff --git a/environment.c b/environment.c
index 720f26b..801a005 100644
--- a/environment.c
+++ b/environment.c
@@ -42,7 +42,7 @@ enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
-enum push_default_type push_default = PUSH_DEFAULT_MATCHING;
+enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #ifndef OBJECT_CREATION_MODE
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
-- 
1.6.2.5
