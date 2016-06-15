From: Michael Witten <mfwitten@mit.edu>
Subject: [PATCH 1/3] git-cvsexportcommit.perl tabified
Date: Tue, 16 Oct 2007 04:08:12 -0400
Message-ID: <1192522094-4988-1-git-send-email-mfwitten@mit.edu>
Cc: Michael Witten <mfwitten@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 11:57:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhjAY-0002RG-Ff
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 11:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757645AbXJPJ4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 05:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758204AbXJPJ4d
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 05:56:33 -0400
Received: from WITTEN.MIT.EDU ([18.239.2.43]:51354 "EHLO witten.mit.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757003AbXJPJ42 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 05:56:28 -0400
Received: by witten.mit.edu (Postfix, from userid 501)
	id 88909262127; Tue, 16 Oct 2007 04:08:14 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.4.207.g6d7480-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61135>

Signed-off-by: Michael Witten <mfwitten@mit.edu>
---
    This patch attempts to tabify this code.
    Please be gentle, this is my second time
    submitting a patch.

 git-cvsexportcommit.perl |  284 +++++++++++++++++++++++-----------------------
 1 files changed, 141 insertions(+), 143 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index a33fa8d..b330c3d 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -12,7 +12,7 @@ use Data::Dumper;
 use File::Basename qw(basename dirname);
 
 unless ($ENV{GIT_DIR} && -r $ENV{GIT_DIR}){
-    die "GIT_DIR is not defined or is unreadable";
+	die "GIT_DIR is not defined or is unreadable";
 }
 
 our ($opt_h, $opt_P, $opt_p, $opt_v, $opt_c, $opt_f, $opt_a, $opt_m, $opt_d, $opt_u);
@@ -25,15 +25,13 @@ die "Need at least one commit identifier!" unless @ARGV;
 
 my @cvs;
 if ($opt_d) {
-	@cvs = ('cvs', '-d', $opt_d);
+		@cvs = ('cvs', '-d', $opt_d);
 } else {
-	@cvs = ('cvs');
+		@cvs = ('cvs');
 }
 
 # setup a tempdir
-our ($tmpdir, $tmpdirname) = tempdir('git-cvsapplycommit-XXXXXX',
-				     TMPDIR => 1,
-				     CLEANUP => 1);
+our ($tmpdir, $tmpdirname) = tempdir('git-cvsapplycommit-XXXXXX', TMPDIR => 1, CLEANUP => 1);
 
 # resolve target commit
 my $commit;
@@ -41,18 +39,18 @@ $commit = pop @ARGV;
 $commit = safe_pipe_capture('git-rev-parse', '--verify', "$commit^0");
 chomp $commit;
 if ($?) {
-    die "The commit reference $commit did not resolve!";
+	die "The commit reference $commit did not resolve!";
 }
 
 # resolve what parent we want
 my $parent;
 if (@ARGV) {
-    $parent = pop @ARGV;
-    $parent =  safe_pipe_capture('git-rev-parse', '--verify', "$parent^0");
-    chomp $parent;
-    if ($?) {
-	die "The parent reference did not resolve!";
-    }
+	$parent = pop @ARGV;
+	$parent =  safe_pipe_capture('git-rev-parse', '--verify', "$parent^0");
+	chomp $parent;
+	if ($?) {
+		die "The parent reference did not resolve!";
+	}
 }
 
 # find parents from the commit itself
@@ -65,44 +63,44 @@ my $title;
 my $msg = '';
 
 foreach my $line (@commit) {
-    chomp $line;
-    if ($stage eq 'headers' && $line eq '') {
-	$stage = 'msg';
-	next;
-    }
-
-    if ($stage eq 'headers') {
-	if ($line =~ m/^parent (\w{40})$/) { # found a parent
-	    push @parents, $1;
-	} elsif ($line =~ m/^author (.+) \d+ [-+]\d+$/) {
-	    $author = $1;
-	} elsif ($line =~ m/^committer (.+) \d+ [-+]\d+$/) {
-	    $committer = $1;
+	chomp $line;
+	if ($stage eq 'headers' && $line eq '') {
+		$stage = 'msg';
+		next;
 	}
-    } else {
-	$msg .= $line . "\n";
-	unless ($title) {
-	    $title = $line;
+
+	if ($stage eq 'headers') {
+		if ($line =~ m/^parent (\w{40})$/) { # found a parent
+			push @parents, $1;
+		} elsif ($line =~ m/^author (.+) \d+ [-+]\d+$/) {
+			$author = $1;
+		} elsif ($line =~ m/^committer (.+) \d+ [-+]\d+$/) {
+			$committer = $1;
+		}
+	} else {
+		$msg .= $line . "\n";
+		unless ($title) {
+			$title = $line;
+		}
 	}
-    }
 }
 
 if ($parent) {
-    my $found;
-    # double check that it's a valid parent
-    foreach my $p (@parents) {
-	if ($p eq $parent) {
-	    $found = 1;
-	    last;
-	}; # found it
-    }
-    die "Did not find $parent in the parents for this commit!" if !$found and !$opt_P;
+	my $found;
+	# double check that it's a valid parent
+	foreach my $p (@parents) {
+		if ($p eq $parent) {
+			$found = 1;
+			last;
+		}; # found it
+	}
+	die "Did not find $parent in the parents for this commit!" if !$found and !$opt_P;
 } else { # we don't have a parent from the cmdline...
-    if (@parents == 1) { # it's safe to get it from the commit
-	$parent = $parents[0];
-    } else { # or perhaps not!
-	die "This commit has more than one parent -- please name the parent you want to use explicitly";
-    }
+	if (@parents == 1) { # it's safe to get it from the commit
+		$parent = $parents[0];
+	} else { # or perhaps not!
+		die "This commit has more than one parent -- please name the parent you want to use explicitly";
+	}
 }
 
 $opt_v && print "Applying to CVS commit $commit from parent $parent\n";
@@ -110,14 +108,14 @@ $opt_v && print "Applying to CVS commit $commit from parent $parent\n";
 # grab the commit message
 open(MSG, ">.msg") or die "Cannot open .msg for writing";
 if ($opt_m) {
-    print MSG $opt_m;
+	print MSG $opt_m;
 }
 print MSG $msg;
 if ($opt_a) {
-    print MSG "\n\nAuthor: $author\n";
-    if ($author ne $committer) {
-	print MSG "Committer: $committer\n";
-    }
+	print MSG "\n\nAuthor: $author\n";
+	if ($author ne $committer) {
+		print MSG "Committer: $committer\n";
+	}
 }
 close MSG;
 
@@ -153,70 +151,70 @@ map { s/\\([0-7]{3})/sprintf('%c',oct $1)/eg } @bfiles,@files;
 my $dirty;
 my @dirs;
 foreach my $p (@afiles) {
-    my $path = dirname $p;
-    while (!-d $path and ! grep { $_ eq $path } @dirs) {
-	unshift @dirs, $path;
-	$path = dirname $path;
-    }
+	my $path = dirname $p;
+	while (!-d $path and ! grep { $_ eq $path } @dirs) {
+		unshift @dirs, $path;
+		$path = dirname $path;
+	}
 }
 
 # ... check dirs,
 foreach my $d (@dirs) {
-    if (-e $d) {
-	$dirty = 1;
-	warn "$d exists and is not a directory!\n";
-    }
+	if (-e $d) {
+		$dirty = 1;
+		warn "$d exists and is not a directory!\n";
+	}
 }
 
 # ... query status of all files that we have a directory for and parse output of 'cvs status' to %cvsstat.
 my @canstatusfiles;
 foreach my $f (@files) {
-    my $path = dirname $f;
-    next if (grep { $_ eq $path } @dirs);
-    push @canstatusfiles, $f;
+	my $path = dirname $f;
+	next if (grep { $_ eq $path } @dirs);
+	push @canstatusfiles, $f;
 }
 
 my %cvsstat;
 if (@canstatusfiles) {
-    if ($opt_u) {
-      my @updated = safe_pipe_capture(@cvs, 'update', @canstatusfiles);
-      print @updated;
-    }
-    my @cvsoutput;
-    @cvsoutput= safe_pipe_capture(@cvs, 'status', @canstatusfiles);
-    my $matchcount = 0;
-    foreach my $l (@cvsoutput) {
-        chomp $l;
-        if ( $l =~ /^File:/ and  $l =~ /Status: (.*)$/ ) {
-            $cvsstat{$canstatusfiles[$matchcount]} = $1;
-            $matchcount++;
-        }
-    }
+	if ($opt_u) {
+	  my @updated = safe_pipe_capture(@cvs, 'update', @canstatusfiles);
+	  print @updated;
+	}
+	my @cvsoutput;
+	@cvsoutput= safe_pipe_capture(@cvs, 'status', @canstatusfiles);
+	my $matchcount = 0;
+	foreach my $l (@cvsoutput) {
+		chomp $l;
+		if ( $l =~ /^File:/ and  $l =~ /Status: (.*)$/ ) {
+			$cvsstat{$canstatusfiles[$matchcount]} = $1;
+			$matchcount++;
+		}
+	}
 }
 
 # ... validate new files,
 foreach my $f (@afiles) {
-    if (defined ($cvsstat{$f}) and $cvsstat{$f} ne "Unknown") {
-	$dirty = 1;
-	warn "File $f is already known in your CVS checkout -- perhaps it has been added by another user. Or this may indicate that it exists on a different branch. If this is the case, use -f to force the merge.\n";
-	warn "Status was: $cvsstat{$f}\n";
-    }
+	if (defined ($cvsstat{$f}) and $cvsstat{$f} ne "Unknown") {
+		$dirty = 1;
+		warn "File $f is already known in your CVS checkout -- perhaps it has been added by another user. Or this may indicate that it exists on a different branch. If this is the case, use -f to force the merge.\n";
+		warn "Status was: $cvsstat{$f}\n";
+	}
 }
 # ... validate known files.
 foreach my $f (@files) {
-    next if grep { $_ eq $f } @afiles;
-    # TODO:we need to handle removed in cvs
-    unless (defined ($cvsstat{$f}) and $cvsstat{$f} eq "Up-to-date") {
-	$dirty = 1;
-	warn "File $f not up to date but has status '$cvsstat{$f}' in your CVS checkout!\n";
-    }
+	next if grep { $_ eq $f } @afiles;
+	# TODO:we need to handle removed in cvs
+	unless (defined ($cvsstat{$f}) and $cvsstat{$f} eq "Up-to-date") {
+		$dirty = 1;
+		warn "File $f not up to date but has status '$cvsstat{$f}' in your CVS checkout!\n";
+	}
 }
 if ($dirty) {
-    if ($opt_f) {	warn "The tree is not clean -- forced merge\n";
-	$dirty = 0;
-    } else {
-	die "Exiting: your CVS tree is not clean for this merge.";
-    }
+	if ($opt_f) {		warn "The tree is not clean -- forced merge\n";
+		$dirty = 0;
+	} else {
+		die "Exiting: your CVS tree is not clean for this merge.";
+	}
 }
 
 print "Applying\n";
@@ -225,30 +223,30 @@ print "Applying\n";
 print "Patch applied successfully. Adding new files and directories to CVS\n";
 my $dirtypatch = 0;
 foreach my $d (@dirs) {
-    if (system(@cvs,'add',$d)) {
-	$dirtypatch = 1;
-	warn "Failed to cvs add directory $d -- you may need to do it manually";
-    }
+	if (system(@cvs,'add',$d)) {
+		$dirtypatch = 1;
+		warn "Failed to cvs add directory $d -- you may need to do it manually";
+	}
 }
 
 foreach my $f (@afiles) {
-    if (grep { $_ eq $f } @bfiles) {
-      system(@cvs, 'add','-kb',$f);
-    } else {
-      system(@cvs, 'add', $f);
-    }
-    if ($?) {
-	$dirtypatch = 1;
-	warn "Failed to cvs add $f -- you may need to do it manually";
-    }
+	if (grep { $_ eq $f } @bfiles) {
+		system(@cvs, 'add','-kb',$f);
+	} else {
+		system(@cvs, 'add', $f);
+	}
+	if ($?) {
+		$dirtypatch = 1;
+		warn "Failed to cvs add $f -- you may need to do it manually";
+	}
 }
 
 foreach my $f (@dfiles) {
-    system(@cvs, 'rm', '-f', $f);
-    if ($?) {
-	$dirtypatch = 1;
-	warn "Failed to cvs rm -f $f -- you may need to do it manually";
-    }
+	system(@cvs, 'rm', '-f', $f);
+	if ($?) {
+		$dirtypatch = 1;
+		warn "Failed to cvs rm -f $f -- you may need to do it manually";
+	}
 }
 
 print "Commit to CVS\n";
@@ -257,25 +255,25 @@ my @commitfiles = map { unless (m/\s/) { '\''.$_.'\''; } else { $_; }; } (@files
 my $cmd = join(' ', @cvs)." commit -F .msg @commitfiles";
 
 if ($dirtypatch) {
-    print "NOTE: One or more hunks failed to apply cleanly.\n";
-    print "You'll need to apply the patch in .cvsexportcommit.diff manually\n";
-    print "using a patch program. After applying the patch and resolving the\n";
-    print "problems you may commit using:";
-    print "\n    $cmd\n\n";
-    exit(1);
+	print "NOTE: One or more hunks failed to apply cleanly.\n";
+	print "You'll need to apply the patch in .cvsexportcommit.diff manually\n";
+	print "using a patch program. After applying the patch and resolving the\n";
+	print "problems you may commit using:";
+	print "\n	$cmd\n\n";
+	exit(1);
 }
 
 if ($opt_c) {
-    print "Autocommit\n  $cmd\n";
-    print safe_pipe_capture(@cvs, 'commit', '-F', '.msg', @files);
-    if ($?) {
-	die "Exiting: The commit did not succeed";
-    }
-    print "Committed successfully to CVS\n";
-    # clean up
-    unlink(".msg");
+	print "Autocommit\n  $cmd\n";
+	print safe_pipe_capture(@cvs, 'commit', '-F', '.msg', @files);
+	if ($?) {
+		die "Exiting: The commit did not succeed";
+	}
+	print "Committed successfully to CVS\n";
+	# clean up
+	unlink(".msg");
 } else {
-    print "Ready for you to commit, just run:\n\n   $cmd\n";
+	print "Ready for you to commit, just run:\n\n   $cmd\n";
 }
 
 # clean up
@@ -297,25 +295,25 @@ END
 # to work around shell problems with weird characters in arguments
 # if the exec returns non-zero we die
 sub safe_pipe_capture {
-    my @output;
-    if (my $pid = open my $child, '-|') {
-	@output = (<$child>);
-	close $child or die join(' ',@_).": $! $?";
-    } else {
-	exec(@_) or die "$! $?"; # exec() can fail the executable can't be found
-    }
-    return wantarray ? @output : join('',@output);
+	my @output;
+	if (my $pid = open my $child, '-|') {
+		@output = (<$child>);
+		close $child or die join(' ',@_).": $! $?";
+	} else {
+		exec(@_) or die "$! $?"; # exec() can fail the executable can't be found
+	}
+	return wantarray ? @output : join('',@output);
 }
 
 sub safe_pipe_capture_blob {
-    my $output;
-    if (my $pid = open my $child, '-|') {
-        local $/;
-	undef $/;
-	$output = (<$child>);
-	close $child or die join(' ',@_).": $! $?";
-    } else {
-	exec(@_) or die "$! $?"; # exec() can fail the executable can't be found
-    }
-    return $output;
+	my $output;
+	if (my $pid = open my $child, '-|') {
+		local $/;
+		undef $/;
+		$output = (<$child>);
+		close $child or die join(' ',@_).": $! $?";
+	} else {
+		exec(@_) or die "$! $?"; # exec() can fail the executable can't be found
+	}
+	return $output;
 }
-- 
1.5.3.4.207.g6d7480-dirty
