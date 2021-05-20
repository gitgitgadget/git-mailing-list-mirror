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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FAAC43460
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA2D3613AC
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhETVss (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 17:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbhETVsq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 17:48:46 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B891C061763
        for <git@vger.kernel.org>; Thu, 20 May 2021 14:47:24 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id c15so21602335ljr.7
        for <git@vger.kernel.org>; Thu, 20 May 2021 14:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0OfjDCFK40CHYWc5u5uSaXiZBcYaZsJ1ZH5HBXLLJ+Y=;
        b=DtxpmHNCocZDIYLvEPmXji/nLVzCqmeRyd0wcTvi9PU/ku5QysLJ4QEdMqeP0YLR0T
         Y9ecklUUIC5TOMg/7e9JyUmjMiyJcHbK4cMyL2/GEiyR3EiePKX8eZQUrK7mDea6NPLv
         EthEu1oanVJCXUvdbAV4LD9CY3nXFUzbXs6q/PPF9YuO4qC1conTEITTxTdl6K2Q+LQS
         0aaK6VlIM3u7rObE1+bFxYmeZ4ovhGOldwDQNNy2PEyAStm2I0hVH2XVJOcMsL3ROEs2
         EqiPh1mIRtZ2TeBctS3MWlj7wfRL7wJmFL+FqfvKPO8FUMyWqOC1Iih6G1ilakddlkIU
         SgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0OfjDCFK40CHYWc5u5uSaXiZBcYaZsJ1ZH5HBXLLJ+Y=;
        b=kYnL6e3MZf/6Io0f/vFGztzi83UPygpRRUltVGTAa032npCU4+2UGxMJyCNzKZrq4F
         ZscCQtNx1fvgBHHsg6qSqNulGb61fa6fZaJYMbS2vVggNeLSjNNujpsWaICZ4Uw5oSU1
         jaCN9f6jz11Zlr4iSPe/VTBmauU3j0LerA51hEiUdpXRCVCbkDMXRbXsL45lVxjUV8ac
         b+JOweE+PcRh7vIJNJ00rgMu+tBs2rWsy2zjnMzwI0nGhPIAIE9gxewtX5kZ/lXtivDi
         4rmzQTh/uW6KjtXF+qTudS9kv9zBO1tsEN6h9DC2jtXe3qJtVN0KGFTUnKBKXtuaNzIA
         4/mw==
X-Gm-Message-State: AOAM533PfE9/VeXs3l0xqyg2qkcuUYQFrLgOKpg3c0X2nBbjnxnU74dv
        1mtkgf1FA3dyKiHNZU5ktQU=
X-Google-Smtp-Source: ABdhPJxDGO2xRDLs66oJ1/ZQ9UYuKmQc7h4bx1AqUXNKyLjsbG/WTmE0PBg0flgpkZ7ZUOAYB4qrJA==
X-Received: by 2002:a2e:890f:: with SMTP id d15mr4577051lji.54.1621547243055;
        Thu, 20 May 2021 14:47:23 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p2sm408414lfh.31.2021.05.20.14.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 14:47:22 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 07/10] git-svn: stop passing "-m" to "git rev-list"
Date:   Fri, 21 May 2021 00:47:00 +0300
Message-Id: <20210520214703.27323-8-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210520214703.27323-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210520214703.27323-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rev-list doesn't utilize -m. It happens to eat it silently, so this
bug went unnoticed.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 perl/Git/SVN.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index f6f1dc03c608..35ff5a68963d 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1636,7 +1636,7 @@ sub has_no_changes {
 	my $commit = shift;
 
 	my @revs = split / /, command_oneline(
-		qw(rev-list --parents -1 -m), $commit);
+		qw(rev-list --parents -1), $commit);
 
 	# Commits with no parents, e.g. the start of a partial branch,
 	# have changes by definition.
-- 
2.25.1

