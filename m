Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC53AC433E9
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 10:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 839AF23A51
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 10:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbhANKkT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 05:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbhANKj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 05:39:57 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C672EC061793
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 02:39:13 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id u14so27677wmq.4
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 02:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=vF0SYDK4JHQLqOuXur7sNXnKckOtjBYrrLkPSBmrSzs=;
        b=kIieN98UlcdTDZ854cVLDFPiT0uH2/tlY19ewqrwvrM5PtbmBwLh6D7BLw2e+8qQk2
         pvs24Wuac0ASq5yfErMIzYOa6mnxbQZQLk/9gWG02XiklF1DBX2ryXTHayMw7eatwxEh
         VYPWGk5nXPzrJCTpWOUv7oSR+mnfSToOKsAT874TrCof4ZjlUxL2ZQSttYLBVmhwhRG2
         5ESejoVWjtEMDFnCB4g1xroL0txRIgIFPDBSdizV67eSAPaxyCXT7vdiWfLs1u/90TRe
         zbOYQg0hq1qUZXlji4Qdu+jVBEYQzYKljnJxCNnqMW0EQT3kTdsCv7MbYVDDFH1D1Z6j
         GxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=vF0SYDK4JHQLqOuXur7sNXnKckOtjBYrrLkPSBmrSzs=;
        b=bJQSV6MgROJh5dJenm2Su2u2y7Tn9mqMy0hELSNF41iHvZ2xMhe8Mz6kRKt/NOQs+v
         2Fh1Rvq6s3c2TYED0lRY6MbmT81QwRleucDtmP54YS+3aEdOL9uFqMFr3U809/sshkf0
         giWgcrn66pIGaa10fOcTiqU9vRDMUu298AEZlOIq4mzxQ9piUagVMaTqre0QRydBQMmQ
         gbBC38x8y7d5a6tD+vZe8vWeVIuZayKjg7R7gi/nnqb9yRPO5GYIMp8fpeU+9hIWWtLQ
         lgsXinnm5JGcS9cD0uXH/ShE58/Y+uZ/0eGf82lGCQvvYOQhD1UEEdqVQ18VIuHaaOS+
         sPTg==
X-Gm-Message-State: AOAM5331g5dox8a31LKrZq2wM2+r8Sn2VxALNxCeYYcNxyx9KQ0o3Uv4
        upoLmXnQIxBD8P73FaFzzxyrtit9daU=
X-Google-Smtp-Source: ABdhPJzAnZdBuDHht3oxIUNBGkrZaBDYyMag8XjhjdY4Ds1KC4+wlEJKWcSJ6u1fsvO3qusy1J9TOA==
X-Received: by 2002:a1c:9ac6:: with SMTP id c189mr3313578wme.137.1610620752055;
        Thu, 14 Jan 2021 02:39:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i59sm4907114wri.3.2021.01.14.02.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 02:39:11 -0800 (PST)
Message-Id: <pull.837.git.1610620750894.gitgitgadget@gmail.com>
From:   "Mikhail Klyushin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 14 Jan 2021 10:39:10 +0000
Subject: [PATCH] git-gui: fix typo in russian locale
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Mikhail Klyushin <klyushinmisha@gmail.com>,
        Mikhail Klyushin <klyushinmisha@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Mikhail Klyushin <klyushinmisha@gmail.com>

Fixed typo in russian locale: издекса -> индекса

Signed-off-by: Mikhail Klyushin <klyushinmisha@gmail.com>
---
    git-gui: fix typo in russian locale

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-837%2Fklyushinmisha%2Ffix%2Ftypo-in-russian-locale-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-837/klyushinmisha/fix/typo-in-russian-locale-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/837

 git-gui/po/ru.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-gui/po/ru.po b/git-gui/po/ru.po
index 161ee1ac8cb..7aebaf809d0 100644
--- a/git-gui/po/ru.po
+++ b/git-gui/po/ru.po
@@ -331,7 +331,7 @@ msgstr "Добавить изменённые файлы в индекс"
 
 #: git-gui.sh:2936
 msgid "Unstage From Commit"
-msgstr "Убрать из издекса"
+msgstr "Убрать из индекса"
 
 #: git-gui.sh:2942 lib/index.tcl:521
 msgid "Revert Changes"

base-commit: 72c4083ddf91b489b7b7b812df67ee8842177d98
-- 
gitgitgadget
