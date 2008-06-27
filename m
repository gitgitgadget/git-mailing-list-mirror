From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] clone: respect url.insteadOf setting in global configs
Date: Fri, 27 Jun 2008 13:56:05 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806271355520.9925@racer>
References: <27C25D70-0BFC-4362-A771-C7CAD89BC198@ai.rug.nl> <alpine.DEB.1.00.0806271353350.9925@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailinglist <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Fri Jun 27 14:59:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCDY2-00041E-6k
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 14:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753600AbYF0M6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 08:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754537AbYF0M6I
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 08:58:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:55807 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754660AbYF0M6H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 08:58:07 -0400
Received: (qmail invoked by alias); 27 Jun 2008 12:58:05 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp014) with SMTP; 27 Jun 2008 14:58:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+YqAglII+YsE1sNxLmK72eilja7D4UGokrgIa8+9
	4Uxq6oLReaacYV
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0806271353350.9925@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86549>


When we call "git clone" with a url that has a rewrite rule in either
$HOME/.gitconfig or /etc/gitconfig, the URL can be different from
what the command line expects it to be.

So, let's use the URL as the remote structure has it, not the literal
string from the command line.

Noticed by Pieter de Bie.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-clone.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 965b5fc..8dda52a 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -463,7 +463,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		refs = clone_local(path, git_dir);
 	else {
 		struct remote *remote = remote_get(argv[0]);
-		struct transport *transport = transport_get(remote, argv[0]);
+		struct transport *transport =
+			transport_get(remote, remote->url[0]);
 
 		if (!transport->get_refs_list || !transport->fetch)
 			die("Don't know how to clone %s", transport->url);
-- 
1.5.6.173.gde14c
