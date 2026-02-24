Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F157D274B43
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925359; cv=none; b=NGJDnQoOKqpZ5eu90VLic7QjU7TJ568B8J7ACXMn9z1YG4LgivEBNyXc/qEQMxUHL75NO4m+kZE/MAK+o5JHSjpw6EvEnBIh5FIEsuvZb9L+e7KieaHyLHVSWzE+QgVHKSuPCjlFFyTZbJa2ULhoWohZpiYPtuOThBqH7o19smA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925359; c=relaxed/simple;
	bh=ehfmgTFC7dGWPyMcp+LjY3Z4mYQel+xIZmJ/S/Pf3e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpVSLXi8SY3N+YPDxEtKbGs3VDtHcI/xqJeZ8fPm+tW0BikWrPI7xXCEp5Xs+7rokWh/gs3mEW0r1zLBmPs5yQzLL8FXe+4a2AbAfcu2eFCEZUwewlaIqhkije74tZr5e2jQdD/1lZojkn61NM2Gdx4vVDkIYOX4fd+NF1SIUhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=g/I8IRuy; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="g/I8IRuy"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771925356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=31W1J7RWaQcpvN0YN2KFks9SRHEJaUvjSO3uVJW8xhw=;
	b=g/I8IRuyh2OqpCe6kXBskZE2Qgc7hedoQZJxgguG4Iw96dN0jlBk6QojloNiMX29y5x1OH
	mZZwPo4jedyZkiO0XRr1bzwUjbItcIc23r9FZ6VxEqotXueCT2MLn6oEVf8rCJ7JvufoR3
	tWRXwuGDPmWJNMlWgnbAeoi31Nm2iBiGfKi4VIQVIb+6envp9emiDFRT3wgTITrc15hYLU
	Z4lFtF8l49KTehe0bHajCFJG6SVPGuZ2ZOXbRthXxlzt0L5dk/Oe8Zt+Sd6wCxx1dcBxWC
	h4jZlful3AqvZCwkxWdOVaTDpuw5x+BnWtUDx8HRTXzL6+Feku1WqNzl7jlWTA==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2 2/2] format-patch: add commitListFormat config
Date: Tue, 24 Feb 2026 10:29:02 +0100
Message-ID: <6a0c7aecfd6dc1ee873d5e81110b723fa2d225fb.1771925291.git.mroik@delayed.space>
In-Reply-To: <cover.1771925291.git.mroik@delayed.space>
References: <20260224040400.751247-1-mroik@delayed.space> <cover.1771925291.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2789; i=mroik@delayed.space; h=from:subject:message-id; bh=ehfmgTFC7dGWPyMcp+LjY3Z4mYQel+xIZmJ/S/Pf3e0=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpnW9S562KlmCdjX6+FXpAc9ygufiTXBuKjltyl P650cf1BpqJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaZ1vUgAKCRBIeX6hnBm+ 0QI4EAC9ivdcfIosOvG+RniORyeCIV6IS1LnBExl41W9nOr21tJHci+lo7c8RDEazUrDovc0DBe gnIVG8GmhuXqdwiqbK34cKQ6DhrpevyOLOlG+laNqLQsD8BR15G45PEj0zdfTVDqlDBGuBqj5JM nvNJNP+QsmsXE0CfVIerSE9igQAuaKnxm+WUT38izVHCymwsKphVKL5+qmi2ovmEZAlzGhHBmTm zVIVXfNIt64Z4LKTLLCDWMDsmsX5l91XhO9E2Ag1zxh6d0JmrU7jxL2Gk6JV6fhXJ27TvzCvQA1 pfyRSL0/GI9A61vcL37G919YTeVH4UvRkGn1mWthrDT07XdSZGAAkVZcm4mWxyXIB8VzpQJlkw9 COwsaxf4b6Lb8LLLI/DEcolzkRKXe4M2wWgYJneDbtta8No0OEiBALqjVFBrgzxNv43wHgJHCPK phEfToqTGrNhkv7llwLPIGuFujN0HcvCgHg6Y36/cSotbWcjkFtntao6Nk+FLb8Yu9vBbE8JSlq lybkZc8xoHzRTZfUR+Xf0wUC91+NQ852qTkT4cvbw4eSJCDWuXdcdyqnqMYWtLfJhOaesBq64Ft xqDycldempuQxLwMcTvUDzz/KT7LCpeL6CIOcz+21q8cHICsZgZm4N1LFFnS9rmkBSa7mqf0Ja+ zi1Fv0NC5
 +xYvjg==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

Using "--cover-letter" we can tell format-patch to generate a cover
letter, in this cover letter there's a list of commits included in the
patch series and the format is specified by the "--cover-letter-format"
option. Would be useful if this format could be configured from the
config file instead of always needing to pass it from the command line.

Teach format-patch how to read the format spec for the cover letter from
the config files. The variable it should look for is called
"commitListFormat".

If commitListFormat is set but not string is passed, it will use the
"%s" format spec, if a string is passed will use it as a format spec, if
it is not set at all it will default to the shortlog format.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 builtin/log.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index 5e99660d7c..725ebf13f6 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -886,6 +886,7 @@ struct format_config {
 	char *signature;
 	char *signature_file;
 	enum cover_setting config_cover_letter;
+	char* fmt_cover_letter_commit_list;
 	char *config_output_directory;
 	enum cover_from_description cover_from_description_mode;
 	int show_notes;
@@ -930,6 +931,7 @@ static void format_config_release(struct format_config *cfg)
 	string_list_clear(&cfg->extra_cc, 0);
 	strbuf_release(&cfg->sprefix);
 	free(cfg->fmt_patch_suffix);
+	free(cfg->fmt_cover_letter_commit_list);
 }
 
 static enum cover_from_description parse_cover_from_description(const char *arg)
@@ -1052,6 +1054,19 @@ static int git_format_config(const char *var, const char *value,
 		cfg->config_cover_letter = git_config_bool(var, value) ? COVER_ON : COVER_OFF;
 		return 0;
 	}
+	if (!strcmp(var, "format.commitlistformat")) {
+		struct strbuf tmp = STRBUF_INIT;
+		strbuf_init(&tmp, 0);
+		strbuf_addstr(&tmp, "log:");
+		if (value)
+			strbuf_addstr(&tmp, value);
+		else
+			strbuf_addstr(&tmp, "%s");
+
+		git_config_string(&cfg->fmt_cover_letter_commit_list, var, tmp.buf);
+		strbuf_release(&tmp);
+		return 0;
+	}
 	if (!strcmp(var, "format.outputdirectory")) {
 		FREE_AND_NULL(cfg->config_output_directory);
 		return git_config_string(&cfg->config_output_directory, var, value);
@@ -2318,6 +2333,13 @@ int cmd_format_patch(int argc,
 		goto done;
 	total = list.nr;
 
+	if (cover_letter_fmt && (strcmp(cover_letter_fmt, "shortlog") && strncmp(cover_letter_fmt, "log:", 4))) {
+		die(_("--cover-letter: invalid format spec"));
+	}
+
+	if (!cover_letter_fmt)
+		cover_letter_fmt = cfg.fmt_cover_letter_commit_list;
+
 	if (cover_letter == -1) {
 		if (cfg.config_cover_letter == COVER_AUTO)
 			cover_letter = total > 1;
-- 
2.53.0.3.g6a0c7aecfd

