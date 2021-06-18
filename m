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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDE0C49361
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 062B5611AC
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbhFRS1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbhFRS1o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:27:44 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316B6C0617AD
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:34 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso10576630otj.4
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cUKZz0H1QBu/HTdhUngiScEYOBVU5tFVUWxaf7KEbOI=;
        b=eCyykaKyxMysS7m8g6TUkKfvChwX6MN2rTIDkWorx8UaE2CPEmU1KP6rUrMG9JnEkr
         j9HKO0iyufJTlDtJoD8f2gsCSH4x7UZfrbilf6HbRnWGT6npL7QUt8S6bPJflbtFUMYd
         xFiM5E6kug5NXeYRHTzQQCYH7fh2NyWQr7azqWepu4Ynvalw3Twcz+mmMuQn+6UKsEKb
         ktu3oEvh1OiY7k8+IrRz4E2TEIMCElQmIh7g6L11XYeuWRtxIeQiU0Dvz5vP9KhH+c6w
         SK5bINzIv/wt/vsU3D/H6ndOuLJi/vwwJIHvsbakIHZMaIRTF40i2NMC+k1iDPftvbmn
         1A6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cUKZz0H1QBu/HTdhUngiScEYOBVU5tFVUWxaf7KEbOI=;
        b=n9whhy7JB3s0/DqHeQoeasOgqW+WOobV0aw97n/4GbYEsdkfUn9HEVSb5KlCrJEj9M
         Eyf/toPZ0q+q+2LmCyPU00xw77jJZz7eurXIZhs80cdGYf5LTtvliCastTBBTFFuQWhu
         EXmkIdkgUanFgQtszsZw8BoSRtJNsjhVER/Ddl9miT8xBSlWfmzpN/IGPo/RmMwfXjcu
         VgmRcPeTVvRypWv7oYrbcFR8TVF9xcTvIJWYQZjkBhLOwZfCPXJLFbKd6hDyGdjb0tFS
         Wmaq2Dk2yKOgvhTO6Eh1rhyeAvZCqgV4SAQt8B4PbwhtdHU9EzrommbfFBoNs2pBgZ0A
         Xiow==
X-Gm-Message-State: AOAM530/75cHytgBN2ICc8TZ8Br5ZoY2DtVNn/o8n3lct46VzxDub+0H
        pWnJbVXlqz2gkd/AH7VkwoMxr6BOIGG9Iw==
X-Google-Smtp-Source: ABdhPJwvt8yu0SsDQ/aVQzW1UdzgyS4XipmyDRWaQ15uIru4sq3KNaGr1yT7gCvXCEBhF/4OLDTjtw==
X-Received: by 2002:a05:6830:1be6:: with SMTP id k6mr10551256otb.219.1624040733270;
        Fri, 18 Jun 2021 11:25:33 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id e19sm1952262oiw.24.2021.06.18.11.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:25:32 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 07/45] completion: zsh: trivial improvement
Date:   Fri, 18 Jun 2021 13:24:40 -0500
Message-Id: <20210618182518.697912-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$words has basically all the words we need, except the first one: git.

Lets simply add that instead of passing the original, which contains
options we don't want to pass downstream (like -c and -C).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index da13c184d1..9f0e03e86b 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -220,9 +220,6 @@ __git_zsh_main ()
 {
 	local curcontext="$curcontext" state state_descr line
 	typeset -A opt_args
-	local -a orig_words
-
-	orig_words=( ${words[@]} )
 
 	_arguments -C \
 		'(-p --paginate --no-pager)'{-p,--paginate}'[pipe all output into ''less'']' \
@@ -262,7 +259,7 @@ __git_zsh_main ()
 
 		(( $+opt_args[--help] )) && command='help'
 
-		words=( ${orig_words[@]} )
+		words=( git ${words[@]} )
 
 		__git_zsh_bash_func $command
 		;;
-- 
2.32.0

