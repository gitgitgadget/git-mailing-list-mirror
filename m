Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="D5QeH1om";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="nfKIF2J8"
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A497A1BB
	for <git@vger.kernel.org>; Tue, 21 Nov 2023 12:34:23 -0800 (PST)
From: "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1700598861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/0cbsbQsQfiWMxFvLmpfXnoIjIAhS5qAiOzTgiyLLA=;
	b=D5QeH1omKZvD1kAlCMx337Q1y8xn7jkocXghUNT5jDMgyx0vfmfCvanclY0QomJPXjb4uQ
	uU20WPiSmJ4Opy0U9LdFSNcBFu9A/lrEh+RHs7STltwWPdEny+9kR55seUOFYGM1grBJ6s
	RU5Y5e5jYUOtdKxLp27Y3gxV0iSAy886VwbwUOXJhVFYz82B14/WqYpqLhbPQl7RDB+bHM
	eoRjw7EhIkmlDfufxJLCXNZaEbPIVpkgUUc5uZ5S/D789hzaFtAcHGcLV59BTPObXOgSo+
	ObKkQtIQTnOlHaXisgSQBHMd8vwBZkxZKXTuBAlHFy/v+Tby1ISOHh5/85I4tuI+LwXNte
	p05Bgf0N0grDZdj4CbDrzuKUz9LFGHuaiuUxNAAufHotCg7mF+TmQM/ZjAkv1O1CzV0S/U
	kAQ99kh54LVfS2jhrtvsRwnGH/Tfcj3uxCiCjctb45BisAPiDIp1/l16uzP9Ai8RHr/WNn
	3NPHhXuNv1THKWSCboHcYpIgXcKzedW5iGAPwv0I0u5srgasOjHw1rO9L22fCI9SEGO5Y1
	ZpYkS+kQjI/H0+AlbQvAgV3jwnxLjUBZPJBzkTqIOcJ8P8yMifN5GQdYEvQWlrP4MiYeLS
	nug11hM0pGWPGsUVNGEAHQDq71H+Nc7U1PtbMhnu4Pd87DM3mikuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1700598861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/0cbsbQsQfiWMxFvLmpfXnoIjIAhS5qAiOzTgiyLLA=;
	b=nfKIF2J8o5f6y9YiYwz4TrPTf5BNoDupys6vO4D3Wo0J8jn8bM7xOxtjERHVhPCtuDwW+s
	tJhyJEt8tKi99YAQ==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=heftig smtp.mailfrom=heftig@archlinux.org
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Shourya Shukla <shouryashukla.oo@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Denton Liu <liu.denton@gmail.com>,
	"Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
Subject: [PATCH v2 4/6] t7419, t7420: use test_cmp_config instead of grepping .gitmodules
Date: Tue, 21 Nov 2023 21:32:45 +0100
Message-ID: <20231121203413.176414-4-heftig@archlinux.org>
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

We have a test function to verify config files. Use it as it's more
precise.

Signed-off-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
---
 t/t7419-submodule-set-branch.sh | 10 +++++-----
 t/t7420-submodule-set-url.sh    |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t7419-submodule-set-branch.sh b/t/t7419-submodule-set-branch.sh
index 5ac16d0eb7..3cd30865a7 100755
--- a/t/t7419-submodule-set-branch.sh
+++ b/t/t7419-submodule-set-branch.sh
@@ -44,53 +44,53 @@ test_expect_success 'submodule config cache setup' '
 
 test_expect_success 'ensure submodule branch is unset' '
 	(cd super &&
-		! grep branch .gitmodules
+		test_cmp_config "" -f .gitmodules --default "" submodule.submodule.branch
 	)
 '
 
 test_expect_success 'test submodule set-branch --branch' '
 	(cd super &&
 		git submodule set-branch --branch topic submodule &&
-		grep "branch = topic" .gitmodules &&
+		test_cmp_config topic -f .gitmodules submodule.submodule.branch &&
 		git submodule update --remote &&
 		cat <<-\EOF >expect &&
 		b
 		EOF
 		git -C submodule show -s --pretty=%s >actual &&
 		test_cmp expect actual
 	)
 '
 
 test_expect_success 'test submodule set-branch --default' '
 	(cd super &&
 		git submodule set-branch --default submodule &&
-		! grep branch .gitmodules &&
+		test_cmp_config "" -f .gitmodules --default "" submodule.submodule.branch &&
 		git submodule update --remote &&
 		cat <<-\EOF >expect &&
 		a
 		EOF
 		git -C submodule show -s --pretty=%s >actual &&
 		test_cmp expect actual
 	)
 '
 
 test_expect_success 'test submodule set-branch -b' '
 	(cd super &&
 		git submodule set-branch -b topic submodule &&
-		grep "branch = topic" .gitmodules &&
+		test_cmp_config topic -f .gitmodules submodule.submodule.branch &&
 		git submodule update --remote &&
 		cat <<-\EOF >expect &&
 		b
 		EOF
 		git -C submodule show -s --pretty=%s >actual &&
 		test_cmp expect actual
 	)
 '
 
 test_expect_success 'test submodule set-branch -d' '
 	(cd super &&
 		git submodule set-branch -d submodule &&
-		! grep branch .gitmodules &&
+		test_cmp_config "" -f .gitmodules --default "" submodule.submodule.branch &&
 		git submodule update --remote &&
 		cat <<-\EOF >expect &&
 		a
diff --git a/t/t7420-submodule-set-url.sh b/t/t7420-submodule-set-url.sh
index d6bf62b3ac..aa63d806fe 100755
--- a/t/t7420-submodule-set-url.sh
+++ b/t/t7420-submodule-set-url.sh
@@ -49,7 +49,7 @@ test_expect_success 'test submodule set-url' '
 		cd super &&
 		test_must_fail git submodule update --remote &&
 		git submodule set-url submodule ../newsubmodule &&
-		grep -F "url = ../newsubmodule" .gitmodules &&
+		test_cmp_config ../newsubmodule -f .gitmodules submodule.submodule.url &&
 		git submodule update --remote
 	) &&
 	git -C super/submodule show >actual &&
-- 
2.43.0

