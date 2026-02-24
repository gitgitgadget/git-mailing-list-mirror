Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26332243956
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 04:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771905871; cv=none; b=I/Lmos24KNCZvCcYRqkv8VbTNh5sJvw98anKJ+q2yfT23FwUpPfhHlDShvCsppdGD7Jt9QGS19xSV3XRAHUjk8RAicMTr5SazMfpaZsuemLtl0UFfYz5mvNbP2wvXn5VhUFjsiBAbr8yEH6TrJn6K5+vXArCU0uV/7lrFbScYfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771905871; c=relaxed/simple;
	bh=P023i+sCY7aR/c7IfnH8XXUwq0Vw8UBYsVxm75B7Arc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exzA6RI3LoIc6UAMLjwUtn1HYvujKDD53F8fY2WDhxBMwd0A0gA9T/xzh3ZUAbZsjcjRay7cyu6ELyfnPCzSj6HZGv6kT60xShQgaZUAtG9dp69LO/3OXMx9H+AwFzuxQoHsNyJuKrWq5NZ1iHakeuuZGOtGd8IDaYPwos1rwmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=FJ61m1F8; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="FJ61m1F8"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771905868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O5peLVz+Y4PjLLuaQ6Cns3SJFZaXmAZ3lfKP1ZqLv1s=;
	b=FJ61m1F83rb5k3Gc2v+ohhYUEcfavLFbOBK6byjWF6XmJhzBmlof9t0cFFBgAek0ppn8gF
	bq4t2wNmfVOy9dQA4m36lk+5SCVP5yU09Sa9HX1QrrOQBvgdWXrtQLyebjuIpTfnpyUN00
	mKollYuc7tnA3Dc2SZUjzNrkajZhG6C6WwnesPmT6sDlE2pjYeJReyosthZWjgmxbI14aa
	bu+HysVzcO8+C7UqvwFn9bwqH/Pc3UMnCbvtycBUWbiGTcyhPNBMKtvxQWVSDmvVrmkpi1
	WhZRcEVsh/iwXD9VSDXHI0nq3ktrxKcHZfmkAQEKFts6rVtMNSUa08jABBfDSw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] format-patch: add commitListFormat config
Date: Tue, 24 Feb 2026 05:03:58 +0100
Message-ID: <20260224040400.751247-4-mroik@delayed.space>
In-Reply-To: <20260220230633.132213-1-mroik@delayed.space>
References: <20260220230633.132213-1-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2789; i=mroik@delayed.space; h=from:subject; bh=P023i+sCY7aR/c7IfnH8XXUwq0Vw8UBYsVxm75B7Arc=; b=kA0DAAoBSHl+oZwZvtEByyZiAGmdIt2iV7L14Jop4JN473tO02Z436C8O6lBA9kHZGC4HbqTV okCMwQAAQoAHRYhBP8rLfsrSlLCbCzJtkh5fqGcGb7RBQJpnSLdAAoJEEh5fqGcGb7RPyYP/1lL v1DUTMjay7f68GpZOSNhy9Jy+Rga7Xs68lDqXcMiB+H6GrbFNkThYUMIDoYSMKc68EGDXDVFnT/ Hf/RyTbdyqvKmPR57rwkxguplmNr84bpX0LJpPqnkypvyezRDsV3rSfl5DB89noh7H7vLsQJDYb KS4F6S+tFM1WA5IE30PKPFYDIX7P4dh+XJ6WeYzPXnpa0TPkq3c2A+7iperr4LIYDdtDbtuKrz/ Pqak3xaGIqbVqjB3WSchUCjxYf2d7CCeZj95qHTw3tkRWNazsnPF3zVBEK/KtPHi5HRy3RFLgvi QTBttRExSsMq9x0IrzWznpCJE99iEr2dqw7Dn1czET3ZQrUP/mBNuZKgQF1PE/VSfrk9z7PeVi3 0K+DM5pIMp+EpZ5VOk7Po50SgxQc/+Ul96OSgcakMStkMBo1s43dZvsX6k1e3DT686sy12M8nX6 kRiDX/PaLC1qI2JNhPoCiS6uVtHbohvn6z0B8UR92FETharcnb/mIu7j5HKB/cmISATCxCPMB2J DAH0IcwfXiAehf9IV6VZFKSK9BI0CegXKgpEA+nKe32UHJpgvyaD5sxQyaepDe33rYd7YDppPWn mJr/6wyo6HKpFmrix5fAKOw4KFe+Q+0vCXZXvkbAKeKVa2NO5eGHxp4NkABTWA38/XTC3KtJRaP YZW+Z
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -

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
index 80ec79efe8..7f41c83e18 100644
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
@@ -2321,6 +2336,13 @@ int cmd_format_patch(int argc,
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
2.53.0.4.geaa3cc5f7e

