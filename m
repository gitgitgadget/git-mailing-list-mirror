From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] archimport: Actually cope with merges from "remote" repositories. Plus: Nicer messages.
Date: Fri, 30 Sep 2005 19:15:12 +1200
Message-ID: <11280645122296-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Fri Sep 30 09:15:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELF6N-0007NV-RK
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 09:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbVI3HO0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 03:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbVI3HO0
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 03:14:26 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:33998 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S932575AbVI3HOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 03:14:25 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1ELF68-0006qz-5A; Fri, 30 Sep 2005 19:14:24 +1200
Received: from mltest ([127.0.0.1])
	by mltest with smtp (Exim 3.36 #1 (Debian))
	id 1ELF6v-00014f-00; Fri, 30 Sep 2005 19:15:13 +1200
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9543>

archimport was refusing to import commits that had merges from repositories
that it didn't know about. Fixed.

Also brings in nicer messages.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 git-archimport.perl |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

d118e96e7f08fcd0963eac8d9e6f18e13f553a41
diff --git a/git-archimport.perl b/git-archimport.perl
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -228,10 +228,12 @@ foreach my $ps (@psets) {
     # skip commits already in repo
     #
     if (ptag($ps->{id})) {
-      $opt_v && print "Skipping already imported: $ps->{id}\n";
+      $opt_v && print " * Skipping already imported: $ps->{id}\n";
       next;
     }
 
+    print " * Starting to work on $ps->{id}\n";
+
     # 
     # create the branch if needed
     #
@@ -675,6 +677,10 @@ sub find_parents {
     # that branch.
     #
     foreach my $branch (keys %branches) {
+
+	# check that we actually know about the branch
+	next unless -e "$git_dir/refs/heads/$branch";
+
 	my $mergebase = `git-merge-base $branch $ps->{branch}`;
 	die "Cannot find merge base for $branch and $ps->{branch}" if $?;
 	chomp $mergebase;
