From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v5 23/31] git-remote-mediawiki: Brace file handles for print for more clarity
Date: Wed, 12 Jun 2013 17:43:40 +0200
Message-ID: <1371051828-12866-24-git-send-email-celestin.matte@ensimag.fr>
References: <1371051828-12866-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 12 17:45:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmnEK-0007Ue-QW
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 17:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757095Ab3FLPop convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 11:44:45 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43466 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756065Ab3FLPoV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 11:44:21 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5CFiHN9028839
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Jun 2013 17:44:17 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5CFiJ5c015085;
	Wed, 12 Jun 2013 17:44:19 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5CFhu68014096;
	Wed, 12 Jun 2013 17:44:18 +0200
X-Mailer: git-send-email 1.8.3.rc3.18.g21a7b2c
In-Reply-To: <1371051828-12866-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 12 Jun 2013 17:44:17 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227632>

This follows the following rule:
InputOutput::RequireBracedFileHandleWithPrint (Severity: 1)
    The `print' and `printf' functions have a unique syntax that suppor=
ts an
    optional file handle argument. Conway suggests wrapping this argume=
nt in
    braces to make it visually stand out from the other arguments. When=
 you
    put braces around any of the special package-level file handles lik=
e
    `STDOUT', `STDERR', and `DATA', you must the `'*'' sigil or else it
    won't compile under `use strict 'subs''.

      print $FH   "Mary had a little lamb\n";  #not ok
      print {$FH} "Mary had a little lamb\n";  #ok

      print   STDERR   $foo, $bar, $baz;  #not ok
      print  {STDERR}  $foo, $bar, $baz;  #won't compile under 'strict'
      print {*STDERR}  $foo, $bar, $baz;  #perfect!

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 202 ++++++++++++++------=
--------
 1 file changed, 101 insertions(+), 101 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 9773a82..8b0144c 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -169,7 +169,7 @@ sub parse_command {
 	} elsif ($cmd[0] eq 'push') {
 		mw_push($cmd[1]);
 	} else {
-		print STDERR "Unknown command. Aborting...\n";
+		print {*STDERR} "Unknown command. Aborting...\n";
 		return 0;
 	}
 	return 1;
