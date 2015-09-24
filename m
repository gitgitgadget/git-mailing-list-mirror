From: Jeff King <peff@peff.net>
Subject: [PATCH 31/68] help: drop prepend function in favor of xstrfmt
Date: Thu, 24 Sep 2015 17:07:14 -0400
Message-ID: <20150924210713.GB30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:07:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDjg-0001wh-D7
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199AbbIXVHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:07:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:35973 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753076AbbIXVHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:07:16 -0400
Received: (qmail 11973 invoked by uid 102); 24 Sep 2015 21:07:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:07:16 -0500
Received: (qmail 29253 invoked by uid 107); 24 Sep 2015 21:07:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:07:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:07:14 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278586>

This function predates xstrfmt, and its functionality is a
subset. Let's just use xstrfmt.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/help.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 3422e73..fba8c01 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -295,16 +295,6 @@ static int is_git_command(const char *s)
 		is_in_cmdlist(&other_cmds, s);
 }
 
-static const char *prepend(const char *prefix, const char *cmd)
-{
-	size_t pre_len = strlen(prefix);
-	size_t cmd_len = strlen(cmd);
-	char *p = xmalloc(pre_len + cmd_len + 1);
-	memcpy(p, prefix, pre_len);
-	strcpy(p + pre_len, cmd);
-	return p;
-}
-
 static const char *cmd_to_page(const char *git_cmd)
 {
 	if (!git_cmd)
@@ -312,9 +302,9 @@ static const char *cmd_to_page(const char *git_cmd)
 	else if (starts_with(git_cmd, "git"))
 		return git_cmd;
 	else if (is_git_command(git_cmd))
-		return prepend("git-", git_cmd);
+		return xstrfmt("git-%s", git_cmd);
 	else
-		return prepend("git", git_cmd);
+		return xstrfmt("git%s", git_cmd);
 }
 
 static void setup_man_path(void)
-- 
2.6.0.rc3.454.g204ad51
