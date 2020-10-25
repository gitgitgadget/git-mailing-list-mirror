Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5174FC56201
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2438620882
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egMrImZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766822AbgJYDNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731837AbgJYDNt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:13:49 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CB6C0613CE
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:13:49 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id u17so6950701oie.3
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KP8M/6Zey1w8U/r0Vdi1896il9WkPM/iUniB5jCSgbE=;
        b=egMrImZ2X4gleUAKbuXVvj5+kFv3CTvJgm6JqadyY5DHZ59CgSanXhydTN44Ut2QC8
         CU6jdP6KYu2dr7IomsHxhzcUXncMW1dUFf60fTXR3B0F7smm2tjBdracLljmW9+Z0Nlv
         VldciyDBjEpBmtxWHUFlCqGu2icQCN9F4OQCHd9EDpbsM6N5muRUbPYKJhxuJeLtV8pJ
         ZI/OWeGa2IvLY/vCmBq4vchgR8ITGH69eKFqdQkXnhwJKT3agvGZFi/XkHDYNRWsIc7D
         OvxI2olC69pWUDkkWF/gI19/n0HTYPt3+UILiGPWRbxmU3+E63/RxzCHslgXoFN/5m8v
         tOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KP8M/6Zey1w8U/r0Vdi1896il9WkPM/iUniB5jCSgbE=;
        b=qoakP3QLeqawczUr71WoWSVZbGkKsgyu7U5Ojw5vsC6/Jfw7YjSI72QGtbf1umc6hz
         N1pUi7obqJtIQWYh2aIlIyhrLXPclWxEprsgg9yNL2EAYfc4UorKAoz8weaCcYIZMl/o
         kPazG290xfC23Q/qAN8V0AjI3yyjGt1ggAZ3TTLACx6eGe7nBbbEy7xIztYzwu1A5iJ2
         IxFm2NxadGf6XRkjUAXqB/sAPOIZmGPpgNMNlWJS81YUZYVAhPZ/1XwVUPdm/p50f9IE
         VEUVmraE13vqi6Tu2JCaR1/FI6KwRr+I2gShM6lmblnntWBSVDYlC0k8+eW1gM7j577A
         8fKw==
X-Gm-Message-State: AOAM5304NkgfTxiBRhHw64L6o3zfy+2NhGLCeUV+o2KoPofakKbOSGB8
        LcloHwwnPm4hQkGL0CioH8J92bYSbxPA6g==
X-Google-Smtp-Source: ABdhPJwV3b1ofk7dy5NV11uX6BoaG0yP3WIadSDLwgDO2/qrmP7ISpryTWVoWNAfSs/F69Xf0RCyqA==
X-Received: by 2002:aca:be56:: with SMTP id o83mr8266815oif.1.1603595628837;
        Sat, 24 Oct 2020 20:13:48 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id t65sm1867353oib.50.2020.10.24.20.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:13:48 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Maxim Belsky <public.belsky@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 02/29] completion: zsh: fix name due to broken autoloading
Date:   Sat, 24 Oct 2020 22:13:16 -0500
Message-Id: <20201025031343.346913-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 176f5adfdb wrongly changed the installation path to
'~/.zsh/git-completion.zsh', this ensures the script is not
automatically loaded.

The whole point of adding the script to the fpath variable is that it's
autoloaded after typing 'git<tab>', which won't happen unless it's named
_git.

I've changed the wording so it's crystal clear the name of the file
*must* be '_git'.

http://zsh.sourceforge.net/Doc/Release/Completion-System.html#Autoloaded-files

Cc: Maxim Belsky <public.belsky@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 2cefae943a..6d451355fd 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -11,9 +11,11 @@
 #
 #  zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
 #
-# The recommended way to install this script is to make a copy of it in
-# ~/.zsh/ directory as ~/.zsh/git-completion.zsh and then add the following
-# to your ~/.zshrc file:
+# The recommended way to install this script is to make a copy of it as a
+# file named '_git' inside any directory in your fpath.
+#
+# For example, create a directory '~/.zsh/', copy this file to '~/.zsh/_git',
+# and then add the following to your ~/.zshrc file:
 #
 #  fpath=(~/.zsh $fpath)
 
-- 
2.29.0

