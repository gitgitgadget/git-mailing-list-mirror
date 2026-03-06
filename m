Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A193536074B
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 22:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772837945; cv=none; b=j+e1jnbpH5pNleiFrUKpFFlv2y9lYQr0KCkdwgMHrcVP4/Gf7LBYp79FzZZb+m77NtISQQpQTVJIZCxxQwItW7NfjY2DVUD+KG+zjWbXgGxujcyrAXcmX/F7zEN8i3qQXm4y5s/4aMwngRCx8ExDl1wRricM3EKLvACb2d0s/Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772837945; c=relaxed/simple;
	bh=gMj4oTLv3A4QXXC1SJp8fDmKkZF7wYxeHWWiwGU7cLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFxFgQUls7r0Z73t3gggDojlc/w6nlHVlruRL13rtgM8CVsKdsjkjU6nD6SJP+im0Kfoo7xTyxWH83mesuSTGMenDhbTTFRgGECsTViFLkS7slRsWnxHdUsUAxc/n/teMJyfuKeZEqxpE5jSrJC4qzc1nG79rj8+zzPPNNKmrmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=ffr90zAY; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="ffr90zAY"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772837940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6RC+3FZRvVe7ARUX50t5qpFW+1cN1ylHchtRbsb4rVQ=;
	b=ffr90zAY+RRScpInbfwcy1rPUr0co23Vmw0QyhPGrc5DF3pud+0wZX6N89DzLDkvCpwB1v
	u6fwbBVJM3NrX7KNFjMYijbwOlsUcNbrmQ+feQhqcmnu59LNZGa8y5ljG91lvGEWbca+3q
	VyPt8kIFE8ZmUiIMm7obKnuyHlAxTWT0wbWxbgNcVNVu8qkdlwlZxkFAHe/oE1stQ7cZj3
	pK2zaYqUisvRmWyYeX8nup6B4y8vnf7w6Khzpy9xm9ziHkr6BURpNVGTgDDFaJKQc5WRfH
	kdTpLCDTtsv7pJZCc4oeD5Ux+QNqu4E4NPXG5di5EZQyUj5/f2TPU06khFnTgg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mroik <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v6 0/5] format-patch: add cover-letter-format option
Date: Fri,  6 Mar 2026 23:58:43 +0100
Message-ID: <cover.1772837832.git.mroik@delayed.space>
In-Reply-To: <cover.1772232373.git.mroik@delayed.space>
References: <cover.1772232373.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5139; i=mroik@delayed.space; h=from:subject:message-id; bh=1KfpAbq9FrpoF6dZvt6V4+HRr4Y1DSnQQG4s1Jo98ek=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpq1v6Pofsz3SsxQS2Vtb88vVNOoGGe5CFEu3XV fIWt2+MNDuJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaatb+gAKCRBIeX6hnBm+ 0T9UEACJ/3czNvtXboqcdT2oASrxquv+cina3TlkzTvwl53nhQ1zJ2OEeC1AHNAQLRcGl23SOau HhBniriO7VWq8oJC4mtL3UQK7bnz2dwHRUUgqzpUxEsOzcoe8BeTUsWEYPAif4FalKWiL5ZVQT9 QA80lh1Uv1p7MZ/w//NLiEj3+caIzs/CzjAPFT4xw5NX6O2tB7bpKymhcpe1D9p01CagYL8K4mH ++PjBxHKKzRGjzCeUW4q9XiZmLlJhMj4NgxkU/816zQ23mZL112fIWSrcw3SnMvTCYNpf21JsO0 klEoqU3lRb7qzqLG9UK7dVWY+CAK61/csxTjlTjmgJVTPY0IKjWwL6mcKKet5g3XnjReaRciPCM EwOs6v6KyOTt7U1Iv1lcofnzEYrfRUU2vzSbOKuvb5frAEo/mlk1whEFZvQtvbjDZV7R/Zkmnzq Dqg/DYwAeu9uER/yrBkgaL+GOgFNu7IcSPUWiFVXsgck30l8BbpgjiyJlhq1Ko6UsVeZWwr75h4 VMdAh8YkM44M17E0RZ3oRhnQVOnostZx5wFPz5wgkVkiMHIcYNokSCS7FNwVXhqHN2XitfXAQiC Ap9pXavVFcK8oZsZunBaaOJSGHg8/vVHqxZa2YqF1pbcxEzDUjFpufuyhVp/Tz/Tl2e7cRoDWPP UZHvWalbL
 eTr6rw==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -

From: Mroik <mroik@delayed.space>

Last version

