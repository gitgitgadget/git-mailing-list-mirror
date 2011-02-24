From: Jeff King <peff@peff.net>
Subject: [PATCH 8/8] trace: give repo_setup trace its own key
Date: Thu, 24 Feb 2011 09:30:30 -0500
Message-ID: <20110224143030.GH15477@sigill.intra.peff.net>
References: <20110224142308.GA15356@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 15:30:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PscDG-00008i-2B
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 15:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756140Ab1BXOac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 09:30:32 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:55848 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755575Ab1BXOac (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 09:30:32 -0500
Received: (qmail 23424 invoked by uid 111); 24 Feb 2011 14:30:31 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 24 Feb 2011 14:30:31 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Feb 2011 09:30:30 -0500
Content-Disposition: inline
In-Reply-To: <20110224142308.GA15356@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167818>

You no longer get this output with GIT_TRACE=1; instead, you
can do GIT_TRACE_SETUP=1.

Signed-off-by: Jeff King <peff@peff.net>
---
 trace.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/trace.c b/trace.c
index 3f9f287..262260f 100644
--- a/trace.c
+++ b/trace.c
@@ -155,10 +155,11 @@ static const char *quote_crnl(const char *path)
 /* FIXME: move prefix to startup_info struct and get rid of this arg */
 void trace_repo_setup(const char *prefix)
 {
+	static const char *key = "GIT_TRACE_SETUP";
 	const char *git_work_tree;
 	char cwd[PATH_MAX];
 
-	if (!trace_want("GIT_TRACE"))
+	if (!trace_want(key))
 		return;
 
 	if (!getcwd(cwd, PATH_MAX))
@@ -170,10 +171,10 @@ void trace_repo_setup(const char *prefix)
 	if (!prefix)
 		prefix = "(null)";
 
-	trace_printf("setup: git_dir: %s\n", quote_crnl(get_git_dir()));
-	trace_printf("setup: worktree: %s\n", quote_crnl(git_work_tree));
-	trace_printf("setup: cwd: %s\n", quote_crnl(cwd));
-	trace_printf("setup: prefix: %s\n", quote_crnl(prefix));
+	trace_printf_key(key, "setup: git_dir: %s\n", quote_crnl(get_git_dir()));
+	trace_printf_key(key, "setup: worktree: %s\n", quote_crnl(git_work_tree));
+	trace_printf_key(key, "setup: cwd: %s\n", quote_crnl(cwd));
+	trace_printf_key(key, "setup: prefix: %s\n", quote_crnl(prefix));
 }
 
 int trace_want(const char *key)
-- 
1.7.2.5.25.g3bb93
