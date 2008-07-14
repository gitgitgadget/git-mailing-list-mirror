From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] bash completion: Append space after file names have been
	completed
Date: Mon, 14 Jul 2008 00:22:03 +0000
Message-ID: <20080714002203.GA13749@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 02:23:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIBqL-0007Jt-Er
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 02:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754423AbYGNAWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 20:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754484AbYGNAWF
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 20:22:05 -0400
Received: from george.spearce.org ([209.20.77.23]:54494 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398AbYGNAWE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 20:22:04 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 17B073836B; Mon, 14 Jul 2008 00:22:03 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88363>

When completing `git show origin/maint:Makef<tab>` we should add a
space after the filename has been completed, so that the user can
immediately begin the next argument.

I also added a special case for the symlink variant so we treat it
just like a normal blob, as there are no items below it in the Git
tree structure.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9a1c66a..790d1c6 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -294,9 +294,17 @@ __git_complete_file ()
 			ls="$ref"
 			;;
 	    esac
+		local IFS=$'\n'
 		COMPREPLY=($(compgen -P "$pfx" \
 			-W "$(git --git-dir="$(__gitdir)" ls-tree "$ls" \
-				| sed '/^100... blob /s,^.*	,,
+				| sed '/^100... blob /{
+				           s,^.*	,,
+				           s,$, ,
+				       }
+				       /^120000 blob /{
+				           s,^.*	,,
+				           s,$, ,
+				       }
 				       /^040000 tree /{
 				           s,^.*	,,
 				           s,$,/,
-- 
1.5.6.2.393.g45096
