From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-completion.bash: prevent 'git help' from searching for git repository
Date: Wed, 2 Sep 2009 09:58:43 +0000
Message-ID: <20090902095843.28914.qmail@3cd9dde586d86b.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 02 11:58:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MimcA-0004KQ-2E
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 11:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbZIBJ6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 05:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbZIBJ6n
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 05:58:43 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:3192 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751098AbZIBJ6n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 05:58:43 -0400
Received: (qmail 28915 invoked by uid 1000); 2 Sep 2009 09:58:43 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127601>

On 'git <TAB><TAB>' the bash completion runs 'git help -a'.  Since
'git help' actually doesn't need to be run inside a git repository,
this commit uses the option --git-dir=/nonexistent to prevent it
from searching a git directory.  Unnecessary searching for a git
directory can be annoying in auto-mount environments.

The annoying behavior and suggested fix has been reported by Vincent
Danjean through
 http://bugs.debian.org/539273

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index bf688e1..d51854a 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -500,7 +500,7 @@ __git_all_commands ()
 		return
 	fi
 	local i IFS=" "$'\n'
-	for i in $(git help -a|egrep '^ ')
+	for i in $(git --git-dir=/nonexistent help -a|egrep '^ ')
 	do
 		case $i in
 		*--*)             : helper pattern;;
-- 
1.6.0.3
