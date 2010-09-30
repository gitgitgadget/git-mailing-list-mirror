From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 02/16] send-email: use lexical filehandles for $compose
Date: Thu, 30 Sep 2010 13:42:55 +0000
Message-ID: <1285854189-10240-3-git-send-email-avarab@gmail.com>
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
	id 1P1JQJ-0000ri-0t
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 15:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756041Ab0I3Nnf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 09:43:35 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55464 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656Ab0I3Nne (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 09:43:34 -0400
Received: by mail-ww0-f44.google.com with SMTP id 15so389309wwe.1
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 06:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=K/KN1taqPBmxpCP96sThMGzPFavwb7v24fQ3rQG2VSo=;
        b=r8ALWeipdrOwRAsdZ7YG8W6PkLbLVqPCb60Okk3NWK2iKSeEBmHjUr7pw57rH7JIMD
         +/WdfNKfAF8hjRESYHGZZLrVJAp2y+smrndwXtYioWpmCmaEe+ofHUSmZL5ahM2+Ngqn
         Gr3CwUd9cyCTsyW4Fu8z93gtNEn5imfix/7PU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=TgIzY0KeJNa3elvEKm6zWwbcfl14JatsgFcXKH0IOvIQFx4JfqzYf91swLEswIQ83Y
         9NdwDD0sKcv8IV1pER6bI4r8NMRqDCwPJZbnIzyTVp2mJspGCtY1TNvCPtmP8Nrxn6v2
         n2KM4eOsy1lzoGvBNshU9LiaqC6J+Vq1r6jR0=
Received: by 10.227.137.193 with SMTP id x1mr3195965wbt.80.1285854213373;
        Thu, 30 Sep 2010 06:43:33 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e56sm6328567wer.46.2010.09.30.06.43.31
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 06:43:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157653>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-send-email.perl |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 2f18d83..634835c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -567,7 +567,7 @@ if ($compose) {
 	$compose_filename =3D ($repo ?
 		tempfile(".gitsendemail.msg.XXXXXX", DIR =3D> $repo->repo_path()) :
 		tempfile(".gitsendemail.msg.XXXXXX", DIR =3D> "."))[1];
-	open(C,">",$compose_filename)
+	open my $c, ">", $compose_filename
 		or die "Failed to open for writing $compose_filename: $!";
=20
=20
@@ -575,7 +575,7 @@ if ($compose) {
 	my $tpl_subject =3D $initial_subject || '';
 	my $tpl_reply_to =3D $initial_reply_to || '';
=20
-	print C <<EOT;
+	print $c <<EOT;
 From $tpl_sender # This line is ignored.
 GIT: Lines beginning in "GIT:" will be removed.
 GIT: Consider including an overall diffstat or table of contents
@@ -588,9 +588,9 @@ In-Reply-To: $tpl_reply_to
=20
 EOT
 	for my $f (@files) {
-		print C get_patch_subject($f);
+		print $c get_patch_subject($f);
 	}
-	close(C);
+	close $c;
=20
 	if ($annotate) {
 		do_edit($compose_filename, @files);
@@ -598,23 +598,23 @@ EOT
 		do_edit($compose_filename);
 	}
=20
-	open(C2,">",$compose_filename . ".final")
+	open my $c2, ">", $compose_filename . ".final"
 		or die "Failed to open $compose_filename.final : " . $!;
=20
-	open(C,"<",$compose_filename)
+	open $c, "<", $compose_filename
 		or die "Failed to open $compose_filename : " . $!;
=20
 	my $need_8bit_cte =3D file_has_nonascii($compose_filename);
 	my $in_body =3D 0;
 	my $summary_empty =3D 1;
-	while(<C>) {
+	while(<$c>) {
 		next if m/^GIT:/;
 		if ($in_body) {
 			$summary_empty =3D 0 unless (/^\n$/);
 		} elsif (/^\n$/) {
 			$in_body =3D 1;
 			if ($need_8bit_cte) {
-				print C2 "MIME-Version: 1.0\n",
+				print $c2 "MIME-Version: 1.0\n",
 					 "Content-Type: text/plain; ",
 					   "charset=3DUTF-8\n",
 					 "Content-Transfer-Encoding: 8bit\n";
@@ -639,10 +639,10 @@ EOT
 			print "To/Cc/Bcc fields are not interpreted yet, they have been ign=
ored\n";
 			next;
 		}
-		print C2 $_;
+		print $c2 $_;
 	}
-	close(C);
-	close(C2);
+	close $c;
+	close $c2;
=20
 	if ($summary_empty) {
 		print "Summary email is empty, skipping it\n";
--=20
1.7.3.159.g610493
