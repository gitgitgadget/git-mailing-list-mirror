From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 02/16] bisect: add test for the bisect algorithm
Date: Fri, 26 Feb 2016 03:04:28 +0100
Message-ID: <1456452282-10325-3-git-send-email-s-beyer@gmx.net>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 03:06:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ7nL-0007bG-E6
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 03:06:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbcBZCFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 21:05:45 -0500
Received: from mout.gmx.net ([212.227.15.18]:57840 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752065AbcBZCFo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 21:05:44 -0500
Received: from fermat.fritz.box ([188.108.247.176]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0LfSyv-1aATGe3j0T-00p2nV; Fri, 26 Feb 2016 03:05:42
 +0100
X-Mailer: git-send-email 2.7.2.383.g3fb0654
In-Reply-To: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:zxMbMBCzrTYujFIfrGifKOOfcZ+5+eMFWeV3zSZkda3s456tlkN
 fWz1ZZhw5v6GR0amMQrMPUMPdJf1Q7MnlojjckSnoWQPHm6RWfrhh0Ie4fxk96aS3S0Y0En
 Xu3Nmb81/47JD8i8i/wCiu3lkCnIFVPXX0fVk0HqwGd4niY1eQEJxOPvN6upM2WG+NTTRcD
 pEU5F6qyZmDHm1s9r7NUw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a7EFNl0JVFM=:ORrdlSgSxlhEfXLYub9d2V
 fnhJnrNXpEi6w3XUSYlFdER8z/BK4OkAZYqhQD/ojipxeKm7NYZfjLaSgL7fDSuZktumgrYJi
 TYivd2lZ2Y5jZtVOBLk+km/M9NaUIHZTbMZ4MA5w2Pe1/uVOPt+I4/CzBv20cF+neAd9BmOnv
 r4sHKdZu0HSLUXZuSSJ69Liubzur44Zmm9HqWHKaL1Jbn+r2+LKfQZVHLNaOhaqjEtTVKriql
 4C7yV5xSTCBaE4OKSZrAgnfJz5JKGtKIfMDryLHxqE29KwJk5GQ685rjfoX/Gygg7pLKGQA89
 ppb4mvhhIOcymKzdzBo8TE5DGNr07+PBrsZ09P1hTj3ueqnioYM2iehbiuR7cspHmIGt8sj1V
 74wqa75JiiLNtcd7odaM3O7K+1HiAeeaEnfX4b+ELcmKyRH1q1mJkYL0F3jfw80ptcuzXMZOo
 CSiPiSTURN0lI1fTTGT30kplsLfWqsPKQcq/U0KRu2Q6ZqhfHqwbCoUhIik4QS3JzN0Fq695N
 RyQgxxs8qnUfi9jEo//REhG1quDNyj6DQJZ2cjGnOP5dyLpbGYP5vBvO0eDN2Xd2rrtVraHIF
 eeZEW2TxvSq1XM6VdIPsEB0RykgGs4J+aI7DANGNgwY3AR5lj90bKgDH+UvIrqzYSAPhjbawT
 2eB7CY2s29u/rPLVFoLj6131yL/DdTIYxgc07biG+eKzjs9Qa0qYc43chQdQ8DN5tZqo1LjV1
 bhu/3n/2SzRkLJsFEvuzeNT7OSK/KytUczoPspvChciTpFDal46Ols38kuQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287525>

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

To be honest: the test could be better, it could be more "targeted",
i.e. the example commit history could be smaller and just consider
all the cases and corner cases and whatever.
However, I made it first to understand the algorithm and verify the
description of it in the documentation. Then I was too lazy to
improve it. I am sorry that this is no better advertising text. ;)

Moreover, the test does not test one important thing that is
always cared about in the bisect code: TREESAME commits.
Perhaps I got the concept wrong. I tried to obtain TREESAME commits
using 'git commit --allow-empty -m "same tree"'. However, those
commits were never considered being TREESAME. So I gave up (I did
not care much.)
Anyone has an idea how to obtain them?
Or is this a bug that should be fixed?

(Also UNINTERESTING commits are never found by the DEBUG_BISECT
output, but I think this is because they are just filtered out.)

 t/t8010-bisect-algorithm.sh | 162 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100755 t/t8010-bisect-algorithm.sh

diff --git a/t/t8010-bisect-algorithm.sh b/t/t8010-bisect-algorithm.sh
new file mode 100755
index 0000000..bda59da
--- /dev/null
+++ b/t/t8010-bisect-algorithm.sh
@@ -0,0 +1,162 @@
+#!/bin/sh
+#
+# Copyright (c) 2016 Stephan Beyer
+#
+test_description='Tests git bisect algorithm'
+
+exec </dev/null
+
+. ./test-lib.sh
+
+test_expect_success 'set up a history for the test' '
+	test_commit A1 A 1 &&
+	test_commit A2 A 2 &&
+	test_commit A3 A 3 &&
+	test_commit A4 A 4 &&
+	test_commit A5 A 5 &&
+	test_commit A6 A 6 &&
+	git checkout -b b A5 &&
+	test_commit B1 B 1 &&
+	git checkout master &&
+	test_commit A7 A 7 &&
+	git checkout b &&
+	test_commit B2 B 2 &&
+	git checkout master &&
+	test_commit A8 A 8 &&
+	test_merge Bmerge b &&
+	git checkout b &&
+	test_commit B3 B 3 &&
+	git checkout -b c A7 &&
+	test_commit C1 C 1 &&
+	git checkout -b d A3 &&
+	test_commit D1 D 1 &&
+	git checkout c &&
+	test_commit C2 C 2 &&
+	git checkout d &&
+	test_commit D2 D 2 &&
+	git checkout c &&
+	test_commit C3 C 3 &&
+	git checkout master &&
+	git merge -m BCDmerge b c d &&
+	git tag BCDmerge &&
+	test_commit A9 A 9 &&
+	git checkout d &&
+	test_commit D3 &&
+	git checkout master
+'
+
+test_expect_success 'bisect algorithm works in linear history with an odd number of commits' '
+	git bisect start A7 &&
+	git bisect next &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse A3)" \
+	  -o "$(git rev-parse HEAD)" = "$(git rev-parse A4)"
+'
+
+test_expect_success 'bisect algorithm works in linear history with an even number of commits' '
+	git bisect reset &&
+	git bisect start A8 &&
+	git bisect next &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse A4)"
+'
+
+test_expect_success 'bisect algorithm works with a merge' '
+	git bisect reset &&
+	git bisect start Bmerge &&
+	git bisect next &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse A5)" &&
+	git bisect good &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse A8)" &&
+	git bisect good &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse B2)" \
+	  -o "$(git rev-parse HEAD)" = "$(git rev-parse B1)"
+'
+
+#                   | w  min | w  min | w  min | w  min |
+# B---.    BCDmerge | 18  0  | 9    0 | 5    0 | 3    0 |
+# |\ \ \            |        |        |        |        |
+# | | | *  D2       | 5   5  | 2    2 | 2    2*| good   |
+# | | | *  D1       | 4   4  | 1    1 | 1    1 | good   |
+# | | * |  C3       | 10  8  | 1    1 | 1    1 | 1    1*|
+# | | * |  C2       | 9   9 *| good   | good   | good   |
+# | | * |  C1       | 8   8  | good   | good   | good   |
+# | * | |  B3       | 8   8  | 3    3 | 1    1 | 1    1*|
+# * | | |  Bmerge   | 11  7  | 4    4*| good   | good   |
+# |\ \ \ \          |        |        |        |        |
+# | |/ / /          |        |        |        |        |
+# | * | |  B2       | 7   7  | 2    2 | good   | good   |
+# | * | |  B1       | 6   6  | 1    1 | good   | good   |
+# * | | |  A8       | 8   8  | 1    1 | good   | good   |
+# | |/ /            |        |        |        |        |
+# |/| |             |        |        |        |        |
+# * | |   A7        | 7   7  | good   | good   | good   |
+# * | |   A6        | 6   6  | good   | good   | good   |
+# |/ /              |        |        |        |        |
+# * |     A5        | 5   5  | good   | good   | good   |
+# * |     A4        | 4   4  | good   | good   | good   |
+# |/                |        |        |        |        |
+# *       A3        | 3   3  | good   | good   | good   |
+# *       A2        | 2   2  | good   | good   | good   |
+# *       A1        | 1   1  | good   | good   | good   |
+
+test_expect_success 'bisect algorithm works with octopus merge' '
+	git bisect reset &&
+	git bisect start BCDmerge &&
+	git bisect next &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse C2)" &&
+	git bisect good &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse Bmerge)" &&
+	git bisect good &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse D2)" &&
+	git bisect good &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse B3)" \
+	  -o "$(git rev-parse HEAD)" = "$(git rev-parse C3)" &&
+	git bisect good &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse C3)" \
+	  -o "$(git rev-parse HEAD)" = "$(git rev-parse B3)" &&
+	git bisect good > output &&
+	grep "$(git rev-parse BCDmerge) is the first bad commit" output
+'
+
+# G 5a6bcdf        D3       | w  min | w  min |
+# | B 02f2eed      A9       | 14  0  | 7   0  |
+# | *---. 6174c5c  BCDmerge | 13  1  | 6   1  |
+# | |\ \ \                  |        |        |
+# | |_|_|/                  |        |        |
+# |/| | |                   |        |        |
+# G | | | a6d6dab  D2       | good   | good   |
+# * | | | 86414e4  D1       | good   | good   |
+# | | | * c672402  C3       | 7   7 *| good   |
+# | | | * 0555272  C2       | 6   6  | good   |
+# | | | * 28c2b2a  C1       | 5   5  | good   |
+# | | * | 4b5a7d9  B3       | 5   5  | 3   3 *|
+# | * | | a419ab7  Bmerge   | 8   6  | 4   3 *|
+# | |\ \ \                  |        |        |
+# | | |/ /                  |        |        |
+# | | * | 4fa1e39  B2       | 4   4  | 2   2  |
+# | | * | 92a014d  B1       | 3   3  | 1   1  |
+# | * | | 79158c7  A8       | 5   5  | 1   1  |
+# | | |/                    |        |        |
+# | |/|                     |        |        |
+# | * | 237eb73    A7       | 4   4  | good   |
+# | * | 3b2f811    A6       | 3   3  | good   |
+# | |/                      |        |        |
+# | * 0f2b6d2      A5       | 2   2  | good   |
+# | * 1fcdaf0      A4       | 1   1  | good   |
+# |/                        |        |        |
+# * 096648b        A3       | good   | good   |
+# * 1cf01b8        A2       | good   | good   |
+# * 6623165        A1       | good   | good   |
+
+test_expect_success 'bisect algorithm works with good commit on unrelated branch' '
+	git bisect reset &&
+	git bisect start A9 D3 &&
+	test "$(git rev-parse HEAD)" = "$(git merge-base A9 D3)" &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse D2)" &&
+	git bisect good &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse C3)" &&
+	git bisect good &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse B3)" \
+	  -o "$(git rev-parse HEAD)" = "$(git rev-parse Bmerge)"
+'
+
+test_done
-- 
2.7.1.354.gd492730.dirty
