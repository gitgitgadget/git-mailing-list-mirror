Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF642296BA9
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 23:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771370747; cv=none; b=I4ohIIzaACPg64zx6s2W9IBzlzV4rH3LqY7Ip3OcPcW3MkZ/0Yl0G0Go0Vmdh0HUDxeuRs8U/CjJDMZusrYmKM+dlm4kj/GKlJRvJf9ioU8nfk0tC2Sj5stz8eI1+cVH0IUZA8aFKViGA1TkAQOp2tucByUeNvyoaXDDAvFqt3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771370747; c=relaxed/simple;
	bh=yzzPYPMhRZcMyRr3Dh2h1nsYLvcETz842B/hmCXZlho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQ/ZhXV3xSEIaC31HtmTcsRxrbE7swvsRMBi7MaWfSpGpPJy9I3H859lC4LoaJjKTP9h6uVUUt8NiB+vY6O7qaX+MnryA8dpZLuRuE5UL28kWZnUjdwoS8xxvY9mFIDoP8xY3HztO+mrt0z4y2mAbQ9CL7OK59k4TFEvPhCYb0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=UU2kMDl5; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="UU2kMDl5"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771370743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6UDPZjW+n0tDwACo0kqz3tuJEqc7JEW/rl/8v0DUvY4=;
	b=UU2kMDl5RNKfaXpBbRfggTlx+AyEanTE1qGFdWvQiBHOrDKTuA1nSLaK0auHc4LevWeAZk
	BOd2ppeitI2B2iAfg4792QRLRjlvV6krVrohs4wy56qpCwoxqQEBOgco4lu3SlCD8+x0Xz
	Wch2xOfvNlA9uxLpQw6tTjvE8g1gVMWO4zbdbmg157gQ2QJ5rbnv0pURo0+JgTYSE8pYDQ
	qft9BxP4OeAybVbU1fjIgImBeW9iToH5+nwtQERKTkg2AioUbuv+B0BnMFBupr9HiNEY64
	l9V9YN6kLehJocJHYPLpBP4Eg050BgKOgD9bF0UwNkMZP0VeGEpRmJkV1+OgEQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v4] format-patch: fix From header in cover letter
Date: Wed, 18 Feb 2026 00:25:18 +0100
Message-ID: <20260217232519.24898-1-mroik@delayed.space>
In-Reply-To: <20260217220515.14127-1-mroik@delayed.space>
References: <20260217220515.14127-1-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4013; i=mroik@delayed.space; h=from:subject; bh=yzzPYPMhRZcMyRr3Dh2h1nsYLvcETz842B/hmCXZlho=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBplPjT+44+bMM+5TBhDN6W+PEAAnOEbU4jq1dW9 vnDvSpxAH6JAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaZT40wAKCRBIeX6hnBm+ 0ZI4EACwxA7oFYnJ/T8uhU074r6c1dols+Q2m2OeJTR5DJ93rVeA0+Qm2DY7nz7/B1IZvjSI0x3 XGbjDK8FfxQvauJ65JZLFRkxinG38RcQeoHXBKMtQQDdkqgtm3qHVrMqP67UkeCe6acqrNMmBof 6s93AQ9n5IJqhUVgwxKRCNI8ZY0P1M6fqqfj+fEPnJFbVVj839cC5cDlHOedK9MMgUczgrnONFy bLY8MsUFsBiDi+wVje5OEiyR6ip8Hye6iA1puHJE8JyYRDxNG1Re/leVtWB/mmY9zzu1LXWgdp6 sNGlvX/9WEVA0l2tZ0GhDKXBoIOpvCoPppk/NNK4LfjQVzSN+ML3OmudL67mFBzhkmYaupRkRSa gQEhYxLyfOkuizXlULjIg6TXMcuXQgxGNiEg6konSLY56YTuqtiV1rccdtVQDEFURF3dzJSaRvT 4btoCZOYkIMsypJlP5iLuH1IJZbAq6KiwdnvdUJfkIDuStauw4NsrH92FuMZTS+xNywbEv8HkLR tOiLCl9kvcizcwjoCyPzomUslkbRQHHqeGq03dcw6s4AwobHXnFwYzj6Jyxrg7FJWRIcXAyqrY9 1DoYXbTbsF8MHGECl0p4xXXBcmXgRFDv3nzA+SWbyANkFiIpaSmAMLiBXnclJ8UfFofLsi200E3 RTZTqILmttR7/9w==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ----

