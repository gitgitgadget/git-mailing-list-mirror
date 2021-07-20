Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDD5C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6741861186
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbhGTJ6n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237008AbhGTJ4D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:56:03 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D93C0613E7
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:36:39 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o30-20020a05600c511eb029022e0571d1a0so1729747wms.5
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F2bSDOWO8mgf1qcFiqewDbhA1sEl4sLhPseETaely2s=;
        b=BC6D1dHk5vIwiLY5RgVWrllZNqKDLJOVjG3XbNv4qnBhtfwpyGptvZoEOcaGt/85QJ
         10QxONvV9L/PEeVRnODFrAyYt2DTvaJKN3/P3RjqqJlzgVEjJzphl6LdRsvby+jfVjSM
         hi+J+8V2T6JonbckSI8U0mxVKXI8ebqoNsOd7+cTwGjWFtgpqiz4QovGOCij50Z3+gWS
         ccakPuxAR6A4rWm0/zaMdefIjyXgKaZkbJnQUPa6qq9e50xFfpQNtImhz7SoGSRm982q
         bYjMGleaz4Quv5uqellp/jNB7ydTsS+ZrLB961EiL2VeZFlKo5JxuoZ9eaZaaTEVWeRs
         Ak1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=F2bSDOWO8mgf1qcFiqewDbhA1sEl4sLhPseETaely2s=;
        b=EOm8to33tuzh7l87QW14+qpqwuzj9S7JIqgj5n9rxeX1yiuadjE/WXsZz3c46YcQBZ
         FkZ16yMdllbgRbyH7GPXEBBWzADf55ncT0FACqHL7R6QinHDNr73M+bF2ddV2Gzzck48
         BPQM8DYsk1MCHfx+1ZT5Eei1mOu9s1kF00uws0up2huEX9U9usL4z+mhJaLNncOHPXu+
         xgqjiRIgEv8/HIOUzB2YqjcP7DqdlDngEtPPNLNxUtg1NZQkDX8FNdr+9hJJadZWa9wX
         M0OVOMjltmSA58VTdy7P/Cl0E9VDiSLq0SbTjr+m+iqYPSOE7BWAW+h+q7hE4j7vjBoy
         HwtQ==
X-Gm-Message-State: AOAM532WZenvlQ1qBc9ON4gmXXWGUU+azWFIZOefHozUEVc9/fHL3tGJ
        Ls/BKI3POQuhXLsXRmM8P35LAz0egGw=
X-Google-Smtp-Source: ABdhPJzaQlmiFoP99WeMeulnY4vSAHDLEI6v+C2Mu/YzLEKBQdBGpooGym9ngSnb+RSZFdNE5Sxmow==
X-Received: by 2002:a1c:f70b:: with SMTP id v11mr30994845wmh.186.1626777397708;
        Tue, 20 Jul 2021 03:36:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 11sm2060115wmo.10.2021.07.20.03.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:36:37 -0700 (PDT)
Message-Id: <93fdef30d64dd86493733c28f67ee22bcf5e6f58.1626777394.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
References: <pull.981.git.1623675888.gitgitgadget@gmail.com>
        <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 10:36:25 +0000
Subject: [PATCH v2 04/12] diff: simplify allow-indentation-change delta
 calculation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Now that we reliably end a block when the sign changes we don't need
the whitespace delta calculation to rely on the sign.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index 2b51b77fd20..77c893b266a 100644
--- a/diff.c
+++ b/diff.c
@@ -864,23 +864,17 @@ static int compute_ws_delta(const struct emitted_diff_symbol *a,
 	    a_width = a->indent_width,
 	    b_off = b->indent_off,
 	    b_width = b->indent_width;
-	int delta;
 
 	if (a_width == INDENT_BLANKLINE && b_width == INDENT_BLANKLINE) {
 		*out = INDENT_BLANKLINE;
 		return 1;
 	}
 
-	if (a->s == DIFF_SYMBOL_PLUS)
-		delta = a_width - b_width;
-	else
-		delta = b_width - a_width;
-
 	if (a_len - a_off != b_len - b_off ||
 	    memcmp(a->line + a_off, b->line + b_off, a_len - a_off))
 		return 0;
 
-	*out = delta;
+	*out = a_width - b_width;
 
 	return 1;
 }
@@ -924,10 +918,7 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
 	 * match those of the current block and that the text of 'l' and 'cur'
 	 * after the indentation match.
 	 */
-	if (cur->es->s == DIFF_SYMBOL_PLUS)
-		delta = a_width - c_width;
-	else
-		delta = c_width - a_width;
+	delta = c_width - a_width;
 
 	/*
 	 * If the previous lines of this block were all blank then set its
-- 
gitgitgadget

