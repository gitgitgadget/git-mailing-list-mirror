Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC493612E7
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 22:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772837946; cv=none; b=LBrru4/neaForYyOKh8RIWW0mZMMn1QKKf8ZtB+jzMnT3BO+tEm0yDAvL5JrhYXuFDBrL6b/MWyaVeY/vUhW0lAmvvpYi+HSV62jWnzP1MhAnUxh81RJemJWT+JeQjDeuTLCvtx+9ITirdk3vc8FCDoQHcs3b6Ne3sJuC8sQLfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772837946; c=relaxed/simple;
	bh=/O+NEqE24zFqiHS+Z6mhN1GFQ+sOl8fq0xrR+Da3j3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJrNnFPWhFayqAK6D3pNqbNzqR0/n2EDA3hWhnzq8at2M0gxD1MI7bvWumDPyrNHBvnIhYg1Pga07FVKTs5AUSXxH7k+enqCxZQ0pihdI5MzMnwDC905vwaVJ3+yAOq/yrP54kXqS11C/BYtgDEUMwZ2aKSpfpweq8LZ7oOCLfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=fZMAZppS; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="fZMAZppS"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772837943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=128HolsTTq5HcuoU/zfGb1214KYhJErWdWpOFTwCp9s=;
	b=fZMAZppSiE8XGyYj/1700pGyKYTG20Nb9RWye39nM5PYQwjszH6CsdWSRA75jK9BziDWL7
	WeTpUmSKlbpT3EFjQzO2ILOlMcfFZDvGN3S9OPnE7ucPG7w/bER1d2k1f5BrIRBPbGlZ/c
	e5olZ07J7X7VNSXn+TuiuidQAxGbscWwyrik0R5i4vz6JA5D3Kw/J2lSOWa45tulRfU1e1
	R8YVzlrdMi7R+Ytce/90xo3s9tKB9gYjVhLsfTGPdkDYDyju/1BfC+pglMfgA+bhPz4oij
	yBmJ4Zr+vPSl8f755BcHSLuqXUUg4MgiWp0tUU6oclJuJccdJH+2u3suvTUSwg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v6 4/5] format-patch: add commitListFormat config
Date: Fri,  6 Mar 2026 23:58:47 +0100
Message-ID: <c522f47e5b574c0c889c40284c71c36158b6bb6e.1772837832.git.mroik@delayed.space>
In-Reply-To: <cover.1772837832.git.mroik@delayed.space>
References: <cover.1772232373.git.mroik@delayed.space> <cover.1772837832.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5929; i=mroik@delayed.space; h=from:subject:message-id; bh=/O+NEqE24zFqiHS+Z6mhN1GFQ+sOl8fq0xrR+Da3j3k=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpq1v9R7/phtr7TIQiNa02nDq2/DquR6Nz89Job KWVOd4uh1aJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaatb/QAKCRBIeX6hnBm+ 0YoID/4/1HiIfKNf3z3hB7T2cOBiPVie8rkuj1NJriG93ub0s8Uc13S4Tl+OFcpi+WN4l46BiFF pnPJvw27Q36yWIAAmhILIzowOTksEUWVVmLPwBFoNxhWOockEtDAs0yYI69Hz5Obza1y71CAviL a1uXj0XBmakUj7gbBCshKXzSVJlTSTZkKH68iqUbzBjX9CJEpPVzQEMXAGfZhc5hkIsspY2nxha x86Zx/ikvo+hNi6sf/CP4zTif6Tkdh7j/YT/oHxC2OVrrtxTAEMWOUKDhmyYt/yolFAQSM0988O vDuPZHErqHLngF4GVHU6XBsOcVCu4SPwtAMBgYIzQkZHErR1wWGidPybnfDHIiaMNRd7J7uUpO0 DB0M9KabEx4SKoS39GzBt1TfsnQAKPUnufWdZzTZhus2nLUB9h2VmFENvKrpB0JcQ4dTZ6EnfWn RQmzC5/F17ajaksVt5GzTS14SP0XM5vvlAHgR8PF9yEt98qS+vdDKx6v0F9c4abc4dW/fHC2SwE /OTg0Lnzbj3wgKYEw7xt47dutx6lI+qG954+aanLBUO6A/0CKM7q50STA6Cr9/YyOVJRsZ5MteL KaAc5h+eMWGQ/dxomYidMY2M+8G5DcpmSrP2cltLu0CA8y4CwCARqA0J4P4f1BRczwO2U06SfOo ZRS6kuL1p
 ZTLwMg==
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
format.commitListFormat.

