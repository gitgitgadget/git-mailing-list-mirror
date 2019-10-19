Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D1381F4C0
	for <e@80x24.org>; Sat, 19 Oct 2019 10:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbfJSKfw (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Oct 2019 06:35:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43222 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfJSKfw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Oct 2019 06:35:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so3495218wrr.10
        for <git@vger.kernel.org>; Sat, 19 Oct 2019 03:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jMmCozbUr/QVQyVyEsFlszBE917s8M+G60xNdUWxY4E=;
        b=cS5pP5N3EDFB3lKOBAKBsNX3ZWJpsWSpI+xUgiOLWiZKhj9BpMP+zWDG5s5A8oWp8w
         FTq0pNOtWr4vVe551vg+KH9RqttGiIE7ZlRNRDq1Euf7UInfgf9cE1Ez+67mKqGjW3T+
         9QZ+YZZkm2e2ZtUg+xxp6vxHIRLCanxyL1GYAuBcR8LVGJZo3cHX2/MuAG8merUr+YIW
         RYEzmtUrbXWputXKkwRHNHpHf99hszQdM42Lz40TCrMxbIpxER3wX3wcYYCY/+Pux+uh
         7qpX1vroquo6ioR/wUaiVyBYgbanLzdlHZpI4QOjYTYjYZuMjh/zhYmmkBOZ5EV14m/a
         zjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jMmCozbUr/QVQyVyEsFlszBE917s8M+G60xNdUWxY4E=;
        b=d4xKZwpj23NgMZFpGp75foRDXZ18MDx7W0l9/IB6mL4B/dKi5899d7tKMvBkO5mVPo
         U0AQQnXf2sVj7YbznkFUPAFRElE10/05E9otpYanRrqECwzUfkh9AeFy4a/8XQUH/yyK
         KZFWHmT51hNz48anAaHJ+Z+wxnFPsJQcjk0dg2I3avyntwVGgRr4MYIcEHgUgYYoNRJY
         0Z2dYu8/pKvX6Uc0SyBk+z3lo34/7wiRSDvgtozU560q4W+hhEvC22Dz20wGuolgSW+u
         IsSrgHavkxpJYWBrLw8/9ZE/OFQmMZEbnonSPdiTfpAtyfs5cIz5wyikSaDlUXCnFV9t
         gjPQ==
X-Gm-Message-State: APjAAAX+/ZBA8QYL+Qs6t0CtsEd9gHID7KYelcJ1jpDUX5gL93l9AdEJ
        jJ23cxNgHGiGcZnICripkyfDpgJmeLXO1A==
X-Google-Smtp-Source: APXvYqyoZi/VPxno9dk3Mo0PrBAH/AmKf0IrYFnunitlzfLG5Q9iJL/PQM/jV4DJqrSMFuGKFr28pQ==
X-Received: by 2002:adf:db42:: with SMTP id f2mr12388235wrj.287.1571481349419;
        Sat, 19 Oct 2019 03:35:49 -0700 (PDT)
Received: from localhost.localdomain ([80.214.68.206])
        by smtp.gmail.com with ESMTPSA id p68sm6383086wme.0.2019.10.19.03.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 03:35:48 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 0/9] Rewrite packfile reuse code
Date:   Sat, 19 Oct 2019 12:35:22 +0200
Message-Id: <20191019103531.23274-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.0.rc0.9.gef620577e2
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

The first version of this patch series was also discussed:

https://public-inbox.org/git/20190913130226.7449-1-chriscool@tuxfamily.org/

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

  - Rebased onto current master (v2.24.0-rc0), which means that
    conflicts due to dropping the last argument of packlist_find() are
    resolved.

  - Replaced "in a following patch" with "in a following commit" in
    commit messages.

  - Squashed previous patchs 3/10 and 4/10 into new patch 3/9 as
    suggested by Peff and Jonathan.

  - Changed commit message of patch 3/9, so that the justification
    should be correct now.

  - Also in patch 3/9, `block ? block * 2 : 1` is now used to compute
    the number of words that should be allocated.

  - Changed commit message of patch 4/9 (previously 5/10), so that the
    justification should be correct now.

  - Document pack.allowPackReuse in patch 7/9.

  - Also in patch 7/9 move using the `allow_pack_reuse` variable into
    pack_options_allow_reuse() as suggested by Junio.

  - Improved commit message in patch 9/9 a lot by adding many comments
    made by Peff about it.

  - In patch 9/9 removed `if (0) { ... }` code.

  - Also in patch 9/9 changed parameter name from
    `struct bitmap **bitmap` to `struct bitmap **reuse_out` in
    pack-bitmap.h as suggested by Jonathan.

I tried to use `git range-diff` to see if I could send its output to
compare this patch series with the previous one, but it looks like it
unfortunately thinks that new patch 7/9 is completely different than
previous patch 8/10, and also it shows a lot more changes from patch
10/10 to patch 9/9 than necessary for some reason. So I decided not to
send it, but if you want it anyway please tell me.

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
 builtin/pack-objects.c        | 235 +++++++++++++++++++++++++++-------
 csum-file.h                   |   9 ++
 ewah/bitmap.c                 |  13 +-
 ewah/ewok.h                   |   1 +
 pack-bitmap.c                 | 178 +++++++++++++++++--------
 pack-bitmap.h                 |   6 +-
 packfile.c                    |  10 +-
 packfile.h                    |   3 +
 9 files changed, 349 insertions(+), 110 deletions(-)

-- 
2.24.0.rc0.9.gef620577e2

