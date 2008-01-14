From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH] cvsimport: remove last use of repo-config from git standard tools
Date: Sun, 13 Jan 2008 22:51:10 -0600
Message-ID: <1200286270-12236-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 05:51:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEHIc-0001ja-Fc
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 05:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbYANEvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 23:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbYANEvP
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 23:51:15 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:65454 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbYANEvO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 23:51:14 -0500
Received: by an-out-0708.google.com with SMTP id d31so414315and.103
        for <git@vger.kernel.org>; Sun, 13 Jan 2008 20:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=/4BNwDBF2CzEyfclegnmoVEQRljIAaIIobyGLfv65gw=;
        b=aPjiq0WE0RMfRj8CyVHRdSVAQGhppI0Jfv2wYJbwIpHxrmWusu+qB6GCGb5VcIJEMHTEKYXLNTZ0PXsqRqyodYYQNNh5ZWbJEOpP9VwGouKdu+cbDLSYuDXOZx8XnqS6aX0rT4tIUruREOIPdZgeTeWcZTSKlBFN48uOCMhLDK4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ImMkPGbrKxZRdhbTyTGDrWCOe5f9XT/YfeY/0f4UOHR5R3DQpgC8SWiFrlapSC+/QjxCgpvATiVE49JDQKyOfbT8aLliONrSeJWcY9Uh50GIpH0Y673m+Izv2J2QvNsFcgSpnEgkMtEC8ycv+jUEcr1EOWo0TFRnB2He85TvaU8=
Received: by 10.100.34.16 with SMTP id h16mr13111866anh.114.1200286273372;
        Sun, 13 Jan 2008 20:51:13 -0800 (PST)
Received: from localhost ( [76.197.238.51])
        by mx.google.com with ESMTPS id 36sm5149941nzk.29.2008.01.13.20.51.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Jan 2008 20:51:12 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70439>

git cvsimport was the last tool to use repo-config instead of config. Update
it to use plain git config.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 git-cvsimport.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 6d8ff93..5694978 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -88,7 +88,7 @@ sub write_author_info($) {
 	close ($f);
 }
 
-# convert getopts specs for use by git-repo-config
+# convert getopts specs for use by git config
 sub read_repo_config {
     # Split the string between characters, unless there is a ':'
     # So "abc:de" becomes ["a", "b", "c:", "d", "e"]
@@ -96,7 +96,7 @@ sub read_repo_config {
 	foreach my $o (@opts) {
 		my $key = $o;
 		$key =~ s/://g;
-		my $arg = 'git-repo-config';
+		my $arg = 'git config';
 		$arg .= ' --bool' if ($o !~ /:$/);
 
         chomp(my $tmp = `$arg --get cvsimport.$key`);
@@ -116,7 +116,7 @@ getopts($opts) or usage();
 usage if $opt_h;
 
 if (@ARGV == 0) {
-		chomp(my $module = `git-repo-config --get cvsimport.module`);
+		chomp(my $module = `git config --get cvsimport.module`);
 		push(@ARGV, $module) if $? == 0;
 }
 @ARGV <= 1 or usage("You can't specify more than one CVS module");
-- 
1.5.4.rc3
