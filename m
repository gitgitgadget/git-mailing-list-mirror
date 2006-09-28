From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: Factor out gitweb_have_snapshot()
Date: Thu, 28 Sep 2006 16:49:21 -0700 (PDT)
Message-ID: <20060928234921.62443.qmail@web31808.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1344458973-1159487361=:61997"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Sep 29 01:49:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT5d7-0005Xs-Op
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 01:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbWI1XtW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 19:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWI1XtW
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 19:49:22 -0400
Received: from web31808.mail.mud.yahoo.com ([68.142.207.71]:23701 "HELO
	web31808.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964978AbWI1XtV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 19:49:21 -0400
Received: (qmail 62445 invoked by uid 60001); 28 Sep 2006 23:49:21 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=htGJDI08D9nBVE6AeByFyb0Xg+49plzXhXdRAZSck0D4RdQJBcFtJVjRocmbbmReQK/RgfMCNZR8EIGF0+Hwar8IyuSCR7pgzMC27V4Vz4ivvuiUMe9aMqFy/j0te2WYZsMy/Keuz75uuPGr/aOLhVFCVrXEC03eKRXjJjzTOJ0=  ;
Received: from [64.215.88.90] by web31808.mail.mud.yahoo.com via HTTP; Thu, 28 Sep 2006 16:49:21 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28070>

--0-1344458973-1159487361=:61997
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Create gitweb_have_snapshot() which returns true
of snapshot is available and enabled, else false.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

--0-1344458973-1159487361=:61997
Content-Type: text/plain; name="p3.txt"
Content-Description: 3222950043-p3.txt
Content-Disposition: inline; filename="p3.txt"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f3f22c2..a2f07cc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -155,6 +155,13 @@ sub feature_snapshot {
 	return ($ctype, $suffix, $command);
 }
 
+sub gitweb_have_snapshot {
+	my ($ctype, $suffix, $command) = gitweb_check_feature('snapshot');
+	my $have_snapshot = (defined $ctype && defined $suffix);
+
+	return $have_snapshot;
+}
+
 # To enable system wide have in $GITWEB_CONFIG
 # $feature{'pickaxe'}{'default'} = [1];
 # To have project specific config enable override in $GITWEB_CONFIG
@@ -2736,8 +2743,7 @@ sub git_blob {
 }
 
 sub git_tree {
-	my ($ctype, $suffix, $command) = gitweb_check_feature('snapshot');
-	my $have_snapshot = (defined $ctype && defined $suffix);
+	my $have_snapshot = gitweb_have_snapshot();
 
 	if (!defined $hash_base) {
 		$hash_base = "HEAD";
@@ -2813,7 +2819,6 @@ sub git_tree {
 }
 
 sub git_snapshot {
-
 	my ($ctype, $suffix, $command) = gitweb_check_feature('snapshot');
 	my $have_snapshot = (defined $ctype && defined $suffix);
 	if (!$have_snapshot) {
@@ -2923,8 +2928,7 @@ sub git_commit {
 	my $refs = git_get_references();
 	my $ref = format_ref_marker($refs, $co{'id'});
 
-	my ($ctype, $suffix, $command) = gitweb_check_feature('snapshot');
-	my $have_snapshot = (defined $ctype && defined $suffix);
+	my $have_snapshot = gitweb_have_snapshot();
 
 	my @views_nav = ();
 	if (defined $file_name && defined $co{'parent'}) {
-- 
1.4.2.1.g05f0f


--0-1344458973-1159487361=:61997--