Possible values:
  - commitListFormat is set but no string is passed: it will default to
    "[%(count)/%(total)] %s"

  - if a string is passed: will use it as a format spec. Note that this
    is either "shortlog" or a format spec prefixed by "log:"
    e.g."log:%s (%an)"

  - if commitListFormat is not set: it will default to the shortlog
    format.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 builtin/log.c           | 21 ++++++++++++++++
 t/t4014-format-patch.sh | 53 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index 95e5d9755f..5fec0ddaf9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -886,6 +886,7 @@ struct format_config {
 	char *signature;
 	char *signature_file;
 	enum cover_setting config_cover_letter;
+	char *fmt_cover_letter_commit_list;
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
+		if (value)
+			strbuf_addstr(&tmp, value);
+		else
+			strbuf_addstr(&tmp, "log:[%(count)/%(total)] %s");
+
+		FREE_AND_NULL(cfg->fmt_cover_letter_commit_list);
+		git_config_string(&cfg->fmt_cover_letter_commit_list, var, tmp.buf);
+		strbuf_release(&tmp);
+		return 0;
+	}
 	if (!strcmp(var, "format.outputdirectory")) {
 		FREE_AND_NULL(cfg->config_output_directory);
 		return git_config_string(&cfg->config_output_directory, var, value);
@@ -2329,6 +2344,12 @@ int cmd_format_patch(int argc,
 		goto done;
 	total = list.nr;
 
+	if (!cover_letter_fmt) {
+		cover_letter_fmt = cfg.fmt_cover_letter_commit_list;
+		if (!cover_letter_fmt)
+			cover_letter_fmt = "shortlog";
+	}
+
 	if (cover_letter == -1) {
 		if (cfg.config_cover_letter == COVER_AUTO)
 			cover_letter = (total > 1);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 458da80721..4891389a53 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -428,6 +428,59 @@ test_expect_success 'cover letter no format' '
 	test_line_count = 1 result
 '
 
+test_expect_success 'cover letter config with count, subject and author' '
+	test_when_finished "rm -rf patches result" &&
+	test_when_finished "git config unset format.coverletter" &&
+	test_when_finished "git config unset format.commitlistformat" &&
+	git config set format.coverletter true &&
+	git config set format.commitlistformat "log:[%(count)/%(total)] %s (%an)" &&
+	git format-patch -o patches HEAD~2 &&
+	grep -E "^[[[:digit:]]+/[[:digit:]]+] .* \(A U Thor\)" patches/0000-cover-letter.patch >result &&
+	test_line_count = 2 result
+'
+
+test_expect_success 'cover letter config with count and author' '
+	test_when_finished "rm -rf patches result" &&
+	test_when_finished "git config unset format.coverletter" &&
+	test_when_finished "git config unset format.commitlistformat" &&
+	git config set format.coverletter true &&
+	git config set format.commitlistformat "log:[%(count)/%(total)] (%an)" &&
+	git format-patch -o patches HEAD~2 &&
+	grep -E "^[[[:digit:]]+/[[:digit:]]+] \(A U Thor\)" patches/0000-cover-letter.patch >result &&
+	test_line_count = 2 result
+'
+
+test_expect_success 'cover letter config commitlistformat set but no format' '
+	test_when_finished "rm -rf patches result" &&
+	test_when_finished "git config unset format.coverletter" &&
+	test_when_finished "git config unset format.commitlistformat" &&
+	git config set format.coverletter true &&
+	printf "\tcommitlistformat" >> .git/config &&
+	git format-patch -o patches HEAD~2 &&
+	grep -E "^[[[:digit:]]+/[[:digit:]]+] .*" patches/0000-cover-letter.patch >result &&
+	test_line_count = 2 result
+'
+
+test_expect_success 'cover letter config commitlistformat set to shortlog' '
+	test_when_finished "rm -rf patches result" &&
+	test_when_finished "git config unset format.coverletter" &&
+	test_when_finished "git config unset format.commitlistformat" &&
+	git config set format.coverletter true &&
+	git config set format.commitlistformat shortlog &&
+	git format-patch -o patches HEAD~2 &&
+	grep -E "^A U Thor \([[:digit:]]+\)" patches/0000-cover-letter.patch >result &&
+	test_line_count = 1 result
+'
+
+test_expect_success 'cover letter config commitlistformat not set' '
+	test_when_finished "rm -rf patches result" &&
+	test_when_finished "git config unset format.coverletter" &&
+	git config set format.coverletter true &&
+	git format-patch -o patches HEAD~2 &&
+	grep -E "^A U Thor \([[:digit:]]+\)" patches/0000-cover-letter.patch >result &&
+	test_line_count = 1 result
+'
+
 test_expect_success 'reroll count' '
 	rm -fr patches &&
 	git format-patch -o patches --cover-letter --reroll-count 4 main..side >list &&
-- 
2.53.0.5.g1a4ba6dc33

