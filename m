Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD46DC636D3
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 10:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjBJK26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 05:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbjBJK2x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 05:28:53 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FBF47402
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 02:28:51 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id o15so1279979wrc.9
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 02:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUDG+FAg6dNgJrZyVZNRFENNI5v6z5zIgFmf9KfvVfI=;
        b=JGBbyVGeSGYLeVqvVbtF78RUrKMW6kHSsC1yAY/yy7RMwvF9kAR7zxtRuzaQE4T+K1
         LZDCCAvt9b2r3AxN1vLmx8Wk+63ZZPkD7YyqEklbTWGPE6UV0/g7AZIckuhjvMfJplnr
         SdnFtRScnchNwV8RZW0+NoVsG4NeBmjhmbCkFbgTzHnI53bCbaBua8zSJ4svbLKHhmP+
         rJRr90lWb4S4+PNOidjsvgDeJe55dMKh2sb+qx9i4bed3BoSMm/H9cw7Oek4IaVnaI9f
         3hkwR1yh72R4laZkYvIbQPJ3ga/+t7dDnktVlfW5o7COdSNRzqyCv992MHwiDhL4uNVP
         VOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUDG+FAg6dNgJrZyVZNRFENNI5v6z5zIgFmf9KfvVfI=;
        b=d+oQXeg1NhZFUXo7uLJ2dyyNKC5zsnr8jQdxtZLmnGzAgQgPeMdvO0G8t1sZcV1QWj
         MW9GJs0k0Geh4ZOCyhZLVMLdT7QoGFfD81CQKW5aAV1m6fBwvHAadLmJ5dqiweyupyoY
         ku1d0YFayMkNeT6CbqY/m1hE9DdcvceU9fYO36ebwuwOfRfcI+F5z+pta01q3oPIMEgv
         sZy5RgZc3yEkMnHRN3XIqBbBcU+YqsSa9vAUj53a4eNaxpPnHhv2QjX2V2hRvngX0kzc
         8SyAWrZ3+XhirRJjNe2syn462nxcCl1dbT6HEVDSgaNL/G6TKEKSLH+A2FYSpF9RCKng
         H7Hw==
X-Gm-Message-State: AO0yUKXFyItKUbUVtBAo9ZzxQn9muDPINYL0lFsed+6VGm73BIIJARxt
        ZXqkiuNHbMl2S3oyjg2NSC7EFcuuK5JVWb+j
X-Google-Smtp-Source: AK7set8FvfIw2zfCsODkFmCtdzLjWn3sE9bn099NIdQEWrV7o0Cm9I3tvaQ6RtfSBVYHoflS0bNYZg==
X-Received: by 2002:a05:6000:1c1d:b0:2c5:4c9f:cf3b with SMTP id ba29-20020a0560001c1d00b002c54c9fcf3bmr8940wrb.7.1676024929564;
        Fri, 10 Feb 2023 02:28:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d514d000000b002c3f50228afsm3244792wrt.3.2023.02.10.02.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 02:28:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/6] builtin/rm.c: use narrower "USE_THE_INDEX_VARIABLE"
Date:   Fri, 10 Feb 2023 11:28:34 +0100
Message-Id: <patch-v2-1.6-916761cb50f-20230210T102114Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1475.gc2542cdc5ef
In-Reply-To: <cover-v2-0.6-00000000000-20230210T102114Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20230210T102114Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the "USE_THE_INDEX_COMPATIBILITY_MACROS" define with the
narrower "USE_THE_INDEX_VARIABLE". This could have been done in
07047d68294 (cocci: apply "pending" index-compatibility to some
"builtin/*.c", 2022-11-19), but I missed it at the time.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 4a4aec0d00e..8844f906557 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Linus Torvalds 2006
  */
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
-- 
2.39.1.1475.gc2542cdc5ef

