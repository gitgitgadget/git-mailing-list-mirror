From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: snapshot cleanups & support for offering multiple formats
Date: Sun, 22 Jul 2007 01:30:27 +0200
Message-ID: <200707220130.28516.jnareb@gmail.com>
References: <3bbc18d20707171103q262eaa8amb319ca9f835dbf67@mail.gmail.com> <1184699486.9831.7.camel@mattlaptop2>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>, Luben Tuikov <ltuikov@yahoo.com>
To: Matt McCutchen <hashproduct@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 01:26:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICOKl-0007u0-FQ
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 01:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbXGUXZp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 19:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbXGUXZp
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 19:25:45 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:32932 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbXGUXZn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 19:25:43 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1963340mue
        for <git@vger.kernel.org>; Sat, 21 Jul 2007 16:25:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LacavVXJiHadBCzW5rIxKD1zfTcqfE7v4h5mFsJj8Z6n05w4oPOtXLo66vIDoFiTU884ORmYbbuZSM5rnFLW8Wx0NP4+jI+eiywVOMHaq5ZGIWcmeMUcOGAqRE9coJ74V/gHMDxzZJHO5at6LOGkUx1eZ5jtnishY+fi5bDPinA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pHYTHkdbHOHGQLhuBoSi/lBTgCzlknaywSYE7kTs54KMebdBnyHjeNWD8O+ss1mIKtTzlsQZ5UlksQfRYbdhPWPt4enZ6cF4lSRc45SB6LVNo3PiahH7+pTrToPKnJkPPb1rBwaZwUeMGzIfOE53XsH7kwF0D/nXPHH/1aixR+o=
Received: by 10.86.65.11 with SMTP id n11mr1408388fga.1185060341062;
        Sat, 21 Jul 2007 16:25:41 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id 31sm10337407fkt.2007.07.21.16.25.37
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Jul 2007 16:25:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1184699486.9831.7.camel@mattlaptop2>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53196>

From: Matt McCutchen <hashproduct@gmail.com>
Subject: [PATCH] gitweb: snapshot cleanups & support for offering multiple formats

- Centralize knowledge about snapshot formats (mime types, extensions,
  commands) in %known_snapshot_formats and improve how some of that
  information is specified.  In particular, zip files are no longer a
  special case.

- Add support for offering multiple snapshot formats to the user so
  that he/she can download a snapshot in the format he/she prefers.
  The site-wide or project configuration now gives a list of formats
  to offer, and if more than one format is offered, the "_snapshot_"
  link becomes something like "snapshot (_tar.bz2_ _zip_)".

- If only one format is offered, a tooltip on the "_snapshot_" link
  tells the user what it is.

- Fix out-of-date "tarball" -> "archive" in comment.

Alert for gitweb site administrators: This patch changes the format of
$feature{'snapshot'}{'default'} in gitweb_config.perl from a list of
three pieces of information about a single format to a list of one or
more formats you wish to offer from the set ('tgz', 'tbz2', 'zip').
Update your gitweb_config.perl appropriately.  There was taken care
for old-style gitweb configuration to work as it used to, but this
backward compatibility works only for the values which correspond to
gitweb.snapshot values of 'gzip', 'bzip2' and 'zip', i.e.
  ['x-gzip', 'gz', 'gzip']
  ['x-bzip2', 'bz2', 'bzip2']
  ['x-zip', 'zip', '']

The preferred names for gitweb.snapshot in repository configuration
have also changed from 'gzip' and 'bzip2' to 'tgz' and 'tbz2', but
the old names are still recognized for compatibility.

Signed-off-by: Matt McCutchen <hashproduct@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This tries to address concerns that was raised in this thread.
Namely:
 - hash is used instead of fixed order of mixed arguments array
 - it tries to be backward compatibile wrt. gitweb config

 gitweb/gitweb.perl |  166 ++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 116 insertions(+), 50 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6754e26..c4f8824 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -114,6 +114,49 @@ our $fallback_encoding = 'latin1';
 # - one might want to include '-B' option, e.g. '-B', '-M'
 our @diff_opts = ('-M'); # taken from git_commit
 
