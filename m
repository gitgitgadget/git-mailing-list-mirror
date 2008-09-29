From: Luc Heinrich <luc@honk-honk.com>
Subject: [PATCH] git-svn: call 'fatal' correctly in set-tree
Date: Mon, 29 Sep 2008 15:58:18 +0200
Message-ID: <1222696698-97356-1-git-send-email-luc@honk-honk.com>
Cc: gitster@pobox.com, Luc Heinrich <luc@honk-honk.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 29 16:18:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkJa3-0001eB-Jk
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 16:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbYI2ORZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 10:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbYI2ORY
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 10:17:24 -0400
Received: from fb2.tech.numericable.fr ([82.216.111.50]:36823 "EHLO
	fb2.tech.numericable.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbYI2ORX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 10:17:23 -0400
X-Greylist: delayed 1143 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Sep 2008 10:17:23 EDT
Received: from smtp3.tech.numericable.fr (unknown [10.0.0.48])
	by fb2.tech.numericable.fr (Postfix) with ESMTP id 57EE219D32C
	for <git@vger.kernel.org>; Mon, 29 Sep 2008 15:59:42 +0200 (CEST)
Received: from localhost.localdomain (81-65-49-248.rev.numericable.fr [81.65.49.248])
	by smtp3.tech.numericable.fr (Postfix) with ESMTP id 0249F3E427;
	Mon, 29 Sep 2008 15:58:18 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97012>

When doing a set-tree and there is no revision to commit to, the following unrelated error message is displayed: "Undefined subroutine &Git::SVN::fatal called at /opt/local/libexec/git-core/git-svn line 2575." The following patch fixes the problem and allows the real error message to be shown.

Signed-off-by: Luc Heinrich <luc@honk-honk.com>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 80a5728..7609a83 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2591,7 +2591,7 @@ sub set_tree {
 	my ($self, $tree) = (shift, shift);
 	my $log_entry = ::get_commit_entry($tree);
 	unless ($self->{last_rev}) {
-		fatal("Must have an existing revision to commit");
+		::fatal("Must have an existing revision to commit");
 	}
 	my %ed_opts = ( r => $self->{last_rev},
 	                log => $log_entry->{log},
-- 
1.6.0.2
