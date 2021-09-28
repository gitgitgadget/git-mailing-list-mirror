Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8BEC433FE
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5433F61131
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240811AbhI1NQc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 09:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240711AbhI1NQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 09:16:25 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8CAC061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:14:46 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t18so58046508wrb.0
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y2ga8NrhoHT62xcigXV6kP7xXqqvMgVdPXbBGem337I=;
        b=SJc2xfk82cG49oQt2MncZbeaJaAsBkZJOiXNFxqp20frEPaIwZ1ESEHNf9JNnQNM2V
         HnUvOIYFK0SWIlBwqanllewfZ/Q5/yEA4PoPOOnMy+QLa4n+yBZ4Yg39eLIa7145DtKg
         so0v2ODbwkADErvak4O9sUbE1IE72Yn4L8dyPIXNgtdvrYUGJsVeOrQPOgdvDw5RclUx
         bNDHFwHDufFG/9O9nOX0iECUOb2wPTzxSHZ5G5ogfDRSE2qZOXh0oll7ewZgTSYSjkMJ
         1/VXMFOJvm848+zxFmBQXVwZvIArb4l/aiNzfTt7HdHUtOVTZQFpKF6XYJjhhW3EeBhM
         QL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y2ga8NrhoHT62xcigXV6kP7xXqqvMgVdPXbBGem337I=;
        b=JMGCSbPtkT3yGjWKhUTnF2EbR0BI5pXN/cUnuMMn2nsq00+27dqaC8k7WdQ/BuRLE8
         4hlk7rY+CPz0XTxBTXT3jTyain+6aMeerze4Bn4EzXlNUk5Z18jzcMMfVHMr1lnR7MOq
         iD6fDbC4wtUhGq/+xjyDQX9DQEuI4HAbr4FWDme+4TqGrs7a8+4mjSSHkyCQkmbsHRUE
         iUlFfGFu4iw3ggNGtBb2LeA5tJE4xPk6btO/w4ueL98Ggr/cipNbFTWjcA+1hXhP+SPB
         8uiDuA265eNwwq8r25klRrF1Tu8b/xEfSzmUoO4V8lUiZ9YwO3ruNZqBFyyHDjLzKo9V
         7pNw==
X-Gm-Message-State: AOAM532E2DM3ygCrR8zHfjVvSe2x6JotlYJxPfdoUL2hVXuXPBW3u3Zg
        ORfcZpOqqyv8AbvjAuIRBb5QN9mk5YVOuA==
X-Google-Smtp-Source: ABdhPJyyQ8uD8zvIuDK/YIm9SMMTllRrV7SpYQvZWlHzpnq0NNRvz5V9JcvIblsGw3cwtYWROEDb7Q==
X-Received: by 2002:a05:6000:8d:: with SMTP id m13mr6430827wrx.109.1632834884355;
        Tue, 28 Sep 2021 06:14:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l21sm2617981wmh.31.2021.09.28.06.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 06:14:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/10] parse-options: change OPT_{SHORT,UNSET} to an enum
Date:   Tue, 28 Sep 2021 15:14:31 +0200
Message-Id: <patch-10.10-a28ab961125-20210928T130905Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1339.g53eae12fb46
In-Reply-To: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
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
index 57e95846e83..1eb3b51f753 100644
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
@@ -318,11 +323,11 @@ static enum parse_opt_result parse_long_opt(
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
2.33.0.1340.ge9f77250f2b

