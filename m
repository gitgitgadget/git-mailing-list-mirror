From: Byron Bradley <byronb@picochip.com>
Subject: [PATCH] git-cvsserver: use non-dashed git commands
Date: Wed, 15 Apr 2009 12:21:07 +0100 (BST)
Message-ID: <alpine.LRH.2.00.0904151218570.885@dunsop.picochip.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 13:38:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu3Rg-0000tf-HB
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 13:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759711AbZDOLf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 07:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759470AbZDOLf6
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 07:35:58 -0400
Received: from mail2.picochip.com ([82.111.145.34]:43480 "EHLO
	arun.picochip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759451AbZDOLf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 07:35:56 -0400
X-Greylist: delayed 936 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Apr 2009 07:35:54 EDT
Received: from dunsop.picochip.com (dunsop.picochip.com [172.17.1.250])
	by arun.picochip.com (8.13.1/8.13.1) with ESMTP id n3FBKGEQ032545
	for <git@vger.kernel.org>; Wed, 15 Apr 2009 12:20:16 +0100
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (arun.picochip.com [172.17.0.30]); Wed, 15 Apr 2009 12:20:16 +0100 (BST)
X-Virus-Scanned: ClamAV version 0.91.2, clamav-milter version 0.91.2 on arun.picochip.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116605>


Signed-off-by: Byron Bradley <byronb@picochip.com>
---
 git-cvsserver.perl |   42 +++++++++++++++++++++---------------------
 1 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index ab6cea3..c320ee9 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -285,7 +285,7 @@ sub req_Root
        return 0;
     }
 
-    my @gitvars = `git-config -l`;
+    my @gitvars = `git config -l`;
     if ($?) {
        print "E problems executing git-config on the server -- this is not a git repository or the PATH is not set correctly.\n";
         print "E \n";
@@ -702,7 +702,7 @@ sub req_Modified
     # Save the file data in $state
     $state->{entries}{$state->{directory}.$data}{modified_filename} = $filename;
     $state->{entries}{$state->{directory}.$data}{modified_mode} = $mode;
-    $state->{entries}{$state->{directory}.$data}{modified_hash} = `git-hash-object $filename`;
+    $state->{entries}{$state->{directory}.$data}{modified_hash} = `git hash-object $filename`;
     $state->{entries}{$state->{directory}.$data}{modified_hash} =~ s/\s.*$//s;
 
     #$log->debug("req_Modified : file=$data mode=$mode size=$size");
@@ -1289,7 +1289,7 @@ sub req_ci
 
 	# do a checkout of the file if it is part of this tree
         if ($wrev) {
-            system('git-checkout-index', '-f', '-u', $filename);
+            system('git', 'checkout-index', '-f', '-u', $filename);
             unless ($? == 0) {
                 die "Error running git-checkout-index -f -u $filename : $!";
             }
@@ -1331,15 +1331,15 @@ sub req_ci
         {
             $log->info("Removing file '$filename'");
             unlink($filename);
-            system("git-update-index", "--remove", $filename);
+            system("git", "update-index", "--remove", $filename);
         }
         elsif ( $addflag )
         {
             $log->info("Adding file '$filename'");
-            system("git-update-index", "--add", $filename);
+            system("git", "update-index", "--add", $filename);
         } else {
             $log->info("Updating file '$filename'");
-            system("git-update-index", $filename);
+            system("git", "update-index", $filename);
         }
     }
 
@@ -1351,7 +1351,7 @@ sub req_ci
         return;
     }
 
-    my $treehash = `git-write-tree`;
+    my $treehash = `git write-tree`;
     chomp $treehash;
 
     $log->debug("Treehash : $treehash, Parenthash : $parenthash");
@@ -1368,7 +1368,7 @@ sub req_ci
     }
     close $msg_fh;
 
-    my $commithash = `git-commit-tree $treehash -p $parenthash < $msg_filename`;
+    my $commithash = `git commit-tree $treehash -p $parenthash < $msg_filename`;
     chomp($commithash);
     $log->info("Commit hash : $commithash");
 
@@ -1821,7 +1821,7 @@ sub req_annotate
 	# TODO: if we got a revision from the client, use that instead
 	# to look up the commithash in sqlite (still good to default to
 	# the current head as we do now)
