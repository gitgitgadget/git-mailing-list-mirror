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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107CFC49361
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF84C613E2
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236384AbhFRS3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236383AbhFRS2p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:45 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03DDC0613A2
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:30 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id c13so11464188oib.13
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RtBFRg4YIY0Ft23J52Bewvp56U72amuajVH1wIdgxT8=;
        b=cYrTGf5+KbK1JWI/CPSDp9aBhkKLAtgSrttZaHCMMtmZab2Krbl+lexxh0iJ8K/ovS
         jNCEwKOEvTp+njkz9hGxAYq6rNdmU65pjCXAFnzsmWxtkiflcmsfKCLylrqLQC/V4R+n
         s1CJ42cEkPwF7wn3zeM1o7SZAb20BcVPNP4XAO3XerzYxNydfBvuD/0ui/eDGKOJ637X
         xVBpH105P9W9mjYoT7udbN0pKgKeZWjnInyn7fDj1mCai5PVWHp2Uz0T6/m4knWLcT4u
         qgCj0b1aq1mGAuvNi2tXR2MCe1SuwhAyMlv0Prew8eTawKjXDOuvnJSDfQTgfqgA6cTQ
         AszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RtBFRg4YIY0Ft23J52Bewvp56U72amuajVH1wIdgxT8=;
        b=EErh6/0p+4jnho2qGx5+O2a4o83ZFiBrvgula6n1IEkn5ZA9t+8hWFJBv7bhux5oKU
         JFxslJv8DAdpUlxGj2CXcSIC599ih6sV102+HFQ4uYTw1zVvKPrS2t0FjIwPnWCr2dHi
         JDa1bUcP3VSyIJY49OXNQLxmtKnhe1004kuC0wtZO/8t3t+2czC02u3+5jHmI31Ul4UW
         QVi8tci0jB9TmwIFVY4mKmDkFtA2nZ18jWjPu0W54K/r9+ukIUJA+IGHGMfTdZZNL3J7
         L3T6PkixM5VaiWIoCfI1+gNKNsg9ci3IT48rAmFgRCtgZVJG3seIapMCuzmR3IDiHvJW
         pV0Q==
X-Gm-Message-State: AOAM530/hTwOfDNX/fBR/dLIamPU23OZTcod99GxFb2X0m/HjqkaRBbH
        LFWQjvBe2BmMANtFakvvOeeQr9Che1zlRQ==
X-Google-Smtp-Source: ABdhPJyMAwl1Sog8SL83MtAox6c00vqnnXdRh4xI8kvg2ebL0BGRD66i+r27eeop279wUkWDFdYy1w==
X-Received: by 2002:a05:6808:484:: with SMTP id z4mr8171447oid.89.1624040790187;
        Fri, 18 Jun 2021 11:26:30 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id l8sm1952202ooo.13.2021.06.18.11.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:26:29 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 37/45] completion: zsh: fix direct quoting
Date:   Fri, 18 Jun 2021 13:25:10 -0500
Message-Id: <20210618182518.697912-38-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apparently using "compadd -Q" is almost always wrong, we want zsh to add
quoting when necessary. However, if we remove the -Q option, that would
make zsh add an extra "\ " at the end of some completions.

We can manually remove the spaces from the completions that have them,
and then add the suffix with the -S option, thus there's no more need
for the -Q option.

This makes completions like "stash@{0}" complete correctly:

  git stash show <tab>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index c4510a3180..3818291950 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -55,7 +55,7 @@ __gitcomp ()
 	emulate -L zsh
 
 	local IFS=$' \t\n'
-	compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
+	compadd -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
 }
 
 __gitcomp_opts ()
@@ -85,14 +85,17 @@ __gitcomp_opts ()
 		fi
 		array+=("$c$sfx")
 	done
-	compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
+	compadd -S '' -p "${2-}" -a -- array && _ret=0
 }
 
 __gitcomp_nl ()
 {
 	emulate -L zsh
 
-	compadd -Q -S "${4- }" -p "${2-}" -- ${(f)1} && _ret=0
+	# words that don't end up in space
+	compadd -p "${2-}" -S "${4- }" -q -- ${${(f)1}:#*\ } && _ret=0
+	# words that end in space
+	compadd -p "${2-}" -S " ${4- }" -q -- ${${(M)${(f)1}:#*\ }% } && _ret=0
 }
 
 __gitcomp_file ()
-- 
2.32.0

