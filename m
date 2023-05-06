Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A00C77B7F
	for <git@archiver.kernel.org>; Sat,  6 May 2023 11:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjEFLgf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 07:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjEFLge (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 07:36:34 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C5D76A5
        for <git@vger.kernel.org>; Sat,  6 May 2023 04:36:33 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6434e65d808so3042866b3a.3
        for <git@vger.kernel.org>; Sat, 06 May 2023 04:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683372993; x=1685964993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrBUxp0F4dYdkN7Pw5SlVE4Nv9PrT1g3N7bWJshS3M8=;
        b=LHTq/6TAl/VjU8ybpg4KY4ABuof0tm6iny3I9o2kXI0YddxEzFDEbwJgz25NSSRdep
         bcFTSAv+2xWPhlnMy00nuy+59Pe2xMILOBLyqvUuNdDF7D53iDHvIb7qgBcVk5ZsfgUk
         4YjVpkqsm0+hAmCdZI406euOHrR6TMnoNENvM8WtLpYU3uqY4cL8w8HjY5ECeeTLi+xR
         C9f1YEbVlwZAKe4LZmG5HvdH62ULQ6OwObo9cHcAS1uzG1B2aV+2YhlrRcplSbT35Tef
         DGi2nqHG5AV/Jj5A/xuOIaMVJihf5hCdONNONQKIAixQ0D7QdVbhz4axczumGhX1vYqz
         NWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683372993; x=1685964993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrBUxp0F4dYdkN7Pw5SlVE4Nv9PrT1g3N7bWJshS3M8=;
        b=mGa3WLd3fCyWOT+Kp/gL4jvhEPYe7MNiH8MhlWD71iiXrHOELqF/si9DN3TKjBmoZG
         VbYqR73dcRUTnP5/3STY5up3S3FnbndX+GTxOEDtkRfW8qkeLRBts2mnTiVlqpFRXkYd
         VH8DObufKbJk8YjaQ+S5wVYfxOUaG3pk8k70ybHVD5nUdFDP3TiJDKC6iL7Z9oov2vEL
         NUczNp6MTbqlKSnk7mrwNtXJAaSqq3Ly7FP0NA6O8WAh45TRc8df6vkG3a1i+kytLSG5
         1OaOCt1PH/lnsTp6wvQDEvhglGY7s8tI+WzYOApDGT/0t1jpnZv3bXpbbHYCWqpcGn0P
         Q1Rg==
X-Gm-Message-State: AC+VfDylSsbAh/0IuSgGLsiRgwIH22NaDNsTv0fEChAekA+8zv9VdY2a
        6fm8YT2r78Ykix/EExqrvOlt8w/9pSj1AWRNdT0=
X-Google-Smtp-Source: ACHHUZ6ZX9TeX78QOJqGYayFGYm0xejL4d9AnUu+T0IOTTdb5+UntBy52IpLwGDSeYZXN4fPcrxU3Q==
X-Received: by 2002:a05:6a00:228a:b0:643:59e7:e601 with SMTP id f10-20020a056a00228a00b0064359e7e601mr5864631pfe.26.1683372992932;
        Sat, 06 May 2023 04:36:32 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id v12-20020aa7850c000000b00627e87f51a5sm3012551pfn.161.2023.05.06.04.36.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 May 2023 04:36:32 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH 0/1] push: introduce '--branches' option
Date:   Sat,  6 May 2023 19:36:26 +0800
Message-ID: <20230506113626.61560-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.1.446.gf331623a.dirty
In-Reply-To: <20230506112740.61454-1-tenglong.tl@alibaba-inc.com>
References: <20230506112740.61454-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

wrong context, please ignore it, refer to

  https://public-inbox.org/git/20230506113408.61529-1-tenglong.tl@alibaba-inc.com/

Thanks.
