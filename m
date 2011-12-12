From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] mv: honor --verbose flag
Date: Mon, 12 Dec 2011 02:51:24 -0500
Message-ID: <20111212075124.GB17532@sigill.intra.peff.net>
References: <20111212074503.GB16511@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Dec 12 08:51:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra0fg-0007aq-1M
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 08:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791Ab1LLHvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 02:51:31 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48004
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752860Ab1LLHv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 02:51:29 -0500
Received: (qmail 30167 invoked by uid 107); 12 Dec 2011 07:58:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Dec 2011 02:58:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2011 02:51:24 -0500
Content-Disposition: inline
In-Reply-To: <20111212074503.GB16511@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186881>

The code for a verbose flag has been here since "git mv" was
converted to C many years ago, but actually getting the "-v"
flag from the command line was accidentally lost in the
transition.

Signed-off-by: Jeff King <peff@peff.net>
---
This has been broken since 2006, so I guess nobody really cares. But
it's simple to fix.

 Documentation/git-mv.txt |    8 ++++++--
 builtin/mv.c             |    1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index 4be7a71..e3c8448 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -15,8 +15,8 @@ DESCRIPTION
 -----------
 This script is used to move or rename a file, directory or symlink.
 
- git mv [-f] [-n] [-k] <source> <destination>
- git mv [-f] [-n] [-k] <source> ... <destination directory>
+ git mv [-v] [-f] [-n] [-k] <source> <destination>
+ git mv [-v] [-f] [-n] [-k] <source> ... <destination directory>
 
 In the first form, it renames <source>, which must exist and be either
 a file, symlink or directory, to <destination>.
@@ -40,6 +40,10 @@ OPTIONS
 --dry-run::
 	Do nothing; only show what would happen
 
+-v::
+--verbose::
+	Report the names of files as they are moved.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/mv.c b/builtin/mv.c
index 5efe6c5..11abaf5 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -59,6 +59,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	int i, newfd;
 	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0;
 	struct option builtin_mv_options[] = {
+		OPT__VERBOSE(&verbose, "be verbose"),
 		OPT__DRY_RUN(&show_only, "dry run"),
 		OPT__FORCE(&force, "force move/rename even if target exists"),
 		OPT_BOOLEAN('k', NULL, &ignore_errors, "skip move/rename errors"),
-- 
1.7.8.13.g74677
