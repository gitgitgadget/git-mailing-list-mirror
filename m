From: Ingmar Vanhassel <ingmar@exherbo.org>
Subject: [PATCH] import-tars: Add support for tarballs compressed with lzma, xz
Date: Tue, 20 Oct 2009 10:59:37 +0200
Message-ID: <1256029177-22503-1-git-send-email-ingmar@exherbo.org>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	Junio C Hamano <gitster@pobox.com>,
	Ingmar Vanhassel <ingmar@exherbo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 20 10:59:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0AZM-0002hD-AQ
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 10:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbZJTI7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 04:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbZJTI7m
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 04:59:42 -0400
Received: from bach.exherbo.org ([78.47.197.147]:42662 "EHLO bach.exherbo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335AbZJTI7m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 04:59:42 -0400
Received: from [83.101.72.69] (helo=localhost)
	by bach.exherbo.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <ingmar@exherbo.org>)
	id 1N0AZE-0002Ey-71; Tue, 20 Oct 2009 08:59:44 +0000
X-Mailer: git-send-email 1.6.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130776>

Signed-off-by: Ingmar Vanhassel <ingmar@exherbo.org>
---
 contrib/fast-import/import-tars.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
index 7001862..95438e1 100755
--- a/contrib/fast-import/import-tars.perl
+++ b/contrib/fast-import/import-tars.perl
@@ -20,7 +20,7 @@ use Getopt::Long;
 
 my $metaext = '';
 
-die "usage: import-tars [--metainfo=extension] *.tar.{gz,bz2,Z}\n"
+die "usage: import-tars [--metainfo=extension] *.tar.{gz,bz2,lzma,xz,Z}\n"
 	unless GetOptions('metainfo=s' => \$metaext) && @ARGV;
 
 my $branch_name = 'import-tars';
@@ -49,6 +49,9 @@ foreach my $tar_file (@ARGV)
 	} elsif ($tar_name =~ s/\.tar\.Z$//) {
 		open(I, '-|', 'uncompress', '-c', $tar_file)
 			or die "Unable to uncompress -c $tar_file: $!\n";
+	} elsif ($tar_name =~ s/\.(tar\.(lzma|xz)|(tlz|txz))$//) {
+		open(I, '-|', 'xz', '-dc', $tar_file)
+			or die "Unable to xz -dc $tar_file: $!\n";
 	} elsif ($tar_name =~ s/\.tar$//) {
 		open(I, $tar_file) or die "Unable to open $tar_file: $!\n";
 	} else {
-- 
1.6.5.1
