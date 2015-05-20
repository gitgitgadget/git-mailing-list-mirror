From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v6 1/2] mergetool--lib: set IFS for difftool and mergetool
Date: Wed, 20 May 2015 02:07:22 -0700
Message-ID: <1432112843-973-1-git-send-email-davvid@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Phil Susi <phillsusi@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 11:07:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuzyO-0002u4-Eh
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 11:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbbETJH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 05:07:27 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36192 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbbETJHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 05:07:25 -0400
Received: by pabts4 with SMTP id ts4so59989979pab.3
        for <git@vger.kernel.org>; Wed, 20 May 2015 02:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=NrxVDFYnfXsFc3w6LoLWTmTNmzr33iuE9hiwG53PAvg=;
        b=LIlGE/EgCN8PwPdeyiIOpOgrR+Xy2S13RX1uJSVnDFjLXUlppKZN3CUUvYvY2KlcJB
         9Ji80Ugfcstn0+ALNLjNx38hKk67ukm6ltZFT0XCxzl9MqCi+hPldtuRhwyEYNCHAY4+
         mrjheYJ8QSy39pxSXhmlb5pHzAhrnvJtCcmLZRUf3xyeF/uz6YsUAZLPcxG1MuTrQCa7
         IAwZSLL63sasc1BdZuEsVFLoPOOkCNYiKg0rXj1FMyC8Vsu8d4Oy03spu3EUwA+FIyJn
         SRuUme0T3yDAgKWhOpQsAWcx6bZ9acpIEtfl89Es6ouEsL1/TPzDRBtu9I/OX3mXM++k
         eBdw==
X-Received: by 10.68.116.132 with SMTP id jw4mr61568850pbb.107.1432112844625;
        Wed, 20 May 2015 02:07:24 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id kr9sm15524314pab.30.2015.05.20.02.07.23
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 20 May 2015 02:07:23 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.218.gc09a0e5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269456>

git-sh-setup sets IFS but it is not used by git-difftool--helper.
Set IFS in git-mergetool--lib so that the mergetool scriptlets,
difftool, and mergetool do not need to do so.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Changes since v5: fixed "diftool" typo in commit message

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
