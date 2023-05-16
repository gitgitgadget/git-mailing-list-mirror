Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8774C77B7F
	for <git@archiver.kernel.org>; Tue, 16 May 2023 08:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjEPIXo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 04:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjEPIXm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 04:23:42 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24B119A7
        for <git@vger.kernel.org>; Tue, 16 May 2023 01:23:40 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-6439f186366so8866288b3a.2
        for <git@vger.kernel.org>; Tue, 16 May 2023 01:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684225420; x=1686817420;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HxHkPJ3/ASboh1CH2lj0ze8IEUf7Cslpxz310wu6Duc=;
        b=RDoVjbOYrSqRp1dIucPcjtQKCya/B0xetMWtpa2u45FuwY2bDQXNdpy8LOfZSAPV4c
         sKbGWZuF9KXahjzw3fxEQ05hUR/BY5CLLJt2ejpWEYcWwA/zXwsQtjMUzwUWiSCC1kmM
         Th4Q8UHd4b0zk0dW86Y/VNdExFSXVpkYtOWVs9gITgfw9wXsiIw3uwoKshIdnpfSZ822
         8r+TWHK7R4gshhN2qc3sbusg9NDwCpCezGYEDGZRC7w9pAJKBjSQl+UcCtUt4MXnv3+N
         u8vCIIbPuoRYfZ03gF6U7iHwZvquK0QlvLrzj+LQkveh4vfefIBD4yIZhh/9STsS1wCt
         6gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684225420; x=1686817420;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HxHkPJ3/ASboh1CH2lj0ze8IEUf7Cslpxz310wu6Duc=;
        b=juadrGsIgcVQ8UEwTPqVZscUPCQftEcXseVCbtPngCykvg2GPw3bC8KwyNoC4ic6eF
         Kj8XkeWMzH06BpiYOS2JO0xlJihGOsIIZhkcl4X4KfaejZk7Uh8b92GAnnxV0So5DPIp
         GH7Kl+bKE9v6njnHmNGE3e2uSbfx8D7hYyzWYU6ccZ4BPSx5IKyoDOmOnMOwEcS60dh8
         ednq1eo/OIjajQZFyp1+BujL+z+SnngKBDVFSyKMxkr0FK0RIRFN2qcP0Jr3lkcVXHBB
         VjUY+rhqLs2yCAplWIGnQUvLcW6QL+G7djkI9gg/3URgkU1Eg3xyzDoVFNczL1u1BS+2
         fDKA==
X-Gm-Message-State: AC+VfDzVaRdwwQdIGTc7PK5tRG/aRfdU4sp5zgM5+DGH6WEFQwW16n+J
        VSfUmtwXQf8hQFeccKZzD8LzQpKv2DyzJ9nE1Fb7OFSKlfgRyDCHqw0=
X-Google-Smtp-Source: ACHHUZ6S0U84p4i53vr1Kj8CXIpOLWulrxeisp2SS8Nh3CpEitAoPcyGGndrFcbbdhMB5wCa/UT5daebB8oPQAE225I=
X-Received: by 2002:a05:6a20:3d95:b0:106:57b9:6da1 with SMTP id
 s21-20020a056a203d9500b0010657b96da1mr5873469pzi.20.1684225420383; Tue, 16
 May 2023 01:23:40 -0700 (PDT)
MIME-Version: 1.0
From:   Tribo Dar <3bodar@gmail.com>
Date:   Tue, 16 May 2023 08:23:29 +0000
Message-ID: <CACJVABb6s+dH8CPs1-OGgwRwgyRRSMnenLCenBScis=ADUUuDA@mail.gmail.com>
Subject: [BUG_REPORT] `git submodule update` segfaults
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)
Ran `git submodule update` after commenting out the url field in both
.gitmodules and the corresponding section for the submodule in .git/config.

What did you expect to happen? (Expected behavior)
Graceful handling of the situation.

What happened instead? (Actual behavior)
Segmentation fault.

Anything else you want to add:
The segfault results from `sub->url` being NULL here (actual segfault
comes a couple calls further):
https://github.com/git/git/blob/0df2c180904f6b709766f9c24669a9d01543f915/builtin/submodule--helper.c#LL2027C1-L2027C1

Possibly relevant: a similar snippet being properly protected against
null-pointer dereferencing:
https://github.com/git/git/blob/0df2c180904f6b709766f9c24669a9d01543f915/builtin/submodule--helper.c#L1243
