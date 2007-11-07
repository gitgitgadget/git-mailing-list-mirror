From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: [PATCH] send-email: apply --suppress-from to S-o-b and cc-cmd
Date: Wed,  7 Nov 2007 08:34:12 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <1194420852-15822-1-git-send-email-ukleinek@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= <Uwe.Kleine-Koenig@digi.com>,
	Ryan Anderson <ryan@michonline.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 07 08:33:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpfPx-0008C5-FH
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 08:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555AbXKGHd0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Nov 2007 02:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755438AbXKGHd0
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 02:33:26 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:61976 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755414AbXKGHdZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Nov 2007 02:33:25 -0500
X-Greylist: delayed 1596 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Nov 2007 02:33:25 EST
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.68)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IpfPg-0004he-4A; Wed, 07 Nov 2007 08:33:24 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id lA77XM6V003986;
	Wed, 7 Nov 2007 08:33:22 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id lA77XC2Z003985;
	Wed, 7 Nov 2007 08:33:12 +0100 (MET)
X-Mailer: git-send-email 1.5.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63774>

=46rom: Uwe Kleine-K=C3=B6nig <Uwe.Kleine-Koenig@digi.com>

Signed-off-by: Uwe Kleine-K=C3=B6nig <Uwe.Kleine-Koenig@digi.com>
Cc: Ryan Anderson <ryan@michonline.com>
---
Hello,

I don't see the sense in adding the sender to Cc: from Signed-off-by
lines but not from From:.  If someone is convinced it makes sense, I'm
willing to send a new patch that uses a different option.

Cc'd Ryan as the author of --suppress-from.

I already tried to send this from my work's email account, but it seems
to have problems to send mails to vger (and lists.arm.linux.org.uk).
Sorry Ryan if you get this mail once more.

Best regards
Uwe

 Documentation/git-send-email.txt |    3 +--
 git-send-email.perl              |    5 +++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-=
email.txt
index e38b702..659215a 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -113,8 +113,7 @@ The --cc option must be repeated for each user you =
want on the cc list.
 	is not set, this will be prompted for.
=20
 --suppress-from, --no-suppress-from::
-        If this is set, do not add the From: address to the cc: list, =
if it
-        shows up in a From: line.
+        If this is set, do not add the From: address to the cc: list.
         Default is the value of 'sendemail.suppressfrom' configuration=
 value;
         if that is unspecified, default to --no-suppress-from.
=20
diff --git a/git-send-email.perl b/git-send-email.perl
index 96051bc..f4b8f96 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -88,8 +88,7 @@ Options:
=20
    --smtp-ssl     If set, connects to the SMTP server using SSL.
=20
-   --suppress-from Suppress sending emails to yourself if your address
-                  appears in a From: line. Defaults to off.
+   --suppress-from Suppress sending emails to yourself. Defaults to of=
f.
=20
    --thread       Specify that the "In-Reply-To:" header should be set=
 on all
                   emails. Defaults to on.
@@ -730,6 +729,7 @@ foreach my $t (@files) {
 			if (/^(Signed-off-by|Cc): (.*)$/i && $signed_off_cc) {
 				my $c =3D $2;
 				chomp $c;
+				next if ($c eq $sender and $suppress_from);
 				push @cc, $c;
 				printf("(sob) Adding cc: %s from line '%s'\n",
 					$c, $_) unless $quiet;
@@ -745,6 +745,7 @@ foreach my $t (@files) {
 			my $c =3D $_;
 			$c =3D~ s/^\s*//g;
 			$c =3D~ s/\n$//g;
+			next if ($c eq $sender and $suppress_from);
 			push @cc, $c;
 			printf("(cc-cmd) Adding cc: %s from: '%s'\n",
 				$c, $cc_cmd) unless $quiet;
--=20
1.5.3.4
