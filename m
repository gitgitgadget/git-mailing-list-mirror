Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B865E59B77
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710800671; cv=none; b=X3af3OD9n7RCFSl1EttODHYx18yjEp0y6d+2wLSVxymXZkIZRPWYD9cQG5VhGd+nGT0TfJOT8Q2ZaH71H29/WbJJhvpyEZctSi1gg3ik4y0iWYnJ6U38+OHu9+dLuxSc5MwCZtBMhnPeWO/9xJdp+Vsvwx+KLBaFP3/bwn62UoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710800671; c=relaxed/simple;
	bh=Opq0hnsXmkEjpwoBrCVGfrnP7ULhUN11knrqaL7o6h4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KUaES7lsQs3TkG+OqhVtj99CI6SaBqtIC6HJiq56n0A7bpRqRhu9EJj0WU1G4FVDklwNmKTXLMCTNHkmLJ2UtNPB9srcxds89/AM3Co43SzIhAu8Bxm9A7IUAR0r8rSTXvU/4d1DrPCVeLzE4+bVn2olbWr9IkQj74a3Qm0WMz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=uTieX5WE; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="uTieX5WE"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710800667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yrOs75+rbuLnU8lEv9PIIWH3wYnZ03HmVer+YuNQA4M=;
	b=uTieX5WEXX8+cVmeP+ycYtXgqtJwqOedDD+eQhk/xo9c5dj7bvAPLFGLKLPvu0VKdI3MT0
	8IvdlFdYee4Hy3G3lCn8fAz+DzK9iTimcUzxNd+ZgQH0r6BrLoEqJ0b3ixFPs2SS5zqfFS
	qqa85I4JFVxUjkU0GYfp99TOwSMIlkb6p6GZT6YI7MbNzSIcyrCwnlKh8IAxdzvoFOYjz1
	mnOjSlvfOmrnp3iYu0aFYixvpJj8tvVK8EZlWlQAxKQtzHAkglk/z4l0dEZtdGAN9XJEq+
	uZBm5GyUI9P5w1526d/3j1jxk25HrzN2fHI26H0cTgQN1RFsZLEOYdnHKKQGYg==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de,
	sunshine@sunshineco.com
Subject: [PATCH v3 3/4] t1300: add more tests for whitespace and inline comments
Date: Mon, 18 Mar 2024 23:24:21 +0100
Message-Id: <92ddcd1f668906348e20a682cd737d90bb38ddc6.1710800549.git.dsimic@manjaro.org>
In-Reply-To: <cover.1710800549.git.dsimic@manjaro.org>
References: <cover.1710800549.git.dsimic@manjaro.org>
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
    Changes in v3:
        - Removed a few unnecessary invocations of x_to_tab()
        - As pointed out by Eric Sunshine, [3] it's better not to introduce
          new random helper functions, so x_to_tab() was replaced by a direct
          invocation of tr(1), in one case that requires use of literal 'Q'
          characters, and by invocations of q_to_tab(), in the remaining cases
          that actually allow use of 'Q' characters to represent HTs
        - Dropped the change of the name of an already existing test, to not
          distract the reviewers, as suggested by Eric Sunshine [4]
        - Renamed the first added test, as suggested by Eric Sunshine, [4] to
          make it consistent with the expected way for naming setup tests
    
    Changes in v2:
        - All new tests and one already existing test reworked according to
          Eric Sunshine's review suggestions; [1][2]  the already existing
          test was reworked a bit to ensure consistency
        - Added a Helped-by tag
    
    [1] https://lore.kernel.org/git/CAPig+cRMPNExbG34xJ0w5npUc3DDwxQUGS_AQfam_mi4s53=sA@mail.gmail.com/
    [2] https://lore.kernel.org/git/CAPig+cRG8eFxepkaiN54H+fa7D=rFGsmEHdvTP+HSSaLO_6T_A@mail.gmail.com/
    [3] https://lore.kernel.org/git/CAPig+cSLb+Rsy81itvw9Tfvqv9vvKSPgO_ER9fWL04XZrgFvwg@mail.gmail.com/T/#u
    [4] https://lore.kernel.org/git/CAPig+cTVmQzC38DympSEtPNhgY=-+dYbZmkr0RTRbhG-hp2fmQ@mail.gmail.com/

 t/t1300-config.sh | 112 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 109 insertions(+), 3 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 31c387868708..7688362826ea 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -11,6 +11,96 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
+test_expect_success 'setup whitespace config' '
+	tr "X" "\011" >.git/config <<-\EOF
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
+	echo "big QQ blue" | q_to_tab >expect &&
+	git config --get section.sparse >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'internal and trailing whitespace' '
+	echo "big QQ blue" | q_to_tab >expect &&
+	git config --get section.sparseAndTail >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'internal and trailing whitespace, all quoted' '
+	echo "big QQ blue " | q_to_tab >expect &&
+	git config --get section.sparseAndTailQuoted >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'internal and more trailing whitespace' '
+	echo "big QQ blue" | q_to_tab >expect &&
+	git config --get section.sparseAndBiggerTail >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'internal and more trailing whitespace, all quoted' '
+	echo "big QQ blue Q Q" | q_to_tab >expect &&
+	git config --get section.sparseAndBiggerTailQuoted >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'internal and more trailing whitespace, not all quoted' '
+	echo "big QQ blue Q Q" | q_to_tab >expect &&
+	git config --get section.sparseAndBiggerTailQuotedPlus >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'leading and trailing whitespace' '
+	echo "big blue" >expect &&
+	git config --get section.headAndTail >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'leading and trailing whitespace, all quoted' '
+	echo "Qbig blue " | q_to_tab >expect &&
+	git config --get section.headAndTailQuoted >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'leading and trailing whitespace, not all quoted' '
+	echo "Qbig blue " | q_to_tab >expect &&
+	git config --get section.headAndTailQuotedPlus >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'inline comment' '
+	echo "big blue" >expect &&
+	git config --get section.annotated >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'inline comment, quoted' '
+	echo "big blue" >expect &&
+	git config --get section.annotatedQuoted >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'clear default config' '
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
