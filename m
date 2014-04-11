From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH] test: fix t7001 cp to use POSIX options
Date: Fri, 11 Apr 2014 01:24:02 -0700
Message-ID: <1c3e86191de8c91545ac3ddc18fd31e@74d39fa044aa309eaea14b9f57fe79c>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 10:24:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYWl3-0007p7-Mt
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 10:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbaDKIYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 04:24:14 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:62595 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbaDKIYM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 04:24:12 -0400
Received: by mail-pa0-f50.google.com with SMTP id kq14so5093457pab.23
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 01:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=8CG0WAxWzLolJiAoMbTv97M+CS1ud6JWxhmIxHCvTvc=;
        b=LSijB2o1QxqfTNiCKnFxdebHc9UqMNi5k465jL7cORSS1TersM7De8V0t8eduKCdwX
         ezO9aYaPzmM1z282JNrTzBNZ9lv1Ac83/Khfsbn/lcTyI52MUFjqbLNaGAOMxWsntFl8
         7r8n+Hbh9EsqZQ1RE+DxWWEgT5GYKT+TlbJcQ6grvWVoey1Rioj/bUuuGG1VTbM7NC+S
         FQ73wnWBSWlDzAuNjqQrktpp4+teL4jN62KLjK5aRlJ0HYWurcAAxQFQ9ZTa4Ki523lN
         JCSvwqalVd5YTWBKxeQK8fv+Mc15/AWzfmkoQJ98ElLUtRzWmnZIxYaq4JxCm5V4gl+C
         RMpA==
X-Received: by 10.66.192.73 with SMTP id he9mr25631908pac.88.1397204651745;
        Fri, 11 Apr 2014 01:24:11 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ei4sm14003695pbb.42.2014.04.11.01.24.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Apr 2014 01:24:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246068>

Since 11502468 and 04c1ee57 (both first appearing in v1.8.5), the
t7001-mv test has used "cp -a" to perform a copy in several of the
tests.

However, the "-a" option is not required for a POSIX cp utility and
some platforms' cp utilities do not support it.

The POSIX equivalent of -a is -R -P -p.

Change "cp -a" to "cp -R -P -p" so that the t7001-mv test works
on systems with a cp utility that only implements the POSIX
required set of options and not the "-a" option.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>

---
 t/t7001-mv.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 215d43d6..c8ff9115 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -308,7 +308,7 @@ test_expect_success 'git mv moves a submodule with a .git directory and no .gitm
 	(
 		cd sub &&
 		rm -f .git &&
-		cp -a ../.git/modules/sub .git &&
+		cp -R -P -p ../.git/modules/sub .git &&
 		GIT_WORK_TREE=. git config --unset core.worktree
 	) &&
 	mkdir mod &&
@@ -331,7 +331,7 @@ test_expect_success 'git mv moves a submodule with a .git directory and .gitmodu
 	(
 		cd sub &&
 		rm -f .git &&
-		cp -a ../.git/modules/sub .git &&
+		cp -R -P -p ../.git/modules/sub .git &&
 		GIT_WORK_TREE=. git config --unset core.worktree
 	) &&
 	mkdir mod &&
-- 
tg: (0bc85abb..) t/t7001-posix-cp (depends on: maint)
