From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 5/9 v6] difftool: stop appending '.exe' to git
Date: Thu, 22 Mar 2012 15:52:20 -0400
Message-ID: <1332445944-10944-6-git-send-email-tim.henigan@gmail.com>
References: <1332445944-10944-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 22 20:53:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAo4o-0005TY-Q5
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 20:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088Ab2CVTxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 15:53:34 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:35572 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755696Ab2CVTxd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 15:53:33 -0400
Received: by mail-qa0-f46.google.com with SMTP id b19so544975qae.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 12:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Jr80fcA1X7w9PbtlCeT2sUckkfAiLZvDPeZhjW8+6Ig=;
        b=YbjSCwufkr/uZHEu1rX5QJI3Bjb2lDukZX4G5y8kIoRRX1PA6hoqsnR3szFuUIWBKu
         r+WN0mGrz6VtNm6LHNKk0jDaC7NiJDS5kTCwjKYfAALmF36oUZfzOgqBsC5SumXEbVCR
         nlt/1fsHHLA5PoDJUlWp4W6PglI54HTZ0ROFeUhCIO+WeVdVqMcfShUrqwOL29R12gcF
         25aR00+aXRTQrcV+dHRZ3vFDMhtArXpyzaTsAXQ91u6ANnv1UUdrp3RwQcJrHalMYbi3
         tHhOVLS/0YnYdoW9OSvSOen7RTGTtAVUzPTbATbAdm7zkUY0YKzhmzDz/ABA0CF36UpO
         zSJw==
Received: by 10.229.136.203 with SMTP id s11mr3581164qct.106.1332446012836;
        Thu, 22 Mar 2012 12:53:32 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id ha10sm9992234qab.14.2012.03.22.12.53.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 12:53:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc1.36.g15e879
In-Reply-To: <1332445944-10944-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193704>

The system call to Git works the same whether or not ".exe" is
appended to "git". The extra code is not necessary.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---
 git-difftool.perl |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 77c9907..493260d 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -35,15 +35,6 @@ sub setup_environment
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
 my ($difftool_cmd, $extcmd, $gui, $help, $prompt);
@@ -89,7 +80,7 @@ if (defined($prompt)) {
 }
 
 setup_environment();
-my @command = (exe('git'), 'diff', @ARGV);
+my @command = ('git', 'diff', @ARGV);
 
 # ActiveState Perl for Win32 does not implement POSIX semantics of
 # exec* system call. It just spawns the given executable and finishes
-- 
1.7.10.rc1.36.g15e879
