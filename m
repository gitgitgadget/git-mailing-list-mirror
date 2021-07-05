Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1F6C07E95
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 01:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C45D613B6
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 01:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhGEB7S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 21:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhGEB7S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 21:59:18 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4490AC061574
        for <git@vger.kernel.org>; Sun,  4 Jul 2021 18:56:41 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id cs1-20020a17090af501b0290170856e1a8aso13875801pjb.3
        for <git@vger.kernel.org>; Sun, 04 Jul 2021 18:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ya+s7bPIbwHvZu70PyMJ23B2Enj9SKxZ4nsRk8IHLU=;
        b=vRg2I+34nSiq1K3UDN7DKxw63tCCyma0kaNv0e9bUYiZzWBWxDaqtLrRK1GmFR7xXn
         CER12YwT8C59dvQtWq6x3bYld3wVT4KXfELJmZyjZlFRMzY49ebF2t4ifx7HgJFtAnX+
         KXfSo8z0gJNssNtQop4JDzbpTgvr1NJkwVymb3leULBxAnOL+7aoswkOL+jJcnlDKsMA
         kjE6mzP1+uimx15jA95YgyridQkFRVd0Q5mfMjwKlOvSL/bqfUViB97Ss2v8++xc2oaM
         Z2V6s7ZZF5zwlnajMIKiefOpiADhag1xa5iCK45t5piEDn9OcD9wTyztovf8flCVTXst
         P8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ya+s7bPIbwHvZu70PyMJ23B2Enj9SKxZ4nsRk8IHLU=;
        b=GZNTRbnyExHIgdoKJ47c+d/zzDKS0MzR0dQcFyCD+zYJxW5wu63uCSTkM953itz5/0
         7gvKE9CNDWDRsbRew5KSYdbSTXdZJJnAEsYaQSwl8c0yBqgIcUfsgysJhSfI0Ly5iH6P
         DJgu2kILSq5u1AOcuKSX8N7UIE/LYPZMFaPqf1s/x6fMCn6PwHwNJ2VqzmLtU18VDnSl
         6dg4Mm7KiGo+1pR1ec8m/hlCrpju/UNTo5cLMCcM9w7hyImwCzodN7bfRyIaHuSbwOMU
         6CxWmRidvZ2uSesTXtPyIf8/cKHXs2IzjvNLdqf4ffBRbLVixToT9YVilmY9z2s/k2sB
         HcUw==
X-Gm-Message-State: AOAM532qJOXNlnveyjiPiyILR1hPTdxxP/x6MT0JpyoZJy0yMj5Mip8R
        SfJyASU7FFQgeZrK+I1XYy4=
X-Google-Smtp-Source: ABdhPJyBS3AlpjJy3eIg/gsuvO1HN8DnoMc8HFbz3Kwi2/6dZDCMo+GMoUNuQBlsycaFEF92ojOPfg==
X-Received: by 2002:a17:90a:ca8c:: with SMTP id y12mr12781891pjt.2.1625450200706;
        Sun, 04 Jul 2021 18:56:40 -0700 (PDT)
Received: from ubuntu.mate (subs02-180-214-232-71.three.co.id. [180.214.232.71])
        by smtp.gmail.com with ESMTPSA id d20sm10516021pfn.219.2021.07.04.18.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 18:56:40 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     worldhello.net@gmail.com
Cc:     DJm00n@mail.ru, alessandro.menti@alessandromenti.it,
        arek_koz@o2.pl, ash@kambanaria.org, bagasdotme@gmail.com,
        bitigchi@me.com, christopher.diaz.riv@gmail.com,
        elongbug@gmail.com, git@vger.kernel.org, hello@brighterdan.com,
        jmas@softcatala.org, jn.avila@free.fr, matthias.ruester@gmail.com,
        pan93412@gmail.com, peter@softwolves.pp.se, rybak.a.v@gmail.com,
        vnwildman@gmail.com, vyruss@hellug.gr
Subject: [PATCH] [l10n] po/id.po: fix mismatched variable names
Date:   Mon,  5 Jul 2021 08:55:31 +0700
Message-Id: <20210705015530.18033-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210703111837.14894-1-worldhello.net@gmail.com>
References: <20210703111837.14894-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin notified me [1] to fix some typos. Running git-po-helper [2]
check, it found following:

  1. git submodule--helper typo (was git submodule==helper)
  2. new_index improper translation (DO NOT translate instead)

Fix them.

This patch is also available as PR at [3]. It can also be squashed into
[1].

[1]:
https://lore.kernel.org/git/20210703111837.14894-1-worldhello.net@gmail.com/
[2]:
https://github.com/git-l10n/git-po-helper/commit/e44df847abb91227771560aca56719031f280068
[3]: https://github.com/git-l10n/git-po/pull/535

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 po/id.po | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/po/id.po b/po/id.po
index 50e2e1dc3c..2fb14c068d 100644
--- a/po/id.po
+++ b/po/id.po
@@ -12822,7 +12822,7 @@ msgstr "gagal memperbarui tembolok pohon utama"
 
 #: builtin/commit.c:437 builtin/commit.c:460 builtin/commit.c:508
 msgid "unable to write new_index file"
-msgstr "tidak dapat menulis berkas indeks baru"
+msgstr "tidak dapat menulis berkas new_index"
 
 #: builtin/commit.c:489
 msgid "cannot do a partial commit during a merge."
@@ -13330,7 +13330,7 @@ msgid ""
 "not exceeded, and then \"git restore --staged :/\" to recover."
 msgstr ""
 "repositori sudah diperbarui, tetapi tidak dapat menulis\n"
-"berkas indeks baru. Periksa bahwa disk tidak penuh dan kuota\n"
+"berkas new_index. Periksa bahwa disk tidak penuh dan kuota\n"
 "tidak terlampaui, lalu \"git restore --staged :/\" untuk pulihkan."
 
 #: builtin/config.c:11
@@ -21717,7 +21717,7 @@ msgstr "git submodule status [--quiet] [--cached] [--recursive] [<jalur>...]"
 
 #: builtin/submodule--helper.c:918
 msgid "git submodule--helper name <path>"
-msgstr "git submodule==helper name <jalur>"
+msgstr "git submodule--helper name <jalur>"
 
 #: builtin/submodule--helper.c:990
 #, c-format

base-commit: 9146ef75dd34f27ab3c70b041af9506357c940df
-- 
2.25.1

