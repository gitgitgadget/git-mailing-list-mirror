From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Use user.name and user.email in import-tars.perl
Date: Sun, 24 Feb 2008 13:57:18 +0100
Message-ID: <1203857838-29505-1-git-send-email-mh@glandium.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Feb 24 13:56:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTGOx-0000nQ-J8
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 13:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbYBXMzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 07:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbYBXMzn
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 07:55:43 -0500
Received: from vuizook.err.no ([85.19.215.103]:33802 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbYBXMzm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 07:55:42 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JTGOD-0003fZ-An; Sun, 24 Feb 2008 13:55:39 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JTGPu-0007gF-FU; Sun, 24 Feb 2008 13:57:18 +0100
X-Mailer: git-send-email 1.5.4.1.48.g0d77
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74927>

Mimic what is done in git-import.sh and git-import.perl

Signed-off-by: Mike Hommey <mh@glandium.org>
---

 And that made me wonder if it wouldn't be worth, actually, to have
 git config user.name and git config user.email return the "magic" values
 gotten from guessing in ident.c when no value is in the config. That would
 allow scripts, which have no other simple means to get the user name and
 email, to have the same feature as builtins.

 contrib/fast-import/import-tars.perl |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
index 23aeb25..39c091c 100755
--- a/contrib/fast-import/import-tars.perl
+++ b/contrib/fast-import/import-tars.perl
@@ -14,8 +14,10 @@ die "usage: import-tars *.tar.{gz,bz2,Z}\n" unless @ARGV;
 
 my $branch_name = 'import-tars';
 my $branch_ref = "refs/heads/$branch_name";
-my $committer_name = 'T Ar Creator';
-my $committer_email = 'tar@example.com';
+chomp(my $committer_name = `git config user.name`);
+chomp(my $committer_email = `git config user.email`);
+die 'You need to set user name and email'
+  unless $committer_name && $committer_email;
 
 open(FI, '|-', 'git', 'fast-import', '--quiet')
 	or die "Unable to start git fast-import: $!\n";
-- 
1.5.4.1.48.g0d77
