Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD19EC433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 12:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B384E6128E
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 12:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240954AbhDMMaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 08:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345911AbhDMM3E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 08:29:04 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008ABC06175F
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 05:28:44 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a4so16282752wrr.2
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 05:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R/wPsmzGW7ld06CPbTH0BVcUVun/eFbBSJW/Bpk1bac=;
        b=ohYihJmJfS8r8/T/f39nolrnTTVUVKS7pjhUEa3DkmQztDlnXihd2jRdtnlqayQ6gu
         x15I/MFK3mh1OpZIZJ34u5XjsZeu4owaa8EgW5hqXpI4NZpoPAdjEkw4qPCXZT17NeSI
         FfTX4QQutks0C/KzlcHPUFJaenytF4653PC6zBmwRnC8YT6xCFQUmuzthMJcj9hk+MjV
         LYodkZ8/49Z/CKsIM9oIPDYDbgSEFNNIlkufmY3+a7d4jnNEmd9hSunAu0mdKL5rQiyf
         gMUh4tDKQi16sv1PcpMCC11m2DgATueUdnx8etxNPyhbdi9NgPvzGfl/Pq4E8zDoLR/i
         Mvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R/wPsmzGW7ld06CPbTH0BVcUVun/eFbBSJW/Bpk1bac=;
        b=ELGf5xwejjumfq7kjJ/7hQgia5E7WXS0v1rssVD0iRm+LwX7H7xIdndgmM0mNSGmG+
         LVl1ITZLEkevz6xaw0SbmwFfzBBt+54t3X+JW9hBRxoCypN89U+ZQBAGC75ZVfuZBUqg
         VEBFvXZ6Sc4BMwPY8z2YL27dcTt7LXUzrmG+ibLOiwUSrNs/v7yZyCg0xmIG0Vljy5hR
         hCW865qk4LsaJ0u/fmBGy+AplUxbRPbQ2DiR3cPEqMcrTWTz083FvadLcLwmutVGcolm
         qYNYqMlXHbNSfWbPitbWLDFg9nV2M8TUSS7U/sNQguCGLMzSB8YMnDO2kOfyE4DiprT/
         xgrQ==
X-Gm-Message-State: AOAM532nuvRbyIdHtoC5HSIDUQopsXh5U/hLx7ov1ZUcohxcCbsZVcM7
        mQ4hPe6ELBw8QdjfsOz4cfcHpOK9xN+Srg==
X-Google-Smtp-Source: ABdhPJw+UhQFml6Ulyc2Szd6iD1hjapIkcj5Wiviev25PFKjaGAjWBpKmhQnA/wBavRXnpj7KwtkHA==
X-Received: by 2002:a05:6000:1004:: with SMTP id a4mr35265667wrx.202.1618316923489;
        Tue, 13 Apr 2021 05:28:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 7sm19565445wry.60.2021.04.13.05.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 05:28:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] diff tests: un-flaky and post-gettext-poison cleanup
Date:   Tue, 13 Apr 2021 14:28:32 +0200
Message-Id: <cover-0.2-00000000000-20210413T122645Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.646.g06d606cb9c7
In-Reply-To: <patch-1.1-f0542cd902c-20210413T121930Z-avarab@gmail.com>
References: <patch-1.1-f0542cd902c-20210413T121930Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In reply to [1] because they're related post-GETTEXT_POISON cleanup,
but both apply on top of master.

I had a flaky t4013 test with some local WIP code that I hadn't
investigated, as it turns out re-running the test was hiding the
failure. 2/2 fixes that, 1/2 is a minor post-GETTEXT_POISON cleanup.

1. https://lore.kernel.org/git/patch-1.1-f0542cd902c-20210413T121930Z-avarab@gmail.com 

Ævar Arnfjörð Bjarmason (2):
  diff tests: remove redundant case statement
  diff tests: rewrite flakyness-causing test "aid"

 t/t4013-diff-various.sh | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

-- 
2.31.1.646.g06d606cb9c7

