Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66D2C64ED8
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 23:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBXXjW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 18:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBXXjV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 18:39:21 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6E864D7C
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 15:39:19 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so516024wmi.3
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 15:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=410TqsSfQSFOPLlWnvliuZlLNxR555y8pHj2a3iU8Qo=;
        b=KYqOIcxiYAw1m+Kd9cUg434zISi2j/+IJddFN75ujrueFbKW2RUEpyW/kiLwN3UiUO
         F8g1VRQBPS58X+vWUUN7R2xaPIPnamTEGg8FocMfpP6j2agV2MvABtdcPSMRAAlpaSmK
         AVPDw/0hPUVrnqwHeOKYzDAN/x75ap/FasYIb8cQjNOHtWFV/zqPVqc7+jjmKYuVaJWt
         toEWQ96ImnYhXC16oSNNrCYpZBhVaSbxqtqpXE2dEUKZdTcXzf2oMC5T3672UVaNvvFx
         g7fzi8UHCeD2AuEbpq6GRK2fdxz5AiMFOw7zmq09mkUtRI8o1RvpTpb0+LIQP9B0bpau
         wrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=410TqsSfQSFOPLlWnvliuZlLNxR555y8pHj2a3iU8Qo=;
        b=QXnLvegkYHhiq8MkGTMa+3np/ANPn5BYilujnj5r9Lztr1DToFFgnxlKRx6ZJSLO3I
         lrr0L6klHDVIrzj7U9GGAKHenz8HDH1oHfc7EZ7R3gQfTyzfBqaQYTGrn6eiyswcqEtu
         4T/YC9T9Ky78f9UD6CXilBngFsRMLYdDi8Ue7nqf4wqOQgQJZodOcs4EfV4ljzfVRN0u
         8WxQDOELhuWmlUPQm5T0bV10f0pTC7MA74jbMBSphFnr/iGkWr4bYi4c3yyT1RgigXm+
         dBfy7Ra3ca9/Nk68rXsVsiQaPXwh4WrT1kwHFN19SHVUtxItzCO+4G5A0E3bLvYmaZFZ
         v89Q==
X-Gm-Message-State: AO0yUKUvcC71cIMdjSnCmZ1paDBo5ehYXshyrvPcc9H5L5o1jlLVoLei
        Bmj1k/tcTnQl4dfTu+ZdSCksvzWSlUR7Lw==
X-Google-Smtp-Source: AK7set8dKUi6YbHtmeM2qOITSe5a71SGsmXEYzGwiljeE7HntS5LsRW40tJyiL4si4K70iYI85FGkQ==
X-Received: by 2002:a05:600c:3299:b0:3dd:a4ad:ae45 with SMTP id t25-20020a05600c329900b003dda4adae45mr12909556wmp.12.1677281957461;
        Fri, 24 Feb 2023 15:39:17 -0800 (PST)
Received: from DESKTOP-FOQ07IR.localdomain ([2a00:a040:191:caeb:8c12:5f48:cdd4:4a9e])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c35c600b003dc4fd6e624sm709441wmq.19.2023.02.24.15.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 15:39:17 -0800 (PST)
From:   Roy Eldar <royeldar0@gmail.com>
To:     git@vger.kernel.org
Cc:     Roy Eldar <royeldar0@gmail.com>
Subject: [RFC PATCH 0/2] status: improve info for detached HEAD
Date:   Sat, 25 Feb 2023 01:28:39 +0200
Message-Id: <20230224232841.21297-1-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a repository is cloned using "git clone -b" and a tag is specified,
HEAD is automatically detached. As a result, "git status" shows
"currently not on any branch", which is not very useful.

Teach "git status" to generate the "HEAD detached at" message in this
case as well, in a similar way to when a tag is checked out.

In the case of "git checkout", the name of the ref that was checked out
is retrieved from the reflog; for "git clone", the name of the ref isn't
present in the reflog entry, so we use the abbreviated hash instead.
This is also consistent with the "detached HEAD" advice.

Roy Eldar (2):
  t7508: test status output for detached HEAD after clone
  status: improve info for detached HEAD after clone

 t/t7508-status.sh | 12 ++++++++++++
 wt-status.c       |  7 +++++++
 2 files changed, 19 insertions(+)

-- 
2.30.2

