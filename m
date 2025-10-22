Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BA02EDD6F
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111753; cv=pass; b=J97VCvTQbE1HH1Xx+H8uloMwcbYJcgda7180C7fI3SuPSfErGIqfwA/vKqV4pTqYDEaGWxklkdbF3bmenRmoYEbFljK+kOly1svlujq9GKFkK1kyXOa/TTTfZfBC/wGueLt6nMzjfn21gArSyFGPDr3J7iC0ujhJQ5zSaax9XaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111753; c=relaxed/simple;
	bh=lMENA3dUqP/npa6UCsXQXNc4M7PFhwEVPqFz6qywyvg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldeT9mLqZAQ+82ML29PPjkbQ/VDCHx1A19eQFyKri+0xPYUyO7W9gJ0bTFJWVk5qAgR5fFJBdCiyxr8GSpq9SrfRKPg5gVpQa0Ws0iRbP5FZKrfVhNSHpaCoDq/A7ZVT6NAFn6ZplISZlBIMth2KF8TUXFkYbHR3qcWeVwuUWsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=TICUexpt; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="TICUexpt"
ARC-Seal: i=1; a=rsa-sha256; t=1761111625; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZAPN8A6K4DUa/RQ+QD8ZemWKKlOyCQIGWMxagOdRgroS0cdhpntOtvKvdN1PplegoD8enuFEpptZxjcjXhhs6SBMvQns5cl89XLbR9R+RBkrqVmBjGvdRHKkieKzSRqwzUAGTq9UHg1rfGWpPVS2ID6HlRUmE3JDEfceLn46qek=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111625; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=P5+oYwF9vc0Qh5r/H9lKdCZw4VbIhwxz1a7hbNfQFho=; 
	b=fufg7vO5KUa69Desg6vQtzeAgt4pp9Q2SRdr0w/p8aBLO/vqSjUVr+B6qmHVS7rm0j4eyP9uN2ZmsWbeuMDpyp4ixX1tsGIJMmN527t9YzrkkfZkj81k1fGktDjdKo8ncVnznuckSOPKfxInb0BS5dTMIb926UrJ+zXUeRipF3k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111625;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=P5+oYwF9vc0Qh5r/H9lKdCZw4VbIhwxz1a7hbNfQFho=;
	b=TICUexptOo3NGQWSAUStnRpC3KlHzoWM5Mh7IfGIq4NjDx9cmHflogTDGMRTI8Il
	b2FgcBNGibSZFg3zIyO12NO4RflZDdGIhCtMMqc1yfNrzuajbLxw1wyZioupTwvDgvG
	uW2qdITQ9kQwuFGslzrshc8MaQu9Pnh84n1Bmzcw=
Received: by mx.zohomail.com with SMTPS id 1761111622074649.3800565398782;
	Tue, 21 Oct 2025 22:40:22 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 13/29] rebase: skip stripping of --trailer option prefix
Date: Wed, 22 Oct 2025 13:39:33 +0800
Message-ID: <20251022053951.602605-14-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022053951.602605-1-me@linux.beauty>
References: <20251022053951.602605-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Removed redundant --trailer= prefix stripping in
validate_trailer_args_after_config() since OPT_STRVEC
already stores only the argument text.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 builtin/rebase.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index a950005dfc..3ac1eda61b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1128,13 +1128,9 @@ static int validate_trailer_args_after_config(const struct strvec *cli_args,
 					      struct strbuf *err)
 {
 	for (size_t i = 0; i < cli_args->nr; i++) {
-		const char *raw = cli_args->v[i];
-		const char *txt; // Key[:=]Val
+		const char *txt = cli_args->v[i]; // Key[:=]Val
 		const char *sep;
 
-		if (!skip_prefix(raw, "--trailer=", &txt))
-			txt = raw;
-
 		if (!*txt) {
 			strbuf_addstr(err, _("empty --trailer argument"));
 			return -1;
-- 
2.51.0

