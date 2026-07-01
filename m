Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5D03C1970
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782941101; cv=none; b=RvY1+0L4C8ipoYKw/hV8jinCdxO6/jy8Po/hiHVrse2NEXW4jaKkKSRlQ/C47wJyS5bsTCjNGm2Mw3EULyqGCHPG/2zXHePrz+2EY32GfpyEgfYt1+lhAqu8AVmK5A+Y27Svczc1zboEqDuUqwskLJyVYdJPduX37qM2uFSrT1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782941101; c=relaxed/simple;
	bh=K/W40NcWsPaohqSBcnsZ+8KSkfLj4ExZ3jWNUyaO+lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mO1/VWKthY9K6l8ZsuKwf4tVpGVWji0TJr4U+dscQqjZtfFXKEzKCfGynzvg5zKKdzHq+Cjn4BgqHVFtLmavjedWx2j3z98O4Y9alYjj9YEJMidTHmcJRmDvzzufq3wQhB8Bm1LHwg8+MrjVTEfLqMWrHxs0Z92nXpQKZjrnGRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=tp5K/2Ds; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="tp5K/2Ds"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1782941093;
	bh=K/W40NcWsPaohqSBcnsZ+8KSkfLj4ExZ3jWNUyaO+lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=tp5K/2Dsa50u7gbbf4F/QE8R8eED0jXAEiKIVJCjii9CAbKjis7G7CxZ1fBIqU4VM
	 luzSF2XScKaBNIgrjDm4GJuBoHZP6pZC2yr+QjdZ9r8dETAkVjNGljg5UfoUDqw247
	 16aY3GvVZy8mAwdMWXcgbWxl0OOG+B4CwJbu3U9d7qSYs+YPm/sVO2ke6v3cO3rHuK
	 wBJtivuh9HH/7bOPsg0FZYE54RiekqpnqK3pQxp4wmRq0EVuBWLh9EZpIgIqoMj4o+
	 uDGJ4fGsi4okurJkdI5zctsHuDCtVYSq1MnDK75Okgz2/FkIKs2YlCJw4dFGbcfrpZ
	 7lUgY06WILGxtxvAzlIzo+a+y04xuPWAB+PGA32GSGNIxzd1sgZzYGVmoepbH4msZ/
	 vrpvipFQy9H2qrQ+jzIGAYuPp+9YhlJAnT2e4nbVysBWEpzHPe6PbgaupvDXBnqrcn
	 uEOvv94m03kTZz/T4Rvfw5nTt0R0au7QfkNcGCA00sUmlVs6iax
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:cd97:af94:901e:255d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 17102201AE;
	Wed,  1 Jul 2026 21:24:53 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2 2/4] parse-options: add a separate case for help output on error
Date: Wed,  1 Jul 2026 21:24:40 +0000
Message-ID: <20260701212442.1430084-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260701212442.1430084-1-sandals@crustytoothpaste.net>
References: <20260316220742.1286157-1-sandals@crustytoothpaste.net>
 <20260701212442.1430084-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we parse a command line option such as -h or --help, we currently
exit 129, since that is the exit code when help output is printed. In a
future commit, we'll change this to exit 0 instead, since we're doing
what the user wanted successfully.

