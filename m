From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 03/16] send-email: use lexical filehandles during sending
Date: Thu, 30 Sep 2010 13:42:56 +0000
Message-ID: <1285854189-10240-4-git-send-email-avarab@gmail.com>
References: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ryan Anderson <rda@google.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 30 15:43:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1JQJ-0000ri-He
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 15:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756045Ab0I3Nnp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 09:43:45 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55464 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656Ab0I3Nno (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 09:43:44 -0400
Received: by mail-ww0-f44.google.com with SMTP id 15so389309wwe.1
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 06:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Uclu5bHEo69RKeCZy/K+2anUhdMbpS/Fcp1P6FF4+Jk=;
        b=c3A3OvvsNaTS574BOYzFbWwTas9YOPvINHJc4DNCshRa8abEjq4vEVbDF2eY9cOLDW
         JmhrH/QAbJlIxmH/uN3jDOw437xyBWjOK2Zc0BIrfXotdsg03KXVzJBRax51dZmw03j6
         JAi7Oph6Iv09O2RVf619h4O0QmqWYenjgWCEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=eEMj9fT0gHVzX1hP5o9L9HqIyuWgmB/z6ibzkK1Ycz4NLYroC2+vxzHhjPf6rl0IhK
         7H8RBJALg8KtJE3nTmeihlMd7evkkzKl1C8h0Yg0KgucL78k3MFdaDvebxeD+kIvsQ+g
         p0pcojOCrRbjngDff8AVjoL14eKK5AVBNRJb8=
Received: by 10.216.165.16 with SMTP id d16mr3054295wel.0.1285854223339;
        Thu, 30 Sep 2010 06:43:43 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e56sm6328567wer.46.2010.09.30.06.43.41
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 06:43:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157654>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-send-email.perl |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 634835c..488d894 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1144,7 +1144,7 @@ $subject =3D $initial_subject;
 $message_num =3D 0;
=20
 foreach my $t (@files) {
-	open(F,"<",$t) or die "can't open file $t";
+	open my $fh, "<", $t or die "can't open file $t";
=20
 	my $author =3D undef;
 	my $author_encoding;
@@ -1157,7 +1157,7 @@ foreach my $t (@files) {
 	$message =3D "";
 	$message_num++;
 	# First unfold multiline header fields
-	while(<F>) {
+	while(<$fh>) {
 		last if /^\s*$/;
 		if (/^\s+\S/ and @header) {
 			chomp($header[$#header]);
@@ -1233,7 +1233,7 @@ foreach my $t (@files) {
 		}
 	}
 	# Now parse the message body
-	while(<F>) {
+	while(<$fh>) {
 		$message .=3D  $_;
 		if (/^(Signed-off-by|Cc): (.*)$/i) {
 			chomp;
@@ -1250,12 +1250,12 @@ foreach my $t (@files) {
 				$c, $_) unless $quiet;
 		}
 	}
-	close F;
+	close $fh;
=20
 	if (defined $cc_cmd && !$suppress_cc{'cccmd'}) {
-		open(F, "$cc_cmd \Q$t\E |")
+		open my $fh, "$cc_cmd \Q$t\E |"
 			or die "(cc-cmd) Could not execute '$cc_cmd'";
-		while(<F>) {
+		while(<$fh>) {
 			my $c =3D $_;
 			$c =3D~ s/^\s*//g;
 			$c =3D~ s/\n$//g;
@@ -1264,7 +1264,7 @@ foreach my $t (@files) {
 			printf("(cc-cmd) Adding cc: %s from: '%s'\n",
 				$c, $cc_cmd) unless $quiet;
 		}
-		close F
+		close $fh
 			or die "(cc-cmd) failed to close pipe to '$cc_cmd'";
 	}
=20
--=20
1.7.3.159.g610493
