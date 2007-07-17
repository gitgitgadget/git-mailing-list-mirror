From: Matt McCutchen <hashproduct@gmail.com>
Subject: [PATCH] gitweb: snapshot cleanups & support for offering multiple
	formats
Date: Tue, 17 Jul 2007 15:11:26 -0400
Message-ID: <1184699486.9831.7.camel@mattlaptop2>
References: <3bbc18d20707171103q262eaa8amb319ca9f835dbf67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>, Luben Tuikov <ltuikov@yahoo.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 21:11:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAsSO-0001Dq-25
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 21:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760442AbXGQTLc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 15:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758480AbXGQTLc
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 15:11:32 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:3422 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756426AbXGQTLa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 15:11:30 -0400
Received: by an-out-0708.google.com with SMTP id d31so322518and
        for <git@vger.kernel.org>; Tue, 17 Jul 2007 12:11:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Y4/zJ296Z7FQBCMVKbTU4dUw4Pl37FhmOx9mE1x5pT+a6DYc1YBybBjZ5O+JfFLcJCEUn8eurD+6kbe36RI7lGXozjxE6q3L6wdOxKloMxfYoW0b8bKIhDL5EdJnUPIJvccv/9wVa7RXeOZPKTB5uQKsHo7iz5scy6+b0sVYyQA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=CdrwQeQB9EiOwXQUrxM9/ebgI8s2CMDB8kVDEhqsp8kOMpxT2RmQIFRNtAa9vOrXmL3N7shr2SHpyng8bkIPPv9pjIaGyMyxj8xX7sEWSW/Fy3/4mjrhs+19NSCrrJmILlUQDammV1kkJc8wwA9bDMkfBltArIMQZAuizmcoJoI=
Received: by 10.100.141.13 with SMTP id o13mr395422and.1184699489941;
        Tue, 17 Jul 2007 12:11:29 -0700 (PDT)
Received: from ?192.168.1.10? ( [71.163.72.192])
        by mx.google.com with ESMTPS id d24sm14166and.2007.07.17.12.11.28
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Jul 2007 12:11:29 -0700 (PDT)
In-Reply-To: <3bbc18d20707171103q262eaa8amb319ca9f835dbf67@mail.gmail.com>
X-Mailer: Evolution 2.10.3 (2.10.3-1.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52791>

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
Update your gitweb_config.perl appropriately.  The preferred names for
gitweb.snapshot in repository configuration have also changed from
'gzip' and 'bzip2' to 'tgz' and 'tbz2', but the old names are still
recognized for compatibility.

Signed-off-by: Matt McCutchen <hashproduct@gmail.com>
---

Changes since the previous revision of the patch:

- Added display names.
- Changed compressor command line to list form.
- Added compatibility format aliases for repository configuration.
- Tweaked filtering of unknown formats to apply only to repository
  configuration.
- Reformatted format_snapshot_links and added/modified comments to make it much
  easier to understand.
- When a single snapshot format is offered, added a tooltip showing the format
  to the "snapshot" link.  This helps Junio's hypothetical end user without
  using additional screen real estate.

I thought of another incompatibility: previously bookmarked snapshot
URLs will no longer work because they lack the new "sf" parameter.  I
don't care about this; do any of you?

Is there anything else I need to do to the patch?  If not, how soon is
it likely to be committed?  I'm guessing I missed the boat on git 1.5.3.

Matt

 gitweb/gitweb.perl |  134 +++++++++++++++++++++++++++++++++-------------------
 1 files changed, 86 insertions(+), 48 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c8ba3a2..f17c983 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -104,6 +104,22 @@ our $mimetypes_file = undef;
 # could be even 'utf-8' for the old behavior)
 our $fallback_encoding = 'latin1';
 
+# information about snapshot formats that gitweb is capable of serving
+# name => [display name, mime type, filename suffix, --format for git-archive,
+#          [compressor command and arguments] | undef]
+our %known_snapshot_formats = (
+	'tgz'  => ['tar.gz' , 'application/x-gzip' , '.tar.gz' , 'tar', ['gzip' ]],
+	'tbz2' => ['tar.bz2', 'application/x-bzip2', '.tar.bz2', 'tar', ['bzip2']],
+	'zip'  => ['zip',     'application/x-zip'  , '.zip'    , 'zip', undef    ],
+);
+
+# Aliases so we understand old gitweb.snapshot values in repository
+# configuration.
+our %known_snapshot_format_aliases = (
+	'gzip'  => 'tgz' ,
+	'bzip2' => 'tbz2',
+);
+
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
 our %feature = (
@@ -134,20 +150,22 @@ our %feature = (
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
@@ -246,28 +264,17 @@ sub feature_blame {
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
+		@fmts = ($val eq 'none' ? () : split /,/, $val);
+		@fmts = map $known_snapshot_format_aliases{$_} || $_, @fmts;
+		@fmts = grep exists $known_snapshot_formats{$_}, @fmts;
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
@@ -563,6 +570,7 @@ sub href(%) {
 		order => "o",
 		searchtext => "s",
 		searchtype => "st",
+		snapshot_format => "sf",
 	);
 	my %mapping = @mapping;
 
@@ -1257,6 +1265,39 @@ sub format_diff_line {
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
+			}, $known_snapshot_formats{$_}[0]) # the display name
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
+				-title => "in format: $known_snapshot_formats{$fmt}[0]" # the display name
+			}, "snapshot");
+	} else { # $num_fmts == 0
+		return undef;
+	}
+}
+
 ## ----------------------------------------------------------------------
 ## git utility subroutines, invoking git commands
 
