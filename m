Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951F7C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 12:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E00961183
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 12:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhIUMqz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 08:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhIUMqv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 08:46:51 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5501DC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 05:45:22 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t7so5538464wrw.13
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 05:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1EuEEBMVtmLo/bzIo7nu9zFESDmTS126Xd5mMlfqkXI=;
        b=YUrwMP1uvxOOfoHg4Qi2WBCYaZkYyr5nXBeawLpvBcvOazgr0hKRfzAoS5PaZwSRnO
         d8ThqeEu31uhWtwVVooHk67Zn+kaxS0+ipbgYgCMxD4iwJ3EKdpxjFyHpdoS2Xv0eMyE
         RWliqdlCRN1uFH5y2+PECFoxisvJZoFs6F7Y27wKzNXVtlLdpSTfpuf/7lMxoEYbQqX1
         LC3ycUyXAfqFvQTUFfyBNLgqjWN5xwXBVYcZyfb2Zby8ly2CQr+YnIrzh7/+Pf61HQPo
         yAlwEsfHj9aPqUISrS02ZKfVhFg6vYIKoxhGpWcMMFXA/ts0fD8XkKDJMjS1BWuoRSyp
         hwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1EuEEBMVtmLo/bzIo7nu9zFESDmTS126Xd5mMlfqkXI=;
        b=l+PhnteBzvwxDiFd8yLXPYDRo3Ce/u9jx1JBjHMnexhYNBit1t0sgjbLW4cB1sKz1M
         XWn3P0eK9wwEZNTFjDtiXzdOlCGFkkiHfL5kBonZCCfB8pEGkzSbUKaAihQg//0crOy3
         vgVnxYKaqGVOvoiwPeX8Pm8rmfeV7ep2HyiZp8idDqcdx4yX77jkUwHzt2LgbLlThBXM
         DSz73wgP+RbK9sa84QQgBOWxTAeYq5wM95j1WKLK/nOPq1yKF+p0KhGBMq0olXYocUF0
         qHJs2RcLgrDCoMo4i2jUwjgmGw2/KkZ/KyR6II/zwG33jsiZcQOfqiR2rU+FWBMxtJ5H
         3ZwQ==
X-Gm-Message-State: AOAM532TnknXQUe2+gAPHwLFjnF8IWTVGtp4Xel+ijUPPFMawI2ukTGj
        PuGAd63EyzTe+DPVu+03MiDjo1zYYz3zew==
X-Google-Smtp-Source: ABdhPJz/v/ZSjPXOC6svCBxjxIT5ETEYU8MPXRfuhBX980HWFpE1uiqBxd/wrKEcKGubzujMeOmedw==
X-Received: by 2002:adf:c184:: with SMTP id x4mr34904557wre.266.1632228320438;
        Tue, 21 Sep 2021 05:45:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i187sm2957038wma.0.2021.09.21.05.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 05:45:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Hamza Mahfooz <someguy@effective-light.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/5] grep.c: mark eol/bol and derived as "const char * const"
Date:   Tue, 21 Sep 2021 14:45:16 +0200
Message-Id: <patch-1.1-c317e6e125e-20210921T124416Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The control flow of how "bol" and "eol" are passed through the various
functions in grep.c can be hard to follow, because in some functions
we want e.g. an "eol pointer to const char", but in others we can do
with a "const pointer to const char", likewise for the "const char **"
case.

I think that it would be good to eventually change this code to mostly
take a "const char *const"/"const size_t" pair, as that's what both
regexec_buf() and the equivalent PCRE function consume[1], now we
convert to length with "eol - bol" in several places.

For any such future conversion, and for reading the code, it'll be
much easier if we're at a starting point of knowing what pointers we
modify where, so let's have the compiler help us with that.

This change was made by converting these to the strictest possible
"const" forms and seeing where we had errors, note that the lone
"const char ** const" can only be that strict, it can't be a "const
char * const * const".

This change doesn't matter for the compiler's optimization, both gcc
and clang generate practically (only address differences) the same
code under both -O0 and -O3.

1. https://lore.kernel.org/git/87czp29l2c.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

A suggested patch either on top of Jeff King's
<YUlVZk1xXulAqdef@coredump.intra.peff.net> or even for squashing into
his series.

I think that generally git's codebase could use going beyond just
"const char *" when a "const char * const" would suffice, for some
reason we seem to mostly use it for the static usage variables.

In this particular case I think it makes the flow of grep.c much
easier to reason about. You can immediately see which functions are
twiddling the bol/eof pointers and which aren't.

 grep.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/grep.c b/grep.c
index 14fe8a0fd23..4e266769931 100644
--- a/grep.c
+++ b/grep.c
@@ -206,7 +206,7 @@ void grep_commit_pattern_type(enum grep_pattern_type pattern_type, struct grep_o
 		grep_set_pattern_type_option(GREP_PATTERN_TYPE_ERE, opt);
 }
 
-static struct grep_pat *create_grep_pat(const char *pat, size_t patlen,
+static struct grep_pat *create_grep_pat(const char *const pat, size_t patlen,
 					const char *origin, int no,
 					enum grep_pat_token t,
 					enum grep_header_field field)
@@ -436,8 +436,8 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	}
 }
 
-static int pcre2match(struct grep_pat *p, const char *line, const char *eol,
-		regmatch_t *match, int eflags)
+static int pcre2match(struct grep_pat *p, const char * const line,
+		      const char * const eol, regmatch_t *match, int eflags)
 {
 	int ret, flags = 0;
 	PCRE2_SIZE *ovector;
@@ -489,8 +489,9 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	die("cannot use Perl-compatible regexes when not compiled with USE_LIBPCRE");
 }
 
