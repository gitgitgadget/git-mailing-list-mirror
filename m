From: drafnel@gmail.com
Subject: [PATCH 2/3] git-gc: always use -A when manually repacking
Date: Fri,  9 May 2008 23:01:56 -0500
Message-ID: <11461522.1210392051144.JavaMail.teamon@b303.teamon.com>
References: <7vabj0b1re.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat May 10 06:02:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JugHc-00005I-WC
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 06:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbYEJEAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 00:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbYEJEAy
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 00:00:54 -0400
Received: from mailproxy03.teamon.com ([64.85.68.139]:44561 "EHLO
	b303.teamon.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750764AbYEJEAx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 00:00:53 -0400
Received: from b303.teamon.com (localhost [127.0.0.1])
	by b303.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id m4A40pU18409;
	Sat, 10 May 2008 04:00:51 GMT
X-Mailer: git-send-email 1.5.5.67.g9a49
In-Reply-To: <7vabj0b1re.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81646>

From: Brandon Casey <drafnel@gmail.com>

Now that repack -A will leave unreferenced objects unpacked, there is
no reason to use the -a option to repack (which will discard unreferenced
objects). The unpacked unreferenced objects will not be repacked by a
subsequent repack, and will eventually be pruned by git-gc based on the
gc.pruneExpire config option.
---
 builtin-gc.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index f99ebc7..6db2f51 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -256,17 +256,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			"performance. You may also\n"
 			"run \"git gc\" manually. See "
 			"\"git help gc\" for more information.\n");
-	} else {
-		/*
-		 * Use safer (for shared repos) "-A" option to
-		 * repack when not pruning. Auto-gc makes its
-		 * own decision.
-		 */
-		if (prune)
-			append_option(argv_repack, "-a", MAX_ADD);
-		else
-			append_option(argv_repack, "-A", MAX_ADD);
-	}
+	} else
+		append_option(argv_repack, "-A", MAX_ADD);
 
 	if (pack_refs && run_command_v_opt(argv_pack_refs, RUN_GIT_CMD))
 		return error(FAILED_RUN, argv_pack_refs[0]);
-- 
1.5.5.67.g9a49
