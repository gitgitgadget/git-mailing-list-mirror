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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911BEC4332B
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FAD220798
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbhAACRI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbhAACRH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:07 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFDCC061575
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:27 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id i6so19328924otr.2
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5edPSVe0LJ7X1nf0VSs3p//nYaz/dkyLecSzg/ATeOI=;
        b=MSecFVIgY0mwhFjh6GHjrH6aBFBoLmOOK8YTMkvXxNQ+UQGNy6z/XNzabYQTGVqVhQ
         JFnfA3aSVfjOCZAt/JRI3/3AE3yU9ONXMMSxQVnmi454hNWKKIG/w0AaT4vqbHAME9KO
         KelzvnK9lwBG0R2KN1TKWtFg3lchvnLcDiFzEjnHO/dLQpNSH5tIp6qB7HiCX0eSZMWy
         j4XyHBIuqivm2FUGZvN/J9M01Ad3DLZ1UhID9hYoYTtcV2LAiR5Ku05JoJJxTBJWcMQl
         ENA5H92R8tDTvqcbPaKhwOlPby71XYf5vxBl3evRmuGhLgk+GGesuzO37rwdqQtwVSPe
         koEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5edPSVe0LJ7X1nf0VSs3p//nYaz/dkyLecSzg/ATeOI=;
        b=MRMiIqlvnEuEs1J68aUV8kecNX0In16bv1Ja9ydqTtHMywmr4NLf1cSf1Q1AVj6Akj
         maT6EvCVYmAsFCxanC7u7egj2S2OFF/hMLvnpqVSxc7w3DMLD2YJ1dpDj4YU/YhJ225q
         JrA7oCRMYVhfP4cvy1XEcVTO+KhT651dWFrpm2F0063se/LenWPqKnHv44JoJMJ8lBLA
         0zevaQl6auW5yqA1jUh05t8Yj15YQR4CQa55CDfToP4SYnlthCkjCKHYrrjAl+UQ09qn
         a6c1GmrGvMevTUEnu9LvvpB8rHaaxD6r0aLH19IiP5SMm5uSV6v/kLBMc1LCSSPDCZW6
         2C1A==
X-Gm-Message-State: AOAM532ukKZeVAHK0At/w4TvhcJtyTjC4gbyIDhsYcVWBdFfUW7j2Z8Q
        8JZaSaGtk7NjZQUNuSrzXXRkpmbYYrsp9A==
X-Google-Smtp-Source: ABdhPJzX5hMidaL9H6zEmXfpleGt7wiMtLchmWRY8+9s4UMJvjGZukpCfm8JajXJvjL3KV73Tl2Ipw==
X-Received: by 2002:a05:6830:2113:: with SMTP id i19mr43145606otc.209.1609467386311;
        Thu, 31 Dec 2020 18:16:26 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id s77sm12065941oos.27.2020.12.31.18.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:16:25 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 01/47] completion: bash: fix prefix detection in branch.*
Date:   Thu, 31 Dec 2020 20:15:36 -0600
Message-Id: <20210101021622.798041-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise we are completely ignoring the --cur argument.

The issue can be tested with:

  git clone --config=branch.<tab>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 463a3124da..10d225cc9c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2633,8 +2633,8 @@ __git_complete_config_variable_name ()
 		return
 		;;
 	branch.*)
-		local pfx="${cur%.*}."
-		cur_="${cur#*.}"
+		local pfx="${cur_%.*}."
+		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
 		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
 		return
-- 
2.30.0

