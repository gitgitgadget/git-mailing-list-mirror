From: Elijah Newren <newren@gmail.com>
Subject: [RFC/PATCH 05/18] Add testcase for --index-only merges needing the recursive strategy
Date: Thu,  7 Apr 2016 23:58:33 -0700
Message-ID: <1460098726-5958-6-git-send-email-newren@gmail.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 08:59:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoQO8-0002VL-6W
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 08:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbcDHG7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 02:59:15 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33961 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757475AbcDHG7J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 02:59:09 -0400
Received: by mail-pa0-f67.google.com with SMTP id hb4so8474488pac.1
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 23:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d5NhG/fyf0H3/ekov0nud7Sko4ZFZJQCSVanA0oCNlM=;
        b=sl83n1xs1eOOW32BDBd+Ru+VZJYYdKDC8J8I8NUiOe3uSdKCX3Y0/iQyvsD/ffnQqF
         01gYI1Y5YnLKXfBi0D4AUHxL1gL+KplYZQTZ82GQKzF9evHSO6qtSOoA1IBsFpHEulXQ
         U+Y/V8U6ZmvUoQYNyJkWLF97Pz9+mqm3iJp3xg5uZSgXf5SB6IVEavBw+oUbkK9I1h29
         Q0Stea1rWvTbG00kup6rxofIQ9E/F/5mW88EhoBNZPl7AmSkVXfLBjK8TNM4EwyTqwCI
         8wV9lelblGgivRaz2BWDxq3Tst1vr+laLYQqiQqxtjFztuc7uoPqQyU5msmgVIPAy/cN
         l8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d5NhG/fyf0H3/ekov0nud7Sko4ZFZJQCSVanA0oCNlM=;
        b=lj3VOhWIkOlW/IDNphAYnYzJ/YVuDbeEu6lX1q7kO1CdNk8QnzSHGPV57qKuUvEsix
         UNHCgfuZnz3vGH40aFVrML7MfVrTHljO2FmQVHCoyy8oxpI1ByxmaBondzDJRbMMmZ8x
         a7BnijXqNJv+rA++j4rf0h7gUv7JXHpfqt1X3w/Eo9mpRqGwhhfo/DgK4ABG3v36HFFH
         GDMjyp0R0dXWJG2djpo1TT/mx8hROhOlH89ZKwtf8Zn62dNqYa/wyOL4kU21aE4rl4RD
         zujV+jfJTOySkrB0sDVF7A8JzURekKTMeGmfto9ZSqZpMYz55YEgkk1RHbVZ7woPQ9Mt
         Lytw==
X-Gm-Message-State: AD7BkJIZ4MHNDzcRMzvJ7oE4UEK9y2Y9FU9JOjzQHv/Ap4iZeffP17XNkR2p3E4T27j9eQ==
X-Received: by 10.66.122.3 with SMTP id lo3mr10365815pab.25.1460098743454;
        Thu, 07 Apr 2016 23:59:03 -0700 (PDT)
Received: from unknownB8F6B118D3EB.attlocal.net ([2602:30a:2c28:20f0:baf6:b1ff:fe18:d3eb])
        by smtp.gmail.com with ESMTPSA id w62sm16371973pfa.79.2016.04.07.23.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Apr 2016 23:59:02 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.18.gc685494
In-Reply-To: <1460098726-5958-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291004>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-index-only.sh | 170 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 170 insertions(+)
 create mode 100755 t/t6043-merge-index-only.sh

