From: Chris Lamb <lamby@debian.org>
Subject: [PATCH] git-rebase--interactive: Handle commit messages that end in
 backslash
Date: Thu, 13 May 2010 13:39:55 +0100
Message-ID: <20100513133955.05493175@bobcat.office>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/+nvyg6SAGciE7hxFsILSjHD"; protocol="application/pgp-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 13 14:50:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCXrv-0002Cr-Fx
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 14:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757462Ab0EMMuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 08:50:19 -0400
Received: from new1.smtp.messagingengine.com ([66.111.4.221]:48138 "EHLO
	new1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754588Ab0EMMuS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 May 2010 08:50:18 -0400
X-Greylist: delayed 613 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 May 2010 08:50:18 EDT
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A6507F5DCD
	for <git@vger.kernel.org>; Thu, 13 May 2010 08:40:03 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 13 May 2010 08:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=date:from:to:subject:message-id:mime-version:content-type; s=smtpout; bh=DQvQCJ2ERCoQ7n15fPHCCga0u20=; b=gHrys/drilLpO5MF814r0WasW240HisC6Haf+Hf2QFnuzDlF0CeNrpRCyJYt/g2qmcG7CWvCn75w3i155Eln2Ak8628pJ4eheQpM6ikZvNrhkAv+sZ4MIy3kQF7WskLCRNBYhsKScEa5wKCOOg/jJXb3CSNpqsoSkb/9qaEqzxY=
X-Sasl-enc: VEOXL7FJ0/kb0O4D0WTrJtl/y8HfvVmBTEGfFLs6TXIZ 1273754402
Received: from bobcat.office (87-194-70-110.bethere.co.uk [87.194.70.110])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C213E53580
	for <git@vger.kernel.org>; Thu, 13 May 2010 08:40:02 -0400 (EDT)
X-Mailer: Claws Mail 3.7.2 (GTK+ 2.18.2; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146999>

--Sig_/+nvyg6SAGciE7hxFsILSjHD
Content-Type: multipart/mixed; boundary="MP_/ogUb.rkZtSfnmse9X5/tubA"

--MP_/ogUb.rkZtSfnmse9X5/tubA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


This patch fixes three issues with handling commits that end in a
backslash character ("\"), two of which had potential for silent data
"loss".

First, if you had two commits

  abcde...   Remove trailing \
  01234...   Another commit

then git rebase -i formatted this in your editor like so:

 pick abcde Remove trailing pick 01234: Another commit

Assuming you don't spot this visually, git-rebase will then happily skip
over 01234 upon processing, removing that commit disappear from your HEAD
(!).

Secondly, when skipping over commits whose parents were unchanged, if any
of these commits ended in a backslash, it would try and ignore it.

Lastly, this patch fixes "edit"ing and "squash"ing of commits that end
in a backslash; git-rebase would previously blow up.

Signed-off-by: Chris Lamb <lamby@debian.org>
---
 git-rebase--interactive.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


Regards,

--=20
      ,''`.
     : :'  :     Chris Lamb
     `. `'`      lamby@debian.org
       `-

--MP_/ogUb.rkZtSfnmse9X5/tubA
Content-Type: text/x-patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename=0001-git-rebase-interactive-Handle-commit-messages-that-e.patch

=46rom 63a17f07dc8eba199f59699a055eebd6e696f27f Mon Sep 17 00:00:00 2001
From: Chris Lamb <lamby@debian.org>
Date: Thu, 13 May 2010 13:36:45 +0100
Subject: [PATCH] git-rebase--interactive: Handle commit messages that end i=
n backslash

This patch fixes three issues with handling commits that end in a backslash
character ("\"), two of which had potential for silent data "loss".

First, if you had two commits

  abcde...   Remove trailing \
  01234...   Another commit

then git rebase -i formatted this in your editor like so:

 pick abcde Remove trailing pick 01234: Another commit

Assuming you don't spot this visually, git-rebase will then happily skip
over 01234 upon processing, removing that commit disappear from your HEAD
(!).

Secondly, when skipping over commits whose parents were unchanged, if any
of these commits ended in a backslash, it would try and ignore it.

Lastly, this patch fixes "edit"ing and "squash"ing of commits that end in a
backslash; git-rebase would previously blow up.

Signed-off-by: Chris Lamb <lamby@debian.org>
---
 git-rebase--interactive.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 436b7f5..31c5fd2 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -450,7 +450,7 @@ record_in_rewritten() {
=20
 do_next () {
 	rm -f "$MSG" "$AUTHOR_SCRIPT" "$AMEND" || exit
-	read command sha1 rest < "$TODO"
+	sed -e 's/\\$/\\\\/g' "$TODO" | read command sha1 rest
 	case "$command" in
 	'#'*|''|noop)
 		mark_action_done
@@ -591,7 +591,7 @@ do_rest () {
 # skip picking commits whose parents are unchanged
 skip_unnecessary_picks () {
 	fd=3D3
-	while read command sha1 rest
+	sed -e 's/\\$/\\\\/g' "$TODO" | while read command sha1 rest
 	do
 		# fd=3D3 means we skip the command
 		case "$fd,$command,$(git rev-parse --verify --quiet $sha1^)" in
@@ -607,7 +607,7 @@ skip_unnecessary_picks () {
 			;;
 		esac
 		echo "$command${sha1:+ }$sha1${rest:+ }$rest" >&$fd
-	done <"$TODO" >"$TODO.new" 3>>"$DONE" &&
+	done >"$TODO.new" 3>>"$DONE" &&
 	mv -f "$TODO".new "$TODO" &&
 	case "$(peek_next_command)" in
 	squash|s|fixup|f)
@@ -890,7 +890,7 @@ first and then run 'git rebase --continue' again."
 		git rev-list $MERGES_OPTION --pretty=3Doneline --abbrev-commit \
 			--abbrev=3D7 --reverse --left-right --topo-order \
 			$REVISIONS | \
-			sed -n "s/^>//p" | while read shortsha1 rest
+			sed -n "s/^>//p" | sed -e 's/\\$/\\\\/g' | while read shortsha1 rest
 		do
 			if test t !=3D "$PRESERVE_MERGES"
 			then
--=20
1.7.1


--MP_/ogUb.rkZtSfnmse9X5/tubA--

--Sig_/+nvyg6SAGciE7hxFsILSjHD
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvr8xwACgkQ5/8uW2NPmiBBhACgqiR2PZRcmnTo179KsVeh0CgR
DSAAnRSQ/C2S4WJbWWQS+hhOEYlG0GX6
=N3vp
-----END PGP SIGNATURE-----

--Sig_/+nvyg6SAGciE7hxFsILSjHD--
