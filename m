From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 13/16] send-email: extract_valid_address use qr// regexes and /o
Date: Thu, 30 Sep 2010 13:43:06 +0000
Message-ID: <1285854189-10240-14-git-send-email-avarab@gmail.com>
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
X-From: git-owner@vger.kernel.org Thu Sep 30 15:44:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1JRG-0001Kp-Ig
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 15:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756087Ab0I3Noj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 09:44:39 -0400
Received: from mail-ww0-f48.google.com ([74.125.82.48]:55448 "EHLO
	mail-ww0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756078Ab0I3Noh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 09:44:37 -0400
Received: by mail-ww0-f48.google.com with SMTP id 22so762927wwb.5
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 06:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=1Otu1nmKLBbUGGsNEjakovAR4GKC5D38kcDcIh82jAM=;
        b=qLBowf7zZSOCUGGDIMbQI4UVduG0fivJHGVVlKmSfVMov26z9x59b/SXSn/bg1JkG/
         0RDkyaXbZ5mCX3s2/bXsC1ObZzce/cOhpp1a0VYRPfP/ASABessEuoSPZQBeQq47g5vk
         UPSUL1PTY1plhGB/6xYcW/X/0kcgnrz3cvx5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=N9qDEU03XYQgvhf0R2dzMhSnez5lp2bCGz5i9DuSFyolIWBeu+2XFQmRzcR1TSQ96T
         wLnpe0CMn0vzLPISD272yUXwOsnKyi6RGeHf2c3u/mG+oqbuOWhBiLgVFz7IOivOmQFf
         +OT/LYq/cEo93w8RS/1j0mwGrXH3w5UFoy/lQ=
Received: by 10.227.136.2 with SMTP id p2mr2893333wbt.215.1285854277003;
        Thu, 30 Sep 2010 06:44:37 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e56sm6328567wer.46.2010.09.30.06.44.35
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 06:44:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157661>

Change the regex fragment in extract_valid_address to use the qr//
syntax for compiled regexes, and when they're used add a /o flag so
they're only compiled once for the lifetime of the program.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-send-email.perl |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index b87c3f2..47d86ad 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -777,11 +777,11 @@ our ($message_id, %mail, $subject, $reply_to, $re=
ferences, $message,
=20
 sub extract_valid_address {
 	my $address =3D shift;
-	my $local_part_regexp =3D '[^<>"\s@]+';
-	my $domain_regexp =3D '[^.<>"\s@]+(?:\.[^.<>"\s@]+)+';
+	my $local_part_regexp =3D qr/[^<>"\s@]+/;
+	my $domain_regexp =3D qr/[^.<>"\s@]+(?:\.[^.<>"\s@]+)+/;
=20
 	# check for a local address:
-	return $address if ($address =3D~ /^($local_part_regexp)$/);
+	return $address if ($address =3D~ /^($local_part_regexp)$/o);
=20
 	$address =3D~ s/^\s*<(.*)>\s*$/$1/;
 	if ($have_email_valid) {
@@ -789,7 +789,7 @@ sub extract_valid_address {
 	} else {
 		# less robust/correct than the monster regexp in Email::Valid,
 		# but still does a 99% job, and one less dependency
-		$address =3D~ /($local_part_regexp\@$domain_regexp)/;
+		$address =3D~ /($local_part_regexp\@$domain_regexp)/o;
 		return $1;
 	}
 }
--=20
1.7.3.159.g610493
