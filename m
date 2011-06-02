From: Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>
Subject: [RFC/PATCH] Added a remote helper to interact with mediawiki, pull & clone handled
Date: Thu,  2 Jun 2011 11:28:31 +0200
Message-ID: <1307006911-4326-1-git-send-email-arnaud.lacurie@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	=?UTF-8?q?J=C3=A9r=C3=A9mie=20Nikaes?= 
	<jeremie.nikaes@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	=?UTF-8?q?Sylvain=20Boulm=C3=A9?= <sylvain.boulme@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 11:29:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QS4Db-0001iT-JD
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 11:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732Ab1FBJ3Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jun 2011 05:29:25 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53934 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534Ab1FBJ3X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 05:29:23 -0400
Received: by wya21 with SMTP id 21so454653wya.19
        for <git@vger.kernel.org>; Thu, 02 Jun 2011 02:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:cc:subject:date:message-id
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=ndrLUS3vEl40SwHGUG5u0cM39coCv9dq4+rGIdmsdnQ=;
        b=xFwlymIHzTIKR3NgyoAEtUDjQm1sVSguKyWAC1fGGGwzUDLS42T4tpnUrgjUemhU5v
         hvz9JK7IzsW6PDjbQZAL1vUNzStDKifpzjnsA+368karUGzUsnEot6HQoNiVJNNGuaKj
         RvTK/XusaINzej2JAlZBlWXGfRZD/pxxQ4vtw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=T1zV82K4RjvbMY+X9JIm1BnhaHWnAFlOIMDz7lcXbUEryPDiKbGu1JMlxfyuIgR1YS
         spftB2+VLIDul+2zi/QoogeaL7LyUBoBcDj+2P1ypqR41MdklmhQqbV+6VAgAe3QlUNy
         ebxvbrmAPWe1Do4li0J/hn3gOFFthsXc9KiP0=
Received: by 10.227.172.74 with SMTP id k10mr502508wbz.80.1307006961484;
        Thu, 02 Jun 2011 02:29:21 -0700 (PDT)
Received: from localhost.localdomain (100.46.23.93.rev.sfr.net [93.23.46.100])
        by mx.google.com with ESMTPS id o19sm259911wbh.38.2011.06.02.02.29.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Jun 2011 02:29:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.3.486.gdc5865
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174932>

Implements a gate between git and mediawiki, allowing git users to
push and pull objects from mediawiki just as one would do with a
classic git repository thanks to remote-helpers.

Currently supported commands are :
       git clone mediawiki::http://onewiki.com
       git pull

You need the following packages installed (available on common
repositories):
       libmediawiki-api-perl
       libdatetime-format-iso8601-perl

Remote helpers have been used in order to be as transparent as possible
to the git user.

Mediawiki revisions are downloaded through the Mediawiki API and then
fast-imported into git.

Mediawiki revisions and git commits are linked thanks to notes bound to
commits.

The import part is done on a refs/mediawiki/<remote> branch before
coming to refs/remote/origin/master (Huge thanks to Jonathan Nieder
for his help)

=46or now, the whole wiki is cloned, but it will be possible to clone o=
nly
some pages: the clone is based on a list of pages which is now all
pages.

