Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B18313E23
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444871; cv=pass; b=ed7cXrg95Ia5K0ScURhVDtQTQZE54+SWcdd/e5Ub0EN3+qrPdNYntX4eC6CgHZ5ltsmmwhRM4H9YyZtZBhFK9Hd67kucz69lrUxiIEn6jYu6e+tYmUv8z+HDd2qF3CPCbNVsPbu+9Hx6pr7i17ofXlkX7XBq0K6yujAXIvhWHO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444871; c=relaxed/simple;
	bh=TQ2NkXmHSojS46yiwt1XVmt+YcdKUwGfnZL144WU/J0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1Vnpn4isjj4iK7F1enZAPrnVf/u/vdUOHQLSKwtQPGgAZ80LAk/pgbK1qaNx6k2SL9ZfZr89WOc9FWWRX9A6iW5QnBUv/HO+sBjBH5bPMFzT2qDYmTAizYM5/A2d2wk6x6NTp2kwUID5eXIuH886lhtKlDyYHLFyIPBQX4ozdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=ZU5yocDO; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="ZU5yocDO"
ARC-Seal: i=1; a=rsa-sha256; t=1760444752; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eBo7iCvwx0UDnfYd8VKT+oRBHuXfidkc+B+i+rkqZGz5qiwUi7N8KRh0JczZlNEjGWuZeqwkRZFE+DTB6BWkSMyY0L1N7/nzHaEHKG/WhcrBBzv6JKZMCflOmVjyIEf7JmXyQ2c6olNoiK4YLCqxvmH3qcMVkbR0flJNFDdI5wg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760444752; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=GoIZOPmSZ3BY7hrcN83CejS9evX8Uu6QfkibIdyqGs8=; 
	b=P/3g0BXCK3HspcBIIv3x2kkDmvTUIdoO002/WJ4+wRaJcHzRCtpF0R8URmgFeDSFXUuxRDTU+cxcKKAezwDm1Fn00fIfIotGg3a51xA9wI3wIaNDnmYcdx+d2l8wKjhhHPx4tXH72M3lfm0wCx0GzoB1tiFbuUgIdEYZDL6hkAc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760444752;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=GoIZOPmSZ3BY7hrcN83CejS9evX8Uu6QfkibIdyqGs8=;
	b=ZU5yocDO30HATgvIAts4MOzHSCEyCHS31ybm6aT/4GJSRyyB8DndJX4yU7dxDJrk
	PcOPe3wT2fdFK68p6L6ogRHb5UbYFQRSc1JRVMX+AuXnkpxu0Td3W507b7gOYBMn+Pn
	9vmyveTJiM89oFu0CvLqQxXLLAU9n/v8f7WoMxCY=
Received: by mx.zohomail.com with SMTPS id 1760444750230962.5039688574516;
	Tue, 14 Oct 2025 05:25:50 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v4 17/29] tests: t3440: create expect files at point of use
Date: Tue, 14 Oct 2025 20:24:30 +0800
Message-ID: <20251014122452.1851103-18-me@linux.beauty>
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

Created the expected trailer files within
the individual rebase tests that use them,
simplifying the shared history setup and
avoiding unused fixtures.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 t/t3440-rebase-trailer.sh | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
index c08a9c4abf..0c0185d058 100755
--- a/t/t3440-rebase-trailer.sh
+++ b/t/t3440-rebase-trailer.sh
@@ -26,14 +26,7 @@ test_expect_success 'setup repo with a small history' '
 	git checkout -b conflict-branch first &&
 	test_commit file-2 file-2 &&
 	test_commit conflict file &&
-	test_commit third file &&
-	ident="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" &&
-	create_expect initial-signed  "Initial empty commit" &&
-	create_expect first-signed    "first"                 &&
-	create_expect second-signed   "second"                &&
-	create_expect file2-signed    "file-2"                &&
-	create_expect third-signed    "third"                 &&
-	create_expect conflict-signed "conflict"
+	test_commit third file
 '
 
 test_expect_success 'apply backend is rejected with --trailer' '
@@ -74,6 +67,7 @@ test_expect_success 'multiple Signed-off-by trailers all preserved' '
 '
 
 test_expect_success 'rebase -m --trailer adds trailer after conflicts' '
+	create_expect file2-signed "file-2" &&
 	git reset --hard third &&
 	test_must_fail git rebase -m \
 		--trailer "Reviewed-by: Dev <dev@example.com>" \
@@ -85,6 +79,8 @@ test_expect_success 'rebase -m --trailer adds trailer after conflicts' '
 '
 
 test_expect_success 'rebase --root --trailer updates every commit' '
+	create_expect initial-signed "Initial empty commit" &&
+	create_expect first-signed "first" &&
 	git checkout first &&
 	git rebase --root --keep-empty \
 		--trailer "Reviewed-by: Dev <dev@example.com>" &&
-- 
2.51.0

