From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 4/9] difftool: stop appending '.exe' to git
Date: Fri, 16 Mar 2012 21:57:17 -0400
Message-ID: <1331949442-15039-5-git-send-email-tim.henigan@gmail.com>
References: <1331949442-15039-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, davvid@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 02:58:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8iua-0005no-Uu
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 02:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032987Ab2CQB6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 21:58:19 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51068 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030239Ab2CQB6K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 21:58:10 -0400
Received: by mail-iy0-f174.google.com with SMTP id z16so6233121iag.19
        for <git@vger.kernel.org>; Fri, 16 Mar 2012 18:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ta/QwCUdJGPAFZ/+F3rVPwb3J2LmTjEDZHnMq/HaNTo=;
        b=Hb9ToTI/hzzVZ/jYiO89wBOsrGIvEokuYn5wS5B68rh3TzEkgLdyXQQuRrzIjft7DH
         y5C5Ra+nc2GdEvXsd7bu1npQeVHJqb5ITzz+bHQzNxUb9wnjwXIGHTRP9d0kJSi7utiD
         dmlxhcv7FD50j3OiISfO2USxeKb5RqY974/vmyluoUMef6I16pzvhNlsoBSelKPmX+EJ
         hecxpy2gKLgyaFOetYxZDgffdRcqD2awHveKxJ/f3U7R0fkFC1+VBAKhLVmtbeGzD4eg
         Neamj4DQGnA9NFNdM8eF2ioTDoj3ig/gvXiUEio9aHE7eD5Pdo30VZpYzpxAyl8uw50X
         zsSQ==
Received: by 10.50.85.232 with SMTP id k8mr1029214igz.16.1331949489968;
        Fri, 16 Mar 2012 18:58:09 -0700 (PDT)
Received: from localhost ([75.38.216.51])
        by mx.google.com with ESMTPS id vr4sm5247384igb.1.2012.03.16.18.58.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Mar 2012 18:58:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.1.290.gbd444
In-Reply-To: <1331949442-15039-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193293>

The system call to Git works the same whether or not ".exe" is
appended to "git". The extra code is not necessary.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---
 git-difftool.perl |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 53fcd7e..99ff587 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -33,15 +33,6 @@ sub setup_environment
 	$ENV{GIT_EXTERNAL_DIFF} = 'git-difftool--helper';
 }
 
-sub exe
-{
-	my $exe = shift;
-	if ($^O eq 'MSWin32' || $^O eq 'msys') {
-		return "$exe.exe";
-	}
-	return $exe;
-}
-
 # parse command-line options. all unrecognized options and arguments
 # are passed through to the 'git diff' command.
 my ($difftool_cmd, $extcmd, $gui, $help, $no_prompt, $prompt);
@@ -86,7 +77,7 @@ elsif (defined($no_prompt)) {
 }
 
 setup_environment();
-my @command = (exe('git'), 'diff', @ARGV);
+my @command = ('git', 'diff', @ARGV);
 
 # ActiveState Perl for Win32 does not implement POSIX semantics of
 # exec* system call. It just spawns the given executable and finishes
-- 
1.7.9.1.290.gbd444
