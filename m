Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF477E95A91
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 10:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345957AbjJIKzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 06:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345822AbjJIKzl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 06:55:41 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC99AB
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 03:55:35 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-532c81b9adbso7630411a12.1
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 03:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696848933; x=1697453733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hc4v31B7BZ+unAODbPYjDOcoxCYyDHds2J7A0aemnHA=;
        b=b6VxSC3U1Hk2WVGaczC3DXPkLkNC6BlnftZBiRl25/++xtjjQVpkmfpEFH0RlOYajS
         IW96bb21J04Ji6h86cSRX+v635TDNcte4Ce9XAgDNAeut6DjS+jaqZ9tnPJ+LREbzq9Q
         Xdm7Rze0Pv18RrDdy0BYeSe9EIWZZvuaakUdHM2tdxjNLB2kd2n2x8AImROC321UKLxw
         CybSh/7MVRxgpP0i1fsYYpvZV/p72p0qjKfI3jKdVJQzrbEjIqfATLvuDa0jQrTDEPMn
         +qswP36+j9lKy49qk4wH5M7TLvAvQL9nsQ/ncbww/qM040NHBTOfxPdaO2eaQjcQzLzc
         8AsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696848933; x=1697453733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hc4v31B7BZ+unAODbPYjDOcoxCYyDHds2J7A0aemnHA=;
        b=S2PGEXcg3I/EvBIiywHDS8u4ib/kybj1v1Qu4iNUVDVetdHWO/FP4j8N2RxC5rKhuE
         Xe11gN/EPlOPlhtf6WWbNqPvQQ/IyJzXNGMiFr2JegeRnlPc8ixcl/rAVAPlWLjN35/s
         7Osx/TZM4DC0xKXUuQGaJE8zX9wY3YC2+T5fUwOUYIvifYHm4y80jBhiLNLHJ3N5euS3
         Yb5393nx4jAusJ65JWtInfVSakzJ+cS/ne0nPHrct97DbSmBduyFQZ8Z02pzt6fbol33
         SRpPU0oO67fm7gw0FZRmWkX86GEDVjqMICxJluDXyi8Fc7lc3LVDYLsyPOf6jDt1tU40
         Kysw==
X-Gm-Message-State: AOJu0YzcSlbqNSyyMlJ2keqnhCxEcIvQXZcEFFBv/zGZQ0LHPLoaB/Ai
        kc9J1hkSFbE5yVkqmGUDxZjFkJvv7v0tSw==
X-Google-Smtp-Source: AGHT+IGZS8zwIwS5uDnES3q7Ebq/nCIEfbC6XjQ+jyqb3yw+eu9ltLKsRxrESxBUJOLm6+rk1EZVtA==
X-Received: by 2002:a05:6402:1a28:b0:522:3849:48d8 with SMTP id be8-20020a0564021a2800b00522384948d8mr13803357edb.9.1696848933111;
        Mon, 09 Oct 2023 03:55:33 -0700 (PDT)
Received: from worklaptop.fritz.box ([2a02:2454:56d:f00:47bc:9393:72b0:bdf2])
        by smtp.gmail.com with ESMTPSA id ca15-20020aa7cd6f000000b005331f6d4a30sm5906800edb.56.2023.10.09.03.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 03:55:32 -0700 (PDT)
From:   Karthik Nayak <karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/3] rev-list: add support for commits in `--missing`
Date:   Mon,  9 Oct 2023 12:55:25 +0200
Message-ID: <20231009105528.17777-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `--missing` option in git-rev-list(1) was introduced intitally
to deal with missing blobs in the context of promissory notes.
Eventually the option was extended to also support tree objects in
7c0fe330d5 (rev-list: handle missing tree objects properly,2018-10-05).

This patch series extends the `--missing` option to also add support for
commit objects. We do this by introducing a new flag `MISSING` which is
added whenever we encounter a missing commit during traversal. Then in
`builtin/rev-list` we check for this flag and take the appropriate
action based on the `--missing=*` option used.

This series is an alternate to the patch series I had posted earlier:
https://lore.kernel.org/git/20230908174208.249184-1-karthik.188@gmail.com/.
In that patch, we introduced an option `--ignore-missing-links` which
was added to expose the `ignore_missing_links` bit to the user. The
issue in that patch was that, the option `--ignore-missing-links` didn't
play well the pre-existing `--missing` option. This series avoids that
route and just extends the `--missing` option for commits to solve the
same problem.

Karthik Nayak (3):
  revision: rename bit to `do_not_die_on_missing_objects`
  rev-list: move `show_commit()` to the bottom
  rev-list: add commit object support in `--missing` option

 builtin/reflog.c            |  2 +-
 builtin/rev-list.c          | 93 +++++++++++++++++++------------------
 list-objects.c              |  2 +-
 object.h                    |  2 +-
 revision.c                  |  9 +++-
 revision.h                  | 20 ++++----
 t/t6022-rev-list-missing.sh | 74 +++++++++++++++++++++++++++++
 7 files changed, 145 insertions(+), 57 deletions(-)
 create mode 100755 t/t6022-rev-list-missing.sh

-- 
2.41.0

