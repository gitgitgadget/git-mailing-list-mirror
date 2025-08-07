Received: from outbound.mr.icloud.com (p-west2-cluster6-host12-snip4-1.eps.apple.com [57.103.70.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F8125B311
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.70.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754579221; cv=none; b=W4xsT+CJ2J84DBLQhD4JZWTBsYRmxSiPQo8AwKt+d1CdK2dt/Yie76waP/UwRpB03FshjeKH3lYmAyUMS7DN91nY5Fg9zx3WpqStiNA71q2SjYD1gl63aPePtuvm8Gp8XdkY+gFW3h/GGf/Cr7NM4K3JVo6xTqJ/DTw48voOLVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754579221; c=relaxed/simple;
	bh=sEAgP34mv2ScwExR6hwmXn58G47Tvau4fCjJTuWOLRM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kLn2lDVe0IVHVq1jrWmDmjIEaDuakBZGWLrH1d9zS0cXbNCkVSKScjoL3HU9chJA3s+9ZftzoaKk8ObTG0jihH6Gk8+NPDPXRPgMORuJUW1cUwnWJgm3qRIlVjLC0f4MnWKnkBbkJj6TYeXFNIvJHO3EIR9AAYbyJJAgvI+LY5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gregoirege.is; spf=pass smtp.mailfrom=gregoirege.is; dkim=pass (2048-bit key) header.d=gregoirege.is header.i=@gregoirege.is header.b=uL23Yplf; arc=none smtp.client-ip=57.103.70.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gregoirege.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gregoirege.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gregoirege.is header.i=@gregoirege.is header.b="uL23Yplf"
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-10-percent-2 (Postfix) with ESMTPS id 0BBB41803854;
	Thu,  7 Aug 2025 15:06:57 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gregoirege.is; s=sig1; bh=3/P4gyrmOaD4yRnyxB0yNJJDsKEL9ZF+/W91CNdyzTc=; h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme; b=uL23Yplf153OugH7UJ32HO5f5xDx4FWxvDhuD0T7pymhM2mEOKkx4SOO0EpDPG/KKrGSkaEGxny2LYkrdAsShK433s1ZWcUJxgkkc5OCfRDnyalgWP9c/abRSrjxh8W+93yI0NKFvgwe74LbfM7Cyp1nC1ure9UqgZIDk+PT79nv/apnBfJcdJCanIgV/2N2HlSYKUhPWy39JqF087hJjXLDaKlSW569007SFu4CKb1v6/OH8Bo3o0E5pqqLTzfHDsMZ0jCXMCF63Hm/d6mZTDoLaMq/J5nIF2S167pqL0x2u7Mm8pVw/ew4y2B6yChPjn//UoP09F+/Qxf8Ws1jNw==
X-Client-IP: 118.221.50.200
Received: from localhost.localdomain (mr-asmtp-me-k8s.p00.prod.me.com [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-10-percent-2 (Postfix) with ESMTPSA id 0163B1803876;
	Thu,  7 Aug 2025 15:06:56 +0000 (UTC)
From: Gregoire Geis <opensource@gregoirege.is>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Gregoire Geis <opensource@gregoirege.is>
Subject: [PATCH] diff-no-index: fix stdin path in subdirectory
Date: Fri,  8 Aug 2025 00:06:13 +0900
Message-Id: <20250807150613.32177-1-opensource@gregoirege.is>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: g1zrvL__495jBRptJNBwiQ0cy4kHETZj
X-Proofpoint-ORIG-GUID: g1zrvL__495jBRptJNBwiQ0cy4kHETZj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDEyMyBTYWx0ZWRfXzQKaZVSQ/3PD
 bD8oHgVc/JP1tiqHrgw5TEfm65xhylTF8FO25miPNKjfzI19G2i6JuKW3qKnZw25JTEKHJJRigi
 bMT6x3bizFpmqg6mGUtxPbchlpIRKITWvYehSj3A84bkX7eTl6XG+xlNdLgn8kqucEtByQEYzXE
 5gUBONeSd6y5okpetCli69k+94XfwPPF1dW6tl0xVnsR0GjJIksuDng6VlKyzqbzcNu4qlMvUoJ
 qNmaVw9E3cksuHerg9/2Jtu6FBRDZcg3bU85xMIWP3zwpsEEFg2mN+gaLB3Ozq7K9ZogPYgsI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 phishscore=0 spamscore=0 malwarescore=0 clxscore=1030 mlxscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2508070123

`git diff --no-index` tried to normalize paths before printing them,
skipping a prefix before reading a string. However, `-` doesn't start
with this prefix, leading to a buffer overflow:

$ make SANITIZE=address
$ mkdir a && cd a
$ echo a | ../git diff --no-index /dev/null -
=================================================================
==14536==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x60b000001f92 at pc 0x000102612a30 bp 0x00016db386d0 sp 0x00016db386c8
READ of size 1 at 0x60b000001f92 thread T0
    #0 0x102612a2c in diff_flush_patch diff.c:6154
    #1 0x10260dbfc in diff_flush diff.c:6829
    #2 0x1025f218c in diff_no_index diff-no-index.c:422
    #3 0x102356338 in cmd_diff diff.c:501
    #4 0x1022cc780 in run_builtin git.c:480
    #5 0x1022c9bec in handle_builtin git.c:746
    #6 0x1022c8670 in cmd_main git.c:953
    #7 0x1024fe230 in main common-main.c:9

Signed-off-by: Gregoire Geis <opensource@gregoirege.is>
---
Hello!

I noticed that running `git diff --no-index /dev/null -` in a
subdirectory leads to garbage file names (instead of `a/-` and `b/-`).

Valgrind and ASAN confirmed that this is a heap buffer overflow. I
fixed it by checking against "-" when writing the file names in the
patch, which leads to results similar to using an absolute path (e.g.
`a/dev/stdin`, `a/-`, no matter the working directory). "-" is a
special input for `git diff --no-index`, so I don't think we need any
kind of normalization before this check.

I added a test which currently fails on `master`. I chose a
subdirectory `aa/bb/cc` to make sure that the path is long enough for
garbage to appear even if git is compiled without ASAN.

 diff.c                        |  4 ++--
 t/meson.build                 |  1 +
 t/t4072-diff-no-index-dash.sh | 17 +++++++++++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)
 create mode 100755 t/t4072-diff-no-index-dash.sh

diff --git a/diff.c b/diff.c
index dca87e1..88e93e5 100644
--- a/diff.c
+++ b/diff.c
@@ -4626,12 +4626,12 @@ static void diff_fill_oid_info(struct diff_filespec *one, struct index_state *is
 static void strip_prefix(int prefix_length, const char **namep, const char **otherp)
 {
 	/* Strip the prefix but do not molest /dev/null and absolute paths */
-	if (*namep && !is_absolute_path(*namep)) {
+	if (*namep && !is_absolute_path(*namep) && strcmp(*namep, "-")) {
 		*namep += prefix_length;
 		if (**namep == '/')
 			++*namep;
 	}
-	if (*otherp && !is_absolute_path(*otherp)) {
+	if (*otherp && !is_absolute_path(*otherp) && strcmp(*otherp, "-")) {
 		*otherp += prefix_length;
 		if (**otherp == '/')
 			++*otherp;
diff --git a/t/meson.build b/t/meson.build
index bbeba1a..9042f3f 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -486,6 +486,7 @@ integration_tests = [
   't4069-remerge-diff.sh',
   't4070-diff-pairs.sh',
   't4071-diff-minimal.sh',
+  't4072-diff-no-index-dash.sh',
   't4100-apply-stat.sh',
   't4101-apply-nonl.sh',
   't4102-apply-rename.sh',
diff --git a/t/t4072-diff-no-index-dash.sh b/t/t4072-diff-no-index-dash.sh
new file mode 100755
index 0000000..35170a4
--- /dev/null
+++ b/t/t4072-diff-no-index-dash.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+test_description='`git diff file -` does not crash'
+
+. ./test-lib.sh
+
+test_expect_success '`git diff --no-index /dev/null -` works in root' '
+  echo foo | git diff --no-index /dev/null - | grep "a/- b/-"
+'
+
+test_expect_success '`git diff --no-index /dev/null -` works in subdirectory' '
+  mkdir -p aa/bb/cc &&
+  cd aa/bb/cc &&
+  echo foo | git diff --no-index /dev/null - | grep "a/- b/-"
+'
+
+test_done

base-commit: 64cbe5e2e8a7b0f92c780b210e602496bd5cad0f
-- 
2.48.1

