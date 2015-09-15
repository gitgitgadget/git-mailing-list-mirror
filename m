From: Jeff King <peff@peff.net>
Subject: [PATCH 31/67] help: drop prepend function in favor of xstrfmt
Date: Tue, 15 Sep 2015 11:48:32 -0400
Message-ID: <20150915154832.GE29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:48:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbsTM-0002HV-Jl
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605AbbIOPsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:48:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:59361 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752736AbbIOPsf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:48:35 -0400
Received: (qmail 12449 invoked by uid 102); 15 Sep 2015 15:48:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:48:34 -0500
Received: (qmail 7324 invoked by uid 107); 15 Sep 2015 15:48:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:48:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:48:32 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277933>

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
2.6.0.rc2.408.ga2926b9
