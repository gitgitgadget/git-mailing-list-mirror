Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EF921F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 14:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfKOOQB (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 09:16:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34045 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfKOOQB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 09:16:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id j18so10180157wmk.1
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 06:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P//NRvd6iygy98zMx0D12yIEHseTZh4cVo2QlIVFiIA=;
        b=gPm90cqwKPLocBbgxy5Wwdp4yu8tWz3/HfjvoCiEal7WPs3KyKHQhphAv+Gp4bXRv7
         frrIGiFW2/9Mx3mKr9C7LYLdPjnPzdZy2nLhYP6faDUVODfSgdHPQ3VW6BMzq8GMRkp1
         3IxOJF59bGQgCliBORkMz927We8OktoYAVHGTAtCrXZ2YRDSYmlHiD4gAy0co7SU/ChF
         ml7UNigchx8y0taaPwcTGQDqDSX120sOUpfWc0VgFPV+nD/Z4dwbFE6+uJlAFZOFhvmQ
         CazN4IEV7cVMKZy2XyTzwAWbadcibYzFF1qWamAlxnnhM/x+SZRGQ81H11Drwfae6LzY
         8wJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P//NRvd6iygy98zMx0D12yIEHseTZh4cVo2QlIVFiIA=;
        b=JmVch+05tyl3lTCzA9PMNYCGNphM9NQSaGqGdxE0B8ShR5zreu4Wf04QfmcUBMxIZi
         5r6gZERcE8QJb/RxWr67DoTD5/ZA7pb9MQY3WmkOOwkZCommITB0nr70hvAoDUjrHIzb
         3QxtBQyvaWFHnGppZDabRRfYEBzZQaPBjVw42YEZgfGH71fiWo+A4Jx1KJzXDHqCDco1
         cR96GJ/6euF+Xb4iin5Z2rPNzKgpsxbHuz7p4PD3UHzB/JsARyKh10bqFTwJElH1NxpJ
         OnxVVlgwWTMUXMQEcrMmUCKMUoXJduFr/nJbFvLZYitTwPrx6DM3H53iK/cvlrPFNUzs
         5lmA==
X-Gm-Message-State: APjAAAU4EsPH8vwy10BxZSo1N43hmD48H9WJcnT2Rc40inG0+klwQ0p4
        ckLQPFkur8SOKoCUtyZjIrMI6vzi
X-Google-Smtp-Source: APXvYqwKUbLwRuszjUIBBuPaHNIqnVrpiRd+hvn/zaH0zUb1eP5Qn2oY+STdXH34aJwle2MlcGnLlw==
X-Received: by 2002:a1c:9e58:: with SMTP id h85mr15451874wme.77.1573827358532;
        Fri, 15 Nov 2019 06:15:58 -0800 (PST)
Received: from localhost.localdomain ([2a04:cec0:1050:ac52:b4cd:f6a2:ba59:f1d4])
        by smtp.gmail.com with ESMTPSA id a2sm7907874wrt.79.2019.11.15.06.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 06:15:57 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v3 0/9] Rewrite packfile reuse code
Date:   Fri, 15 Nov 2019 15:15:32 +0100
Message-Id: <20191115141541.11149-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.0-rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is rewriting the code that tries to reuse existing
packfiles.

The code in this patch series was written by GitHub, and Peff nicely
provided it in the following discussion:

https://public-inbox.org/git/3E56B0FD-EBE8-4057-A93A-16EBB09FBCE0@jramsay.com.au/

The first versions of this patch series were also discussed:

V2: https://public-inbox.org/git/20191019103531.23274-1-chriscool@tuxfamily.org/
V1: https://public-inbox.org/git/20190913130226.7449-1-chriscool@tuxfamily.org/

Thanks to the reviewers!

According to Peff this new code is a lot smarter than what it
replaces. It allows "holes" in the chunks of packfile to be reused,
and skips over them. It rewrites OFS_DELTA offsets as it goes to
account for the holes. So it's basically a linear walk over the
packfile, but with the important distinction that we don't add those
objects to the object_entry array, which makes them very lightweight
(especially in memory use, but they also aren't considered bases for
finding new deltas, etc). It seems like a good compromise between the
cost to serve a clone and the quality of the resulting packfile.

Changes since the previous patch series are the following:

  - Rebased onto current master (d9f6f3b619, The first batch post 2.24
    cycle, 2019-11-10)

  - Remove a paragraph in the commit message of patch 3/9 as suggested
    by Jonathan Tan.

  - Improve commit message of patch 9/9 as suggested by Jonathan Tan.

  - Renamed fields of struct reused_chunk in patch 9/9 as suggested by
    Jonathan Tan.

  - Added a few comments in patch 9/9 as suggested by Jonathan Tan.

It could be a good idea if Peff could answer some of the comments made
by Jonathan Tan about patch 9/9.

I have put Peff as the author of all the commits.

Jeff King (9):
  builtin/pack-objects: report reused packfile objects
  packfile: expose get_delta_base()
  ewah/bitmap: introduce bitmap_word_alloc()
  pack-bitmap: don't rely on bitmap_git->reuse_objects
  pack-bitmap: introduce bitmap_walk_contains()
  csum-file: introduce hashfile_total()
  pack-objects: introduce pack.allowPackReuse
  builtin/pack-objects: introduce obj_is_packed()
  pack-objects: improve partial packfile reuse

 Documentation/config/pack.txt |   4 +
 builtin/pack-objects.c        | 243 +++++++++++++++++++++++++++-------
 csum-file.h                   |   9 ++
 ewah/bitmap.c                 |  13 +-
 ewah/ewok.h                   |   1 +
 pack-bitmap.c                 | 178 ++++++++++++++++++-------
 pack-bitmap.h                 |   6 +-
 packfile.c                    |  10 +-
 packfile.h                    |   3 +
 9 files changed, 357 insertions(+), 110 deletions(-)

-- 
2.24.0-rc1

