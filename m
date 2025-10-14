Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB3D23BD1D
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444837; cv=pass; b=lD2G0m5JnQbolg8LkOsEpHK9d2mgEFgtEhDHT0wmnheEESGgw/MlZVjTubJBQycgl23kipVoKZzx81TPwaK/cpWY121XAnP69nbuyGNaxeBpt9zdN+iuN4ROfhY7zoLAermXDUr/6KCXdER5hH47wvfVu0sds4ic8jkmR7D8OLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444837; c=relaxed/simple;
	bh=trU4GPWSKj6ArnItE80c6K/A5vMrj9njZUG1XICxuxg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZCFBFeKZVNJYLjucrcB87vdykXuSETVE2S2K8rcY+/C7M/Y3g8ARhptwboWCMm4Y+06ZTKmwjigj/Iu1WmlQyfSZgZreN73WUShOwxHkabxMjvskZTEuYQrev2AxmCWfRSGzr2la55r1+ZqpVH2G1evKXHV+ZI2pbvzoztWrl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=N/RzoNKB; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="N/RzoNKB"
ARC-Seal: i=1; a=rsa-sha256; t=1760444742; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IfgkFLCHocccPSUU36QIte3/RrApM+Yb1aFw7zY413HEMvyM1b3ibuiyyjhepzkc6hdVdI5t/IsYFA2+5TjYKBOvvHYgYZq4Z/a1SqcHZxHIxRosJQoMDwdM71wbbdaVGwsyoczdlTJTdlMcFXK0YRJDdDsygBMM85Hf/RQZPF4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760444742; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=XGT7QZEAa9D4nr/1R5se/j1HKp1DoaKozVo3KXYBBUk=; 
	b=cgSLK0muNyL5pnm10Ore9v0HnKLi1V9tJPIb49oF1A8pmsPOTulFadHf0ITc4TeqttUQAVo45sVslimlO5wOBMUSgCbb6qD2mBtL6xI9seD1EqX81PxZu8ZRa6WtRhIKGRYmomq7bdCg30TjnWLDNyyioGSoKBAsA9UjALBOmA8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760444742;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=XGT7QZEAa9D4nr/1R5se/j1HKp1DoaKozVo3KXYBBUk=;
	b=N/RzoNKBvzfKFscQBMZMLaM0gl/Mrh+bnTPl+dDXEmUoICUneUKI/0kMt105N0EZ
	m9q+BtZcboIJ7pG86dl0P/ldkHOtMX+rEU8Se0ExgYLc+p32ETk8JP6kx1m+G8Eu3ME
	RyisjkjElLf1DxLbEi7eJanWbzekvGJue5eYiFMU=
Received: by mx.zohomail.com with SMTPS id 1760444740704548.8769578740436;
	Tue, 14 Oct 2025 05:25:40 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v4 13/29] rebase: skip stripping of --trailer option prefix
Date: Tue, 14 Oct 2025 20:24:26 +0800
Message-ID: <20251014122452.1851103-14-me@linux.beauty>
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

Removed redundant --trailer= prefix stripping in
validate_trailer_args_after_config() since OPT_STRVEC
already stores only the argument text.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 builtin/rebase.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 51fb9388c7..cc90980d7d 100644
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

