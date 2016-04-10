From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 4/6] merge-octopus: Abort if index does not match HEAD
Date: Sat,  9 Apr 2016 23:13:38 -0700
Message-ID: <1460268820-8308-5-git-send-email-newren@gmail.com>
References: <1460268820-8308-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 08:14:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ap8dJ-00049x-Hx
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 08:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbcDJGNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 02:13:55 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36681 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbcDJGNx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 02:13:53 -0400
Received: by mail-pa0-f66.google.com with SMTP id k3so8290551pav.3
        for <git@vger.kernel.org>; Sat, 09 Apr 2016 23:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uh4lBIGOwtdbFIb6z0Nwlwzh3KYZO/ja+e/3QNBmQIk=;
        b=Xei2bxqCb7DqbdL+JjTJzSueK9foUpdFE/88Y6EYsgPloolQWH1ljKxRJG+NH9XMRn
         He8JbRTc4Ue6gBaxXvIhOnz+Fv2VSM92oKVjJwM+gyMFUNMQwPJy+/pXsRpr/gd669El
         BiHhO2LhuVz/a3Qqj1E0bC7Jd3j1Ce7hZp2iWp0Ee52lfym7rM9Pe9sGghSnMYuLSWOS
         oiTPpjotq5hHl+VLGkdMi9QZ7vgpFTKYMa/pnnyt3vr5iP1nHevHIU1lCnaiiTIwjaeZ
         NB74xyytaecIlXWow/jQD/qQv0rOz2KExqQ84TlWwkL7jpXq4k7YLrR9M0lIjwO1QdnK
         9dJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uh4lBIGOwtdbFIb6z0Nwlwzh3KYZO/ja+e/3QNBmQIk=;
        b=F7CShA7oIGDWJiCaH4q5qLsaI/LfNUHyEXOoYdsdePgsvk8NKSHTjM1ocVMyubStcx
         RW/RdXV9/1kydB9fxbv+dzQCfJR4zz70erq4OJow+4CmE1jYyO6ydFGYG5VRY7eR53kU
         OOzhN6PrAflci1xcki1Tzz4ggOHkfSawGusgnePMLtpISc99a6yDh1fEzk51FFOrOW0O
         RIfEuUCG/YqEiYes/56G08YKMu4j5tBY22/iFF++7EwIJ2vbrEhQk3JpSniYI4GwoQ0C
         r8dVcN3b0zr5mWL7PznbcihPAKYoArjVJEO12eANwc/br0qRpCu+GmaSxm0fO/+BaaGd
         Nfsg==
X-Gm-Message-State: AD7BkJJTaQZPs27v6K0j/klFvQ9pazo8JthFZjRN67ozjdgTNeqysADSxkc3rGBBLVPmvg==
X-Received: by 10.67.6.10 with SMTP id cq10mr24108106pad.120.1460268832603;
        Sat, 09 Apr 2016 23:13:52 -0700 (PDT)
Received: from unknownB8F6B118D3EB.attlocal.net ([2602:30a:2c28:20f0:baf6:b1ff:fe18:d3eb])
        by smtp.gmail.com with ESMTPSA id p26sm28228711pfi.84.2016.04.09.23.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Apr 2016 23:13:52 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.6.g5833b2a
In-Reply-To: <1460268820-8308-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291141>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 git-merge-octopus.sh                     | 6 ++++++
 t/t6044-merge-unrelated-index-changes.sh | 6 +++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
index 8643f74..dc2fd1b 100755
--- a/git-merge-octopus.sh
+++ b/git-merge-octopus.sh
@@ -44,6 +44,12 @@ esac
 # MRC is the current "merge reference commit"
 # MRT is the current "merge result tree"
 
+if ! git diff-index --quiet --cached HEAD --
+then
+    echo "Error: Your local changes to the following files would be overwritten by merge"
+    git diff-index --cached --name-only HEAD -- | sed -e 's/^/    /'
+    exit 2
+fi
 MRC=$(git rev-parse --verify -q $head)
 MRT=$(git write-tree)
 NON_FF_MERGE=0
diff --git a/t/t6044-merge-unrelated-index-changes.sh b/t/t6044-merge-unrelated-index-changes.sh
index eed5d95..20a3ffe 100755
--- a/t/t6044-merge-unrelated-index-changes.sh
+++ b/t/t6044-merge-unrelated-index-changes.sh
@@ -105,7 +105,7 @@ test_expect_success 'recursive' '
 	test_must_fail git merge -s recursive C^0
 '
 
-test_expect_failure 'octopus, unrelated file touched' '
+test_expect_success 'octopus, unrelated file touched' '
 	git reset --hard &&
 	git checkout B^0 &&
 
@@ -114,7 +114,7 @@ test_expect_failure 'octopus, unrelated file touched' '
 	test_must_fail git merge C^0 D^0
 '
 
-test_expect_failure 'octopus, related file removed' '
+test_expect_success 'octopus, related file removed' '
 	git reset --hard &&
 	git checkout B^0 &&
 
@@ -123,7 +123,7 @@ test_expect_failure 'octopus, related file removed' '
 	test_must_fail git merge C^0 D^0
 '
 
-test_expect_failure 'octopus, related file modified' '
+test_expect_success 'octopus, related file modified' '
 	git reset --hard &&
 	git checkout B^0 &&
 
-- 
2.8.0.21.g229f62a
