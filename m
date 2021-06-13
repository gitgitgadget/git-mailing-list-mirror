Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5F7C48BCF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 06:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48EE9611CC
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 06:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhFMGjH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 02:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhFMGjG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 02:39:06 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6ABC061574
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 23:37:05 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id q20-20020a4a6c140000b029024915d1bd7cso1853030ooc.12
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 23:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WX5eeXgJ67QYJP5QPs/rKUFm8b+XFCmJ1VS3NeOPSUQ=;
        b=EUgmYF+vTMOeWn2fTk15EJH+meOw/1V0OY4pSNPzSKCLBhY3RM50pMUCzZ5bFByLuy
         tFYJ7+V+Y0TO9cbgJXL3inVydkUIPZkQqMy+pWJIM5JERQthpP+8nT+iwPQClOrWI8jw
         YuYS+NB6B1Wko5czBAyDhiy4CJVXORoygH4Wsb7x+YhLLvFmh4gMEJyv39o5C2L+Zk04
         JcDmG4YtXC/oj9OcDvjVLoHXcwbNQB7YE5eQEvg2GodRxt8+EX0WTgAq9uuvygWQm2Ty
         E+iZAjt6kkVqni0jdlqCrj3rmMsxJlry+YPWf2UF0zBtaWW4benTnNi/zeZVgpkV5Hv+
         A30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WX5eeXgJ67QYJP5QPs/rKUFm8b+XFCmJ1VS3NeOPSUQ=;
        b=gPSy81yoSSeDW6WeX8l5oPN6QrjXtD4AeKpPGozUJbOgHgzVvKKZTgQtvw+Io+ga7k
         9yjszV6cf10WU4hDwOJefRQIxAl6G1i9y/9yfsiLeTyhail5OyaCM7bGJpkqzgXot81N
         mRqtHpBeTttOg74S6o6ej6p7ejnsi8PuZb5dAmwLzEjj2xmqeF8rddIRBylM3ppHhExB
         EjB+QFIajXjHW06IBW/CPJLDRNzYHQxGkZipWjhy4xW/+HfqtUmVykvY/oh+tMSqjErN
         EVaJ7w5ofZn1IrNnBDx6vt7RW+/eVhrxiqKAKhGI8T278snXQ0U37L7BfdR/2ZPtZsua
         AMCg==
X-Gm-Message-State: AOAM533P+GpGCRRtR42WPfjSHV5Nugd4Bl5e1odRcM4zL92asL7C60R/
        1rvCKGJVdOJuyJveaGeG+/sPBFN7bAKnqQ==
X-Google-Smtp-Source: ABdhPJyaeQfE9zr8PFGh2XXC3SKjFrH2PUL6Cxr4p1hfH2ureX4nxaV1f2uxtq53kqkaK98ct/SD9Q==
X-Received: by 2002:a4a:1401:: with SMTP id 1mr9071200ood.50.1623566224783;
        Sat, 12 Jun 2021 23:37:04 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id v42sm233631ott.70.2021.06.12.23.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 23:37:04 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] Trivial cleanups
Date:   Sun, 13 Jun 2021 01:37:00 -0500
Message-Id: <20210613063702.269816-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These perfeclty good patches from 2014 weren't picked with no good
reason.

[1] https://lore.kernel.org/git/1398808178-3703-1-git-send-email-felipe.contreras@gmail.com/

Felipe Contreras (2):
  config: avoid yoda conditions
  add: avoid yoda condition

 builtin/add.c | 2 +-
 config.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.32.0