+# information about snapshot formats that gitweb is capable of serving
+our %known_snapshot_formats = (
+	# name => {
+	# 	'display' => display name,
+	# 	'type' => mime type,
+	# 	'suffix' => filename suffix,
+	# 	'format' => --format for git-archive,
+	# 	'compressor' => [compressor command and arguments]
+	# 	                (array reference, optional)}
+	#
+	'tgz' => {
+		'display' => 'tar.gz',
+		'type' => 'application/x-gzip',
+		'suffix' => '.tar.gz',
+		'format' => 'tar',
+		'compressor' => ['gzip']},
+
+	'tbz2' => {
+		'display' => 'tar.bz2',
+		'type' => 'application/x-bzip2',
+		'suffix' => '.tar.bz2',
+		'format' => 'tar',
+		'compressor' => ['bzip2']},
+
+	'zip' => {
+		'display' => 'zip',
+		'type' => 'application/x-zip',
+		'suffix' => '.zip',
+		'format' => 'zip'},
+);
+
+# Aliases so we understand old gitweb.snapshot values in repository
+# configuration.
+our %known_snapshot_format_aliases = (
+	'gzip'  => 'tgz',
+	'bzip2' => 'tbz2',
+
+	# backward compatibility: legacy gitweb config support
+	'x-gzip' => undef, 'gz' => undef,
+	'x-bzip2' => undef, 'bz2' => undef,
+	'x-zip' => undef, '' => undef,
+);
+
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
 our %feature = (
@@ -144,20 +187,22 @@ our %feature = (
 		'override' => 0,
 		'default' => [0]},
 
-	# Enable the 'snapshot' link, providing a compressed tarball of any
+	# Enable the 'snapshot' link, providing a compressed archive of any
 	# tree. This can potentially generate high traffic if you have large
 	# project.
 
+	# Value is a list of formats defined in %known_snapshot_formats that
+	# you wish to offer.
 	# To disable system wide have in $GITWEB_CONFIG
-	# $feature{'snapshot'}{'default'} = [undef];
+	# $feature{'snapshot'}{'default'} = [];
 	# To have project specific config enable override in $GITWEB_CONFIG
 	# $feature{'snapshot'}{'override'} = 1;
-	# and in project config gitweb.snapshot = none|gzip|bzip2|zip;
+	# and in project config, a comma-separated list of formats or "none"
+	# to disable.  Example: gitweb.snapshot = tbz2,zip;
 	'snapshot' => {
 		'sub' => \&feature_snapshot,
 		'override' => 0,
-		#         => [content-encoding, suffix, program]
-		'default' => ['x-gzip', 'gz', 'gzip']},
+		'default' => ['tgz']},
 
 	# Enable text search, which will list the commits which match author,
 	# committer or commit text to a given string.  Enabled by default.
