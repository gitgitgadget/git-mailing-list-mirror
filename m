From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH] git-rebase: Teach rebase "-" shorthand.
Date: Tue, 18 Mar 2014 17:44:28 +0900
Message-ID: <1395132268-69488-1-git-send-email-modocache@gmail.com>
Cc: Brian Gesiak <modocache@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 18 09:44:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPpdh-0005yQ-DP
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 09:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131AbaCRIon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 04:44:43 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:46787 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858AbaCRIol (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 04:44:41 -0400
Received: by mail-pa0-f43.google.com with SMTP id bj1so6945015pad.16
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 01:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=yqIbN6P2ZBqjt28mWN3pIc5DcCaYcObBJvuHAN7jtmk=;
        b=XB4fWWzUc19JquRo364Xk0egZw1PGZQi8/4FNn70pLAsZ+3g7Ni0xZv3LTcdSD0ikp
         gYgxOaM+iVFj60XQkGxs79CeM/Z4Gom991dbLAEvHqaxdC6Am+KApVjiKKWslBTQU2iO
         Xbaj3stiVPhniceMm7zQgLsJTDouSJbK/mcjbmip9KVg0hpVIBzIZlvbxJMpU+t8t1GD
         mvBkeVj59zUU8Ham0BBqoDxp4UBsC0rja99BC2BYxR6vTDazTqzlBkQV4VsAbpsYh+sq
         wHH/ZHhkQgHN1/hE8xJOpXslRWr7sMWaDubXSVWGGkpq56pC8Cu/B4jtf1G4qraoxR5Y
         Qniw==
X-Received: by 10.66.122.36 with SMTP id lp4mr31773897pab.82.1395132281404;
        Tue, 18 Mar 2014 01:44:41 -0700 (PDT)
Received: from localhost.localdomain (p1157-ipbf5204marunouchi.tokyo.ocn.ne.jp. [118.8.132.157])
        by mx.google.com with ESMTPSA id ff4sm84364191pad.24.2014.03.18.01.44.39
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 18 Mar 2014 01:44:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.5.2 (Apple Git-48)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244340>

Teach rebase the same shorthand as checkout and merge; that is, that "-"
means "the branch we were previously on".

Reported-by: Tim Chase <git@tim.thechases.com>
Signed-off-by: Brian Gesiak <modocache@gmail.com>
---
 git-rebase.sh     | 4 ++++
 t/t3400-rebase.sh | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/git-rebase.sh b/git-rebase.sh
index 5f6732b..2c75e9f 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -453,6 +453,10 @@ then
 		test "$fork_point" = auto && fork_point=t
 		;;
 	*)	upstream_name="$1"
+		if test "$upstream_name" = "-"
+		then
+			upstream_name="@{-1}"
+		fi
 		shift
 		;;
 	esac
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 6d94b1f..00aba9f 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -88,6 +88,12 @@ test_expect_success 'rebase from ambiguous branch name' '
 	git rebase master
 '
 
+test_expect_success 'rebase using shorthand' '
+	git checkout master
+	git checkout -b shorthand HEAD^
+	GIT_TRACE=1 git rebase -
+'
+
 test_expect_success 'rebase a single mode change' '
 	git checkout master &&
 	git branch -D topic &&
-- 
1.8.5.2 (Apple Git-48)
