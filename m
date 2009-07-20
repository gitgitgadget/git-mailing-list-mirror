From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH RFC 1/8] reintroduce PUSH_DEFAULT_UNSPECIFIED
Date: Mon, 20 Jul 2009 19:49:48 +0200
Message-ID: <1248112195-3761-2-git-send-email-bonzini@gnu.org>
References: <1248112195-3761-1-git-send-email-bonzini@gnu.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 19:50:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSx08-0005Xp-Tg
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 19:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061AbZGTRuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 13:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752957AbZGTRuD
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 13:50:03 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:56550 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855AbZGTRuB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 13:50:01 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1MSwzx-00032g-2R
	for git@vger.kernel.org; Mon, 20 Jul 2009 13:50:01 -0400
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <1248112195-3761-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123623>

This is just the first patch from the push --current series.  It
is the only one needed as a prerequisite for these patches, at
least to get as far as writing the configuration in .git/config.

Not-signed-off-for-this-rfc-by: Paolo Bonzini <bonzini@gnu.org>
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
index dbe460c..f10513f 100644
--- a/cache.h
+++ b/cache.h
@@ -544,6 +544,7 @@ enum rebase_setup_type {
 };
 
 enum push_default_type {
+	PUSH_DEFAULT_UNSPECIFIED = -1,
 	PUSH_DEFAULT_NOTHING = 0,
 	PUSH_DEFAULT_MATCHING,
 	PUSH_DEFAULT_TRACKING,
diff --git a/environment.c b/environment.c
index 95aa8a6..4b68109 100644
--- a/environment.c
+++ b/environment.c
@@ -46,7 +46,7 @@ struct tracking_config git_branch_track = {
 	AUTOREBASE_NEVER,
 	0
 };
-enum push_default_type push_default = PUSH_DEFAULT_MATCHING;
+enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #ifndef OBJECT_CREATION_MODE
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
-- 
1.6.2.5
