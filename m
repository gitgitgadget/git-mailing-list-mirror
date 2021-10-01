Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDF4C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C74F961A3A
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354558AbhJAObg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 10:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354579AbhJAOba (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 10:31:30 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B0EC0613E4
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 07:29:32 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w29so15811354wra.8
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 07:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fbZPlM83ZBxDsP+bY7JpDa/BpYAVuJjI5iCwjav2AVQ=;
        b=VfeiIhYkAnmChTlDtBvOaemmiwJm75suC6PIV3Kg0+ca6OEKksbteau1/0mBNmQozI
         7H7gc+lRUlWVMuZ9qmsdp47cA/IVzblTGtLhBFC/ya9eJ58yfb8tEDJrfINFCCkYGpJK
         lTitx7f4Osgle3oxfHs7a8lioqf0Ie1kO+DaUR+xy4/jBJBqDPB3CCYClZwBkg4lgDST
         pBPF63zrsLf1ofafuqn7B5lyyoQ0GnPbE/pbIkfPYo59oi5rSnMn+YycpvK4feHxetA2
         yIGFrMvh2Najm+UHQycaMDFgbItpWswdma+5D1OHuPTjZIqM7vOScufgs7G8jdgj0XK5
         gmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fbZPlM83ZBxDsP+bY7JpDa/BpYAVuJjI5iCwjav2AVQ=;
        b=Rsr1kmXXWcbuAr4LSrCr39EFnc42VV6o2Yo8cnYG3oPOxnQfQ0ZYqkei8oz5EsNYH6
         aCtD3NwuIj07cDvUOXXrnZlTsl31cRlX/3WABXIeqRghoIBRIfj9pSkPHHBl+qWGQ9gQ
         tgaVbEYs9aLZLV06xVhnZhrBKLG5wegBXJpvbtWWBD5ohe+TcT5Nr8HY6CXo1MJRlr0C
         w+u68awfaH3VS500NgiNG5+u/Yof2cGLQNbXHo3D3gpe8TdemwvyYyXf672T1W6zrpTl
         mN+vPQiLVdS87eZygFy4Y7LjlPKHZ7WAgeHbyziNmpScaKah8tJ8qxcUu/nSHB+KWpJM
         dFuQ==
X-Gm-Message-State: AOAM530/M9knZhizmkGkV4eEc3NHitxK892tt6LNPylPKr0prM7BAvnW
        K1eJngh7dreMwBk8IQwjQnBI7jh4p8ZmQQ==
X-Google-Smtp-Source: ABdhPJwAltm1DKmRNUwPn8cfFSQezeYoyXj5WR2azpLoDFntAHfEMhiwok8FZd8WnevfZys9kaesfA==
X-Received: by 2002:a5d:4481:: with SMTP id j1mr13159514wrq.6.1633098570644;
        Fri, 01 Oct 2021 07:29:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 189sm9042069wmz.27.2021.10.01.07.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:29:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 11/11] parse-options: change OPT_{SHORT,UNSET} to an enum
Date:   Fri,  1 Oct 2021 16:29:17 +0200
Message-Id: <patch-v2-11.11-4fbc07fc7fd-20211001T142631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1374.gc8f4fa74caf
In-Reply-To: <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
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
index 0239c6bd418..61c294b7895 100644
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
2.33.0.1374.gc8f4fa74caf

