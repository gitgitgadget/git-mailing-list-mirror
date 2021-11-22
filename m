Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5057C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhKVWgN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhKVWgN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 17:36:13 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6596AC061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:33:06 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id e7-20020aa798c7000000b004a254db7946so10554190pfm.17
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=yktJoZGKDNabWxXU6fDhVYSO9Pf+OZ/PUk0YftjXUvQ=;
        b=NIeapA5UvvG8N1SDHsD49m2yH4XZqg3PnZJvFpVBIj160TKx7vZJikEwBwJefE8dnU
         NlhmiGigzm6AFghcyAKTfric4myIcNLao3EYE4lAFHBXtwD7kw98gKWUSAeFm/vjN54/
         EmZfGcmU6ei3nW5ftA0RD9NcP7wcbec3rdQNoNHRrHAA2RuxJhE0KcDVNCHkXXhjWW41
         QtLkMuPRayVC9M+iixuSgiM+v//xY6zWzJ1BdLdOI64FHPywJdTXicPT33JNr7iVuboQ
         kNoysDK/n1rnC+il3cgHN/NSHN3nQFEXioOwGU+xw6JGGovr1p8tDsLix5/VqPy9gqvn
         p9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=yktJoZGKDNabWxXU6fDhVYSO9Pf+OZ/PUk0YftjXUvQ=;
        b=z5GwvfOSu03do9K/fDZUxKMR2tMPWwYC2oNrjoa03OF/ULn15zmLCnk/07Qx5XeKoU
         4aZaXxfmzmCmeLtt9tRK0RpdesDv46K2xGIPKZ45skTCWYkfibUP2vQhE+on410qPJYY
         s1Hz65QMNLMm7sYIxJTtrMOG24B3smc+HyZf+ncEDCtxbPoFfURVb/xJKwGg1EMwaS/3
         SnU9tlcEzRqxIKpIVMBXkpAzxe9R4Gn+t63nXMjDrHINlnqNzP8exO5veicuQ6Vd+rwg
         WbAZI445heWggSy10TdNJyo1KqEh1sPev+Xq+r+QrsKecpE6kFqNz0n+gvk8Eu3m3UDC
         j22g==
X-Gm-Message-State: AOAM533fg78Y4oHPHocOVeuhGkNMLU9DZtZltppGM1+cOGVXpy8VyBjt
        14AYRVwdhKDBjJqztBiQCCyBUQ+qKGPlkjDQArK/fA4VJ117SWMpQ07PG6/1Uq9uK5/uxwDxNiq
        rGQ/BPxuzQES5CYy3HjoxhdJsED0rN2rkBkmgUHObjaJYGQ7jaoalg8vxVOxxDeA=
X-Google-Smtp-Source: ABdhPJwPh53vOlc0LIYkHN405qYNzwAF756qAR1mdXAgl51oU2JgnYpDUNG34GidByPqObYSKzKbhsjkvDqRrw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:fe85:: with SMTP id
 co5mr35899763pjb.110.1637620385813; Mon, 22 Nov 2021 14:33:05 -0800 (PST)
Date:   Mon, 22 Nov 2021 14:32:48 -0800
Message-Id: <20211122223252.19922-1-chooglen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH 0/4] implement branch --recurse-submodules
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Submodule branching RFC:
https://lore.kernel.org/git/kl6lv912uvjv.fsf@chooglen-macbookpro.roam.corp.google.com/

Original Submodule UX RFC/Discussion:
https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/

Contributor Summit submodules Notes:
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2110211148060.56@tvgsbejvaqbjf.bet/

Submodule UX overhaul updates:
https://lore.kernel.org/git/?q=Submodule+UX+overhaul+update

This series implements branch --recurse-submodules as laid out in the
Submodule branching RFC (linked above). If there are concerns about the
UX/behavior, I would appreciate feedback on the RFC thread as well :)

This series uses child processes to support submodules. I initially
hoped to do this in-core and [1] and [2] were meant to prepare for that.
But even though in-core is tantalizingly close, [1] showed that there
is more work to be done on config.c before this is possible, and I would
like to get more feedback on the UX before converting this to in-core.

[1] https://lore.kernel.org/git/20211111171643.13805-1-chooglen@google.com/
[2] https://lore.kernel.org/git/20211118005325.64971-1-chooglen@google.com/

Glen Choo (4):
  submodule-config: add submodules_of_tree() helper
  branch: refactor out branch validation from create_branch()
  branch: add --dry-run option to branch
  branch: add --recurse-submodules option for branch creation

 Documentation/config/advice.txt    |   3 +
 Documentation/config/submodule.txt |   9 +
 Documentation/git-branch.txt       |   8 +-
 advice.c                           |   1 +
 advice.h                           |   1 +
 branch.c                           | 300 +++++++++++++++++++++--------
 branch.h                           |  41 +++-
 builtin/branch.c                   |  77 ++++++--
 builtin/submodule--helper.c        |  33 ++++
 submodule-config.c                 |  19 ++
 submodule-config.h                 |  13 ++
 t/t3200-branch.sh                  |  30 +++
 t/t3207-branch-submodule.sh        | 249 ++++++++++++++++++++++++
 13 files changed, 678 insertions(+), 106 deletions(-)
 create mode 100755 t/t3207-branch-submodule.sh

-- 
2.33.GIT

