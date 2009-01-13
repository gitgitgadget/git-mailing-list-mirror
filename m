From: Ted Pavlic <ted@tedpavlic.com>
Subject: [PATCH 2/3] Makes the bash completion script try *bash* completions
 before simple, filetype completions when a git completion is not found. If
 bash, completions aren't available, the default file completions are used.
 This, behavior was inspired by Mercurial's bash completion script.
Date: Tue, 13 Jan 2009 11:10:21 -0500
Message-ID: <496CBCED.80402@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 13 17:11:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMlrn-0006EU-Na
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 17:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbZAMQKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 11:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752222AbZAMQKY
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 11:10:24 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:45277 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751211AbZAMQKX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jan 2009 11:10:23 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id C8C2680D8031;
	Tue, 13 Jan 2009 11:04:39 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mLtQlT7odKEN; Tue, 13 Jan 2009 11:04:39 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id B2D6180D801B;
	Tue, 13 Jan 2009 11:04:39 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105505>


Second in a series of patches that make bash completions more robust to
different interactive shell configurations and editors.


[PATCH 2/3] Makes the bash completion script try *bash* completions 
before simple
  filetype completions when a git completion is not found. If bash
  completions aren't available, the default file completions are used. This
  behavior was inspired by Mercurial's bash completion script.


Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
---
  contrib/completion/git-completion.bash |    9 ++++++---
  1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash 
b/contrib/completion/git-completion.bash
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
