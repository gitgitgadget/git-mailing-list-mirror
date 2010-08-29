From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] builtin/merge_recursive.c: Add a usage string and make use of it.
Date: Sun, 29 Aug 2010 14:39:19 -0300
Message-ID: <c9d88eb8cbd5b025b0c0112be05d3c0fe993de25.1283103426.git.tfransosi@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 29 19:39:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oplqw-00076I-1D
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 19:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844Ab0H2Rj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 13:39:28 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50552 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686Ab0H2Rj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 13:39:28 -0400
Received: by ywh1 with SMTP id 1so1393167ywh.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 10:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=h5kJGG16z3+yidK0CzHPfYa3CtFfMaDeP5fMosIbaZM=;
        b=X1AqdTGrotQ1XqUooJJ/1cpotOj1gVoiQK+nTk2kNXVur6+icCcxUwXiX2Ldj5Nl3R
         efp0vcvNDBYYpZuH9ldEomaDAjGuRF6wB6TeVZzRtsVwdRa+exfCGuMh+tPrDDnxZZ+f
         /1H1E8/1z7MFNzc4bHmumz+b7ly/Z7yXESeSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=tjlbuJ7C/DKZRAfkhHqXNOy4U5TFjOX7DNPK22NZkBOlRWx+Y/2++dNJJcjPSYk56B
         tjBiIQvDPSEs61aD9OJ1itcdvFubhz0UncAPJDAtyNyeq14BCyXru26oL9Ummwa0yhPv
         F53two+YItA/2JKah1/iomuzUaZxOSp5NmtDg=
Received: by 10.101.154.30 with SMTP id g30mr3399361ano.256.1283103567400;
        Sun, 29 Aug 2010 10:39:27 -0700 (PDT)
Received: from localhost ([186.205.0.204])
        by mx.google.com with ESMTPS id w1sm10918965ana.16.2010.08.29.10.39.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 10:39:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.95.g3d045
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154698>

This improves the usage output by adding builtin_merge_recursive_usage string
that follows the same pattern used by the other builtin commands.

Also it uses usage() function instead of the usagef() function.

The previous output for git merger-recursive was:
usage: merge-recursive <base>... -- <head> <remote> ...

Now the output is:
usage: git merge-recursive <base>... -- <head> <remote> ...

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 builtin/merge-recursive.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index d8875d5..46c2a85 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -3,6 +3,9 @@
 #include "tag.h"
 #include "merge-recursive.h"
 
+static const char builtin_merge_recursive_usage[] =
+	"git merge-recursive <base>... -- <head> <remote> ...";
+
 static const char *better_branch_name(const char *branch)
 {
 	static char githead_env[8 + 40 + 1];
@@ -29,7 +32,7 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 		o.subtree_shift = "";
 
 	if (argc < 4)
-		usagef("%s <base>... -- <head> <remote> ...", argv[0]);
+		usage(builtin_merge_recursive_usage);
 
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
