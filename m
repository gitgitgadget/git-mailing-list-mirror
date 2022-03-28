Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181A3C433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 19:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245233AbiC1TNG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 15:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiC1TNF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 15:13:05 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B44966AFD
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 12:11:24 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id u22-20020a170902a61600b00154adad001bso6407975plq.10
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 12:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=lBeuIsWUP+123OGlMhB6j5gw11BgmhjFardpzTOS8QI=;
        b=WU3+VfaIW01WmekgeCqyXp9hFoqDbVN6nrdp9lA+jhYyuIz6qb87fpoXXyNhQ/1n+2
         9dMNK+HUNTvQ+M/lcCgmy8qtqnPJwOvGVorm2pWEmO0IDhKgHz6N9LXOl17IRISa5DbU
         9G3dV4D+cFnEa9JWP22bqJl2k8xbHPhE0Y+RN4jIIacNVmp9f3IxB4fJjLayLi9mImbN
         2kSPrDMbNifhRwWHL7Yyv0G7Fl2p2ju1en3Ep2obw+L3FcjCvmVuLFgXIVlNJ+htiU0i
         Y/Nj8chgZ33WUeRu/yioDFtBrZekG1nKli9ZqacEq/4UpUDnWs1l7jQVjJURBHz1VXgl
         IFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=lBeuIsWUP+123OGlMhB6j5gw11BgmhjFardpzTOS8QI=;
        b=FElO92/pA3tFpAcgjGmRFzokqjFnX1Sq7c75ZkRpvnYTwdnDGiwX/Cdt3q4TRwNyq7
         yMC3b4+DoL79fAABmT6K0dhjGry5X8muYz2bYPMeWlvXY74CCRXy4rflbuwFqib0XQvE
         yo0mPFdTIcK1XKx1C2kmu+QDYkFfAOmFerFhGC37hvyfKFncrG0f3MElNzM175AKJEhc
         9XJ7k4Dh3ppDVReHWthy6XmmqJIkmhGkCiLy9k4G8DQxCEMBhgBmFO4hdJzL5mhAl1ws
         zVXU2zSruf88YTocZgklziWdtKx78DW4WAxOK9DFFQMWxDbbL4LnnJJQG5r5CeT6Wg9O
         reOA==
X-Gm-Message-State: AOAM533e+UIzsBrBppy2TDOrta6c9UKcYNU1d3E9evPeMFrS/c/KgUEA
        dRxr7JuKbfU/64TjW7czkGhy1Ui1FzX7lrf9fVMJo3q2NmJkLb87wflqMWMxnsRfHThuQEaSlaE
        XBeQ6wFIqY98fE2zJU/+CI+g0UJ4sxCFLrSV8P5OYEwjoNDHFeSfOHQJjOUMGoymAMQ==
X-Google-Smtp-Source: ABdhPJwLyvAVvQ/cZbUEeVPuEtIK2wmZjWb0VUSxthT7c0a+jYNpgWZj/8TCBVl6+Z6nqdjpI3Rr1Bm3950SKe0=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90b:38d2:b0:1c6:fa94:96bb with SMTP
 id nn18-20020a17090b38d200b001c6fa9496bbmr637015pjb.206.1648494683304; Mon,
 28 Mar 2022 12:11:23 -0700 (PDT)
Date:   Mon, 28 Mar 2022 19:11:09 +0000
In-Reply-To: <20220208235631.732466-1-calvinwan@google.com>
Message-Id: <20220328191112.3092139-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20220208235631.732466-1-calvinwan@google.com>
X-Mailer: git-send-email 2.33.0.664.g0785eb7698
Subject: [PATCH v3 0/3] object-info: add option for retrieving object info
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, philipoakley@iee.email,
        johncai86@gmail.com, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes it is useful to get information about an object without
having to download it completely. The server logic has already been
implemented as =E2=80=9Ca2ba162cda (object-info: support for retrieving obj=
ect
info, 2021-04-20)=E2=80=9D. This patch implements the client option for it.

Add =E2=80=98--object-info=E2=80=99 option to fetch. This option allows the=
 client to
make an object-info command request to a server that supports protocol
v2. If the server is v2, but does not allow for the object-info
command request, the entire object is fetched instead and the relevant
information is returned.

Patch 1 is a small refactor. Patch 2 adds a config option for
advertisement of object-info.  Patch 3 is the main implementation of
fetch object-info.

Major changes since v2:
 * Added a fallback for servers that do not
   allow object-info
 * Refactored the fetch object-info code by moving it to fetch_refs in
   the vtable rather than having its own function in the vtable. This
   allows for the code to easily transition to the fallback if
   object-info fails.

Calvin Wan (3):
  fetch-pack: refactor how packet is written to be more generic
  objectinfo.advertise: add config option to advertise object-info
  object-info: add option for retrieving object info

 Documentation/config/transfer.txt |   4 +
 Documentation/fetch-options.txt   |   5 ++
 Documentation/git-fetch.txt       |   1 +
 builtin/fetch.c                   |  36 +++++++-
 fetch-pack.c                      |  66 ++++++++++----
 fetch-pack.h                      |   9 ++
 protocol-caps.c                   |  11 +++
 protocol-caps.h                   |   6 ++
 serve.c                           |   2 +-
 t/t5583-fetch-object-info.sh      | 138 ++++++++++++++++++++++++++++++
 transport-helper.c                |   8 +-
 transport-internal.h              |   1 +
 transport.c                       |  75 +++++++++++++++-
 transport.h                       |   9 ++
 14 files changed, 349 insertions(+), 22 deletions(-)
 create mode 100755 t/t5583-fetch-object-info.sh


base-commit: f01e51a7cfd75131b7266131b1f7540ce0a8e5c1
--=20
2.33.0.664.g0785eb7698

