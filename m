Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B38C8DD
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 04:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710994672; cv=none; b=hQfzUsduXAu1tcgqhwePrPSjYLHJLv8bhX7gmjNKVC5M4/ZYSKrT/mU56JrXBHYC9FqzF4ug10WIjSZMPpgUJuNm7dA53gldk5ms+nojvZ18wYHfV7+nTFx7m7JIcBWj2Q5kUmuXg8oSV16P+9NiazktwRLrMt5LjMsWKUDbfBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710994672; c=relaxed/simple;
	bh=Yf+EgOvoyb0w7fhixtHncM+HeN3pHD05aHApNPytp+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=akxCA+J9ElQkE7Z2+0foUptzYEStkgTl3X9PNvSHT4qJgUjlPiHl0Eh5LOYVNqpnqN5S2hTllpFJp2SOVLc6a9KanDMNcJkYerMnZhP4pm5qkXUDKR9mOuwqzYakDdDAPJb864XZINo1UhrqIMuXG1LqC2EjLCy6OulYod439Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=QcUiwwnK; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="QcUiwwnK"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710994667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AtzjDFeCS7mer2i5SXpOgKoNV7KbnDV3a2h1zMBlD4A=;
	b=QcUiwwnKmScj4ljFZYRn8yAnUOawwtbOninmt9H6jP0ODBO49j1mxcttNj64L75w89+Ooo
	cCxcblW6TmU2rW03r9zTucnQKkpYUzM/Oe5i0FFfxoA+qNxTdJbLfgB3O2p/VC34MHm09k
	fBRndM47jwr1LGaV2NpExvqWxGSUwrhm83H39ITsYQs4S1QEQFllQTIJDA2dKvLDH2jey0
	ZTbP4cAjd04z/4W3Kb2RdD83ARI9gUQD8EYdVGhhNE+eQZDYw1gnpCIq/NRVOPXNrKHkLm
	y4ktRGyx/zyHdRqdBvsMQDPbQd690NkHZIJM91o/7Lzfz9z8ZcdRQ6k6gofXKA==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de,
	sunshine@sunshineco.com
Subject: [PATCH v4 3/4] t1300: add more tests for whitespace and inline comments
Date: Thu, 21 Mar 2024 05:17:42 +0100
Message-Id: <688128d8ef09589712634888074ffd71a192a7aa.1710994548.git.dsimic@manjaro.org>
In-Reply-To: <cover.1710994548.git.dsimic@manjaro.org>
References: <cover.1710994548.git.dsimic@manjaro.org>
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

 t/t1300-config.sh | 114 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 111 insertions(+), 3 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 31c387868708..6ecc9dd4c3d2 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -11,6 +11,98 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
+test_expect_success 'setup whitespace config' '
+	sed -e "s/^|//" \
+	    -e "s/[$]$//" \
+	    -e "s/X/\\t/g" >.git/config <<-\EOF
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
