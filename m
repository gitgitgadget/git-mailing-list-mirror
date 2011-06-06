From: Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>
Subject: [PATCH] Add a remote helper to interact with mediawiki, pull & clone handled
Date: Mon,  6 Jun 2011 12:20:35 +0200
Message-ID: <1307355635-5580-1-git-send-email-jeremie.nikaes@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jrnieder@gmail.com,
	Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	=?UTF-8?q?Sylvain=20Boulm=C3=A9?= <sylvain.boulme@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 12:21:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTWvt-0002v5-A2
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 12:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753104Ab1FFKVM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2011 06:21:12 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63201 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105Ab1FFKVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 06:21:09 -0400
Received: by wwa36 with SMTP id 36so3631819wwa.1
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 03:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:cc:subject:date:message-id
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=TRaBKaMr/GkvkOvmqBwUzpqpy1RvvrOWz/Wqk/nqx9o=;
        b=lyDnXqNyMqznhAaIQdLXI48RWbgh+Uxd5C1SJFSw5vBo7vndxr/aQI0Ng2iXs9pzci
         ceXwDLwef05Q2wl1vOqbe1h5ut9ZaJs/+xVsdTVrFVXNnrLv6bFMv6NbnXt7oCTQPSYa
         9VXgSJYo6qZ7LkVcjqErTxyms7e+TBuKcpvbg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=N/jivFLgOkOFcdhCJPJgvtasKRzNCht4xC7tZ5tvhydUT+tdqAhxqIFj9l3Qdif4FN
         3Zz1QI9d0yAmBwMBo0hbodFeHhJ2Yzyvi0Bvk1SGIn0IQR1MxTnEZpb1Q3QvAhxq3pYY
         1e7DrjckCGGkH8weI8uqwZCRxbDfujdIa6xE4=
Received: by 10.227.57.78 with SMTP id b14mr4779503wbh.106.1307355667788;
        Mon, 06 Jun 2011 03:21:07 -0700 (PDT)
Received: from localhost.localdomain (100.46.23.93.rev.sfr.net [93.23.46.100])
        by mx.google.com with ESMTPS id et5sm2748107wbb.50.2011.06.06.03.21.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 06 Jun 2011 03:21:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175115>

Implement a gate between git and mediawiki, allowing git users to
push and pull objects from mediawiki just as one would do with a
classic git repository thanks to remote-helpers.

Currently supported commands are :
      git clone mediawiki::http://onewiki.com
      git pull

You need the following packages installed (available on common
repositories):
      libmediawiki-api-perl
      libdatetime-format-iso8601-perl

Use remote helpers in order to be as transparent as possible
to the git user.

Download Mediawiki revisions through the Mediawiki API and then
fast-import into git.

Mediawiki revisions and git commits are linked thanks to notes bound to
commits.

The import part is done on a refs/mediawiki/<remote> branch before
coming to refs/remote/origin/master (Huge thanks to Jonathan Nieder
for his help)

=46or now, the whole wiki is cloned, but it will be possible to clone o=
nly
some pages: the clone is based on a list of pages which is now all
pages.

Code clarified & improved with the help of Jeff King and Junio C Hamano=
=2E

We were not able to reproduce the empty timestamp bug noticed by Jeff
King, thus needing some further testing. A placeholder is still
implemented in case.

