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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10E7C49EA6
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B367619A9
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbhFNKz3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbhFNKxF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:53:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EED1C0611FB
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:48:21 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c9so14013497wrt.5
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HlKUhK/9llxloVg55Ea6gUjqTAXdtbJDGg+uANzveWk=;
        b=X69PFOA+opBnobusURl9D+b7ZUq0D8sDPR+kyp1pZysh7sChF4FrGb35KptcYp5u2c
         VaYXLUl33fOI7wF+4bZiSB9eZ6vPAabsLwFXeXgtE96+H28gpxzgUvl9HyE9SRD7gkvA
         N+XFMhQm2GjgfDfrrplKsh4F3DGKOrzIlKMZi2yM2C6ciTR+qs9JJYU+MCmBtjKiufhL
         J28M90GKSchB7bah7V45a503CphG+r3bfNsQ2R38SdrTcS1O6hnGE+6q9LvLWs/RWZkf
         ZOXXMEald61nij62IrfkMphdz7Z6k6Y6SYOd2d7BvZlfWGbVoXa3C1vZ18D7308E8HYw
         pF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HlKUhK/9llxloVg55Ea6gUjqTAXdtbJDGg+uANzveWk=;
        b=bnNsx8GfnUi6ilp6eCJ51KigxYRTJ8d+chzmzp3+SpAv2E9YBg+cL2lpLQOfR9B+5U
         tj86nP+NaefP+NG83tE2Bb2XLbigqZwGiBSZ8tEWzRmqvWcazfzB1QOQL1Q7bAxpPVRQ
         pRsn2D364wdoAhRp2DB82Qwp6yHow/LQDQLDVyID7N3UE0lNvYzzoZV77rqb1or3TpP4
         ul+lgoW+55GdcV6OCsTRY2oOkpxucrk28P2V0Gzuom+2RmNYP9a5Xr5fOsXZIvyw4Cuc
         /C0/50itgIo4bt+Y48Kt6fAh6BiCJgTezlzXoDZI0RB9I0M4Dlrp7KQoKIkWGfwSlFho
         ko4g==
X-Gm-Message-State: AOAM532BD808ZcO+PlnUC9/lK57+iAOzEVRU0q7VJ4yhrFKo8RzZNnrn
        z3qPNjQl/m+h5SLCnYev6yaRUGEZ372Xfg==
X-Google-Smtp-Source: ABdhPJzRkGLPATUR7QrDYoQaiVL11n4gsUL3TsNddrtsO2j5peoDr2r95LiuKruKU5X3MrBXrfbdww==
X-Received: by 2002:adf:f711:: with SMTP id r17mr17754110wrp.69.1623667699476;
        Mon, 14 Jun 2021 03:48:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m23sm15153732wms.2.2021.06.14.03.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:48:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Ilya Bobyr <ilya.bobyr@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/8] test-lib tests: split off subtest code in t0000 into lib-subtest.sh
Date:   Mon, 14 Jun 2021 12:48:06 +0200
Message-Id: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This refactors the testing of test-lib.sh itself in t0000 into a
lib-subtest.sh, fixing duplicate setup, bugs and various shell nits
along the way.

This was waiting on my now-merged 2019256717d (Merge branch
'ab/test-lib-updates', 2021-06-14).

There's a conflict here with Felipe's proposed
http://lore.kernel.org/git/20210609170520.67014-1-felipe.contreras@gmail.com,
but it's just a matter of moving the fix around and solving a trivial
conflict. I thought it was better to submit this now anyway, while
this code is fresh in people's minds.

I'm hoping Felipe will take some variant of my
http://lore.kernel.org/git/8735tk22if.fsf@evledraar.gmail.com and
perhaps review this series & base his patch on top of these changes,
but alternatively they can go in independently with Junio solving the
conflict.

Ævar Arnfjörð Bjarmason (8):
  test-lib tests: move "run_sub_test" to a new lib-subtest.sh
  test-lib tests: split up "write and run" into two functions
  test-lib tests: stop using a subshell in write_sub_test_lib_test()
  test-lib tests: don't provide a description for the sub-tests
  test-lib tests: get rid of copy/pasted mock test code
  test-lib tests: avoid subshell for "test_cmp" for readability
  test-lib tests: refactor common part of check_sub_test_lib_test*()
  test-lib tests: assert 1 exit code, not non-zero

 t/lib-subtest.sh | 105 ++++++++++++
 t/t0000-basic.sh | 419 +++++++++++++----------------------------------
 2 files changed, 219 insertions(+), 305 deletions(-)
 create mode 100644 t/lib-subtest.sh

-- 
2.32.0.rc3.434.gd8aed1f08a7

