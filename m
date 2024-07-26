Received: from impout003.msg.chrl.nc.charter.net (impout003aa.msg.chrl.nc.charter.net [47.43.20.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22CA176AB3
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981874; cv=none; b=UR2qEjRk+7PSdWSPhTzICuOcZ69VRatmu8ueLdv2nmJ8+Homl6MrzF5/5P3qLL95aT/+B4UWy/JP3fCm03DkYza3feSqRrSHTP87vx+qUbbhSPGR4SkIWa9noqPkZfySY5PvMb5uxmgAhv7Ek1/or6fO2TrMIuxv3LCZlnhQIl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981874; c=relaxed/simple;
	bh=yYQ7iwQgtZohuEsFFW9qx5CQe8gGMAJVekBILsKL9Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkQv73GumRQ7yqlV+fVC/T1JR09lXrCUw7oQL2iIlv39RefVdKeBjCKVyZfJGooJjhb+tjjlNBNKl6mxKjoV55cQ+sgv5/TuGHmS1CULVLAMs0yYlM0Dpi2mtQPcbDYH8TuE5ppYZr5d6SZudATa0taO52ez7E5XhSrfBNfnf0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=Ey5gQ3kn; arc=none smtp.client-ip=47.43.20.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="Ey5gQ3kn"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id XG7MsyipKvFCWXG7ZsRqj3; Fri, 26 Jul 2024 08:16:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1721981773;
	bh=yYQ7iwQgtZohuEsFFW9qx5CQe8gGMAJVekBILsKL9Bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ey5gQ3knBxQPc6Zxadx3voSy3QO3fpnqYhkjTB0GvRWRd6dIyr3/NFgtD/jxk4Y+W
	 D2rHUVHoNO15XwSmdQFqN84oJvZgysONzwBedXIHQbM2u4C+EKYBzOarG5lgwNnFqr
	 9XK+kb228QunOzjTmnleOQDqSdFs/CpNMajHIWODb+B7dpXm7yPjmbeybj/WblGAyv
	 bmVaw/qcWhnCvQrVydG0vW2T3HasFekrfHOr7zLRk0Iu641PbxbDe0EeL57sbRPOQO
	 bbFB8mUwpsgYaQ3ifuGZ2ttLqUwRJIXd1EOk4zxicgJ27facteFLnLnd84zX94ttbd
	 2j9NiT8TJ3PlQ==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=O+w/vg9W c=1 sm=1 tr=0 ts=66a35b4d
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=A1X0JdhQAAAA:8 a=g-X_pVf7e692ChHf-W0A:9 a=jYKBPJSq9nmHKCndOPe9:22
 a=Df3jFdWbhGDLdZNm0fyq:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/5] t3430: drop unnecessary one-shot "VAR=val shell-func" invocation
Date: Fri, 26 Jul 2024 04:15:18 -0400
Message-ID: <20240726081522.28015-2-ericsunshine@charter.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726081522.28015-1-ericsunshine@charter.net>
References: <20240722065915.80760-1-ericsunshine@charter.net>
 <20240726081522.28015-1-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIRDs6Davw2aWHZtwOmj7fCu2dRTcTfecn094yLQcuIHWLubkDiIfVughfkcgbqQhkjMCvT6vwtT02OzPDBBnin0vqgBPhYDKbWyGgGRoxg/ti/Cx0+w
 bfkCBcItcolPIrBEzmjVB55kS0GYWkIj2HEdfBguVxCWQbCXZJxA3gDOmVfkWK7MGk5XX6+SwVV9UL0GfRo0/z8f9xmb1gxiuig6FvGTaRgInCed72SgcLUE
 BKFjYWBSVnvmKl4u2PjxydS/jbGlOfFYJDwG6aooKBhyp76uuKEWBD8HWvbhlU9qGMjWpAe7e9EZM5L37ohBprtRDnhxDlNbgtqWZV+Hv7OOz5qB/oKfMjX7
 ms0BJPG2

From: Eric Sunshine <sunshine@sunshineco.com>

The behavior of a one-shot environment variable assignment of the form
"VAR=val cmd" is undefined according to POSIX when "cmd" is a shell
function. Indeed the behavior differs between shell implementations and
even different versions of the same shell. One such ill-defined behavior
is that, with some shells, the assignment will outlive the invocation of
the function, thus may potentially impact subsequent commands in the
test, as well as subsequent tests. A common way to work around the
problem is to wrap a subshell around the one-shot assignment, thus
ensuring that the assignment is short-lived.

In this test, the subshell is employed precisely for this purpose; other
side-effects of the subshell, such as losing the effect of `test_tick`
which is invoked by `test_commit`, are immaterial.

These days, we can take advantage of `test_commit --author` to more
clearly convey that the test is interested only in overriding the author
of the commit.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t3430-rebase-merges.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 36ca126bcd..2aa8593f77 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -392,8 +392,7 @@ test_expect_success 'refuse to merge ancestors of HEAD' '
 
 test_expect_success 'root commits' '
 	git checkout --orphan unrelated &&
-	(GIT_AUTHOR_NAME="Parsnip" GIT_AUTHOR_EMAIL="root@example.com" \
-	 test_commit second-root) &&
+	test_commit --author "Parsnip <root@example.com>" second-root &&
 	test_commit third-root &&
 	cat >script-from-scratch <<-\EOF &&
 	pick third-root
-- 
2.45.2

