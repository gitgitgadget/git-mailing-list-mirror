Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9722381AA
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 06:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711001177; cv=none; b=YknuqodBChBF3VephZ1xEPhBa9B4Vk8AxDau5N4QY5Lveh2qrhtwEj5wEwPJ24JWo8Q5FNXcji3g6YZOVDX/c9OtLDJg84vse+jKfvcvRs22KUkn5KUB/NlS6bNYWE4lDwBH+j2BTyyVuGJ5LRFBYxrF7CNY4FtBnvpC4IduY4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711001177; c=relaxed/simple;
	bh=g34D15xnHJH6jRQSWYbeDCeK57+IoI2M64sqVpnnNS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YtxdVozpjrwu9mfrMwubRyP8OlJTtRsvewEQUlHSGcVzER0p3QcyCkDu44AIONaIx2Gw36baUGHW3ElAUvOHLAuTTlRNoN4UnFdWib8RmA3Cnp4A/MXYPXi0RvXyd6X3HEJSkiYEhD0GW9AZLOHZ3TV6jzV15LTEDOEPYax0xVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=RPIJG7H0; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="RPIJG7H0"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711001172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3y/RipEssvh4IRhVq1OXyjN6DSPhYeLHbJ2t6v0eikk=;
	b=RPIJG7H0iZPiJ0m66uX3dcQHqDJb3mNMNW/X8ybIMpTok2RZaHPTZj50raDVXy7mnQ5ijm
	6dm4sPf6vlndyiyOuoxS2KfX9UDEmwly5n1/zl2X3Vi2ru4Vd/IEC9Iw010rRAmvGMOrKx
	no20UFZFzvYWh9d1sFYqiKS4EwVAu5no1Gw3pudWITPuaml5MfGSBiJtzceEKvAL8DUwzm
	0w90ccAMn2dV/gYyfH/m1Iu6/dPQMycdwaRMZWVoRVEXFyvx8geJgsYGghdom4yU1/KweP
	Y3zeUOH2beYDlQcrplTdZZSQ4zzhdq41fPy3J/mqNnYBvS+clGTUAfp66xE/FA==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de,
	sunshine@sunshineco.com
Subject: [PATCH v5 3/4] t1300: add more tests for whitespace and inline comments
Date: Thu, 21 Mar 2024 07:06:07 +0100
Message-Id: <9110797a7d9daa7f3f29a79f416a01a6355cde82.1711001016.git.dsimic@manjaro.org>
In-Reply-To: <cover.1711001016.git.dsimic@manjaro.org>
References: <cover.1711001016.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Add a handful of additional tests, to improve the coverage of the handling
of configuration file entries whose values contain internal whitespace,
leading and/or trailing whitespace, which may or may not be enclosed within
quotation marks, or which contain an additional inline comment.

At the same time, rework one already existing whitespace-related test a bit,
to ensure its consistency with the newly added tests.  This change introduced
no functional changes to the already existing test.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    Changes in v5:
        - Replaced the HT escape sequence with a literal HT character in the
          configuration setup test's invocation of sed(1), because it may not
          be portable, as pointed out by Eric Sunshine [6]
    
    Changes in v4:
        - Improved the added configuration setup test, to make the included
          leading and trailing whitespace characters more robust and easier
          on the eyes, as suggested and outlined by Junio [5]
        - Expanded the patch description a bit and improved the wording
        - Added a Helped-by tag
    
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
    [5] https://lore.kernel.org/git/32c4718d09ff6675e37587e15e785413@manjaro.org/
    [6] https://lore.kernel.org/git/CAPig+cQekOLrpcK_NcL951SRZAg-1Y1aFzE0-i-uCTK_XuiajQ@mail.gmail.com/

 t/t1300-config.sh | 114 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 111 insertions(+), 3 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 31c387868708..f4bd69512ed9 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -11,6 +11,98 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
+test_expect_success 'setup whitespace config' '
+	sed -e "s/^|//" \
+	    -e "s/[$]$//" \
+	    -e "s/X/	/g" >.git/config <<-\EOF
+	[section]
+	|	solid = rock
+	|	sparse = big XX blue
+	|	sparseAndTail = big XX blue $
+	|	sparseAndTailQuoted = "big XX blue "
+	|	sparseAndBiggerTail = big XX blue X X
+	|	sparseAndBiggerTailQuoted = "big XX blue X X"
+	|	sparseAndBiggerTailQuotedPlus = "big XX blue X X"X $
+	|	headAndTail = Xbig blue $
+	|	headAndTailQuoted = "Xbig blue "
+	|	headAndTailQuotedPlus = "Xbig blue " $
+	|	annotated = big blueX# to be discarded
+	|	annotatedQuoted = "big blue"X# to be discarded
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
@@ -1066,9 +1158,25 @@ test_expect_success '--null --get-regexp' '
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