Signed-off-by: J=C3=A9r=C3=A9mie Nikaes <jeremie.nikaes@ensimag.imag.fr=
>
Signed-off-by: Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>
Signed-off-by: Claire Fousse <claire.fousse@ensimag.imag.fr>
Signed-off-by: David Amouyal <david.amouyal@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Sylvain Boulm=C3=A9 <sylvain.boulme@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki     |  306 ++++++++++++++++++++=
++++++++
 contrib/mw-to-git/git-remote-mediawiki.txt |    7 +
 2 files changed, 313 insertions(+), 0 deletions(-)
 create mode 100755 contrib/mw-to-git/git-remote-mediawiki
 create mode 100644 contrib/mw-to-git/git-remote-mediawiki.txt

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git=
/git-remote-mediawiki
new file mode 100755
index 0000000..9db64c2
--- /dev/null
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -0,0 +1,306 @@
+#! /usr/bin/perl
+
+use strict;
+use Switch;
+use MediaWiki::API;
+use Storable qw(freeze thaw);
+use DateTime::Format::ISO8601;
+use Encode qw(encode_utf8);
+
+# Mediawiki filenames can contain forward slashes. This variable decid=
es by which pattern they should be replaced
+my $slash_replacement =3D "<slash>";
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
+				mw_import($cmd[1]);
+			}=20
+		}
+		case "option" {
+			if ($cmd[1] ne "" && $cmd[2] ne "" && $cmd[3] eq "") {
+				mw_option($cmd[1],$cmd[2]);
+			}=20
+		}
+		case "push" {
+			#check the pattern <src>:<dst>
+			my @pushargs =3D split(/:/,$cmd[1]);
+			if ($pushargs[1] ne "" && $pushargs[2] eq "") {
+				mw_push($pushargs[0],$pushargs[1]);
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
+	my $note =3D `git log --notes=3Dmediawiki 2>/dev/null | grep "mediawi=
ki_revision: " | sed -n 1p`;
+	$note =3D~ s/^\s+//; #left trim of note=20
+	my @note_info =3D split(/ /, $note);
+
+	my $lastrevision_number;
+	if (!($note_info[0] eq "mediawiki_revision:")) {
+		print STDERR "No previous mediawiki revision found";
+		$lastrevision_number =3D 0;
+	} else {
+		# Notes are formatted : mediawiki_revision: #number
+		$lastrevision_number =3D $note_info[1];
+		chomp($lastrevision_number);
+		print STDERR "Last local mediawiki revision found is $lastrevision_n=
umber ";
+	}
+	return $lastrevision_number;
+}
+
+sub get_last_remote_revision {
+	my $mediawiki =3D MediaWiki::API->new;
+	$mediawiki->{config}->{api_url} =3D "$url/api.php";
+
+	my $pages =3D $mediawiki->list({
+		action =3D> 'query',
+		list =3D> 'allpages',
+		aplimit =3D> 500,
+	});
+
+	my $max_rev_num =3D 0;
+
+	foreach my $page (@$pages) {
+		my $id =3D $page->{pageid};
+
+
+		my $query =3D {
+			action =3D> 'query',
+			prop =3D> 'revisions',
+			rvprop =3D> 'ids',
+			pageids =3D> $id,
+		};
+
+		my $result =3D $mediawiki->api($query);
+	=09
+		my $lastrev =3D pop(@{$result->{query}->{pages}->{$id}->{revisions}}=
);
+	=09
+		$max_rev_num =3D ($lastrev->{revid} > $max_rev_num ? $lastrev->{revi=
d} : $max_rev_num);
+	}
+
+	print STDERR "Last remote revision found is $max_rev_num\n";
+	return $max_rev_num;
+}
+
+sub literal_data {
+	my ($content) =3D @_;
+	print "data ", bytes::length($content), "\n", $content;
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
+		exit;
+	}
+
+	my @revisions;
+	print STDERR "Searching revisions...\n";
+	my $fetch_from =3D get_last_local_revision() + 1;
+	if ($fetch_from =3D=3D 1) {
+		print STDERR ", fetching from beginning\n";
+	} else {
+		print STDERR ", fetching from here\n";
+	}
+	my $n =3D 1;
+	my $last_timestamp =3D 0;
+	foreach my $page (@$pages) {
+		my $id =3D $page->{pageid};
+
+		print STDERR "$n/", scalar(@$pages), ": ". encode_utf8($page->{title=
})."\n";
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
+		my $dt;
+
+		# This has to be verified, haven't been able to reproduce the scenar=
io
+		if ($rev->{timestamp} !=3D undef) {
+			$dt =3D DateTime::Format::ISO8601->parse_datetime($rev->{timestamp}=
);
+		} else {
+			$dt =3D $last_timestamp + 1;
+		}
+		$last_timestamp =3D $dt;
+
+
+		my $comment =3D defined $rev->{comment} ? $rev->{comment} : '*Empty =
MediaWiki Message*';
+		my $title =3D encode_utf8($result->{query}->{pages}->{$pagerevids->{=
pageid}}->{title});
+		my $content =3D $rev->{'*'};
+	=09
+		$title =3D~ y/ /_/;
+		$title =3D~ s/\//$slash_replacement/g;
+
+		print STDERR "$n/", scalar(@revisions), ": Revision n=C2=B0$pagerevi=
ds->{revid} of $title\n";
+
+		print "commit refs/mediawiki/$remotename/master\n";
+		print "mark :$n\n";
+		print "committer $user <$user\@$wiki_name> ", $dt->epoch, " +0000\n"=
;
+		literal_data(encode_utf8($comment));
+		# If it's not a clone, needs to know where to start from
+		if ($fetch_from !=3D 1 && $n =3D=3D 1) {
+			print "from refs/mediawiki/$remotename/master^0\n";
+		}
+		print "M 644 inline $title.mw\n";
+		literal_data(encode_utf8($content));
+		print "\n\n";
+
+
+		# mediawiki revision number in the git note
+		if ($fetch_from =3D=3D 1 && $n =3D=3D 1) {
+			print "reset refs/notes/mediawiki\n";
+		}
+		print "commit refs/notes/mediawiki\n";
+		print "committer $user <$user\@$wiki_name> ", $dt->epoch, " +0000\n"=
;
+		literal_data(encode_utf8("note added by git-mediawiki"));
+		if ($fetch_from !=3D 1 && $n =3D=3D 1) {
+			print "from refs/notes/mediawiki^0\n";
+		}
+		print "N inline :$n\n";
+		literal_data(encode_utf8("mediawiki_revision: " . $pagerevids->{revi=
d}));
+		print "\n\n";
+	}
+
+	if ($fetch_from =3D=3D 1) {
+		if ($n !=3D 0) {
+			print "reset $_[0]\n"; #$_[0] contains refs/heads/master
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
+
+	print STDERR "Not yet implemented";
+	print "\n";
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
1.7.4.1
