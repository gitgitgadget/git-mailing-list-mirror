Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47783C4363D
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 07:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE975235FC
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 07:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbmtnsbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgIWHad (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 03:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgIWHac (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 03:30:32 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49505C061755
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 00:30:32 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id p15so10856562qvk.5
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 00:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8zxt1bkSVAQ5NGYUlniqLyZ1B5bzKSUih0nmWJWrSzw=;
        b=sbmtnsbHugbLXSHDYwXEy92UFiQT4dO87FqCQsU6dsiWBOR6JSgRAdBqZyLXa+69Ok
         56rcJzHKSulDID2o4+YkZx4FhiEkY81G6nlI+BehxceJsQ6I4/hZgLjCoMvpjSs7bMTK
         FN7rIZ85AoRp6x/xIG8mZbudWlPfTVivRbFp4+vngwAkUK5p+hberLuiGHN8U2Han4Qq
         qGhlXZp/wMG/GAyH7TxMyBGkMZMCQwSbcARaT5MudA4hpFFsIyzT8i4hNKs7JPQu0RYa
         Ae5OXCqO5IJTsFxyoPJpSgYHnRPxR4k7PIpgWDkZa+d03No3LSEhNmC67NWXnTvUZMgR
         9iPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8zxt1bkSVAQ5NGYUlniqLyZ1B5bzKSUih0nmWJWrSzw=;
        b=VFEu3dBLKHcvJ6uXcJ59cx8ZAI/R8mmR1BJB6lC2hQJuy4/ujl4BEWsY5HHoC56PJO
         8NBF2kF1HLyJ6XyBOwE0Y6HWHGWF0vvSbEtdRD4p8zW43XrS6w/9zszfSvHE2kQ4P7FR
         eFkOVNL5uQyr5DK85Lsk626H9T2wJs/6iJNMcZMi4RbOka/n+71ZdkixOK0HTAC8pwcG
         zWzvwh/AXGr0zKSlx1dZ1qKiCncNGu36AvkugkZD5Zz3Otqou5JuqPUJZa2nTTLiRzI9
         zLKGPdoRV75CpzeJAdys8YRy02RwlrdTj9xIRiO+OtOXbWqW9++K/DQVbIz/hta+orbg
         jvRQ==
X-Gm-Message-State: AOAM5312eknJr1VdZQQzFBYdHLmaxDf7FJ1N6r2KgwJnwBnDz3YMYI1U
        l1gvIVhvNBzB8plbLIP+DAEhzN8hmjIhONDwBzs=
X-Google-Smtp-Source: ABdhPJy2CZ7v5oJ80q843MdkiBoozMnoNihkg1t5aywiDcPaWPc7L2aBf1FyriKf6/zLeDpnm8Brsw==
X-Received: by 2002:a0c:e447:: with SMTP id d7mr9869911qvm.44.1600846231127;
        Wed, 23 Sep 2020 00:30:31 -0700 (PDT)
Received: from localhost.localdomain ([124.123.107.121])
        by smtp.gmail.com with ESMTPSA id i18sm6341138qka.50.2020.09.23.00.30.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 00:30:30 -0700 (PDT)
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v5 0/3]  push: add "--[no-]force-if-includes"
Date:   Wed, 23 Sep 2020 13:00:19 +0530
Message-Id: <20200923073022.61293-1-shrinidhi.kaushik@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200919170316.5310-1-shrinidhi.kaushik@gmail.com>
References: <20200919170316.5310-1-shrinidhi.kaushik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new option: "--force-if-includes" to "git-push" where forced
updates are allowed only if the tip of the remote-tracking ref has
been integrated locally, by verifying if the tip of the remote-tracking
ref -- on which a local branch has based on -- is reachable from at
least one of the "reflog" entries of the branch about to be updated
by force on the remote.

This option can be used with "--force-with-lease" with setups where
the remote-tracking refs of the repository are implicitly updated in
the background to help prevent unintended remote overwrites.

If a local branch is based on a remote ref for a rewrite, and if that
remote-tracking ref is updated by a push from another repository after
it has been checked out locally, force updating that branch to remote
with "--force-with-lease[=<refname>[:<expect>]]" without specifying
the "<expect>" value, can cause the update that happened in-between the
checkout and forced push to be lost.

Changes since v4:
  - Collect commits during the reflog iteration step and use
    "in_merge_bases_many()" once on the list of collected commits
    instead of using "in_merge_bases()" for every entry [1].

  - Include reflog timestamps to reduce the number of reflog entry
    iterations by stopping early if we see an entry that is older
    than the remote tip's commit date [2]. This, coupled with a
    single call of "in_merge_bases_many()" should help make the
    check faster [3].

  - Reword commit messages, documentation; add a note to explain
    when the option is a "no-op".

  - Fix a mistake in the test script (t5533).

Srinidhi Kaushik (3):
  push: add reflog check for "--force-if-includes"
  push: parse and set flag for "--force-if-includes"
  t, doc: update tests, reference for "--force-if-includes"

 Documentation/config/advice.txt |   9 +-
 Documentation/config/push.txt   |   6 ++
 Documentation/git-push.txt      |  26 +++++-
 advice.c                        |   3 +
 advice.h                        |   2 +
 builtin/push.c                  |  27 ++++++
 builtin/send-pack.c             |  12 +++
 remote-curl.c                   |  14 +++-
 remote.c                        | 140 +++++++++++++++++++++++++++++++-
 remote.h                        |   8 +-
 send-pack.c                     |   1 +
 t/t5533-push-cas.sh             |  53 ++++++++++++
 transport-helper.c              |  10 +++
 transport.c                     |   8 ++
 transport.h                     |  15 ++--
 15 files changed, 321 insertions(+), 13 deletions(-)

base-commit: 385c171a018f2747b329bcfa6be8eda1709e5abd

Thanks to Johannes, Junio and Phillip for continually suggesting
improvements and patiently reviewing the patch series.

[1]: https://public-inbox.org/git/xmqqft7djzz0.fsf@gitster.c.googlers.com/
[2]: https://public-inbox.org/git/f6bb2b1f-0f1b-f196-59f1-893580430cf2@gmail.com/
[3]: https://public-inbox.org/git/xmqqimc7ezk2.fsf@gitster.c.googlers.com/
--
2.28.0
