Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86439C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 14:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3767723119
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 14:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isZGaJDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgI0OSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 10:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgI0OSg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 10:18:36 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64CDC0613CE
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 07:18:35 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id q123so1779875pfb.0
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 07:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rq0YjgOJ4+/4c997vgebUUYrN9mwxLO76eoGAw8AGd0=;
        b=isZGaJDOxBM5GeWVyzWPPLRXY6NjSt7X5uDYqVBgGxJjI3z2c4Wbr3J/8HM0bVMHBS
         01H4xksWc0GcyUyHuWAtBG299Ujugp1OdW9bwdMOjFkjwquJ2e767notr3R6dYqZ+DzI
         PxrrI7rUDrzT3xmlmscRCxlrEVRWRPJiUvyqHakmweLk18RKQgZcI6Lwsn6oxhmF7VrW
         Zu5SGmyGoDKmzc7EZMOPrdaJSyJMd9sGqA3X61S+S33piGJbw1wdbaLEK/rUkY+nTOnl
         x4u0qO6GhzBjZY3tMDRNzRk97EV9XuGI+4ncBgqTUEN3evwWBNKN/dobfMxeWOajBk4I
         wM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rq0YjgOJ4+/4c997vgebUUYrN9mwxLO76eoGAw8AGd0=;
        b=r8XmZ4UY7SGRxb19KEyLAJQ+Cm6AOWPw4H6cEpK3a3m2C9fu5ouZ8eUapsdxKtD3g9
         1FgcUyEXjig1u97El6Bm3P9+ENG4ckxDY1ovazEF4PeQ8bnIt+TenFF+Fyi/rWP+0vwd
         0kkFxY8coFU4LIkx3H+IgCZxyhAd78Qv5E0rbq/M9Lum6a41QunmBAFBnIKHXomY5vzc
         kOv8gzA3dmxk1XUYtVnzyWGG9gNA+7c1p9sSXzW6Ijfbcx/mJ1KtKv0RdRqhTskQr2KO
         GnDdh+S1v6vCTDTnzXE44/E2lx60ehDL0Z1g+sS0EQdkaOItgCuA9DNwh3fldipST1Rm
         g68w==
X-Gm-Message-State: AOAM5302RENy/rq4O3Ek8hYfQ0IsTAQ26TPeKTUs7bX7a5djCYfBPWtu
        Yy2aPCC0QDYeoDM5sJ0Um1TRmoQCxGA3rDyl
X-Google-Smtp-Source: ABdhPJyKT/Ic+FoGFQQ4NYJ3YQGk+kSPBdHXuJyfdeT9GLDkCX7YPwUTZny7GmNA+cl3/th69WZ+qw==
X-Received: by 2002:aa7:9583:0:b029:142:2501:396a with SMTP id z3-20020aa795830000b02901422501396amr7234901pfj.47.1601216314691;
        Sun, 27 Sep 2020 07:18:34 -0700 (PDT)
Received: from localhost.localdomain ([124.123.106.216])
        by smtp.gmail.com with ESMTPSA id d17sm8377799pfq.157.2020.09.27.07.18.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Sep 2020 07:18:34 -0700 (PDT)
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v8 0/3] push: add "--[no-]force-if-includes"
Date:   Sun, 27 Sep 2020 19:47:44 +0530
Message-Id: <20200927141747.78047-1-shrinidhi.kaushik@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200926114626.28823-1-shrinidhi.kaushik@gmail.com>
References: <20200926114626.28823-1-shrinidhi.kaushik@gmail.com>
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
the "<expect>" value, can cause the update that happened in-between
the checkout and forced push to be lost.

Changes since v7:
  - Clean up the way batching is done for "in_merge_bases_many()".

  - The timestamp check during "reflog" iteration has been moved
    to the end of the function because we should stop collecting
    entries older than the current one (i.e., in the next round).

  - Add a test case to show deletes should be allowed with the
    new option.

  - Minor changes to comments and function names.

Srinidhi Kaushik (3):
  push: add reflog check for "--force-if-includes"
  push: parse and set flag for "--force-if-includes"
  t, doc: update tests, reference for "--force-if-includes"

 Documentation/config/advice.txt |   9 +-
 Documentation/config/push.txt   |   6 +
 Documentation/git-push.txt      |  26 ++++-
 advice.c                        |   3 +
 advice.h                        |   2 +
 builtin/push.c                  |  27 +++++
 builtin/send-pack.c             |  12 ++
 remote-curl.c                   |  14 ++-
 remote.c                        | 188 ++++++++++++++++++++++++++++++--
 remote.h                        |  12 +-
 send-pack.c                     |   1 +
 t/t5533-push-cas.sh             | 140 ++++++++++++++++++++++++
 transport-helper.c              |  10 ++
 transport.c                     |   8 ++
 transport.h                     |  15 ++-
 15 files changed, 455 insertions(+), 18 deletions(-)

base-commit: 9bc233ae1cf19a49e51842c7959d80a675dbd1c0
--
2.28.0
