From: Ted Pavlic <ted@tedpavlic.com>
Subject: [PATCH 4/4] completion: More fixes to prevent unbound variable errors.
Date: Wed, 11 Feb 2009 13:54:39 -0500
Message-ID: <1234378479-29304-5-git-send-email-ted@tedpavlic.com>
References: <7v63jgg7st.fsf@gitster.siamese.dyndns.org>
 <1234378479-29304-1-git-send-email-ted@tedpavlic.com>
 <1234378479-29304-2-git-send-email-ted@tedpavlic.com>
 <1234378479-29304-3-git-send-email-ted@tedpavlic.com>
 <1234378479-29304-4-git-send-email-ted@tedpavlic.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Ted Pavlic <ted@tedpavlic.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Feb 11 19:57:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXKGM-00038I-HY
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757051AbZBKSzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 13:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756984AbZBKSzA
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:55:00 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:44571 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755758AbZBKSyv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2009 13:54:51 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 65BA480D808E;
	Wed, 11 Feb 2009 13:48:20 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dsdtMujOb4PV; Wed, 11 Feb 2009 13:48:20 -0500 (EST)
Received: from localhost.localdomain (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 4012580D808B;
	Wed, 11 Feb 2009 13:48:20 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.390.gba743
In-Reply-To: <1234378479-29304-4-git-send-email-ted@tedpavlic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109503>

Several functions make use of "[-n ...]" and "[-z ...]". In many cases,
the variables being tested were declared with "local." However, several
__variables are not, and so they must be replaced with their ${__-}
equivalents.

Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
Acked-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3d48a65..8d62b2b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -62,7 +62,7 @@ esac
 __gitdir ()
 {
 	if [ -z "${1-}" ]; then
-		if [ -n "$__git_dir" ]; then
+		if [ -n "${__git_dir-}" ]; then
 			echo "$__git_dir"
 		elif [ -d .git ]; then
 			echo .git
@@ -299,7 +299,7 @@ __git_remotes ()
 
 __git_merge_strategies ()
 {
-	if [ -n "$__git_merge_strategylist" ]; then
+	if [ -n "${__git_merge_strategylist-}" ]; then
 		echo "$__git_merge_strategylist"
 		return
 	fi
@@ -385,7 +385,7 @@ __git_complete_revlist ()
 
 __git_all_commands ()
 {
-	if [ -n "$__git_all_commandlist" ]; then
+	if [ -n "${__git_all_commandlist-}" ]; then
 		echo "$__git_all_commandlist"
 		return
 	fi
@@ -403,7 +403,7 @@ __git_all_commandlist="$(__git_all_commands 2>/dev/null)"
 
 __git_porcelain_commands ()
 {
-	if [ -n "$__git_porcelain_commandlist" ]; then
+	if [ -n "${__git_porcelain_commandlist-}" ]; then
 		echo "$__git_porcelain_commandlist"
 		return
 	fi
-- 
1.6.1.2.390.gba743
