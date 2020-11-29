Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E65C64E8A
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 19:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 320C620809
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 19:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YitA2dCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgK2Txj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 14:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgK2Txj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 14:53:39 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D066EC0613D4
        for <git@vger.kernel.org>; Sun, 29 Nov 2020 11:52:58 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id t22so13673023ljk.0
        for <git@vger.kernel.org>; Sun, 29 Nov 2020 11:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KXyPVqMvIDTnoE3DFp/xAUTBSZaE6gyvH0WAkC6/i2w=;
        b=YitA2dCaokxDdaK78st5yT6Ve79jIJpBSXJ1LBa3DxeR1S0VOdn5kD3x/eW/J5KT+k
         Uf/f3c33KkcH63n87KIe6p5yhDQKzJM1uF61p7NTFHeryrEEXOkTizAyrWVU91Dt0fcM
         1YfvVrZqz4RvaWaTrtOKEWwjLeHCU5UqOn0MQif5semmBAGjrpsb2Pso/Mop0pEQAW4i
         KkmopTC1H/cwrp5BsMxtQ9NjSENoYA+IoF1RhAD0rRi2RVDx8VidR2WdC3cbFOpTi4nh
         7QaWH8rhGekuoxFkXPdLsnxpdS5clWcE7pyuYo0avrjNFinl7EbfDLalg64zoZ/JvTdZ
         zTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KXyPVqMvIDTnoE3DFp/xAUTBSZaE6gyvH0WAkC6/i2w=;
        b=FPMd3MMpbv6I76z9m4qyaDzbgcPehKt45s6pev3P+v0QfeLoWdWDqL18jMz1B57lSV
         mVH1kF5FOF4F93uMfiL4xmQFNfCNq+iVnkfyCwZahAbGt7KVxgRRbh5C9RSzuxZBxWsj
         CoAPSMYFs3H4BeP9ldUgkqmiH71pTpnev+CH0aSa/jlaqJ84FU/2WXPosuzX5PRhpenA
         ZN95oBJZwnPhchh6LSeDgiez7Y/buULj+yylamg9ON5ONlub3deRh5OIglbZP7uQGGXs
         8PWpFfWQt+eCkw/x7zKgkIcZ/y2f7BGfkzrtWudueVKUI1L0Q42dGdZrm4XKzZOW47q+
         e43A==
X-Gm-Message-State: AOAM531JtnBTHA+JQ34JGHBOsLAWWlTb6QOGdfgzQeGngC3OrUvjNs36
        D60z+in+W/5zuXnw3QOg1xYmwcKxpFE=
X-Google-Smtp-Source: ABdhPJzOOE66mHStBjhVqvQYls2iO5zZG55RYrFx5eM8yV/5oB8BRhgamRfhQXXHJ3sHWkeTNfPXaA==
X-Received: by 2002:a2e:9b83:: with SMTP id z3mr8213294lji.145.1606679577040;
        Sun, 29 Nov 2020 11:52:57 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id w72sm1808707lff.89.2020.11.29.11.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 11:52:56 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3 3/4] grep: copy struct in one fell swoop
Date:   Sun, 29 Nov 2020 20:52:21 +0100
Message-Id: <77371dee2f13723cf8f766793b07241ca458adbd.1606679312.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2
In-Reply-To: <cover.1606679312.git.martin.agren@gmail.com>
References: <cover.1606251357.git.martin.agren@gmail.com> <cover.1606679312.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a `struct grep_opt` with our defaults which we then copy into
the caller's struct. Rather than zeroing the target struct and copying
each element one by one, just copy everything at once. This leaves the
code simpler and more maintainable.

We don't have any ownership issues with what we're copying now and can
just greedily copy the whole thing. If and when we do need to handle
such elements (`char *`?), we must and can handle it appropriately. Make
sure to leave a comment to our future selves.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 grep.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/grep.c b/grep.c
index 8f2009ec9f..efeb6dc58d 100644
--- a/grep.c
+++ b/grep.c
@@ -66,11 +66,6 @@ static const char *color_grep_slots[] = {
 	[GREP_COLOR_SEP]	    = "separator",
 };
 
-static void color_set(char *dst, const char *color_bytes)
-{
-	xsnprintf(dst, COLOR_MAXLEN, "%s", color_bytes);
-}
-
 static int parse_pattern_type_arg(const char *opt, const char *arg)
 {
 	if (!strcmp(arg, "default"))
@@ -100,6 +95,14 @@ int grep_config(const char *var, const char *value, void *cb)
 	if (userdiff_config(var, value) < 0)
 		return -1;
 
+	/*
+	 * The instance of grep_opt that we set up here is copied by
+	 * grep_init() to be used by each individual invocation.
+	 * When populating a new field of this structure here, be
+	 * sure to think about ownership -- e.g., you might need to
+	 * override the shallow copy in grep_init() with a deep copy.
+	 */
+
 	if (!strcmp(var, "grep.extendedregexp")) {
 		opt->extended_regexp_option = git_config_bool(var, value);
 		return 0;
@@ -157,9 +160,6 @@ int grep_config(const char *var, const char *value, void *cb)
  */
 void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix)
 {
-	struct grep_opt *def = &grep_defaults;
-	int i;
-
 #if defined(USE_LIBPCRE2)
 	if (!pcre2_global_context)
 		pcre2_global_context = pcre2_general_context_create(
@@ -171,26 +171,13 @@ void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix
 	pcre_free = free;
 #endif
 
-	memset(opt, 0, sizeof(*opt));
+	*opt = grep_defaults;
+
 	opt->repo = repo;
 	opt->prefix = prefix;
 	opt->prefix_length = (prefix && *prefix) ? strlen(prefix) : 0;
 	opt->pattern_tail = &opt->pattern_list;
 	opt->header_tail = &opt->header_list;
-
-	opt->only_matching = def->only_matching;
-	opt->color = def->color;
-	opt->extended_regexp_option = def->extended_regexp_option;
-	opt->pattern_type_option = def->pattern_type_option;
-	opt->linenum = def->linenum;
-	opt->columnnum = def->columnnum;
-	opt->max_depth = def->max_depth;
-	opt->pathname = def->pathname;
-	opt->relative = def->relative;
-	opt->output = def->output;
-
-	for (i = 0; i < NR_GREP_COLORS; i++)
-		color_set(opt->colors[i], def->colors[i]);
 }
 
 void grep_destroy(void)
-- 
2.29.2.454.gaff20da3a2

