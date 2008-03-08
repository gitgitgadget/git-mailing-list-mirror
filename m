From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 03/11] Test that --reference actually suppresses fetching
 referenced objects
Date: Sat, 8 Mar 2008 18:04:02 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803081804010.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 00:04:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY85u-0008Ar-Su
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 00:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbYCHXEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 18:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbYCHXEG
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 18:04:06 -0500
Received: from iabervon.org ([66.92.72.58]:42223 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965AbYCHXEE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 18:04:04 -0500
Received: (qmail 18567 invoked by uid 1000); 8 Mar 2008 23:04:02 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Mar 2008 23:04:02 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76602>

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 t/t5700-clone-reference.sh |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index 0c42d9f..aa2acb8 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -8,6 +8,8 @@ test_description='test clone --reference'
 
 base_dir=`pwd`
 
+U=$base_dir/UPLOAD_LOG
+
 test_expect_success 'preparing first repository' \
 'test_create_repo A && cd A &&
 echo first > file1 &&
@@ -50,8 +52,13 @@ diff expected current'
 
 cd "$base_dir"
 
+rm -f $U
+
 test_expect_success 'cloning with reference (no -l -s)' \
-'git clone --reference B file://`pwd`/A D'
+'GIT_DEBUG_SEND_PACK=3 git clone --reference B file://`pwd`/A D 3>$U'
+
+test_expect_success 'fetched no objects' \
+'! grep "^want" $U'
 
 cd "$base_dir"
 
-- 
1.5.4.3.327.g614d7.dirty

