Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584FAC433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 11:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08DDF64D7F
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 11:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbhBALSM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 06:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhBALSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 06:18:09 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF8FC061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 03:17:29 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id sa23so7440313ejb.0
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 03:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zKF0qGCET28jlz7cY0aYb0keDDSBAeJs1FNPLGki8/I=;
        b=HxZNkS78onF0bdCqF6mWpGReAM3U+6+Jf3Q9GcVqvQcPlzlEv4e5sI4bBeIekgi1uP
         DsDwe8MhsZ5E0rS+umH9g27eep8U38FGsgRMBJa6/vq66W6H2srSJ8ghjew8YhTKhiph
         V+K73PLCytNeBQEtFEU6mP4wNUWk1g6cY8A7Gg1e6goBL0DB3CNpuHMVJxWXyx3kVsEk
         qZBCZiRkvdkrk+jvo9aXZtD9YvKrxLzl64UEopD1Ue+iC1xTCFdTYKcvTNAbl6HIJqKb
         jKlLTGeGUE6Tduxc1mKPGHVuj7mqADpotRJd3O9tnOSNAABGc1KX3oY5Mdpbt49iOCiG
         uGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zKF0qGCET28jlz7cY0aYb0keDDSBAeJs1FNPLGki8/I=;
        b=eM0H0AlPzm3XefaGyhDoe2sZtusg3SPNZNWFUw8YHUtY5J8xds0+yOezEbNIH1Az53
         C8JxH2NzJFT01oWs3hBkaCU9Hk61N2/tmEROY4IS3CQVnvWOSHAJg+RVl6tX3hJ1Zptq
         11Fda2MAMVnq/VjvlvF9Xyh1IgaNzb4fXdyMY8o9sRlAzoOmn8G9Un8fST5j0sNhqYnA
         Tp9S0eRA2uJZ9wswXhvNgl/7IK9C18ZSyfan9LlurTlWvr/mF62mNW45rwe+OysPv+hi
         SVUX4RSRZv3d5pv5hUmtI5/6YSXQsXgr2xhirBXM4FKb7Urt86pspjf9k5aYXGHb9vnB
         GkIA==
X-Gm-Message-State: AOAM5333XHk0SPF89HwR1LN70NlWnbk3Ulfpcr4EawhOR5mwKfAzMR+z
        9lZs3xyNXBaKkYd11ItQbFkWlvErPSk=
X-Google-Smtp-Source: ABdhPJxPPPkubJrf1DDYwDq+PCqhAgT8VGYbfYqmR0QM/J8+qv0c8xtGaGMhLhbIQ9kBf0gWSpiErA==
X-Received: by 2002:a17:907:2d87:: with SMTP id gt7mr1849477ejc.123.1612178247619;
        Mon, 01 Feb 2021 03:17:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t19sm7760548ejc.62.2021.02.01.03.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 03:17:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/6] Makefile: add {program,xdiff,test,git}-objs & objects targets
Date:   Mon,  1 Feb 2021 12:17:09 +0100
Message-Id: <20210201111715.10200-1-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210128182310.26787-1-avarab@gmail.com>
References: <20210128182310.26787-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-send of v1
(https://lore.kernel.org/git/20210128182310.26787-1-avarab@gmail.com)
+ a trivial whitespace fix in 2/6.

Due to recent vger.kernel.org difficulties 4-6 never made it on-list.

Ævar Arnfjörð Bjarmason (6):
  Makefile: remove "all" on "$(FUZZ_OBJS)"
  Makefile: guard against TEST_OBJS in the environment
  Makefile: split up long OBJECTS line
  Makefile: sort OBJECTS assignment for subsequent change
  Makefile: split OBJECTS into OBJECTS and GIT_OBJS
  Makefile: add {program,xdiff,test,git}-objs & objects targets

 Makefile | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7

