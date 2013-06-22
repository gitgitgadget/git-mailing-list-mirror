From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/2] completion: handle unstuck form of base git options
Date: Sat, 22 Jun 2013 12:25:17 +0100
Message-ID: <adafd1a0c0d7d059d215d9fd1ea68579525efe6e.1371900318.git.john@keeping.me.uk>
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 22 13:26:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqLy4-0007pw-Do
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 13:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756191Ab3FVL0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 07:26:44 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:35195 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965Ab3FVL02 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 07:26:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id ECF5F22B91;
	Sat, 22 Jun 2013 12:26:27 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vnwArsya5YPL; Sat, 22 Jun 2013 12:26:27 +0100 (BST)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id BBAE122EC6;
	Sat, 22 Jun 2013 12:26:22 +0100 (BST)
X-Mailer: git-send-email 1.8.3.1.676.gaae6535
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228697>

git-completion.bash's parsing of the command name relies on everything
preceding it starting with '-' unless it is the "-c" option.  This
allows users to use the stuck form of "--work-tree=<path>" and
"--namespace=<path>" but not the unstuck forms "--work-tree <path>" and
"--namespace <path>".  Fix this.

Similarly, the completion only handles the stuck form "--git-dir=<path>"
and not "--git-dir <path>", so fix this as well.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 contrib/completion/git-completion.bash | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6c3bafe..8fbf941 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2492,9 +2492,10 @@ __git_main ()
 		i="${words[c]}"
 		case "$i" in
 		--git-dir=*) __git_dir="${i#--git-dir=}" ;;
+		--git-dir)   ((c++)) ; __git_dir="${words[c]}" ;;
 		--bare)      __git_dir="." ;;
 		--help) command="help"; break ;;
-		-c) c=$((++c)) ;;
+		-c|--work-tree|--namespace) ((c++)) ;;
 		-*) ;;
 		*) command="$i"; break ;;
 		esac
-- 
1.8.3.1.676.gaae6535
