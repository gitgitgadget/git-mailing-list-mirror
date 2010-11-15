From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] git-gui: support for underline styles
Date: Mon, 15 Nov 2010 11:04:58 +0100
Message-ID: <1289815498-12287-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	"Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Nov 15 11:05:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHvw2-0008Hk-FF
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 11:05:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755290Ab0KOKFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 05:05:05 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56216 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755052Ab0KOKFD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 05:05:03 -0500
Received: by bwz15 with SMTP id 15so5019881bwz.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 02:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=PchvpvXaRw6Kd0HYW/B7RHhehfFvDX99qq9lx2MNErs=;
        b=tEZEXs9H+B29fJcbRhR/ru/kIeEErc/z8oxFZeMoMtOOkAMKTVcyczCxW0fuanGoTb
         6msqXfBT8ptFeEkVzrJqXfx/GbcYQw84QPEVLU+5tO3ysNLJDHiQw1XbvWQL628sHqc1
         YVceSxoEKB5d03eEfBGSfDHVqYzttEGNDhW1M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=VxJcYrU46P8VsrGVd050B+JcTrphfGy/y6jtizH0kMKLFwHhiTYD6eDoFuYjAEegSU
         AcBdeXSqpg2XbQCL5UJUxeljDQQMBjHSY4v4xMdfkRWDDBeyCrX9qF3xQLC0SHw2qCXi
         owT5LNmvqmiTp+xQLbuF/yyPs8vEnowgzrkaw=
Received: by 10.204.62.203 with SMTP id y11mr5734392bkh.11.1289815501655;
        Mon, 15 Nov 2010 02:05:01 -0800 (PST)
Received: from localhost (p3E99037B.dip.t-dialin.net [62.153.3.123])
        by mx.google.com with ESMTPS id d12sm2928252bkw.7.2010.11.15.02.04.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 02:05:00 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.1149.g1f51c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161474>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 git-gui/git-gui.sh   |    4 ++++
 git-gui/lib/diff.tcl |    3 ++-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index d3acf0d..70c0483 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -3328,6 +3328,10 @@ foreach {n c} {0 black 1 red4 2 green4 3 yellow4 4 blue4 5 magenta4 6 cyan4 7 gr
 	$ui_diff tag configure clri4$n -foreground $c
 	$ui_diff tag configure clr3$n -foreground $c
 	$ui_diff tag configure clri3$n -background $c
+	$ui_diff tag configure clru4$n -underline 1 -background $c
+	$ui_diff tag configure clrui4$n -underline 1 -foreground $c
+	$ui_diff tag configure clru3$n -underline 1 -foreground $c
+	$ui_diff tag configure clrui3$n -underline 1 -background $c
 }
 $ui_diff tag configure clr1 -font font_diffbold
 
diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index dcf0711..f59477f 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -463,7 +463,8 @@ proc read_diff {fd cont_info} {
 
 		foreach {posbegin colbegin posend colend} $markup {
 			set prefix clr
-			foreach style [split $colbegin ";"] {
+			foreach style [lsort -integer [split $colbegin ";"]] {
+				if {$style eq "4"} {append prefix u; continue}
 				if {$style eq "7"} {append prefix i; continue}
 				if {$style < 30 || $style > 47} {continue}
 				set a "$mark linestart + $posbegin chars"
-- 
tg: (6f10c41..) bw/git-gui/support-underline-ansi-styles (depends on: master)
