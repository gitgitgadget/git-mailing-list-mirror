Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573B02EC099
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111649; cv=pass; b=V3mjGcgNkEDN5dqmXqgpclfEqgUu0LWVQiZhUMy7UD+tlje88Xs36TwRsmXF5HQNXJiL2J+UhTO1vdZemIeNLqbDQ7Lk6+6Xl8ljvvW1aczRMHDya+JXyoXwOqGQ9C2XZm/Hw+uf6VFcBZpzY7rG3VbsdTTERc0Vy1kKbsCQLgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111649; c=relaxed/simple;
	bh=tYtAm9azdNoDx+KxrT7UK7hnpontnkONlfx+lGzNdvc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZYd0E/y5/HLgkyqN5owXXTLwGufArMGwqunz5oK8Xyt5Z5VGytcBuU3CmQJ+FcqPz1KTAvI69rrSkcYCzDa8OrX3NjaCXt6V2tC32gFqr2sEmrDRrTVbV90dYDS1zQsnHC+NI/OUQo9x3WceSrX76/GoPJgjkZaXzypddBb1O4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=PFwdjSeS; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="PFwdjSeS"
ARC-Seal: i=1; a=rsa-sha256; t=1761111605; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EuvlfW4yoMZ6syMGUD1bhCjW/Lf/4ak/sG32DJVmSYVHTPX3ryGIT7iJkpZpjlF09Q8u6ZcvXs//azaGQVJFkTXY70s2m7k2p5u3vSx5Qbh6BxWIiSqefeCX23EfbfBXGagO3crsN5Bq9Iket0R1ihdJhijzIENIRQ+/id7mR20=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111605; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=JuRHfollfCAC8Mrvb064WFwn5V/ahajrvpbgC6Tv6PA=; 
	b=WwIE2i0+IWS5L1itlEIxxMgHvTV4T0BnK6AEiL/EaM+Ly3jWr8jN44z5UD1Qb2my6kh5MfcMO7ZYiaAzgbahKnNP0npWeTGQ5Fvt/zuemN+aZjJWhjXBlDCX9nM1/hFsb3bBJOQnGWrZhMHXHvHTH6Gi4Gj5SvcXgEdEMloj4t8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111605;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=JuRHfollfCAC8Mrvb064WFwn5V/ahajrvpbgC6Tv6PA=;
	b=PFwdjSeSVXkxygzMVUOfOjlI4sl+YJ/P/fDW0eLMRA7ntWj0P8/PRPL8GAVrXsVD
	FveDer7ZoBoi3zEkAn5W4sNHFq/D8Ksa7zKIU+SK93qi9EmngNbj7wrFF9bLy7BeUun
	l1bgrs/sOiGjyF1mdTj/FIgHGCyMAjtIslafmIQk=
Received: by mx.zohomail.com with SMTPS id 1761111602906160.80367597274687;
	Tue, 21 Oct 2025 22:40:02 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 03/29] trailer: drop --trailer prefix handling in amend helper
Date: Wed, 22 Oct 2025 13:39:23 +0800
Message-ID: <20251022053951.602605-4-me@linux.beauty>
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

Make callers pass plain trailer text instead of recreating
the option prefix before invoking interpret-trailers.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 builtin/commit.c | 2 +-
 builtin/tag.c    | 3 +--
 trailer.c        | 5 +----
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0243f17d53..67070d6a54 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1719,7 +1719,7 @@ int cmd_commit(int argc,
 		OPT_STRING(0, "fixup", &fixup_message, N_("[(amend|reword):]commit"), N_("use autosquash formatted message to fixup or amend/reword specified commit")),
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
-		OPT_PASSTHRU_ARGV(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG),
+		OPT_CALLBACK_F(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG, parse_opt_strvec),
 		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
diff --git a/builtin/tag.c b/builtin/tag.c
index f0665af3ac..65c4a0b36b 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -499,8 +499,7 @@ int cmd_tag(int argc,
 		OPT_CALLBACK_F('m', "message", &msg, N_("message"),
 			       N_("tag message"), PARSE_OPT_NONEG, parse_msg_arg),
 		OPT_FILENAME('F', "file", &msgfile, N_("read message from file")),
-		OPT_PASSTHRU_ARGV(0, "trailer", &trailer_args, N_("trailer"),
-				  N_("add custom trailer(s)"), PARSE_OPT_NONEG),
+		OPT_CALLBACK_F(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG, parse_opt_strvec),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of tag message")),
 		OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-signed tag")),
 		OPT_CLEANUP(&cleanup_arg),
diff --git a/trailer.c b/trailer.c
index 2fe49df23a..b7b0029e05 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1235,12 +1235,9 @@ static int amend_strbuf_with_trailers(struct strbuf *buf,
 	opts.no_divider = 1;
 
 	for (i = 0; i < trailer_args->nr; i++) {
-		const char *arg = trailer_args->v[i];
-		const char *text;
+		const char *text = trailer_args->v[i];
 		struct new_trailer_item *item;
 
-		if (!skip_prefix(arg, "--trailer=", &text))
-			text = arg;
 		if (!*text)
 			continue;
 		item = xcalloc(1, sizeof(*item));
-- 
2.51.0

