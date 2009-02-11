From: Ted Pavlic <ted@tedpavlic.com>
Subject: [PATCH 4/3] completion: More fixes to prevent unbound variable errors.
Date: Wed, 11 Feb 2009 11:18:52 -0500
Message-ID: <1234369132-22063-1-git-send-email-ted@tedpavlic.com>
References: <1234366634-17900-4-git-send-email-ted@tedpavlic.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Ted Pavlic <ted@tedpavlic.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Feb 11 17:20:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXHpC-0003Tz-Bs
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 17:20:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755910AbZBKQTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 11:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755758AbZBKQTH
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 11:19:07 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:38775 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755718AbZBKQTH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2009 11:19:07 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 616CF80D8087;
	Wed, 11 Feb 2009 11:12:35 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TnYqaaN0pvBt; Wed, 11 Feb 2009 11:12:35 -0500 (EST)
Received: from localhost.localdomain (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 4892F80D8085;
	Wed, 11 Feb 2009 11:12:35 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.390.gba743
In-Reply-To: <1234366634-17900-4-git-send-email-ted@tedpavlic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109435>

Several functions make use of "test -n" and "test -z". In many cases,
the variables being tested were declared with "local." However, several
__variables are not, and so they must be replaced with their ${__-}
equivalents.

Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
---

This patch depends on:

    <1234366634-17900-3-git-send-email-ted@tedpavlic.com>
    "[PATCH 2/3] completion: Change "if [...]" to "if test ..." to 
                             match git convention"

If that patch is not applied, I can submit a new patch.

 contrib/completion/git-completion.bash |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ffde82a..055e4ac 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -62,7 +62,7 @@ esac
 __gitdir ()
 {
 	if test -z "${1-}"; then
-		if test -n "$__git_dir"; then
+		if test -n "${__git_dir-}"; then
 			echo "$__git_dir"
 		elif test -d .git; then
 			echo .git
@@ -294,7 +294,7 @@ __git_remotes ()
 
 __git_merge_strategies ()
 {
-	if test -n "$__git_merge_strategylist"; then
+	if test -n "${__git_merge_strategylist-}"; then
 		echo "$__git_merge_strategylist"
 		return
 	fi
@@ -380,7 +380,7 @@ __git_complete_revlist ()
 
 __git_all_commands ()
 {
-	if test -n "$__git_all_commandlist"; then
+	if test -n "${__git_all_commandlist-}"; then
 		echo "$__git_all_commandlist"
 		return
 	fi
@@ -398,7 +398,7 @@ __git_all_commandlist="$(__git_all_commands 2>/dev/null)"
 
 __git_porcelain_commands ()
 {
-	if test -n "$__git_porcelain_commandlist"; then
+	if test -n "${__git_porcelain_commandlist-}"; then
 		echo "$__git_porcelain_commandlist"
 		return
 	fi
-- 
1.6.1.2.390.gba743
