From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] annotate: fix -S parameter to take a string
Date: Thu, 2 Mar 2006 17:24:30 +1300
Message-ID: <11412734703272-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Mar 02 05:08:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEf6v-0002uh-4W
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 05:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWCBEIO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 23:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWCBEIO
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 23:08:14 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:24473 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1750917AbWCBEIN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 23:08:13 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1FEf6q-00027L-0n; Thu, 02 Mar 2006 17:08:12 +1300
Received: from mltest ([127.0.0.1])
	by mltest with smtp (Exim 3.36 #1 (Debian))
	id 1FEfMc-0008Vv-00; Thu, 02 Mar 2006 17:24:30 +1300
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17044>

In the conversion to Getopt::Long, the -S / --rev-list parameter stopped
working. We need to tell Getopt::Long that it is a string.

As a bonus, the open() now does some useful error handling.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>

---

Or pull from my cvsserver branch.

---

 git-annotate.perl |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

5a44938cf5b79dd5d056075509f12b8e9a13e941
diff --git a/git-annotate.perl b/git-annotate.perl
index f9c2c6c..31318d3 100755
--- a/git-annotate.perl
+++ b/git-annotate.perl
@@ -31,7 +31,7 @@ our ($help, $longrev, $rename, $starting
 my $rc = GetOptions(	"long|l" => \$longrev,
 			"help|h" => \$help,
 			"rename|r" => \$rename,
-			"rev-file|S" => \$rev_file);
+			"rev-file|S=s" => \$rev_file);
 if (!$rc or $help) {
 	usage();
 }
@@ -174,7 +174,8 @@ sub git_rev_list {
 
 	my $revlist;
 	if ($rev_file) {
-		open($revlist, '<' . $rev_file);
+		open($revlist, '<' . $rev_file)
+		    or die "Failed to open $rev_file : $!";
 	} else {
 		$revlist = open_pipe("git-rev-list","--parents","--remove-empty",$rev,"--",$file)
 			or die "Failed to exec git-rev-list: $!";
-- 
1.2.4.g09a27-dirty
