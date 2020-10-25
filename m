Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA46FC2D0A3
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B57CD20936
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7bDOO5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766888AbgJYDO0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766862AbgJYDOT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:14:19 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5849AC0613D6
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:19 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id o14so5097289otj.6
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ZO8XtpxlyUrQgt59tHFPcS5frvIGuFbj4NiNC7to1U=;
        b=f7bDOO5RIaVm0s5lqogjXHNH5EGZ/ph4dqwMFepiyF8++MZ5eWkdyoRej+nDEQVx3y
         uyTLXvoMZiu6ZUXn07a89WzwIui/y0YY+9O3VqAI1ovD9gMuZ6QitYY5mWHtbacVLC8q
         B4BUNn+yzT8G4ZQg1XlAFEUZe3hmwLsfxk8MxRh6Q5eKsriKp02bHv9cWPQTRlbCf30S
         +ShB560wfGigLn/EkMvOlN7axXNZdtpjFu8Caf3Ow8PTCr+fd0Em1lEIzOVIGnfxBcIq
         SLe2QGMzJaQtQ148IN4LJ7yxXjLMCsr+tysGDdliuiGlDJ1KfqFWpgh+iaRVcdL/bmQm
         tBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ZO8XtpxlyUrQgt59tHFPcS5frvIGuFbj4NiNC7to1U=;
        b=nhAjfac6PtunNThcZBhmnCSC9YhkS2thMqkT8NAR5gXUxIQ9cueSIDSTBy4wPgeYMS
         vjS/fU3uMLhEsYlzVlZVr33G8QXvnRjCstGr/ap8hN98vdvoo2HGgMGWTpq9yzjvvWdz
         yi25cMsPlqQIWRJnBarRfFhmidA/TlTKno1WTH4UC4S2uo1l58dKhWSh7W7vksWFEZWw
         i5Gch2U6FuidiaExSPon2mJ2rZZkCz5MIV2A6+ldlq2PBgRuPQsTPwsd1hXXt9a2TrJO
         O27lX4aBC6Bz+dctY4VqlRe8cCuMQ/nqqbSyFgeWFJ3wF4ZIvyaDhHNH04DAYuMYnMoG
         dzZA==
X-Gm-Message-State: AOAM532C6qcRJt4pqK1MfMFy0VPpban0aa3nmxkLLcIF4o1VUfUrbzbh
        g9DJPUbQRNhntDTRiZI+CXPuakOO6DUkuw==
X-Google-Smtp-Source: ABdhPJw2MEoNMsWx1hbQhtkIREZV4TgKLvE8kAFjeJdjGhTX+nQZQ36RCpsC8ZIfJcHvP6hebkDneQ==
X-Received: by 2002:a9d:32e:: with SMTP id 43mr8677422otv.144.1603595658553;
        Sat, 24 Oct 2020 20:14:18 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id b7sm1840451oic.36.2020.10.24.20.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:14:18 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 22/29] completion: zsh: improve command tags
Date:   Sat, 24 Oct 2020 22:13:36 -0500
Message-Id: <20201025031343.346913-23-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
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
index 702ce8db25..2016e8c1b7 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -228,10 +228,13 @@ __git_zsh_main ()
 
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
2.29.0