diff --git a/t/t6043-merge-index-only.sh b/t/t6043-merge-index-only.sh
new file mode 100755
index 0000000..b8b22ab
--- /dev/null
+++ b/t/t6043-merge-index-only.sh
@@ -0,0 +1,170 @@
+#!/bin/sh
+
+test_description="index-only merges"
+
+. ./test-lib.sh
+
+# Testcase setup for rename/modify:
+#   Commit A: new file: a
+#   Commit B: modify a slightly
+#   Commit C: rename a->b
+# We should be able to merge B & C cleanly
+
+test_expect_success 'setup rename/modify merge' '
+	git init &&
+
+	printf "1\n2\n3\n4\n5\n6\n7\n" >a &&
+	git add a &&
+	git commit -m A &&
+	git tag A &&
+
+	git checkout -b B A &&
+	echo 8 >>a &&
+	git add a &&
+	git commit -m B &&
+
+	git checkout -b C A &&
+	git mv a b &&
+	git commit -m C
+'
+
+test_expect_failure '--index-only with rename/modify works in non-bare-clone' '
+	git checkout B^0 &&
+
+	git merge --index-only -s recursive C^0 &&
+
+	echo "Making sure the working copy was not updated" &&
+	test ! -f b &&
+	test -f a &&
+	test $(git rev-parse B:a) = $(git hash-object a) &&
+
+	echo "Making sure the index was updated" &&
+	test 1 -eq $(git ls-files -s | wc -l) &&
+	test $(git rev-parse B:a) = $(git rev-parse :b)
+'
+
+test_expect_failure '--index-only with rename/modify works in a bare clone' '
+	git clone --bare . bare.clone &&
+	(cd bare.clone &&
+
+	 git update-ref --no-deref HEAD B &&
+	 git read-tree HEAD &&
+
+	 git merge --index-only -s recursive C^0 &&
+
+	 echo "Making sure the working copy was not updated" &&
+	 test ! -f b &&
+	 test ! -f a &&
+
+	 echo "Making sure the index was updated" &&
+	 test 1 -eq $(git ls-files -s | wc -l) &&
+	 test $(git rev-parse B:a) = $(git rev-parse :b)
+	)
+'
+
+# Testcase requiring recursion to handle:
+#
+#    L1      L2
+#     o---o--o
+#    / \ /    \
+# B o   X      o C
+#    \ / \    /
+#     o---o--o
+#    R1      R2
+#
+# B : 1..20
+# L1: 1..3 a..c 4..20
+# R1: 1..13n..p14..20
+# L2: 1..3 a..i 4..13 n..p 14..20
+# R2: 1..3 a..c 4..13 n..v 14..20
+# C:  1..3 a..i 4..13 n..v 14..20
+#   needs 'recursive' strategy to get correct solution; 'resolve' would fail
+#
+
+test_expect_success 'setup single-file criss-cross resolvable with recursive strategy' '
+	git reset --hard &&
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	seq 1 20 >contents &&
+	git add contents &&
+	test_tick && git commit -m initial &&
+
+	git branch R1 &&
+	git checkout -b L1 &&
+	seq 1 3 >contents &&
+	seq 1 3 | tr 1-3 a-c >>contents &&
+	seq 4 20 >>contents &&
+	git add contents &&
+	test_tick && git commit -m L1 &&
+
+	git checkout R1 &&
+	seq 1 13 >contents &&
+	seq 1 3 | tr 1-3 n-p >>contents &&
+	seq 14 20 >>contents &&
+	git add contents &&
+	test_tick && git commit -m R1 &&
+
+	git checkout -b L2 L1^0 &&
+	test_tick && git merge R1 &&
+	seq 1 3 >contents &&
+	seq 1 9 | tr 1-9 a-i >>contents &&
+	seq 4 13 >>contents &&
+	seq 1 3 | tr 1-3 n-p >>contents &&
+	seq 14 20 >>contents &&
+	git add contents &&
+	test_tick && git commit -m L2 &&
+
+	git checkout -b R2 R1^0 &&
+	test_tick && git merge L1 &&
+	seq 1 3 >contents &&
+	seq 1 3 | tr 1-3 a-c >>contents &&
+	seq 4 13 >>contents &&
+	seq 1 9 | tr 1-9 n-v >>contents &&
+	seq 14 20 >>contents &&
+	git add contents &&
+	test_tick && git commit -m R2 &&
+
+	seq 1 3 >answer &&
+	seq 1 9 | tr 1-9 a-i >>answer &&
+	seq 4 13 >>answer &&
+	seq 1 9 | tr 1-9 n-v >>answer &&
+	seq 14 20 >>answer &&
+	git tag answer $(git hash-object -w answer) &&
+	rm -f answer
+'
+
+test_expect_failure 'recursive --index-only in non-bare repo' '
+	git reset --hard &&
+	git checkout L2^0 &&
+
+	git merge --index-only -s recursive R2^0 &&
+
+	test 1 = $(git ls-files -s | wc -l) &&
+	test 0 = $(git ls-files -u | wc -l) &&
+	test 0 = $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :contents) = $(git rev-parse answer) &&
+	test $(git rev-parse L2:contents) = $(git hash-object contents)
+'
+
+test_expect_failure 'recursive --index-only in bare repo' '
+	git clone --bare . bare.clone &&
+	(cd bare.clone &&
+
+	 git update-ref --no-deref HEAD L2 &&
+	 git read-tree HEAD &&
+
+	 git merge --index-only -s recursive R2^0 &&
+
+	 test 1 = $(git ls-files -s | wc -l) &&
+	 test 0 = $(git ls-files -u | wc -l) &&
+
+	 test $(git rev-parse :contents) = $(git rev-parse answer) &&
+	 test ! -f contents
+	)
+'
+
+test_done
-- 
2.8.0.18.gc685494
