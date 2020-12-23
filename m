Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57424C433E9
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 14:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29F5923341
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 14:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgLWOte (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 09:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgLWOte (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 09:49:34 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE888C061794
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 06:48:53 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id l200so18423604oig.9
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 06:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YbdoSm8EtQ0FJfHn3PPhVHREjneJpjjRtRn9xPpNRV0=;
        b=Vjfq0r4GL7SGD8IzwwMMdvwkGdSoWnJC15QgySeahWmrfduFoboQQ2/NgmJalSSuYM
         EZrtF9rrAujw2vqm36lH1lg/mEOIa0PES9YdRVCk0vmN1SoHQ5wvroR4TziGv+y45SVI
         g1Ikpgz8/ShQTOgyRlWn7f9WbepeukM3cuggEzLQLGAGfEKRrBFyKRpwY7qKzpHVjk+p
         sY6V4STGHavgj1etSh1sKIgiEAHIaII25qMf4wYjTvQBeyWIcyMf3s/uO4DCtD5/9RVC
         LpAEil2n5qye94NQKhUPQ4BxOsFyuBWWvD8oSpG8R2xDYdHpS04W0JSyYYx+IGKLESYq
         CKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YbdoSm8EtQ0FJfHn3PPhVHREjneJpjjRtRn9xPpNRV0=;
        b=Iv7RILNVczRz0+0VuyLSSLKrAqhuWqYStN0IAujC/iT3J0SzHe/lFSQE7MLOBu6F0m
         P+66lXKpo+BHKZ4ZJoRUIK0mP+0Rz795jp8WBna/UcQMcEjUKp8JoGij9FHUGvDNf9/V
         AE83F0cnajuL2QXIJSp08NgTRdRggwL9PHko/tCnTRgbcT8g9hTfUbnl1VtIBGeWaoDM
         qkK4W32eYEz9jPfGwqWhAnmTcIam1csSsMTwZ4ACbszHS0az/5PqZPykS3GVpurH/U4V
         J4qKjXn2hbNNsAfR9app3Vm+kofvJeS6ImSyjaca8LuyBh3AAfWJhSScHjf9HOJ6LwsX
         7g+g==
X-Gm-Message-State: AOAM532gugmRpcQhbyPLXyh25bkFj4oR8mSewZgjq8eaSPSrJgMPB0Ui
        wMofrukNduSQjx9zMhuRJ/tyAy1OgBbYrg==
X-Google-Smtp-Source: ABdhPJyTcINy7oRxU3KMr0M2Vm6IFU+z7T9UpwH8AEvkN98csrhBdMhKAP2ibTYrYhzFihHTj4hvqA==
X-Received: by 2002:aca:5453:: with SMTP id i80mr120336oib.2.1608734933160;
        Wed, 23 Dec 2020 06:48:53 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id h7sm5411067otq.21.2020.12.23.06.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 06:48:52 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/4] completion: bash: fix for multiple dash commands
Date:   Wed, 23 Dec 2020 08:48:44 -0600
Message-Id: <20201223144845.143039-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc1
In-Reply-To: <20201223144845.143039-1-felipe.contreras@gmail.com>
References: <20201223144845.143039-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise commands like 'for-each-ref' are not completed.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 10e69af9ed..64cf35ba04 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -412,7 +412,7 @@ __gitcomp_builtin ()
 	local incl="${2-}"
 	local excl="${3-}"
 
-	local var=__gitcomp_builtin_"${cmd/-/_}"
+	local var=__gitcomp_builtin_"${cmd//-/_}"
 	local options
 	eval "options=\${$var-}"
 
-- 
2.30.0.rc1

