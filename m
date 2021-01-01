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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1F8C433E0
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 067C3207A3
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbhAACRx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbhAACRt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:49 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8CAC061573
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:06 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id w124so23456942oia.6
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1/DcuYHbYOfQJb8IH+RsxhCP2A7w5yTJs4F8e6Nxm/8=;
        b=QgK8vJev2QyiERPSU/nHlmyxupcffzej8MUTVZfonHZnssgTpHAWHsFYXcP7fBm/vx
         RUVukd1EoYrq71SSRLZ38Fe+J3DoxzBVZ1o0SH3xDNrf3R0NEC3FmTA+/qs9pEsk16Mo
         C8lzxvWW7s8tzIFBnEJiUFEtndciS++Q6RzcXfqPAVqUwGNkbbKru81vPBcq7zWtZxZr
         9/F2OdIxB+rkp7+UJebiCLJD/8KMCMurixDAte27S+A+ip3NqdbxtIjMmkJfTc95uFTD
         XzzPIhvZeKxRwEDYbMQFM0TFBR3Lf+IH/PThxTIC0gfFofAthyY45KDWCCnjniYnO3zw
         IZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1/DcuYHbYOfQJb8IH+RsxhCP2A7w5yTJs4F8e6Nxm/8=;
        b=kwVe410ecki0rWH3UWZIyr/t8L5DRJtE2FYT/DN3X+3jfGEXiLvguHnF6NtL302jR/
         MGblPFLhurfUyNyacSDeSfm0rxPopq3cr3LE5+cGUbU0y2u5/WcHRaqGSTIfd3OD6QaS
         2ucvOe5NgfbIargyKn3r/VLgv0iYQQUGy2dRnVg/lvut9oVBPFyQztogitR1N+lnDaM4
         ozGgZyr4w+tCDgUC3tbBocYDCHRNCgzmZBMNhNTdA7tqQMZHUI8yqb48JqPT/zw9hanU
         LQKWTfVzCL/Rg9V0vAimI79cI/d68gTAapSkeid/HBFSL9sbygfx3uCA65VxO0JpUj7k
         pjag==
X-Gm-Message-State: AOAM5338fd6TVphpwrwMtnnReyL3DF1xwvn+lMkjpVVQHs6zOoH96olT
        d4yh43P8g2Iscuu2i08PNAZWpgIlRnoOdA==
X-Google-Smtp-Source: ABdhPJxgy8020FYVLBsw91PO7pJBKfE8WmmY+pznty8gdUCO2v3P7wavztoqAzxUB618qJL0WOiV3Q==
X-Received: by 2002:aca:5183:: with SMTP id f125mr9840467oib.92.1609467425719;
        Thu, 31 Dec 2020 18:17:05 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id r13sm11721624oti.49.2020.12.31.18.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:17:05 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 26/47] completion: bash: simplify config_variable_name
Date:   Thu, 31 Dec 2020 20:16:01 -0600
Message-Id: <20210101021622.798041-27-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we can actually pass a suffix to __gitcomp function, and it
does the right thing, all the functions can receive the same suffix.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4eea322366..73c9a81405 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2569,7 +2569,7 @@ __git_complete_config_variable_value ()
 #                 subsections) instead of the default space.
 __git_complete_config_variable_name ()
 {
-	local cur_="$cur" sfx
+	local cur_="$cur" sfx=" "
 
 	while test $# != 0; do
 		case "$1" in
@@ -2591,7 +2591,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	guitool.*.*)
@@ -2625,7 +2625,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__git_compute_all_commands
-		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	remote.*.*)
@@ -2641,7 +2641,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl "pushDefault" "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl "pushDefault" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	url.*.*)
-- 
2.30.0