Signed-off-by: J=C3=A9r=C3=A9mie Nikaes <jeremie.nikaes@ensimag.imag.fr=
>
Signed-off-by: Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>
Signed-off-by: Claire Fousse <claire.fousse@ensimag.imag.fr>
Signed-off-by: David Amouyal <david.amouyal@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Sylvain Boulm=C3=A9 <sylvain.boulme@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki     |  252 ++++++++++++++++++++=
++++++++
 contrib/mw-to-git/git-remote-mediawiki.txt |    7 +
 2 files changed, 259 insertions(+), 0 deletions(-)
 create mode 100755 contrib/mw-to-git/git-remote-mediawiki
 create mode 100644 contrib/mw-to-git/git-remote-mediawiki.txt

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git=
/git-remote-mediawiki
new file mode 100755
index 0000000..f20edc4
--- /dev/null
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -0,0 +1,252 @@
+#! /usr/bin/perl
+
+use strict;
+use Switch;
+use MediaWiki::API;
+use Storable qw(freeze thaw);
+use DateTime::Format::ISO8601;
+use Encode qw(encode_utf8);
+
+my $remotename =3D $ARGV[0];
+my $url =3D $ARGV[1];
+
+print STDERR "$url\n";
+
+# commands parser
+my $loop =3D 1;
+my $entry;
+my @cmd;
+while ($loop) {
+	$| =3D 1; #flush STDOUT
+	$entry =3D <STDIN>;
+	print STDERR $entry;
+	chomp($entry);
+	@cmd =3D undef;
+	@cmd =3D split(/ /,$entry);
+	switch ($cmd[0]) {
+		case "capabilities" {
+			if ($cmd[1] eq "") {
+				mw_capabilities();
+			} else {
+			       $loop =3D 0;
+			}
+		}
+		case "list" {
+			if ($cmd[2] eq "") {
+				mw_list($cmd[1]);
+			} else {
+			       $loop =3D 0;
+			}
+		}
+		case "import" {
+			if ($cmd[1] ne "" && $cmd[2] eq "") {
+				mw_import($url);
+			} else {
+			       $loop =3D 0;
+			}
+		}
+		case "option" {
+			mw_option($cmd[1],$cmd[2]);
+		}
+		case "push" {
+			#check the pattern +<src>:<dist>
+			my @pushargs =3D split(/:/,$cmd[1]);
+			if ($pushargs[1] ne "" && $pushargs[2] eq ""
+			&& (substr($pushargs[0],0,1) eq "+")) {
+				mw_push(substr($pushargs[0],1),$pushargs[1]);
+			} else {
+			       $loop =3D 0;
+			}
+		} else {
+			$loop =3D 0;
+		}
+	}
+	close(FILE);
+}
+
+########################## Functions ##############################
+
+sub get_last_local_revision {
+	# Get last commit sha1
+	my $commit_sha1 =3D `git rev-parse refs/mediawiki/$remotename/master =
2>/dev/null`;
+
+	# Get note regarding that commit
+	chomp($commit_sha1);
+	my $note =3D `git notes show $commit_sha1 2>/dev/null`;
+	my @note_info =3D split(/ /, $note);
+
+	my $lastrevision_number;
+	if (!($note_info[0] eq "mediawiki_revision:")) {
+		print STDERR "No previous mediawiki revision found, fetching from be=
ginning\n";
+		$lastrevision_number =3D 0;
+	} else {
+		# Notes are formatted : mediawiki_revision: #number
+		$lastrevision_number =3D $note_info[1];
+		chomp($lastrevision_number);
+		print STDERR "Last mediawiki revision found is $lastrevision_number,=
 fetching from here\n";
+	}
+	return $lastrevision_number;
+}
+
+sub mw_capabilities {
+	# Revisions are imported to the private namespace
+	# refs/mediawiki/$remotename/ by the helper and fetched into
+	# refs/remotes/$remotename later by fetch.
+	print STDOUT "refspec refs/heads/*:refs/mediawiki/$remotename/*\n";
+	print STDOUT "import\n";
+	print STDOUT "list\n";
+	print STDOUT "option\n";
+	print STDOUT "push\n";
+	print STDOUT "\n";
+}
+
+sub mw_list {
+	# MediaWiki do not have branches, we consider one branch arbitrarily
+	# called master
+	print STDOUT "? refs/heads/master\n";
+	print STDOUT '@'."refs/heads/master HEAD\n";
+	print STDOUT "\n";
+
+}
+
+sub mw_option {
+	print STDERR "not yet implemented \n";
+	print STDOUT "unsupported\n";
+}
+
+sub mw_import {
+	my @wiki_name =3D split(/:\/\//,$url);
+	my $wiki_name =3D $wiki_name[1];
+
+	my $mediawiki =3D MediaWiki::API->new;
+	$mediawiki->{config}->{api_url} =3D "$url/api.php";
+
+	my $pages =3D $mediawiki->list({
+		action =3D> 'query',
+		list =3D> 'allpages',
+		aplimit =3D> 500,
+	});
+	if ($pages =3D=3D undef) {
+		print STDERR "fatal: '$url' does not appear to be a mediawiki\n";
+		print STDERR "fatal: make sure '$url/api.php' is a valid page\n";
+		exit;
+	}
+
+	my @revisions;
+	print STDERR "Searching revisions...\n";
+	my $fetch_from =3D get_last_local_revision() + 1;
+	my $n =3D 1;
+	foreach my $page (@$pages) {
+		my $id =3D $page->{pageid};
+
+		print STDERR "$n/", scalar(@$pages), ": $page->{title}\n";
+		$n++;
+
+		my $query =3D {
+			action =3D> 'query',
+			prop =3D> 'revisions',
+			rvprop =3D> 'ids',
+			rvdir =3D> 'newer',
+			rvstartid =3D> $fetch_from,
+			rvlimit =3D> 500,
+			pageids =3D> $page->{pageid},
+		};
+
+		my $revnum =3D 0;
+		# Get 500 revisions at a time due to the mediawiki api limit
+		while (1) {
+			my $result =3D $mediawiki->api($query);
+
+			# Parse each of those 500 revisions
+			foreach my $revision (@{$result->{query}->{pages}->{$id}->{revision=
s}}) {
+				my $page_rev_ids;
+				$page_rev_ids->{pageid} =3D $page->{pageid};
+				$page_rev_ids->{revid} =3D $revision->{revid};
+				push (@revisions, $page_rev_ids);
+				$revnum++;
+			}
+			last unless $result->{'query-continue'};
+			$query->{rvstartid} =3D $result->{'query-continue'}->{revisions}->{=
rvstartid};
+			print "\n";
+		}
+		print STDERR "  Found ", $revnum, " revision(s).\n";
+	}
+
+	# Creation of the fast-import stream
+	print STDERR "Fetching & writing export data...\n";
+	binmode STDOUT, ':binary';
+	$n =3D 0;
+
+	foreach my $pagerevids (sort {$a->{revid} <=3D> $b->{revid}} @revisio=
ns) {
+		#fetch the content of the pages
+		my $query =3D {
+			action =3D> 'query',
+			prop =3D> 'revisions',
+			rvprop =3D> 'content|timestamp|comment|user|ids',
+			revids =3D> $pagerevids->{revid},
+		};
+
+		my $result =3D $mediawiki->api($query);
+
+		my $rev =3D pop(@{$result->{query}->{pages}->{$pagerevids->{pageid}}=
->{revisions}});
+
+		$n++;
+		my $user =3D $rev->{user} || 'Anonymous';
+		my $dt =3D DateTime::Format::ISO8601->parse_datetime($rev->{timestam=
p});
+
+		my $comment =3D defined $rev->{comment} ? $rev->{comment} : '*Empty =
MediaWiki Message*';
+		my $title =3D $result->{query}->{pages}->{$pagerevids->{pageid}}->{t=
itle};
+		my $content =3D $rev->{'*'};
+		$title =3D~ y/ /_/;
+
+		print STDERR "$n/", scalar(@revisions), ": Revision n=C2=B0$pagerevi=
ds->{revid} of $title\n";
+
+		print "commit refs/mediawiki/$remotename/master\n";
+		print "mark :$n\n";
+		print "committer $user <$user\@$wiki_name> ", $dt->epoch, " +0000\n"=
;
+		print "data ", bytes::length(encode_utf8($comment)), "\n", encode_ut=
f8($comment);
+		# If it's not a clone, needs to know where to start from
+		if ($fetch_from !=3D 1 && $n =3D=3D 1) {
+			print "from refs/mediawiki/$remotename/master^0\n";
+		}
+		print "M 644 inline $title.wiki\n";
+		print "data ", bytes::length(encode_utf8($content)), "\n", encode_ut=
f8($content);
+		print "\n\n";
+
+
+		# mediawiki revision number in the git note
+		my $note_comment =3D encode_utf8("note added by git-mediawiki");
+		my $note_comment_length =3D bytes::length($note_comment);
+		my $note_content =3D encode_utf8("mediawiki_revision: " . $pagerevid=
s->{revid} . "\n");
+		my $note_content_length =3D bytes::length($note_content);
+
+		if ($fetch_from =3D=3D 1 && $n =3D=3D 1) {
+			print "reset refs/notes/commits\n";
+		}
+		print "commit refs/notes/commits\n";
+		print "committer $user <user\@example.com> ", $dt->epoch, " +0000\n"=
;
+		print "data ", $note_comment_length, "\n", $note_comment;
+		if ($fetch_from !=3D 1 && $n =3D=3D 1) {
+			print "from refs/notes/commits^0\n";
+		}
+		print "N inline :$n\n";
+		print "data ", $note_content_length, "\n", $note_content;
+		print "\n\n";
+	}
+
+	if ($fetch_from =3D=3D 1) {
+		if ($n !=3D 0) {
+			print "reset refs/heads/master\n";
+			print "from :$n\n";
+		} else {
+			print STDERR "You appear to have cloned an empty mediawiki\n";
+			#What do we have to do here ? If nothing is done, an error is throw=
n saying that
+			#HEAD is refering to unknown object 0000000000000000000
+		}
+	}
+
+}
+
+sub mw_push {
+	print STDERR "not yet implemented \n";
+}
diff --git a/contrib/mw-to-git/git-remote-mediawiki.txt b/contrib/mw-to=
-git/git-remote-mediawiki.txt
new file mode 100644
index 0000000..4d211f5
--- /dev/null
+++ b/contrib/mw-to-git/git-remote-mediawiki.txt
@@ -0,0 +1,7 @@
+Git-Mediawiki is a project which aims the creation of a gate
+between git and mediawiki, allowing git users to push and pull
+objects from mediawiki just as one would do with a classic git
+repository thanks to remote-helpers.
+
+For more information, visit the wiki at
+https://github.com/Bibzball/Git-Mediawiki/wiki
--=20
1.7.5.3.486.gdc5865
