Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B97C433DB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA4F60202
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhBOSnD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 13:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhBOSmX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 13:42:23 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DEAC061574
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 10:41:42 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id n10so10258609wmq.0
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 10:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AhkB74Z2iGAIRlYSEs4W2EaO/e4N04X6hzwdsO9nld4=;
        b=TiWdgszPqExdsNezuDYgKRQlBYOXRu6sJNUlp13ztFDPZI1oTm6QYxGFTwnEWqA42j
         bAGFn5ePQjljBoRihWqaJKtSVcj3P+G3GxvZIcrNtYoI/9s3zS+L2HahfEBRRCuIL/3+
         NhvvB7/XCVO8tKKLLDjMoj/to4c49txiNWSmqMpfgw50keOC6ZgfjTKqlT8IKSvb7MMn
         DncChc5yw1Y2vjSxa0XgKIn/knMhCcdZ0mY0MoV61d22uVynUZqI1yspAAY7hCiFLam5
         ZarJPJJlA9/UZaxOAHt4iarGyNP/dhqydfU2NcLk4DxFyXH7tJzGsEpJxmoYXdSKiSod
         qf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AhkB74Z2iGAIRlYSEs4W2EaO/e4N04X6hzwdsO9nld4=;
        b=QMbeh7F0bCoWEpIztviiANL2PyJYEwYIYw7TgXoIdaS+TycHYsGFFYjwSOXTRpmbXc
         m3LeJfFs3OMD1Ky8RS7qJxQrw2fNW82tegNbEIq7ZEGOkwGjioxzPi+N1EJFp4R7KWX8
         nZGIFvYrTIpB5RNUtH+7tY/Cxy5eXxwwHgU5LkFgcgTGi/fyQ4kwX75UE9Vv87d77pqg
         4xUFFwuly6hjFUzyhfPwmvPYrAjxvx18zPIPL0ytBWJb7RuiCdwVHkD2LdoeA/vuAsa5
         sMn4z9DlqkiE+TeR8Dw6lXVdsrZ88bEB558y8AB73e8UcvZ20tb6Qz2rgDNrTnjtjMWb
         Pl7g==
X-Gm-Message-State: AOAM533HS/Zzs3et5faOaFhKZqyML+OKDkIwrwFRtMYZAHDffFQ9CZmH
        XT95SRPRU4hv6WAMFxBrb3vi6lHFdhJRfg==
X-Google-Smtp-Source: ABdhPJzfe0sX2dZ2P0XRfsln9cOyiHnR9vs/IHu/UC9zpuOz5CsmccVQ1RGfWtGfOAWOQvmfvAuCdQ==
X-Received: by 2002:a1c:750e:: with SMTP id o14mr212629wmc.60.1613414500940;
        Mon, 15 Feb 2021 10:41:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v12sm11258979wrv.69.2021.02.15.10.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 10:41:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        dstolee@microsoft.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        peff@peff.net,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] commit-graph: parse_options() cleanup
Date:   Mon, 15 Feb 2021 19:41:13 +0100
Message-Id: <20210215184118.11306-1-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87r1lhb6z7.fsf@evledraar.gmail.com>
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A trivial cleanup series as a follow-up to my comments in
https://lore.kernel.org/git/87r1lhb6z7.fsf@evledraar.gmail.com/

Ævar Arnfjörð Bjarmason (5):
  commit-graph: define common usage with a macro
  commit-graph: remove redundant handling of -h
  commit-graph: use parse_options_concat()
  commit-graph: refactor dispatch loop for style
  commit-graph: show usage on "commit-graph [write|verify] garbage"

 builtin/commit-graph.c  | 102 ++++++++++++++++++++++------------------
 t/t5318-commit-graph.sh |   7 +++
 2 files changed, 62 insertions(+), 47 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7

