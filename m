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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AC1C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B52CF6127A
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbhE1JZg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 05:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235672AbhE1JZd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 05:25:33 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC2EC06174A
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:23:57 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l18-20020a1c79120000b0290181c444b2d0so1977502wme.5
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jYXqFWJmbITdUifHX7psazBPf1OOFD6Z85t7c+XZhlo=;
        b=hYqdAPGByfRKmxhRUJPWIDl7T5J38M4HtpgnoI6etflPT3ZYvK/mybQb78VR5BYc9D
         C9lMRWM36PToawEVXraERyTnf9DUyNyVmoMHKHp6svb8gpPY12mGl+AX8HMnethJOIGn
         nHOexafMWsrpGm2wbN+L1h2h3oppCLQK7fO/VGpfHpRqkLfwhIPUn3EtwaJyLc8zJSiS
         eOpl98kprqycvFu0BiB4ltYgwzE6izirUSotZgpVoqcOqjtiKeZ0XseHdqyWxzWdeWUZ
         7ZlbNxkpxPjm+25fxNoLvQ9MEElcs7ohflO4CZX7ZCPu+90iJs/Y9Xnl9989+GSMHXdK
         qEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jYXqFWJmbITdUifHX7psazBPf1OOFD6Z85t7c+XZhlo=;
        b=KO7KqOou8qbOvz0ukwyA9kPli/sJDZzzgxnx5NetJF3VaMACoPdcsU3NQXi8x+5fCT
         dM+m35JhUcJ2ADZa6qOAHToSa0JoGwWUBuCbI5+YXCCdg7oGgRu7fWMWQLTCFRI+hMQ7
         yieSK2rsizE/PsTdxvsHdUT/LYtmtpFYyrxfktWuNM5YFWC8qYbQ+YuXYqdZ3QLn91Qx
         p4V2o3ew4RUVvkaR5w8uKol0Sq/zxW+tTh0EW5dFH3JaaeL83np6osM7yG6cHUofVrIJ
         lP5EYyZN0iXZm+cIPns6JaWA5sIMy1XD0x96gdlqk9vAdZAWKqmwIMzsC7j1aELuoyo2
         bkzQ==
X-Gm-Message-State: AOAM530MF7i77c3UAqNlTf5DUWkfrt3huWrWkwNPHu0bldFaIeaHSV6V
        2JB157cbq9fi1/FX1/2D7fL1mqDAfX1zoA==
X-Google-Smtp-Source: ABdhPJxbG8AlZbBNo8cIOYu4x+60SPFq3k2zxiglSV7+rLV2jHus+TQVJBv8uEj4iLZo3tlL4D9dYQ==
X-Received: by 2002:a1c:61c3:: with SMTP id v186mr839091wmb.101.1622193835572;
        Fri, 28 May 2021 02:23:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18sm5842009wmj.15.2021.05.28.02.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:23:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 01/13] send-email tests: support GIT_TEST_PERL_FATAL_WARNINGS=true
Date:   Fri, 28 May 2021 11:23:40 +0200
Message-Id: <patch-01.13-81025b48f1c-20210528T092228Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.458.gd885d4f985c
In-Reply-To: <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com> <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support for the "GIT_TEST_PERL_FATAL_WARNINGS=true" test mode to
"send-email". This was added to e.g. git-svn in 5338ed2b26 (perl:
check for perl warnings while running tests, 2020-10-21), but not
"send-email". Let's rectify that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 25be2ebd2af..1630e87cd4d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -18,7 +18,7 @@
 
 use 5.008;
 use strict;
-use warnings;
+use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 use POSIX qw/strftime/;
 use Term::ReadLine;
 use Getopt::Long;
-- 
2.32.0.rc1.458.gd885d4f985c

