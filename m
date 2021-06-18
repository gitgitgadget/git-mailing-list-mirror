Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C763DC49EA2
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA12C613E2
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbhFRS3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236388AbhFRS2q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:46 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60714C061224
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:34 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id r16so11525958oiw.3
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IugA4e8sia2SfBnU7y99hb07IL8ySGm4SOBc0tdzo00=;
        b=Xqh5Th9nx20I+OkaJzDtPuRb8+ITHO29iVv62l/rYfQOLLpeKd15eqU8vo5BXJKAmK
         z9Yq56r1W1Zzphmzqk+FLy0iFEQFNf+T587T1stlJFPrFjUlT8RS0TCPs2/6g52u6mcE
         sI/LfXGH6+lSFoltULurwmZWjxZKw15yUDKN4+K9ZBMXemrY/8DeqDGUpJxv5kH24U+g
         Kp991iwpbXVmsI7ykPvRWQ5ZJg5NA+KYSBp42/YephVS+hKFHD2+WEND0Z/3Gux2TiZs
         LE6YBN52oKeD3GoyBxuCpoy2Ba+0wvbzMZJgk1vd8UafwJ2aGJeOlOTVI8+VTMxYDzPH
         OgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IugA4e8sia2SfBnU7y99hb07IL8ySGm4SOBc0tdzo00=;
        b=hVEzHG+EZR6qaSwDCVlwDaMwkihFdY3XAvi/G0T0/1cQEjmphrAIsLyykLN0KLwOGd
         lBTRxTUmMsGozn/zpQ2yon+TUVEpSgx4Vru0sHssnAM1F18vA6AwoHlhEBC0oZVztr63
         SQia8EUC5ExhWnb9FyxP14Ye3DW7xm5dF78wFc2L8c2BNVRIb9sHjVae9Fc9Qu5oX6k4
         K1CNMrUsbk3L4QOXzIMRd+Zl/9iwlAdrOeiK0bZ1UbWEO2pxFxY3d0MxR3Avd5QStJsr
         mlSiiGOt301tZNmUX71FafyKv/WRdA96HF3sIcp85armlIjQPhfPwjlG+7MEDSfWyWkF
         U4RQ==
X-Gm-Message-State: AOAM533XR47zqBRqWrHGPDpYxYLpUJ79RJmGCsHy3qX2boY5hKfX7W1q
        LfPhezpe7p20TGbRk3itZtUjBMoIhNY48Q==
X-Google-Smtp-Source: ABdhPJyJ41avEFK3nD37wh9BO9dwmlJWWrrgSoQCS7F+j0rE2s84pKkxIeRsDJfvF3OnNc4H42rkeA==
X-Received: by 2002:aca:c456:: with SMTP id u83mr8350981oif.86.1624040793506;
        Fri, 18 Jun 2021 11:26:33 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id f12sm2155735otc.79.2021.06.18.11.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:26:33 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 39/45] completion: zsh: add __gitcompadd helper
Date:   Fri, 18 Jun 2021 13:25:12 -0500
Message-Id: <20210618182518.697912-40-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So we don't have to do the same over and over.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index a4b5e7dcc4..0f2f0e5eb0 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -50,12 +50,16 @@ COMP_WORDBREAKS=':'
 GIT_SOURCING_ZSH_COMPLETION=y . "$script"
 functions[complete]="$old_complete"
 
+__gitcompadd ()
+{
+	compadd -p "${2-}" -S "${3- }" -- ${=1} && _ret=0
+}
+
 __gitcomp ()
 {
 	emulate -L zsh
 
-	local IFS=$' \t\n'
-	compadd -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
+	IFS=$' \t\n' __gitcompadd "$1" "${2-}" "${4- }"
 }
 
 __gitcomp_opts ()
@@ -70,7 +74,7 @@ __gitcomp_opts ()
 	for c in ${=1}; do
 		if [[ $c == "--" ]]; then
 			[[ "$cur_" == --no-* ]] && continue
-			compadd -S " " -- "--no-..." && _ret=0
+			__gitcompadd "--no-..."
 			break
 		fi
 
@@ -82,7 +86,7 @@ __gitcomp_opts ()
 		else
 			sfx="$4"
 		fi
-		compadd -S "$sfx" -p "${2-}" -- "$c" && _ret=0
+		__gitcompadd "$c" "${2-}" "$sfx"
 	done
 }
 
-- 
2.32.0

