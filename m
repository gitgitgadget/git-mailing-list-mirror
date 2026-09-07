Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84752525A8D
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 20:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788811203; cv=none; b=Gg2R2WKoohq2S3LID6UMMecQIMEyZe8doDufkmL5249SUBQ2dIckW+iY5409sjxTyLDed0OmaMWvOv4O6k00gXhxN8r+ab1YadZ9DK7S3Y1hT0nZv1F2sHkKpqLeMjmOKV7eY/++GwRKbasL51I47k9AQj+MbbMEnQixw/hZz7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788811203; c=relaxed/simple;
	bh=YqfSkbOrK1uNpeBgJjAs2W2lpzUQFVP9LkCb59gVCf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CY6aBoUailmXAnWCjMNn0GxT8Ji0aVV7emp/asbj6cxx3fBv6VsiKninL0/urVT3yxsprmiZeejsJoqme2SnL6ckBi+kKsUR0FLA6miHgtrs4LUVmeNYV2Y13l2tCvysVM9rbKgiO9Sb9LUOSF7GYLr1JDAJVqDQ+VrcZJmgvew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=m6vF+jBX; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="m6vF+jBX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1788811198;
	bh=YqfSkbOrK1uNpeBgJjAs2W2lpzUQFVP9LkCb59gVCf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=m6vF+jBXtW8TDZZYrFcquIcSumru4l43FmKnFJ185er284vCcz3P/Ht/nMI5X+Le2
	 hR/Lg4+Q/8SN4ghtbBFbzmtoAet60OUGaWtYAAOw547qkxmgvOqsd/J7qeA/m8PDeE
	 32XeLgGUG/E8NQb5ew54iM0+QliG09pULF51tVzGB8DGVOaeqL6gRaIWaI5oUYy3aw
	 3mihiQExznYhmji9fqiluA/BUEHsGhWAEr/xY2ZwUrhH2sWpGRcVN2Vjaj6aCQMDuI
	 vbkEeum+2pLfNRSWfrEXJOMHWQjdqDzojfJ21gQWdBYkItHoBKdOnNDJ+4eolSvywD
	 si0Fw5JAMqo0oBe327Q8hxkm0pbEdN9K2xF63kkToUDaHOLFyKqartTwPvvB+w4dh/
	 ksSZHL51rzurHVzd/Sf6rIY+fBYt9adNMMYB83cow/zUsy4cj2335/iACtbphzjkUC
	 MJSNPl7L/wC6btjLxBZjTrrB8lWAQKsltXg1l6TR71SVO+aaiIh
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:7b23:2dc:c9d2:f0e4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4A43E231F1;
	Mon,  7 Sep 2026 19:59:58 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 6/7] t5324: adjust tests for corrupt commit-graph
Date: Mon,  7 Sep 2026 19:59:39 +0000
Message-ID: <20260907195941.1024289-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260907195941.1024289-1-sandals@crustytoothpaste.net>
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
 <20260907195941.1024289-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a future commit, we'll no longer allow uppercase object IDs.  When
that happens, t5324 will fail because the error message from corrupting
commit-graph files will be different.  The current test looks for an
error message that occurs when the commit-graph file has a name that is
parseable as a valid object ID but is not a valid commit-graph file
(which, on case-sensitive systems, is of course checked case
sensitively).

However, in the future, we need the object ID to continue to be valid,
and that means that the hex character we use must be lowercase.  In
SHA-256, though, one of the characters we want to corrupt is
legitimately already an "a", so switch to using the character "b" in
both of these cases, which is the correct character for neither SHA-1
nor SHA-256.  If we adopt another hash algorithm in the future, we may
need to adjust these values again.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5324-split-commit-graph.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index bf7ba0e558..53cddfe437 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -349,7 +349,7 @@ test_expect_success 'verify after commit-graph-chain corruption (base)' '
 		test_must_fail git commit-graph verify 2>test_err &&
 		grep -v "^+" test_err >err &&
 		test_grep "invalid commit-graph chain" err &&
-		corrupt_file "$graphdir/commit-graph-chain" 30 "A" &&
+		corrupt_file "$graphdir/commit-graph-chain" 30 "b" &&
 		test_must_fail git commit-graph verify 2>test_err &&
 		grep -v "^+" test_err >err &&
 		test_grep "unable to find all commit-graph files" err
@@ -364,7 +364,7 @@ test_expect_success 'verify after commit-graph-chain corruption (tip)' '
 		test_must_fail git commit-graph verify 2>test_err &&
 		grep -v "^+" test_err >err &&
 		test_grep "invalid commit-graph chain" err &&
-		corrupt_file "$graphdir/commit-graph-chain" 70 "A" &&
+		corrupt_file "$graphdir/commit-graph-chain" 70 "b" &&
 		test_must_fail git commit-graph verify 2>test_err &&
 		grep -v "^+" test_err >err &&
 		test_grep "unable to find all commit-graph files" err
