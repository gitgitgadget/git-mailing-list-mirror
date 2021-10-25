Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC96C433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 21:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4166E61073
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 21:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbhJYV2c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 17:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbhJYV2a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 17:28:30 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5D1C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 14:26:07 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id y78so6694688wmc.0
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 14:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i0KwojNWAiDCodbnIGNhZ3shxuM2FiEwGFtvUgNPulI=;
        b=K/+CvHxkut81AFbSzQ2Vk9k8Xe5+9dn3ojw5DAkDnExmX47M+kCOXAGlZA/AmDfVKY
         ZDIq/zxuwhdT3H/QaeaE7Ov9jg+hVGh8tzUvH6mO7ARgCLaO19+SiJXOmABO08ttWt9G
         35+TTpWKcPUrvpkBrnqr9eUI3L/f+J+tRcqMg4KUBZ7NkZs0HOMtQ3fyv+Z7Ri77Ay8i
         B6G5NeaySl3jgHupeaq1bQPAVEwbd2X+45CWquMqHnY3HM9lblLTGqtO/e1McuRTH6ON
         l5gmys30V1MAuy+FaNZ12Ol9W/XM5QiRwjbZjQBdb2bDRtAoA2aIDs0OgXUwuMZJuBwf
         UATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i0KwojNWAiDCodbnIGNhZ3shxuM2FiEwGFtvUgNPulI=;
        b=UIXpMIR2fN0jSP+AgaJpYO3e9YEPGntY2mz+zK3Ze/xbCVXNxyKhB0bQphRGA1Ivt8
         qE5KzGahr/6xR1F0nRPbU8pHKbe8uoOElD3o/hZkjnkqzlHP2dcyGcBGYBpg5OKonSAH
         yW/7ci9kLYDGmMJZNkKodEQ1wmf1+d9YQOC13YbrLa+UE3Io8yDAabZq1H+JiWYpj1Hj
         t6XukVCKrd1y6j2qG1DigkcxSuOWDNNAmD6QF0pwVkcXVxHLJwCytQLJ8C/iZVclORT4
         OAhT1kitwCwxcVEaSXW7J5ZH6Qno35m3Dfgwx9yW73KmAm+J1x4cV1htd4lFyglNYAw4
         v1Kg==
X-Gm-Message-State: AOAM530yrFhkBiydq2N91jY/NCpfxuvEQJMC3oHAjf2p2oJUjJSvRz5m
        0I00lMiY4aovZh4Pmw45yK/mg1qKKgTPGg==
X-Google-Smtp-Source: ABdhPJzsQYp40SnFMjGwVqBw9kubFMeKw4Hj/FMVY5ZOex6cY1FIw6d0Wvxb9ykCTntbeJcxkDgszg==
X-Received: by 2002:a1c:f405:: with SMTP id z5mr22747857wma.72.1635197165949;
        Mon, 25 Oct 2021 14:26:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m15sm17972784wmq.0.2021.10.25.14.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 14:26:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] bundle-uri: "dumb" static CDN offloading, spec & server implementation
Date:   Mon, 25 Oct 2021 23:25:43 +0200
Message-Id: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1511.g4a4db174869
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This implements a new "bundle-uri" protocol v2 extension, which allows
servers to advertise *.bundle files which clients can pre-seed their
full "clone"'s or incremental "fetch"'s from.

This is both an alternative to, and complimentary to the existing
"packfile-uri" mechanism, i.e. servers and/or clients can pick one or
both, but would generally pick one over the other.

This "bundle-uri" mechanism has the advantage of being dumber, and
offloads more complexity from the server side to the client
side.

Unlike with packfile-uri a conforming server doesn't need produce a
PACK that (hopefully, otherwise there's not much point) excludes OIDs
that it knows it'll provide via a packfile-uri.

To the server a "bundle-uri" negotiation the same as a "normal" one,
the client just happens to provide OIDs it found in bundles as "have"
lines.

In my WIP client patches I even have a (trivial to implement) mode
where a client can choose to pretend that a server reported that a
given set of bundle URIs can be used to pre-seed its "clone" or
"fetch".

A client can thus use use a CDN it controls to optimistically pre-seed
a clone from a server that knows nothing about "bundle-uri", sort of
like a "git clone --reference <path> --dissociate", except with a
<uri> instead of a <path>.

Need re-clone a bunch of large repositories on CI boxes from
git.example.com, but git.example.com doesn't support "bundle-uri", and
you've got a slow outbound connection? Just point to a pre-seeding CDN
you control.

There are disadvantages to this over packfile-uri, JGit has a mature
implementation of it, and I doubt that e.g. Google will ever want to
use this, since that feature was tailor-made for their use case.

E.g. a repository that has a *.pack sitting on disk can't re-use and
stream it out with sendfile() as it could with a "packfile-uri",
instead it would need to point to some duplicate of that data in
*.bundle form (or on-the-fly generate a header for the *.pack).

The goal of this feature isn't to win over packfile-uri users, but to
give users who wouldn't consider it due to its tight coupling to have
access to CDN offloading.

The error optimistic recovery of "bundle-uri" and looseer coupling
between server and CDN means that it should be easy to use this for
use where the CDN is something like say Debian's mirror network.

We're coming up on 2.34.0-rc0, so this certainly won't be in 2.34.0,
but I'm submitting this now per discussion during '#git-devel' standup
today.

There was a discussion on the RFC version of the larger series of
patches to implement this "bundle-uri"[1].

I've updated the protocol-v2.txt changes in 2/3 a lot in response to
that, in particular I've specified and implemented early client
disconnection behavior, so bundle-uri SHOULD never cause
client<->server dialog to hang (at most we'll need to re-connect, if
we need to fall back from a failed bundle-uri).

1. https://lore.kernel.org/git/RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (3):
  leak tests: mark t5701-git-serve.sh as passing SANITIZE=leak
  protocol v2: specify static seeding of clone/fetch via "bundle-uri"
  bundle-uri client: add "bundle-uri" parsing + tests

 Documentation/technical/protocol-v2.txt | 209 ++++++++++++++++++++++++
 Makefile                                |   2 +
 bundle-uri.c                            | 179 ++++++++++++++++++++
 bundle-uri.h                            |  30 ++++
 serve.c                                 |   6 +
 t/helper/test-bundle-uri.c              |  83 ++++++++++
 t/helper/test-tool.c                    |   1 +
 t/helper/test-tool.h                    |   1 +
 t/t5701-git-serve.sh                    | 125 +++++++++++++-
 t/t5750-bundle-uri-parse.sh             | 153 +++++++++++++++++
 10 files changed, 788 insertions(+), 1 deletion(-)
 create mode 100644 bundle-uri.c
 create mode 100644 bundle-uri.h
 create mode 100644 t/helper/test-bundle-uri.c
 create mode 100755 t/t5750-bundle-uri-parse.sh

-- 
2.33.1.1511.gd15d1b313a6

