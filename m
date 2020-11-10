Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BA8C55ABD
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9466F20781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKjTAXob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbgKJVW1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732011AbgKJVWY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:22:24 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA47C0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:23 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id z16so119237otq.6
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jvauBapL0uN6zq2yeHB/f8iB1nCDxZWO+X+6woXLnrc=;
        b=HKjTAXobVp3UD13VdoVzrGySb+tK75ZL6KuVPQ7+2UI3RO+pFhkt4nXiv5zyzVIjlI
         rUBetvS2iGM8L7xGQWZcKhphBE1MIoc/R2tNDBl5sfcUJsDwAGZIwLz8ru+3BKrEmmmx
         DZUPzTXCDfXUHPOmLy/JWbvaHjZbSEr3ksToyRCeSjjb+2CLjxETMI12eMo4lCSaGzFq
         cLLdW9J++TUk0K2aeiTXluCaRrrqT6U+2mOAag7+T6iAnTCVYz7odwtUtkgmwQ7RRe3T
         4hyMYZn7IcBZbb9/V1EdPOIUiEWZiP7JjuCghp5fnpOQS8nuWcBqgVRw/YfJzCiNhy/Z
         XIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jvauBapL0uN6zq2yeHB/f8iB1nCDxZWO+X+6woXLnrc=;
        b=OVFXJE9iwYCkxzoP4ZMdblFdBXq106U3j9bHy+umJgHc8jSq+Ynd5XDe2lErnOHnbZ
         b7HMlNYMlVIGbEfD87rtgPsqmBtly86nOti9Q+oDpsweC3Kg7Bu7g9UQntZlz7Ks10q+
         icr02uVdKk315x4y9+QSCROFM3n2KvH8YokUQVIIMiTxf7Eo073DDXa4Yi4lPQDWxihQ
         ifD1Jtm9KH1YXqKQvdF+GlUW6+O31OyoDPSiGEKWLOQOGGeCR2oeJbm44cdQmPDfgTXu
         hGxL5xa6rwh2YJY4UkyY1g+gdzisYbhi5NOlBkRt+uBs9kF7401JudbrKQFh6EI+Tgid
         1iFg==
X-Gm-Message-State: AOAM530OSCb37pn2P62+abo+4iYp3CSlBRb3gTkiqaVlTOu6XSHdkod5
        5Y+L+0ELRIDgQcoiOwuHtyMs024+Rl1UIQ==
X-Google-Smtp-Source: ABdhPJxpF+proBeCQKciNiyKDB6fnM1n+lJaf/5tKhq1xfFuvB7TQk0VFtR0n9UMesF8/nD2n87T3A==
X-Received: by 2002:a9d:654c:: with SMTP id q12mr14655235otl.84.1605043343191;
        Tue, 10 Nov 2020 13:22:23 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id t5sm29246oth.16.2020.11.10.13.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:22:22 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 23/26] completion: bash: improve __gitcomp description
Date:   Tue, 10 Nov 2020 15:21:33 -0600
Message-Id: <20201110212136.870769-24-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110212136.870769-1-felipe.contreras@gmail.com>
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It does a lot more than what is stated now.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ffff7e2317..8e6723874e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -182,8 +182,7 @@ __gitcompadd ()
 	done
 }
 
-# Generates completion reply, appending a space to possible completion words,
-# if necessary.
+# Creates completion replies, reorganizing options and adding suffixes as needed.
 # It accepts 1 to 4 arguments:
 # 1: List of possible completion words.
 # 2: A prefix to be added to each possible completion word (optional).
-- 
2.29.2

