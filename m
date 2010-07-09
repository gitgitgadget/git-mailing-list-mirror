From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 1/6] Add additional testcases for D/F conflicts
Date: Fri,  9 Jul 2010 07:10:51 -0600
Message-ID: <1278681056-31460-2-git-send-email-newren@gmail.com>
References: <1278681056-31460-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, agladysh@gmail.com,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 09 15:03:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXDEv-000077-Nm
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 15:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756154Ab0GINDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 09:03:08 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:39030 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755883Ab0GINDH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 09:03:07 -0400
Received: by pxi14 with SMTP id 14so804539pxi.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 06:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=K0AX+mDQ+K5InmX/A3biFuB4N+h/DEFnkdkexH+yJz0=;
        b=jtBiXrfIXMsuz3rc0LKwgr1H5zRfSh/D4cI6rh9UksrgFnX08v0SHp9U4NelSaSeOw
         Y37pAMqS7t+SoiZrN/4m+J4bwTOfPf4kcfUSaSLlAk2VCKSspbzYf3TNQwqZL0itSB3J
         /iGiqxoJLl68cq641jVy8bs9MQPJkIsOdzXnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NNurIB2oHj8luz7Lav9uuNx330pdc6kwHIR/Tct9YR7T414wDvlEcH5xTR0mQZbLAj
         5Z7oqNqSdSnc73/WC3RnOBm1ZPrjQkBLaiOAjo1BESIh3sSua5nz+qFKvBKD9SDKb7m3
         4NyppiDCHktJZ80syEzb+wEJAMO1qsV6ujsUo=
Received: by 10.142.158.13 with SMTP id g13mr10769024wfe.232.1278680582830;
        Fri, 09 Jul 2010 06:03:02 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-59-120.hsd1.nm.comcast.net [76.113.59.120])
        by mx.google.com with ESMTPS id b1sm700259rvn.2.2010.07.09.06.03.00
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Jul 2010 06:03:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1.23.gafea6
In-Reply-To: <1278681056-31460-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150663>

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6035-merge-dir-to-symlink.sh |   64 ++++++++++++++++++++++++++++++++++++--
 t/t9350-fast-export.sh          |   24 ++++++++++++++
 2 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/t/t6035-merge-dir-to-symlink.sh b/t/t6035-merge-dir-to-symlink.sh
index 3202e1d..761ad9d 100755
--- a/t/t6035-merge-dir-to-symlink.sh
+++ b/t/t6035-merge-dir-to-symlink.sh
@@ -48,7 +48,7 @@ test_expect_success 'setup for merge test' '
 	git tag baseline
 '
 
-test_expect_success 'do not lose a/b-2/c/d in merge (resolve)' '
+test_expect_success 'Handle D/F conflict, do not lose a/b-2/c/d in merge (resolve)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	git merge -s resolve master &&
@@ -56,7 +56,7 @@ test_expect_success 'do not lose a/b-2/c/d in merge (resolve)' '
 	test -f a/b-2/c/d
 '
 
-test_expect_failure 'do not lose a/b-2/c/d in merge (recursive)' '
+test_expect_failure 'Handle D/F conflict, do not lose a/b-2/c/d in merge (recursive)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	git merge -s recursive master &&
@@ -64,6 +64,54 @@ test_expect_failure 'do not lose a/b-2/c/d in merge (recursive)' '
 	test -f a/b-2/c/d
 '
 
+test_expect_success 'Handle F/D conflict, do not lose a/b-2/c/d in merge (resolve)' '
+	git reset --hard &&
+	git checkout master^0 &&
+	git merge -s resolve baseline^0 &&
+	test -h a/b &&
+	test -f a/b-2/c/d
+'
+
+test_expect_failure 'Handle F/D conflict, do not lose a/b-2/c/d in merge (recursive)' '
+	git reset --hard &&
+	git checkout master^0 &&
+	git merge -s recursive baseline^0 &&
+	test -h a/b &&
+	test -f a/b-2/c/d
+'
+
+test_expect_failure 'do not lose untracked in merge (resolve)' '
+	git reset --hard &&
+	git checkout baseline^0 &&
+	>a/b/c/e &&
+	test_must_fail git merge -s resolve master &&
+	test -f a/b/c/e &&
+	test -f a/b-2/c/d
+'
+
+test_expect_success 'do not lose untracked in merge (recursive)' '
+	git reset --hard &&
+	git checkout baseline^0 &&
+	>a/b/c/e &&
+	test_must_fail git merge -s recursive master &&
+	test -f a/b/c/e &&
+	test -f a/b-2/c/d
+'
+
+test_expect_success 'do not lose modifications in merge (resolve)' '
+	git reset --hard &&
+	git checkout baseline^0 &&
+	echo more content >>a/b/c/d &&
+	test_must_fail git merge -s resolve master
+'
+
+test_expect_success 'do not lose modifications in merge (recursive)' '
+	git reset --hard &&
+	git checkout baseline^0 &&
+	echo more content >>a/b/c/d &&
+	test_must_fail git merge -s recursive master
+'
+
 test_expect_success 'setup a merge where dir a/b-2 changed to symlink' '
 	git reset --hard &&
 	git checkout start^0 &&
@@ -74,7 +122,7 @@ test_expect_success 'setup a merge where dir a/b-2 changed to symlink' '
 	git tag test2
 '
 
-test_expect_success 'merge should not have conflicts (resolve)' '
+test_expect_success 'merge should not have D/F conflicts (resolve)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	git merge -s resolve test2 &&
@@ -82,7 +130,7 @@ test_expect_success 'merge should not have conflicts (resolve)' '
 	test -f a/b/c/d
 '
 
-test_expect_failure 'merge should not have conflicts (recursive)' '
+test_expect_failure 'merge should not have D/F conflicts (recursive)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	git merge -s recursive test2 &&
@@ -90,4 +138,12 @@ test_expect_failure 'merge should not have conflicts (recursive)' '
 	test -f a/b/c/d
 '
 
+test_expect_failure 'merge should not have F/D conflicts (recursive)' '
+	git reset --hard &&
+	git checkout -b foo test2 &&
+	git merge -s recursive baseline^0 &&
+	test -h a/b-2 &&
+	test -f a/b/c/d
+'
+
 test_done
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index d43f37c..69179c6 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -376,4 +376,28 @@ test_expect_success 'tree_tag-obj'    'git fast-export tree_tag-obj'
 test_expect_success 'tag-obj_tag'     'git fast-export tag-obj_tag'
 test_expect_success 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-obj'
 
+test_expect_failure 'directory becomes symlink'        '
+	git init dirtosymlink &&
+	git init result &&
+	(
+		cd dirtosymlink &&
+		mkdir foo &&
+		mkdir bar &&
+		echo hello > foo/world &&
+		echo hello > bar/world &&
+		git add foo/world bar/world &&
+		git commit -q -mone &&
+		git rm -r foo &&
+		ln -s bar foo &&
+		git add foo &&
+		git commit -q -mtwo
+	) &&
+	(
+		cd dirtosymlink &&
+		git fast-export master -- foo |
+		(cd ../result && git fast-import --quiet)
+	) &&
+	(cd result && git show master:foo)
+'
+
 test_done
-- 
1.7.1.1.23.gafea6