-	system("git-read-tree", $lastseenin);
+	system("git", "read-tree", $lastseenin);
 	unless ($? == 0)
 	{
 	    print "E error running git-read-tree $lastseenin $ENV{GIT_INDEX_FILE} $!\n";
@@ -1830,7 +1830,7 @@ sub req_annotate
 	$log->info("Created index '$ENV{GIT_INDEX_FILE}' with commit $lastseenin - exit status $?");
 
         # do a checkout of the file
-        system('git-checkout-index', '-f', '-u', $filename);
+        system('git', 'checkout-index', '-f', '-u', $filename);
         unless ($? == 0) {
             print "E error running git-checkout-index -f -u $filename : $!\n";
             return;
@@ -1861,7 +1861,7 @@ sub req_annotate
         close ANNOTATEHINTS
             or (print "E failed to write $a_hints: $!\n"), return;
 
-        my @cmd = (qw(git-annotate -l -S), $a_hints, $filename);
+        my @cmd = (qw(git annotate -l -S), $a_hints, $filename);
         if (!open(ANNOTATE, "-|", @cmd)) {
             print "E error invoking ". join(' ',@cmd) .": $!\n";
             return;
@@ -2078,17 +2078,17 @@ sub transmitfile
 
     die "Need filehash" unless ( defined ( $filehash ) and $filehash =~ /^[a-zA-Z0-9]{40}$/ );
 
-    my $type = `git-cat-file -t $filehash`;
+    my $type = `git cat-file -t $filehash`;
     chomp $type;
 
     die ( "Invalid type '$type' (expected 'blob')" ) unless ( defined ( $type ) and $type eq "blob" );
 
-    my $size = `git-cat-file -s $filehash`;
+    my $size = `git cat-file -s $filehash`;
     chomp $size;
 
     $log->debug("transmitfile($filehash) size=$size, type=$type");
 
-    if ( open my $fh, '-|', "git-cat-file", "blob", $filehash )
+    if ( open my $fh, '-|', "git", "cat-file", "blob", $filehash )
     {
         if ( defined ( $options->{targetfile} ) )
         {
@@ -2935,7 +2935,7 @@ sub update
         push @git_log_params, $self->{module};
     }
     # git-rev-list is the backend / plumbing version of git-log
-    open(GITLOG, '-|', 'git-rev-list', @git_log_params) or die "Cannot call git-rev-list: $!";
+    open(GITLOG, '-|', 'git', 'rev-list', @git_log_params) or die "Cannot call git rev-list: $!";
 
     my @commits;
 
@@ -3021,7 +3021,7 @@ sub update
                         next;
                     }
 		    my $base = eval {
-			    safe_pipe_capture('git-merge-base',
+			    safe_pipe_capture('git', 'merge-base',
 						 $lastpicked, $parent);
 		    };
 		    # The two branches may not be related at all,
@@ -3033,8 +3033,8 @@ sub update
                     if ($base) {
                         my @merged;
                         # print "want to log between  $base $parent \n";
-                        open(GITLOG, '-|', 'git-log', '--pretty=medium', "$base..$parent")
-			  or die "Cannot call git-log: $!";
+                        open(GITLOG, '-|', 'git', 'log', '--pretty=medium', "$base..$parent")
+			  or die "Cannot call git log: $!";
                         my $mergedhash;
                         while (<GITLOG>) {
                             chomp;
@@ -3075,7 +3075,7 @@ sub update
 
         if ( defined ( $lastpicked ) )
         {
-            my $filepipe = open(FILELIST, '-|', 'git-diff-tree', '-z', '-r', $lastpicked, $commit->{hash}) or die("Cannot call git-diff-tree : $!");
+            my $filepipe = open(FILELIST, '-|', 'git', 'diff-tree', '-z', '-r', $lastpicked, $commit->{hash}) or die("Cannot call git diff-tree : $!");
 	    local ($/) = "\0";
             while ( <FILELIST> )
             {
@@ -3149,7 +3149,7 @@ sub update
             # this is used to detect files removed from the repo
             my $seen_files = {};
 
-            my $filepipe = open(FILELIST, '-|', 'git-ls-tree', '-z', '-r', $commit->{hash}) or die("Cannot call git-ls-tree : $!");
+            my $filepipe = open(FILELIST, '-|', 'git', 'ls-tree', '-z', '-r', $commit->{hash}) or die("Cannot call git ls-tree : $!");
 	    local $/ = "\0";
             while ( <FILELIST> )
             {
@@ -3451,7 +3451,7 @@ sub commitmessage
         return $message;
     }
 
-    my @lines = safe_pipe_capture("git-cat-file", "commit", $commithash);
+    my @lines = safe_pipe_capture("git", "cat-file", "commit", $commithash);
     shift @lines while ( $lines[0] =~ /\S/ );
     $message = join("",@lines);
     $message .= " " if ( $message =~ /\n$/ );
-- 
1.6.3.rc0.2.g8152.dirty
