Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF0CC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 05:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A66D9610C8
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 05:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhIBFbi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 01:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhIBFbi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 01:31:38 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DB9C061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 22:30:40 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id b4so641433qtx.0
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 22:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wYR7O+AnS8cyPo5wZF3pgpSQ1a0/e5/UNShfy/CPxTQ=;
        b=dMMRba/M6g+M67lf5A4EUACIKS6tvYo/DScSxHLVcEbf5izKgE7euLi4fJiJR3gd2l
         +joOcZSw4Q4UMjtYqhhFmO2GAokMMfbRv5P7CA91PBfILD35apo04AmLHsa/Sw5foN/T
         zsz+vNJ7yIJFbOyNYaCEWp5o/ClQGPWqmwXtHeFdAjwBpPQO/B2rJ6Wi3nBz7MJHGOfb
         yfjvl/gmj5L/rt/VfitVpC2zrhk44WxGWpSl3mryneJq3RvHNrwcHLzbYXJPWbAUIL5z
         R8PGPtGHH6axwy1gELrGcZkyLELfGrXtt2UgWv8W8PV2191u/irzdIbcCB4smdwFVQ82
         obgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wYR7O+AnS8cyPo5wZF3pgpSQ1a0/e5/UNShfy/CPxTQ=;
        b=q80t1Kp/1PsStgzVQuFoMpIP1xolxzLXAczwK0mxpnD/TrF2vsMbq/33SNnkSRd86M
         jPzQrD660SeZvPpbkuwhLgobzA+k73FeJ/GWBnEOnp19J+YW1Q32XcEH5Sut4CRxeJbQ
         wDFJo+ALq9uHvN3pIU5KGB6CuJ7s6XSJH40Ti0ss4/Z/3F2IdfIKXjDJYbrHzxM7pxmG
         vMMV2ZKNTu50KnTNpcRNGEITOEDcDQockKrE7b0a9G5YIsurevDlJC9HexizXwl05+f2
         2yX7tiIE8GHVCBJpcRXuIpwyjcyyQUbtxOk25fbKmzXzccoWU5LRUAo+SgmrM/fRBn1m
         2xTA==
X-Gm-Message-State: AOAM533wOdkScfigLJzEiGvsqYWiiLLZc/w9fl2facW7zbSBpSVko8oS
        KzNgw7kTlybRbY2g97xVnfoCOiR97S0=
X-Google-Smtp-Source: ABdhPJxo9DO0UO7v32TXX02kShav9B6QSg4BPF0Ji5Qci5heJYCJeDMiywxmtCksD4DJPRfqE8cD9Q==
X-Received: by 2002:ac8:5a51:: with SMTP id o17mr1358852qta.386.1630560638996;
        Wed, 01 Sep 2021 22:30:38 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id w19sm669346qki.21.2021.09.01.22.30.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Sep 2021 22:30:38 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 0/3] hn/reftable: fixes for building with -DNDEBUG
Date:   Wed,  1 Sep 2021 22:30:20 -0700
Message-Id: <20210902053023.44006-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

they are all based against the last reroll for that topic in "seen"

they all introduce the use of a macro from git (MAYBE_UNUSED) that
hopefully is not controversial (ex: when applied to libgit2) as other
git-compat is already in use.

they are named so they could be easily squashed into their corresponding
patches, but at least the third one needs some further evaluation, where
the code in the assert gets removed and with it the whole function
becomes a NOOP, even if the tests still pass.

there is also an additional fixup for supporting OpenBSD 7 (now in beta)
that will be sent independently; sorry for the noise

Carlo Marcelo Arenas Belón (3):
  fixup! refs: RFC: Reftable support for git-core
  fixup! reftable: add merged table view
  fixup! reftable: add a heap-based priority queue for reftable records

 refs/reftable-backend.c | 5 +++--
 reftable/merged_test.c  | 8 ++++----
 reftable/pq.c           | 2 ++
 3 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.33.0.481.g26d3bed244