-static int pcre2match(struct grep_pat *p, const char *line, const char *eol,
-		regmatch_t *match, int eflags)
+static int pcre2match(struct grep_pat *p,
+		      const char * const line, const char * const eol,
+		      regmatch_t *match, int eflags)
 {
 	return 1;
 }
@@ -909,7 +910,7 @@ static void show_name(struct grep_opt *opt, const char *name)
 }
 
 static int patmatch(struct grep_pat *p,
-		    const char *line, const char *eol,
+		    const char * const line, const char * const eol,
 		    regmatch_t *match, int eflags)
 {
 	int hit;
@@ -923,7 +924,7 @@ static int patmatch(struct grep_pat *p,
 	return hit;
 }
 
-static void strip_timestamp(const char *bol, const char **eol_p)
+static void strip_timestamp(const char * const bol, const char ** const eol_p)
 {
 	const char *eol = *eol_p;
 
@@ -1026,7 +1027,7 @@ static int match_one_pattern(struct grep_pat *p,
 }
 
 static int match_expr_eval(struct grep_opt *opt, struct grep_expr *x,
-			   const char *bol, const char *eol,
+			   const char *bol, const char * const eol,
 			   enum grep_context ctx, ssize_t *col,
 			   ssize_t *icol, int collect_hits)
 {
@@ -1095,7 +1096,7 @@ static int match_expr_eval(struct grep_opt *opt, struct grep_expr *x,
 }
 
 static int match_expr(struct grep_opt *opt,
-		      const char *bol, const char *eol,
+		      const char *bol, const char * const eol,
 		      enum grep_context ctx, ssize_t *col,
 		      ssize_t *icol, int collect_hits)
 {
@@ -1104,7 +1105,7 @@ static int match_expr(struct grep_opt *opt,
 }
 
 static int match_line(struct grep_opt *opt,
-		      const char *bol, const char *eol,
+		      const char *bol, const char * const eol,
 		      ssize_t *col, ssize_t *icol,
 		      enum grep_context ctx, int collect_hits)
 {
@@ -1137,7 +1138,7 @@ static int match_line(struct grep_opt *opt,
 }
 
 static int match_next_pattern(struct grep_pat *p,
-			      const char *bol, const char *eol,
+			      const char * const bol, const char * const eol,
 			      enum grep_context ctx,
 			      regmatch_t *pmatch, int eflags)
 {
@@ -1159,7 +1160,7 @@ static int match_next_pattern(struct grep_pat *p,
 }
 
 static int next_match(struct grep_opt *opt,
-		      const char *bol, const char *eol,
+		      const char * const bol, const char * const eol,
 		      enum grep_context ctx, regmatch_t *pmatch, int eflags)
 {
 	struct grep_pat *p;
@@ -1216,7 +1217,7 @@ static void show_line_header(struct grep_opt *opt, const char *name,
 }
 
 static void show_line(struct grep_opt *opt,
-		      const char *bol, const char *eol,
+		      const char *bol, const char * const eol,
 		      const char *name, unsigned lno, ssize_t cno, char sign)
 {
 	int rest = eol - bol;
@@ -1306,7 +1307,7 @@ static inline void grep_attr_unlock(void)
 }
 
 static int match_funcname(struct grep_opt *opt, struct grep_source *gs,
-			  const char *bol, const char *eol)
+			  const char * const bol, const char * const eol)
 {
 	xdemitconf_t *xecfg = opt->priv;
 	if (xecfg && !xecfg->find_func) {
@@ -1336,7 +1337,7 @@ static void show_funcname_line(struct grep_opt *opt, struct grep_source *gs,
 			       const char *bol, unsigned lno)
 {
 	while (bol > gs->buf) {
-		const char *eol = --bol;
+		const char * const eol = --bol;
 
 		while (bol > gs->buf && bol[-1] != '\n')
 			bol--;
@@ -1352,7 +1353,7 @@ static void show_funcname_line(struct grep_opt *opt, struct grep_source *gs,
 	}
 }
 
-static int is_empty_line(const char *bol, const char *eol);
+static int is_empty_line(const char * const bol, const char * const eol);
 
 static void show_pre_context(struct grep_opt *opt, struct grep_source *gs,
 			     const char *bol, const char *end, unsigned lno)
@@ -1375,8 +1376,8 @@ static void show_pre_context(struct grep_opt *opt, struct grep_source *gs,
 
 	/* Rewind. */
 	while (bol > gs->buf && cur > from) {
-		const char *next_bol = bol;
-		const char *eol = --bol;
+		const char * const next_bol = bol;
+		const char * const eol = --bol;
 
 		while (bol > gs->buf && bol[-1] != '\n')
 			bol--;
@@ -1438,7 +1439,7 @@ static int look_ahead(struct grep_opt *opt,
 		      const char **bol_p)
 {
 	unsigned lno = *lno_p;
-	const char *bol = *bol_p;
+	const char * const bol = *bol_p;
 	struct grep_pat *p;
 	const char *sp, *last_bol;
 	regoff_t earliest = -1;
@@ -1533,7 +1534,7 @@ static int fill_textconv_grep(struct repository *r,
 	return 0;
 }
 
-static int is_empty_line(const char *bol, const char *eol)
+static int is_empty_line(const char *bol, const char * const eol)
 {
 	while (bol < eol && isspace(*bol))
 		bol++;
-- 
2.33.0.1098.gf02a64c1a2d

