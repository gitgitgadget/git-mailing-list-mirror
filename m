Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAAFC433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 612C46109E
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhDZQTC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbhDZQTB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:19:01 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E893EC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:18:18 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id d16-20020a4a3c100000b02901f0590a614eso4585090ooa.8
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZYgQl0Spbq4LtnaXl/F1K/rUqpPWbk4hPCxHx4anthI=;
        b=aZi1d5jV70qtG7t4kllEAz68toJLHCXInXkwtzlqi7qpid/IPEFHTohmdNr0gC4r/K
         TDhViDzgwSPNP8lg61xnPOp2Ox6/VD/3jpAc+B2TmYl4mJ4kaTCi+3JT7ShRV8CZqpbA
         37ReIAVhIRArMPzz8HmdLNpw2Muw+Cv8aDMFo13hmqctn1p9kmgkkmWFhc+6YUIKhsdM
         twlHsyo4bWePjW0xMwsAChyLZZt13xwcAZsfIe5gdxC9A1AL1isqd7xVVrfqQNUjHU6M
         eXhIxhXkRZBKWUjSdKTbNJbfkaLbniNj/YXnVj5z992ApRBZ3fJF+rX42mlIzX/eJG43
         HJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZYgQl0Spbq4LtnaXl/F1K/rUqpPWbk4hPCxHx4anthI=;
        b=X74zZf3WSRLnYslMMLsD35cmBzPVnAhoZuwDiwSWcUTk9sjS4prn/qxM7n10XsZuMd
         1X1/RkXpYboSln2U+knYfPXDnegw8rjsTSL0uwx3p+sKSqiDpbfazLMB4iyRUOUWSQO8
         8zkEv1ly3mrZZui1F9AyO//rR744PFPBAoIqNmJ/ZX86TBKcbEdUaR7d3bucZYuLR/x6
         cU1bKRUJfSc6nOD7PdO1AMeEjI1+SV/YdDD8850s7RqMsuvOZXOteJvHerVIDihsOQQ7
         RIslFmCA5R19M1CBftt6RhqY/Zzhzh9fOjvoZweYN/P6irH8ferbyRO2eIoQlJbKSC8u
         9SlQ==
X-Gm-Message-State: AOAM533HzuGlMZk5OtPUgKT7qQSkSKyeCx8VBCZrxL0T1pznMGj6kMbz
        q6NZ5UF2mG9JQs+pJfBCChLc6GXdQv5ZQg==
X-Google-Smtp-Source: ABdhPJzo2ssB3zusIY4su9gU64DmOhGMFFsQEzqQ4/HuAGdiLjQwH4ORFvm4oSqttTdL0GXhJ51xbA==
X-Received: by 2002:a4a:3352:: with SMTP id q79mr13993582ooq.23.1619453898197;
        Mon, 26 Apr 2021 09:18:18 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id q20sm194049oic.41.2021.04.26.09.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:18:17 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 23/43] completion: simplify __gitcomp
Date:   Mon, 26 Apr 2021 11:14:38 -0500
Message-Id: <20210426161458.49860-24-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not possible for $cur_ to have anything more than --no- at this
point, so there's no need to add a suffix, nor check anything else.

All we are doing is checking that $cur_ matches --no, and adding a
completion if so.

This way the code reflects what we are doing.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 5 ++---
 contrib/completion/git-completion.zsh  | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6c8a8f6f5f..766c7f57c7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -341,9 +341,8 @@ __gitcomp ()
 				continue
 			fi
 
-			c="--no-...${4-}"
-			if [[ $c == "$cur_"* ]]; then
-				COMPREPLY[i++]="${2-}$c "
+			if [[ --no == "$cur_"* ]]; then
+				COMPREPLY[i++]="--no-... "
 			fi
 			break
 		fi
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index fbd03a0180..4eef9c5199 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -62,7 +62,7 @@ __gitcomp ()
 	for c in ${=1}; do
 		if [[ $c == "--" ]]; then
 			[[ "$cur_" == --no-* ]] && continue
-			array+=("--no-...${4-} ")
+			array+=("--no-... ")
 			break
 		fi
 		c="$c${4-}"
-- 
2.31.0

