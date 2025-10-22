Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A102D0C63
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111897; cv=pass; b=MApMvd5y/68EFBb3Jxlwnymc4bZMv3aI5iQ/yhTQonLXTaQkNwUQsERREyoNu9iBWPYV/C8wLEgqBCrrIeerZl2Jo/IEy/9lHc+AlvfZ9LILvDrDQVRWkazX8YUsdp5YPb5zDnsdV2WEoJUGovM9Xli+1yWK0FrsP+pW+JNj3Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111897; c=relaxed/simple;
	bh=fgVcSN0ec37KizjiDOM8+k32rvq3iOjGg/Kefifx7xk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnVDK6sw+7iqnyvhkjYVys1+AsewJQj81Bqxg/p9A5gym8QKiHn7BHtXGG1C98CqqCzt5b9WwYLmFPJ14+AFfZgs0gp4by9qg+V24ZXtFpmRkiykSS1aHIXdxCAfMsvJFSNGGaUEx19GhWdvzZ2cBnpqS6v7+zwJlSm2XYcDXD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=sd6gtGe/; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="sd6gtGe/"
ARC-Seal: i=1; a=rsa-sha256; t=1761111653; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jhQVE/o00E0zXsWhTGW90hpDQBn7X4YFzAtdQAGVoGi0HxAx8mlfyEee6vklvCmY4ECa+74veaMnBBSWemvwNSahbHOz2wacLEDOi+YxRZ2rhXChgZVIBE1VGqs9YzQOJAUgDLuEBDJcbVTZFaPtMevQe16ZtDccNJJNGIc0EGE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111653; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=v16qO9wPw5HDD/U4uBTMy9UwukuP53iG0AjnoxgxoHU=; 
	b=VnTsk0Huif8Hltuv5/5AfpDAaCOT44G3zBf0i8nDBae/jaWPaUnNrgndOcbtBSLqtKb4IGbAKI2lD0zL4F1LgGgF9OUGaSgfKNZe6Zc9Mrx/cXqaFoaZKVGl4c91tF4HCKdLfZ7eAP1O8QEua9HDhrH8t/KT+wsyUzA4v4JfDC4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111653;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=v16qO9wPw5HDD/U4uBTMy9UwukuP53iG0AjnoxgxoHU=;
	b=sd6gtGe/iqYS4kRV71MJtdHwBIlVJHCYgdsT35Lm0P9FI9bPdsElfqNT84X+veEn
	Z9NsiQjA6+KoMiCxNXzrA/ITJdcxVatVzovgXdgYWLmSUH873vf656MQVqaiLDI6LK2
	OaBVlfUOXSzt9emnwuEE3izehbqLU2f4iiYHJYhs=
Received: by mx.zohomail.com with SMTPS id 1761111651340256.45677673081616;
	Tue, 21 Oct 2025 22:40:51 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 27/29] t3440: ensure trailers persist after rebase continue
Date: Wed, 22 Oct 2025 13:39:47 +0800
Message-ID: <20251022053951.602605-28-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022053951.602605-1-me@linux.beauty>
References: <20251022053951.602605-1-me@linux.beauty>
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
index bea98d08c6..35d2054716 100755
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

