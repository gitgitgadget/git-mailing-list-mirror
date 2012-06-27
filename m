From: Chris Webb <chris@arachsys.com>
Subject: [PATCH 2/3] Allow help.htmlpath to be an http: URL
Date: Wed, 27 Jun 2012 21:55:13 +0100
Message-ID: <233b27a14d16a2a1cb38b9f3e07a3a79b09a3256.1340830514.git.chris@arachsys.com>
References: <20120627205459.GC11498@arachsys.com>
Cc: chris@arachsys.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 22:55:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjzGz-00031Z-AL
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 22:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757216Ab2F0UzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 16:55:25 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:43623 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756846Ab2F0UzW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 16:55:22 -0400
Received: from [81.2.114.212] (helo=miranda.home.)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SjzGj-0002NM-Ma; Wed, 27 Jun 2012 21:55:21 +0100
X-Mailer: git-send-email 1.7.10
In-Reply-To: <20120627205459.GC11498@arachsys.com>
In-Reply-To: <8d3c71d21710c66e4d5560cec958552b69a22338.1340830514.git.chris@arachsys.com>
References: <8d3c71d21710c66e4d5560cec958552b69a22338.1340830514.git.chris@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200750>

Setting this to a URL prefix instead of a path to a local directory allows
git-help --web to work even when HTML docs aren't locally installed, by
pointing the browser at a copy accessible on the web. For example,

    [help]
      format = html
      htmlpath = http://git-scm.com/docs

will use the publicly available documentation on the git homepage.

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 builtin/help.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index b467db2..60b3251 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -399,9 +399,11 @@ static void get_html_page_path(struct strbuf *page_path, const char *page)
 		html_path = system_path(GIT_HTML_PATH);
 
 	/* Check that we have a git documentation directory. */
-	if (stat(mkpath("%s/git.html", html_path), &st)
-	    || !S_ISREG(st.st_mode))
-		die(_("'%s': not a documentation directory."), html_path);
+	if (prefixcmp(html_path, "http:")) {
+		if (stat(mkpath("%s/git.html", html_path), &st)
+				|| !S_ISREG(st.st_mode))
+			die("'%s': not a documentation directory.", html_path);
+	}
 
 	strbuf_init(page_path, 0);
 	strbuf_addf(page_path, "%s/%s.html", html_path, page);
-- 
1.7.10
