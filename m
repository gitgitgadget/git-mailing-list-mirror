From: =?utf-8?q?D=C3=A9vai=20Tam=C3=A1s?= <devait@mailbox.sk>
Subject: [PATCH] git-svn: Fix for rewriteRoot URL containing username.
Date: Thu, 12 Feb 2009 00:14:02 +0100
Message-ID: <1234394042-11577-1-git-send-email-devait@mailbox.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?D=C3=A9vai=20Tam=C3=A1s?= <devait@mailbox.sk>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 12 00:26:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXOTh-0000iK-7V
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 00:26:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755349AbZBKXZW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Feb 2009 18:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754828AbZBKXZV
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 18:25:21 -0500
Received: from b.relay.invitel.net ([62.77.203.4]:48547 "EHLO
	b.relay.invitel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807AbZBKXZV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 18:25:21 -0500
X-Greylist: delayed 653 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Feb 2009 18:25:21 EST
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by b.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id 7727031A263
	for <git@vger.kernel.org>; Thu, 12 Feb 2009 00:14:24 +0100 (CET)
Received: from localhost.localdomain ([87.97.126.233])
 by mail.invitel.hu (Invitel Messaging Server)
 with ESMTPA id <0KEX00KHBCJEUZ30@invitel.hu> for git@vger.kernel.org; Thu,
 12 Feb 2009 00:14:03 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109545>

If the new svn root URL given with the svn-remote.<repo>.rewriteRoot co=
nfig option
(or by the --rewrite-root option to 'git svn init') contains a username
(such as 'svn+ssh://username@example.com/repo'), find_by_url() cannot f=
ind
the repository URL, because the URL contained in the commit message doe=
s have
the username removed.

Signed-off-by: D=C3=A9vai Tam=C3=A1s <devait@mailbox.sk>
---
 git-svn.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 001a1d8..83cb36f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1693,6 +1693,7 @@ sub find_by_url { # repos_root and, path are opti=
onal
 			my $prefix =3D '';
 			if ($rwr) {
 				$z =3D $rwr;
+				remove_username($z);
 			} elsif (defined $svm) {
 				$z =3D $svm->{source};
 				$prefix =3D $svm->{replace};
--=20
1.6.1.2
