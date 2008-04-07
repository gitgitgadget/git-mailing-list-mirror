From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] pretty=format: Add %d to show decoration
Date: Mon, 7 Apr 2008 14:41:12 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804071441040.430@eeepc-johanness>
References: <alpine.DEB.1.00.0804071439480.430@eeepc-johanness>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 07 15:42:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jirc6-0005Pu-5Y
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 15:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757581AbYDGNlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 09:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757539AbYDGNlj
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 09:41:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:45108 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757558AbYDGNli (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 09:41:38 -0400
Received: (qmail invoked by alias); 07 Apr 2008 13:41:36 -0000
Received: from unknown (EHLO eeepc-johanness.st-andrews.ac.uk) [138.251.11.75]
  by mail.gmx.net (mp024) with SMTP; 07 Apr 2008 15:41:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18JTFpAr8EJGMg6DJN3lxvZAscoqNWe3g0zjeZyBd
	Axa8Xl1uXTOJ92
X-X-Sender: user@eeepc-johanness
In-Reply-To: <alpine.DEB.1.00.0804071439480.430@eeepc-johanness>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78976>


With this patch, "git log --decorate --pretty=format:%d", shows the
name decoration (i.e. whenever a commit matches a ref, that ref's name
is shown).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Maybe %d should expand to " (<name decoration>)" instead of
	"<name decoration>"?

 Documentation/pretty-formats.txt |    1 +
 pretty.c                         |    9 +++++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index e8bea3e..9d8a8d4 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -117,6 +117,7 @@ The placeholders are:
 - '%e': encoding
 - '%s': subject
 - '%b': body
+- '%d': decoration (needs --decorate)
 - '%Cred': switch color to red
 - '%Cgreen': switch color to green
 - '%Cblue': switch color to blue
diff --git a/pretty.c b/pretty.c
index 6c04176..37f7c3e 100644
--- a/pretty.c
+++ b/pretty.c
@@ -489,6 +489,15 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 			return 3;
 		} else
 			return 0;
+	case 'd':
+		{
+			struct name_decoration *decoration =
+				lookup_decoration(&name_decoration,
+				&commit->object);
+			if (decoration)
+				strbuf_addstr(sb, decoration->name);
+			return 1;
+		}
 	}
 
 	/* these depend on the commit */
-- 
1.5.5.rc0.208.g1d50
