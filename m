Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29607231C9F
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739815093; cv=none; b=pGB08dDhptBdrZCA0cKH2neXNTmYya1j4zKutHPnryQCYj/OEV2LRop8waUAWseflDEcbXTb2fV7TJQfaXlbI+Ho0hz4fk8dZWIO5EpOkhcvu3SxmuLmZabmwGjqNbEufnI2LxVad9U3c8lgscoEpxfGKr+EP7XLMyNPBxPm+RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739815093; c=relaxed/simple;
	bh=VgZ5lcHmdwnGgIX3QHFYVOt+N5Yc537PuMY3uDUwh34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFCjYsNGbcGJDZp2ynJzuOfI1BC9NFSEB9PlZ3cHYUpzWgNjPlGLTPGs4Bu0wgM28T/shjObft3Hv9kpw418z+sPYwskOEf6/72plwwNWoRJnt2rwZ0n1TB6WOY7QREDFcelnewnowsl3bb6OU74EpUHajE8NYFmBWDaRSEfNhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=xPl7ERkq; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xPl7ERkq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1739815089;
	bh=VgZ5lcHmdwnGgIX3QHFYVOt+N5Yc537PuMY3uDUwh34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=xPl7ERkqGAYbRliSw+NUPx8W8ZkDW/uTARBizW1hu08rxTaBusIJqu/WXfEFy56VV
	 DfCgd2/NTKAicWt/DjBAAxsK7bWRAyiCKUcdRBudg8J0E06DPlxlajRAS2t8gnVU35
	 NXb8/elO44U0jv7w8lPjdWj9/yK14BvPESJniDzDv/9z4srHsWl+MGkamsLRR6hMfE
	 mwOKErRZRETu8pVLGCe+8O6axptS+oAv9qorQ1paV4UIHKomEcXMkLfv1iPRPnqXWT
	 j4KvFcRApdrEAypRR9TPnQTyh4LT+lVFMRtlPFTg4ukbhSNVfSwTTnV3K8DaOv4zYH
	 QOU+PzpIhN2TaaPFwh04Jrzh/rjMGSDz7YK87nb3/JxtBGkgnGDD7BOtnRR1lhlCVX
	 BP2aYP/KSc3yxQTsmLt6jUTBwehiPrpbcSRi+dKhf38iDMi58j1yvSuS9BA6PI+7+X
	 wAdkfnO7RfbGukhEsASPGVyfboaduYcjkLpW/eKdu+LUsij/UVl
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4E1862007A;
	Mon, 17 Feb 2025 17:58:09 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jared Van Bortel <cebtenzzre@gmail.com>
Subject: [PATCH] diff: don't crash with empty argument to -G or -S
Date: Mon, 17 Feb 2025 17:57:59 +0000
Message-ID: <20250217175759.1576684-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.48.0.rc1.219.gb6b6757d772
In-Reply-To: <Z7KX2y-dXaZuPrW4@tapette.crustytoothpaste.net>
References: <Z7KX2y-dXaZuPrW4@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pickaxe options, -G and -S, need either a regex or a string to look
through the history for.  An empty value isn't very useful since it
would either match everything or nothing, and what's worse, we presently
crash with a BUG like so when the user provides one:

    BUG: diffcore-pickaxe.c:241: should have needle under -G or -S

Since it's not very nice of us to crash and this wouldn't do anything
useful anyway, let's simply inform the user that they must provide a
non-empty argument and exit with an error if they provide an empty one
instead.

Reported-by: Jared Van Bortel <cebtenzzre@gmail.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 diff.c                 |  4 ++++
 t/t4209-log-pickaxe.sh | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/diff.c b/diff.c
index 019fb893a7..c89c15d98e 100644
--- a/diff.c
+++ b/diff.c
@@ -5493,6 +5493,8 @@ static int diff_opt_pickaxe_regex(const struct option *opt,
 	BUG_ON_OPT_NEG(unset);
 	options->pickaxe = arg;
 	options->pickaxe_opts |= DIFF_PICKAXE_KIND_G;
+	if (arg && !*arg)
+		return error(_("-G requires a non-empty argument"));
 	return 0;
 }
 
@@ -5504,6 +5506,8 @@ static int diff_opt_pickaxe_string(const struct option *opt,
 	BUG_ON_OPT_NEG(unset);
 	options->pickaxe = arg;
 	options->pickaxe_opts |= DIFF_PICKAXE_KIND_S;
+	if (arg && !*arg)
+		return error(_("-S requires a non-empty argument"));
 	return 0;
 }
 
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index a675ace081..0e2f80a268 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -93,6 +93,22 @@ test_expect_success 'usage: --no-pickaxe-regex' '
 	test_cmp expect actual
 '
 
+test_expect_success 'usage: -G and -S with empty argument' '
+	cat >expect <<-\EOF &&
+	error: -S requires a non-empty argument
+	EOF
+
+	test_expect_code 129 git log -S "" 2>actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	error: -G requires a non-empty argument
+	EOF
+
+	test_expect_code 129 git log -G "" 2>actual &&
+	test_cmp expect actual
+'
+
 test_log	expect_initial	--grep initial
 test_log	expect_nomatch	--grep InItial
 test_log_icase	expect_initial	--grep InItial
