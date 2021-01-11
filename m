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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022D2C4332E
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 13:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8D54221EC
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 13:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732694AbhAKNbd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 08:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731882AbhAKNPk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 08:15:40 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EC8C061794
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 05:14:59 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id y23so15046448wmi.1
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 05:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PUE7Sa/Nkd6GWBTus6wW8Jgp4lc1cYifmY22Rr1kLsU=;
        b=GIixta/cH6YTvTjETgx/HpIkEH91eWZTK8UKxO23hHpOoffTnPMPvFW/mc0+aCY70F
         TkqXGK2Rs8DosbVfDkwSc++tAl3I30H8HqgWgYW717NSyw5TGcxjWOQYFGOGB5YIGmOi
         wikE2BIgE2BaSfBitMBoYYBxgXZQM8po1PaJZfLgdbj6G9/+hhCcThGa/LK1mOdYaudh
         dBiy8m3oVtfHj/J/CfcjAQmO92GCfy3XwcYT/xu0rPeF3mns48wIlBX7M1CRaoMzrydn
         f07hroNDTks/w/5NF8W0U+5NHZ6e/lcpXUu7p00vhqA2WtWcNcknjmpIAHGlIQN6/um3
         knGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PUE7Sa/Nkd6GWBTus6wW8Jgp4lc1cYifmY22Rr1kLsU=;
        b=OZQ+KZFS/1ZZSMuqmRtqEBYAh7HBSLM+gCjyKUrPm8I1sFf3oSAlUlV52XY2O7UQzG
         GkhB/VcXoWryY/rwBfcg/ihvMvnE3X+k5etfLuAULSUgJKuFBMqXV+gfQl1fKhNF0XeV
         N2piUcKEeyWv2TrtGyzgqk3lhxy+yAR6eRYakwxhGAuDYEv7rbGOAWasWPTnvkooJuzo
         jFvmTnrlFsxg4DfPcZecVLcYn3gMKOg8MH0pT/YdWYyRE0t3yQvJzOAImr9rcq4QI7Jg
         tabftYbgVmfZNgi5y+WnP+pe1mo6H/qrgDAVjDIfX0xvXv8zcYKl8MsnDQXuRqnXgr59
         EtLA==
X-Gm-Message-State: AOAM5317G1YHNXMf325EOCsILHr04XJVDjSXJKGNC7DSO/X2ISjHHVvK
        Rw6Snxd+hVJF6HF7ISUP1LKGrEYGSap2bA==
X-Google-Smtp-Source: ABdhPJxsHdyOJUHfNJbP44Lh6dBQitfMyf0TXAeH7e3D3FtjIqAu6KgwmgfCjb/gAJcPV2VjjL5fLw==
X-Received: by 2002:a7b:cd91:: with SMTP id y17mr14645856wmj.5.1610370897685;
        Mon, 11 Jan 2021 05:14:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q73sm22924450wme.44.2021.01.11.05.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 05:14:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] Makefile: remove a warning about old GETTEXT_POISON flag
Date:   Mon, 11 Jan 2021 14:14:50 +0100
Message-Id: <20210111131451.7084-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <87pn2b6eyb.fsf@evledraar.gmail.com>
References: <87pn2b6eyb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a migratory warning I added in 6cdccfce1e0 (i18n: make
GETTEXT_POISON a runtime option, 2018-11-08) to give anyone using that
option in their builds a heads-up about the change from compile-time
to runtime introduced in that commit.

It's been more than 2 years since then, anyone who ran into this is
likely to have made a change as a result, so removing this is long
overdue.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Makefile b/Makefile
index 7b64106930a..5a9a8a00a06 100644
--- a/Makefile
+++ b/Makefile
@@ -1554,9 +1554,6 @@ endif
 ifdef NO_SYMLINK_HEAD
 	BASIC_CFLAGS += -DNO_SYMLINK_HEAD
 endif
-ifdef GETTEXT_POISON
-$(warning The GETTEXT_POISON option has been removed in favor of runtime GIT_TEST_GETTEXT_POISON. See t/README!)
-endif
 ifdef NO_GETTEXT
 	BASIC_CFLAGS += -DNO_GETTEXT
 	USE_GETTEXT_SCHEME ?= fallthrough
-- 
2.29.2.222.g5d2a92d10f8

