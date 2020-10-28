Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6362AC4363A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A3820878
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RP5+Af36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgJ2CFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 22:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgJ1Vic (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 17:38:32 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5400C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 14:38:32 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 9so1115655oir.5
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 14:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w6Ui3PmfcmaZFFFXz0FUQ4Lr/gNpAFU0/draG+RBXU8=;
        b=RP5+Af36Be3KNDYtOSoeuCA+vyVPh/DCEPxeZvXXRmqphGpsdIUamqw2oVikkEJ+9h
         ZIegkGSAqxvB4EEIi2yDRBC8d5ihNsqUv7z7qWetnoHNi696OAuqIS4yWuvp4krkAvQs
         wkFJcuXV7KXbUya5EVVG4LctkYgVsaWQa6Dd2HIj2Vs4N83sc9Ge1lTiAAY16CeFGYOn
         BOAEixFC7209Xqha8N6mcKUpDmvXOpgZaMYwLJAmtjVvPMSda38VjD3e6pPQCInZd9hn
         YmvrE2ioBmOHhmGMhOMM22DxuN9crJEHqchXwl0ms9UwB7BbqwAb2AC3CUuTNKrYNvOL
         bquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w6Ui3PmfcmaZFFFXz0FUQ4Lr/gNpAFU0/draG+RBXU8=;
        b=fhs8eBb9jCl6eP5CmDL3yidJxJuccRKfhdWcx+0JPbkHZW1zuPCyvcdl7o+eGDfF8q
         dNqCJk6Ib5/3eGHXURwcNCvEhPHFqJxL1ky2q9DmRjdKoIE3XMMXfygdo+bWrZIhTh4M
         0UfvjNfPKD+qmmp7NFoljAKonR5oN8jzktKcC1z4ndDffDblqXXkPTuBiHAyfMKrOBqj
         sLVsrWsjGKY8h66kH9zHhQFExg0BxsB18vB1IOLpjfOOz92z6BuVhzAaJAWDxma2kcqQ
         XT0/dBlQUZcmstf5ZiQh5Fuk6VKS76ayndWe4aJSWdOjgjy/qm7Zl+E81OCXgDm30GBO
         2aEQ==
X-Gm-Message-State: AOAM532gEiVOSM1G7M8RsBRSzJQzilagOzqVDLQOWXaloBjf2LiQexGv
        KrXVINvESmMa4KL+e81JXg1XSWA/JcDwYg==
X-Google-Smtp-Source: ABdhPJySgkC3uFfMb8mbJPMUJkhl+elOgWhTEy+qNDnc+naW8cuqxg9Aa2oMhWQx6SroRrFC1+K0hQ==
X-Received: by 2002:a05:6808:254:: with SMTP id m20mr3705102oie.139.1603850870659;
        Tue, 27 Oct 2020 19:07:50 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id l23sm1722439otk.68.2020.10.27.19.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:50 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 22/29] completion: zsh: improve command tags
Date:   Tue, 27 Oct 2020 20:07:05 -0600
Message-Id: <20201028020712.442623-23-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to use _alternative and repeat a lot of the code.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 858864f3fb..22d8e58fcc 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -235,10 +235,13 @@ __git_zsh_main ()
 
 	case $state in
 	(command)
-		_alternative \
-                         'alias-commands:alias:__git_zsh_cmd_alias' \
-                         'common-commands:common:__git_zsh_cmd_common' \
-                         'all-commands:all:__git_zsh_cmd_all' && _ret=0
+		_tags common-commands alias-commands all-commands
+		while _tags; do
+			_requested common-commands && __git_zsh_cmd_common
+			_requested alias-commands && __git_zsh_cmd_alias
+			_requested all-commands && __git_zsh_cmd_all
+			let _ret || break
+		done
 		;;
 	(arg)
 		local command="${words[1]}" __git_dir
-- 
2.29.1

