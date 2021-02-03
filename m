Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A96C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF5B364F50
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbhBCDbf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbhBCDaW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 22:30:22 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826B8C06121F
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 19:28:44 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id 7so22600428wrz.0
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 19:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zoOhyuka3q3Nhl6wnSAzpoA2kumtr8dkvPHAGxTkY4I=;
        b=uYZ47Q6mgbhdONqAuMpUgcWCqhQ43Qsn12oulW8Gfb4/0twsaCuVEiF1Ckwbe9AY1k
         zk1JZGppYDjUlPbxWAGKPMawTRIA0S+sXfG+H0BlNK8abfsvqSfZseaT5vqq+GfoFlGA
         5TFqDKkzggLQODjTXK69xW0wRK1wSy7xUC5nv2EYbXpBxog1bem6QaHX2JKn85UwFt2K
         /ZO9uT6ThP3u2sTB0XaaJI+yHNoBzErKoa6CqcAlCbB4us+O8AOP9y6v6SYNvjgFzc9r
         0CVJyUH0uYa5ZtwSJthQ5TcnzWJGFiHwaxW5cc0/FLP0GR3gO90hsuKrfYj1PMq60gUj
         QTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zoOhyuka3q3Nhl6wnSAzpoA2kumtr8dkvPHAGxTkY4I=;
        b=SY7GO0dQBYgqYctXXfE6/zsFPgrJPV+jI8LLWt/SCLPRddej3v1Zy4HS/RreLjP6QV
         gHtMO9PLuqniD2YyY1rRlEbiRJKDLSSJ86fmr62po2lKYq7CBw7VurFNEdhKBp5OU0er
         2hT2UKXExFImBgUBxw8zmEtkNDEtEA3p8uTcKWdSoQl8947pUFG350KCbIaOwP3gmzAg
         HHU/PxBAXxHa1+juqigoH8KxJjeWT0a0fuLymW1DY1GvE8ZNFDPXEpaZ4NWw9Aa6oAu/
         LrBaOk/uQmHc53V9jlu4pCPD+bB3EAfCLADj7niBgWoRTTB96o6rOQ5mEay9Nk2M2yr7
         hJPw==
X-Gm-Message-State: AOAM530mak5ndUUNwIu0kcz0uOBDm7UQ7v3cQH/yLAYHdfQS/pfG0yyL
        EJZYqY8VsEWNH1Ug7N75CX6EQ65IuhcGQQ==
X-Google-Smtp-Source: ABdhPJzMUjucvZhc1zDfnqyUWjjA61ISGPZuMvpmCNz6Dge4jGUAuwC9B1Fz9G6f+iO/Lscm+IWh+A==
X-Received: by 2002:adf:c413:: with SMTP id v19mr1071654wrf.158.1612322922932;
        Tue, 02 Feb 2021 19:28:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c5sm971089wrn.77.2021.02.02.19.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:28:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 25/25] pickaxe -G: terminate early on matching lines
Date:   Wed,  3 Feb 2021 04:28:11 +0100
Message-Id: <20210203032811.14979-26-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Solve a long-standing item for "git log -Grx" of us e.g. finding "+
str" in the diff context and noting that we had a "hit", but xdiff
diligently continuing to generate and spew the rest of the diff at us.

The TODO item has been there since "git log -G" was implemented. See
f506b8e8b5f (git log/diff: add -G<regexp> that greps in the patch
text, 2010-08-23).

Our xdiff interface also had the limitation of not being able to abort
early since the beginning, see d9ea73e0564 (combine-diff: refactor
built-in xdiff interface., 2006-04-05). Although at that time
"xdiff_emit_line_fn" was called "xdiff_emit_consume_fn", and
"xdiff_emit_hunk_fn" didn't exist yet.

But now with the support added in the preceding ""xdiff-interface:
allow early return from xdiff_emit_{line,hunk}_fn" commit we can
return early, and furthermore test the functionality of the new
early-exit xdiff-interface by having a BUG() call here to die if it
ever starts handing us needless work again.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diffcore-pickaxe.c | 29 +++++++++++++++++++----------
 xdiff-interface.h  |  5 +++++
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 21f9d66b6a..e773fa69a2 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -29,12 +29,11 @@ static int diffgrep_consume(void *priv, char *line, unsigned long len)
 	if (line[0] != '+' && line[0] != '-')
 		return 0;
 	if (data->hit)
-		/*
-		 * NEEDSWORK: we should have a way to terminate the
-		 * caller early.
-		 */
-		return 0;
-	data->hit = patmatch(grep_pat, line + 1, line + len + 1, &regmatch, 0);
+		BUG("Already matched in diffgrep_consume! Broken xdiff_emit_line_fn?");
+	if (patmatch(grep_pat, line + 1, line + len + 1, &regmatch, 0)) {
+		data->hit = 1;
+		return -1;
+	}
 	return 0;
 }
 
@@ -47,6 +46,7 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	xdemitconf_t xecfg;
 	regmatch_t regmatch;
 	struct grep_pat *grep_pat = grep_filter->pattern_list;
+	int ret;
 
 	if (!one)
 		return patmatch(grep_pat, two->ptr, two->ptr + two->size,
@@ -65,10 +65,19 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	ecbdata.hit = 0;
 	xecfg.ctxlen = 0;
 	xecfg.interhunkctxlen = o->interhunkcontext;
-	if (xdi_diff_outf(one, two, discard_hunk_line, diffgrep_consume,
-			  &ecbdata, &xpp, &xecfg))
-		return 0;
-	return ecbdata.hit;
+
+	/*
+	 * An xdiff error might be our "data->hit" from above. See the
+	 * comment for xdiff_emit_{line,hunk}_fn in xdiff-interface.h
+	 * for why.
+	 */
+	ret = xdi_diff_outf(one, two, discard_hunk_line, diffgrep_consume,
+			    &ecbdata, &xpp, &xecfg);
+	if (ecbdata.hit)
+		return 1;
+	if (ret)
+		return ret;
+	return 0;
 }
 
 static unsigned int contains(mmfile_t *mf, struct grep_opt *grep_filter)
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 1b27d6104c..347d8a4425 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -25,6 +25,11 @@
  * granular return values, but for now use it carefully, or consider
  * e.g. using discard_hunk_line() if you say just don't care about
  * hunk headers.
+ *
+ * Note that just returning -1 will make your early return
+ * indistinguishable from an error internal to xdiff. See "diff_grep"
+ * in diffcore-pickaxe.c for a trick to work around this, i.e. using
+ * the "consume_callback_data" to note the desired early return.
  */
 typedef int (*xdiff_emit_line_fn)(void *, char *, unsigned long);
 typedef int (*xdiff_emit_hunk_fn)(void *data,
-- 
2.30.0.284.gd98b1dd5eaa7

