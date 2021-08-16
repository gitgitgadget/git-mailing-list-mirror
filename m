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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFC1C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 09:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 018736113A
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 09:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbhHPJLE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 05:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbhHPJLD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 05:11:03 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C9AC061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 02:10:32 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id o185so25698103oih.13
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 02:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lmMOjKD2GdJ3kfvxotA5vQuZ/R3UdAVe9/YJgY3VHPw=;
        b=MFeSYuA0JsA7aDd7KCGMv+FRi5rFTOXzxEqybpnzYfhVBYX9gC0ntCTrbs5y4IQM6r
         FMRy4E7LbV/lKh7oggRzT7j2gpCmg/tyK919HpLE0Rvxh0IreuO6gIOH8Tpsk4wWVdsR
         2xJ7XAoGri+UGR0rH/OInR5kZqkvM6CmPOAlEOiAYJ0r2nSP4rKN2jMMx0qdXJLqDnPf
         0MTWXru1Z33cQZaoL8WuPxiSMR9pn9zLXiPhZPUrYp8bo4EW+NI59mTaGseGSbpjnZJa
         ofHavBfYymy39qh9QdguzU0FbqX0HDojA/lFPkRFwACnMTzcbvyuK88sSFbhlswIVTIS
         OWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lmMOjKD2GdJ3kfvxotA5vQuZ/R3UdAVe9/YJgY3VHPw=;
        b=cSSQ1zF4wb4WFqM365pI19YLgwCVHuVIyAHefdbWNrROJ/4CuNAndNp3jzMIEGX+kU
         cNhF2wGAZ9zS+QJWQtTXtxGN5XtYTWj/wad1l1J5OjEruUOHVTG69/plWAbtDjyXWUhb
         maW4wGET3+AgyWNTTsKpC2E0SJh0HCDL6N8KZcZ50ydaJzZW1N79MNCtd02cCZMyGxtL
         YNR4npL+VHx7QRlb7KdmUF/jva9fgstHaxFSsRWZmCQAUz9UXf8EVHhtZsspNRtVSC36
         DYsqLojj5iF50Ey/J60QrZCA5+AamPbuNBIswXiNePX4Cw+XDj2jBNtwyAHAW2DG2kip
         O29w==
X-Gm-Message-State: AOAM5334SPbuDdvBabcXHKs9DW/ZxVgu3oVpz4MLeA2u2/O5bO3K0gM6
        NsMw3yQ9fjmTmjGnXGMAlAIpdmYDtyk=
X-Google-Smtp-Source: ABdhPJyK0/VFAJJciqrcNVa5+Iz/RoQiZnpF+0z62tObX7h3bzCzZE5TrbgjtdRwn17UQzFKIiIuUQ==
X-Received: by 2002:a05:6808:2208:: with SMTP id bd8mr11244721oib.110.1629105031825;
        Mon, 16 Aug 2021 02:10:31 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id q62sm1985977oih.57.2021.08.16.02.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 02:10:31 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 try4 3/4] completion: bash: fix for multiple dash commands
Date:   Mon, 16 Aug 2021 04:10:24 -0500
Message-Id: <20210816091025.548095-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.48.g096519100f
In-Reply-To: <20210816091025.548095-1-felipe.contreras@gmail.com>
References: <20210816091025.548095-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise options of commands like 'for-each-ref' are not completed.

Tested-by: David Aguilar <davvid@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7aea1abda5..b7988f0485 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -421,7 +421,7 @@ __gitcomp_builtin ()
 	local incl="${2-}"
 	local excl="${3-}"
 
-	local var=__gitcomp_builtin_"${cmd/-/_}"
+	local var=__gitcomp_builtin_"${cmd//-/_}"
 	local options
 	eval "options=\${$var-}"
 
-- 
2.32.0.48.g096519100f

