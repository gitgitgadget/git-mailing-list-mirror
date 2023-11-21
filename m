Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="GIVCTEjW";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="Z0cWSU3p"
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5ACED45
	for <git@vger.kernel.org>; Tue, 21 Nov 2023 12:34:23 -0800 (PST)
From: "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1700598861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ogQdB7OZeVYFTrNMmrWnV7LdvywP2myruO1FDxORTCU=;
	b=GIVCTEjWO3mj0Bc203Fn4t8Nmk/3HMaM3KoP0OUdTY/4o2CaJMETdmDdsqztdntTFiDo41
	OD8HKWGADuB5dCv/J5d4aoR89KOBRz+qI9WAchVQcNhaZtF/nlgMJS80ZK5o3vMojlt362
	s81A3IL+BX45a/TOYBkkRRAwNS5T9kX9wGUWEWmNRqcE23+J4g3fFyrjx6wtWDAclobg/s
	Cga+NXzdKaeMFk6eGEH68J0MDP+gPtN8urTFxDUe5szTXeEKI7hPJPazoGakVH+LFZPX4q
	ODqPCUJ+QHewK8bnrPphWbycileLZxxCebkYyswdsazFMIl1oppRZTnJwQASmDFr3kwltd
	lu1xs2/ajepNj0ygjYSAFhsGy54vzhdsP9enaKLgzNhRYjzm2DoFg3k5uabEmktK1ysAep
	MjcrqomhQNQzrPcYykaw5fFAbxZpUIZHjsFBdpP3m8LpwDs8yNytWkSvwnAuCiv8+zm/3a
	m1SUoRQceShd4tlKjfnrZLEJb1BDP4hNt8z4/tWE26lzjM1vmavK4G1St4U2XNidvpb00R
	+nTHpE7cjkve92iupEIxm2vLVkRY+B+SwPeo7cPGi/ZkXcTbw3XcVv0GHEcbVIbQ04XRuU
	+9FM3g6l1a7BsPRbSXzZlpVfM8uuosXhUzNuNAZYzfnUOqgPPk4kY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1700598861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ogQdB7OZeVYFTrNMmrWnV7LdvywP2myruO1FDxORTCU=;
	b=Z0cWSU3pOmftOdZU0K4DMyt2yQjHVrlKDyAidvuSswVcQXqF97nVs+t9NQRwTHrYrgUzEO
	wiOvUv7gNzMVBSAg==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=heftig smtp.mailfrom=heftig@archlinux.org
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Shourya Shukla <shouryashukla.oo@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Denton Liu <liu.denton@gmail.com>,
	"Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
Subject: [PATCH v2 3/6] t7419: actually test the branch switching
Date: Tue, 21 Nov 2023 21:32:44 +0100
Message-ID: <20231121203413.176414-3-heftig@archlinux.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231121203413.176414-1-heftig@archlinux.org>
References: <20231003185047.2697995-1-heftig@archlinux.org>
 <20231121203413.176414-1-heftig@archlinux.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The submodule repo the test set up had the 'topic' branch checked out,
meaning the repo's default branch (HEAD) is the 'topic' branch.

The following tests then pretended to switch between the default branch
and the 'topic' branch. This was papered over by continually adding
commits to the 'topic' branch and checking if the submodule gets updated
to this new commit.

Return the submodule repo to the 'main' branch after setup so we can
actually test the switching behavior.

Signed-off-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
---

Notes:
    v2 changes:
        - fixed subject

 t/t7419-submodule-set-branch.sh | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/t/t7419-submodule-set-branch.sh b/t/t7419-submodule-set-branch.sh
index 232065504c..5ac16d0eb7 100755
--- a/t/t7419-submodule-set-branch.sh
+++ b/t/t7419-submodule-set-branch.sh
@@ -11,23 +11,28 @@ as expected.
 
 TEST_PASSES_SANITIZE_LEAK=true
 TEST_NO_CREATE_REPO=1
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
 	git config --global protocol.file.allow always
 '
 
 test_expect_success 'submodule config cache setup' '
 	mkdir submodule &&
 	(cd submodule &&
 		git init &&
 		echo a >a &&
 		git add . &&
 		git commit -ma &&
 		git checkout -b topic &&
 		echo b >a &&
 		git add . &&
-		git commit -mb
+		git commit -mb &&
+		git checkout main
 	) &&
 	mkdir super &&
 	(cd super &&
@@ -57,41 +62,38 @@ test_expect_success 'test submodule set-branch --branch' '
 '
 
 test_expect_success 'test submodule set-branch --default' '
-	test_commit -C submodule c &&
 	(cd super &&
 		git submodule set-branch --default submodule &&
 		! grep branch .gitmodules &&
 		git submodule update --remote &&
 		cat <<-\EOF >expect &&
-		c
+		a
 		EOF
 		git -C submodule show -s --pretty=%s >actual &&
 		test_cmp expect actual
 	)
 '
 
 test_expect_success 'test submodule set-branch -b' '
-	test_commit -C submodule b &&
 	(cd super &&
 		git submodule set-branch -b topic submodule &&
 		grep "branch = topic" .gitmodules &&
 		git submodule update --remote &&
 		cat <<-\EOF >expect &&
 		b
 		EOF
 		git -C submodule show -s --pretty=%s >actual &&
 		test_cmp expect actual
 	)
 '
 
 test_expect_success 'test submodule set-branch -d' '
-	test_commit -C submodule d &&
 	(cd super &&
 		git submodule set-branch -d submodule &&
 		! grep branch .gitmodules &&
 		git submodule update --remote &&
 		cat <<-\EOF >expect &&
-		d
+		a
 		EOF
 		git -C submodule show -s --pretty=%s >actual &&
 		test_cmp expect actual
-- 
2.43.0

