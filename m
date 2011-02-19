From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] gitweb/gitweb.perl: remove use of qw(...) as parentheses
Date: Sat, 19 Feb 2011 14:10:54 +0000
Message-ID: <1298124654-12051-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 15:11:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqnWo-0001Bv-HL
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 15:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628Ab1BSOLN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 09:11:13 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38734 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754368Ab1BSOLM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 09:11:12 -0500
Received: by eye27 with SMTP id 27so2286758eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 06:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=yxWGNPj0uP6nVgu7lbIP9PjdXc6pzsfPNpnbEosvAb8=;
        b=xfCbb440WEj4xzRsuQfLUc6kTEAYKKPHakdSe18BJYSmQHymp6+D3dbFMhnXod4jTk
         SG9y4rULmgQKhU1e9AUYrv3ii8qIVcuYHqhherqd6TE454DPzL4fij75s4z5zuT/qem3
         KGcpMjY3Wi5cwF5OSn+UXGHew1o8sKdr2Lj64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=bYLa3chiZyN40j8jPQGeKzUi8ojMADIgmIXGVnKG5jrd/F7LYhRcSim6cURzeOBJkV
         rWORpFxhxX7tQG/zh7VP+elF6g61Tq3sGQXwREpXCTyOkbOZLT98Ni7RwA9zD4uYdO3Z
         J3EFB/L1SFIh1qy3QHsaaktvU0MLVTueu/Y+o=
Received: by 10.213.27.204 with SMTP id j12mr1673662ebc.85.1298124671562;
        Sat, 19 Feb 2011 06:11:11 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id t5sm2944287eeh.8.2011.02.19.06.11.10
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 06:11:10 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167283>

Using the qw(...) construct as implicit parentheses was deprecated in
perl 5.13.5. Change the relevant code in gitweb to not use the
deprecated construct. The offending code was introduced in 3562198b by
Jakub Narebski.

The issue is that perl will now warn about this:

    $ perl -wE 'for my $i qw(a b) { say $i }'
    Use of qw(...) as parentheses is deprecated at -e line 1.
    a
    b

This caused gitweb.perl to warn on perl 5.13.5 and above, and these
tests to fail on those perl versions:

    ./t9501-gitweb-standalone-http-status.sh           (Wstat: 256 Test=
s: 11 Failed: 10)
      Failed tests:  2-11
      Non-zero exit status: 1
    ./t9502-gitweb-standalone-parse-output.sh          (Wstat: 256 Test=
s: 10 Failed: 9)
      Failed tests:  2-10
      Non-zero exit status: 1
    ./t9500-gitweb-standalone-no-errors.sh             (Wstat: 256 Test=
s: 90 Failed: 84)
      Failed tests:  1-8, 10-36, 38-45, 47-48, 50-88
      Non-zero exit status: 1

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0779f12..b02372c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3501,7 +3501,7 @@ sub print_feed_meta {
 			$href_params{'-title'} =3D 'log';
 		}
=20
-		foreach my $format qw(RSS Atom) {
+		foreach my $format (qw(RSS Atom)) {
 			my $type =3D lc($format);
 			my %link_attr =3D (
 				'-rel' =3D> 'alternate',
@@ -3682,7 +3682,7 @@ sub git_footer_html {
 		}
 		$href_params{'-title'} ||=3D 'log';
=20
-		foreach my $format qw(RSS Atom) {
+		foreach my $format (qw(RSS Atom)) {
 			$href_params{'action'} =3D lc($format);
 			print $cgi->a({-href =3D> href(%href_params),
 			              -title =3D> "$href_params{'-title'} $format feed",
--=20
1.7.2.3
