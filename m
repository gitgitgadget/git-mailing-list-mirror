From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 2/9] difftool: exit(0) when usage is printed
Date: Fri, 16 Mar 2012 21:57:15 -0400
Message-ID: <1331949442-15039-3-git-send-email-tim.henigan@gmail.com>
References: <1331949442-15039-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, davvid@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 02:58:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8iuS-0005eo-56
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 02:58:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032984Ab2CQB6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 21:58:10 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51068 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032978Ab2CQB6B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 21:58:01 -0400
Received: by mail-iy0-f174.google.com with SMTP id z16so6233121iag.19
        for <git@vger.kernel.org>; Fri, 16 Mar 2012 18:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5QIEgZd05kU5TtidBKWEGlhkg8YYeh59cTo/DZ6EtQk=;
        b=F7ARQli6bN5rMKmdfutnWCdBn1+JGHkwSQy7NX65HIA39OIHnXSFTmhiJPQzj2XOmm
         lWiJzO9CAroQXv+t7LNWRlHDa5jpEs8+ZE0Y39u5YI59YUFHECpFKzIouh6uydSH8qPY
         Br4Wa5aSCOKY2zrh+X7v2AnMyWQqt3uxl9ogM4qfILTFCJClywhcHLf8LxRCIljHVjl6
         zM3pdviVOxdpDa0p7n/mZ6q+iCrhSIL0SdUG+V2tTqNWXT9hHslcrdVNMZRcg5N7erWh
         V+Adqnwd46EuxWi5aCa84CUi+bPu88i1wU51S2obQWRdaY1HTOMlt7ew9m+wv8nGqHrM
         h5fw==
Received: by 10.50.190.226 with SMTP id gt2mr994698igc.32.1331949480811;
        Fri, 16 Mar 2012 18:58:00 -0700 (PDT)
Received: from localhost ([75.38.216.51])
        by mx.google.com with ESMTPS id cv10sm1217915igc.13.2012.03.16.18.57.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Mar 2012 18:58:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.1.290.gbd444
In-Reply-To: <1331949442-15039-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193290>

Prior to this commit, the script exited with an error whenever the
usage string was printed, regardless of the reason it was done. In
cases where usage was printed due to a user request (e.g. '-h'
option), the script should exit without error (exit 0).

This commit adds an argument to the usage function that allows the
exit code to be specified when the function is called.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---
 git-difftool.perl |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index e365727..81ecf34 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -20,12 +20,13 @@ use Git;
 
 sub usage
 {
+	my $exitcode = shift;
 	print << 'USAGE';
 usage: git difftool [-t|--tool=<tool>] [-x|--extcmd=<cmd>]
                     [-y|--no-prompt]   [-g|--gui]
                     ['git diff' options]
 USAGE
-	exit 1;
+	exit($exitcode);
 }
 
 sub setup_environment
@@ -56,14 +57,14 @@ GetOptions('g|gui' => \$gui,
 	'y|no-prompt' => \$no_prompt);
 
 if (defined($help)) {
-	usage();
+	usage(0);
 } 
 if (defined($difftool_cmd)) {
 	if (length($difftool_cmd) > 0) {
 		$ENV{GIT_DIFF_TOOL} = $difftool_cmd;
 	} else {
 		print "No <tool> given for --tool=<tool>\n";
-		usage();
+		usage(1);
 	}
 }
 if (defined($extcmd)) {
@@ -71,7 +72,7 @@ if (defined($extcmd)) {
 		$ENV{GIT_DIFFTOOL_EXTCMD} = $extcmd;
 	} else {
 		print "No <cmd> given for --extcmd=<cmd>\n";
-		usage();
+		usage(1);
 	}
 }
 if (defined($gui)) {
-- 
1.7.9.1.290.gbd444
