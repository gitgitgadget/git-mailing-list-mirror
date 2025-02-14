Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7046026770A
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550753; cv=none; b=L4LiReMG0ttUxauQ+fPUNAXDi5T8hBsHoRsSQPxtJi1GQVFTkZ4bEgt0DDrvuTXf/nAEH2GgeVxy/A4PO7cqrzUWxAhW96vS+Q2g8ObDiuZUr/zhVlSFip3V/cC7iCvCUz1j0zHRrbKXd876WqmhhVGIWCxxTrn5RuLvymw+FhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550753; c=relaxed/simple;
	bh=kBxRPRswLqrehMv0K9l5YEr0cXGkn/7kzOGW/hbSmmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q1VoW22vg191jDMsM6mrgHKtdLVsWj5HuArfW947+4GqTLUBvAJHyxXEoUg4e4CmldI11cCerbgYi1L5N9mFFCNqiaC13iEwDFshBJYF/KVjcMUhcDZ4it6+LVi+6bLagP7H3oHMjjYhTcPD5fjLDbxIa+qLLNfslbGEMwGdKL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Wvv9z2EM; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Wvv9z2EM"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 61E9B4429F;
	Fri, 14 Feb 2025 16:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739550745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1VDCkI4yWo8OCZWMd3pJjyNZkitQ8U6xPgYD2d1e0Fg=;
	b=Wvv9z2EMJtAysJJk0K665D9kUf+PHPM7upWsL3NGGNODNXkHr/9ndnqQkVuRk0xm3q2Mql
	wDRtRKgBksUN0NmnT2VP7Oyv8gh4iUXV+LUD/qW4GBa4Ih93+ryjEjdGO1lzXfTbOl99OV
	Khvx0hDvvKoO/KKF0qBvmchpDWCwkGR6MNfZqZ4yo5NCiRAbBlYxO4E7f96GcLVZSFfhE+
	daArKkbGBzS4sQf0tImn8M+hAcBYhpiBAFROrmhTyzFC9QRQSiZmvgmSH1quK7o13sw3XB
	hIknSeW3EavdLlwGkRiA07NonDLBaDLS/03687wV6Ux/P111/ziPlrM1z7rc5A==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 14 Feb 2025 17:31:13 +0100
Subject: [PATCH RFC] builtin/log: include From in git show --format=email
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-git-show-from-email-v1-1-df6469635454@bootlin.com>
X-B4-Tracking: v=1; b=H4sIANBvr2cC/x3MPQqAMAxA4atIZgNp8QdcBQ/gKg5iUw2olVZUE
 O9ucfyG9x4I7IUDVMkDnk8J4rYIlSYwzsM2MYqJBk06J6VKnOTAMLsLrXcr8jrIgoW2xBlRZko
 Dsdw9W7n/awdtU0P/vh9FBh6/agAAAA==
