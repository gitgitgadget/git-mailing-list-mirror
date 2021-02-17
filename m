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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7754FC43381
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4101E64E7A
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbhBQT5T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbhBQT5N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:57:13 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5023C0613D6
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:56:32 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id q14so17900905ljp.4
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EpTYtN9SKOvZ+TYchholWqqGoP1n86sFOd1I6adJoKo=;
        b=fEZGEbxXbe7mNzuupcMtCWXPwWtE6iZZNMuOAaZS1WBtdQM660SkAGbdAKxetrhHzf
         lVJHFa6fMPxFtQN7D0X5nRQeZLo/0pjuJY5RuFMu1MFcpXorUrah1f9VXT6hX3d9twAL
         eekXaXyNmvQyCfiHkTMa5Z9BUVMwoovCSsEwO3NAKyHeyMe6dZ0P/1Bx38+oVmfsx1v6
         oHvSoE5RlJLwpfz8b/RiOH64QdWI2hGca+uPinVQR7ZgnSXkq3hM2HFbuub6ER/6ns/d
         Ld018jLF0On/kb+nEMr+wuiFehTaZy5G1nqJEeGwznaK/OjFugzu3ExPi8iWBFnl6uNG
         EQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EpTYtN9SKOvZ+TYchholWqqGoP1n86sFOd1I6adJoKo=;
        b=hnjlAU91BMHYYsEXf+I9UvZwo9Q4Vhi8J00wlK0i98tiifeOTcPljCCHuU10itO3XR
         iEHpvWwZUByjpKSYDIDZbb+matDhBB2YB5S/pZhu9+wPw297C77Z6EvRZUhg25zHAT5O
         bnh3Tl3dSX0MVU/o45Z0Fdy/YQ3LFrdpGlevo187wXplNo6ZKBblfL8085sriIVmEn0t
         0Wdi7XhytZK+w4rRAP5gJIPjm8OS/PcIw2V4BEjAiTdtSI9UiRclAhESDYoz2l2S5h85
         GULvHzM24MfiEtNRvNq14ErRw8lAUP39wKit9pwe8TwYzYaBiBJnTfWyCOm0lp88hVq9
         a1lQ==
X-Gm-Message-State: AOAM533wspOTuhx2VOwnQXcq08L5F75oBHXxzI2UyELyynd8fQy1JVoM
        89AmTJYsjsJrzdbTHJwg0K7rKoVfM1Q=
X-Google-Smtp-Source: ABdhPJztufGeUR1l7oAynX/0KJwhP9mL3ocHlV0C1Xsjz5umrIVmBtE0GIYoyOmwDh/wHFcRPw/wTA==
X-Received: by 2002:a05:651c:1ad:: with SMTP id c13mr481447ljn.287.1613591790836;
        Wed, 17 Feb 2021 11:56:30 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id o19sm347495lfu.182.2021.02.17.11.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:56:30 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Sergey Organov <sorganov@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] git.txt: fix monospace rendering
Date:   Wed, 17 Feb 2021 20:56:05 +0100
Message-Id: <97c686dd7ba1bbd1c0be6f7f61a3a033adf8adb6.1613590761.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5ea
In-Reply-To: <cover.1613590761.git.martin.agren@gmail.com>
References: <cover.1613590761.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we write `<name>`s with the "s" tucked on to the closing backtick,
we end up rendering the backticks literally. Rephrase this sentence
slightly to render this as monospace.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 doc-diff:
 --- a/.../man/man1/git.1
 +++ b/.../man/man1/git.1
 @@ -77,8 +77,8 @@ OPTIONS
             setting the value to an empty string, instead the environment
             variable itself must be set to the empty string. It is an error if
             the <envvar> does not exist in the environment.  <envvar> may not
 -           contain an equals sign to avoid ambiguity with `<name>`s which
 -           contain one.
 +           contain an equals sign to avoid ambiguity with <name> containing
 +           one.
 
             This is useful for cases where you want to pass transitory
             configuration options to git, but are doing so on OS’s where other
 Documentation/git.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index d36e6fd482..3a9c44987f 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -88,7 +88,7 @@ foo.bar= ...`) sets `foo.bar` to the empty string which `git config
 	empty string, instead the environment variable itself must be
 	set to the empty string.  It is an error if the `<envvar>` does not exist
 	in the environment. `<envvar>` may not contain an equals sign
-	to avoid ambiguity with `<name>`s which contain one.
+	to avoid ambiguity with `<name>` containing one.
 +
 This is useful for cases where you want to pass transitory
 configuration options to git, but are doing so on OS's where
-- 
2.30.0.284.gd98b1dd5ea

