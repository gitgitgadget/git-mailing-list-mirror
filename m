Return-Path: <SRS0=BObu=DK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C032BC41604
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 22:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63B11206C9
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 22:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edgjyVbQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgJCWTd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Oct 2020 18:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgJCWTc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Oct 2020 18:19:32 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9419FC0613D0
        for <git@vger.kernel.org>; Sat,  3 Oct 2020 15:19:32 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k10so5594207wru.6
        for <git@vger.kernel.org>; Sat, 03 Oct 2020 15:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=PeGeeebN60ERfgjd0qsYOgxxP3d9ciQgXop3nas1sIk=;
        b=edgjyVbQLtwebBHubjjlaafMdPdPD4ZqtaV+wXy0olc/EZq5Tn+MA+Dtjhac+Weyto
         IyhCmEL1N6QpBMCk6c2TAVyOvX3yBlmKgvZDPXf8YhbXqTlYJIPEhgj3vAVZmo+w68RC
         j1vqFifN1rfp1qiUNiRjKB0YYYg1tkwEkTJfwc0NwiwB7pHPYcG2uQNkj1xumlOZMQtF
         VSmxZJWP7x/Fnk9K8ujhwg/XqLBSh+WgK1VczlrU/4vDWOnoTWMG5CDF9moclnz4Ofej
         3xJwoKjoLX0EXiSQF/SfVdWxay33wjgrgPK7eXIiHviqbhc98Xyu3l+jY7ut5o0xusb3
         sKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PeGeeebN60ERfgjd0qsYOgxxP3d9ciQgXop3nas1sIk=;
        b=mxFeF+RpNi/AuP52CHUuK9OORbnrNewT8Sqtr13ee2eai9DrwhVCRh5Kt5iTSlrHTz
         jDA2d2gzQmz2iwwCG8I/8koO2ct2k3c9VWKFMdb+h6KC68a8V9bpGIiTiZzp3wr7ZHNL
         D9J6Eo5iEiHdlMjxTf9M2KG04JVWQJnEi8GNGIwFmW8qhqck4CmtpZozsAchjlcU7uMk
         Kk9k22fPqsanK2pRGWo5EgCrWLXWV8oLkJYZaDCnK8aXIGNKWiAfu5GLtGn47A2dLF8I
         pvVylCnUZMXaWG3bNe/arv8BW8xvkS/aSHvIpDnwTyPbH+WbrKUO1g1jEpl1V3BbhkLE
         SvUA==
X-Gm-Message-State: AOAM531jb0GmnsJdqMxFAEYLmzkKKynugPjlOOu8W7A4HeE4/XM3K2uX
        PedmqECz1l7MerFnrYi1fDRqmXYEFI8=
X-Google-Smtp-Source: ABdhPJwAmsfjfUsww91S1Enlxuz0GgX2/Ea4RROW53C468reTF3X/WyVsgdjtCAl6AB75Eg/Q7Y5cQ==
X-Received: by 2002:adf:f207:: with SMTP id p7mr10570345wro.152.1601763569798;
        Sat, 03 Oct 2020 15:19:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z11sm3038563wrh.70.2020.10.03.15.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 15:19:29 -0700 (PDT)
Message-Id: <pull.742.git.1601763568860.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 03 Oct 2020 22:19:28 +0000
Subject: [PATCH] po: adjust for the recent change in
 send-pack/transport-helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As of 4d04658d8b5 (send-pack/transport-helper: avoid mentioning a
particular branch, 2020-06-24), the message does not mention any branch
name anymore.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    po: adjust for the recent change in send-pack/transport-helper
    
    I hope that I am being helpful here... Please let me know if I should
    just leave the translations alone instead.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-742%2Fdscho%2Fadjust-send-pack-translation-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-742/dscho/adjust-send-pack-translation-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/742

 po/bg.po | 4 ++--
 po/ca.po | 4 ++--
 po/el.po | 2 +-
 po/ru.po | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/po/bg.po b/po/bg.po
index a189b16dc4..aa463b5c24 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -8790,10 +8790,10 @@ msgstr "грешка при изпълнението на командата з
 #, c-format
 msgid ""
 "No refs in common and none specified; doing nothing.\n"
-"Perhaps you should specify a branch such as 'master'.\n"
+"Perhaps you should specify a branch.\n"
 msgstr ""
 "Няма общи указатели, не са указани никакви указатели — нищо няма да бъде\n"
-"направено.  Пробвайте да укажете клон, напр. “master“.\n"
+"направено.  Пробвайте да укажете клон.\n"
 
 #: transport-helper.c:1121
 #, c-format
diff --git a/po/ca.po b/po/ca.po
index c43c21bc22..750e558343 100644
--- a/po/ca.po
+++ b/po/ca.po
@@ -8593,10 +8593,10 @@ msgstr "error en executar l'exportació ràpida"
 #, fuzzy, c-format
 msgid ""
 "No refs in common and none specified; doing nothing.\n"
-"Perhaps you should specify a branch such as 'master'.\n"
+"Perhaps you should specify a branch.\n"
 msgstr ""
 "No hi ha referències en comú i no n'hi ha cap especificat. Potser hauríeu "
-"d'especificar una branca com ara «master»."
+"d'especificar una branca."
 
 #: transport-helper.c:1121
 #, fuzzy, c-format
diff --git a/po/el.po b/po/el.po
index 703f46d0c7..1e20ebc5a6 100644
--- a/po/el.po
+++ b/po/el.po
@@ -6599,7 +6599,7 @@ msgstr ""
 #, c-format
 msgid ""
 "No refs in common and none specified; doing nothing.\n"
-"Perhaps you should specify a branch such as 'master'.\n"
+"Perhaps you should specify a branch.\n"
 msgstr ""
 
 #: transport-helper.c:1083
diff --git a/po/ru.po b/po/ru.po
index a77b462e62..6363c270b5 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -6948,7 +6948,7 @@ msgstr ""
 #, c-format
 msgid ""
 "No refs in common and none specified; doing nothing.\n"
-"Perhaps you should specify a branch such as 'master'.\n"
+"Perhaps you should specify a branch.\n"
 msgstr ""
 
 #: transport-helper.c:1085

base-commit: 306ee63a703ad67c54ba1209dc11dd9ea500dc1f
-- 
gitgitgadget
