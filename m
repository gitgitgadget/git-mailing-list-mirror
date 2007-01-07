From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 5/5] gitweb: Fix split patches output (e.g. file to symlink)
Date: Sun,  7 Jan 2007 02:52:27 +0100
Message-ID: <11681347551377-git-send-email-jnareb@gmail.com>
References: <100171.86639.qm@web31814.mail.mud.yahoo.com>
Cc: Luben Tuikov <ltuikov@yahoo.com>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 07 02:52:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3NDK-0001C8-Bp
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 02:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbXAGBwj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 20:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbXAGBwi
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 20:52:38 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:5038 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932308AbXAGBwd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 20:52:33 -0500
Received: by nf-out-0910.google.com with SMTP id o25so8960301nfa
        for <git@vger.kernel.org>; Sat, 06 Jan 2007 17:52:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UkvDAAgcGuRU9CwMUo3Hav3mEUWvLaozeVp6Xcrqh/gk4Kx21vUIyajeARR4YqCAVi9981clVj+ePjwjDiK+HXIzOIr74af2dNJtlQ3BhTICsFqc3q17K+7pbnSnPEhLskQOOEuHM6WYoHrbQ8YKSKo7XfitaNb5VUvkNc9IHlU=
Received: by 10.49.41.3 with SMTP id t3mr8937572nfj.1168134752360;
        Sat, 06 Jan 2007 17:52:32 -0800 (PST)
Received: from roke.D-201 ( [81.190.18.145])
        by mx.google.com with ESMTP id x27sm101645665nfb.2007.01.06.17.52.31;
        Sat, 06 Jan 2007 17:52:32 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l071qZe1007276;
	Sun, 7 Jan 2007 02:52:35 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l071qZnm007275;
	Sun, 7 Jan 2007 02:52:35 +0100
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3
In-Reply-To: <100171.86639.qm@web31814.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36115>

Do not replace /dev/null in two-line from-file/to-file diff header for
split patches ("split" patch mean more than one patch per one
diff-tree raw line) by a/file or b/file link.

Split patches differ from pair of deletion/creation patch in git diff
header: both a/file and b/file are hyperlinks, in all patches in a
split.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d60d7c6..f46a422 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2525,7 +2525,7 @@ sub git_patchset_body {
 		last PATCH unless $patch_line;
 		next PATCH if ($patch_line =~ m/^diff /);
 		#assert($patch_line =~ m/^---/) if DEBUG;
-		if ($from{'href'}) {
+		if ($from{'href'} && $patch_line =~ m!^--- "?a/!) {
 			$patch_line = '--- a/' .
 			              $cgi->a({-href=>$from{'href'}, -class=>"path"},
 			                      esc_path($from{'file'}));
@@ -2537,7 +2537,7 @@ sub git_patchset_body {
 		chomp $patch_line;
 
 		#assert($patch_line =~ m/^+++/) if DEBUG;
-		if ($to{'href'}) {
+		if ($to{'href'} && $patch_line =~ m!^\+\+\+ "?b/!) {
 			$patch_line = '+++ b/' .
 			              $cgi->a({-href=>$to{'href'}, -class=>"path"},
 			                      esc_path($to{'file'}));
-- 
1.4.4.3
