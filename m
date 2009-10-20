From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 2/5] git-svn: allow test setup script to support PERL env. var
Date: Tue, 20 Oct 2009 15:42:00 +1300
Message-ID: <1256006523-5493-3-git-send-email-sam.vilain@catalyst.net.nz>
References: <1256006523-5493-1-git-send-email-sam.vilain@catalyst.net.nz>
 <1256006523-5493-2-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 20 04:43:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N04hI-00087R-B0
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 04:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758228AbZJTCnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 22:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756757AbZJTCnb
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 22:43:31 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:42702 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755475AbZJTCna (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 22:43:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id D7DBF32395;
	Tue, 20 Oct 2009 15:43:34 +1300 (NZDT)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iVdIV3xGV4t8; Tue, 20 Oct 2009 15:43:34 +1300 (NZDT)
Received: from localhost.localdomain (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 215D33236D;
	Tue, 20 Oct 2009 15:43:34 +1300 (NZDT)
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1256006523-5493-2-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130750>

Possibly the 'perl' in the PATH is not the one to be used for the tests;
let PERL set in the environment select it.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
  A little unrelated nit

 t/lib-git-svn.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index fd8631f..0f7f35c 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -16,6 +16,7 @@ fi
 GIT_DIR=$PWD/.git
 GIT_SVN_DIR=$GIT_DIR/svn/refs/remotes/git-svn
 SVN_TREE=$GIT_SVN_DIR/svn-tree
+PERL=${PERL:-perl}
 
 svn >/dev/null 2>&1
 if test $? -ne 1
@@ -29,7 +30,7 @@ export svnrepo
 svnconf=$PWD/svnconf
 export svnconf
 
-perl -w -e "
+$PERL -w -e "
 use SVN::Core;
 use SVN::Repos;
 \$SVN::Core::VERSION gt '1.1.0' or exit(42);
@@ -130,7 +131,7 @@ stop_httpd () {
 }
 
 convert_to_rev_db () {
-	perl -w -- - "$@" <<\EOF
+	$PERL -w -- - "$@" <<\EOF
 use strict;
 @ARGV == 2 or die "Usage: convert_to_rev_db <input> <output>";
 open my $wr, '+>', $ARGV[1] or die "$!: couldn't open: $ARGV[1]";
-- 
1.6.3.3
