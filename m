From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] difftool: add a -y shortcut for --no-prompt
Date: Tue, 24 Mar 2009 23:29:59 -0700
Message-ID: <1237962599-29625-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 25 07:30:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmMdX-0005QM-2B
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 07:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754591AbZCYG3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 02:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754525AbZCYG3V
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 02:29:21 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:32293 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446AbZCYG3U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 02:29:20 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2688268rvb.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 23:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=s/vWC9vVmuN7/eTwQP1hE2YmKtNv5ct9UkDQ1H1YVCs=;
        b=hy1aaa8giZq06UdkJYLEywOldbCtRRSu11o405erSjvkf+Pakc6DjiF6q83huZ/Vww
         p9uyfL1JzsAvzm68YmgPKl2pxXeeWOHEwNfoySCif292UtoQ/zwvrMzeu0QF/xuaLhS3
         MwLS2GMxZ9QbqmWmiuKA2Ov3Lr6oImNAMugT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=C/tug4N2hFHqUR1gAL++7DeKqI4lM5dJEMbm+qwpE3WprwLSv9DJERP1B/zCjV9wKo
         aeSP/ffOLo4duvIm+qw8bmqBXGlgEsV9HRKolZIEPZwZtB9dbaYaGa6SK1OjxmtWSYXG
         B/qKnvnZ7MR99u5huqXtU4PnvQVHjgRVxJhOQ=
Received: by 10.114.234.13 with SMTP id g13mr6243443wah.64.1237962557917;
        Tue, 24 Mar 2009 23:29:17 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id m17sm7213668waf.31.2009.03.24.23.29.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Mar 2009 23:29:17 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.303.g63699
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114569>

This is another consistency cleanup to make git-difftool's options
match git-mergetool.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

This also fixes the style used for the -h option which I should
have caught in my previous patch.  Doh!

 Documentation/git-difftool.txt |    3 ++-
 git-difftool.perl              |    6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 23070c1..be1020d 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -7,7 +7,7 @@ git-difftool - Show changes using common diff tools
 
 SYNOPSIS
 --------
-'git difftool' [--tool=<tool>] [--no-prompt] [<'git diff' options>]
+'git difftool' [--tool=<tool>] [-y|--no-prompt] [<'git diff' options>]
 
 DESCRIPTION
 -----------
@@ -17,6 +17,7 @@ to 'git-diff' and accepts the same options and arguments.
 
 OPTIONS
 -------
+-y::
 --no-prompt::
 	Do not prompt before launching a diff tool.
 
diff --git a/git-difftool.perl b/git-difftool.perl
index 207dd50..5bc64d5 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -18,7 +18,7 @@ my $DIR = abs_path(dirname($0));
 sub usage
 {
 	print << 'USAGE';
-usage: git difftool [--tool=<tool>] [--no-prompt] ["git diff" options]
+usage: git difftool [--tool=<tool>] [-y|--no-prompt] ["git diff" options]
 USAGE
 	exit 1;
 }
@@ -60,11 +60,11 @@ sub generate_command
 			$ENV{GIT_DIFF_TOOL} = substr($arg, 7);
 			next;
 		}
-		if ($arg eq '--no-prompt') {
+		if ($arg eq '-y' || '--no-prompt') {
 			$ENV{GIT_DIFFTOOL_NO_PROMPT} = 'true';
 			next;
 		}
-		if ($arg eq '-h' or $arg eq '--help') {
+		if ($arg eq '-h' || $arg eq '--help') {
 			usage();
 		}
 		push @command, $arg;
-- 
1.6.2.1.303.g63699
