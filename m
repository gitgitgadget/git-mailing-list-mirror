Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47B8313544
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444770; cv=pass; b=P38YHXaVvw6xeCtNYuASczyaJ72Yt4sWqu3G82X5WS6w1PdEXKUnXSumWUU+nTDc5g4MIlaEuIJ7wj7okufMj4+q9Ihftnxll81iRjlKtNcZM8MyDhrkdN6RzvdfDbguc2oDPF+zMWNyW8t9G0VLuDdMvhbTSmd1C59lhWsAg4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444770; c=relaxed/simple;
	bh=WKXfcj2tpKTg0m0FOBZ3FYw5G9RWIptRCxy/Cqld9l0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMtKxnxJjBZd6O3IHOPiLZhxEdj4Uwq42GoCYFyp5IeQY6gfCoTsrcCXhKLJVK7C4S8BiWuM5dHckqjLl+PZ4x2+fpDV5nqoB+rHsCE0hTyVyxqwBey2rAUKMyLUyQCL8pHnY0fSlSCnVRauokumdaX7TnR4g3SC/ea/cbVn+b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=kNpYkIZS; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="kNpYkIZS"
ARC-Seal: i=1; a=rsa-sha256; t=1760444724; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gwagHkYRTXU7vJPGb6/ZNIL6P+vooYUof9hRksydXYSrZec2NkVZshiICYK5iEky++jG4pbY+iuQ3WyErazSQWsrVZmCu3m7GRHSGhkDsaJC4bjKlAb+45oEz10djp/gJ8MGYKrmB8Er8PjHu7QDnwU0Zk/69xtB3+bn2toNqew=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760444724; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=GndceRWJf9GKbc+esELD+MARY4IHfhnk3MLah01TjmU=; 
	b=YhHWFFusd8/faKHCfztGUU1RtXEsejYQoMN4vU7fZtsxQYmB4DT21zuKagwWmlv3FF2SNqa+AN+WAdFMiMeT0vcFmqKAPpH0nEwOtNAwNJpJZ3rTZzD02ljm60CWMuvXX2/9KDymbmwHoP2SkIj45YR5Yni6W+W1/0ln29Ua3d8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760444724;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=GndceRWJf9GKbc+esELD+MARY4IHfhnk3MLah01TjmU=;
	b=kNpYkIZS2N4emCa87Xzj/KQvhGuVo2NuExMVEwbwCoojvPuEXSH9lJKn0CwmvC/K
	CKEj1lWWpNHg+4uEnWZqD7n/VceQcWvra/JCQ+jwdr5gKwI0QTUkh2sdALWQtW9ViGF
	VZk7NyyOd/TuEQvVgdk43FBw2OM3RK6h1MlWH0Is=
Received: by mx.zohomail.com with SMTPS id 1760444721874138.16214819921458;
	Tue, 14 Oct 2025 05:25:21 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v4 05/29] trailer: use bool for had_trailer_before
Date: Tue, 14 Oct 2025 20:24:18 +0800
Message-ID: <20251014122452.1851103-6-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014122452.1851103-1-me@linux.beauty>
References: <20251014122452.1851103-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Li Chen <chenl311@chinatelecom.cn>

Switch had_trailer_before from int to bool
to match its logical use. No functional change.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 trailer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/trailer.c b/trailer.c
index 3169e315c0..ac756020a3 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1266,7 +1266,7 @@ int trailer_process(const struct process_trailer_options *opts,
 	struct trailer_block *blk;
 	LIST_HEAD(orig_head);
 	struct strbuf trailers_sb = STRBUF_INIT;
-	int had_trailer_before;
+	bool had_trailer_before;
 
 	blk = parse_trailers(opts, msg, &orig_head);
 	had_trailer_before = !list_empty(&orig_head);
-- 
2.51.0

