From: Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>
Subject: [RFC/PATCH 2/2] Git-remote-mediawiki: Add push support
Date: Thu,  9 Jun 2011 15:16:00 +0200
Message-ID: <1307625360-10973-2-git-send-email-jeremie.nikaes@ensimag.imag.fr>
References: <1307625360-10973-1-git-send-email-jeremie.nikaes@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	=?UTF-8?q?Sylvain=20Boulm=C3=A9?= <sylvain.boulme@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 15:17:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUf6c-0008Ao-Ei
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 15:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757825Ab1FINQ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 09:16:57 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54010 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757798Ab1FINQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 09:16:56 -0400
Received: by wwa36 with SMTP id 36so1686350wwa.1
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 06:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:cc:subject:date:message-id
         :x-mailer:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=NY9NSoDxvRn+lbsAtv4dBH0ol1HM1ZFiEEQDvOrcnIs=;
        b=mRsS7Jlc4LaqIPxaNOgu6DirTUoYa1k4/ITJ4hnJUB1VLMaDSagt9xv227nIZHsSKD
         vt2N95tUNpo3IOIDgpmRVIGiFPiezGvu4PwojbIuxL5/5li8uucGeBf3X6Oj12ZZ/Yvk
         6uxQYxl9P8V7K27DsJPsx1Phc6SYRtfbMe0zc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        b=JFmSivTJu8GDi2IEHCnuMUFMPxSKRwcBsysdIVVzTa4tZjsuufrFQ9AM9bVZiL+A7v
         HAKSHnIBvVCPtnfx936T3HbTiJd+d7Ru1vWV/cGM5MmsPlIkCmgNPb0VMMJHdDVuWwJl
         Mg3g2YaQuANEWiBY4i8TADU/TJGgBtKJRdqzE=
Received: by 10.227.128.20 with SMTP id i20mr824513wbs.3.1307625415348;
        Thu, 09 Jun 2011 06:16:55 -0700 (PDT)
Received: from localhost.localdomain (227.60.23.93.rev.sfr.net [93.23.60.227])
        by mx.google.com with ESMTPS id e1sm1219942wbh.22.2011.06.09.06.16.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Jun 2011 06:16:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1307625360-10973-1-git-send-email-jeremie.nikaes@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175522>

Push is now supported by the remote-helper
Thanks to notes metadata, it is possible to compare remote and local
last mediawiki revision to warn non fast-forward and everything
up-to-date.

When allowed, push looks for each commit between remotes/origin/master
and HEAD, catches every blob related to these commit and push them in
chronological order. To do so, it uses git rev-list --children HEAD and
travels the tree from remotes/origin/master to HEAD through children. I=
n
other words :

	* Shortest path from remotes/origin/master to HEAD
	* For each commit encountered, push blobs related to this commit

An automatic git pull --rebase is executed after a successful push to
get metadata back from mediawiki. This is also done to maintain
closeness with the form of a mediawiki history. It can be a problem
since it also flatens the entire history. (This solution is still
to be discussed).

To send files to mediawiki, the mediawiki API is used. A filter is
applied to the data send because mediawiki pages cannot have blank
characters at the end. The filter is thus more or less a right trim.

Signed-off-by: J=C3=A9r=C3=A9mie Nikaes <jeremie.nikaes@ensimag.imag.fr=
>
Signed-off-by: Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>
Signed-off-by: Claire Fousse <claire.fousse@ensimag.imag.fr>
Signed-off-by: David Amouyal <david.amouyal@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Sylvain Boulm=C3=A9 <sylvain.boulme@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki |   93 ++++++++++++++++++++++++=
+++++++-
 1 files changed, 92 insertions(+), 1 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git=
/git-remote-mediawiki
index 176ff09..dc1aacf 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -148,6 +148,14 @@ sub get_last_remote_revision {
 	return $max_rev_num;
 }
