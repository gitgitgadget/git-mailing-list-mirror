From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH 01/18] Follow perlcritic's recommendations - level 5 and 4
Date: Thu,  6 Jun 2013 21:34:06 +0200
Message-ID: <1370547263-13558-2-git-send-email-celestin.matte@ensimag.fr>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 06 21:34:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkfxR-0000MD-HJ
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 21:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286Ab3FFTeq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jun 2013 15:34:46 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44253 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752876Ab3FFTeo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 15:34:44 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r56JYZYM005211
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Jun 2013 21:34:35 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r56JYbII021384;
	Thu, 6 Jun 2013 21:34:37 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r56JYToo023108;
	Thu, 6 Jun 2013 21:34:37 +0200
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 06 Jun 2013 21:34:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r56JYZYM005211
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371152080.1179@iAEl77ZK/W/tYwfcxy0gYw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226534>

=46ix warnings from perlcritic's level 5 and 4. They correspond to the =
following
cases:
- always end a submodule with a return
- don't use the constant pragma, use the Readonly module instead
- some syntax details for maps, and others.

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl |   81 +++++++++++++++++--=
--------
 1 file changed, 51 insertions(+), 30 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 410eae9..83cf292 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -15,32 +15,32 @@ use strict;
 use MediaWiki::API;
 use Git;
 use DateTime::Format::ISO8601;
+use warnings;
=20
 # By default, use UTF-8 to communicate with Git and the user
-binmode STDERR, ":utf8";
-binmode STDOUT, ":utf8";
+binmode STDERR, ":encoding(UTF-8)";
+binmode STDOUT, ":encoding(UTF-8)";
=20
 use URI::Escape;
 use IPC::Open2;
-
-use warnings;
+use Readonly;
=20
 # Mediawiki filenames can contain forward slashes. This variable decid=
es by which pattern they should be replaced
-use constant SLASH_REPLACEMENT =3D> "%2F";
+Readonly my $SLASH_REPLACEMENT =3D> "%2F";
=20
 # It's not always possible to delete pages (may require some
 # privileges). Deleted pages are replaced with this content.
-use constant DELETED_CONTENT =3D> "[[Category:Deleted]]\n";
+Readonly my $DELETED_CONTENT =3D> "[[Category:Deleted]]\n";
=20
 # It's not possible to create empty pages. New empty files in Git are
 # sent with this content instead.
-use constant EMPTY_CONTENT =3D> "<!-- empty page -->\n";
+Readonly my $EMPTY_CONTENT =3D> "<!-- empty page -->\n";
=20
 # used to reflect file creation or deletion in diff.
-use constant NULL_SHA1 =3D> "0000000000000000000000000000000000000000"=
;
+Readonly my $NULL_SHA1 =3D> "0000000000000000000000000000000000000000"=
;
=20
 # Used on Git's side to reflect empty edit messages on the wiki
-use constant EMPTY_MESSAGE =3D> '*Empty MediaWiki Message*';
+Readonly my $EMPTY_MESSAGE =3D> '*Empty MediaWiki Message*';
=20
 if (@ARGV !=3D 2) {
 	exit_error_usage();
@@ -96,6 +96,9 @@ unless ($fetch_strategy) {
 	$fetch_strategy =3D "by_page";
 }
=20
+# Remember the timestamp corresponding to a revision id.
+my %basetimestamps;
+
 # Dumb push: don't update notes and mediawiki ref to reflect the last =
push.
 #
 # Configurable with mediawiki.dumbPush, or per-remote with
@@ -198,12 +201,14 @@ sub mw_connect_maybe {
 			exit 1;
 		}
 	}
+	return;
 }
=20
 ## Functions for listing pages on the remote wiki
 sub get_mw_tracked_pages {
 	my $pages =3D shift;
 	get_mw_page_list(\@tracked_pages, $pages);
+	return;
 }
=20
 sub get_mw_page_list {
@@ -219,6 +224,7 @@ sub get_mw_page_list {
 		get_mw_first_pages(\@slice, $pages);
 		@some_pages =3D @some_pages[51..$#some_pages];
 	}
+	return;
 }
=20
 sub get_mw_tracked_categories {
@@ -241,6 +247,7 @@ sub get_mw_tracked_categories {
 			$pages->{$page->{title}} =3D $page;
 		}
 	}
+	return;
 }
=20
 sub get_mw_all_pages {
@@ -260,6 +267,7 @@ sub get_mw_all_pages {
 	foreach my $page (@{$mw_pages}) {
 		$pages->{$page->{title}} =3D $page;
 	}
+	return;
 }
=20
 # queries the wiki for a set of pages. Meant to be used within a loop
@@ -290,6 +298,7 @@ sub get_mw_first_pages {
 			$pages->{$page->{title}} =3D $page;
 		}
 	}
+	return;
 }
=20
 # Get the list of pages to be fetched according to configuration.
@@ -358,11 +367,12 @@ sub get_all_mediafiles {
 	foreach my $page (@{$mw_pages}) {
 		$pages->{$page->{title}} =3D $page;
 	}
+	return;
 }
