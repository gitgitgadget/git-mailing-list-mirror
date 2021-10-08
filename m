Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B9EC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6912060F4F
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241274AbhJHTKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240187AbhJHTJz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 15:09:55 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC31C061762
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 12:07:58 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t8so32841037wri.1
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 12:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0QXO4fjeBefOTyARWqTPwOds6RKJ3TwZZPrwpYeA7xA=;
        b=qxhsKmG1Q1f76he36fMCcurl2An5AwHk3YTeFccv2SgugVXivlqQDXImeFgAGjlR0I
         fGcJ40b1jOhCcpO2gTiTNwmnRPpqxyOh3vBShCclngXiCPL0w2RBp8Uk5F6NFFko/ptT
         m+6/cWk3+C4Lyi2GeF0xwaHGg9aK4jr/0g1OkycOmftZ48De2JWYZSwZP/fptynB25/G
         ahT0kmJxhwUddM7cSj/SHr62NSuPI1Up6DDO2GiJfZFnEYVRjncPJlXMyDio+EnbvWvY
         thZ3leOCs7PCDV7sbyozXLUMjjsBDjAonkiHS91Mrw89ci+qnxUQO5BJ50PUVUsu77FL
         SK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0QXO4fjeBefOTyARWqTPwOds6RKJ3TwZZPrwpYeA7xA=;
        b=5MLB39lgHk1ayCzG+i+fHmqzrDCVBShTzXLipeyo/Zf3tMY0X77jgJ9Mb+XeaQiw/w
         unuyymgBrUcLKDlj+ZR7BUEoJ+q3bsC+4OGpshS6Lo1JGAb6Vg/QxdhJ7ZqZm6ckcqB3
         wqNreyVM1KpPmAkzVb9TTtCsJ1jn6dsxrFvKC4z7eu6c5IG2Kbx7m7sa5pETDgaF9rvL
         VowJabMUTDRvax7y2ebTCKUD5uUL4aDnUPhicxydYbSGxrvQHxOqLfEVNKR6HJCuGOYQ
         ovIWLZIxGEL2r3eeB2aXXarMW9NBrtwA9u3uC1XUdS3J/DaJKLJ1qAWep9Qakgyhb5+v
         BHgA==
X-Gm-Message-State: AOAM530AS69ApT8lgugmeFfOT2nVix1P6d6Ju1D60CsjlioNodPt3lUo
        tIRtYkLh2hWcYO9vEMxEn2yh3qxe3jlGJQ==
X-Google-Smtp-Source: ABdhPJwo2z+0zK/hDZkXoD3g/xMKnYYU6+4TBp9wLlUJYpkb5piv4ahjv2cp6ul4ErlYZ1evxUh9VQ==
X-Received: by 2002:a5d:414e:: with SMTP id c14mr1456015wrq.415.1633720076879;
        Fri, 08 Oct 2021 12:07:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x17sm169882wrc.51.2021.10.08.12.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:07:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 10/10] parse-options: change OPT_{SHORT,UNSET} to an enum
Date:   Fri,  8 Oct 2021 21:07:46 +0200
Message-Id: <patch-v3-10.10-e05627d3634-20211008T190536Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1446.g6af949f83bd
In-Reply-To: <cover-v3-00.10-00000000000-20211008T190536Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211008T190536Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the comparisons against OPT_SHORT and OPT_UNSET to an enum
which keeps track of how a given option got parsed. The case of "0"
was an implicit OPT_LONG, so let's add an explicit label for it.

Due to the xor in 0f1930c5875 (parse-options: allow positivation of
options starting, with no-, 2012-02-25) the code already relied on
this being set back to 0. To avoid refactoring the logic involved in
that let's just start the enum at "0" instead of the usual "1<<0" (1),
but BUG() out if we don't have one of our expected flags.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 64bd4c32854..2a2c0ee24f2 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -8,8 +8,11 @@
 
 static int disallow_abbreviated_options;
 
-#define OPT_SHORT 1
-#define OPT_UNSET 2
+enum opt_parsed {
+	OPT_LONG  = 0,
+	OPT_SHORT = 1<<0,
+	OPT_UNSET = 1<<1,
+};
 
 static int optbug(const struct option *opt, const char *reason)
 {
@@ -22,7 +25,7 @@ static int optbug(const struct option *opt, const char *reason)
 	return error("BUG: switch '%c' %s", opt->short_name, reason);
 }
 
-static const char *optname(const struct option *opt, int flags)
+static const char *optname(const struct option *opt, enum opt_parsed flags)
 {
 	static struct strbuf sb = STRBUF_INIT;
 
@@ -31,15 +34,17 @@ static const char *optname(const struct option *opt, int flags)
 		strbuf_addf(&sb, "switch `%c'", opt->short_name);
 	else if (flags & OPT_UNSET)
 		strbuf_addf(&sb, "option `no-%s'", opt->long_name);
-	else
+	else if (flags == OPT_LONG)
 		strbuf_addf(&sb, "option `%s'", opt->long_name);
+	else
+		BUG("optname() got unknown flags %d", flags);
 
 	return sb.buf;
 }
 
 static enum parse_opt_result get_arg(struct parse_opt_ctx_t *p,
 				     const struct option *opt,
-				     int flags, const char **arg)
+				     enum opt_parsed flags, const char **arg)
 {
 	if (p->opt) {
 		*arg = p->opt;
@@ -65,7 +70,7 @@ static void fix_filename(const char *prefix, const char **file)
 static enum parse_opt_result opt_command_mode_error(
 	const struct option *opt,
 	const struct option *all_opts,
-	int flags)
+	enum opt_parsed flags)
 {
 	const struct option *that;
 	struct strbuf that_name = STRBUF_INIT;
@@ -97,7 +102,7 @@ static enum parse_opt_result opt_command_mode_error(
 static enum parse_opt_result get_value(struct parse_opt_ctx_t *p,
 				       const struct option *opt,
 				       const struct option *all_opts,
-				       int flags)
+				       enum opt_parsed flags)
 {
 	const char *s, *arg;
 	const int unset = flags & OPT_UNSET;
@@ -313,11 +318,11 @@ static enum parse_opt_result parse_long_opt(
 	const struct option *all_opts = options;
 	const char *arg_end = strchrnul(arg, '=');
 	const struct option *abbrev_option = NULL, *ambiguous_option = NULL;
-	int abbrev_flags = 0, ambiguous_flags = 0;
+	enum opt_parsed abbrev_flags = OPT_LONG, ambiguous_flags = OPT_LONG;
 
 	for (; options->type != OPTION_END; options++) {
 		const char *rest, *long_name = options->long_name;
-		int flags = 0, opt_flags = 0;
+		enum opt_parsed flags = OPT_LONG, opt_flags = OPT_LONG;
 
 		if (!long_name)
 			continue;
-- 
2.33.0.1446.g6af949f83bd