=20
+sub mediawiki_filter($) {
+	# Mediawiki does not allow blank space at the end of a page and ends =
with a single \n.
+	# This function right trims a string and adds a \n at the end to foll=
ow this rule
+	my $string =3D shift;
+	$string =3D~ s/\s+$//;
+	return $string."\n";
+}
+
 sub literal_data {
 	my ($content) =3D @_;
 	print STDOUT "data ", bytes::length($content), "\n", $content;
@@ -175,6 +183,7 @@ sub mw_list {
 }
=20
 sub mw_option {
+	print STDERR "remote-helper capability 'option' not yet implemented \=
n";
 	print STDOUT "unsupported\n";
 }
=20
@@ -318,5 +327,87 @@ sub mw_import {
 }
=20
 sub mw_push {
-	print STDERR "Push not yet implemented\n";
+
+	sub push_file {
+		#$_[0] contains a string in this format :
+		#100644 100644 <sha1_of_blob_before_commit> <sha1_of_blob_now> <stat=
us>\0<filename.mw>\0
+		#$_[1] contains the title of the commit message (the only phrase kep=
t in the revision message)
+		my @blob_info_split =3D split(/ |\t|\0/, $_[0]);
+
+		my $sha1 =3D $blob_info_split[3];
+		my $complete_file_name =3D $blob_info_split[5];
+		# complete_file_name =3D uri_unescape($complete_file_name); # If we =
use the uri escape before
+		# we should unescape here, before anything
+	=09
+		if (substr($complete_file_name,-3) eq ".mw"){
+			my $title =3D substr($complete_file_name,0,-3);
+			$title =3D~ s/$slash_replacement/\//g;
+
+			my $file_content =3D run_git("cat-file -p $sha1");
+		=09
+			my $mw =3D MediaWiki::API->new();
+			$mw->{config}->{api_url} =3D "$url/api.php";
+
+			# log in to the wiki : here should be added a way to push changes w=
ith an identity
+			#$mw->login( { lgname =3D> 'login', lgpassword =3D> 'passwd' })
+			#|| die $mw->{error}->{code} . ': ' . $mw->{error}->{details};
+		=09
+			$mw->edit( {
+				action =3D> 'edit',
+				summary =3D> $_[1],
+				title =3D> $title,
+				text =3D> mediawiki_filter($file_content),
+			}, {
+				skip_encoding =3D> 1 # Helps with names with accentuated character=
s
+			}) || die 'Fatal: Error ' . $mw->{error}->{code} . ' from mediwiki:=
 ' . $mw->{error}->{details};
+
+			print STDERR "Pushed file : $sha1 - $title\n";
+		} else {
+			print STDERR "$complete_file_name not a mediawiki file. '(Not pusha=
ble on this version)\n"
+		}
+	}
+=09
+	my $last_local_revid =3D get_last_local_revision();
+	my $last_remote_revid =3D get_last_remote_revision();
+
+	# Get sha1 of commit pointed by local HEAD
+	my $HEAD_sha1 =3D run_git("rev-parse $_[0] 2>/dev/null"); chomp($HEAD=
_sha1);
+	# Get sha1 of commit pointed by remotes/origin/master
+	my $remoteorigin_sha1 =3D run_git("rev-parse refs/remotes/origin/mast=
er 2>/dev/null"); chomp($remoteorigin_sha1);
+
+	if ($last_local_revid < $last_remote_revid){
+		my $message =3D "\"To prevent you from losing history, non-fast-forw=
ard updates were rejected \\n";
+		$message .=3D "Merge the remote changes (e.g. 'git pull') before pus=
hing again. See the";
+		$message .=3D " 'Note about fast-forwards' section of 'git push --he=
lp' for details.\"";
+		print STDOUT "error $_[0] $message\n";
+		print STDOUT "\n";
+	} elsif ($HEAD_sha1 ne $remoteorigin_sha1) {
+		# Get every commit in between HEAD and refs/remotes/origin/master,
+		# including HEAD and refs/remotes/origin/master
+		my $parsed_sha1 =3D $remoteorigin_sha1;
+		while ($parsed_sha1 ne $HEAD_sha1) {
+			my @commit_info =3D  grep(/^$parsed_sha1/, `git rev-list --children=
 $_[0]`);
+			my @commit_info_split =3D split(/ |\n/, $commit_info[0]);
+			# $commit_info_split[0] is the sha1 of the commit itself
+			# $commit_info_split[1] is the sha1 of its direct child
+			my $blob_infos =3D run_git("diff --raw --abbrev=3D40 -z $commit_inf=
o_split[0] $commit_info_split[1]");
+			my @blob_info_list =3D split(/\n/, $blob_infos);
+			# Keep the first line of the commit message as mediawiki comment fo=
r the revision
+			my $commit_msg =3D (split(/\n/, run_git("show --pretty=3Dformat:\"%=
s\" $commit_info_split[1]")))[0];
+			chomp($commit_msg);
+			foreach my $blob_info (@blob_info_list) {
+				# Push every blob
+				push_file($blob_info, $commit_msg);
+			}
+			$parsed_sha1 =3D $commit_info_split[1];
+		}
+
+		print STDOUT "ok $_[1]\n";
+		print STDOUT "\n";
+	=09
+		# Pulling from mediawiki after pushing in order to keep things synch=
ronized
+		exec("git pull --rebase >/dev/null");
+	} else {
+		print STDOUT "\n";
+	}
 }
--=20
1.7.4.1
