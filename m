From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] filter-branch: fix dash complaining about "Missing '))'"
Date: Tue, 24 Jul 2007 23:29:29 +0200
Message-ID: <46A66F39.20507@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jul 24 23:29:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDRwq-00050B-JJ
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 23:29:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481AbXGXV3h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 17:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752300AbXGXV3h
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 17:29:37 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:60234
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751881AbXGXV3g (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jul 2007 17:29:36 -0400
Received: from [10.0.1.201] (p508EC3BB.dip.t-dialin.net [80.142.195.187])
	by neapel230.server4you.de (Postfix) with ESMTP id 032008B008;
	Tue, 24 Jul 2007 23:29:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (Windows/20070716)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53647>

On e.g. Ubuntu, dash is used as /bin/sh.  Unlike bash it parses
commands like

  a=$((echo stuff) | wc)

as an arithmetic expression while what we want is a subshell inside
a command substitution.  Resolve the ambiguity by placing a space
between the two opening parentheses.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 0ff3475..b5fa449 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -298,7 +298,7 @@ do
 	# Assign the boundarie(s) in the set of rewritten commits
 	# as the replacement commit(s).
 	# (This would look a bit nicer if --not --stdin worked.)
-	for p in $((cd "$workdir"/../map; ls | sed "s/^/^/") |
+	for p in $( (cd "$workdir"/../map; ls | sed "s/^/^/") |
 		git rev-list $ref --boundary --stdin |
 		sed -n "s/^-//p")
 	do
