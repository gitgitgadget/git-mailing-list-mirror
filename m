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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49599C433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 21:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2367229CA
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 21:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgLUV1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 16:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLUV1e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 16:27:34 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCDFC0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 13:26:54 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id y19so26962563lfa.13
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 13:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kQtlv71BgjJDGgOr+euauN6L4lv8bzso/wU0iKKHqt4=;
        b=ooA4LGRBafre7QSvLyJSfYQvrqiGu2QrLhC6PbePnQpoTc6W/SgUqEHz9WjE6XyZHg
         K/q6DyNWlT2/Hj+H2wij1zC7gBuEqsKkx0wf8xGXgWGw+Hr379iWGIQ9oXfdJqH+pube
         KP18MdiTkin3QWiyjvIVGC12iXGOwgsBKsri+BofvCfcozcjRfCi00oF0AOKP5PVmpOR
         vpxvto+5zo4F83X8FGMSJdh8I/Z7vtqjNPWMi0EVfOW0cpKN/QFKdSToH5TJik2mMlnt
         sq2bNjHnTpUuHWGtqdoZktRAaiZBF9f/MGBAH0OJURIUVbjq1tF2ARZFrQq4eD7n8RGS
         HzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kQtlv71BgjJDGgOr+euauN6L4lv8bzso/wU0iKKHqt4=;
        b=P0LxLg8qvNkWxWdhu1V7bNklJc85+NO+Pvzd8SvXgtK1Qfm0LgrjKWuSgPK0TFB4HR
         nXlEhw2SF8d3h3YHuAfV4R51xdgMA70faBjmVVb+RWiKnYMyCPhJpjIWJQY1qVcezsHf
         w14UfnbxLROiGbfdCDmMQBgnnRGeC0LXbopWS6Z0fkK5CjDur85RPsEmnqYGvzk2hUWO
         2i0H2VS510+O4fhcSnGwHaJAvtBQo+1zZcboC4wxq49LDACKvl7D6o2WnnxEXnMqNKXN
         WRMKPrLRj+KS4aZV8SS5k23cvDFEc3tpYPoXtGhOg9UfY/+h3PtSxBcSpxQDf/Y002fI
         d9eQ==
X-Gm-Message-State: AOAM530wJF/QIB48/VbwKCHSzEBknj9oXUUaEP3mTclNeiI9+Uj0W9oH
        FS36gL2r4A3jdRpq5EFFHDqrqXtsYV4=
X-Google-Smtp-Source: ABdhPJwQIoNbtN0yan/7kWYoOVYNwxYiVkuxGOCMHmWP4tTpmpDK2qcpuOCvN8wewRYlCGc/iGPxwQ==
X-Received: by 2002:ac2:482c:: with SMTP id 12mr5921248lft.37.1608586012512;
        Mon, 21 Dec 2020 13:26:52 -0800 (PST)
Received: from localhost.localdomain (78-66-223-148-no2204.tbcn.telia.com. [78.66.223.148])
        by smtp.gmail.com with ESMTPSA id t14sm2236100lfl.216.2020.12.21.13.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 13:26:52 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 0/3] gc: fix handling of crontab magic markers
Date:   Mon, 21 Dec 2020 22:26:30 +0100
Message-Id: <cover.1608585497.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a fix for a new bug in the v2.30 cycle:

`git maintenance [start|stop]` add and/or remove entries to/from the
user's cron table. When inserting entries, we add magic "BEGIN" and
"END" markers. When we later removes these entries, we remove everything
from "BEGIN" to ... the end of file. A realistic scenario for hitting
this bug is

  $ git maintenance start
  $ crontab -e # add stuff at the end of the file
  $ git maintenance stop
  $ crontab -l # stuff from above is gone

The second patch is the actual fix. The first patch is just a very minor
fix to the documentation. The third patch future-proofs the magic
markers, so that we can be reasonably sure that all future versions of
Git stick to these strings.

Martin Ågren (3):
  git-maintenance.txt: add missing word
  gc: fix handling of crontab magic markers
  t7900-maintenance: test for magic markers

 Documentation/git-maintenance.txt |  2 +-
 t/t7900-maintenance.sh            | 16 ++++++++++++++++
 builtin/gc.c                      |  7 +++----
 3 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.30.0.rc1

