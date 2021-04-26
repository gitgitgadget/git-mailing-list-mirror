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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D765FC433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9543160C3D
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbhDZQUs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbhDZQUm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:20:42 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443BEC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:20:00 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id w6-20020a4a9d060000b02901f9175244e7so290056ooj.9
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2rKM0jsvPMc46w9HiUZvdwt6cYPr2zXcWxKnnOjtcKc=;
        b=vUsP5YuwJha5MmWG+WTcf4dvlEs1emtWk43/DDC3b1AIOOdoBS9oMCUWGd4QGW6OKC
         uCN1pLh4UQbvolgvWYqGp+OqETgyiYKUrCc/ISEqQ/7i4voWXOaHiaBDR4oj3U+3I5fk
         CZMI58quC0uksklu6Ap2eT7nNQUXiz5lpXq/Pq4e2jYcYdWtxn79/ZTsM3+2E+gDO8h/
         E7dRp2lYEmn5B3d8NgoYmLlPWG72u7oqirk3CypGjs9t7J+Gh65S+xXVQ6BT4fDcU/cQ
         0C02hepP5QhSDDTPjiTNffq4xaeI/tiGQ2xC6XIR99SBI1EouF6dM9OqIq9fAati2s3k
         AvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2rKM0jsvPMc46w9HiUZvdwt6cYPr2zXcWxKnnOjtcKc=;
        b=GhMYC56RGpwFA3rMhGNVyehaLfWLjNQ73Pi/bK/Bi62ZClazV68LPVe9XeZ6TNwvpe
         foxLt5zUBbV7tcEPUpJUFN5wkm284oOnexTOuSBYGGnmIS5/u2IyppMc8BDCZGUGlV8+
         NV1iEELbz1PBoOZWBrgWWs9JvKdMdmmXp1xuHO4PsezfoH2wTSO8V+uNBPTvrV9XKQFz
         iTBz/NOu3YVJ81dlzlkz09l++vWs6otAawS7BrzORxavYRROXzErKa2zL+aXDEA0jE2t
         ZNOricwEfB4bN22AhpFnGeYufkAmMCTkJmKwRKdnv2JaSiesH+Isx0J6N+HwaoF675AI
         KeaA==
X-Gm-Message-State: AOAM531VRoEY6GLhQw+lx/0opHKPvlpmR5mbFB3phf3wV/m/9lvYLOVo
        Vom0j5ELiK/uDezX0mg0+Wy0GuDrAvx5fQ==
X-Google-Smtp-Source: ABdhPJzIuOs/ko/eO6JljSvF/RINVWcilg+Z44irHzjXG13iri7BsgNKjWgUQXjr1ytuVA5GzYdBtw==
X-Received: by 2002:a4a:dc84:: with SMTP id g4mr14147945oou.24.1619453996535;
        Mon, 26 Apr 2021 09:19:56 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id m129sm3130748oif.34.2021.04.26.09.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:19:56 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 35/43] completion: zsh: add elements individually in __gitcomp_opts
Date:   Mon, 26 Apr 2021 11:14:50 -0500
Message-Id: <20210426161458.49860-36-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's useful to specify specific suffixes for specific words.

This will be useful later on.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 2faf435087..82a4d6f470 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -66,11 +66,10 @@ __gitcomp_opts ()
 	[[ "$cur_" == *= ]] && return
 
 	local c IFS=$' \t\n' sfx
-	local -a array
 	for c in ${=1}; do
 		if [[ $c == "--" ]]; then
 			[[ "$cur_" == --no-* ]] && continue
-			array+=("--no-... ")
+			compadd -S " " -- "--no-..." && _ret=0
 			break
 		fi
 
@@ -82,9 +81,8 @@ __gitcomp_opts ()
 		else
 			sfx="$4"
 		fi
-		array+=("$c$sfx")
+		compadd -S "$sfx" -p "${2-}" -- "$c" && _ret=0
 	done
-	compadd -S '' -p "${2-}" -a -- array && _ret=0
 }
 
 __gitcomp_nl ()
-- 
2.31.0

