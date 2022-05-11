Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427AFC433EF
	for <git@archiver.kernel.org>; Wed, 11 May 2022 18:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346015AbiEKSAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 14:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345986AbiEKSAS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 14:00:18 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC8D6FA25
        for <git@vger.kernel.org>; Wed, 11 May 2022 11:00:17 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id kk28so2659105qvb.3
        for <git@vger.kernel.org>; Wed, 11 May 2022 11:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BBTemDjkoC6gipCCQXwkLNbYk1Xv/vStPpkwCvtPbPU=;
        b=EyN3GKdfrphMi2xZnQOKrK/wu9Bg8/Ke5t/ODYCsAHapcSCDJYd+FdkBXrdZfV0csK
         YEXCkugxIk1Vgr6Kneq8GtNdSnYNrGMcoSKxbTGv6zpAN1ki74PRdfC5E/xY88wK/lvG
         pzc9F23BBss1mJtsGDbJ8PcNDlCWWjMNetpe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BBTemDjkoC6gipCCQXwkLNbYk1Xv/vStPpkwCvtPbPU=;
        b=iqlc0p5muYYiJIeneA7Ag0vE3P051JoiNQ+dBtGVlsqVdokAf3fMbbf92z97fj5eJo
         npW9q6QFIv1T9Q+JFi0bC42Exho6kvWKNfDn5spZkECVw6t6Uea31XV1B2Fin132ocO/
         m8gNrbvWstzB/rlYUQikQbMv3lnRh1gQ1CbFmSG/8z9qDzmGBLrbt3Ysz7TvoCTOe1uL
         vOz7uFu6JJx9y+o3BZ/NRFmYdfsScaEDweYgE/7zDCJUptUvCuwcQY7iCD3wES+7L0/B
         dM+RSPizirr/ynQPs/T/uvGUAN7HjQsrGnfb3oTO14iLa//dL3fYNnHxCsjWzCRXMNqw
         La8A==
X-Gm-Message-State: AOAM533G6jU45Lc6IUTYbCmMXETLJ2by4URFFvw5cYEiMrCFIbtUO8Ni
        ukcVo7RFBRYPc/Fq98zuapiaeyaVNZB3XIuo56A=
X-Google-Smtp-Source: ABdhPJy1irLubrztwtR7X92TWSBJCFJmUXywrF1+elYH0YAA2gvM5S8+IwiHpVBpAvu6+GEXdbNiyQ==
X-Received: by 2002:a0c:f94d:0:b0:458:1157:6af5 with SMTP id i13-20020a0cf94d000000b0045811576af5mr23210285qvo.94.1652292015999;
        Wed, 11 May 2022 11:00:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e9fd])
        by smtp.gmail.com with ESMTPSA id f18-20020a05620a281200b0069fc13ce222sm1773328qkp.83.2022.05.11.11.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 11:00:15 -0700 (PDT)
Date:   Wed, 11 May 2022 19:00:14 +0100
From:   Chris Down <chris@chrisdown.name>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>, kernel-team@fb.com
Subject: [PATCH v3 2/2] bisect: output bisect setup status in bisect log
Message-ID: <83c76401ad2e066bc25cab542214bc3a021afd02.1652291688.git.chris@chrisdown.name>
References: <cover.1652291688.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1652291688.git.chris@chrisdown.name>
User-Agent: Mutt/2.2.4 (c3baa83e) (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows seeing the current intermediate status without adding a new
good or bad commit:

    $ git bisect log | tail -1
    # status: waiting for bad commit, 1 good commit known

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 builtin/bisect--helper.c    | 26 +++++++++++++++++++++-----
 t/t6030-bisect-porcelain.sh | 10 ++++++++++
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index fa8024a864..e358e3dd5b 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -400,6 +400,22 @@ static void bisect_status(struct bisect_state *state,
 	free(bad_ref);
 }
 
+__attribute__((format (printf, 1, 2)))
+static void bisect_log_printf(const char *fmt, ...)
+{
+	struct strbuf buf = STRBUF_INIT;
+	va_list ap;
+
+	va_start(ap, fmt);
+	strbuf_vaddf(&buf, fmt, ap);
+	va_end(ap);
+
+	printf("%s", buf.buf);
+	append_to_file(git_path_bisect_log(), "# %s", buf.buf);
+
+	strbuf_release(&buf);
+}
+
 static void bisect_print_status(const struct bisect_terms *terms)
 {
 	struct bisect_state state = { 0 };
@@ -411,13 +427,13 @@ static void bisect_print_status(const struct bisect_terms *terms)
 		return;
 
 	if (!state.nr_good && !state.nr_bad)
-		printf(_("status: waiting for both good and bad commits\n"));
+		bisect_log_printf(_("status: waiting for both good and bad commits\n"));
 	else if (state.nr_good)
-		printf(Q_("status: waiting for bad commit, %d good commit known\n",
-			  "status: waiting for bad commit, %d good commits known\n",
-			  state.nr_good), state.nr_good);
+		bisect_log_printf(Q_("status: waiting for bad commit, %d good commit known\n",
+				     "status: waiting for bad commit, %d good commits known\n",
+				     state.nr_good), state.nr_good);
 	else
-		printf(_("status: waiting for good commit(s), bad commit known\n"));
+		bisect_log_printf(_("status: waiting for good commit(s), bad commit known\n"));
 }
 
 static int bisect_next_check(const struct bisect_terms *terms,
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 686f6d5c7f..83931d482f 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -1029,9 +1029,15 @@ test_expect_success 'bisect state output with multiple good commits' '
 	git bisect reset &&
 	git bisect start >output &&
 	grep "waiting for both good and bad commits" output &&
+	git bisect log >output &&
+	grep "waiting for both good and bad commits" output &&
 	git bisect good "$HASH1" >output &&
 	grep "waiting for bad commit, 1 good commit known" output &&
+	git bisect log >output &&
+	grep "waiting for bad commit, 1 good commit known" output &&
 	git bisect good "$HASH2" >output &&
+	grep "waiting for bad commit, 2 good commits known" output &&
+	git bisect log >output &&
 	grep "waiting for bad commit, 2 good commits known" output
 '
 
@@ -1039,7 +1045,11 @@ test_expect_success 'bisect state output with bad commit' '
 	git bisect reset &&
 	git bisect start >output &&
 	grep "waiting for both good and bad commits" output &&
+	git bisect log >output &&
+	grep "waiting for both good and bad commits" output &&
 	git bisect bad "$HASH4" >output &&
+	grep -F "waiting for good commit(s), bad commit known" output &&
+	git bisect log >output &&
 	grep -F "waiting for good commit(s), bad commit known" output
 '
 
-- 
2.36.0