However, there are some cases where we print help output because the
user has provided ambiguous or invalid input, such as an ambiguous
option, and we'll want to exit unsuccessfully there.  Make this easier
by defining a new return code, PARSE_OPT_HELP_ERROR, that can be used in
this case, while reserving PARSE_OPT_HELP for those cases where the user
has requested help directly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/blame.c        | 1 +
 builtin/shortlog.c     | 1 +
 builtin/update-index.c | 1 +
 parse-options.c        | 7 ++++++-
 parse-options.h        | 3 ++-
 5 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index ffbd3ce5c5..65d43c7d48 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1013,6 +1013,7 @@ int cmd_blame(int argc,
 		case PARSE_OPT_UNKNOWN:
 			break;
 		case PARSE_OPT_HELP:
+		case PARSE_OPT_HELP_ERROR:
 		case PARSE_OPT_ERROR:
 		case PARSE_OPT_SUBCOMMAND:
 			exit(129);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 6b2a0b93b5..cd262bd376 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -433,6 +433,7 @@ int cmd_shortlog(int argc,
 		case PARSE_OPT_UNKNOWN:
 			break;
 		case PARSE_OPT_HELP:
+		case PARSE_OPT_HELP_ERROR:
 		case PARSE_OPT_ERROR:
 		case PARSE_OPT_SUBCOMMAND:
 			exit(129);
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 3d6646c318..ac4610ec94 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1133,6 +1133,7 @@ int cmd_update_index(int argc,
 			break;
 		switch (parseopt_state) {
 		case PARSE_OPT_HELP:
+		case PARSE_OPT_HELP_ERROR:
 		case PARSE_OPT_ERROR:
 			exit(129);
 		case PARSE_OPT_COMPLETE:
diff --git a/parse-options.c b/parse-options.c
index f4647e0099..a623961800 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -583,7 +583,7 @@ static enum parse_opt_result parse_long_opt(
 			ambiguous.option->long_name,
 			(abbrev.flags & OPT_UNSET) ?  "no-" : "",
 			abbrev.option->long_name);
-		return PARSE_OPT_HELP;
+		return PARSE_OPT_HELP_ERROR;
 	}
 	if (abbrev.option) {
 		if (*arg_end)
@@ -1037,6 +1037,7 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 				usage_with_options(usagestr, options);
 			case PARSE_OPT_COMPLETE:
 			case PARSE_OPT_HELP:
+			case PARSE_OPT_HELP_ERROR:
 			case PARSE_OPT_ERROR:
 			case PARSE_OPT_DONE:
 			case PARSE_OPT_NON_OPTION:
@@ -1072,6 +1073,7 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 			case PARSE_OPT_NON_OPTION:
 			case PARSE_OPT_SUBCOMMAND:
 			case PARSE_OPT_HELP:
+			case PARSE_OPT_HELP_ERROR:
 			case PARSE_OPT_COMPLETE:
 				BUG("parse_short_opt() cannot return these");
 			case PARSE_OPT_DONE:
@@ -1099,6 +1101,7 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 				case PARSE_OPT_SUBCOMMAND:
 				case PARSE_OPT_COMPLETE:
 				case PARSE_OPT_HELP:
+				case PARSE_OPT_HELP_ERROR:
 					BUG("parse_short_opt() cannot return these");
 				case PARSE_OPT_DONE:
 					break;
@@ -1132,6 +1135,7 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 		case PARSE_OPT_UNKNOWN:
 			goto unknown;
 		case PARSE_OPT_HELP:
+		case PARSE_OPT_HELP_ERROR:
 			goto show_usage;
 		case PARSE_OPT_NON_OPTION:
 		case PARSE_OPT_SUBCOMMAND:
@@ -1197,6 +1201,7 @@ int parse_options(int argc, const char **argv,
 	parse_options_start_1(&ctx, argc, argv, prefix, options, flags);
 	switch (parse_options_step(&ctx, options, usagestr)) {
 	case PARSE_OPT_HELP:
+	case PARSE_OPT_HELP_ERROR:
 	case PARSE_OPT_ERROR:
 		exit(129);
 	case PARSE_OPT_COMPLETE:
diff --git a/parse-options.h b/parse-options.h
index 0d1f738f8d..3ec8ba5cc8 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -57,7 +57,8 @@ enum parse_opt_option_flags {
 };
 
 enum parse_opt_result {
-	PARSE_OPT_COMPLETE = -3,
+	PARSE_OPT_COMPLETE = -4,
+	PARSE_OPT_HELP_ERROR = -3,
 	PARSE_OPT_HELP = -2,
 	PARSE_OPT_ERROR = -1,	/* must be the same as error() */
 	PARSE_OPT_DONE = 0,	/* fixed so that "return 0" works */
