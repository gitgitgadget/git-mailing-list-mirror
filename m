From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] Rename REFRESH_SAY_CHANGED to REFRESH_IN_PORCELAIN.
Date: Fri, 21 Aug 2009 10:57:58 +0200
Message-ID: <1250845079-30614-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqljlipcs6.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 21 11:01:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MePzm-0007tR-1j
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 11:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755141AbZHUJBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 05:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755109AbZHUJBC
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 05:01:02 -0400
Received: from imag.imag.fr ([129.88.30.1]:53876 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755079AbZHUJBA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 05:01:00 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n7L8w7EU009450
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 21 Aug 2009 10:58:07 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MePwl-000229-EW; Fri, 21 Aug 2009 10:58:07 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MePwl-0000su-C9; Fri, 21 Aug 2009 10:58:07 +0200
X-Mailer: git-send-email 1.6.4.187.gd399.dirty
In-Reply-To: <vpqljlipcs6.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 21 Aug 2009 10:58:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126697>

The change in the output is going to become more general than just saying
"changed", so let's make the variable name more general too.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin-add.c   |    2 +-
 builtin-reset.c |    4 ++--
 cache.h         |    2 +-
 read-cache.c    |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 581a2a1..a325bc9 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -105,7 +105,7 @@ static void refresh(int verbose, const char **pathspec)
 	for (specs = 0; pathspec[specs];  specs++)
 		/* nothing */;
 	seen = xcalloc(specs, 1);
-	refresh_index(&the_index, verbose ? REFRESH_SAY_CHANGED : REFRESH_QUIET,
+	refresh_index(&the_index, verbose ? REFRESH_IN_PORCELAIN : REFRESH_QUIET,
 		      pathspec, seen);
 	for (i = 0; i < specs; i++) {
 		if (!seen[i])
diff --git a/builtin-reset.c b/builtin-reset.c
index 5fa1789..ddf68d5 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -261,7 +261,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			die("Cannot do %s reset with paths.",
 					reset_type_names[reset_type]);
 		return read_from_tree(prefix, argv + i, sha1,
-				quiet ? REFRESH_QUIET : REFRESH_SAY_CHANGED);
+				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
 	}
 	if (reset_type == NONE)
 		reset_type = MIXED; /* by default */
@@ -302,7 +302,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		break;
 	case MIXED: /* Report what has not been updated. */
 		update_index_refresh(0, NULL,
-				quiet ? REFRESH_QUIET : REFRESH_SAY_CHANGED);
+				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
 		break;
 	}
 
diff --git a/cache.h b/cache.h
index 9222774..ae0e83e 100644
--- a/cache.h
+++ b/cache.h
@@ -476,7 +476,7 @@ extern int check_path(const char *path, int len, struct stat *st);
 #define REFRESH_QUIET		0x0004	/* be quiet about it */
 #define REFRESH_IGNORE_MISSING	0x0008	/* ignore non-existent */
 #define REFRESH_IGNORE_SUBMODULES	0x0010	/* ignore submodules */
-#define REFRESH_SAY_CHANGED	0x0020	/* say "changed" not "needs update" */
+#define REFRESH_IN_PORCELAIN	0x0020	/* user friendly output, not "needs update" */
 extern int refresh_index(struct index_state *, unsigned int flags, const char **pathspec, char *seen);
 
 struct lock_file {
diff --git a/read-cache.c b/read-cache.c
index 4e3e272..f1aff81 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1077,7 +1077,7 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 	unsigned int options = really ? CE_MATCH_IGNORE_VALID : 0;
 	const char *needs_update_message;
 
-	needs_update_message = ((flags & REFRESH_SAY_CHANGED)
+	needs_update_message = ((flags & REFRESH_IN_PORCELAIN)
 				? "locally modified" : "needs update");
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce, *new;
-- 
1.6.4.187.gd399.dirty
