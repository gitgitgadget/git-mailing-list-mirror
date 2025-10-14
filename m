Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD02B313546
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444956; cv=pass; b=N7GntjZUowQ9PbLP0/JzBahRYqGZJb/uWIU515i7W03BaWvpJOSRuz2XDE3SquTrTre5u6XE84AUEwG44UMt6ZKYJ4rqnu4nk9yCVGvGGRIJ/wlUo5xHMOhtAi5CWvKJmbKdyx7RF1OB0UfLwhTil3x5i35KkOOXpekinXdclsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444956; c=relaxed/simple;
	bh=nMPlY0ASWzjtfH9AiCqN0dJ8DWOmJOdek9D9G5jj0V4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+Kh4F4MIOdbQbcDCBXF1FqmAfBgriVgemruTi5bXqS0v4m9oTyoH50ai7ml+fabS+dBYlM93+ip+vDCqDONCXrQYKcPFYqIKVuvwQfZjtSy+ZIc+7svxLvUUsrJrPhr8lE4e4QStTyUj1jBBThy/+edL+rwPd0879NLKLWHHkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=H09kBNoS; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="H09kBNoS"
ARC-Seal: i=1; a=rsa-sha256; t=1760444783; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nbnumkbQftDRSJ82nBoB7luefhITBFApkCrkj0mkeNvvMLaObH+S00/ugKQMuloG9I14ZamZomhN0ddYca5EOpwa0I7Od7jgeTYLP8wsbofnCFlqUXq+r/VppREzcx84+Uys2tlaQgrGQLOZTcK/5QOZLFVplvMbk50PC8pGYCk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760444783; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=lNVY0oBogjHVOHU+HYAWtzoVqIRQpPqyQyHNyPNMUi0=; 
	b=ZX29Uw/PGlsPN7h6mP6tQVjFgIS1B9JE14BlGkDJg9h/1cRNqbD/Lu7OPvgrknt0/tlKHRdWYCSKypFmKbhDUTpjusqEOgtZjozGtAKueguqMwCjdeF8JQ0Qa/6pj+12GGzvuFsCkrrgTZZUYyX7mb4GLKkhNmrU1EWprlTEzSM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760444783;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=lNVY0oBogjHVOHU+HYAWtzoVqIRQpPqyQyHNyPNMUi0=;
	b=H09kBNoSL4J2umFgvu6/mJWkuLReLisCcgqGm8V0QJjYN1C50J/qhoUnbDoEEpjx
	97wmdmBvR7nWY2UojF5soqbUQPdGfwP9aOLR9scLj80qLOWNuaJ+HVsjwCJx7tQLg6W
	R1irb13PTx2ZIOSUbdvQ2eYotJPh4pTY/Gg1iR6k=
Received: by mx.zohomail.com with SMTPS id 1760444781802302.6844950925014;
	Tue, 14 Oct 2025 05:26:21 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v4 27/29] tests: t3440: ensure trailers persist after rebase continue
Date: Tue, 14 Oct 2025 20:24:40 +0800
Message-ID: <20251014122452.1851103-28-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014122452.1851103-1-me@linux.beauty>
References: <20251014122452.1851103-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Rebuilt the conflict test branch, added a fourth commit,
and asserted that both the conflicted and subsequent commits
receive the --trailer data in t/t3440-rebase-trailer.sh.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 t/t3440-rebase-trailer.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
index dd703b0eb7..7a2ddb440e 100755
--- a/t/t3440-rebase-trailer.sh
+++ b/t/t3440-rebase-trailer.sh
@@ -85,13 +85,16 @@ test_expect_success 'multiple Signed-off-by trailers all preserved' '
 '
 
 test_expect_success 'rebase -m --trailer adds trailer after conflicts' '
+	git checkout -B conflict-branch third &&
+	test_commit fourth file &&
 	test_must_fail git rebase -m \
-		--trailer "$REVIEWED_BY_TRAILER" \
-		second third &&
+			--trailer "$REVIEWED_BY_TRAILER" \
+			second &&
 	git checkout --theirs file &&
 	git add file &&
 	git rebase --continue &&
-	expect_trailer_msg HEAD "third"
+	expect_trailer_msg HEAD "fourth" &&
+	expect_trailer_msg HEAD^ "third"
 '
 
 test_expect_success 'rebase --root --trailer updates every commit' '
-- 
2.51.0