=20
 sub get_linked_mediafiles {
 	my $pages =3D shift;
-	my @titles =3D map $_->{title}, values(%{$pages});
+	my @titles =3D map { $_->{title} } values(%{$pages});
=20
 	# The query is split in small batches because of the MW API limit of
 	# the number of links to be returned (500 links max).
@@ -390,11 +400,13 @@ sub get_linked_mediafiles {
 		while (my ($id, $page) =3D each(%{$result->{query}->{pages}})) {
 			my @media_titles;
 			if (defined($page->{links})) {
-				my @link_titles =3D map $_->{title}, @{$page->{links}};
+				my @link_titles
+				    =3D map { $_->{title} } @{$page->{links}};
 				push(@media_titles, @link_titles);
 			}
 			if (defined($page->{images})) {
-				my @image_titles =3D map $_->{title}, @{$page->{images}};
+				my @image_titles
+				    =3D map { $_->{title} } @{$page->{images}};
 				push(@media_titles, @image_titles);
 			}
 			if (@media_titles) {
@@ -404,6 +416,7 @@ sub get_linked_mediafiles {
=20
 		@titles =3D @titles[($batch+1)..$#titles];
 	}
+	return;
 }
=20
 sub get_mw_mediafile_for_page_revision {
@@ -473,9 +486,6 @@ sub get_last_local_revision {
 	return $lastrevision_number;
 }
=20
-# Remember the timestamp corresponding to a revision id.
-my %basetimestamps;
-
 # Get the last remote revision without taking in account which pages a=
re
 # tracked or not. This function makes a single request to the wiki thu=
s
 # avoid a loop onto all tracked pages. This is useful for the fetch-by=
-rev
@@ -538,7 +548,7 @@ sub mediawiki_clean {
 	$string =3D~ s/\s+$//;
 	if ($string eq "" && $page_created) {
 		# Creating empty pages is forbidden.
-		$string =3D EMPTY_CONTENT;
+		$string =3D $EMPTY_CONTENT;
 	}
 	return $string."\n";
 }
@@ -546,7 +556,7 @@ sub mediawiki_clean {
 # Filter applied on MediaWiki data before adding them to Git
 sub mediawiki_smudge {
 	my $string =3D shift;
-	if ($string eq EMPTY_CONTENT) {
+	if ($string eq $EMPTY_CONTENT) {
 		$string =3D "";
 	}
 	# This \n is important. This is due to mediawiki's way to handle end =
of files.
@@ -555,7 +565,7 @@ sub mediawiki_smudge {
=20
 sub mediawiki_clean_filename {
 	my $filename =3D shift;
-	$filename =3D~ s/@{[SLASH_REPLACEMENT]}/\//g;
+	$filename =3D~ s{$SLASH_REPLACEMENT}{/}g;
 	# [, ], |, {, and } are forbidden by MediaWiki, even URL-encoded.
 	# Do a variant of URL-encoding, i.e. looks like URL-encoding,
 	# but with _ added to prevent MediaWiki from thinking this is
@@ -569,7 +579,7 @@ sub mediawiki_clean_filename {
=20
 sub mediawiki_smudge_filename {
 	my $filename =3D shift;
-	$filename =3D~ s/\//@{[SLASH_REPLACEMENT]}/g;
+	$filename =3D~ s{/}{$SLASH_REPLACEMENT}g;
 	$filename =3D~ s/ /_/g;
 	# Decode forbidden characters encoded in mediawiki_clean_filename
 	$filename =3D~ s/_%_([0-9a-fA-F][0-9a-fA-F])/sprintf("%c", hex($1))/g=
e;
@@ -579,6 +589,7 @@ sub mediawiki_smudge_filename {
 sub literal_data {
 	my ($content) =3D @_;
 	print STDOUT "data ", bytes::length($content), "\n", $content;
+	return;
 }
=20
 sub literal_data_raw {
@@ -588,7 +599,8 @@ sub literal_data_raw {
 	utf8::downgrade($content);
 	binmode STDOUT, ":raw";
 	print STDOUT "data ", bytes::length($content), "\n", $content;
-	binmode STDOUT, ":utf8";
+	binmode STDOUT, ":encoding(UTF-8)";
+	return;
 }
=20
 sub mw_capabilities {
@@ -600,6 +612,7 @@ sub mw_capabilities {
 	print STDOUT "list\n";
 	print STDOUT "push\n";
 	print STDOUT "\n";
+	return;
 }
=20
 sub mw_list {
@@ -608,11 +621,13 @@ sub mw_list {
 	print STDOUT "? refs/heads/master\n";
 	print STDOUT "\@refs/heads/master HEAD\n";
 	print STDOUT "\n";
+	return;
 }
=20
 sub mw_option {
 	print STDERR "remote-helper command 'option $_[0]' not yet implemente=
d\n";
 	print STDOUT "unsupported\n";
+	return;
 }
=20
 sub fetch_mw_revisions_for_page {
@@ -707,7 +722,7 @@ sub import_file_revision {
 	if (!$full_import && $n =3D=3D 1) {
 		print STDOUT "from refs/mediawiki/$remotename/master^0\n";
 	}
-	if ($content ne DELETED_CONTENT) {
+	if ($content ne $DELETED_CONTENT) {
 		print STDOUT "M 644 inline " .
 		    fe_escape_path($title . ".mw") . "\n";
 		literal_data($content);
@@ -734,6 +749,7 @@ sub import_file_revision {
 	print STDOUT "N inline :$n\n";
 	literal_data("mediawiki_revision: " . $commit{mw_revision});
 	print STDOUT "\n\n";
+	return;
 }
=20
 # parse a sequence of
@@ -754,6 +770,7 @@ sub get_more_refs {
 			die("Invalid command in a '$cmd' batch: ". $_);
 		}
 	}
+	return;
 }
=20
 sub mw_import {
@@ -763,6 +780,7 @@ sub mw_import {
 		mw_import_ref($ref);
 	}
 	print STDOUT "done\n";
+	return;
 }
=20
 sub mw_import_ref {
@@ -806,6 +824,7 @@ sub mw_import_ref {
 		# thrown saying that HEAD is referring to unknown object 00000000000=
00000000
 		# and the clone fails.
 	}
+	return;
 }
=20
 sub mw_import_ref_by_pages {
@@ -817,7 +836,7 @@ sub mw_import_ref_by_pages {
 	my ($n, @revisions) =3D fetch_mw_revisions(\@pages, $fetch_from);
=20
 	@revisions =3D sort {$a->{revid} <=3D> $b->{revid}} @revisions;
-	my @revision_ids =3D map $_->{revid}, @revisions;
+	my @revision_ids =3D map { $_->{revid} } @revisions;
=20
 	return mw_import_revids($fetch_from, \@revision_ids, \%pages_hash);
 }
@@ -888,7 +907,7 @@ sub mw_import_revids {
=20
 		my %commit;
 		$commit{author} =3D $rev->{user} || 'Anonymous';
-		$commit{comment} =3D $rev->{comment} || EMPTY_MESSAGE;
+		$commit{comment} =3D $rev->{comment} || $EMPTY_MESSAGE;
 		$commit{title} =3D mediawiki_smudge_filename($page_title);
 		$commit{mw_revision} =3D $rev->{revid};
 		$commit{content} =3D mediawiki_smudge($rev->{'*'});
@@ -1006,14 +1025,14 @@ sub mw_push_file {
 	my $oldrevid =3D shift;
 	my $newrevid;
=20
-	if ($summary eq EMPTY_MESSAGE) {
+	if ($summary eq $EMPTY_MESSAGE) {
 		$summary =3D '';
 	}
=20
 	my $new_sha1 =3D $diff_info_split[3];
 	my $old_sha1 =3D $diff_info_split[2];
-	my $page_created =3D ($old_sha1 eq NULL_SHA1);
-	my $page_deleted =3D ($new_sha1 eq NULL_SHA1);
+	my $page_created =3D ($old_sha1 eq $NULL_SHA1);
+	my $page_deleted =3D ($new_sha1 eq $NULL_SHA1);
 	$complete_file_name =3D mediawiki_clean_filename($complete_file_name)=
;
=20
 	my ($title, $extension) =3D $complete_file_name =3D~ /^(.*)\.([^\.]*)=
$/;
@@ -1032,7 +1051,7 @@ sub mw_push_file {
 			# special privileges. A common
 			# convention is to replace the page
 			# with this content instead:
-			$file_content =3D DELETED_CONTENT;
+			$file_content =3D $DELETED_CONTENT;
 		} else {
 			$file_content =3D run_git("cat-file blob $new_sha1");
 		}
@@ -1112,6 +1131,7 @@ sub mw_push {
 		print STDERR "  git pull --rebase\n";
 		print STDERR "\n";
 	}
+	return;
 }
=20
 sub mw_push_revision {
@@ -1229,8 +1249,8 @@ sub get_allowed_file_extensions {
 		siprop =3D> 'fileextensions'
 		};
 	my $result =3D $mediawiki->api($query);
-	my @file_extensions=3D map $_->{ext},@{$result->{query}->{fileextensi=
ons}};
-	my %hashFile =3D map {$_ =3D> 1}@file_extensions;
+	my @file_extensions =3D map { $_->{ext}} @{$result->{query}->{fileext=
ensions}};
+	my %hashFile =3D map { $_ =3D> 1 } @file_extensions;
=20
 	return %hashFile;
 }
@@ -1314,7 +1334,8 @@ sub get_mw_namespace_id {
 }
=20
 sub get_mw_namespace_id_for_page {
-	if (my ($namespace) =3D $_[0] =3D~ /^([^:]*):/) {
+	my $namespace =3D shift;
+	if ($namespace =3D~ /^([^:]*):/) {
 		return get_mw_namespace_id($namespace);
 	} else {
 		return;
--=20
1.7.9.5