@@ -196,10 +196,10 @@ sub mw_connect_maybe {
 			       lgdomain =3D> $wiki_domain};
 		if ($mediawiki->login($request)) {
 			Git::credential \%credential, 'approve';
-			print STDERR qq(Logged in mediawiki user "$credential{username}".\n=
);
+			print {*STDERR} qq(Logged in mediawiki user "$credential{username}"=
=2E\n);
 		} else {
-			print STDERR qq(Failed to log in mediawiki user "$credential{userna=
me}" on ${url}\n);
-			print STDERR '  (error ' .
+			print {*STDERR} qq(Failed to log in mediawiki user "$credential{use=
rname}" on ${url}\n);
+			print {*STDERR} '  (error ' .
 				$mediawiki->{error}->{code} . ': ' .
 				$mediawiki->{error}->{details} . ")\n";
 			Git::credential \%credential, 'reject';
@@ -264,9 +264,9 @@ sub get_mw_all_pages {
 		aplimit =3D> 'max'
 	});
 	if (!defined($mw_pages)) {
-		print STDERR "fatal: could not get the list of wiki pages.\n";
-		print STDERR "fatal: '${url}' does not appear to be a mediawiki\n";
-		print STDERR "fatal: make sure '${url}/api.php' is a valid page.\n";
+		print {*STDERR} "fatal: could not get the list of wiki pages.\n";
+		print {*STDERR} "fatal: '${url}' does not appear to be a mediawiki\n=
";
+		print {*STDERR} "fatal: make sure '${url}/api.php' is a valid page.\=
n";
 		exit 1;
 	}
 	foreach my $page (@{$mw_pages}) {
@@ -291,14 +291,14 @@ sub get_mw_first_pages {
 		titles =3D> $titles,
 	});
 	if (!defined($mw_pages)) {
-		print STDERR "fatal: could not query the list of wiki pages.\n";
-		print STDERR "fatal: '${url}' does not appear to be a mediawiki\n";
-		print STDERR "fatal: make sure '${url}/api.php' is a valid page.\n";
+		print {*STDERR} "fatal: could not query the list of wiki pages.\n";
+		print {*STDERR} "fatal: '${url}' does not appear to be a mediawiki\n=
";
+		print {*STDERR} "fatal: make sure '${url}/api.php' is a valid page.\=
n";
 		exit 1;
 	}
 	while (my ($id, $page) =3D each(%{$mw_pages->{query}->{pages}})) {
 		if ($id < 0) {
-			print STDERR "Warning: page $page->{title} not found on wiki\n";
+			print {*STDERR} "Warning: page $page->{title} not found on wiki\n";
 		} else {
 			$pages->{$page->{title}} =3D $page;
 		}
@@ -310,7 +310,7 @@ sub get_mw_first_pages {
 sub get_mw_pages {
 	mw_connect_maybe();
=20
-	print STDERR "Listing pages on remote wiki...\n";
+	print {*STDERR} "Listing pages on remote wiki...\n";
=20
 	my %pages; # hash on page titles to avoid duplicates
 	my $user_defined;
@@ -328,14 +328,14 @@ sub get_mw_pages {
 		get_mw_all_pages(\%pages);
 	}
 	if ($import_media) {
-		print STDERR "Getting media files for selected pages...\n";
+		print {*STDERR} "Getting media files for selected pages...\n";
 		if ($user_defined) {
 			get_linked_mediafiles(\%pages);
 		} else {
 			get_all_mediafiles(\%pages);
 		}
 	}
-	print STDERR (scalar keys %pages) . " pages found.\n";
+	print {*STDERR} (scalar keys %pages) . " pages found.\n";
 	return %pages;
 }
=20
@@ -368,9 +368,9 @@ sub get_all_mediafiles {
 		aplimit =3D> 'max'
 	});
 	if (!defined($mw_pages)) {
-		print STDERR "fatal: could not get the list of pages for media files=
=2E\n";
-		print STDERR "fatal: '$url' does not appear to be a mediawiki\n";
-		print STDERR "fatal: make sure '$url/api.php' is a valid page.\n";
+		print {*STDERR} "fatal: could not get the list of pages for media fi=
les.\n";
+		print {*STDERR} "fatal: '$url' does not appear to be a mediawiki\n";
+		print {*STDERR} "fatal: make sure '$url/api.php' is a valid page.\n"=
;
 		exit 1;
 	}
 	foreach my $page (@{$mw_pages}) {
@@ -457,7 +457,7 @@ sub get_mw_mediafile_for_page_revision {
 		$mediafile{timestamp} =3D $fileinfo->{timestamp};
 		# Mediawiki::API's download function doesn't support https URLs
 		# and can't download old versions of files.
-		print STDERR "\tDownloading file $mediafile{title}, version $mediafi=
le{timestamp}\n";
+		print {*STDERR} "\tDownloading file $mediafile{title}, version $medi=
afile{timestamp}\n";
 		$mediafile{content} =3D download_mw_mediafile($fileinfo->{url});
 	}
 	return %mediafile;
@@ -470,9 +470,9 @@ sub download_mw_mediafile {
 	if ($response->code =3D=3D 200) {
 		return $response->decoded_content;
 	} else {
-		print STDERR "Error downloading mediafile from :\n";
-		print STDERR "URL: ${download_url}\n";
-		print STDERR 'Server response: ' . $response->code . q{ } . $respons=
e->message . "\n";
+		print {*STDERR} "Error downloading mediafile from :\n";
+		print {*STDERR} "URL: ${download_url}\n";
+		print {*STDERR} 'Server response: ' . $response->code . q{ } . $resp=
onse->message . "\n";
 		exit 1;
 	}
 }
@@ -484,13 +484,13 @@ sub get_last_local_revision {
=20
 	my $lastrevision_number;
 	if (!(defined($note_info[0]) && $note_info[0] eq 'mediawiki_revision:=
')) {
-		print STDERR 'No previous mediawiki revision found';
+		print {*STDERR} 'No previous mediawiki revision found';
 		$lastrevision_number =3D 0;
 	} else {
 		# Notes are formatted : mediawiki_revision: #number
 		$lastrevision_number =3D $note_info[1];
 		chomp($lastrevision_number);
-		print STDERR "Last local mediawiki revision found is ${lastrevision_=
number}";
+		print {*STDERR} "Last local mediawiki revision found is ${lastrevisi=
on_number}";
 	}
 	return $lastrevision_number;
 }
@@ -523,7 +523,7 @@ sub get_last_remote_revision {
=20
 	my $max_rev_num =3D 0;
=20
-	print STDERR "Getting last revision id on tracked pages...\n";
+	print {*STDERR} "Getting last revision id on tracked pages...\n";
=20
 	foreach my $page (@pages) {
 		my $id =3D $page->{pageid};
@@ -544,7 +544,7 @@ sub get_last_remote_revision {
 		$max_rev_num =3D ($lastrev->{revid} > $max_rev_num ? $lastrev->{revi=
d} : $max_rev_num);
 	}
=20
-	print STDERR "Last remote revision found is $max_rev_num.\n";
+	print {*STDERR} "Last remote revision found is $max_rev_num.\n";
 	return $max_rev_num;
 }
=20
@@ -597,7 +597,7 @@ sub mediawiki_smudge_filename {
=20
 sub literal_data {
 	my ($content) =3D @_;
-	print STDOUT 'data ', bytes::length($content), "\n", $content;
+	print {*STDOUT} 'data ', bytes::length($content), "\n", $content;
 	return;
 }
=20
@@ -606,9 +606,9 @@ sub literal_data_raw {
 	my ($content) =3D @_;
 	# Avoid confusion between size in bytes and in characters
 	utf8::downgrade($content);
-	binmode STDOUT, ':raw';
-	print STDOUT 'data ', bytes::length($content), "\n", $content;
-	binmode STDOUT, ':encoding(UTF-8)';
+	binmode {*STDOUT}, ':raw';
+	print {*STDOUT} 'data ', bytes::length($content), "\n", $content;
+	binmode {*STDOUT}, ':encoding(UTF-8)';
 	return;
 }
=20
@@ -616,26 +616,26 @@ sub mw_capabilities {
 	# Revisions are imported to the private namespace
 	# refs/mediawiki/$remotename/ by the helper and fetched into
 	# refs/remotes/$remotename later by fetch.
-	print STDOUT "refspec refs/heads/*:refs/mediawiki/${remotename}/*\n";
-	print STDOUT "import\n";
-	print STDOUT "list\n";
-	print STDOUT "push\n";
-	print STDOUT "\n";
+	print {*STDOUT} "refspec refs/heads/*:refs/mediawiki/${remotename}/*\=
n";
+	print {*STDOUT} "import\n";
+	print {*STDOUT} "list\n";
+	print {*STDOUT} "push\n";
+	print {*STDOUT} "\n";
 	return;
 }
=20
 sub mw_list {
 	# MediaWiki do not have branches, we consider one branch arbitrarily
 	# called master, and HEAD pointing to it.
-	print STDOUT "? refs/heads/master\n";
-	print STDOUT "\@refs/heads/master HEAD\n";
-	print STDOUT "\n";
+	print {*STDOUT} "? refs/heads/master\n";
+	print {*STDOUT} "\@refs/heads/master HEAD\n";
+	print {*STDOUT} "\n";
 	return;
 }
=20
 sub mw_option {
-	print STDERR "remote-helper command 'option $_[0]' not yet implemente=
d\n";
-	print STDOUT "unsupported\n";
+	print {*STDERR} "remote-helper command 'option $_[0]' not yet impleme=
nted\n";
+	print {*STDOUT} "unsupported\n";
 	return;
 }
=20
@@ -671,11 +671,11 @@ sub fetch_mw_revisions_for_page {
 		$query->{rvstartid} =3D $result->{'query-continue'}->{revisions}->{r=
vstartid};
 	}
 	if ($shallow_import && @page_revs) {
-		print STDERR "  Found 1 revision (shallow import).\n";
+		print {*STDERR} "  Found 1 revision (shallow import).\n";
 		@page_revs =3D sort {$b->{revid} <=3D> $a->{revid}} (@page_revs);
 		return $page_revs[0];
 	}
-	print STDERR "  Found ${revnum} revision(s).\n";
+	print {*STDERR} "  Found ${revnum} revision(s).\n";
 	return @page_revs;
 }
=20
@@ -687,7 +687,7 @@ sub fetch_mw_revisions {
 	my $n =3D 1;
 	foreach my $page (@pages) {
 		my $id =3D $page->{pageid};
-		print STDERR "page ${n}/", scalar(@pages), ': ', $page->{title}, "\n=
";
+		print {*STDERR} "page ${n}/", scalar(@pages), ': ', $page->{title}, =
"\n";
 		$n++;
 		my @page_revs =3D fetch_mw_revisions_for_page($page, $id, $fetch_fro=
m);
 		@revisions =3D (@page_revs, @revisions);
@@ -721,42 +721,42 @@ sub import_file_revision {
 	my $author =3D $commit{author};
 	my $date =3D $commit{date};
=20
-	print STDOUT "commit refs/mediawiki/${remotename}/master\n";
-	print STDOUT "mark :${n}\n";
-	print STDOUT "committer ${author} <${author}\@${wiki_name}> " . $date=
->epoch . " +0000\n";
+	print {*STDOUT} "commit refs/mediawiki/${remotename}/master\n";
+	print {*STDOUT} "mark :${n}\n";
+	print {*STDOUT} "committer ${author} <${author}\@${wiki_name}> " . $d=
ate->epoch . " +0000\n";
 	literal_data($comment);
=20
 	# If it's not a clone, we need to know where to start from
 	if (!$full_import && $n =3D=3D 1) {
-		print STDOUT "from refs/mediawiki/${remotename}/master^0\n";
+		print {*STDOUT} "from refs/mediawiki/${remotename}/master^0\n";
 	}
 	if ($content ne DELETED_CONTENT) {
-		print STDOUT 'M 644 inline ' .
+		print {*STDOUT} 'M 644 inline ' .
 		    fe_escape_path("${title}.mw") . "\n";
 		literal_data($content);
 		if (%mediafile) {
-			print STDOUT 'M 644 inline '
+			print {*STDOUT} 'M 644 inline '
 			    . fe_escape_path($mediafile{title}) . "\n";
 			literal_data_raw($mediafile{content});
 		}
-		print STDOUT "\n\n";
+		print {*STDOUT} "\n\n";
 	} else {
-		print STDOUT 'D ' . fe_escape_path("${title}.mw") . "\n";
+		print {*STDOUT} 'D ' . fe_escape_path("${title}.mw") . "\n";
 	}
=20
 	# mediawiki revision number in the git note
 	if ($full_import && $n =3D=3D 1) {
-		print STDOUT "reset refs/notes/${remotename}/mediawiki\n";
+		print {*STDOUT} "reset refs/notes/${remotename}/mediawiki\n";
 	}
-	print STDOUT "commit refs/notes/${remotename}/mediawiki\n";
-	print STDOUT "committer ${author} <${author}\@${wiki_name}> " . $date=
->epoch . " +0000\n";
+	print {*STDOUT} "commit refs/notes/${remotename}/mediawiki\n";
+	print {*STDOUT} "committer ${author} <${author}\@${wiki_name}> " . $d=
ate->epoch . " +0000\n";
 	literal_data('Note added by git-mediawiki during import');
 	if (!$full_import && $n =3D=3D 1) {
-		print STDOUT "from refs/notes/${remotename}/mediawiki^0\n";
+		print {*STDOUT} "from refs/notes/${remotename}/mediawiki^0\n";
 	}
-	print STDOUT "N inline :${n}\n";
+	print {*STDOUT} "N inline :${n}\n";
 	literal_data("mediawiki_revision: $commit{mw_revision}");
-	print STDOUT "\n\n";
+	print {*STDOUT} "\n\n";
 	return;
 }
=20
@@ -787,7 +787,7 @@ sub mw_import {
 	foreach my $ref (@refs) {
 		mw_import_ref($ref);
 	}
-	print STDOUT "done\n";
+	print {*STDOUT} "done\n";
 	return;
 }
=20
@@ -804,30 +804,30 @@ sub mw_import_ref {
=20
 	mw_connect_maybe();
=20
-	print STDERR "Searching revisions...\n";
+	print {*STDERR} "Searching revisions...\n";
 	my $last_local =3D get_last_local_revision();
 	my $fetch_from =3D $last_local + 1;
 	if ($fetch_from =3D=3D 1) {
-		print STDERR ", fetching from beginning.\n";
+		print {*STDERR} ", fetching from beginning.\n";
 	} else {
-		print STDERR ", fetching from here.\n";
+		print {*STDERR} ", fetching from here.\n";
 	}
=20
 	my $n =3D 0;
 	if ($fetch_strategy eq 'by_rev') {
-		print STDERR "Fetching & writing export data by revs...\n";
+		print {*STDERR} "Fetching & writing export data by revs...\n";
 		$n =3D mw_import_ref_by_revs($fetch_from);
 	} elsif ($fetch_strategy eq 'by_page') {
-		print STDERR "Fetching & writing export data by pages...\n";
+		print {*STDERR} "Fetching & writing export data by pages...\n";
 		$n =3D mw_import_ref_by_pages($fetch_from);
 	} else {
-		print STDERR qq(fatal: invalid fetch strategy "${fetch_strategy}".\n=
);
-		print STDERR "Check your configuration variables remote.${remotename=
}.fetchStrategy and mediawiki.fetchStrategy\n";
+		print {*STDERR} qq(fatal: invalid fetch strategy "${fetch_strategy}"=
=2E\n);
+		print {*STDERR} "Check your configuration variables remote.${remoten=
ame}.fetchStrategy and mediawiki.fetchStrategy\n";
 		exit 1;
 	}
=20
 	if ($fetch_from =3D=3D 1 && $n =3D=3D 0) {
-		print STDERR "You appear to have cloned an empty MediaWiki.\n";
+		print {*STDERR} "You appear to have cloned an empty MediaWiki.\n";
 		# Something has to be done remote-helper side. If nothing is done, a=
n error is
 		# thrown saying that HEAD is referring to unknown object 00000000000=
00000000
 		# and the clone fails.
@@ -906,7 +906,7 @@ sub mw_import_revids {
 		my $page_title =3D $result_page->{title};
=20
 		if (!exists($pages->{$page_title})) {
-			print STDERR "${n}/", scalar(@$revision_ids),
+			print {*STDERR} "${n}/", scalar(@$revision_ids),
 				": Skipping revision #$rev->{revid} of ${page_title}\n";
 			next;
 		}
@@ -939,7 +939,7 @@ sub mw_import_revids {
 		# If this is a revision of the media page for new version
 		# of a file do one common commit for both file and media page.
 		# Else do commit only for that page.
-		print STDERR "${n}/", scalar(@$revision_ids), ": Revision #$rev->{re=
vid} of $commit{title}\n";
+		print {*STDERR} "${n}/", scalar(@$revision_ids), ": Revision #$rev->=
{revid} of $commit{title}\n";
 		import_file_revision(\%commit, ($fetch_from =3D=3D 1), $n_actual, \%=
mediafile);
 	}
=20
@@ -953,11 +953,11 @@ sub error_non_fast_forward {
 		# Native git-push would show this after the summary.
 		# We can't ask it to display it cleanly, so print it
 		# ourselves before.
-		print STDERR "To prevent you from losing history, non-fast-forward u=
pdates were rejected\n";
-		print STDERR "Merge the remote changes (e.g. 'git pull') before push=
ing again. See the\n";
-		print STDERR "'Note about fast-forwards' section of 'git push --help=
' for details.\n";
+		print {*STDERR} "To prevent you from losing history, non-fast-forwar=
d updates were rejected\n";
+		print {*STDERR} "Merge the remote changes (e.g. 'git pull') before p=
ushing again. See the\n";
+		print {*STDERR} "'Note about fast-forwards' section of 'git push --h=
elp' for details.\n";
 	}
-	print STDOUT qq(error $_[0] "non-fast-forward"\n);
+	print {*STDOUT} qq(error $_[0] "non-fast-forward"\n);
 	return 0;
 }
=20
@@ -971,8 +971,8 @@ sub mw_upload_file {
 	my $path =3D "File:${complete_file_name}";
 	my %hashFiles =3D get_allowed_file_extensions();
 	if (!exists($hashFiles{$extension})) {
-		print STDERR "${complete_file_name} is not a permitted file on this =
wiki.\n";
-		print STDERR "Check the configuration of file uploads in your mediaw=
iki.\n";
+		print {*STDERR} "${complete_file_name} is not a permitted file on th=
is wiki.\n";
+		print {*STDERR} "Check the configuration of file uploads in your med=
iawiki.\n";
 		return $newrevid;
 	}
 	# Deleting and uploading a file requires a priviledged user
@@ -984,9 +984,9 @@ sub mw_upload_file {
 			reason =3D> $summary
 		};
 		if (!$mediawiki->edit($query)) {
-			print STDERR "Failed to delete file on remote wiki\n";
-			print STDERR "Check your permissions on the remote site. Error code=
:\n";
-			print STDERR $mediawiki->{error}->{code} . ':' . $mediawiki->{error=
}->{details};
+			print {*STDERR} "Failed to delete file on remote wiki\n";
+			print {*STDERR} "Check your permissions on the remote site. Error c=
ode:\n";
+			print {*STDERR} $mediawiki->{error}->{code} . ':' . $mediawiki->{er=
ror}->{details};
 			exit 1;
 		}
 	} else {
@@ -1010,9 +1010,9 @@ sub mw_upload_file {
 				 . $mediawiki->{error}->{details} . "\n";
 			my $last_file_page =3D $mediawiki->get_page({title =3D> $path});
 			$newrevid =3D $last_file_page->{revid};
-			print STDERR "Pushed file: ${new_sha1} - ${complete_file_name}.\n";
+			print {*STDERR} "Pushed file: ${new_sha1} - ${complete_file_name}.\=
n";
 		} else {
-			print STDERR "Empty file ${complete_file_name} not pushed.\n";
+			print {*STDERR} "Empty file ${complete_file_name} not pushed.\n";
 		}
 	}
 	return $newrevid;
@@ -1050,7 +1050,7 @@ sub mw_push_file {
 	if ($extension eq 'mw') {
 		my $ns =3D get_mw_namespace_id_for_page($complete_file_name);
 		if ($ns && $ns =3D=3D get_mw_namespace_id('File') && (!$export_media=
)) {
-			print STDERR "Ignoring media file related page: ${complete_file_nam=
e}\n";
+			print {*STDERR} "Ignoring media file related page: ${complete_file_=
name}\n";
 			return ($oldrevid, 'ok');
 		}
 		my $file_content;
@@ -1078,7 +1078,7 @@ sub mw_push_file {
 		if (!$result) {
 			if ($mediawiki->{error}->{code} =3D=3D 3) {
 				# edit conflicts, considered as non-fast-forward
-				print STDERR 'Warning: Error ' .
+				print {*STDERR} 'Warning: Error ' .
 				    $mediawiki->{error}->{code} .
 				    ' from mediwiki: ' . $mediawiki->{error}->{details} .
 				    ".\n";
@@ -1091,13 +1091,13 @@ sub mw_push_file {
 			}
 		}
 		$newrevid =3D $result->{edit}->{newrevid};
-		print STDERR "Pushed file: ${new_sha1} - ${title}\n";
+		print {*STDERR} "Pushed file: ${new_sha1} - ${title}\n";
 	} elsif ($export_media) {
 		$newrevid =3D mw_upload_file($complete_file_name, $new_sha1,
 					   $extension, $page_deleted,
 					   $summary);
 	} else {
-		print STDERR "Ignoring media file ${title}\n";
+		print {*STDERR} "Ignoring media file ${title}\n";
 	}
 	$newrevid =3D ($newrevid or $oldrevid);
 	return ($newrevid, 'ok');
@@ -1111,16 +1111,16 @@ sub mw_push {
 		my ($force, $local, $remote) =3D $refspec =3D~ /^(\+)?([^:]*):([^:]*=
)$/
 		    or die("Invalid refspec for push. Expected <src>:<dst> or +<src>=
:<dst>\n");
 		if ($force) {
-			print STDERR "Warning: forced push not allowed on a MediaWiki.\n";
+			print {*STDERR} "Warning: forced push not allowed on a MediaWiki.\n=
";
 		}
 		if ($local eq "") {
-			print STDERR "Cannot delete remote branch on a MediaWiki\n";
-			print STDOUT "error ${remote} cannot delete\n";
+			print {*STDERR} "Cannot delete remote branch on a MediaWiki\n";
+			print {*STDOUT} "error ${remote} cannot delete\n";
 			next;
 		}
 		if ($remote ne 'refs/heads/master') {
-			print STDERR "Only push to the branch 'master' is supported on a Me=
diaWiki\n";
-			print STDOUT "error ${remote} only master allowed\n";
+			print {*STDERR} "Only push to the branch 'master' is supported on a=
 MediaWiki\n";
+			print {*STDOUT} "error ${remote} only master allowed\n";
 			next;
 		}
 		if (mw_push_revision($local, $remote)) {
@@ -1129,15 +1129,15 @@ sub mw_push {
 	}
=20
 	# Notify Git that the push is done
-	print STDOUT "\n";
+	print {*STDOUT} "\n";
=20
 	if ($pushed && $dumb_push) {
-		print STDERR "Just pushed some revisions to MediaWiki.\n";
-		print STDERR "The pushed revisions now have to be re-imported, and y=
our current branch\n";
-		print STDERR "needs to be updated with these re-imported commits. Yo=
u can do this with\n";
-		print STDERR "\n";
-		print STDERR "  git pull --rebase\n";
-		print STDERR "\n";
+		print {*STDERR} "Just pushed some revisions to MediaWiki.\n";
+		print {*STDERR} "The pushed revisions now have to be re-imported, an=
d your current branch\n";
+		print {*STDERR} "needs to be updated with these re-imported commits.=
 You can do this with\n";
+		print {*STDERR} "\n";
+		print {*STDERR} "  git pull --rebase\n";
+		print {*STDERR} "\n";
 	}
 	return;
 }
@@ -1146,7 +1146,7 @@ sub mw_push_revision {
 	my $local =3D shift;
 	my $remote =3D shift; # actually, this has to be "refs/heads/master" =
at this point.
 	my $last_local_revid =3D get_last_local_revision();
-	print STDERR ".\n"; # Finish sentence started by get_last_local_revis=
ion()
+	print {*STDERR} ".\n"; # Finish sentence started by get_last_local_re=
vision()
 	my $last_remote_revid =3D get_last_remote_revision();
 	my $mw_revision =3D $last_remote_revid;
=20
@@ -1173,7 +1173,7 @@ sub mw_push_revision {
 	if ($last_local_revid > 0) {
 		my $parsed_sha1 =3D $remoteorigin_sha1;
 		# Find a path from last MediaWiki commit to pushed commit
-		print STDERR "Computing path from local to remote ...\n";
+		print {*STDERR} "Computing path from local to remote ...\n";
 		my @local_ancestry =3D split(/\n/, run_git("rev-list --boundary --pa=
rents ${local} ^${parsed_sha1}"));
 		my %local_ancestry;
 		foreach my $line (@local_ancestry) {
@@ -1188,7 +1188,7 @@ sub mw_push_revision {
 		while ($parsed_sha1 ne $HEAD_sha1) {
 			my $child =3D $local_ancestry{$parsed_sha1};
 			if (!$child) {
-				printf STDERR "Cannot find a path in history from remote commit to=
 last commit\n";
+				print {*STDERR} "Cannot find a path in history from remote commit =
to last commit\n";
 				return error_non_fast_forward($remote);
 			}
 			push(@commit_pairs, [$parsed_sha1, $child]);
@@ -1197,7 +1197,7 @@ sub mw_push_revision {
 	} else {
 		# No remote mediawiki revision. Export the whole
 		# history (linearized with --first-parent)
-		print STDERR "Warning: no common ancestor, pushing complete history\=
n";
+		print {*STDERR} "Warning: no common ancestor, pushing complete histo=
ry\n";
 		my $history =3D run_git("rev-list --first-parent --children ${local}=
");
 		my @history =3D split(/\n/, $history);
 		@history =3D @history[1..$#history];
@@ -1245,7 +1245,7 @@ sub mw_push_revision {
 		}
 	}
=20
-	print STDOUT "ok ${remote}\n";
+	print {*STDOUT} "ok ${remote}\n";
 	return 1;
 }
=20
@@ -1296,7 +1296,7 @@ sub get_mw_namespace_id {
 	}
=20
 	if (!exists $namespace_id{$name}) {
-		print STDERR "Namespace ${name} not found in cache, querying the wik=
i ...\n";
+		print {*STDERR} "Namespace ${name} not found in cache, querying the =
wiki ...\n";
 		# NS not found =3D> get namespace id from MW and store it in
 	        # configuration file.
 	        my $query =3D {
@@ -1321,7 +1321,7 @@ sub get_mw_namespace_id {
 	my $id;
=20
 	unless (defined $ns) {
-		print STDERR "No such namespace ${name} on MediaWiki.\n";
+		print {*STDERR} "No such namespace ${name} on MediaWiki.\n";
 		$ns =3D {is_namespace =3D> 0};
 		$namespace_id{$name} =3D $ns;
 	}
--=20
1.8.3.rc3.18.g21a7b2c
