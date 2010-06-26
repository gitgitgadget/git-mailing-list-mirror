From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2] t9700: Use Test::More->builder, not $Test::Builder::Test
Date: Sat, 26 Jun 2010 12:42:41 +0000
Message-ID: <1277556161-8718-1-git-send-email-avarab@gmail.com>
References: <1277554872-6402-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 26 14:43:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSUj6-0007q4-Vl
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 14:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755108Ab0FZMnG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jun 2010 08:43:06 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:37769 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754618Ab0FZMnF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 08:43:05 -0400
Received: by wwi17 with SMTP id 17so1636033wwi.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 05:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ZxxstK3Ud/29jBe1BVnSVQytmytEoc9T1taho+cqTKk=;
        b=Q9NGsFZIUTi6T+YtpLGGC+SI16Ywi5pwpcfiE3Royku592CvPcd2kJfgUo4thRD8wS
         v5Pi1njZng960RTHxDqdJR/z3TG8iMeRvRz2y/KKu+JRLDKHXztAPAclUqxDZJQgS5Bm
         3pKBSoUvmbK30wxT5qvGiy+ItqTfYuXt+hZa8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=FBneufRD/Pp1AyVMEGpIF28Bn4O5J+VbalN7ek/E5bUDeaqJI4iucuJbmGez63vfrF
         eEAr2rqfmMie/eZc0GMKMQGjoIFUMktrrMHTstJKJHukTwaTNuc1/mrdZr/OPzv/j8tY
         JCsHaLysb5x0pr9BMIKNNS05INIYkGiNHeGfg=
Received: by 10.216.87.4 with SMTP id x4mr1600928wee.86.1277556183462;
        Sat, 26 Jun 2010 05:43:03 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id g17sm2301108wee.5.2010.06.26.05.43.01
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 26 Jun 2010 05:43:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1277554872-6402-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149741>

$Test::Builder::Test was only made into an `our' variable in 0.94
released in September 2009, older distros are more likely to have 0.92
or earlier. Use the singleton Test::More->builder constructor instead.

The exit() call was also unportable to <0.94. Just output a meaningful
exit code if the ->is_passing method exists. The t9700-perl-git.sh
test only cares about stderr output, so this doesn't affect test
results when using older Test::More modules.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

The previous patch didn't take into account that the exit() call was
also unportable. Oops.

 t/t9700/test.pl |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index e5d4b03..f2820d2 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -10,8 +10,8 @@ use Test::More qw(no_plan);
 BEGIN {
 	# t9700-perl-git.sh kicks off our testing, so we have to go from
 	# there.
-	$Test::Builder::Test->{Curr_Test} =3D 1;
-	$Test::Builder::Test->{No_Ending} =3D 1;
+	Test::More->builder->{Curr_Test} =3D 1;
+	Test::More->builder->{No_Ending} =3D 1;
 }
=20
 use Cwd;
@@ -113,6 +113,7 @@ like($last_commit, qr/^[0-9a-fA-F]{40}$/, 'rev-pars=
e returned hash');
 my $dir_commit =3D $r2->command_oneline('log', '-n1', '--pretty=3Dform=
at:%H', '.');
 isnt($last_commit, $dir_commit, 'log . does not show last commit');
=20
-printf "1..%d\n", $Test::Builder::Test->{Curr_Test};
+printf "1..%d\n", Test::More->builder->{Curr_Test};
=20
-exit($Test::Builder::Test->{Is_Passing} ? 0 : 1);
+my $is_passing =3D eval { Test::More->is_passing };
+exit($is_passing ? 0 : 1) unless $@ =3D~ /Can't locate object method/;
--=20
1.7.1.251.g92a7
