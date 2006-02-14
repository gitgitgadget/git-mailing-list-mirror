From: Karl =?ISO-8859-1?Q?=20Hasselstr=F6m?= <kha@treskal.com>
Subject: [PATCH] git-svnimport: -r adds svn revision number to commit messages
Date: Tue, 14 Feb 2006 03:43:34 +0100
Message-ID: <24695.4271490269$1139885038@news.gmane.org>
Reply-To: Karl =?ISO-8859-1?Q?=20Hasselstr=F6m?= <kha@treskal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl =?ISO-8859-1?Q?=20Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 03:43:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8qAL-0003nN-0O
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 03:43:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWBNCnm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 13 Feb 2006 21:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWBNCnm
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 21:43:42 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:20386 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1750920AbWBNCnl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 21:43:41 -0500
Received: from backpacker.hemma.treskal.com ([83.227.180.148] [83.227.180.148])
          by mxfep02.bredband.com with ESMTP
          id <20060214024335.MFRQ2008.mxfep02.bredband.com@backpacker.hemma.treskal.com>;
          Tue, 14 Feb 2006 03:43:35 +0100
Received: from backpacker (localhost.localdomain [127.0.0.1])
	by backpacker.hemma.treskal.com (Postfix) with SMTP id 4452F19D3;
	Tue, 14 Feb 2006 03:43:35 +0100 (CET)
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16107>

New -r flag for prepending the corresponding Subversion revision
number to each commit message.

Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>


---

 Documentation/git-svnimport.txt |    4 ++++
 git-svnimport.perl              |    7 ++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

2aad1f8f976b8bb2cd6fd3b225199373008e14b4
diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svnimp=
ort.txt
index 63e28b8..5c543d5 100644
--- a/Documentation/git-svnimport.txt
+++ b/Documentation/git-svnimport.txt
@@ -61,6 +61,10 @@ When importing incrementally, you might=20
 	the git repository. Use this option if you want to import into a
 	different branch.
=20
+-r::
+	Prepend 'rX: ' to commit messages, where X is the imported
+	subversion revision.
+
 -m::
 	Attempt to detect merges based on the commit message. This option
 	will enable default regexes that try to capture the name source
diff --git a/git-svnimport.perl b/git-svnimport.perl
index f17d5a2..c536d70 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -30,19 +30,19 @@ die "Need SVN:Core 1.2.1 or better" if $
 $SIG{'PIPE'}=3D"IGNORE";
 $ENV{'TZ'}=3D"UTC";
=20
-our($opt_h,$opt_o,$opt_v,$opt_u,$opt_C,$opt_i,$opt_m,$opt_M,$opt_t,$op=
t_T,$opt_b,$opt_s,$opt_l,$opt_d,$opt_D);
+our($opt_h,$opt_o,$opt_v,$opt_u,$opt_C,$opt_i,$opt_m,$opt_M,$opt_t,$op=
t_T,$opt_b,$opt_r,$opt_s,$opt_l,$opt_d,$opt_D);
=20
 sub usage() {
 	print STDERR <<END;
 Usage: ${\basename $0}     # fetch/update GIT from SVN
        [-o branch-for-HEAD] [-h] [-v] [-l max_rev]
        [-C GIT_repository] [-t tagname] [-T trunkname] [-b branchname]
-       [-d|-D] [-i] [-u] [-s start_chg] [-m] [-M regex] [SVN_URL]
+       [-d|-D] [-i] [-u] [-r] [-s start_chg] [-m] [-M regex] [SVN_URL]
 END
 	exit(1);
 }
=20
-getopts("b:C:dDhil:mM:o:s:t:T:uv") or usage();
+getopts("b:C:dDhil:mM:o:rs:t:T:uv") or usage();
 usage if $opt_h;
=20
 my $tag_name =3D $opt_t || "tags";
@@ -650,6 +650,7 @@ sub commit {
 		$pr->reader();
=20
 		$message =3D~ s/[\s\n]+\z//;
+		$message =3D "r$revision: $message" if $opt_r;
=20
 		print $pw "$message\n"
 			or die "Error writing to git-commit-tree: $!\n";
--=20
1.2.0.g812d
