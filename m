Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AA6C83011
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 00:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 017DE20857
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 00:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnzI4yfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389154AbgLAAri (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 19:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389150AbgLAAri (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 19:47:38 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5E1C0613CF
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 16:46:52 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id o25so16375368oie.5
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 16:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z/qgwAv+Q8B8ahtjY0Y2RJHAIrr6r2RUXRWxyS4ZwhU=;
        b=rnzI4yfD4P5ICbU3LXfD6bMDTkHDiJ3tQ1e+zTUPBNrRXdM5m2JqFcc3z8CVANWu6t
         jrrzxU68wQw0cO9pp4DyyOjPy/kUaN4vHPnmQl9FenTPAIoQb4hn7QSn6FuyzwX+Ll98
         mfpOFFl5moNG0FtRRSUJERm34SSGRD6FyVCA9AnYxUgE1uSNXW/NZObPCfHZrHGEp0GW
         H36Rg7o2kB7XBiHnmbaO8Wby6uBC8sbir+zhFUHMLG3/yCahIYoPJmJGuilloSWiijaF
         wrv0hDgV2jUKYSJKOb+7YnWjGjB2rR7UxRPqQHWfG+ctLB3XIS7Pmk6Q+w/eK0p3cFpG
         PXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z/qgwAv+Q8B8ahtjY0Y2RJHAIrr6r2RUXRWxyS4ZwhU=;
        b=qOlSVPkdrNprdU1uVnWBDVkwnh5h7wTyvRpUGHRVOYeM31oeRRKAJ8sPPiuK7w/adE
         Ft7Eud43ssYmEoU/TfceCdPWbA64rWaNTfulkzB/M2PTXva5i/RpAzGlwYS225R3M0oi
         csBss4dqLXkiCN3nSunPmq/wL7+pNpGj9hbogGhFDyHrFZbNTatKClKssaiQcQj31O6o
         PFdmSlUUkv6KkoFoVHAWxJxA53JGXOLVIDpG2/NUSLUGKW1ba5vEics3H2CBU3MllFjy
         W7Eoghu+F5LOO7MstnZlhDVOPCAt+wqT3FYmbLHQxgOAISpxStEo7nV4n+mH6xvgIhUn
         KnpA==
X-Gm-Message-State: AOAM532x6y5l3pk22JYT9QBRrpyYB8FR1kuHz64LUFS4f90dAPFkutGD
        5ST9tG7RlexW0E86AMhIfKGwDMm5Y7pjgg==
X-Google-Smtp-Source: ABdhPJzaeV55fYaaZmmjfN9eU03oL5fPy8ecIHbqUnafmMADvAJ57/dLHHHJI/n/QPcsKXGBtEP+dQ==
X-Received: by 2002:a05:6808:10f:: with SMTP id b15mr195885oie.88.1606783611471;
        Mon, 30 Nov 2020 16:46:51 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id z10sm54584oom.3.2020.11.30.16.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 16:46:50 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/4] Random cleanups
Date:   Mon, 30 Nov 2020 18:46:45 -0600
Message-Id: <20201201004649.57548-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just some low-hanging fruit I found.


Felipe Contreras (4):
  refspec: trivial cleanup
  .gitignore: remove dangling file
  test: completion: fix typos
  tests: lib-functions: trivial style cleanups

 .gitignore              |  1 -
 refspec.c               | 19 ++++++++++---------
 t/t9902-completion.sh   |  4 ++--
 t/test-lib-functions.sh |  8 ++++----
 4 files changed, 16 insertions(+), 16 deletions(-)

-- 
2.29.2

