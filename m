From: Ross Lagerwall <rosslagerwall@gmail.com>
Subject: [PATCH] difftool: silence warning
Date: Tue, 21 Aug 2012 12:21:40 +0200
Message-ID: <1345544500-16277-1-git-send-email-rosslagerwall@gmail.com>
Cc: Ross Lagerwall <rosslagerwall@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 12:22:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3lbJ-0004ym-Gy
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 12:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756178Ab2HUKWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 06:22:16 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36045 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755989Ab2HUKWP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 06:22:15 -0400
Received: by wibhr14 with SMTP id hr14so4518960wib.1
        for <git@vger.kernel.org>; Tue, 21 Aug 2012 03:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=r0abGWzOEX58BiT4hLpWRJwKufLZIQMnR5Ia1VswVsQ=;
        b=eksJwfeEOg64S6CPSKBTOUP74UBa8PI1tsmlaN1IpBlFl2qNcrwz3bJ0RBV3Q6m+F/
         9vNqoI1ZBLRNxGHdCGtwwx0Q12KNlCVss/2DK7E+TA4US4UMccyCeRZ81idMa/KoHtov
         qkQYjtfISG5nYzS6WKIp1kc1bQOCm8QWipC2X+wzeZ513IQC7OpV594j3sOBOnGi0It0
         T/N7iDqVXi7jnVdQflP6ES22Y7XVcgvFtIBT0ZnRP7XtxX1GaIA7N4ugE2WM6aoOk7NK
         PZpjpWLFykgAWOLa0xd+HPy2S0NWGxbFwSbSGUIYXuN5uO6hYGxK/Gn+QH40pWoH5mdn
         bT1g==
Received: by 10.216.74.21 with SMTP id w21mr9059392wed.77.1345544534285;
        Tue, 21 Aug 2012 03:22:14 -0700 (PDT)
Received: from localhost.localdomain (41-135-222-205.dsl.mweb.co.za. [41.135.222.205])
        by mx.google.com with ESMTPS id l6sm32937873wiz.4.2012.08.21.03.22.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Aug 2012 03:22:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203961>

Silence a warning given when running git difftool --dir-diff and
there are no changes.
This is because command_oneline returns undef when the command has no
output, not ''.

Signed-off-by: Ross Lagerwall <rosslagerwall@gmail.com>
---
 git-difftool.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 17d4de6..edd0493 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -138,7 +138,7 @@ sub setup_dir_diff
 
 	my @gitargs = ('diff', '--raw', '--no-abbrev', '-z', @ARGV);
 	my $diffrtn = $diffrepo->command_oneline(@gitargs);
-	exit(0) if (length($diffrtn) == 0);
+	exit(0) unless defined($diffrtn);
 
 	# Build index info for left and right sides of the diff
 	my $submodule_mode = '160000';
-- 
1.7.11.4
