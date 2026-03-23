Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70A13C5530
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285083; cv=none; b=kJEr6JXnRAPdR2dWTUx7z8BbzMACmT/QgnSqH7e6voSPRxN0gerrA+bcBcsLtTaoJ/mtjZcc0OSjGBKGmKzG9nps0NHjlA58YvbhGVVf1Q6xVoPryfnZ4Y2u65bNi5hScOttiDYjmUTmzxSgHR24Hftwud0om8USEQbNgoSVZDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285083; c=relaxed/simple;
	bh=3fILk7hrjR2f0OgB3pcnZCMoonwVQ63hp+aMQ+KtcE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwEOO1MAgkSf16UXa3my5/+L+lepl4x4v7jXRbkiByvArWniEH3N6lYGX5PV5jp35J6Tmrs+JTkloezLAsW38RPWPFvU1GB0m2EF8glt05HsYUArXXMnkWJjpoHNuRKTKGNmTl2a5FVuMiSqpGpPul64J1QPgGSkuLCmKIOQ5qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=V+mwQ+Y/; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="V+mwQ+Y/"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1774285078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DoVrJIWLm2KzwHD3HMiDMPEzZM+HelfmQr/9HGLwqkk=;
	b=V+mwQ+Y/ri1BAs/OYAnjP9csQ/YkxopkVuebSCKhq/3dkC0gl9CVTGlFZv+ngTjk61GFdY
	RPKroLJGISSv+bTxLKviPW2jVX/K1Q/Hrfj4g8I1jh/L34Q0QaZs5Kn3JgEritrOkQMAis
	UNlxCzS1BlbK705W3r0oBzMjFc8Rds7HaTB9PYYKTSGWzgfA7rc3Sk/ZjuSPAeOYcfT8h9
	XvmyJRZnF8gnsWeUu0BlpTI7zG+E9jSOKguX8FvAmaeIJuAnmCcv4Lb9EJSW3SgH9BMFzB
	2bwq4do9PU3pnYfxhmFojyor3Skz/opcP2NK9LuQLpgKzVfoF95Da32ps/YFNg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v3 5/8] format.commitListFormat: strip meaning from empty
Date: Mon, 23 Mar 2026 17:57:32 +0100
Message-ID: <66d30249bb933aead0c6b1743167b4b30e522f70.1774284699.git.mroik@delayed.space>
In-Reply-To: <cover.1774284699.git.mroik@delayed.space>
References: <cover.1773959395.git.mroik@delayed.space> <cover.1774284699.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2285; i=mroik@delayed.space; h=from:subject:message-id; bh=3fILk7hrjR2f0OgB3pcnZCMoonwVQ63hp+aMQ+KtcE4=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpwXD06Oo7saAlONHLCWmJI4pIlTngcfn6uzA4f wNRXn2nnZKJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCacFw9AAKCRBIeX6hnBm+ 0fq7D/9UHSWOXK6wSf7rwGw/YDcqyHC8RUzfHPxM3ghioJp7yOrPYmP33G1YF/BhW4G9jitgbap w8eKSEuHBWRfIY5Uy0EoGborkAwwi8oL44GB6n436DOMq0xAVWDe4rGC/rT0zZC34XVMidPXoes WwgKbESNyyFIdJQENpPYBqrY181jO4mJ7JKw9SCCOwxskVmyw2SJ9sZdue1Fg99MF4LjdnEPj9D hZTx2o/l522Iqx4G4RslqrW9456jSk6gbpJp71uWlXNQbyZHFwnh8Ut3dP5AHXn8bEGIvfDuu9C +Xdy2VZENUHe88yDSnaW5tnSmrJ7hir8VEScgXHAEZ26imhbr7X6VEFuk+cZ3PpPA5oX9xCvSAh yjQKy9Yv7Q3pw6r3fmeW2NbWDH1tIVv6IGswC/1VP33/v5/I5oZmA7ZyC2493XuNi5qYIa1y6id o7Bsq6g8wJjsB4q0qTB5QgLhEiwBFiajOgvvVOWEL3Zl8Yw817KBmK/cM4KUFiPusz+aSPN4poh GOdfbvcQCPvr9s117KdIFhgi4I5Gb8AxA/v9zUES9kkhaHO2fov1FFCau9AuexOb8TBCQlDxuly LswqBHm70PPm2pJLRPyBY16pQQavmHd7LTuoOddSAs201skTzgJMaIuwzp8Pxcnm2+4ggZ22H50 ukVkQ52X6
 Rkbrlw==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

The configuration variable format.commitListFormat allows for an empty
value. This is unusual and can create issues when interacting with this
configuration variable through the CLI.

Strip meaning to format.commitListFormat with an empty value.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 builtin/log.c           | 11 +----------
 t/t4014-format-patch.sh | 11 -----------
 2 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index a7f129d583..47126f9064 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1055,17 +1055,8 @@ static int git_format_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "format.commitlistformat")) {
-		struct strbuf tmp = STRBUF_INIT;
-		strbuf_init(&tmp, 0);
-		if (value)
-			strbuf_addstr(&tmp, value);
-		else
-			strbuf_addstr(&tmp, "log:[%(count)/%(total)] %s");
-
 		FREE_AND_NULL(cfg->fmt_cover_letter_commit_list);
-		git_config_string(&cfg->fmt_cover_letter_commit_list, var, tmp.buf);
-		strbuf_release(&tmp);
-		return 0;
+		return git_config_string(&cfg->fmt_cover_letter_commit_list, var, value);
 	}
 	if (!strcmp(var, "format.outputdirectory")) {
 		FREE_AND_NULL(cfg->config_output_directory);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index d2a775f78d..ca37f40a6a 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -451,17 +451,6 @@ test_expect_success 'cover letter config with count and author' '
 	test_line_count = 2 result
 '
 
-test_expect_success 'cover letter config commitlistformat set but no format' '
-	test_when_finished "rm -rf patches result" &&
-	test_when_finished "git config unset format.coverletter" &&
-	test_when_finished "git config unset format.commitlistformat" &&
-	git config set format.coverletter true &&
-	printf "\tcommitlistformat" >> .git/config &&
-	git format-patch -o patches HEAD~2 &&
-	grep -E "^[[[:digit:]]+/[[:digit:]]+] .*" patches/0000-cover-letter.patch >result &&
-	test_line_count = 2 result
-'
-
 test_expect_success 'cover letter config commitlistformat set to shortlog' '
 	test_when_finished "rm -rf patches result" &&
 	test_when_finished "git config unset format.coverletter" &&
-- 
2.53.0.1118.gaef5881109

