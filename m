From: martin@catalyst.net.nz
Subject: [PATCH 3/5] archimport - update in-script doco, options tidyup
Date: Sun, 11 Sep 2005 21:26:05 +1200
Message-ID: <11264307653007-git-send-email-martin@catalyst.net.nz>
References: <1126430765435-git-send-email-martin@catalyst.net.nz>
Reply-To: martin@catalyst.net.nz
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sun Sep 11 11:26:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEO6O-0005zt-KA
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 11:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbVIKJ0R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 05:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbVIKJ0R
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 05:26:17 -0400
Received: from 202-0-36-112.cable.paradise.net.nz ([202.0.36.112]:9939 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S964832AbVIKJ0P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 05:26:15 -0400
Received: from aporo-debian (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (Postfix) with SMTP id AD7FF8A72D;
	Sun, 11 Sep 2005 21:26:05 +1200 (NZST)
In-Reply-To: <1126430765435-git-send-email-martin@catalyst.net.nz>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8283>

Updated the usage/help message to match asciidoc documentation. The perldoc
documentation now includes the first paragraph from the asciidoc documentation
and points users to the manpage.

Updated TODO section.

Removed some redundant options from the getopt() invocation.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 git-archimport.perl |   33 ++++++++++++++++-----------------
 1 files changed, 16 insertions(+), 17 deletions(-)

8d625fb42f58a6b4b2af135efe76726e8f0579e0
diff --git a/git-archimport.perl b/git-archimport.perl
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -6,23 +6,27 @@
 # The basic idea is to walk the output of tla abrowse, 
 # fetch the changesets and apply them. 
 #
+
 =head1 Invocation
 
-    git-archimport -i <archive>/<branch> [<archive>/<branch>]
-    [ <archive>/<branch> ]
+    git-archimport [ -h ] [ -v ] [ -T ] [ -t tempdir ] <archive>/<branch> [ <archive>/<branch> ]
 
-    The script expects you to provide the key roots where it can start the
-    import from an 'initial import' or 'tag' type of Arch commit. It will
-    then follow all the branching and tagging within the provided roots.
+Imports a project from one or more Arch repositories. It will follow branches
+and repositories within the namespaces defined by the <archive/branch>
+parameters suppplied. If it cannot find the remote branch a merge comes from
+it will just import it as a regular commit. If it can find it, it will mark it 
+as a merge whenever possible.
 
-    It will die if it sees branches that have different roots. 
+See man (1) git-archimport for more details.
 
-=head2 TODO
+=head1 TODO
 
- - keep track of merged patches, and mark a git merge when it happens
- - smarter rules to parse the archive history "up" and "down"
- - be able to continue an import where we left off
+ - create tag objects instead of ref tags
  - audit shell-escaping of filenames
+ - better handling of temp directories
+ - use GIT_DIR instead of hardcoded ".git"
+ - hide our private tags somewhere smarter
+ - find a way to make "cat *patches | patch" safe even when patchfiles are missing newlines  
 
 =head1 Devel tricks
 
@@ -54,14 +58,13 @@ our($opt_h,$opt_v, $opt_T,
 sub usage() {
     print STDERR <<END;
 Usage: ${\basename $0}     # fetch/update GIT from Arch
-       [ -h ] [ -v ] [ -T ] 
-       [ -C GIT_repository ] [ -t tempdir ] 
+       [ -h ] [ -v ] [ -T ] [ -t tempdir ] 
        repository/arch-branch [ repository/arch-branch] ...
 END
     exit(1);
 }
 
-getopts("ThviC:t:") or usage();
+getopts("Thvt:") or usage();
 usage if $opt_h;
 
 @ARGV >= 1 or usage();
@@ -71,10 +74,6 @@ my $tmp = $opt_t;
 $tmp ||= '/tmp';
 $tmp .= '/git-archimport/';
 
-my $git_tree = $opt_C;
-$git_tree ||= ".";
-
-
 my @psets  = ();                # the collection
 my %psets  = ();                # the collection, by name
 
