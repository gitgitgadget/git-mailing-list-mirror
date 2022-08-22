Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C514FC28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 21:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbiHVVPQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 17:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiHVVPP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 17:15:15 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02CE326DE
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 14:15:13 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bs25so14728569wrb.2
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 14:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=fjAghy/Xy98lNyO2NBaanetCUp21rj5BzACf+J8MyGA=;
        b=DQULGs2BRX5ljAZGUKr2yHgZ06cA1DnIOlRRqkoJ9bLEU9bacgMTr0TFl6MXKiYHki
         h7ZLkIX5T8I9kGpmtlYwsL5IHoAiT8lsNvvZuZOlgs+c9smUSWGdmlyTiD+CJ0jO8NQd
         Uk/vHdts3WYM+vS7G+VyY07BycWD1IZq1OHFhHd9WeegU+9/tRM/FdVJkZbLKSYOxIBK
         18x85NEoyFz32UUw5sH6Q1XEyfsIuGEYsWj0RUwb4byvoJsI82K7nOaQBZuAwEoTkd25
         iCgiMFr2hM52FCw/kmfWym4Tsp6QsirKpp9QU7rw6EKmHmEvkzpOFmAw2dyaYB2v2YMG
         djqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=fjAghy/Xy98lNyO2NBaanetCUp21rj5BzACf+J8MyGA=;
        b=2+rs/gueTgUrn1mn/QgktwWmXaeUg3RVM48DeCxB/353f9OjXy0+sd1+nwovh3CDLo
         2aMq8xhYzHPJfmnr9hg808sBCfv0bSOfHFM+RGgpziss8nl4HBiOcfBX0o/IjkIdxueG
         dj8CJw0rQcsv0mZHtfjKyy7Z82zmJktY6ZGIIujdfmVXgZqm2twtR9OLLMqP7SRfISeL
         eovz+68pOs/UI4qRgyGLjjOQUMf8l7E//MWyIQFdrZbTNXMDTFx72C1Hvy9xox8XyZbj
         xHDPnFXfLn5fnwYPJfLrt5d73jka/0RQw8MkWC1rIg2NGc4HNHhnAv2mgFwp5OabDngH
         7/lw==
X-Gm-Message-State: ACgBeo0hBDwLRO02FPEECNx5s3wJ2g/miCwGYlMM1pGK7Pvr0HuR5pIC
        QeapyJ4tevpJFVPHtQi9Kh0mKaeIfI4=
X-Google-Smtp-Source: AA6agR6pkd0mCyqyv2FMpBrVXh4R46C3NaonxsUcScRMSz415rbYuoffkYj+8RrfAm/z7YbjL3jZiw==
X-Received: by 2002:adf:f387:0:b0:225:3d19:adf1 with SMTP id m7-20020adff387000000b002253d19adf1mr8445606wro.520.1661202912163;
        Mon, 22 Aug 2022 14:15:12 -0700 (PDT)
Received: from rah.. (2a02-8429-8157-8b01-3203-c8ff-fe28-5999.rev.sfr.net. [2a02:8429:8157:8b01:3203:c8ff:fe28:5999])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c384900b003a35ec4bf4fsm15902928wmr.20.2022.08.22.14.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 14:15:11 -0700 (PDT)
From:   Anthony Delannoy <anthony.2lannoy@gmail.com>
To:     git@vger.kernel.org
Cc:     Anthony Delannoy <anthony.2lannoy@gmail.com>
Subject: [PATCH v2 0/1] pathspec: fix memleak
Date:   Mon, 22 Aug 2022 23:15:06 +0200
Message-Id: <20220822211507.8693-1-anthony.2lannoy@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v1:
- use directly clear_pathspec() function instead of multiple free()

Sending this patch to fix a memleak, created with copy_pathspec, found
thanks to the address sanitizer.

Thanks

Anthony Delannoy (1):
  pathspec: fix memleak

 preload-index.c | 6 ++++++
 1 file changed, 6 insertions(+)


base-commit: 795ea8776befc95ea2becd8020c7a284677b4161
--
2.35.1
