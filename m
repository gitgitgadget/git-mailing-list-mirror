From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git-remote-mediawiki: import "File:" attachments
Date: Wed, 04 Jul 2012 23:58:37 -0700
Message-ID: <7vk3yisnhe.fsf@alter.siamese.dyndns.org>
References: <1340806889-23081-1-git-send-email-Matthieu.Moy@imag.fr>
 <1341406416-1251-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Jul 05 08:58:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Smg1W-0007AL-VG
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 08:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720Ab2GEG6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 02:58:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57907 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885Ab2GEG6k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 02:58:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED5D46703;
	Thu,  5 Jul 2012 02:58:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GBcIttwPt9HFArF+Pa8gAL5Z1L4=; b=kL47TB
	GhP42Hj06cJ0DRGPKu00PBXl1FXwXtPnlzRdMi956TBoz/rW9zZOMCUPtJYGTaK4
	deOsbSgvIRqXsyOffnGB6zy3m+yNyJLOJJCKkKimt79eN89ug7+06iCUeKzFmnoG
	Epoq1zkrVXDVA+g+Y051SSvyuIHrTLirujJK8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TF4IsCtOe8+lhK1AuftGL7GfTCuq7Z9u
	YT1IlGCb4zLFZWKuQe+tP8S3mj117C89iZFZD1n6lOvOXc4nV2T5RMjwtYNmnvLx
	aKLlPNoLHiNfD/YZHiqRnqeGsp4XTKggU7xKpycFXxqL+6mV9bKCDyXAuVxwEH3H
	b0pnJHUH5hc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E41C96702;
	Thu,  5 Jul 2012 02:58:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19DDC6701; Thu,  5 Jul 2012
 02:58:39 -0400 (EDT)
In-Reply-To: <1341406416-1251-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Wed, 4 Jul 2012 14:53:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D93CD1BE-C66E-11E1-95CA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201020>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> This is meant to replace commit 6a9e55b0fc5df40 in branch
> mm/mediawiki-file-attachments in pu.

Bad timing for our mails to cross; it is already on 'next'.

Would the following be a good "incremental update" on top of the
named commit?

-- >8 --
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Wed, 4 Jul 2012 14:53:36 +0200
Subject: [PATCH] git-remote-mediawiki: improve support for non-English Wikis

Mediafiles can live in namespaces with names different from Image
and File. While at it, rework the code to make it simpler and easier
to read.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/mw-to-git/git-remote-mediawiki | 140 ++++++++++++++-------------------
 1 file changed, 61 insertions(+), 79 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index 76b78bc..063a978 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -33,7 +33,6 @@
 use strict;
 use MediaWiki::API;
 use DateTime::Format::ISO8601;
-use FileHandle;
 
 # By default, use UTF-8 to communicate with Git and the user
 binmode STDERR, ":utf8";
