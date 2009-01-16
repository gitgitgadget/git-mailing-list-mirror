From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 4/5] run_hook(): check the executability of the hook before filling argv
Date: Fri, 16 Jan 2009 20:10:01 +0100
Message-ID: <1232133002-21725-4-git-send-email-s-beyer@gmx.net>
References: <20090116172521.GD28177@leksak.fem-net>
 <1232133002-21725-1-git-send-email-s-beyer@gmx.net>
 <1232133002-21725-2-git-send-email-s-beyer@gmx.net>
 <1232133002-21725-3-git-send-email-s-beyer@gmx.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paolo Bonzini <bonzini@gnu.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>, gitster@pobox.com,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 16 20:11:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNu6Y-00051V-VN
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 20:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936629AbZAPTKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 14:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764983AbZAPTKP
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 14:10:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:54543 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763728AbZAPTKI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 14:10:08 -0500
Received: (qmail invoked by alias); 16 Jan 2009 19:10:06 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp044) with SMTP; 16 Jan 2009 20:10:06 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19hVWxcRathqUmYRDJcaXuP0wKaJyceFAI8DRVr39
	QvrU/A8otNbEpg
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LNu4w-0005fP-NO; Fri, 16 Jan 2009 20:10:02 +0100
X-Mailer: git-send-email 1.6.1.160.gecdb
In-Reply-To: <1232133002-21725-3-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105985>

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

	I hope this does not need any more words.
	Thanks to Dscho for the hint: it also saves a "free(argv)"
	and some { } for patch 5/5. :-)

 run-command.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/run-command.c b/run-command.c
index 49810a8..fc54c07 100644
--- a/run-command.c
+++ b/run-command.c
@@ -352,6 +352,9 @@ int run_hook(const char *index_file, const char *name, ...)
 	int ret;
 	int i;
 
+	if (access(git_path("hooks/%s", name), X_OK) < 0)
+		return 0;
+
 	va_start(args, name);
 	argv[0] = git_path("hooks/%s", name);
 	i = 0;
@@ -362,9 +365,6 @@ int run_hook(const char *index_file, const char *name, ...)
 	} while (argv[i]);
 	va_end(args);
 
-	if (access(argv[0], X_OK) < 0)
-		return 0;
-
 	memset(&hook, 0, sizeof(hook));
 	hook.argv = argv;
 	hook.no_stdin = 1;
-- 
1.6.1.160.gecdb
