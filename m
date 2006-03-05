From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH 1/3] git.c: Kill type mismatch warning.
Date: Sun, 05 Mar 2006 09:36:31 +0000
Message-ID: <20060305093630.26650.91571.stgit@metalzone.distorted.org.uk>
References: <20060305093351.26650.84677.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Sun Mar 05 10:36:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFpfI-0001zP-1n
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 10:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbWCEJgd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 04:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752159AbWCEJgd
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 04:36:33 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:62874 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1752151AbWCEJgc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 04:36:32 -0500
Received: (qmail 26935 invoked from network); 5 Mar 2006 09:36:31 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (127.0.0.1)
  by localhost with SMTP; 5 Mar 2006 09:36:31 -0000
To: git@vger.kernel.org
In-Reply-To: <20060305093351.26650.84677.stgit@metalzone.distorted.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17213>

From: Mark Wooding <mdw@distorted.org.uk>

GCC objects when you pass a `char **' where a `const char **' is wanted.
The cast shuts the compiler up, and does the right thing generally.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---

Unfortunately, the warning is fair enough.  I can pass a `T' where
someone was expecting a `const T', but that would mean that the callee
was expecting a `char *const *'.
---

 git.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index a547dbd..69df070 100644
--- a/git.c
+++ b/git.c
@@ -261,7 +261,7 @@ static int cmd_log(int argc, char **argv
 	int show_parents = 0;
 	const char *commit_prefix = "commit ";
 
-	argc = setup_revisions(argc, argv, &rev, "HEAD");
+	argc = setup_revisions(argc, (const char **)argv, &rev, "HEAD");
 	while (1 < argc) {
 		char *arg = argv[1];
 		if (!strncmp(arg, "--pretty", 8)) {