"git format-patch" takes "--from=<user ident>" command line option and
uses the given ident for patch e-mails, but this is not applied to the
cover letter, the option is ignored and the committer ident of the
current user is used. This has been the case ever since "--from" has
been introduced as it has never been used in make_cover_letter().

Teach the make_cover_letter() function to honor the option, instead of
always using the current committer identity. Change variable name from
"committer" to "from" to better reflect the purpose of the variable.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 Documentation/git-format-patch.adoc | 11 ++++++-----
 builtin/log.c                       |  6 +++---
 t/t4014-format-patch.sh             |  8 ++++++++
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index 9a7807ca71..6ac453958c 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -282,11 +282,12 @@ e.g., `--rfc='-(WIP)'` results in "PATCH (WIP)".
 
 --from::
 --from=<ident>::
-	Use `ident` in the `From:` header of each commit email. If the
-	author ident of the commit is not textually identical to the
-	provided `ident`, place a `From:` header in the body of the
-	message with the original author. If no `ident` is given, use
-	the committer ident.
+	Use `ident` in the `From:` header of each email. In case of a
+	commit email, if the author ident of the commit is not textually
+	identical to the provided `ident`, place a `From:` header in the
+	body of the message with the original author. If no `ident` is
+	given, or if the option is not passed at all, use the ident of
+	the current committer.
 +
 Note that this option is only useful if you are actually sending the
 emails and want to identify yourself as the sender, but retain the
diff --git a/builtin/log.c b/builtin/log.c
index d43ca693bf..42648dda54 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1332,7 +1332,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 			      int quiet,
 			      const struct format_config *cfg)
 {
-	const char *committer;
+	const char *from;
 	struct shortlog log;
 	struct strbuf sb = STRBUF_INIT;
 	int i;
@@ -1345,7 +1345,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	if (!cmit_fmt_is_mail(rev->commit_format))
 		die(_("cover letter needs email format"));
 
-	committer = git_committer_info(0);
+	from = cfg->from ? cfg->from : git_committer_info(0);
 
 	if (use_separate_file &&
 	    open_next_file(NULL, rev->numbered_files ? NULL : "cover-letter", rev, quiet))
@@ -1368,7 +1368,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	pp.date_mode.type = DATE_RFC2822;
 	pp.rev = rev;
 	pp.encode_email_headers = rev->encode_email_headers;
-	pp_user_info(&pp, NULL, &sb, committer, encoding);
+	pp_user_info(&pp, NULL, &sb, from, encoding);
 	prepare_cover_text(&pp, description_file, branch_name, &sb,
 			   encoding, need_8bit_cte, cfg);
 	fprintf(rev->diffopt.file, "%s\n", sb.buf);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 21d6d0cd9e..2135b65cee 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1472,6 +1472,14 @@ test_expect_success '--from uses committer ident' '
 	test_cmp expect patch.head
 '
 
+test_expect_success '--from applies to cover letter' '
+	test_when_finished "rm -rf patches" &&
+	git format-patch -1 --cover-letter --from="Foo Bar <author@example.com>" -o patches &&
+	echo "From: Foo Bar <author@example.com>" >expect &&
+	grep "^From:" patches/0000-cover-letter.patch >patch.head &&
+	test_cmp expect patch.head
+'
+
 test_expect_success '--from omits redundant in-body header' '
 	git format-patch -1 --stdout --from="A U Thor <author@example.com>" >patch &&
 	cat >expect <<-\EOF &&
-- 
2.53.0

