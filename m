Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F2FC433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbiGMNU6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbiGMNU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:20:56 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EF163CB
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:20:54 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bu1so14303405wrb.9
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=1FW04XezbpV7EfNEvnaA1v6PMONCZhE2I3DNxIfMhTI=;
        b=R58cmGq2twYoQmfYFhv6+sSYWQYcsCVcwdCAq8X7rgXeoGMWqhZZiY0r3ByyQTnjH7
         R30IHvBrZyGY1UwaIOXwvRGy/pG0fA8jeNyu/hN/CwpZht762a3iurV3gYEnfc+mv+9O
         vmjV6QGPxz4trEhk6ngpg/Z7IdkLtxtBIUmU/qQWn2kJFrDD9DPkBSD8Y5DfmK0JN5TX
         tLCuSjmcoFswzha+2p/aMys/3lqyHMfAzsPQmt81pDfIBZ2PHrFUuurNSE7HxKTOB/97
         gwBYXlocM2q3AhzP4G5KBllvr7jq9xjXHF+1BJGDXM8fLdZ+QCRcWvt9vBI7iaUHkh4h
         Dk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1FW04XezbpV7EfNEvnaA1v6PMONCZhE2I3DNxIfMhTI=;
        b=qx9YhBZGVu9Td0/U5NKWhyfgsYBATvmB+pIxJgbn9R2mVVeGLftiVAgVKb+7OdCm4u
         u4VoCiUp9ifAvhLoBVZEyOduLTFKWRqFgcJfJ1p94ekz8OpDRgiAgXqxk0/UxOKWiP7q
         +NRJnJp8ilCBrvnGBI7GGHEBW+Wumf3vOJm3LjZ009W8W/8XL9MMLGrf5YlokXivXnB3
         hDtJEOMu15r8SaQ1TN3UmocKDbAaxPMkXXUIg0YxWs3pTB6rRC69S7U9WwCy2Vp8exzt
         gRO78fBeQjuBywy8O1t1fm5DemnrD/LWqn2T/bu9tPyVHERisRWqjzx++4M4STEea6o0
         R0Xg==
X-Gm-Message-State: AJIora8IzBMLNX+fjjhfGxE6NWdXGHW0fHivJkguN5NH+yp+Mj8+7wvw
        +dFJqtR7HDdAol33Q1idiKOdnTdDbjk=
X-Google-Smtp-Source: AGRyM1u2lLxljNopZ8yWmEtIHNnlzP8VsDqnTEIp39hD2W07ccHoV/M0Gf1Xdblza6+m5msbceuyfg==
X-Received: by 2002:adf:e405:0:b0:21d:86b6:a286 with SMTP id g5-20020adfe405000000b0021d86b6a286mr3277097wrm.29.1657718452041;
        Wed, 13 Jul 2022 06:20:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600011c200b0021d68a504cbsm10989035wrx.94.2022.07.13.06.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:20:51 -0700 (PDT)
Message-Id: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Jul 2022 13:20:47 +0000
Subject: [PATCH 0/3] Use "allowlist" and "denylist" tree-wide
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The terms "allowlist" and "denylist" are self-defining. One "allows" things
while the other "denies" things.

These are better terms over "whitelist" and "blacklist" which require prior
knowledge of the terms or cultural expectations around what each color
"means".

This series replaces (almost) all uses of these terms with allowlist and
denylist. The only exceptions are in release notes for older Git versions.

There is no meaningful functional change, although one logging message in
daemon.c is changed and I'm unfamiliar with exactly how that might be
consumed.

Some recommend using "blocklist", but I personally prefer "denylist". To me,
"blocking" something seems permanent. "Denying" something seems ephemeral
and related to a specific request being denied due to some (possibly
mutable) state. I'm open to suggestions here. There are many fewer
replacements needed in this case.

I did not make any change to our CodingGuidelines. Hopefully having clear
usage throughout the codebase will be enough to promote using consistent
terminology.

Thanks, -Stolee

Derrick Stolee (3):
  Documentation: use allowlist and denylist
  t/*: use allowlist
  *: use allowlist and denylist

 Documentation/git-cvsserver.txt |  2 +-
 Documentation/git-daemon.txt    | 10 +++++-----
 Documentation/git.txt           |  2 +-
 daemon.c                        |  8 ++++----
 git-cvsserver.perl              |  2 +-
 sha1dc/sha1.c                   | 12 ++++++------
 t/README                        |  4 ++--
 t/lib-proto-disable.sh          |  6 +++---
 t/t5812-proto-disable-http.sh   |  2 +-
 t/t5815-submodule-protos.sh     |  4 ++--
 t/t9400-git-cvsserver-server.sh |  2 +-
 t/test-lib-functions.sh         |  2 +-
 t/test-lib.sh                   |  2 +-
 transport.c                     |  8 ++++----
 14 files changed, 33 insertions(+), 33 deletions(-)


base-commit: e4a4b31577c7419497ac30cebe30d755b97752c5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1274%2Fderrickstolee%2Fallow-deny-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1274/derrickstolee/allow-deny-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1274
-- 
gitgitgadget
