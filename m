Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4DC3C0622
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285083; cv=none; b=VhVauOFeUIJ8XYEZHnxXZeBmF8podl3Xe/ncOhLkQPnzHhX2ty8v/qEBL20DO5jLLjNhIHhlYDEscI2hM8czzt7Xo9b0EYNeBoYOD58GSysML2TBB6JU5y2DRE38Pewy1ms1TtBB15jSdYLjU3FnDgPjnUQHTyC+LRkBzLgkaP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285083; c=relaxed/simple;
	bh=ZB+ZxTf40QsuE8BEM/TIqOnv274G2dt3FQXVhCtzSiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldY+pEgR66PptIXmINULu1CXU0yyJ7Bgpa6ftSVj+hCBTuGoAs3yi40YQz3vNmrsqjv0zadPQ/o8+e6CXjsfrfXvgU3xx0TXcBOYvTSd5nzQb5aQbHLVTU+ZFfBSWtnf2jgIbt9KqPl1BXtcHgjRu1J6/6eLMouijfscodXP6Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=W0aYJER4; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="W0aYJER4"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1774285078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97c0dI2wmOeKD8yAbtiBmUnUdzl9Jx/KxMGexkRsgqU=;
	b=W0aYJER4Y0tUSzPQf+NxNPk7st/fOdgEmZbl+KrCv0QwzOkfy3QNFh2ELZJhlsdbGZTxFr
	rfoFyKT1yCBYQZPKFqgj2XYTg+YSdpIDb3W9szPv3ycwyShCFQ0YizNn2jEG974IHv04eo
	YyGWw7ZuVUh1jy/9JzdlfFUWF9XvQSwoz322RQctQQHpmEQ9GCIoIJnFjCGTAOD26T186K
	eFTRebCyZz/sFZn1O2PyNZtIr56Y//NWwWIVY0kdUFPBX1TLmrsYfNWbAQUHgjf0qSoAQ3
	vrGOh8qJjnEKPf9QPUu2vGttViJqqK4U19RcW8nTadHawsNbw1rnQMOuQMGL5A==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v3 8/8] format-patch: --commit-list-format without prefix
Date: Mon, 23 Mar 2026 17:57:35 +0100
Message-ID: <d125458e3351e6007831dcf84c70e91924b8883d.1774284699.git.mroik@delayed.space>
In-Reply-To: <cover.1774284699.git.mroik@delayed.space>
References: <cover.1773959395.git.mroik@delayed.space> <cover.1774284699.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3440; i=mroik@delayed.space; h=from:subject:message-id; bh=ZB+ZxTf40QsuE8BEM/TIqOnv274G2dt3FQXVhCtzSiY=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpwXD0CuTr7+DuSygiPpuTBNh16fEoOl7S5xiw9 cJBvSVm34SJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCacFw9AAKCRBIeX6hnBm+ 0bUWD/9wWkHgJwIjJry8D6XTAFOU0XeXgyjkBbo75hKDAKbbB++VraxSEbtBF+OqwBz7yr0znTo z16UE2EhqHYokKWLRMCoX74mayc1WZVDq+G2j7DPNDewI/N99Wyrg0qM3dxLGfJqxTPwN9hYcRL X5m1xQ04x4BQOh/TsUkJNYI61UG/LFsrYUKastopt7OKFjdELtaRo2JPcOTpXr2lhh6eGFYB/hN WvHNvWLYlTdj2RZZ+FxT7DEB5+9vGVH5aqfYttq/RzAtPvpvm/82F8DQt5uLm5wBRVucZDN7Ekl JP68Kg4FktZRVSaIM20NSgfRRs9b+sMnc8GtEF33+grxx83LUVWh1JWW3V+aGiUB/P3YvrR28Jc IivsW//7J0ZpDjvQuniAkr3iRxqiGJ+piSDgZ54FGUyEnX6sTLsCb2LNMH7wkSKHAfi1h1TGMqz oTKYtM2gV9wDu9mlrElAFKWALSdCaL0T4eaRVhaT3CMM78Hxs/es/qPE2aPiJzI8bW7yAToMrG6 Ms2r72ReyXfT2WvD+SIux+/S3WNNXks+qNT2z+uRRpCHCyfVpHQTd8mYDWLdZPzQDWKncJ0FF8J mY3VteQ/UNnABS8IgHn37qWa3xbUOK3i3SXfvNYtnHe8PBo6+U0TXoONySJy0o2ckM9V54yW9aj BaY5KT5Q0
 IsSebA==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

Having to prefix a custom format-string with "log:" when passed from the
CLI can be annoying. It would be great if this prefix wasn't required.

Teach make_cover_letter() to accept custom format-strings without the
"log:" prefix if a placeholder is detected.

Note that both here and in "git log --format" the check is done naively
by just checking for the presence of a '%'.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 Documentation/git-format-patch.adoc |  4 +++-
 builtin/log.c                       |  2 ++
 t/t4014-format-patch.sh             | 24 ++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index 55cc680685..c52dbcc170 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -326,8 +326,10 @@ feeding the result to `git send-email`.
 --commit-list-format=<format-spec>::
 	Specify the format in which to generate the commit list of the patch
 	series. The accepted values for format-spec are `shortlog`, `modern` or a
-	format string prefixed with `log:`.
+	format-string prefixed with `log:`.
 	e.g. `log: %s (%an)`
+	The user is allowed to drop the prefix if the format-string contains a
+	`%<placeholder>`.
 	If not given, defaults to the `format.commitListFormat` configuration
 	variable.
 	This option implies the use of `--cover-letter` unless
diff --git a/builtin/log.c b/builtin/log.c
index c6cf04350a..ad7b7215fe 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1448,6 +1448,8 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	else if (!strcmp(format, "modern"))
 		generate_commit_list_cover(rev->diffopt.file, "[%(count)/%(total)] %s",
 					   list, nr);
+	else if (strchr(format, '%'))
+		generate_commit_list_cover(rev->diffopt.file, format, list, nr);
 	else
 		die(_("'%s' is not a valid format string"), format);
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 7571cc582b..7517094bd6 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -392,6 +392,30 @@ test_expect_success 'cover letter with subject, author and count' '
 	test_grep "^\[1/1\] This is a subject (A U Thor)$" patches/0000-cover-letter.patch
 '
 
+test_expect_success 'cover letter with custom format no prefix' '
+	rm -rf patches &&
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_when_finished "rm -rf patches test_file" &&
+	touch test_file &&
+	git add test_file &&
+	git commit -m "This is a subject" &&
+	git format-patch --commit-list-format="[%(count)/%(total)] %s (%an)" \
+	-o patches HEAD~1 &&
+	test_grep "^\[1/1\] This is a subject (A U Thor)$" patches/0000-cover-letter.patch
+'
+
+test_expect_success 'cover letter fail when no prefix and no placeholder' '
+	rm -rf patches &&
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_when_finished "rm -rf patches test_file err" &&
+	touch test_file &&
+	git add test_file &&
+	git commit -m "This is a subject" &&
+	test_must_fail git format-patch --commit-list-format="this should fail" \
+	-o patches HEAD~1 2>err &&
+	test_grep "is not a valid format string" err
+'
+
 test_expect_success 'cover letter modern format' '
 	test_when_finished "git reset --hard HEAD~1" &&
 	test_when_finished "rm -rf patches test_file" &&
-- 
2.53.0.1118.gaef5881109

