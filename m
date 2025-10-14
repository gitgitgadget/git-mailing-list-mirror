Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CA0313E3B
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444896; cv=pass; b=Z/GO8up5PiNx0bf4OfbiE+8bKEZklKcOKeO/HwtV8gR/W6vNRsMZkrf8juxI72/PuUgBLq7z2HTtFr7enfCk285J3AMSaQdhrpkqeAFvAtIdlZDqZ/0DzZN4YMJ5i2qIwaPZlX8cgvz/80sAtaVBCMd5KeCcwtXZQCYQvX3IDkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444896; c=relaxed/simple;
	bh=OCZqDw7vSLjM04HoskukyoddgRuLLYd4ADx/Fd0yd68=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VlxR03Ruw/umYv8fJWg9UG8Qz9uCY/WBZzOvPRuscZgJ2tmEW5Bg40puND04bBTDIYIJHPJwElYMz3nSoOrbMktazmKchjanjBm9/WqUX9lqA6EYtbR0tgkFcAEH2aWG/vfeVGKUpLWLFTsGsdP31r0eOKpcRceZWob68EQcUew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=hfeyMFqi; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="hfeyMFqi"
ARC-Seal: i=1; a=rsa-sha256; t=1760444764; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j71O/UZSRqgMmnX2bjgQ0d0KHwB1kPz0OS1vGxS5KNHYzAtHJNN7nBXmLErHMZBkOXR3I7PghWX8f0lmpUKXY3UPJAK6U9/fgGDm6WnqMthCCJfe9IXaEWi+LDophl3ZgGSTnUmlaZHjYmnB4FIRID6lS7mDd2glqhcYvsdjAEk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760444764; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=fkszlJIiXa5uqy5CsF7T1m9FhC4mSXFDpK36PD8Y+1E=; 
	b=Uo1icV374nNl2qcKUvPTPG/QkQi6XN9HRom87VncKexGeF3CWgC5QiYAW3+GoS7G4SfXkIMdrU++Hu6aPcU1hBkn9QCAO+sgD6DqzgftjsuGjYjue63KnrTqV35g708r9U96QugYixdFSCDysS0GfXEBng8NWmPVM4H/Y4Ih2mc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760444764;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=fkszlJIiXa5uqy5CsF7T1m9FhC4mSXFDpK36PD8Y+1E=;
	b=hfeyMFqikVs2eVZoGzICUwPrYrdWooPUw2gSrxZX6++jFtHPrbwsp/C0t7RuywI7
	fn8t7H85nEjX0hjEjiIkQPYzJLdIvNjKlFmaqNVtozd62NW4wUVQWNigfZLRoa7Eib6
	8XP2xzZa2qRE9jHqyoC8R8qZWkexkAxCMVY8JN8Y=
Received: by mx.zohomail.com with SMTPS id 1760444756784145.25388917199564;
	Tue, 14 Oct 2025 05:25:56 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v4 20/29] tests: t3440: drop redundant resets and pass branch to rebase where needed
Date: Tue, 14 Oct 2025 20:24:33 +0800
Message-ID: <20251014122452.1851103-21-me@linux.beauty>
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

From: Li Chen <chenl311@chinatelecom.cn>

Stop hard-resetting to third in these tests. Where the branch matters,
invoke git rebase -m ... HEAD~1 third to make the target explicit and
preserve the original semantics.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 t/t3440-rebase-trailer.sh | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
index 16b059c2c3..4f313654d6 100755
--- a/t/t3440-rebase-trailer.sh
+++ b/t/t3440-rebase-trailer.sh
@@ -39,21 +39,18 @@ test_expect_success 'apply backend is rejected with --trailer' '
 '
 
 test_expect_success 'reject empty --trailer argument' '
-	git reset --hard third &&
 	test_expect_code 128 git rebase -m --trailer "" HEAD^ 2>err &&
 	test_grep "empty --trailer" err
 '
 
 test_expect_success 'reject trailer with missing key before separator' '
-	git reset --hard third &&
 	test_expect_code 128 git rebase -m --trailer ": no-key" HEAD^ 2>err &&
 	test_grep "missing key before separator" err
 '
 
 test_expect_success 'CLI trailer duplicates allowed; replace policy keeps last' '
-	git reset --hard third &&
 	git -c trailer.Bug.ifexists=replace -c trailer.Bug.ifmissing=add \
-		rebase -m --trailer "Bug: 123" --trailer "Bug: 456" HEAD~1 &&
+		rebase -m --trailer "Bug: 123" --trailer "Bug: 456" HEAD~1 third &&
 	cat >expect <<-\EOF &&
 	third
 
@@ -63,10 +60,9 @@ test_expect_success 'CLI trailer duplicates allowed; replace policy keeps last'
 '
 
 test_expect_success 'multiple Signed-off-by trailers all preserved' '
-	git reset --hard third &&
 	git rebase -m \
 			--trailer "Signed-off-by: Dev A <a@ex.com>" \
-			--trailer "Signed-off-by: Dev B <b@ex.com>" HEAD~1 &&
+			--trailer "Signed-off-by: Dev B <b@ex.com>" HEAD~1 third &&
 	cat >expect <<-\EOF &&
 	third
 
@@ -78,7 +74,6 @@ test_expect_success 'multiple Signed-off-by trailers all preserved' '
 
 test_expect_success 'rebase -m --trailer adds trailer after conflicts' '
 	create_expect file2-signed "file-2" &&
-	git reset --hard third &&
 	test_must_fail git rebase -m \
 		--trailer "Reviewed-by: Dev <dev@example.com>" \
 		second third &&
-- 
2.51.0

