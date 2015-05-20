From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v5 1/2] mergetool--lib: set IFS for difftool and mergetool
Date: Wed, 20 May 2015 02:02:41 -0700
Message-ID: <1432112562-400-1-git-send-email-davvid@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Phil Susi <phillsusi@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 11:02:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yuztu-0000t1-FG
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 11:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110AbbETJCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 05:02:50 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36493 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbbETJCo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 05:02:44 -0400
Received: by pabts4 with SMTP id ts4so59853910pab.3
        for <git@vger.kernel.org>; Wed, 20 May 2015 02:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Acog4r29ujdIIOQc9dYaN4it3UUBMTvfpkEDiwsfKlg=;
        b=EOJh4S6HNc4UjcM9Pc4gE701lUEGT6J50krNfuAAWK1dQEEGx7lpLSpOU9+UGtREqP
         wC9sQbo+jS8YtmYLW0Fi0ICLJ1l4YT/ZbEZlArkEMBQGXyNT4tb1XyoHbo0+cPlt8XkH
         /UUmPhuD/oOEc3up0rMA6LydyzcY+vCb3Y41WmKStYG0Anv996xcavYjVsxUh3wbGU4R
         M0Czoj1C+N782jUNyMgbvn7ptiCjscbKkp3kz8AVsriOp1/ICHVlR/zGLypVogvZkn2f
         FX5TtDmY38C2E9W22wK6QTYLlC34U/mmCCpm2j6W9SDiNcNclRvWOl6bnzJ/OcEoJgwX
         UYgA==
X-Received: by 10.70.24.130 with SMTP id u2mr7639843pdf.147.1432112564171;
        Wed, 20 May 2015 02:02:44 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id nm9sm4513219pdb.26.2015.05.20.02.02.42
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 20 May 2015 02:02:43 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.218.gc09a0e5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269453>

git-sh-setup sets IFS but it is not used by git-difftool--helper.
Set IFS in git-mergetool--lib so that the mergetool scriptlets,
diftool, and mergetool do not need to do so.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This patch is new since last time.  It simplifies the patch that follows.

 git-mergetool--lib.sh | 3 +++
 git-mergetool.sh      | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index fe61e89..14b039d 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -2,6 +2,9 @@
 
 : ${MERGE_TOOLS_DIR=$(git --exec-path)/mergetools}
 
+IFS='
+'
+
 mode_ok () {
 	if diff_mode
 	then
diff --git a/git-mergetool.sh b/git-mergetool.sh
index d20581c..9f77e3a 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -451,8 +451,6 @@ fi
 printf "Merging:\n"
 printf "%s\n" "$files"
 
-IFS='
-'
 rc=0
 for i in $files
 do
-- 
2.4.1.218.gc09a0e5
