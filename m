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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175A0C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C67D0239EF
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgLHA20 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgLHA2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:28:25 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF4EC0611CE
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:27:12 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id q20so1890424oos.12
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uWptlYuhXDCZAz0F+eIUPJTkgpL8Oxwz7vgAz6RQJ08=;
        b=fhWY3ahhNMCfmMlPDMOVOslN69oMTHuYac98Tqji6pVL47IUPWB1LOsJMGWCtVQ934
         oy79u8bCLqhpXvZzUI9c7ON46zeHM6T8eRBLDLI5pTTVQGTEhbxDhpJcYOJ+FPWqpoq7
         T+vmM3r9OcXv/O9GqoFXVOAnE0LCiHiwDaO+qf0LmYetfritp5UzD/P4IQuOybRz39EU
         Nuz5aqznyyQR2p4kEQzjbz6CGMfjWB7VF9Jp1juVfT2AYfSzTUEuG0cd5taOxXkofKJu
         HHWhBcPTVCM5t0zYDIJxSkZB3pWdEoyF+tks6mUJ88qlXLVp+PwbjmXYFV2iuZe/rH9d
         1LYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uWptlYuhXDCZAz0F+eIUPJTkgpL8Oxwz7vgAz6RQJ08=;
        b=DAS3TIISjKCgM42V7Ws4560p6ld+ybr7IBqeiWNAW5PixXt/2jR2MPLztrDjEM5Uwz
         eoQj6tAa+BgTjNISoBg0kqPbUZ7uXc32AmaRobRZVnNKLI1cHpDvV+wkW6qjW3cnYvW1
         YqbHxLCNX8aXN4a8c1bcJChx/RnboL+nP1Yll/LNPfLhR9DP+PTrGHtyK9ZjFlNh9ZOF
         bHyFnjrGIh4fypiBqU81MgaWy1NQ7PVDK+c3npqAGw87i+OXMbhe3Rd+I+1v8iUvU5Kc
         2WzZnxE+yIhscllcHjQREho5+9FLa/ybO+vpdPkq5SdLyo9gpkis+9MgE+jHk2MCLlvW
         AyRg==
X-Gm-Message-State: AOAM533PmFrDSNnaFex4vCkfGdYJ3F1MfNRrM2+niMzRFowwAy1GjKga
        PX6DOspQmD7qp/Tro+vjTOUqdY8+dARtWMNC
X-Google-Smtp-Source: ABdhPJzKlDL4anH/gYoTZSD18RoTNry1PbJSMXlLiJYdy3uGvMwXSO7449FvDPl3fRr0AsitC0YvnQ==
X-Received: by 2002:a4a:b144:: with SMTP id e4mr14579735ooo.3.1607387231767;
        Mon, 07 Dec 2020 16:27:11 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id s189sm3331938oia.7.2020.12.07.16.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:27:11 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 13/19] test: merge-pull-config: trivial cleanup
Date:   Mon,  7 Dec 2020 18:26:42 -0600
Message-Id: <20201208002648.1370414-14-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208002648.1370414-1-felipe.contreras@gmail.com>
References: <20201208002648.1370414-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit e01ae2a4a7 introduced an extra space.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t7601-merge-pull-config.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index d709799f8b..8a6aae564a 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -33,7 +33,6 @@ test_expect_success 'pull.rebase not set' '
 	test_decode_color <err >decoded &&
 	test_i18ngrep "<YELLOW>hint: " decoded &&
 	test_i18ngrep "Pulling without specifying how to reconcile" decoded
-
 '
 
 test_expect_success 'pull.rebase not set (fast-forward)' '
-- 
2.29.2

