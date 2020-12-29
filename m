Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F8DC433E0
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 23:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B28207BB
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 23:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgL2XzG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 18:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgL2XzG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 18:55:06 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C59C061799
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 15:54:26 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id o13so34283662lfr.3
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 15:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5scCbWUr3ARvHY1Ww9lcK2x7dJ9LIxVtOZLspivhGDc=;
        b=eLLot0e53cxxXvKjsOgbKyxUKhyqyNEWF72QPSkIXxG3XwXV4mWiVj0cFVIhMnuQzY
         3GqLfYerxB3xTd6rjLBkp9rxLjSnN1MKkfzOWsnmxNf5ZWw77TkGe1m69TDnxIRniEla
         MdUatGpzPcb1mYTyED2lT9bqZgTJwupUtunKOKtWsuZ2FXSz3H0KV3u2CwSuOqZuFpCX
         TElKEyPvEwm4hi0TfyErVD3v3xf9Oh65T9w72SWyIP3MFuGCufC5A2QBQ0bL2tjFYH+h
         mO7bEcL15ALyV15r64t2q33TByVDBqfsNCzxBF6N2nODghPDw6YIi9IRUnM9JjFJHSSy
         LTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5scCbWUr3ARvHY1Ww9lcK2x7dJ9LIxVtOZLspivhGDc=;
        b=FUsdwcZGY09t+pUeQdDyOHhcQUMriA5QkwW4sAnyjmpFuWBFLIlz1dYarHhlOWHlGC
         eTRDmlvqGyTLi0uvZ0qulVMTat2qCwLBgiftyidt2KFfq6hnUrCHKu/BVq7aTv+gX3Yo
         TPadtowm1RXEsz63H38LrInQMERxkg57mcoFt5ee1Pl9QsiPsU/Qr4+qPfg+mDIluy5p
         d9sHL4nWps+EA6EkJ7Le3opmulI/QsDBa56qpb1t2tzGo33Z4mlgXGeBZq+KJDbHTkKU
         U9WcbuBPWf2+4RbrNXCGHicinqlHLreK5Qru3WZ6IexE70QksFDtH8j6VAlueUHaR3y0
         uCTw==
X-Gm-Message-State: AOAM5322fBCfCIi5ATyNkuKgZQjDu+wC2Sb0kpaAhKiFhawzUckTnLyp
        BdFKgoLCD3b6qUpd9Pe6cfBlIYjcG4o=
X-Google-Smtp-Source: ABdhPJxn8sV+Gj6+2yKr61Eymu56zWXRo2yTHDpyc7h40e83R3rE4h+/uFNuq/XJVIA2QFPDB5Q6ug==
X-Received: by 2002:a2e:b4ab:: with SMTP id q11mr24352780ljm.129.1609286064250;
        Tue, 29 Dec 2020 15:54:24 -0800 (PST)
Received: from localhost.localdomain (78-66-223-148-no2204.tbcn.telia.com. [78.66.223.148])
        by smtp.gmail.com with ESMTPSA id q25sm5777240lfd.282.2020.12.29.15.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 15:54:23 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 0/4] rename "sha1-foo" files
Date:   Wed, 30 Dec 2020 00:52:56 +0100
Message-Id: <cover.1609282997.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have some source files with filenames such as sha1-lookup.c and
sha1-name.c containing a few variable names, comments and the like
referencing "sha1". But they are able to handle SHA-256 as well. Here's
my attempt at removing "sha1" from the contents and names of these
files.

Martin Ågren (4):
  object-name.c: rename from sha1-name.c
  object-file.c: rename from sha1-file.c
  sha1-lookup: rename `sha1_pos()` as `hash_pos()`
  hash-lookup: rename from sha1-lookup

 t/oid-info/README              |  2 +-
 sha1-lookup.h => hash-lookup.h | 14 +++++++-------
 bisect.c                       |  2 +-
 builtin/index-pack.c           |  2 +-
 builtin/name-rev.c             |  4 ++--
 commit-graph.c                 |  8 ++++----
 commit.c                       |  4 ++--
 sha1-lookup.c => hash-lookup.c | 22 +++++++++++-----------
 list-objects-filter.c          |  2 +-
 midx.c                         |  2 +-
 sha1-file.c => object-file.c   |  4 ++--
 sha1-name.c => object-name.c   | 14 +++++++-------
 oid-array.c                    |  4 ++--
 pack-bitmap-write.c            |  4 ++--
 packfile.c                     |  2 +-
 patch-ids.c                    |  2 +-
 rerere.c                       |  4 ++--
 Makefile                       |  6 +++---
 18 files changed, 51 insertions(+), 51 deletions(-)
 rename sha1-lookup.h => hash-lookup.h (72%)
 rename sha1-lookup.c => hash-lookup.c (84%)
 rename sha1-file.c => object-file.c (99%)
 rename sha1-name.c => object-name.c (99%)

-- 
2.30.0

