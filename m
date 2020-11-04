Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AEDC388F9
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2591820825
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnCnKJ0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732116AbgKDRrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 12:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbgKDRrf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 12:47:35 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB43C0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 09:47:35 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id 9so23020787oir.5
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 09:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7kFlxMX4hnUVT4xhtEwHBGmNeSzM50Kbqe2ph0xHk4I=;
        b=ZnCnKJ0+IVGnW3OSjIjLWhbwcPXgdZqEqAHUApy0eJ0pAWlJpxjyeATBZjkgz6hNtJ
         OgROMvFXFJbLmmyJrl510TEBH5QtmWf6QUH9XyeVyopURQ8MSEVKsLyntuQxyily6n5x
         FfMHvvlYPRLRrsnIY1qs/IxiZm1eaX5h5Y6aKqALYJDXh4Ed39e/189T1SSvh3zr/jsq
         HFhMMx14kUvnSAqsDMblO3UhYtcd0bBQhN27zN+DC6EaX4smLVpQVM0kYwDjM1gDYVeZ
         C7EppvMT6IVI9+gwZG21U2YwNSNNGfEry2yqUNQohOWeUAkcFowcPZ0bee7ONkZmJlOC
         UmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7kFlxMX4hnUVT4xhtEwHBGmNeSzM50Kbqe2ph0xHk4I=;
        b=F7DoOyRpbAHfClNCPYvNS+SYeQOWKEUlcA9T35ey5Yht9nq9xB/J+3XFYQJN61GVZK
         qhoVgwucZbTHsiOBj70l9NOGSPpQABmgHef0r4prB3iOnK3f1z3GKpEc5EY40IisYAeT
         LXOX3LmoXKLOvPRUhi8TX1xQJXvoO4+trRe0Q6Nvxl1dcYbl9nx8GUnzh3JigsMqrJJG
         rvaogg8ITqNNyjzf/xNXP0epzb3mLnKplhJVHlsojtQ/LGvFZ7guNvv6ODBeuqjNORL5
         50z/whbF+r86cl7xJeWf9yUxtGXvmGCtt8UX2/e6ZPmANbe42AbCKoFKQcKj2YvhK2af
         4jbA==
X-Gm-Message-State: AOAM531wTG52RULakIcUyV9KeYOIjcNEjhwrEBGEXF9NNpDGZ9hZjyjm
        lkdhRaplhh4yC7MD3yp9ZpTesJZinQBQWg==
X-Google-Smtp-Source: ABdhPJzKsNgAK06EaaVgWO2M+3mxR7Q91FfX09yUlQqGuDoUp4Q8GerYqXuJup08FIG9zio6cInstg==
X-Received: by 2002:aca:b588:: with SMTP id e130mr3481354oif.56.1604512054291;
        Wed, 04 Nov 2020 09:47:34 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id t27sm607210otc.14.2020.11.04.09.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 09:47:33 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 09/10] completion: bash: trivial cleanup
Date:   Wed,  4 Nov 2020 11:47:15 -0600
Message-Id: <20201104174716.783348-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201104174716.783348-1-felipe.contreras@gmail.com>
References: <20201104174716.783348-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The most typical case first (COMP_WORDBREAKS contains our wanted words).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3666fba8ca..b4e6f82c66 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -207,9 +207,7 @@ _get_comp_words_by_ref ()
 	# Which word separators to exclude?
 	exclude="${COMP_WORDBREAKS//[^=:]}"
 	cword=$COMP_CWORD
-	if [ -z "$exclude" ]; then
-		words=("${COMP_WORDS[@]}")
-	else
+	if [ -n "$exclude" ]; then
 		# List of word completion separators has shrunk;
 		# re-assemble words to complete.
 		for ((i=0, j=0; i < ${#COMP_WORDS[@]}; i++, j++)); do
@@ -244,6 +242,8 @@ _get_comp_words_by_ref ()
 				cword=$j
 			fi
 		done
+	else
+		words=("${COMP_WORDS[@]}")
 	fi
 
 	cur=${words[cword]}
-- 
2.29.2

