Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8728821
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737063360; cv=none; b=ejKOWejhKN/PwGvRYwfErBFyfKaLrbaePf7Ikl4qG9Lbjy1kFm1vfb7Hr2tvt0X9BOHsdVrPhWCABxAvE1wugrbh4hkzdaJXBv1gGVhTHZEzHGP6WGV8S/rYENDE9uPlhqTCc1UQUabdDDiS9f7duZVIHintd4SymX6jnXXsGCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737063360; c=relaxed/simple;
	bh=XXrPZtgJcebV6H7r0OlPU2NyY+Eal4C9wj06G1XRUOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1EZzoGiqYgV5iL0uGC4dA4a3JTBFLEwn7o+0crOzGXS1HeTgqHD0ld9MeqkvpSHhYDaBAXXDVG6ZelD/aqcLXKlorcHnkxNYvY/bzPbWC1flBYOWpPlOBPAVfCsCis0K7oPywL7BBFKnVcZYulGlvXH7jgbbjofkXQSbj+gPRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oAmYyQcD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u7TrAgS+; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oAmYyQcD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u7TrAgS+"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 1B08C138028F;
	Thu, 16 Jan 2025 16:35:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 16 Jan 2025 16:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1737063357; x=
	1737149757; bh=eGgvm+BQvA0rTn8FNhysSVahGgHij9K+9UXkk0tGzq4=; b=o
	AmYyQcDtX93c2SJhXc6v1Dvsm4qQtVNIUSs8qzf066An/DttKC8mmxtBrsEMLneT
	KTwGIn+NXmYROCC9DbZ8N8U28RJvTxOJ+HE0yxkr8hVozuo9ZaZDUSf0lzKO0YVr
	xu3GAdLMcJn7Y6/rlsi0Skk9kk1trmV+Sk30mIARbexbhJlNCAe9Rsg4Kwqz2YKs
	BnKycY649qv0TWzQ21fiozh3vWZGne8j/KnQqw97PbWzJevTfKAp1GBXLJn25CQe
	hWIPL9zjC8eSFUf442JEuWjEE9xxDCIHEQJ460kkNvYpSVUy4QgSZ4UtjsnQhSl5
	zXKUOJajyEVj+9EEb+hFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1737063357; x=1737149757; bh=e
	Ggvm+BQvA0rTn8FNhysSVahGgHij9K+9UXkk0tGzq4=; b=u7TrAgS+miuskZ7MU
	Lt5o/iEHERT9ixQlEnO2Hv4+9QG+iMhU4okK3Zg7/TSIqHQI5uKybxlQ5N7VqjOy
	Y8CZfKWRdXegcTzIYdgweJZepTA9TcH51qNyOyNA9EBQS1iwSCsLkyqUBDPy1hOt
	yd8fzbF0sYg1FMpv58tjyErf2FBeiHZu4KXJQ6ByNFJJMeU4Fh9Zh/0RKJSIOxsG
	mXVqomkpS+GL+QdQtt5wTB7y0iB8lwJEXX4mtFMYS61wVPtaDAnVG9+Ld2UuKC/7
	e45Vp63EBvpZeYwnBSooAIe40LeqWlSsMQeFe7Z6jols/aBL/Mwfij83O7xJBNKs
	jlJUA==
X-ME-Sender: <xms:vHuJZ9RMCrQgS11BPHrwgEhkkljvWmsDjFxSK3keQBCLMoDRMY5QUw>
    <xme:vHuJZ2xKz9yDL8gD40XM_21Iu47wxZS9pwqv-NDmtk_EkKiEVRv3nKDC8G_rnM66H
    cGD6HmUQGS5lY4KLg>
X-ME-Received: <xmr:vHuJZy0QEHwKxGB8zq10UYGBnv9wbdbQfpGyTgv2JnB3GW0ExKE9k6-M__M5b-sMFsMhzhdfnGdJN10me0l91RFNM_fCq0i6jL_x>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepvd
    fflefhueetgfektedthfduleffudetleefieeulefhvdduieeukefhtddvudeknecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:vHuJZ1C9vnXb_MynZegC-g1TBaIHLMKLPsKueMkBBppNIHoJYJ5-7Q>
    <xmx:vHuJZ2g_UKLzXRFhc0Bo3O_ZYKBhn1VCwmLtUEh2It3YomzI6X1m8w>
    <xmx:vHuJZ5oL6Vll5CofkvkxgZxuILC550hxL1HA-_d5-QCZq1yEjMi4ww>
    <xmx:vHuJZxjeO1kb8UpIw9RkY-rAWgoxUicU8dFXcaVW2oM4WijbnU3ROw>
    <xmx:vXuJZ3uKKY5aT9nAuGaqWHgevUoAky7Xx3LLQ5wiEDpM87Hm5myezopu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 16:35:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH v4 1/6] t0012: optionally check that "-h" output goes to stdout
Date: Thu, 16 Jan 2025 13:35:48 -0800
Message-ID: <20250116213553.2563751-2-gitster@pobox.com>
X-Mailer: git-send-email 2.48.1-210-gaa1682cadd
In-Reply-To: <20250116213553.2563751-1-gitster@pobox.com>
References: <20250116012524.1557441-1-gitster@pobox.com>
 <20250116213553.2563751-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff King <peff@peff.net>

For most commands, "git foo -h" will send the help output to stdout, as
this is what parse-options.c does. But some commands send it to stderr
instead. This is usually because they call usage_with_options(), and
should be switched to show_usage_help_and_exit_if_asked().

Currently t0012 is permissive and allows either behavior. We'd like it
to eventually enforce that help goes to stdout, and teaching it to do so
identifies the commands that need to be changed. But during the
transition period, we don't want to enforce that for most test runs.

So let's introduce a flag that will let most test runs use the
permissive behavior, and people interested in converting commands can
run:

  GIT_TEST_HELP_MUST_BE_STDOUT=1 ./t0012-help.sh

to see the failures. Eventually (when all builtins have been converted)
we'll remove this flag entirely and always check the strict behavior.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Same as before.

 t/t0012-help.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 1d273d91c2..9c7ae9fd36 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -255,9 +255,16 @@ do
 		(
 			GIT_CEILING_DIRECTORIES=$(pwd) &&
 			export GIT_CEILING_DIRECTORIES &&
-			test_expect_code 129 git -C sub $builtin -h >output 2>&1
+			test_expect_code 129 git -C sub $builtin -h >output 2>err
 		) &&
-		test_grep usage output
+		if test -n "$GIT_TEST_HELP_MUST_BE_STDOUT"
+		then
+			test_must_be_empty err &&
+			test_grep usage output
+		else
+			test_grep usage output ||
+			test_grep usage err
+		fi
 	'
 done <builtins
 
-- 
2.48.1-191-gafe818080f

