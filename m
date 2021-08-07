Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB38DC4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 20:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8750A6103B
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 20:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhHGU2z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 16:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhHGU2y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 16:28:54 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15B0C0613CF
        for <git@vger.kernel.org>; Sat,  7 Aug 2021 13:28:36 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id g6so6878101qvj.8
        for <git@vger.kernel.org>; Sat, 07 Aug 2021 13:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ieQBfjW2X4++i8jKiIRxZ6nr0n4dKC/Q6mcOT2YNBys=;
        b=DPffnKKrj2GvblvHU+QbbvI15QtpE3zafuGkjo55ybsPnpW9ZJ0n/QWbdcmEbWrVQ9
         v9G/SecJOnfq+dKOr/P4Ivhkge2bqGKRr3RuUpPU16NGafmmSptQwGFSYdBRL7l2Th5Y
         mVa67WlM6I5Nm7lShvw+vft/dsEni7rx4lQOhf2gK3AuFBWm6qTnrB/PtVbceVlL6vhj
         EZEADjOEpb/eagglUauQNYrXPpW+dzmlybx74AoaHva5o1nL3rLWva1Y3W/IPUHqZfle
         jf+1XpLSQYpADjObi3Qy495E0ahqxyLFaXYfWL/1PHG263mHWra7MPvNe8Nfl1PEOVS2
         Biug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ieQBfjW2X4++i8jKiIRxZ6nr0n4dKC/Q6mcOT2YNBys=;
        b=rcAYO/k82uIqPJU5zcR2oWDxks9wLsPECslG/1AvJVgyUhkLMri0WjFq/wAp7Da91a
         7wkTBec6+wZ3QqmCBFscYyGzVl/ah+AU/Cy5ALpB7b/zagrpNmL8QERw15cEkvMdK0fO
         1VWHgx8Z9tp0q56yqLCkOENj1ivJJMQt0Dp2MfVmGr7sZqtZCceTq5mZTwaaSJAQdvPU
         sObJQu/ZUhoZEB1qGESjgrKSM57dMTsOmj9NvUQBnadpaxBs2LU6roaMVHh4qSF/xRNB
         xVPGcIUne2Xx53UXLhPQHt04Bxl8ihxXh5xudcyBs+Rpi+lAcUUr6V52Jws+jWUpxi/V
         1rtA==
X-Gm-Message-State: AOAM5315GWIt+lHwSERYWuLOlRRgBmOWRFVGJStC9L7IxUBMghvFdh0R
        w7JN26DYct4Lc+tbCIYaSKW5hEbxN/o=
X-Google-Smtp-Source: ABdhPJxRWbEZmHXmeX/y1wnPxpkYKifkL+jxOb/JRQ+3YqGhu9OZUzPBkRfz0H8k9zbIxQ1myJTcLQ==
X-Received: by 2002:a05:6214:3a4:: with SMTP id m4mr17078293qvy.17.1628368115603;
        Sat, 07 Aug 2021 13:28:35 -0700 (PDT)
Received: from noah-XPS-13-9310.myfiosgateway.com (pool-173-48-203-160.bstnma.fios.verizon.net. [173.48.203.160])
        by smtp.gmail.com with ESMTPSA id b1sm5037038qtq.12.2021.08.07.13.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 13:28:35 -0700 (PDT)
From:   Noah Pendleton <noah.pendleton@gmail.com>
To:     git@vger.kernel.org
Cc:     Noah Pendleton <noah.pendleton@gmail.com>
Subject: [PATCH 0/1] blame: Skip missing ignore-revs file
Date:   Sat,  7 Aug 2021 16:27:51 -0400
Message-Id: <20210807202752.1278672-1-noah.pendleton@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Setting a global `blame.ignoreRevsFile` can be convenient, since I
usually use `.git-blame-ignore-revs` in repos. If the file is missing,
though, `git blame` exits with failure. This patch changes it to skip
over non-existent ignore-rev files instead of erroring.


Noah Pendleton (1):
  blame: skip missing ignore-revs-file's

 Documentation/blame-options.txt |  2 +-
 Documentation/config/blame.txt  |  3 ++-
 builtin/blame.c                 |  2 +-
 t/t8013-blame-ignore-revs.sh    | 10 ++++++----
 4 files changed, 10 insertions(+), 7 deletions(-)

-- 
2.32.0

