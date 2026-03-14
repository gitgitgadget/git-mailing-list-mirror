Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9785A286897
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 23:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773530463; cv=none; b=eHbFJOWxPKgR2eKQCLmv2wd0h0jdEIJRUEuBXb32w6lElGYj7YX6PNEY1ZngJaK9LxNA92jM+2tKDBQR9xG0zMiNt34/eigvbf084LDBtPz4q2ksyguvch2qyYHXt3ldRxCTv/HICdVcA+kIC5kAzVaVsGex/6ZM2h4QIkpuAsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773530463; c=relaxed/simple;
	bh=IGFXnsbVN7EVdFrGKuIywy04wTzYe+pTdWuIArSWeNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=av04QYubQt1NPcKO50M8JQXGR/1sKAuChlZRVx++5t3SgYllnyLGykZKWBrRR+yvouXfXFsNyBQ0/xFDSKSj7iUNjRCV6bI/QxJdJ8giLu1fihrbg+di7Le9V85GmKk77+4Yv1YwA/De6ikdcSw17ggxFCeyEzBySrgFf6Tfz2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=QpPHurWr; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="QpPHurWr"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773530453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yD/iXjKRaAo0JA+BsIsWs0CsNk4/jrtCUijvHH1+YtQ=;
	b=QpPHurWr71NO7PIZh5Ekk9K1xi8M7kbhkMoIxyFFM04r2jixJbSJ6DZCRWW8cQelulajnH
	2AnFApc7G26HDiR4hLOFNuvO2wtqY2XeWp9t4Z79dx223Wewm/wI3fbqU6DL+yojXP9pv/
	fEOXJnCgTwaaePSHxxCh4f5jk7e7nJW2N2lZt2uRhQ6MiSE4tuNur/Jm++mMnrsr/GmNWP
	FBNhpHr8rWoFBnChw77uaBziBf7VhyZtbvLhh/RrJ8dIkNqLSP+RysQs4bSSS2v77qIbL/
	6FIJMDyZxjBMy78L+n5Cyc9J0E81wSWAxfItxG5XkFcG7i8a+BniJSJGP5fn2Q==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>
Subject: [PATCH 2/7] format-patch: refactor generate_commit_list_cover
Date: Sun, 15 Mar 2026 00:20:45 +0100
Message-ID: <086cdfd57206735ed90416e6859ea0067172d708.1773530191.git.mroik@delayed.space>
In-Reply-To: <cover.1773530191.git.mroik@delayed.space>
References: <cover.1773530191.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=960; i=mroik@delayed.space; h=from:subject:message-id; bh=IGFXnsbVN7EVdFrGKuIywy04wTzYe+pTdWuIArSWeNo=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBptezDBeBTXfcJBbYx6Y0RhGtC1ObRLDlnmCDq/ acwWSTdbL2JAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCabXswwAKCRBIeX6hnBm+ 0fqLD/47uo6GLtbTIw4rDc7N2R+bFlwpUS/VQE7xS/fWESLZU5UZlAOJv9ujomOHWPlU8Bsq3Pu 4P+AZRl4fCcV2lPsR85Lw8hLaghx8WeOUpI4Rw9zsv90sqb143C+nzbzsIwTSe2ZfpL9xP54+7L 8xeMvOfR32m5VpUvGBg2wjtDbpZIOfvR3mY0mSMI6MAbMvgg5k1HPGQxbbcgE95m0kFxFmgqEti +pbS5SZpOYA76fVYEh19YsXDOuJ8B9ek4vmLaCN41sVHNHvFSLk+u35IL9TheLcRoYZDK/YjuQH 3AHONAr2eFMYjd7aQf91ZNdef89AUS4jnoKtsSNgOIbtXkyXngpx9+haElJJ6//aWVCQ/9KYGER qfa/4R2ysOzVJsznZCUzHmHWsRhItJ8i7WQ1tpOQitH96giCkG5UI2bWmyE7gq2X1D0iPEi//an IS6AKFWJ+4Yk5DB91OuTf7/7TjgBmR8PF+6V1khJAbRy1w05nwdn2IPtLQIdtNmMG+/tL1jSvtz PStcvjQ1inpHJM2uFhg4WDvcDiD7wKaW0hZ9pmII0is7m4aUv5d7WJOBNipETDIH5jxAefYpeNn 5+xcXI5LSPwa7FuPtXEH+kRLESCqmJrva2vVAam0p1atOoWnhX+JCqh2P/vl7FKcrwc40DeFjVY 9QF9DJ33iD
 463rQ==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

Refactor for readability and remove unnecessary initialization.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 builtin/log.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 716ebc2701..997bdd608e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1376,12 +1376,11 @@ static void generate_commit_list_cover(FILE *cover_file, const char *format,
 	struct pretty_print_context ctx = {0};
 	struct rev_info rev = REV_INFO_INIT;
 
-	strbuf_init(&commit_line, 0);
 	rev.total = n;
 	ctx.rev = &rev;
-	for (int i = n - 1; i >= 0; i--) {
-		rev.nr = n - i;
-		repo_format_commit_message(the_repository, list[i], format,
+	for (int i = 1; i <= n; i++) {
+		rev.nr = i;
+		repo_format_commit_message(the_repository, list[n - i], format,
 				&commit_line, &ctx);
 		fprintf(cover_file, "%s\n", commit_line.buf);
 		strbuf_reset(&commit_line);
-- 
2.53.0.959.g497ff81fa9

