Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082D9538A
	for <git@vger.kernel.org>; Sun, 17 Mar 2024 03:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710647303; cv=none; b=tq1+Dn7rCYhDVRd8bQLIwAH5DSvaXYKg5kZ4mrVKhzQOYENtTdqQYiGKLBSyPdhNL6aXg4zAy3s5Emzmi1XSxZFkevazZ5SDWgip/SOCF2/RLHqTsGK0VWAfDJunVtXdgcmXOpqRMvB85J49btsLd6Biz4WoFOYsVIj3i/AXYOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710647303; c=relaxed/simple;
	bh=x6e1n2AS2tXaPwLEaLUlLHRPslIke97AkD2+3cGQmoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GyYSMMhcm7fl0HMY/5/j7+bKSjWEoh/Gb7XVEaYq+RtoRCGufNnqxoqDQziX74PbeeK/KJskeKqCgq9An9OO/Zx7UqYXnkezpl85hWSMMYJ6D1jewkvNSE7TBXjLgTFVlmf7BKxL8JAmxhRYcW1QHyCaQDdq78YgmfSwDmlb3Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=rEeVMGI8; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="rEeVMGI8"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710647292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bDQWs/4OAzKGh/iQ2dU/79kMHYpVuMJ+HGzZQhWpCKs=;
	b=rEeVMGI8dpQOnrWTOLX84DzeI6poMA6Kr4PpDTPfOT+yVXuDsqI3Ccpu+bB0uPNs6A5pSC
	KlcQLyRjUiUoLW0T8ZBhXEno2j9SoUeKtPQWUnUHiBKbhTCxnx2JBEZhL8TubPpF678LOh
	2JQYC3g+nk4GgdxA8yVkEXxaT803PXQxpL4JLmajT6hg8Hhs/nORpd9Ssy1FUhJ8mLABoR
	rr04aauPl3dikOhaVAMY/BsailiF624eKa5dUf29zwBETgb5XkMGW4u951zQn7T8GlxPBc
	dZD4WzaLrDKH9oAYi5HSG6TkZ+2g+ZMsFo8jgTVqdEK82JcwoAqPspGk2YRi7Q==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de,
	sunshine@sunshineco.com
Subject: [PATCH v2 4/5] t1300: add more tests for whitespace and inline comments
Date: Sun, 17 Mar 2024 04:48:04 +0100
Message-Id: <9a73e7d3cbb9ea210ed1098c5a304b0f5d5e1a2e.1710646998.git.dsimic@manjaro.org>
In-Reply-To: <cover.1710646998.git.dsimic@manjaro.org>
References: <cover.1710646998.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Add a handful of additional automated tests, to improve the coverage of
configuration file entries whose values contain internal whitespace, leading
and/or trailing whitespace, which may or may not be enclosed within quotation
marks, or which contain an additional inline comment.

At the same time, rework one already existing automated test a bit, to ensure
consistency with the newly added tests.  This change introduced no functional
changes to the already existing test.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    Changes in v2:
        - All new tests and one already existing test reworked according to
          Eric Sunshine's review suggestions; [1][2]  the already existing
          test was reworked a bit to ensure consistency
        - Added a Helped-by tag
    
    [1] https://lore.kernel.org/git/CAPig+cRMPNExbG34xJ0w5npUc3DDwxQUGS_AQfam_mi4s53=sA@mail.gmail.com/
    [2] https://lore.kernel.org/git/CAPig+cRG8eFxepkaiN54H+fa7D=rFGsmEHdvTP+HSSaLO_6T_A@mail.gmail.com/

 t/t1300-config.sh | 114 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 110 insertions(+), 4 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 31c387868708..37ed078721ea 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -11,7 +11,97 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
-test_expect_success 'clear default config' '
+test_expect_success 'create test configuration' '
+	x_to_tab >.git/config <<-\EOF
+	[section]
+		Xsolid = rock
+		Xsparse = big XX blue
+		XsparseAndTail = big XX blue 
+		XsparseAndTailQuoted = "big XX blue "
+		XsparseAndBiggerTail = big XX blue X X
+		XsparseAndBiggerTailQuoted = "big XX blue X X"
+		XsparseAndBiggerTailQuotedPlus = "big XX blue X X"X 
+		XheadAndTail = Xbig blue 
+		XheadAndTailQuoted = "Xbig blue "
+		XheadAndTailQuotedPlus = "Xbig blue " 
+		Xannotated = big blueX# to be discarded
+		XannotatedQuoted = "big blue"X# to be discarded
+	EOF
+'
+
+test_expect_success 'no internal whitespace' '
+	echo "rock" >expect &&
+	git config --get section.solid >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'internal whitespace' '
+	echo "big XX blue" | x_to_tab >expect &&
+	git config --get section.sparse >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'internal and trailing whitespace' '
+	echo "big XX blue" | x_to_tab >expect &&
+	git config --get section.sparseAndTail >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'internal and trailing whitespace, all quoted' '
+	echo "big XX blue " | x_to_tab >expect &&
+	git config --get section.sparseAndTailQuoted >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'internal and more trailing whitespace' '
+	echo "big XX blue" | x_to_tab >expect &&
+	git config --get section.sparseAndBiggerTail >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'internal and more trailing whitespace, all quoted' '
+	echo "big XX blue X X" | x_to_tab >expect &&
+	git config --get section.sparseAndBiggerTailQuoted >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'internal and more trailing whitespace, not all quoted' '
+	echo "big XX blue X X" | x_to_tab >expect &&
+	git config --get section.sparseAndBiggerTailQuotedPlus >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'leading and trailing whitespace' '
+	echo "big blue" | x_to_tab >expect &&
+	git config --get section.headAndTail >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'leading and trailing whitespace, all quoted' '
+	echo "Xbig blue " | x_to_tab >expect &&
+	git config --get section.headAndTailQuoted >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'leading and trailing whitespace, not all quoted' '
+	echo "Xbig blue " | x_to_tab >expect &&
+	git config --get section.headAndTailQuotedPlus >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'inline comment' '
+	echo "big blue" | x_to_tab >expect &&
+	git config --get section.annotated >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'inline comment, quoted' '
+	echo "big blue" | x_to_tab >expect &&
+	git config --get section.annotatedQuoted >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clear default configuration' '
 	rm -f .git/config
 '
 
@@ -1066,9 +1156,25 @@ test_expect_success '--null --get-regexp' '
 	test_cmp expect result
 '
 
-test_expect_success 'inner whitespace kept verbatim' '
-	git config section.val "foo 	  bar" &&
-	test_cmp_config "foo 	  bar" section.val
+test_expect_success 'inner whitespace kept verbatim, spaces only' '
+	echo "foo   bar" >expect &&
+	git config section.val "foo   bar" &&
+	git config --get section.val >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'inner whitespace kept verbatim, horizontal tabs only' '
+	echo "fooQQbar" | q_to_tab >expect &&
+	git config section.val "$(cat expect)" &&
+	git config --get section.val >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'inner whitespace kept verbatim, horizontal tabs and spaces' '
+	echo "foo Q  bar" | q_to_tab >expect &&
+	git config section.val "$(cat expect)" &&
+	git config --get section.val >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success SYMLINKS 'symlinked configuration' '