@@ -90,9 +89,6 @@ my $shallow_import = run_git("config --get --bool remote.". $remotename .".shall
 chomp($shallow_import);
 $shallow_import = ($shallow_import eq "true");
 
-# Cache for MediaWiki namespace ids.
-my %namespace_id;
-
 # Dumb push: don't update notes and mediawiki ref to reflect the last push.
 #
 # Configurable with mediawiki.dumbPush, or per-remote with
@@ -267,7 +263,13 @@ sub mw_connect_maybe {
 ## Functions for listing pages on the remote wiki
 sub get_mw_tracked_pages {
 	my $pages = shift;
-	my @some_pages = @tracked_pages;
+	get_mw_page_list(\@tracked_pages, $pages);
+}
+
+sub get_mw_page_list {
+	my $page_list = shift;
+	my $pages = shift;
+	my @some_pages = @$page_list;
 	while (@some_pages) {
 		my $last = 50;
 		if ($#some_pages < $last) {
@@ -443,17 +445,17 @@ sub get_linked_mediafiles {
 		my $result = $mediawiki->api($query);
 
 		while (my ($id, $page) = each(%{$result->{query}->{pages}})) {
-			my @titles;
+			my @media_titles;
 			if (defined($page->{links})) {
 				my @link_titles = map $_->{title}, @{$page->{links}};
-				push(@titles, @link_titles);
+				push(@media_titles, @link_titles);
 			}
 			if (defined($page->{images})) {
 				my @image_titles = map $_->{title}, @{$page->{images}};
-				push(@titles, @image_titles);
+				push(@media_titles, @image_titles);
 			}
-			if (@titles) {
-				get_mw_first_pages(\@titles, \%{$pages});
+			if (@media_titles) {
+				get_mw_page_list(\@media_titles, $pages);
 			}
 		}
 
@@ -463,16 +465,16 @@ sub get_linked_mediafiles {
 
 sub get_mw_mediafile_for_page_revision {
 	# Name of the file on Wiki, with the prefix.
-	my $mw_filename = shift;
+	my $filename = shift;
 	my $timestamp = shift;
 	my %mediafile;
 
-	# Search if on MediaWiki exists a media file with given
-	# timestamp. In that case download the file.
+	# Search if on a media file with given timestamp exists on
+	# MediaWiki. In that case download the file.
 	my $query = {
 		action => 'query',
 		prop => 'imageinfo',
-		titles => $mw_filename,
+		titles => "File:" . $filename,
 		iistart => $timestamp,
 		iiend => $timestamp,
 		iiprop => 'timestamp|archivename|url',
@@ -480,62 +482,33 @@ sub get_mw_mediafile_for_page_revision {
 	};
 	my $result = $mediawiki->api($query);
 
-	my ($fileid, $file) = each ( %{$result->{query}->{pages}} );
+	my ($fileid, $file) = each( %{$result->{query}->{pages}} );
 	# If not defined it means there is no revision of the file for
 	# given timestamp.
 	if (defined($file->{imageinfo})) {
-		# Get real name of media file.
-		my $filename;
-		if (index($mw_filename, 'File:') == 0) {
-			$filename = substr $mw_filename, 5;
-		} else {
-			$filename = substr $mw_filename, 6;
-		}
 		$mediafile{title} = $filename;
 
 		my $fileinfo = pop(@{$file->{imageinfo}});
 		$mediafile{timestamp} = $fileinfo->{timestamp};
-		# If this is an old version of the file, the file has to be
-		# obtained from the archive. Otherwise it can be downloaded
-		# by MediaWiki API download() function.
-		if (defined($fileinfo->{archivename})) {
-			$mediafile{content} = download_mw_mediafile_from_archive($fileinfo->{url});
-		} else {
-			$mediafile{content} = download_mw_mediafile($mw_filename);
-		}
+		# Mediawiki::API's download function doesn't support https URLs
+		# and can't download old versions of files.
+		print STDERR "\tDownloading file $mediafile{title}, version $mediafile{timestamp}\n";
+		$mediafile{content} = download_mw_mediafile($fileinfo->{url});
 	}
 	return %mediafile;
 }
 
-sub download_mw_mediafile_from_archive {
+sub download_mw_mediafile {
 	my $url = shift;
-	my $file;
 
-	my $ua = LWP::UserAgent->new;
-	my $response = $ua->get($url);
-	if ($response->code) {
-		$file = $response->decoded_content;
+	my $response = $mediawiki->{ua}->get($url);
+	if ($response->code == 200) {
+		return $response->decoded_content;
 	} else {
-		print STDERR "Error downloading a file from archive.\n";
-	}
-
-	return $file;
-}
-
-sub download_mw_mediafile {
-	my $filename = shift;
-
-	$mediawiki->{config}->{files_url} = $url;
-
-	my $file_content = $mediawiki->download( { title => $filename } );
-	if (!defined($file_content)) {
-		print STDERR "\tFile \'$filename\' could not be downloaded.\n";
-		exit 1;
-	} elsif ($file_content eq "") {
-		print STDERR "\tFile \'$filename\' does not exist on the wiki.\n";
+		print STDERR "Error downloading mediafile from :\n";
+		print STDERR "URL: $url\n";
+		print STDERR "Server response: " . $response->code . " " . $response->message . "\n";
 		exit 1;
-	} else {
-		return $file_content;
 	}
 }
 
@@ -878,24 +851,16 @@ sub mw_import_ref {
 		$commit{date} = DateTime::Format::ISO8601->parse_datetime($last_timestamp);
 
 		# Differentiates classic pages and media files.
-		my @prefix = split(":", $page_title);
-
+		my ($namespace, $filename) = $page_title =~ /^([^:]*):(.*)$/;
 		my %mediafile;
-		if ($prefix[0] eq "File" || $prefix[0] eq "Image") {
-			# The name of the file is the same as the media page.
-			my $filename = $page_title;
+		if ($namespace && get_mw_namespace_id($namespace) == get_mw_namespace_id("File")) {
 			%mediafile = get_mw_mediafile_for_page_revision($filename, $rev->{timestamp});
 		}
 		# If this is a revision of the media page for new version
 		# of a file do one common commit for both file and media page.
 		# Else do commit only for that page.
 		print STDERR "$n/", scalar(@revisions), ": Revision #$pagerevid->{revid} of $commit{title}\n";
-		if (%mediafile) {
-			print STDERR "\tDownloading file $mediafile{title}, version $mediafile{timestamp}\n";
-			import_file_revision(\%commit, ($fetch_from == 1), $n, \%mediafile);
-		} else {
-			import_file_revision(\%commit, ($fetch_from == 1), $n);
-		}
+		import_file_revision(\%commit, ($fetch_from == 1), $n, \%mediafile);
 	}
 
 	if ($fetch_from == 1 && $n == 0) {
@@ -1201,28 +1166,35 @@ sub get_allowed_file_extensions {
 	return %hashFile;
 }
 
+# In memory cache for MediaWiki namespace ids.
+my %namespace_id;
+
+# Namespaces whose id is cached in the configuration file
+# (to avoid duplicates)
+my %cached_mw_namespace_id;
+
 # Return MediaWiki id for a canonical namespace name.
 # Ex.: "File", "Project".
-# Looks for the namespace id in the local configuration
-# variables, if it is not found asks MW API.
 sub get_mw_namespace_id {
 	mw_connect_maybe();
 	my $name = shift;
 
 	if (!exists $namespace_id{$name}) {
 		# Look at configuration file, if the record for that namespace is
-		# already stored. Namespaces are stored in form:
+		# already cached. Namespaces are stored in form:
 		# "Name_of_namespace:Id_namespace", ex.: "File:6".
 		my @temp = split(/[ \n]/, run_git("config --get-all remote."
-						. $remotename .".namespaces"));
+						. $remotename .".namespaceCache"));
 		chomp(@temp);
 		foreach my $ns (@temp) {
-			my ($n, $s) = split(/:/, $ns);
-			$namespace_id{$n} = $s;
+			my ($n, $id) = split(/:/, $ns);
+			$namespace_id{$n} = $id;
+			$cached_mw_namespace_id{$n} = 1;
 		}
 	}
 
 	if (!exists $namespace_id{$name}) {
+		print STDERR "Namespace $name not found in cache, querying the wiki ...\n";
 		# NS not found => get namespace id from MW and store it in
 	        # configuration file.
 	        my $query = {
@@ -1233,16 +1205,26 @@ sub get_mw_namespace_id {
 	        my $result = $mediawiki->api($query);
 
 	        while (my ($id, $ns) = each(%{$result->{query}->{namespaces}})) {
-	                if (defined($ns->{canonical}) && ($ns->{canonical} eq $name)) {
-	                        run_git("config --add remote.". $remotename
-					.".namespaces ". $name .":". $ns->{id});
-				$namespace_id{$name} = $ns->{id};
-	                }
+	                if (defined($ns->{id}) && defined($ns->{canonical})) {
+				$namespace_id{$ns->{canonical}} = $ns->{id};
+				if ($ns->{'*'}) {
+					# alias (e.g. french Fichier: as alias for canonical File:)
+					$namespace_id{$ns->{'*'}} = $ns->{id};
+				}
+			}
 	        }
 	}
 
-	if (exists $namespace_id{$name}) {
-		return $namespace_id{$name};
+	my $id = $namespace_id{$name};
+
+	if (defined $id) {
+		# Store explicitely requested namespaces on disk
+		if (!exists $cached_mw_namespace_id{$name}) {
+			run_git("config --add remote.". $remotename
+				.".namespaceCache \"". $name .":". $id ."\"");
+			$cached_mw_namespace_id{$name} = 1;
+		}
+		return $id;
 	} else {
 		die "No such namespace $name on MediaWiki.";
 	}
-- 
1.7.11.1.243.g7462176
