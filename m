Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF785C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 16:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiAEQd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 11:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241912AbiAEQdt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 11:33:49 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5328AC061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 08:33:48 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r17so84171878wrc.3
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 08:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iHHzHecnqyxwtHUBkUYNGbnb9p+0kYYjvjuKakFAD6U=;
        b=nI1cYpBGSmQRshjCmrzGFna26PpPgFWQ7X8f0S18tr8GyAl/8JjBNJ+vunUw5ZMDCI
         NZFMoIRRAWwAJXtLXdY2wLU/HcC0SpxugcmohqUlTHJ41bvg8rq+m2twIUXhEGjL+z6t
         fBO6llN3NqqpgdEZmXeNxlzkn3M1UpdAaBWpJzhiIJIMKHIJBPtU/uRjSDj50pm3G+HI
         m1WUmzFyvbnESYPWe2bruUeSaoHopg3w/wqq9nrhaGijexc9Jn1T2eSVJZ8dHEqXt8qX
         SwTekwmf6duDrvZRJSBLv1dTps91siVZoprwFAFfwJSMxTRwvpX5lA1oYLLIC+AjOvZg
         M81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iHHzHecnqyxwtHUBkUYNGbnb9p+0kYYjvjuKakFAD6U=;
        b=oQ04oi8tZBZ258g/ohGDdzXrpH6NE15HBoNC4EuibA7UGuImCBbpT9GZoBs27FxhJ3
         kG5qF6CP3zVq9JoTxrw3suZU5CM+XOBM2PgrqiZ42O+H740fMl+shUWOZx67Amiy5Hr4
         ZKhLODci+IcUCgNWrqt3DeHMGnFJhatZnHz28IB+sk/2t6B9W16xwhU9ty7kWEYE5BBI
         waYovO3/zQFjvHVjn11t/HPKU59P6+7t7EjE5bWYpeQfoKnerENNyOGndoTXJbSgv8eJ
         n9DSQ+ovB4pl2pb7uulcpT3LDIc5LEHCdH0Vu5n4yp1HXatW++kkRQRpLOB+8FYnPWer
         657Q==
X-Gm-Message-State: AOAM533Uun2Ae9SMSiMG1RuuhmRUrSNxOeKBtVbhXy2+CLQrv9HkI6a0
        kCKkULswnyo6mBzmE2PI6diS/RWkyH8=
X-Google-Smtp-Source: ABdhPJzcAWQ2JEZTkoL5qqPO05tLjchJ3sLEMUBCVV0+vwKiwUYzCpDo8yQFcbzxFF9Z6hkXBMDvzw==
X-Received: by 2002:adf:d1e2:: with SMTP id g2mr48582453wrd.179.1641400426475;
        Wed, 05 Jan 2022 08:33:46 -0800 (PST)
Received: from localhost.localdomain ([185.228.230.189])
        by smtp.gmail.com with ESMTPSA id u20sm3417515wml.45.2022.01.05.08.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 08:33:46 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 0/2] Introduce new merge-tree-ort command
Date:   Wed,  5 Jan 2022 17:33:22 +0100
Message-Id: <20220105163324.73369-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.34.1.433.g7bc349372a.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During the 2nd Virtual Git Contributors’ Summit last October, and even
before, the subject of performing server side merges and rebases came
up, as platforms like GitHub and GitLab would like to support many
features and data formats that libgit2 doesn't support, like for
example SHA256 hashes and partial clone.

It's hard for them to get rid of libgit2 though, because Git itself
doesn't have a good way to support server side merges and rebases,
while libgit2 has ways to perform them. Without server side merges and
rebases, those platforms would have to launch some kind of checkout,
which can be very expensive, before any merge or rebase.

The latest discussions on this topic following the 2nd Virtual
Summit[1] ended with some proposals around a `git merge-tree` on
steroids that could be a good solution to this issue.

The current `git merge-tree` command though seems to have a number of
issues, especially:

  - it's too much related to the old merge recursive strategy which is
    not the default anymore since v2.34.0 and is likely to be
    deprecated over time,

  - it seems to output things in its own special format, which is not
    easy to customize, and which needs special code and logic to parse

To move forward on this, this small RFC patch series introduces a new
`git merge-tree-ort` command with the following design:

  - it uses merge-ort's API as is to perform the merge
  
  - it gets back a tree oid and a cleanliness status from merge-ort's
    API and prints them out first

  - it uses diff's API as is to output changed paths and code

  - the diff API, actually diff_tree_oid() is called 3 times: once for
    the diff versus branch1 ("ours"), once for the diff versus branch2
    ("theirs"), and once for the diff versus the base.

Therefore:

  - its code is very simple and very easy to extend and customize, for
    example by passing diff or merge-ort options that the code would
    just pass on to the merge-ort and diff APIs respectively

  - its output can easily be parsed using simple code and existing
    diff parsers

This of course means that merge-tree-ort's output is not backward
compatible with merge-tree's output, but it doesn't seem that there is
much value in keeping the same output anyway. On the contrary
merge-tree's output is likely to hold us back already.

The first patch in the series adds the new command without any test
and documentation.

The second patch in the series adds a few tests that let us see how
the command's output looks like in different very simple cases.

Of course if this approach is considered valuable, I plan to add some
documentation, more tests and very likely a number of options before
submitting the next iteration.

I am not sure that it's worth showing the 3 diffs (versus branch1,
branch2 and base) by default. Maybe by default no diff at all should
be shown and the command should have --branch1 (or --ours), --branch2
(or --theirs) and --base options to ask for such output, but for an
RFC patch I thought it would be better to output the 3 diffs so that
people get a better idea of the approach this patch series is taking.

[1] https://lore.kernel.org/git/nycvar.QRO.7.76.6.2110211147490.56@tvgsbejvaqbjf.bet/


Christian Couder (2):
  merge-ort: add new merge-tree-ort command
  merge-ort: add t/t4310-merge-tree-ort.sh

 .gitignore                |   1 +
 Makefile                  |   1 +
 builtin.h                 |   1 +
 builtin/merge-tree-ort.c  |  93 ++++++++++++++++++++++
 git.c                     |   1 +
 t/t4310-merge-tree-ort.sh | 162 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 259 insertions(+)
 create mode 100644 builtin/merge-tree-ort.c
 create mode 100755 t/t4310-merge-tree-ort.sh

-- 
2.34.1.433.g7bc349372a.dirty