X-Change-ID: 20250117-git-show-from-email-62f0e4004d7d
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Emma Brooks <me@pluvano.com>, 
 Patrick Steinhardt <ps@pks.im>, 
 =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>, 
 Daniel Li <dan@danielyli.com>, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2802;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=kBxRPRswLqrehMv0K9l5YEr0cXGkn/7kzOGW/hbSmmQ=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBnr3AZjm32YawOpRk+7SYk6gTrnmXBTIz3ohkFG
 nmLvSKw8ZSJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ69wGQAKCRDRgEFAKaOo
 NnSzEAC3Nq249kK0/IvHMgaOXDO0AyGyZGcM/Yh0Wpknpn4v9nsf7/WV83iDxv6ihbiYWGt0wPc
 8lgnnzu8TN0Y7SUqohjnXP8TkvfVOKBuchtmshxqj8armbD3nl1Psv5p0MmkTbyXpJSYENCT2ef
 TsECwCY/AnprTMkdq7sXLo/88QRH1SMQLWce9zSlORoTu9ebfJYFEdvh2ZnVriwjr02GS71u/vf
 JrGh4XLg/MCxaLg/X0kOF/fpWmSHB2E7PsF6181oferWDQWSSCOyoSSe/wUqavWTX+915vx5Xur
 nMEeF3GtivdvxdFzxJsWKSlwh+UGFZ2LEGqAiML6Ti09tZ3QjNBuZeHvJTkBsPI8HjLyr/9Oqzv
 0gmmS3LDSOkMLhI4C3QlZjrEFsbS4F6NlvcOKGTLCY4Di6a960P8ftpxYmpHAdPp+bPHxxIHC3q
 me+F/Bq7EYueZZL32H+IwUDYJ+/AEjNrS6pEEtvJ/Zfaau0LQHONgPIXLhkw9GLRCu/9tqi/uUG
 vhLukFgVT6zd0EHt4zNnWhT69lqUxY2TmJ/GRAxu97uQRoa3Ca0zlna/sVozzW73NTsxjNj/eMV
 AxYD2MTYdYCWsSt8ifTaHWBhvfpxYGQd/ddu5R+qq8zZHBM4Awqyl2leq3epXyE8Z1QTEmghKSh
 IO/lAAIR72z1tCA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeetnhhtohhnihhnucfiohgurghrugcuoegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieefkeffteefleevvddtveetveekieeguddtudfgteethfeffeefgedvhffftdefnecuffhomhgrihhnpehfrhhomhgpihguvghnthdrihhtpdguihhffhhophhtrdhnohdpphgvnhguihhnghdrnhhrnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemjegthegtmeeirgguvgemjeelgeekmeegtdehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemjegthegtmeeirgguvgemjeelgeekmeegtdehledphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtp
 hhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuggrnhesuggrnhhivghlhihlihdrtghomhdprhgtphhtthhopehmvgesphhluhhvrghnohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-GND-Sasl: antonin.godard@bootlin.com

Currently, when the format.from and format.forceInBodyFrom options are
configured, the command `git show --format=email <commit>` command does
not include "From: user <email>" in the body, even though I believe it
is expected when using this format.

While the code exists in log-tree.c to take the identity into account:

  if (opt->from_ident.mail_begin && opt->from_ident.name_begin)
    ctx.from_ident = &opt->from_ident;

the mail_begin and name_begin would always be null pointers
because opt->from_ident is never filled in with the identity from
cmd_show.

This commit adds the `from` member to struct log_config, and reads the
user configuration to fill in rev.from_ident. It also reuses
the existing force_in_body_from variable to take this option into
account.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
This is probably not the best solution, as we already have the from
member in struct format_config, so adding it in struct log_config is a bit
redundant. However, this is an RFC that hopefully will get my question
answered: is my belief to have the From field shown with this command
correct?
---
 builtin/log.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index e41f88945e..16a4889c01 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -113,6 +113,7 @@ struct log_config {
 	int fmt_patch_name_max;
 	char *fmt_pretty;
 	char *default_date_mode;
+	char *from;
 };
 
 static void log_config_init(struct log_config *cfg)
@@ -592,6 +593,19 @@ static int git_log_config(const char *var, const char *value,
 		cfg->default_encode_email_headers = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "format.from")) {
+		int b = git_parse_maybe_bool(value);
+		FREE_AND_NULL(cfg->from);
+		if (b < 0)
+			cfg->from = xstrdup(value);
+		else if (b)
+			cfg->from = xstrdup(git_committer_info(IDENT_NO_DATE));
+		return 0;
+	}
+	if (!strcmp(var, "format.forceinbodyfrom")) {
+		force_in_body_from = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "log.abbrevcommit")) {
 		cfg->default_abbrev_commit = git_config_bool(var, value);
 		return 0;
@@ -799,6 +813,13 @@ int cmd_show(int argc,
 		return ret;
 	}
 
+	if (cfg.from) {
+		if (split_ident_line(&rev.from_ident, cfg.from, strlen(cfg.from)))
+			die(_("invalid ident line: %s"), cfg.from);
+	}
+
+	rev.force_in_body_from = force_in_body_from;
+
 	rev.diffopt.no_free = 1;
 	for (i = 0; i < rev.pending.nr && !ret; i++) {
 		struct object *o = rev.pending.objects[i].item;

---
base-commit: 9520f7d9985d8879bddd157309928fc0679c8e92
change-id: 20250117-git-show-from-email-62f0e4004d7d

Best regards,
-- 
Antonin Godard <antonin.godard@bootlin.com>

