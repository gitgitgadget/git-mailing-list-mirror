From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] rebase--interactive: Ignore comments and blank lines in peek_next_command
Date: Mon, 11 Jan 2010 16:56:45 +0100
Message-ID: <59228d1d1e3b846b7d85f3e9752c1f0da6b1ebfc.1263224986.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 16:57:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUMe6-0003hU-06
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 16:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367Ab0AKP5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 10:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752323Ab0AKP5I
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 10:57:08 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:36086 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256Ab0AKP5H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 10:57:07 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (ssh.berlin.jpk.com [212.222.128.135])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0BFuxtY024308;
	Mon, 11 Jan 2010 16:56:59 +0100
X-Mailer: git-send-email 1.6.6.137.g5b1417
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136633>

Previously, blank lines and/or comments within a series of
squash/fixup commands would confuse "git rebase -i" into thinking that
the series was finished.  It would therefore require the user to edit
the commit message for the squash/fixup commits seen so far.  Then,
after continuing, it would ask the user to edit the commit message
again.

Ignore comments and blank lines within a group of squash/fixup
commands, allowing them to be processed in one go.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
This patch applies to master.  It does not conflict with either
mh/rebase-fixup or ns/rebase-auto-squash.

 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index d529328..6ed57e2 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -322,7 +322,7 @@ make_squash_message () {
 }
 
 peek_next_command () {
-	sed -n "1s/ .*$//p" < "$TODO"
+	sed -n -e "/^#/d" -e "/^$/d" -e "s/ .*//p" -e "q" < "$TODO"
 }
 
 do_next () {
-- 
1.6.6.137.g5b1417
