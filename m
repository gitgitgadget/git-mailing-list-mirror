From: ted@tedpavlic.com
Subject: [PATCH 2/3] bash-completion: Try bash completions before simple filetype
Date: Wed, 14 Jan 2009 15:02:21 -0500
Message-ID: <1231963342-24461-2-git-send-email-ted@tedpavlic.com>
References: <1231963342-24461-1-git-send-email-ted@tedpavlic.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Ted Pavlic <ted@tedpavlic.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Jan 14 21:04:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNBy3-0006wS-U1
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 21:04:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755126AbZANUCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 15:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754930AbZANUCe
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 15:02:34 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:36001 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752318AbZANUCe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2009 15:02:34 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 10C0E80D80B4;
	Wed, 14 Jan 2009 14:56:48 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eD6j6VvIzanu; Wed, 14 Jan 2009 14:56:47 -0500 (EST)
Received: from localhost.localdomain (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id E85CF80D80B1;
	Wed, 14 Jan 2009 14:56:47 -0500 (EST)
X-Mailer: git-send-email 1.6.1.87.g15624
In-Reply-To: <1231963342-24461-1-git-send-email-ted@tedpavlic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105692>

From: Ted Pavlic <ted@tedpavlic.com>

  When a git completion is not found, a bash shell should try bash-type
  completions first before going to standard filetype completions. This
  patch /adds/ "-o bashdefault" to the completion line. If that option
  is not available, it uses the old method.

  This behavior was inspired by Mercurial's bash completion script.

Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
Acked-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5d1515c..201f9a6 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1766,13 +1766,16 @@ _gitk ()
 	__git_complete_revlist
 }
 
-complete -o default -o nospace -F _git git
-complete -o default -o nospace -F _gitk gitk
+complete -o bashdefault -o default -o nospace -F _git git 2>/dev/null \
+	|| complete -o default -o nospace -F _git git
+complete -o bashdefault -o default -o nospace -F _gitk gitk 2>/dev/null \
+	|| complete -o default -o nospace -F _gitk gitk
 
 # The following are necessary only for Cygwin, and only are needed
 # when the user has tab-completed the executable name and consequently
 # included the '.exe' suffix.
 #
 if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
-complete -o default -o nospace -F _git git.exe
+complete -o bashdefault -o default -o nospace -F _git git.exe 2>/dev/null \
+	|| complete -o default -o nospace -F _git git.exe
 fi
-- 
1.6.1.87.g15624
