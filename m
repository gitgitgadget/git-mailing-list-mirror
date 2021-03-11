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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78432C433E9
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 12:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40C6264FE5
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 12:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhCKM4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 07:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbhCKM4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 07:56:24 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ED7C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 04:56:24 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so1647942pjb.0
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 04:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8N+8nZMF2soe49MeGxn+dSEYpeQRZwONIpRJcK/L/vo=;
        b=mVsnRFcALh2Vx62eh3/Jp5vW8u+d63ew7psFA7ekb275vcHKEMCWnKka6Z006CojbI
         6Bo4oQ/MlCFlXj1hoWWGkjM5QulwlLGHwIdsKwhattjKlCoOOOaYUmvHM/Xb4Rv7Mubt
         ziP+W5edMCCivWGzuZq4OCeRXHjtnh5xnjt5ZU9BPiVgjXo3RlBUMey29gG9LXKGWwyy
         APjlaNbwyz/DoZQuZQHUrZ4iTuuubiML2qKrbV5g21O5U/nyFqic6LFxBCmhvfLTUQ1s
         5UHrHjrc1DH7mBKwBeVd/zj4LioVZodr0EUEuqqbpASCooXbbESPnHn1YHCg0Ws0qpER
         YEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8N+8nZMF2soe49MeGxn+dSEYpeQRZwONIpRJcK/L/vo=;
        b=LiMd33v5E9WoqI7PA+Kj1KWS5OB7p9DfXdLt12p6p5pTrhxW/rqbEv83L34tkGntxe
         TUWG5vEoA7prAFwPYJ9kW/8rlXD9XQOUx27a29tABJVVplakqWkr4rMp1n8qgMlU0yiO
         uUICqJx5EaHgx5sBpj6JaDSVAU6O9YiLmnjA27+NPV7f+UqEU5LgDpZ2jyBpcq5SKPIz
         RBo4PKMybCXhh042NjpgZcFLv98432TvZ3hqGW+JFlDoJLUglqZ2XQQk2R946A9TXssr
         1mUiG/9g3kq7TLnfjRaaG7iyi2PHdH/E/BC54RA0tYOspyUbGnHzCZpMbenb8+LUd6OZ
         hvWA==
X-Gm-Message-State: AOAM533N+NBy5Bkjfkn+E9SrX/ABAQRiU1iTCv8IbvKa7qUABdLyXdB0
        xAsQ9U6k07DmNEQtgiO4gxzgoObuDj04Tg==
X-Google-Smtp-Source: ABdhPJxkYumjBqsWVTF6sHBTFhI6ewrT5a5uRLRZuSTQx95EDDwE5loZjGskSENTXk4OBCXT/TZayg==
X-Received: by 2002:a17:90b:1987:: with SMTP id mv7mr8524108pjb.152.1615467383955;
        Thu, 11 Mar 2021 04:56:23 -0800 (PST)
Received: from ubuntu.mate (subs03-180-214-233-84.three.co.id. [180.214.233.84])
        by smtp.gmail.com with ESMTPSA id o1sm2389418pjp.4.2021.03.11.04.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 04:56:23 -0800 (PST)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     worldhello.net@gmail.com, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 2/3] po/README: document "core translation"
Date:   Thu, 11 Mar 2021 19:55:10 +0700
Message-Id: <20210311125511.51152-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311125511.51152-1-bagasdotme@gmail.com>
References: <20210311125511.51152-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We now expect new language translations to have core subset of 5000+
messages translated for these to be merged. If it hasn't been done yet,
do so by first generate core PO, then do translation work there, merge
it back to main PO (XX.po), and fix any "fuzzy" errors.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 po/README | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/po/README b/po/README
index 9beffc2954..eda7edf4e6 100644
--- a/po/README
+++ b/po/README
@@ -39,6 +39,42 @@ coordinate among yourselves and nominate the team leader for your
 language, so that the l10n coordinator only needs to interact with one
 person per language.
 
+Because there are now over 5000 messages that needs to be translated,
+we expect to complete translation for core subset of messages before
+a new language translation can be merged. See "Core translation"
+below.
+
+
+Core translation
+----------------
+The core translation file, core-XX.po, covers some of commonly used
+commands:
+
+  - wt-status.c
+  - builtin/clone.c
+  - builtin/checkout.c
+  - builtin/index-pack.c
+  - builtin/push.c
+  - builtin/reset.c
+
+To generate core-XX.po, install the helper script (see "PO Helper")
+and check the main PO file:
+
+    cd po/
+    po-helper.sh check id.po
+
+This will generate po/core-XX.po and corresponding po/core-XX.pot
+template. Now complete the translation in po/core-XX.po.
+
+When it is completed, merge core translation back to main PO file:
+
+    msgcat core-XX.po XX.po -s -o /tmp/XX.po
+    mv /tmp/XX.po XX.po
+    msgmerge --add-location --backup=off -U XX.po git.pot
+
+Fix any "fuzzy" errors that occurs, such as misplaced translated
+messages and duplicate messages.
+
 
 Translation Process Flow
 ------------------------
-- 
2.25.1

