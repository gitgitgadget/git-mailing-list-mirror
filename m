From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: [PATCH] gitweb: Fix git_blame
Date: Fri, 01 Sep 2006 09:13:32 +0530
Message-ID: <ed8a90$pfn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010904040808080706000307"
X-From: git-owner@vger.kernel.org Fri Sep 01 05:44:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIzx2-00023p-MP
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 05:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWIADoH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 23:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWIADoG
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 23:44:06 -0400
Received: from main.gmane.org ([80.91.229.2]:2225 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751094AbWIADn7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Aug 2006 23:43:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GIzwY-0001xX-KC
	for git@vger.kernel.org; Fri, 01 Sep 2006 05:43:46 +0200
Received: from palrel1.hp.com ([156.153.255.242])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Sep 2006 05:43:46 +0200
Received: from aneesh.kumar by palrel1.hp.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Sep 2006 05:43:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: palrel1.hp.com
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26294>

This is a multi-part message in MIME format.
--------------010904040808080706000307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------010904040808080706000307
Content-Type: text/plain;
 name="0001-gitweb-Fix-git_blame.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-gitweb-Fix-git_blame.txt"


Converting the default values to array broke the git blame enable
disable support. Fix the same.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
---
 gitweb/gitweb.perl |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0984e85..57ffa25 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2251,7 +2251,8 @@ sub git_blame2 {
 	my $fd;
 	my $ftype;
 
-	if (!gitweb_check_feature('blame')) {
+	my ($have_blame) = gitweb_check_feature('blame');
+	if (!$have_blame) {
 		die_error('403 Permission denied', "Permission denied");
 	}
 	die_error('404 Not Found', "File name not defined") if (!$file_name);
@@ -2320,7 +2321,8 @@ HTML
 sub git_blame {
 	my $fd;
 
-	if (!gitweb_check_feature('blame')) {
+	my ($have_blame) = gitweb_check_feature('blame');
+	if (!$have_blame) {
 		die_error('403 Permission denied', "Permission denied");
 	}
 	die_error('404 Not Found', "File name not defined") if (!$file_name);
@@ -2494,7 +2496,7 @@ sub git_blob {
 			die_error(undef, "No file name defined");
 		}
 	}
-	my $have_blame = gitweb_check_feature('blame');
+	my ($have_blame) = gitweb_check_feature('blame');
 	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
 		or die_error(undef, "Couldn't cat $file_name, $hash");
 	my $mimetype = blob_mimetype($fd, $file_name);
@@ -2570,7 +2572,7 @@ sub git_tree {
 	my $ref = format_ref_marker($refs, $hash_base);
 	git_header_html();
 	my $base = "";
-	my $have_blame = gitweb_check_feature('blame');
+	my ($have_blame) = gitweb_check_feature('blame');
 	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
 		git_print_page_nav('tree','', $hash_base);
 		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash_base);
-- 
1.4.2.rc1.g83e1-dirty


--------------010904040808080706000307--
