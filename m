From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 01/16] send-email: use lexical filehandle for opendir
Date: Thu, 30 Sep 2010 13:42:54 +0000
Message-ID: <1285854189-10240-2-git-send-email-avarab@gmail.com>
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
X-From: git-owner@vger.kernel.org Thu Sep 30 15:43:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1JQI-0000ri-12
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 15:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756031Ab0I3Nn0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 09:43:26 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55464 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656Ab0I3Nn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 09:43:26 -0400
Received: by wwe15 with SMTP id 15so389309wwe.1
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 06:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=8jN4CGfuhB1G3eq7VUw0g4Ijwt3p4wfn8Pokf/HmgPM=;
        b=c3DB+Ox9CFPceIfpZ11wE06u77yiwe0xhl8sFDt8mbfGnygi/UyWnE+ZF4JAkrTF7n
         tLKP0BXrMrOMNFL9wD2z4EcenLtAeUYQxqr9cNg2fSnjfZExvpJu01DMho+41Dhu4gCc
         wBHEf4Q9x0Yt4kVQ2qladSnLckTEMSkQBlOwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=hqN8q/tBk0M8n0E8zU9Mxsz0dkzjn44Sz23taf4ZPr+EZgjDmhguFZa5xdGdjpCF4C
         FOutVFhxSsMasf+ycUftQRad5vONhErfRmVRb1yy0PJSSvCDUGgWRMS77PkV85cZUVqE
         hXu4yjpKfD6X7gmZ1t4N++eF076KKOObCvDKI=
Received: by 10.227.68.207 with SMTP id w15mr3242928wbi.75.1285854204642;
        Thu, 30 Sep 2010 06:43:24 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e56sm6328567wer.46.2010.09.30.06.43.23
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 06:43:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157652>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-send-email.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 8cc4161..2f18d83 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -512,12 +512,12 @@ while (defined(my $f =3D shift @ARGV)) {
 		push @rev_list_opts, "--", @ARGV;
 		@ARGV =3D ();
 	} elsif (-d $f and !check_file_rev_conflict($f)) {
-		opendir(DH,$f)
+		opendir my $dh, $f
 			or die "Failed to opendir $f: $!";
=20
 		push @files, grep { -f $_ } map { catfile($f, $_) }
-				sort readdir(DH);
-		closedir(DH);
+				sort readdir $dh;
+		closedir $dh;
 	} elsif ((-f $f or -p $f) and !check_file_rev_conflict($f)) {
 		push @files, $f;
 	} else {
--=20
1.7.3.159.g610493
