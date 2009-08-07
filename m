From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] Rename REFRESH_SAY_CHANGED to REFRESH_IN_PORCELAIN.
Date: Fri,  7 Aug 2009 22:24:35 +0200
Message-ID: <1249676676-5051-1-git-send-email-Matthieu.Moy@imag.fr>
References: <7vvdl0kau4.fsf@alter.siamese.dyndns.org>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 07 22:25:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZVzw-0005Bg-O4
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 22:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933742AbZHGUZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 16:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933732AbZHGUY7
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 16:24:59 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33009 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933688AbZHGUY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 16:24:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n77KNr1b017377
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 7 Aug 2009 22:23:53 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MZVza-0007Pb-Gz; Fri, 07 Aug 2009 22:24:46 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MZVza-0004lF-Fk; Fri, 07 Aug 2009 22:24:46 +0200
X-Mailer: git-send-email 1.6.4.62.g39c83.dirty
In-Reply-To: <7vvdl0kau4.fsf@alter.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 07 Aug 2009 22:23:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n77KNr1b017377
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1250281433.7344@cGMJHq1y3tucl1kLuWvthw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125218>

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
index e6c7f33..a2f2923 100644
--- a/cache.h
+++ b/cache.h
@@ -473,7 +473,7 @@ extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
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
1.6.4.62.g39c83.dirty