@@ -256,28 +301,19 @@ sub feature_blame {
 }
 
 sub feature_snapshot {
-	my ($ctype, $suffix, $command) = @_;
+	my (@fmts) = @_;
 
 	my ($val) = git_get_project_config('snapshot');
 
-	if ($val eq 'gzip') {
-		return ('x-gzip', 'gz', 'gzip');
-	} elsif ($val eq 'bzip2') {
-		return ('x-bzip2', 'bz2', 'bzip2');
-	} elsif ($val eq 'zip') {
-		return ('x-zip', 'zip', '');
-	} elsif ($val eq 'none') {
-		return ();
+	if ($val) {
+		@fmts = ($val eq 'none' ? () : split /\s*[,\s]\s*/, $val);
+		@fmts = grep { defined } map {
+			exists $known_snapshot_format_aliases{$_} ?
+				$known_snapshot_format_aliases{$_} : $_ } @fmts;
+		@fmts = grep(exists $known_snapshot_formats{$_}, @fmts);
 	}
 
-	return ($ctype, $suffix, $command);
-}
-
-sub gitweb_have_snapshot {
-	my ($ctype, $suffix, $command) = gitweb_check_feature('snapshot');
-	my $have_snapshot = (defined $ctype && defined $suffix);
-
-	return $have_snapshot;
+	return @fmts;
 }
 
 sub feature_grep {
@@ -563,6 +599,7 @@ sub href(%) {
 		order => "o",
 		searchtext => "s",
 		searchtype => "st",
+		snapshot_format => "sf",
 	);
 	my %mapping = @mapping;
 
@@ -1257,6 +1294,39 @@ sub format_diff_line {
 	return "<div class=\"diff$diff_class\">" . esc_html($line, -nbsp=>1) . "</div>\n";
 }
 
+# Generates undef or something like "_snapshot_" or "snapshot (_tbz2_ _zip_)",
+# linked.  Pass the hash of the tree/commit to snapshot.
+sub format_snapshot_links {
+	my ($hash) = @_;
+	my @snapshot_fmts = gitweb_check_feature('snapshot');
+	my $num_fmts = @snapshot_fmts;
+	if ($num_fmts > 1) {
+		# A parenthesized list of links bearing format names.
+		return "snapshot (" . join(' ', map
+			$cgi->a({
+				-href => href(
+					action=>"snapshot",
+					hash=>$hash,
+					snapshot_format=>$_
+				)
+			}, $known_snapshot_formats{$_}{'display'})
+		, @snapshot_fmts) . ")";
+	} elsif ($num_fmts == 1) {
+		# A single "snapshot" link whose tooltip bears the format name.
+		my ($fmt) = @snapshot_fmts;
+		return $cgi->a({
+				-href => href(
+					action=>"snapshot",
+					hash=>$hash,
+					snapshot_format=>$fmt
+				),
+				-title => "in format: $known_snapshot_formats{$fmt}{'display'}"
+			}, "snapshot");
+	} else { # $num_fmts == 0
+		return undef;
+	}
+}
+
 ## ----------------------------------------------------------------------
 ## git utility subroutines, invoking git commands
 
@@ -3321,8 +3391,6 @@ sub git_shortlog_body {
 	# uses global variable $project
 	my ($commitlist, $from, $to, $refs, $extra) = @_;
 
-	my $have_snapshot = gitweb_have_snapshot();
-
 	$from = 0 unless defined $from;
 	$to = $#{$commitlist} if (!defined $to || $#{$commitlist} < $to);
 
@@ -3349,8 +3417,9 @@ sub git_shortlog_body {
 		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") . " | " .
 		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") . " | " .
 		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree");
-		if ($have_snapshot) {
-			print " | " . $cgi->a({-href => href(action=>"snapshot", hash=>$commit)}, "snapshot");
+		my $snapshot_links = format_snapshot_links($commit);
+		if (defined $snapshot_links) {
+			print " | " . $snapshot_links;
 		}
 		print "</td>\n" .
 		      "</tr>\n";
@@ -4132,8 +4201,6 @@ sub git_blob {
 }
 
 sub git_tree {
-	my $have_snapshot = gitweb_have_snapshot();
-
 	if (!defined $hash_base) {
 		$hash_base = "HEAD";
 	}
@@ -4167,11 +4234,10 @@ sub git_tree {
 				                       hash_base=>"HEAD", file_name=>$file_name)},
 				        "HEAD"),
 		}
-		if ($have_snapshot) {
+		my $snapshot_links = format_snapshot_links($hash);
+		if (defined $snapshot_links) {
 			# FIXME: Should be available when we have no hash base as well.
-			push @views_nav,
-				$cgi->a({-href => href(action=>"snapshot", hash=>$hash)},
-				        "snapshot");
+			push @views_nav, $snapshot_links;
 		}
 		git_print_page_nav('tree','', $hash_base, undef, undef, join(' | ', @views_nav));
 		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash_base);
@@ -4235,33 +4301,36 @@ sub git_tree {
 }
 
 sub git_snapshot {
-	my ($ctype, $suffix, $command) = gitweb_check_feature('snapshot');
-	my $have_snapshot = (defined $ctype && defined $suffix);
-	if (!$have_snapshot) {
-		die_error('403 Permission denied', "Permission denied");
+	my @supported_fmts = gitweb_check_feature('snapshot');
+
+	my $format = $cgi->param('sf');
+	unless ($format =~ m/[a-z0-9]+/
+		&& exists($known_snapshot_formats{$format})
+		&& grep($_ eq $format, @supported_fmts)) {
+		die_error(undef, "Unsupported snapshot format");
 	}
 
 	if (!defined $hash) {
 		$hash = git_get_head_hash($project);
 	}
 
-	my $git = git_cmd_str();
+	my $git_command = git_cmd_str();
 	my $name = $project;
 	$name =~ s,([^/])/*\.git$,$1,;
 	$name = basename($name);
 	my $filename = to_utf8($name);
 	$name =~ s/\047/\047\\\047\047/g;
 	my $cmd;
-	if ($suffix eq 'zip') {
-		$filename .= "-$hash.$suffix";
-		$cmd = "$git archive --format=zip --prefix=\'$name\'/ $hash";
-	} else {
-		$filename .= "-$hash.tar.$suffix";
-		$cmd = "$git archive --format=tar --prefix=\'$name\'/ $hash | $command";
+	$filename .= "-$hash$known_snapshot_formats{$format}{'suffix'}";
+	$cmd = "$git_command archive " .
+		"--format=$known_snapshot_formats{$format}{'format'}" .
+		"--prefix=\'$name\'/ $hash";
+	if (exists $known_snapshot_formats{$format}{'compressor'}) {
+		$cmd .= ' | ' . join ' ', @{$known_snapshot_formats{$format}{'compressor'}};
 	}
 
 	print $cgi->header(
-		-type => "application/$ctype",
+		-type => $known_snapshot_formats{$format}{'type'},
 		-content_disposition => 'inline; filename="' . "$filename" . '"',
 		-status => '200 OK');
 
@@ -4271,7 +4340,6 @@ sub git_snapshot {
 	print <$fd>;
 	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
 	close $fd;
-
 }
 
 sub git_log {
@@ -4390,8 +4458,6 @@ sub git_commit {
 	my $refs = git_get_references();
 	my $ref = format_ref_marker($refs, $co{'id'});
 
-	my $have_snapshot = gitweb_have_snapshot();
-
 	git_header_html(undef, $expires);
 	git_print_page_nav('commit', '',
 	                   $hash, $co{'tree'}, $hash,
@@ -4430,9 +4496,9 @@ sub git_commit {
 	      "<td class=\"link\">" .
 	      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$hash)},
 	              "tree");
-	if ($have_snapshot) {
-		print " | " .
-		      $cgi->a({-href => href(action=>"snapshot", hash=>$hash)}, "snapshot");
+	my $snapshot_links = format_snapshot_links($hash);
+	if (defined $snapshot_links) {
+		print " | " . $snapshot_links;
 	}
 	print "</td>" .
 	      "</tr>\n";
-- 
1.5.2.4
