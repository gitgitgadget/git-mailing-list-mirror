Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3ED37B011
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 23:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773530462; cv=none; b=THtOGgv1dFr5dTJ29gpEsWnjYIbrTb/G+J9LNUI7tZAo1zcMvtKcNjqFgAdSuB8V01aJKw+RNzU7AuA3dRznvD8SY20NSS1XzK0WIr1ppOhGcK6KhKsdlyDPCd+mMTZCnlM0SsaamW5RnFid/pCegNTtRSX9QP9hr57B+4IhBQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773530462; c=relaxed/simple;
	bh=Fg/x3sNYdi8E4++H9he7OPuZPfY61J2FU10L5l5mjqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkJBuNEUkeTWWwmyyzyvO1aBlYytKJjtehU/soFku8sp1vwyZX5KD+vWjKyeVhsFs4KoKa2ekL3Qpstp6VtVu7OyfRe+Nlo9NiHkH/oMLH7ZVJfgMeR1s+4hTmRWs2bytXaFvbOuWTRZPZoAXiL7xtSwSKhlB882Bo2O2ENSpdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=AiUy2fuF; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="AiUy2fuF"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773530453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TG7moJRwTJn/dR9RJ16yPr/OgvjUXBiEVO3cdqg6Ccs=;
	b=AiUy2fuFds7hIN1L8IDeXC07ylWxo01gc7OXJPfImog4aSzKTVIuFbhLLyHBjnjmVDw2Qn
	zpDmZMvXoTmhQv32gr6JduPEfr9sMZSHh0R0MH1RBaoc3K7fwW9QxSj1tlDjkNsxzldcbg
	KtdhD3LcwkrVNfttGe0LLx9bCmMwwJnaozcNAFsR5Mwy0wMMucT0HdKPJqZu0ZvRqkmEk1
	qRvvuADWAI3rG09dL8zBKSU7E/08GyM3k5E5AsaYDNad+GsO85woIkt5JdzBw1uyyBcCao
	PMmnppf3odxgiq5kxKB8SDnz/Atc82VT7+64WhGLWfXnUxcXkGYFck5pmkhnvg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>
Subject: [PATCH 1/7] pretty.c: better die message %(count) and %(total)
Date: Sun, 15 Mar 2026 00:20:44 +0100
Message-ID: <f71d15476ac857550108347ef1664bf9cd9e174d.1773530191.git.mroik@delayed.space>
In-Reply-To: <cover.1773530191.git.mroik@delayed.space>
References: <cover.1773530191.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132; i=mroik@delayed.space; h=from:subject:message-id; bh=Fg/x3sNYdi8E4++H9he7OPuZPfY61J2FU10L5l5mjqc=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBptezDxgVRHaYzpWst0rftJOpkx7MTdWzKbu9M/ oeFWOL83HWJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCabXswwAKCRBIeX6hnBm+ 0UOBD/9LrkyFbVa9driLrEz6IRShW06FV1n4CcSNaUg1SSw1hKqzRne7H6pfGUN+9j/hTfB9pKR NKeSZ0N2m8M9f4VdqY8rOAxvQOty4o5Ey+qQ5Jm3qAdDKqE38bMH2gOl3HYLt71sMFznnGFoyN2 Iqqm64Cg6lxepCUZvko6jwg08iHrelCgX6TRmi5mNT1vhBWPc7xQou8bEqBKgrURZflCfuwQSTE tSHjEKXRBpbRqg6NweFIdVONimMqu05tU7WtjOWTlhklovuwcpyRbZasUwFtMlrfwJp+PDCp2FE pk/GDfzWbqrWw0JMy6jQR8iL+YLSQ7vihKP4fYUa1Rftld0yXtQ5/fhe/lqyPfGXtG/hu3x9NIB 3ryjPw4OMiY5mQkk5pybSl3ghE4bb0sb8LNwvrNmDf97cXCGqO/f0dWt0k/bgj8xz7D5kTpkHbe VP71sXr/0/x5QdracUghdC2p3e93L4EaHGx+sQB0XAlsywfSGWFQnZpWbhLnjLh/gfID8GXdxNk 8HFG7FPEtwf/DRVnJDHCwgFpBIDwbxUOp4b+ChU2b7l9V+JHVufE8+2V5CDaTCosQ9nPOtz6kFR m7Drk9vWslnEuGa/6vF8dEz56Zge+QIQo1tKfW5aQ2GS3WdYVaXxggLUZdQPdb1B5g4sqrmQw2m SwnZmwORp
 0qlHqA==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

Improve die messages for commands that do not support %(count) and
%(total)

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 pretty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pretty.c b/pretty.c
index 74673714c8..814803980b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1551,7 +1551,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
 	if (starts_with(placeholder, "(count)")) {
 		if (!c->pretty_ctx->rev)
-			die(_("this format specifier can't be used with this command"));
+			die(_("%s is not supported by this command"), "%(count)");
 		strbuf_addf(sb, "%0*d", decimal_width(c->pretty_ctx->rev->total),
 			    c->pretty_ctx->rev->nr);
 		return 7;
@@ -1559,7 +1559,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
 	if (starts_with(placeholder, "(total)")) {
 		if (!c->pretty_ctx->rev)
-			die(_("this format specifier can't be used with this command"));
+			die(_("%s is not supported by this command"), "%(total)");
 		strbuf_addf(sb, "%d", c->pretty_ctx->rev->total);
 		return 7;
 	}
-- 
2.53.0.959.g497ff81fa9

