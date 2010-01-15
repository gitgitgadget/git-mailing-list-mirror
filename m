From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 1/3] t7800-difftool.sh: Simplify the --extcmd test
Date: Fri, 15 Jan 2010 14:03:42 -0800
Message-ID: <1263593024-12093-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, j.sixt@viscovery.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 15 23:04:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVuGs-0002hF-UX
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 23:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422Ab0AOWDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 17:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754230Ab0AOWDy
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 17:03:54 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:40612 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319Ab0AOWDx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 17:03:53 -0500
Received: by ewy1 with SMTP id 1so608290ewy.28
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 14:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=jB0bQ0YJ86n5IqPlS0w3iQ9AkATfUwa4/RTi3ttRBBE=;
        b=PHBjhmrEF2r+Id3M2pjlnSGz976XBKAC8mPXiuxNcol6jWWYQAgGj6aEZdkmeM3Oj4
         a3jgVeyOHFNkaVd+QOvWp8ruGLvp+yJUY5iyM4hRinBJN4SjrPxZw+5OSt1b5ZtXK+Fh
         a6tbX2V2Ys66RE/uChuKrWbLAK0J17UHv0gvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=JqIkAIxPzyvNNKC+ztsppxKL3e+k7rwCCXAvf1eu6Bgii2frfo0TimhKrdHGDFSzmA
         4pMsAsvnneb9M5RUzNxgG8e0Bjd00W1J9W2X6e2qDWiba4FVz7s07lpdWFS4sTuuhq+8
         wQPvOnoOGapZQ9V5ghaBrCvohm9W9XUGDVSbg=
Received: by 10.213.110.206 with SMTP id o14mr2991367ebp.6.1263593032062;
        Fri, 15 Jan 2010 14:03:52 -0800 (PST)
Received: from localhost (isrfasc7a1-gw.disneyanimation.com [12.188.26.241])
        by mx.google.com with ESMTPS id 23sm2950078eya.35.2010.01.15.14.03.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 14:03:51 -0800 (PST)
X-Mailer: git-send-email 1.6.6.9.g8dfa7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137134>

Instead of running 'grep', 'echo', and 'wc' we simply compare
git-difftool's output against a known good value.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

This is unchanged from v1 but is included in the series
for completeness.

These all apply to 'next', specifically the da/difftool branch.

 t/t7800-difftool.sh |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 8ee186a..1d9e07b 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -15,6 +15,9 @@ if ! test_have_prereq PERL; then
 	test_done
 fi
 
+LF='
+'
+
 remove_config_vars()
 {
 	# Unset all config variables used by git-difftool
@@ -219,19 +222,13 @@ test_expect_success 'difftool.<tool>.path' '
 	restore_test_defaults
 '
 
-test_expect_success 'difftool --extcmd=...' '
+test_expect_success 'difftool --extcmd=cat' '
 	diff=$(git difftool --no-prompt --extcmd=cat branch) &&
+	test "$diff" = branch"$LF"master
 
-	lines=$(echo "$diff" | wc -l) &&
-	test "$lines" -eq 2 &&
 
-	lines=$(echo "$diff" | grep master | wc -l) &&
-	test "$lines" -eq 1 &&
 
-	lines=$(echo "$diff" | grep branch | wc -l) &&
-	test "$lines" -eq 1 &&
 
-	restore_test_defaults
 '
 
 test_done
-- 
1.6.6.6.g627fb.dirty