@@ -3321,8 +3362,6 @@ sub git_shortlog_body {
 	# uses global variable $project
 	my ($commitlist, $from, $to, $refs, $extra) = @_;
 
-	my $have_snapshot = gitweb_have_snapshot();
-
 	$from = 0 unless defined $from;
 	$to = $#{$commitlist} if (!defined $to || $#{$commitlist} < $to);
 
@@ -3349,8 +3388,9 @@ sub git_shortlog_body {
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
@@ -4132,8 +4172,6 @@ sub git_blob {
 }
 
 sub git_tree {
-	my $have_snapshot = gitweb_have_snapshot();
-
 	if (!defined $hash_base) {
 		$hash_base = "HEAD";
 	}
@@ -4167,11 +4205,10 @@ sub git_tree {
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
@@ -4235,11 +4272,16 @@ sub git_tree {
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
+	my ($dispname, $ctype, $suffix, $ga_format, $compressor_argv) =
+		@{$known_snapshot_formats{$format}};
 
 	if (!defined $hash) {
 		$hash = git_get_head_hash($project);
@@ -4252,16 +4294,14 @@ sub git_snapshot {
 	my $filename = to_utf8($name);
 	$name =~ s/\047/\047\\\047\047/g;
 	my $cmd;
-	if ($suffix eq 'zip') {
-		$filename .= "-$hash.$suffix";
-		$cmd = "$git archive --format=zip --prefix=\'$name\'/ $hash";
-	} else {
-		$filename .= "-$hash.tar.$suffix";
-		$cmd = "$git archive --format=tar --prefix=\'$name\'/ $hash | $command";
+	$filename .= "-$hash$suffix";
+	$cmd = "$git archive --format=$ga_format --prefix=\'$name\'/ $hash";
+	if (defined $compressor_argv) {
+		$cmd .= ' | ' . join ' ', @$compressor_argv;
 	}
 
 	print $cgi->header(
-		-type => "application/$ctype",
+		-type => "$ctype",
 		-content_disposition => 'inline; filename="' . "$filename" . '"',
 		-status => '200 OK');
 
@@ -4390,8 +4430,6 @@ sub git_commit {
 	my $refs = git_get_references();
 	my $ref = format_ref_marker($refs, $co{'id'});
 
-	my $have_snapshot = gitweb_have_snapshot();
-
 	git_header_html(undef, $expires);
 	git_print_page_nav('commit', '',
 	                   $hash, $co{'tree'}, $hash,
@@ -4430,9 +4468,9 @@ sub git_commit {
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
1.5.3.rc2.6.gf09b
