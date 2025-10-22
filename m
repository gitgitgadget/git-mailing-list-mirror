Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167912D73B9
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111827; cv=pass; b=bJC+DEAUWboqXiS3KPm1XUVVqbbBnJQ+L7AeH019J+1mNylG3HfVsXGzOG7zvNKJQVjU+VQ71kxrDpQJCkrvVZ6uZrGEHC1WA2pjrRN7rTGomMKsMkLQVRkht28EXQ6e3vrocoquqHvrkoWUV7FJ6hv/f39CGDzJWy5ZBc7EfAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111827; c=relaxed/simple;
	bh=rGT2q2D07askXqTUEsAlVFLGx5xF80ZJxxrMRRqKAAo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3+fP3Uypfy65lW6VPezmBvmcD4dt4N5Lisul/kTqz6k5F1c8SPiOHTdJ1WkJqYcS+FHixUILc8iToZj7sW1xzNZHGYzrc7b+Hkx4GGUyOza8VJtqEVWscqcdXJylm4/WRbyEqnXHfEECSxXxS9rQRoPzhhn5eCCcF4zC9NrwR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=fd5Elbhw; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="fd5Elbhw"
ARC-Seal: i=1; a=rsa-sha256; t=1761111639; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hgjI1XnmIol1TBdq/wq0BkOt1ZaWP4LhquG7aaesn4POmhXDYZ7QQZ4dPp2xZ9FBhkODP1Uowsh/3hLm4Ah2OdV8rtVZ8EnivfQVSWle2pjFB6RmFik/gGeaBtJgfaOgXJvSP5429Y8SzurcIwVCHcvyt5SR7CbAtR4UOOpQqTs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111639; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=rRg1H0gekSaRvu+GrE13fz2gSKE0iM2ep3fRPdX1B4Y=; 
	b=m5OUtfe2jL5mtRUOaSCOR3RGt5Z51EIVGtjmk5VqTUFB0/TPIa1vYMy8Vo//4jIYgjeq+wZWvaIC+SMscI01nAz3Y8DFBD6E2ROqAPdB9D6EC8RSLmdO+LdosDm2SYNGCwPmp09L/6LlkplRKlUBygAdYI95CGUtP8S9DlVegb8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111639;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=rRg1H0gekSaRvu+GrE13fz2gSKE0iM2ep3fRPdX1B4Y=;
	b=fd5Elbhw5niGgJ8/KPSzoW8PeQboCgPD0IRBcAWVOTcGOkdb3c69z1aaD2o70a4v
	7t7qLiAAS/y/TddtwxDJFmNhIZZNGL/5lYV6dkEVIvjrQe6EAg2dp9vC0OmESEo2RdG
	9DjrN52F+uZrL+UpIuwRGDqDeylNVho2LzMsk6jQ=
Received: by mx.zohomail.com with SMTPS id 1761111637005542.6940353932687;
	Tue, 21 Oct 2025 22:40:37 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 20/29] t3440: drop redundant resets and pass branch to rebase where needed
Date: Wed, 22 Oct 2025 13:39:40 +0800
Message-ID: <20251022053951.602605-21-me@linux.beauty>
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

From: Li Chen <chenl311@chinatelecom.cn>

Stop hard-resetting to third in these tests. Where the branch matters,
invoke git rebase -m ... HEAD~1 third to make the target explicit and
preserve the original semantics.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 t/t3440-rebase-trailer.sh | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
index 1571dd2c97..504bdd86fc 100755
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

