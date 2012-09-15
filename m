From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH 3/3] rebase -i: Add tests for "--edit-todo"
Date: Sat, 15 Sep 2012 16:08:29 -0400
Message-ID: <1347739709-15289-4-git-send-email-andrew.kw.w@gmail.com>
References: <CADgNjambUXj+WEFg=OWvtDQ1EKFhavwbjMbTVaP69rhh5DrphA@mail.gmail.com>
 <1347739709-15289-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 23:10:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCzdf-0004gH-J5
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 23:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169Ab2IOVKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 17:10:48 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:32836 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542Ab2IOVJt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 17:09:49 -0400
Received: by mail-iy0-f174.google.com with SMTP id k25so4417635iah.19
        for <git@vger.kernel.org>; Sat, 15 Sep 2012 14:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0elH4VFI33P+YNoEjIyU+XRC/GPmVj6Q2l8/fcaWb0g=;
        b=E6/X3augkX9uyDGXLd+fvWlQWiDQ+tSDhhoNfZGvb4pbSwZkFVLmcUoZDT21INEb88
         imVeWd21qgJ1odB2amf+q1Sx8TMxVdHgO4PP3WkB7jML2Z+7QoDDvNgrd+W2ahaM3zjP
         jcf6Tbwf+qHiQn2LD8rebT+uhHi2Y0KrD+eEJhq7Gl02Y/MwK79H4gZEnh2wUt2fr1CN
         zDq+4Ijg41vo8BsBiLHBhksj4k5B1oyupM05gmqZGseVdy58YPJWawJs9qWXpTKe5LI8
         061x0ArEtzYdPycdFR+0ouvGPG5sD1j+8Wm9YElBh4DwlWEUt+alMeHSw9eY0K5OharE
         u3IA==
Received: by 10.42.66.207 with SMTP id q15mr5625192ici.34.1347743389212;
        Sat, 15 Sep 2012 14:09:49 -0700 (PDT)
Received: from localhost.localdomain ([69.165.255.59])
        by mx.google.com with ESMTPS id d19sm2172495igp.6.2012.09.15.14.09.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Sep 2012 14:09:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.318.g08bf5ad.dirty
In-Reply-To: <1347739709-15289-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205573>

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 t/t3404-rebase-interactive.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 7304b66..a194c97 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -911,4 +911,20 @@ test_expect_success 'rebase -i --root fixup root commit' '
 	test 0 = $(git cat-file commit HEAD | grep -c ^parent\ )
 '
 
+test_expect_success 'rebase --edit-todo does not works on non-interactive rebase' '
+	git checkout conflict-branch &&
+	test_must_fail git rebase --onto HEAD~2 HEAD~ &&
+	test_must_fail git rebase --edit-todo &&
+	git rebase --abort
+'
+
+test_expect_success 'rebase --edit-todo can be used to modify todo' '
+	git checkout no-conflict-branch^0 &&
+	FAKE_LINES="edit 1 2 3" git rebase -i HEAD~3 &&
+	FAKE_LINES="2 1" git rebase --edit-todo &&
+	git rebase --continue
+	test M = $(git cat-file commit HEAD^ | sed -ne \$p) &&
+	test L = $(git cat-file commit HEAD | sed -ne \$p)
+'
+
 test_done
-- 
1.7.12.318.g08bf5ad.dirty
