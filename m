Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB2227FD5B
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285080; cv=none; b=BQzXql45pBprWly1VF8bAXD2C6ZXufArPChFRBp1usPJlz6QPTTHsqzbnqJeam+l7KGW13g45mwoBi1vVRHVU8mY7hdocWHs65UzTq3OuKMSZKuYnfKSSmcy3nx5UXV6fIGGEzR1gw625bF1RxF07Qssy9M9R6dR6lm5fGwMcaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285080; c=relaxed/simple;
	bh=t6rZ6sCnlhR+CYMTLYBJW5u2Pj4FUaqrNEAM4TUodn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KyemOZGYfcxQ/TXQt571YW8H8gQT32shdHwDVqqv94jF0GCzHZZlIA/9JWGCj+Ecq4MxT4ZyQXeGWur//pEbeWdUZBEPPILTDPZGpptphLJEvTw7o/9fXSTNeao6XN9yMtoLPXhmd6FImcSGsvEQ9SrGr/D6vL/egmF1DJ9bxx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=m0pL6Awo; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="m0pL6Awo"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1774285076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RZeZ+ykplqHtDCK+D0wtAUnf8MdrJ+6FGxOjluQqWmw=;
	b=m0pL6AwovB8t+L/ZjHIHq/zcbb67KjIAIoCuV5xIzLlW1aj+FWEDmJu8to1pdaXPirYZbO
	VU5ri3tzy3xo8GMozDSvYjvBjOgdryVnKQ5UE57CKQB24jtcW7XD1hGbzRJWGVtp/AD0Yb
	LcnQ7euz3VfkhcnGSmVzMhB6/efsiRwrz5ORxgEXLS9c8Z9fMi4n8JWqD8SbLtadAhvGyC
	qoqFIj6P3MJI/gSd2Me469MzRreMUtO8POAkQoql1ikmhXa1YaBUumKX2/5dipRVJlw4rH
	BITfqkfcy0RhVQH4IQU7jMKh6/gCzCb6SkcGtx2G4t61KX92ZLkeQFuJQXZ/Hg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v3 1/8] pretty.c: better die message %(count) and %(total)
Date: Mon, 23 Mar 2026 17:57:28 +0100
Message-ID: <a0d26c5999980f87b12022d12031d9f0dabbd864.1774284699.git.mroik@delayed.space>
In-Reply-To: <cover.1774284699.git.mroik@delayed.space>
References: <cover.1773959395.git.mroik@delayed.space> <cover.1774284699.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133; i=mroik@delayed.space; h=from:subject:message-id; bh=t6rZ6sCnlhR+CYMTLYBJW5u2Pj4FUaqrNEAM4TUodn0=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpwXDzxoScxlICIx59pKfwcAnzmSMT2txmgZYS+ 58817vp0AKJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCacFw8wAKCRBIeX6hnBm+ 0TnVD/9+tUDB5heANA9FaVuyE8XuSMYfbXFPZOwqU7d3JK9hxMcl3owbuVtswVfHeHpx0mh7Dn0 zK0INYvS3hDxdvftwtUjJIDMuKZeoiJQeqg3xaNeJR90+RkSjvTjpBtQHMlSBg2g3/09j0RiZb6 l3oRioGGkt0KKDS57mQ1snwpyCW2Z+0r0CnYxZpCraUnbgHLugckb4zekCdM0lxN5qKQm+3mPMR NfGuJrCobFM61QqwsL/ystcyAv9/h1pW9FESy0QfW9DUmYTpVFnNsacCpziKpcW3CT+o00NWMVu ma1H3DRAMn7YRVwcCzBO/OtxCejVTF4I4nwzsAyhovkT4S4X6/2GhJL7qAtbrFOisqaJ14R3Ojf L38VnY8DDdGMThGJF+W3kd8cFYUSCSp9cUISmzt8yBP+Y5mA0wq/N6yMhlQm4Sk30cR1bgoaTNH wFYg42wwR5+hbpomkspU5rs1vrnLINoP7WmNG7/Dpgfwao1Ctu6On71buDwSRnyeP1id9UR6DKS w6e2sijPDLyWs6jsu60+uDUZeR5yEQGIv8TYFZLy23sT7LzU7UQ2ZCeTRzsWVWjoCSfsAeeLv+t ersx59MWrSsMxgJuGbEWGBlSAMnUGif4LwQI11WRxJlw9WWWdXsGFR8L9gbnjY8k85L3GPVbtu9 m7aAHrvAN
 T341fw==
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
2.53.0.1118.gaef5881109

