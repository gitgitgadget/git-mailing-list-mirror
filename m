From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [RFC] Support TEST_GIT_PATH variable for the path for the git to
 test
Date: Mon, 25 Feb 2008 18:21:34 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802251600220.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 00:22:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTmeF-0004v0-Az
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 00:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754306AbYBYXVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 18:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754209AbYBYXVg
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 18:21:36 -0500
Received: from iabervon.org ([66.92.72.58]:33776 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754077AbYBYXVf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 18:21:35 -0500
Received: (qmail 21382 invoked by uid 1000); 25 Feb 2008 23:21:34 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Feb 2008 23:21:34 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75086>

This is useful if you want to see how some other version of git
handles the tests for some reason. (For example, see how a working
version manages to work while a broken one doesn't)

This version only sort of works, but it's enough to have been helpful in 
debugging builtin-clone, and most of what's left I don't really understand 
at all (the perl code, for example).

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 t/test-lib.sh |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 83889c4..5300549 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -281,7 +281,8 @@ test_create_repo () {
 	cd "$repo" || error "Cannot setup test environment"
 	"$GIT_EXEC_PATH/git" init --template=$GIT_EXEC_PATH/templates/blt/ >/dev/null 2>&1 ||
 	error "cannot run git init -- have you built things yet?"
-	mv .git/hooks .git/hooks-disabled
+	[ ! -e .git/hooks ] || mv .git/hooks .git/hooks-disabled
+	[ -e .git/info ] || mkdir .git/info
 	cd "$owd"
 }
 
@@ -321,8 +322,8 @@ test_done () {
 
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in trash subdirectory.
-PATH=$(pwd)/..:$PATH
-GIT_EXEC_PATH=$(pwd)/..
+GIT_EXEC_PATH=${TEST_GIT_PATH:-$(pwd)/..}
+PATH=$GIT_EXEC_PATH:$(pwd)/..:$PATH
 GIT_TEMPLATE_DIR=$(pwd)/../templates/blt
 unset GIT_CONFIG
 unset GIT_CONFIG_LOCAL
-- 
1.5.4.2.261.g851a5.dirty
