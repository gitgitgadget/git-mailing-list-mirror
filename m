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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE123C433E0
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCF4520729
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbhAACSL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbhAACSK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:18:10 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A51C0617A2
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:29 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id i6so19330093otr.2
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2OjcEM8uVVjQA/LEQX66U+RCjhS9bdxcoTqP4lyMrAM=;
        b=PsQDRJnNQHa95rUH9NiCZoOqCMC5zVGlV2tukazo+ItRvjEcxgUQoF8tRWyn/LtBmP
         uEza3fuidCa+5Wj6VAP3p+zHisAK0c6pPXQxkwCaRrb8XJV3gCWREeV6NjKNI/+9PP3M
         lNlAG8DJH1oz/E/6tHbnSIcdWeQA0e1g5iDW/KFbLMxKtnXf1GKGY0FduN3ElVKBKvEl
         cZPTN22mvYsBK+mpZFmuYaxky9vK2W67P77fqdzLWFx/VtSxKwfIeJvX4Q+tSj54Lc4U
         NCW0jILuHsB3ttMQtgZW1FgqDZUxelUfe+cvc0/xiEBRBezGsmpQ8Kg7C5HFdFI2iRDd
         nN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2OjcEM8uVVjQA/LEQX66U+RCjhS9bdxcoTqP4lyMrAM=;
        b=gCDtIBoIfT3j+EfFz7RmAqEOF88SGCVe1tnxDHNyZIzLiw/o8dxnS+uaXS76pz8GsH
         GiSx14/QGTGLsxHdarv16bE2QH6opvj4ZSc32GH0yHr7SZ5kkcq+8TS8/9hmiaaScn8/
         78mpmlqKoVOzzjmGdCBCecZBOcJ3b52ts8EK/CAAnrOdRh8WgWvP1dZlazALd3dUqI5s
         aIR7TNzYT3a/s7O9ncD8DElYPCqsz6ONVKlEy6m42Lg408ylE5D951Ge21OvbcUWNBwF
         S5yt7JJCMMwdy9glaywfVQV2CSG23iOC9iPBV/ZhfimlJB2qk0vujTUho37wL/pbJ2TJ
         v9eA==
X-Gm-Message-State: AOAM5301YBJiBYZbcv7f10gFroRrcOEg73qwginxkyQqrmdyCXuAU0cS
        Ma4/7LscgClBa+eCvTZiwCqrRxyfbqYwmA==
X-Google-Smtp-Source: ABdhPJz/pISqFceGwjahb1uXoHP19KZjxVu+wwjSxWTQxlZ02xf2se14J2hL9byJ1xLX6bnFjTO8FA==
X-Received: by 2002:a05:6830:1308:: with SMTP id p8mr42220530otq.330.1609467449107;
        Thu, 31 Dec 2020 18:17:29 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id u141sm11285307oie.46.2020.12.31.18.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:17:28 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 41/47] completion: bash: trivial cleanup
Date:   Thu, 31 Dec 2020 20:16:16 -0600
Message-Id: <20210101021622.798041-42-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
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
index 9918998848..d481824a7f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -346,9 +346,7 @@ _get_comp_words_by_ref ()
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
@@ -383,6 +381,8 @@ _get_comp_words_by_ref ()
 				cword=$j
 			fi
 		done
+	else
+		words=("${COMP_WORDS[@]}")
 	fi
 
 	cur=${words[cword]}
-- 
2.30.0

