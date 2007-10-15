From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: [PATCH 5/5] Simplify the handling of fatal errors.
Date: Mon, 15 Oct 2007 17:35:06 +0200
Message-ID: <1192462506-3783-5-git-send-email-tsuna@lrde.epita.fr>
References: <1192462506-3783-1-git-send-email-tsuna@lrde.epita.fr>
 <1192462506-3783-2-git-send-email-tsuna@lrde.epita.fr>
 <1192462506-3783-3-git-send-email-tsuna@lrde.epita.fr>
 <1192462506-3783-4-git-send-email-tsuna@lrde.epita.fr>
Cc: normalperson@yhbt.net, Benoit Sigoure <tsuna@lrde.epita.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 16:37:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhnYG-0006VL-8s
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 16:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932818AbXJPOhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 10:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932758AbXJPOhe
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 10:37:34 -0400
Received: from 1.139.39-62.rev.gaoland.net ([62.39.139.1]:56257 "EHLO
	tsunaxbook.lrde.epita.fr" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754137AbXJPOh2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 10:37:28 -0400
X-Greylist: delayed 82928 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Oct 2007 10:37:28 EDT
Received: by tsunaxbook.lrde.epita.fr (Postfix, from userid 501)
	id 2E667B411D4; Mon, 15 Oct 2007 17:35:07 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.4.214.g6f43
In-Reply-To: <1192462506-3783-4-git-send-email-tsuna@lrde.epita.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61176>

	* git-svn.perl (&fatal): Append the newline at the end of the error
	message.
	Adjust all callers.

Signed-off-by: Benoit Sigoure <tsuna@lrde.epita.fr>
---
 git-svn.perl |   42 +++++++++++++++++++++---------------------
 1 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 466fdd3..1a6aa14 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -21,12 +21,12 @@ $Git::SVN::Log::TZ = $ENV{TZ};
 $ENV{TZ} = 'UTC';
 $| = 1; # unbuffer STDOUT
 
-sub fatal (@) { print STDERR @_; exit 1 }
+sub fatal (@) { print STDERR "@_\n"; exit 1 }
 require SVN::Core; # use()-ing this causes segfaults for me... *shrug*
 require SVN::Ra;
 require SVN::Delta;
 if ($SVN::Core::VERSION lt '1.1.0') {
-	fatal "Need SVN::Core 1.1.0 or better (got $SVN::Core::VERSION)\n";
+	fatal "Need SVN::Core 1.1.0 or better (got $SVN::Core::VERSION)";
 }
 push @Git::SVN::Ra::ISA, 'SVN::Ra';
 push @SVN::Git::Editor::ISA, 'SVN::Delta::Editor';
@@ -369,7 +369,7 @@ sub cmd_set_tree {
 		} elsif (scalar @tmp > 1) {
 			push @revs, reverse(command('rev-list',@tmp));
 		} else {
-			fatal "Failed to rev-parse $c\n";
+			fatal "Failed to rev-parse $c";
 		}
 	}
 	my $gs = Git::SVN->new;
@@ -379,7 +379,7 @@ sub cmd_set_tree {
 		fatal "There are new revisions that were fetched ",
 		      "and need to be merged (or acknowledged) ",
 		      "before committing.\nlast rev: $r_last\n",
-		      " current: $gs->{last_rev}\n";
+		      " current: $gs->{last_rev}";
 	}
 	$gs->set_tree($_) foreach @revs;
 	print "Done committing ",scalar @revs," revisions to SVN\n";
@@ -408,7 +408,7 @@ sub cmd_dcommit {
 			(undef, $last_rev, undef) = cmt_metadata("$d~1");
 			unless (defined $last_rev) {
 				fatal "Unable to extract revision information ",
-				      "from commit $d~1\n";
+				      "from commit $d~1";
 			}
 		}
 		if ($_dry_run) {
@@ -521,7 +521,7 @@ sub cmd_create_ignore {
 		my $ignore = '.' . $path . '.gitignore';
 		my $s = $props->{'svn:ignore'} or return;
 		open(GITIGNORE, '>', $ignore)
-		  or fatal("Failed to open `$ignore' for writing: $!\n");
+		  or fatal("Failed to open `$ignore' for writing: $!");
 		$s =~ s/[\r\n]+/\n/g;
 		chomp $s;
 		# Prefix all patterns so that the ignore doesn't apply
@@ -529,7 +529,7 @@ sub cmd_create_ignore {
 		$s =~ s#^#/#gm;
 		print GITIGNORE "$s\n";
 		close(GITIGNORE)
-		  or fatal("Failed to close `$ignore': $!\n");
+		  or fatal("Failed to close `$ignore': $!");
 		command_noisy('add', $ignore);
 	});
 }
