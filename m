Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDED313535
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444753; cv=pass; b=UkIw1zmg99RjXsTviL6btAVhkkUk3IkII1KzpPqMs0SFrVGGrpNYdfnq6fn0lcg66tT/W3GMVBaIwFkY2KG9E8mxoJoq+2fUVMIt1wJZUk4Ck7zLmFDU4XFlIpYzTsUr566jGUrIi/J9Ea41DRB402ja1krg9cj4ipyujuUeDzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444753; c=relaxed/simple;
	bh=dffLIoDmA+t2F8TkYc/ManEbAg4iypUeW3ygTapJYwA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RiRH84IBmxLE/VYwSh5MVJO5gpx0w6AXPc2WQ6XLplCG/Jr1nDKGxgamDkoMuVGXB8FVj4H5l/daE7Ge2R4u7r2frNIpamjkcM+1eqeVtj5JT3dXhj7EyiKIygDo6Yyp3x+egEgljUnyOTTnhlakxSuZLlT/BisG3xen6RX3t7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=apDctJSV; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="apDctJSV"
ARC-Seal: i=1; a=rsa-sha256; t=1760444719; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gQu16KoV+N70jXAHqMhO+ulrCR4k9LAWOk6g0v5JcyXRYBmehwN+E7hhDE/b8Jf1k7Mh0UYHnXt7bL3Uo8ecaRTg7ukk/m0NcwbmJLcD5oGQ8er9ExZ8csO8Vm9KDglvDAbzKuAzM6hO9dFLBrBs9oMuQMFetm6fpdaz7bj7llk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760444719; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=JVPSWSeEUdxiAZF5CuF3MIKbGD7u/Wbr2hC/LQ3sqQI=; 
	b=Vs1W63P2KwpLTVlPHcuUk20AGjJ3jrC86I8cNnV0c+BQSZ8ag9B20BjDPxYiD5dQAf64d7Fq0pEfYhFFjc6/oA3iEipJMmOF5xxao83foXfZziHqMqEKxl7of3mysAPotasvWbRQ8GyACoA6LTQywA2e/XX7Xl/Fs5uxJpx2qss=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760444719;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=JVPSWSeEUdxiAZF5CuF3MIKbGD7u/Wbr2hC/LQ3sqQI=;
	b=apDctJSVSfFumJCydGqua+wnGJVp+o3bbyKIKcKzFDkxw8si9giBQoywaDPay760
	wN9pivS28gEFFwlTXnGwM967nzwyc6D1a39F4j0ZThxHV/GlmMdSd2KNQEZ7Tr4nj1A
	wjx7+CpRFmVKCmL6M+9XmS1TZsT2iX4GoD7YnYnY=
Received: by mx.zohomail.com with SMTPS id 1760444716755497.2535381713053;
	Tue, 14 Oct 2025 05:25:16 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v4 03/29] trailer: drop --trailer prefix handling in amend helper
Date: Tue, 14 Oct 2025 20:24:16 +0800
Message-ID: <20251014122452.1851103-4-me@linux.beauty>
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
index 8aec466b5f..42ac6f58a2 100644
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