[1/5] pretty.c: add %(count) and %(total) placeholders (Mirko Faina)
[2/5] format-patch: move cover letter summary generation (Mirko Faina)
[3/5] format-patch: add ability to use alt cover format (Mirko Faina)
[4/5] format-patch: add commitListFormat config (Mirko Faina)
[5/5] docs: add usage for the cover-letter fmt feature (Mirko Faina)

 Documentation/config/format.adoc    |   6 ++
 Documentation/git-format-patch.adoc |  11 +++
 builtin/log.c                       |  91 +++++++++++++++++++++----
 pretty.c                            |  15 +++++
 t/t4014-format-patch.sh             | 101 ++++++++++++++++++++++++++++
 t/t9902-completion.sh               |   1 +
 6 files changed, 211 insertions(+), 14 deletions(-)

Range-diff against v5:
1:  169db9df4d ! 1:  cfed3bddf6 pretty.c: add %(count) and %(total) placeholders
    @@ Commit message
         placeholders.
     
         Signed-off-by: Mirko Faina <mroik@delayed.space>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## pretty.c ##
     @@ pretty.c: static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
2:  c69d6409d5 ! 2:  dc131c7565 format-patch: move cover letter summary generation
    @@ Commit message
         commit list using thier own format string.
     
         Signed-off-by: Mirko Faina <mroik@delayed.space>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## builtin/log.c ##
     @@ builtin/log.c: static void get_notes_args(struct strvec *arg, struct rev_info *rev)
3:  c3a92d8896 ! 3:  316c9e76ee format-patch: add ability to use alt cover format
    @@ Commit message
         useful than they'd like, mainly because the shortlog groups commits by
         author, and gives no obvious chronological order.
     
    -    Give the ability to format-patch to specify an alternative format spec
    +    Give format-patch the ability to specify an alternative format spec
         through the "--cover-letter-format" option. This option either takes
         "shortlog", which is the current format, or a format spec prefixed with
         "log:".
    @@ Commit message
             ...
     
         Signed-off-by: Mirko Faina <mroik@delayed.space>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## builtin/log.c ##
     @@ builtin/log.c: static void generate_shortlog_cover_letter(struct shortlog *log,
      	shortlog_output(log);
      }
      
    -+static void generate_commit_list_cover(FILE *cover_file,const char *format,
    ++static void generate_commit_list_cover(FILE *cover_file, const char *format,
     +				       struct commit **list, int n)
     +{
     +	struct strbuf commit_line = STRBUF_INIT;
4:  a6e4e1ac84 ! 4:  c522f47e5b format-patch: add commitListFormat config
    @@ Commit message
             format.
     
         Signed-off-by: Mirko Faina <mroik@delayed.space>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## builtin/log.c ##
     @@ builtin/log.c: struct format_config {
5:  40d1aa8785 ! 5:  1a4ba6dc33 docs: add usage for the cover-letter fmt feature
    @@ Metadata
      ## Commit message ##
         docs: add usage for the cover-letter fmt feature
     
    -    Document the new "--cover-letter-format" feature in format-patch and its
    +    Document the new "--cover-letter-format" option in format-patch and its
         related config variable "format.commitListFormat".
     
         Signed-off-by: Mirko Faina <mroik@delayed.space>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Documentation/config/format.adoc ##
     @@ Documentation/config/format.adoc: format.coverLetter::
    @@ Documentation/config/format.adoc: format.coverLetter::
      	Default is false.
      
     +format.commitListFormat::
    -+	A format string that specifies how to generate the commit list
    -+	of a cover-letter when format-patch is invoked. This is the
    -+	config coupled with `--cover-letter-format` in the format-patch
    -+	command and they both accept the same values.
    -+	Default is shortlog.
    ++	A format string that specifies how to generate the commit list of a
    ++	cover-letter when format-patch is invoked. This config is coupled with
    ++	the `--cover-letter-format` format-patch option command and they both
    ++	accept the same values. Default is `shortlog`.
     +
      format.outputDirectory::
      	Set a custom directory to store the resulting files instead of the
    @@ Documentation/git-format-patch.adoc: feeding the result to `git send-email`.
     +--cover-letter-format=<format-spec>::
     +	Specify the format in which to generate the commit list of the
     +	patch series. This option is available if the user wants to use
    -+	an alternative to the default shortlog format. The accepted
    ++	an alternative to the default `shortlog` format. The accepted
     +	values for format-spec are "shortlog" or a format string
     +	prefixed with `log:`.
     +	e.g. `log: %s (%an)`
-- 
2.53.0.5.g1a4ba6dc33

