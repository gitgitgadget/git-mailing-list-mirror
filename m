From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] archimport: avoid committing on an Arch tag
Date: Sun, 4 Sep 2005 22:55:29 +1200
Message-ID: <11258313291144-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sun Sep 04 12:57:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBsAg-0002Ns-Cm
	for gcvg-git@gmane.org; Sun, 04 Sep 2005 12:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVIDKzz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Sep 2005 06:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVIDKzz
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Sep 2005 06:55:55 -0400
Received: from 202-0-36-112.cable.paradise.net.nz ([202.0.36.112]:48320 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750745AbVIDKzy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2005 06:55:54 -0400
Received: from aporo-debian (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (Postfix) with SMTP id DBE018AAC3;
	Sun,  4 Sep 2005 22:55:29 +1200 (NZST)
In-Reply-To: 
X-Mailer: git-send-email-script
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8057>

Arch tags are full commits (without any changed files) as well. Trust Arch
to have put an unchanged tree in place (which seems to do reliably), and
just add a tag & new branch. Speeds up Arch imports significantly, and leaves
history in a much saner state.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 git-archimport-script |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

55f05e4d4ab662caff10437bdd4de7e8b87f30e0
diff --git a/git-archimport-script b/git-archimport-script
--- a/git-archimport-script
+++ b/git-archimport-script
@@ -227,6 +227,14 @@ foreach my $ps (@psets) {
             
             # find where we are supposed to branch from
             `git checkout -b $ps->{branch} $branchpoint`;
+
+            # If we trust Arch with the fact that this is just 
+            # a tag, and it does not affect the state of the tree
+            # then we just tag and move on
+            tag($ps->{id}, $branchpoint);
+            ptag($ps->{id}, $branchpoint);
+            print " * Tagged $ps->{id} at $branchpoint\n";
+            next;
         } 
         die $! if $?;
     } 
