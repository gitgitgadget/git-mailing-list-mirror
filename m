From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 4/9 v2] difftool: stop appending '.exe' to git
Date: Sat, 17 Mar 2012 21:55:29 -0400
Message-ID: <1332035734-5443-5-git-send-email-tim.henigan@gmail.com>
References: <1331949442-15039-1-git-send-email-tim.henigan@gmail.com>
 <1332035734-5443-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, davvid@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 02:56:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S95MX-0004Hw-64
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 02:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757291Ab2CRB4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 21:56:36 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55335 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757045Ab2CRB4O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 21:56:14 -0400
Received: by mail-iy0-f174.google.com with SMTP id z16so7559135iag.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 18:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ta/QwCUdJGPAFZ/+F3rVPwb3J2LmTjEDZHnMq/HaNTo=;
        b=avzImaIbvtBmF0jepw8jTogSX0cgjcKBNNOLGc7vRDubbvvVH9SrB6ovpnCR4GdZom
         diUW3TZdXzgZD34mXl1nJgr7NJuiHvGDatAInCX+iHEvFPJWRGxuhczVvZxSQTNxbGge
         RHScL9c7lCNJJ1C/6SQ+Hxn+2wTSSRFIV2EhFNrb5cRe+LKYqfoXYYIUObJbusKautZ2
         ZyU+0VgCDBnipJ6X930wy4OLpTngyM6A4RvG0NQIQgkrNfpSJNoYhvwBoj2FRx4iEnyw
         DeN0gyl8Cr2R1di1KJr3hIF8HpZwcy0IhaROwfIsl+02XqSzLSwqFAOqTKb9YkZiqNqB
         w7mQ==
Received: by 10.50.160.196 with SMTP id xm4mr2943207igb.24.1332035774021;
        Sat, 17 Mar 2012 18:56:14 -0700 (PDT)
Received: from localhost ([75.38.216.51])
        by mx.google.com with ESMTPS id b11sm4303117igq.7.2012.03.17.18.56.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Mar 2012 18:56:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.1.290.gbd444
In-Reply-To: <1332035734-5443-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193357>

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
