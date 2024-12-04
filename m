Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E112B9B7
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 10:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308911; cv=none; b=QiCVV7/QklwGHrBln0565d08Htr8DDzcedgINnFn1wj7fidObIz28Tu/3dzTuzK7qK7qVV+gsCEzo2NlSvJ0/qWF6BVQIBDC6CR9DGN9yzLMPnbqEhfApNvaS5X8aC1hFecWLYIrbpC4aJxNYuMvIYLpEn6Vh3RMZz/TglgvUoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308911; c=relaxed/simple;
	bh=cwlyVnOSiYUGHIGlxRZNhD3B5XLGtWr7XqbqUdxDIgA=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=hgOraO+IP7jqxmHZjj0r+IsdCkUH9IM/L9ss5SU5OFw/Y2UDISkHpUFYi5g7xiCDz1RYBbtfRzb/Z8bzb3acKLsnSWY4ql2qoQQcpUSGOyRTP307Er6XY3MYnVwgINMpy2UBcknYCw1ZNVCEGTQkFBvjeItA6ZHf+ZCm3jcDXao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=L3Jnh7KF; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="L3Jnh7KF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=PciC9mmZNlrYxuiKqa48QI+ewG4o10srXW47Xulh80k=;
 b=L3Jnh7KFd2FdMaZCY59ahgP9A4zQEsohRIlbT/cYN4XV9qrGHc87Eu5wFfnWBUrvSFgaOrMK/0//
   cV/GwQRtSWgYFCoiZnqSugl/kQAys3e3GSpfbyCUHNNIy4fyVlJTTSHgRHi0gxm/hiHquqfRmv/6
   wF9Sic/MSUAcUBEAaM9Qz3QfnWfUysTwstb7wbJDmDZzvTWLSrziS7EA4WPTYriWelMoWAMXl8G3
   P9jepkk9xkLISPbPpe3dbwK1tGdoqRdIUcOxSrncce71fMs7Dk8AFO/RV7mCzItfxkz/BN4kW8Mm
   DOE3VXL0h8I31EUGYDr0TaPuAPttxogpOkrtUA==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SNY008DJTPNOVF0@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 04 Dec 2024 10:41:47 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v2 3/3] remote set-head: set followRemoteHEAD to "warn" if
 "always"
Date: Wed,  4 Dec 2024 11:39:26 +0100
Message-id: <20241204104003.514905-3-bence@ferdinandy.com>
In-reply-to: <20241204104003.514905-1-bence@ferdinandy.com>
References: <20241203215713.135068-1-bence@ferdinandy.com>
 <20241204104003.514905-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAFT3u2STzDfwqqTfQV9JtTvpZc/stlRMtWIqovsFZ1gzqEvq1d9mdXL/9RJGmU1
 /+rQoxRkwAtOlY+glzyP0gw4SXWpYE6J3SrIrXplDV56+ekrTc3K15p3na9qc4y6
 elXrRtQKgz0fWFOovXYGz64k9BayJqrpyZO3NOmM5+fo0D7upbuG0AeIr0BY/jpn
 Se4HuBlVGuReVvNg7yQ4g8cJE1QdoDHshN7pPmz27iBxR10V6lrBAncicRq93M53
 EzR7uOJTNGbrYOrQyOGJfo4MFs5eqMYPQSob9jdZlj6iK4rlkvnYtLixNbYEhfbS
 6kqdnUI3BbVB+U1K17Xhl8GwlhBJyNvLOTvNy2i7KjerBNHxicRPUSeM7fAdJC/S
 Lm5M5wEq8T6Jquv8bk6zikjWJ7SQpLMar5DBBESAVx8csaA54UO11mEEfL2M3umy
 yAMAWmUqbNGJz4FVmq9BKmxQzkOpgIi6mY9AweDEXA6xwk2bV/wsx22a

When running "remote set-head" manually it is unlikely, that the user
would actually like to have "fetch" always update the remote/HEAD. On
the contrary, it is more likely, that the user would expect remote/HEAD
to stay the way they manually set it, and just forgot about having
"followRemoteHEAD" set to "always".

When "followRemoteHEAD" is set to "always" make running "remote
set-head" change the config to "warn".

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---
 builtin/remote.c  | 12 +++++++++++-
 t/t5505-remote.sh | 11 +++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d5b81445f2..32d02ca4a0 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1438,6 +1438,7 @@ static int set_head(int argc, const char **argv, const char *prefix,
 		b_local_head = STRBUF_INIT;
 	char *head_name = NULL;
 	struct ref_store *refs = get_main_ref_store(the_repository);
+	struct remote *remote;
 
 	struct option options[] = {
 		OPT_BOOL('a', "auto", &opt_a,
@@ -1448,8 +1449,10 @@ static int set_head(int argc, const char **argv, const char *prefix,
 	};
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_remote_sethead_usage, 0);
-	if (argc)
+	if (argc) {
 		strbuf_addf(&b_head, "refs/remotes/%s/HEAD", argv[0]);
+		remote = remote_get(argv[0]);
+	}
 
 	if (!opt_a && !opt_d && argc == 2) {
 		head_name = xstrdup(argv[1]);
@@ -1488,6 +1491,13 @@ static int set_head(int argc, const char **argv, const char *prefix,
 	}
 	if (opt_a)
 		report_set_head_auto(argv[0], head_name, &b_local_head, was_detached);
+	if (remote->follow_remote_head == FOLLOW_REMOTE_ALWAYS) {
+		struct strbuf config_name = STRBUF_INIT;
+		strbuf_addf(&config_name,
+			"remote.%s.followremotehead", remote->name);
+		git_config_set(config_name.buf, "warn");
+		strbuf_release(&config_name);
+	}
 
 cleanup:
 	free(head_name);
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 7411aa770d..daf70406be 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -504,6 +504,17 @@ test_expect_success 'set-head --auto has no problem w/multiple HEADs' '
 	)
 '
 
+test_expect_success 'set-head changes followRemoteHEAD always to warn' '
+	(
+		cd test &&
+		git config set remote.origin.followRemoteHEAD "always" &&
+		git remote set-head --auto origin &&
+		git config get remote.origin.followRemoteHEAD >output &&
+		echo "warn" >expect &&
+		test_cmp expect output
+	)
+'
+
 cat >test/expect <<\EOF
 refs/remotes/origin/side2
 EOF
-- 
2.47.1.398.g18e7475ebe

