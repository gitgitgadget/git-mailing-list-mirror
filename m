From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH v2] builtin/merge_recursive.c: Add an usage string and make use of it.
Date: Sun, 29 Aug 2010 19:20:21 -0300
Message-ID: <9e0261a0eebe275e2ed1fa651e5ab80c35f6048c.1283120150.git.tfransosi@gmail.com>
References: <20100829214648.GE1890@burratino>
Cc: gitster@pobox.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 00:20:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpqEv-0008HW-7N
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 00:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905Ab0H2WUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 18:20:32 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63992 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753618Ab0H2WUb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 18:20:31 -0400
Received: by gwj17 with SMTP id 17so1782498gwj.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 15:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=WQQY/w5HjKbC4lxb8b1RwY3IqnMChTJ7CGaytyI9/Jo=;
        b=cCgEdYT687D71bk1NIavfQaGrat376kGX+7DgF3Cgm3WalkS/8n53+8yEhGYHisW4o
         72arqF7VZ/NSk8f1v/TguML6tXnFrJvr7NSMDIiL17nDmJH2z7vKWagY/GG+7Dcrs/mP
         JiftGZBk714aJr7+dUxdBKjs/PhJaO1gwDYKU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DKcbmVdOAZ7a1LB345zoVU7W/y0DXS7G8I7/2c90fMHulukORyZsEMeXyRERoTgRSx
         8IBcJXDrSDAZsbWeufvOXBAtdMXx/meJ5gTE5uLS3O5KDW2Jh+AyQmeubB0E0MVtNziK
         uag773wXXiHUFsNyB7RazA8PtAXJokR/1KUuc=
Received: by 10.150.218.1 with SMTP id q1mr4497851ybg.202.1283120430373;
        Sun, 29 Aug 2010 15:20:30 -0700 (PDT)
Received: from localhost ([186.205.0.204])
        by mx.google.com with ESMTPS id d5sm2741648ybi.21.2010.08.29.15.20.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 15:20:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.95.g3d045
In-Reply-To: <20100829214648.GE1890@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154727>

This improves the usage output by adding builtin_merge_recursive_usage string
that follows the same pattern used by the other builtin commands.

The previous output for git merger-recursive was:
usage: merge-recursive <base>... -- <head> <remote> ...

Now the output is:
usage: git merge-recursive <base>... -- <head> <remote> ...

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 builtin/merge-recursive.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index d8875d5..189ba42 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -3,6 +3,9 @@
 #include "tag.h"
 #include "merge-recursive.h"
 
+static const char builtin_merge_recursive_usage[] =
+	"git %s <base>... -- <head> <remote> ...";
+
 static const char *better_branch_name(const char *branch)
 {
 	static char githead_env[8 + 40 + 1];
@@ -29,7 +32,7 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 		o.subtree_shift = "";
 
 	if (argc < 4)
-		usagef("%s <base>... -- <head> <remote> ...", argv[0]);
+		usagef(builtin_merge_recursive_usage, argv[0]);
 
 	for (i = 1; i < argc; ++i) {
 		const char *arg = argv[i];
@@ -37,19 +40,19 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 		if (!prefixcmp(arg, "--")) {
 			if (!arg[2])
 				break;
-			if (!strcmp(arg+2, "ours"))
+			if (!strcmp(arg + 2, "ours"))
 				o.recursive_variant = MERGE_RECURSIVE_OURS;
-			else if (!strcmp(arg+2, "theirs"))
+			else if (!strcmp(arg + 2, "theirs"))
 				o.recursive_variant = MERGE_RECURSIVE_THEIRS;
-			else if (!strcmp(arg+2, "subtree"))
+			else if (!strcmp(arg + 2, "subtree"))
 				o.subtree_shift = "";
-			else if (!prefixcmp(arg+2, "subtree="))
+			else if (!prefixcmp(arg + 2, "subtree="))
 				o.subtree_shift = arg + 10;
 			else
 				die("Unknown option %s", arg);
 			continue;
 		}
-		if (bases_count < ARRAY_SIZE(bases)-1) {
+		if (bases_count < ARRAY_SIZE(bases) - 1) {
 			unsigned char *sha = xmalloc(20);
 			if (get_sha1(argv[i], sha))
 				die("Could not parse object '%s'", argv[i]);
@@ -58,7 +61,7 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 		else
 			warning("Cannot handle more than %d bases. "
 				"Ignoring %s.",
-				(int)ARRAY_SIZE(bases)-1, argv[i]);
+				(int)ARRAY_SIZE(bases) - 1, argv[i]);
 	}
 	if (argc - i != 3) /* "--" "<head>" "<remote>" */
 		die("Not handling anything other than two heads merge.");
-- 
1.7.2.1.95.g3d045
