Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB12C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiLOJLY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiLOJLW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:11:22 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8412AE29
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:11:19 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h12so2323625wrv.10
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCtYMSeO6J6bgj+rhpmq2OWgTQD2yAn+KBy+z9ElkSk=;
        b=OyQE8NCY9RM1OHByz44WynqSpFjawViX4X0qvJ/S2B8+AhARpy0MHaXD7AOhpVh7MQ
         as6njaCU/5a9rCawR3GQRKq6W5wFGCwFVfzSkkBPvmjmVMxwcqBxPgYhnsONx92ruDT1
         mLIbUIilM+DXjT1HdEscEDYtJ8GUlxVlLY8OqTK7L0dmBAJtgrkTzxSSGEIEzAj+p1dE
         r6PjnDIXzCvC//OdFn5eoTaxad9CbaqunayuQM00KbwfCT9ce4fpvQokf6gBk8rMz5Qf
         /ez890wlCgE8YD6c/cemQEHoPozvdBilLoEi1YM9GFjA9miS/pXb6LH9Le3iYfXNmZLj
         /NDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCtYMSeO6J6bgj+rhpmq2OWgTQD2yAn+KBy+z9ElkSk=;
        b=T9kEoztWzNfiC+G1cYJUM+NDJWtM0l2OB65i98H+4BvIF7G8MdiuSrzJDIhGgNg+Lp
         KE0MvuxF7W4lZUyhnK8NO3e3l2DGufiHbEaixE9Ptc1sZZEXjaoV0KCwi6mk8KPZ/Uzm
         sN4mhNbIuVO8YkTE0BxQoO9Rp/n9lVp9w0IU5TqqXv9W8lbHL4+ruj3k5mS2RkiGccA+
         WFQLPRvbe6zgwZyrjS1YX7hrFsVUI+kXQnq9FeWnBc8zt4XIqWgUxljlzHvMd6mGoQM4
         240RYhTuTUU9d8OGCgDIxNsYUIbTym2Mj8mO663zEkD3ud+WRz5hoOeczPDdXIseoJdn
         8CaQ==
X-Gm-Message-State: ANoB5plOicB05xi6kt2u/IT7lv3cLwsSklNswJDRGduC69sWSKHDB1Vi
        mKT27wKmR1NZYjOlt0KULro2xvRttvU8rg==
X-Google-Smtp-Source: AA0mqf46lJjgU5rU2x4h+IkYV06KMATaob/Ri8KM5K9pd4jwXe1R6jGs8h84EfBXCDYDgXNIiIl/mA==
X-Received: by 2002:adf:e9c1:0:b0:243:2077:8d3b with SMTP id l1-20020adfe9c1000000b0024320778d3bmr18012984wrn.5.1671095478026;
        Thu, 15 Dec 2022 01:11:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m7-20020a056000024700b002366f9bd717sm6193835wrz.45.2022.12.15.01.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:11:17 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 0/5] strvec: add a "nodup" mode, fix memory leaks
Date:   Thu, 15 Dec 2022 10:11:06 +0100
Message-Id: <RFC-cover-0.5-00000000000-20221215T090226Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <221214.86ilie48cv.gmgdl@evledraar.gmail.com>
References: <221214.86ilie48cv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an alternative to René's [1], his already fixes a leak in "git
am", and this could be done later, so I'm submitting it as RFC, but it
could also replace it.

I think as this series shows extending the "strvec" API to get a
feature that works like the existing "strdup_strings" that the "struct
string_list" has can make memory management much simpler.

The 4/5 here shows cases where we were leaking because our "v" was
clobbered, but where all the strings we were pushing to the "strvec"
were fixed strings, so we could skip xstrdup()-ing them.

The 5/5 then shows more complex cases where we have mixed-use,
i.e. most strings are fixed, but some are not. For those we use a
"struct string_list to_free = STRING_LIST_INIT_DUP", which we then
push to the "to_free" list with "string_list_append_nodup()".

This does make the API slightly more dangerous to use, as it's no
longer guaranteed that it owns all the members it points to. But as
the "struct string_list" has shown this isn't an issue in practice,
and e.g. SANITIZE=address et al are good about finding double-frees,
or frees of fixed strings.

A branch & CI for this are found at [2].

1. https://lore.kernel.org/git/baf93e4a-7f05-857c-e551-09675496c03c@web.de/
2. https://github.com/avar/git/tree/avar/add-and-use-strvec-init-nodup

Ævar Arnfjörð Bjarmason (5):
  builtin/annotate.c: simplify for strvec API
  various: add missing strvec_clear()
  strvec API: add a "STRVEC_INIT_NODUP"
  strvec API users: fix leaks by using "STRVEC_INIT_NODUP"
  strvec API users: fix more leaks by using "STRVEC_INIT_NODUP"

 builtin/am.c                  |  2 +-
 builtin/annotate.c            | 17 ++++++++---------
 builtin/describe.c            | 28 +++++++++++++++++++++-------
 builtin/stash.c               |  8 ++++++--
 builtin/upload-archive.c      | 16 ++++++++++++----
 strvec.c                      | 20 ++++++++++++++++++--
 strvec.h                      | 30 +++++++++++++++++++++++++++++-
 t/t0023-crlf-am.sh            |  1 +
 t/t4152-am-subjects.sh        |  2 ++
 t/t4254-am-corrupt.sh         |  2 ++
 t/t4256-am-format-flowed.sh   |  1 +
 t/t4257-am-interactive.sh     |  2 ++
 t/t5003-archive-zip.sh        |  1 +
 t/t5403-post-checkout-hook.sh |  1 +
 14 files changed, 105 insertions(+), 26 deletions(-)

-- 
2.39.0.rc2.1048.g0e5493b8d5b

