From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH] t1501: fix test with split index
Date: Tue, 24 Mar 2015 18:35:01 +0100
Message-ID: <1427218501-4644-1-git-send-email-t.gummerer@gmail.com>
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 18:39:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaSnt-0000Lk-81
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 18:39:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641AbbCXRjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 13:39:44 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:34645 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176AbbCXRjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 13:39:09 -0400
Received: by wgs2 with SMTP id 2so37877wgs.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 10:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=FkAGmj9ckkA1UTKBzaAlSl5mAUL1aOBGF0OUBk/P1oE=;
        b=HrFXi3SQ1L1I8xfTYHBn/GYa+3gbijx2uK5VP4ubUOsxN3hLTKv5+o4elYERV552WW
         v4pW2NlIzXWUrRH3y1DXj+O21qS+6svkVOrIhMg8YQopVm42cTpZsNYAT8VYNQJLFIak
         3YUwHPGf9TcDrSs8asy8VUjBpFNmDC4rRz/jZmbFEGFE6AUxb2BsKRbzHdQoBp81561v
         /RxcjzhkfcTrnzhNbJYWo18NciAbEonrgcvn7R/MQLnctsmvfyCq3doHi81ohAZtVwVO
         dfmnqjSbaFz6ZUUV6S7Ctuo48SVoxwE4ieIDfvYjVBqQxxHHcm7YpDxJwFix3iZe12os
         M4jQ==
X-Received: by 10.194.79.226 with SMTP id m2mr10159881wjx.60.1427218748001;
        Tue, 24 Mar 2015 10:39:08 -0700 (PDT)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id e2sm6996192wjy.46.2015.03.24.10.39.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2015 10:39:07 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.264.g0463184.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266208>

t1501-worktree.sh does not copy the shared index in the "relative
$GIT_WORK_TREE and git subprocesses" test, which makes the test fail
when GIT_TEST_SPLIT_INDEX is set.  Copy the shared index as well in
order to fix this.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

This applies on top of nd/multiple-work-trees.  Sorry for not catching it
earlier, but I haven't tried to run the test-suite for the next branch
then, where this appears.

 t/t1501-worktree.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 4df7a2f..ce5c654 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -350,6 +350,7 @@ test_expect_success 'Multi-worktree setup' '
 	mkdir work &&
 	mkdir -p repo.git/repos/foo &&
 	cp repo.git/HEAD repo.git/index repo.git/repos/foo &&
+	( cp repo.git/sharedindex.* repo.git/repos/foo 2>/dev/null || : ) &&
 	sane_unset GIT_DIR GIT_CONFIG GIT_WORK_TREE
 '
 
-- 
2.1.0.264.g0463184.dirty
