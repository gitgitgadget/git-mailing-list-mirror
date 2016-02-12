From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@dwim.me>
Subject: [PATCH] Disown ssh+git and git+ssh
Date: Fri, 12 Feb 2016 16:09:37 +0100
Message-ID: <1455289777-186690-1-git-send-email-cmn@dwim.me>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 16:17:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUFTK-0004ol-I1
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 16:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbcBLPRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 10:17:22 -0500
Received: from hessy.dwim.me ([78.47.67.53]:42308 "EHLO hessy.dwim.me"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396AbcBLPRW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 10:17:22 -0500
X-Greylist: delayed 462 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Feb 2016 10:17:21 EST
Received: from cmartin.tk (unknown [IPv6:2001:6f8:900:8cd0:922b:34ff:fe1c:e3e4])
	by hessy.dwim.me (Postfix) with ESMTPA id 47335819E0
	for <git@vger.kernel.org>; Fri, 12 Feb 2016 16:09:38 +0100 (CET)
Received: (nullmailer pid 186733 invoked by uid 1000);
	Fri, 12 Feb 2016 15:09:37 -0000
X-Mailer: git-send-email 2.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286052>

These were silly from the beginning, but we have to support them for
compatibility. That doesn't mean we have to show them in the
documentation. These were already left out of the main list, but a
reference in the main manpage was left, so remove that.

Also add a note to discourage their use if anybody goes looking for them
in the source code.
---
 Documentation/git.txt | 2 +-
 connect.c             | 4 ++++
 transport.c           | 4 ++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index d987ad2..2f90635 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1122,7 +1122,7 @@ of clones and fetches.
 	    connection (or proxy, if configured)
 
 	  - `ssh`: git over ssh (including `host:path` syntax,
-	    `git+ssh://`, etc).
+	    `ssh://`, etc).
 
 	  - `rsync`: git over rsync
 
diff --git a/connect.c b/connect.c
index fd7ffe1..4f96424 100644
--- a/connect.c
+++ b/connect.c
@@ -267,6 +267,10 @@ static enum protocol get_protocol(const char *name)
 		return PROTO_SSH;
 	if (!strcmp(name, "git"))
 		return PROTO_GIT;
+	/*
+	 * These ssh schemes remain supported for compat but are
+	 * undocumented and their use is discouraged
+	 */
 	if (!strcmp(name, "git+ssh"))
 		return PROTO_SSH;
 	if (!strcmp(name, "ssh+git"))
diff --git a/transport.c b/transport.c
index 9ae7184..f5ae707 100644
--- a/transport.c
+++ b/transport.c
@@ -1002,6 +1002,10 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		|| starts_with(url, "file://")
 		|| starts_with(url, "git://")
 		|| starts_with(url, "ssh://")
+		/*
+		 * These ssh schemes remain supported for compat but are
+		 * undocumented and their use is discouraged
+		 */
 		|| starts_with(url, "git+ssh://")
 		|| starts_with(url, "ssh+git://")) {
 		/*
-- 
2.7.0
