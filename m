Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62628C77B7E
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 13:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjFANrq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 09:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjFANrp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 09:47:45 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34342129
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 06:47:44 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-64d722dac08so196833b3a.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 06:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685627263; x=1688219263;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t4LMLc/BnxUyJ+Nl0OBafqNPQwhiNBMabUV3gnpaatc=;
        b=Qve3QKda9eflGorWsHO/LDsGstuS01S29v+KAt3ftt8e4oo93phr/AqJ922IKx96Zb
         3U1vBZQTldiT/zkuHb5aFZBbCkI7KjkJCtefJ6wJotJD4BDB8eL0MhTc8u0yFTrKB0s3
         4j3ILzmdfhvu25Ng4ZF9goN5fd/5gc79h/B9OldYE0N7FmoKwevjS26ipi7WsC+e3QBq
         ZU6dIvQ+T1gB7Iwc9SnSfwOvgM1mepWD7tS4J6ybKSNNmUD/JcM6497V4yjZQ5SKv7WK
         eAO2j2T/GyDquzQiTD8AzADW5Ly9T5vYzO8N6DXb8OQ+AHMBT8DhRQr3LO7wK55B5dwT
         dREQ==
X-Gm-Message-State: AC+VfDzAZ5bhdtcnZpXluA+4fgcFmGVJu8CBoDG8dDrttWjcXNbJ3TgG
        22GsS2IXyNW6p6fCNvRwRaZnI6yzckC1Naxm//KNHARZvxg=
X-Google-Smtp-Source: ACHHUZ7yQY+b/E/iK0uMxLNuSNi8f06+rmCH+hsSxF2nqX5AQnimZd3SoZrK+IOejr+eJw+j7bn4kQUq0qVP3oqV6RM=
X-Received: by 2002:a05:6a21:78a6:b0:111:a0e5:d29d with SMTP id
 bf38-20020a056a2178a600b00111a0e5d29dmr10472339pzc.4.1685627262894; Thu, 01
 Jun 2023 06:47:42 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Date:   Thu, 1 Jun 2023 09:47:27 -0400
Message-ID: <CAOO-Oz2ua31xDOA9hdE-mMx3qwctDHK6Tu6AKdGc1_beuJMkwA@mail.gmail.com>
Subject: Problems with 592fc5b349
To:     Git List <git@vger.kernel.org>
Cc:     newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

592fc5b3495bf4ff17252d31109f1d9c0134684b moved backup definitions of

  #define DT_

from cache.h to dir.h, but did not include dir.h in cache.h despite those
#defines being used there. Easy fix, `#include "dir.h"` in cache.h,
which I'd submit as a patch, but then name-hash.c, which includes
cache.h, which would now include dir.h, ends up with two definitions
of `struct dir_entry`.

Suggestions?

-Alejandro