@@ -545,7 +545,7 @@ sub get_svnprops {
 	# prefix THE PATH by the sub-directory from which the user
 	# invoked us.
 	$path = $cmd_dir_prefix . $path;
-	fatal("No such file or directory: $path\n") unless -e $path;
+	fatal("No such file or directory: $path") unless -e $path;
 	my $is_dir = -d $path ? 1 : 0;
 	$path = $gs->{path} . '/' . $path;
 
@@ -581,7 +581,7 @@ sub cmd_propget {
 	my $props = get_svnprops($path);
 	if (not defined $props->{$prop})
 	{
-		fatal("`$path' does not have a `$prop' SVN property.\n");
+		fatal("`$path' does not have a `$prop' SVN property.");
 	}
 	print $props->{$prop} . "\n";
 }
@@ -646,7 +646,7 @@ sub cmd_multi_fetch {
 sub cmd_commit_diff {
 	my ($ta, $tb, $url) = @_;
 	my $usage = "Usage: $0 commit-diff -r<revision> ".
-	            "<tree-ish> <tree-ish> [<URL>]\n";
+	            "<tree-ish> <tree-ish> [<URL>]";
 	fatal($usage) if (!defined $ta || !defined $tb);
 	my $svn_path;
 	if (!defined $url) {
@@ -664,7 +664,7 @@ sub cmd_commit_diff {
 	if (defined $_message && defined $_file) {
 		fatal("Both --message/-m and --file/-F specified ",
 		      "for the commit message.\n",
-		      "I have no idea what you mean\n");
+		      "I have no idea what you mean");
 	}
 	if (defined $_file) {
 		$_message = file_to_s($_file);
@@ -727,7 +727,7 @@ sub complete_svn_url {
 	if ($path !~ m#^[a-z\+]+://#) {
 		if (!defined $url || $url !~ m#^[a-z\+]+://#) {
 			fatal("E: '$path' is not a complete URL ",
-			      "and a separate URL is not specified\n");
+			      "and a separate URL is not specified");
 		}
 		return ($url, $path);
 	}
@@ -748,7 +748,7 @@ sub complete_url_ls_init {
 		$repo_path =~ s#^/+##;
 		unless ($ra) {
 			fatal("E: '$repo_path' is not a complete URL ",
-			      "and a separate URL is not specified\n");
+			      "and a separate URL is not specified");
 		}
 	}
 	my $url = $ra->{url};
@@ -1755,7 +1755,7 @@ sub assert_index_clean {
 		$x = command_oneline('write-tree');
 		if ($y ne $x) {
 			::fatal "trees ($treeish) $y != $x\n",
-			        "Something is seriously wrong...\n";
+			        "Something is seriously wrong...";
 		}
 	});
 }
@@ -2181,7 +2181,7 @@ sub set_tree {
 	my ($self, $tree) = (shift, shift);
 	my $log_entry = ::get_commit_entry($tree);
 	unless ($self->{last_rev}) {
-		fatal("Must have an existing revision to commit\n");
+		fatal("Must have an existing revision to commit");
 	}
 	my %ed_opts = ( r => $self->{last_rev},
 	                log => $log_entry->{log},
@@ -3131,7 +3131,7 @@ sub apply_diff {
 		if (defined $o{$f}) {
 			$self->$f($m);
 		} else {
-			fatal("Invalid change type: $f\n");
+			fatal("Invalid change type: $f");
 		}
 	}
 	$self->rmdirs if $_rmdir;
@@ -3739,15 +3739,15 @@ sub config_pager {
 sub run_pager {
 	return unless -t *STDOUT && defined $pager;
 	pipe my $rfd, my $wfd or return;
-	defined(my $pid = fork) or ::fatal "Can't fork: $!\n";
+	defined(my $pid = fork) or ::fatal "Can't fork: $!";
 	if (!$pid) {
 		open STDOUT, '>&', $wfd or
-		                     ::fatal "Can't redirect to stdout: $!\n";
+		                     ::fatal "Can't redirect to stdout: $!";
 		return;
 	}
-	open STDIN, '<&', $rfd or ::fatal "Can't redirect stdin: $!\n";
+	open STDIN, '<&', $rfd or ::fatal "Can't redirect stdin: $!";
 	$ENV{LESS} ||= 'FRSX';
-	exec $pager or ::fatal "Can't run pager: $! ($pager)\n";
+	exec $pager or ::fatal "Can't run pager: $! ($pager)";
 }
 
 sub tz_to_s_offset {
@@ -3883,7 +3883,7 @@ sub cmd_show_log {
 			$r_min = $r_max = $::_revision;
 		} else {
 			::fatal "-r$::_revision is not supported, use ",
-				"standard \'git log\' arguments instead\n";
+				"standard 'git log' arguments instead";
 		}
 	}
 
-- 
1.5.3.4.214.g6f43
