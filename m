Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87C0C77B61
	for <git@archiver.kernel.org>; Mon,  1 May 2023 15:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjEAPxv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 11:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjEAPxt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 11:53:49 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F021720
        for <git@vger.kernel.org>; Mon,  1 May 2023 08:53:46 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-b9daef8681fso1637347276.1
        for <git@vger.kernel.org>; Mon, 01 May 2023 08:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682956426; x=1685548426;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AHCvaMVOKuP5Psy3lUxpAfKZTInr8/mfZ6hebsctOuM=;
        b=NvEllr3FwO2tBR6VWvRrdsMZVltZKV5Eo5EQt+G8NMG05cKpsfwXPw0feO4LRzr8Nr
         FZcg79qB72xUUzAKjdEO72AieSEeRil3OIDRLpQzpPUNFozGOVlGIiucJxKW8/OuLuoR
         zg1wznz2lBsP2vupwK+HZSKCj6Q0GeJQqIY6aGV8MM7kqIMQnHXleQc2yOSTn3V4FcDb
         rHpVEtzpYEWY4V1p2GgfcIUAH/RKwPw8p9WiXnBzNx3ytdzG+nMt9lmdEMgtkbnUSSUq
         2dX35Lxvsk1plMVOi0HcivDK6dc58/l4v3vn0/NHluJOQxgxHYKjpoceRGpfFdMblaab
         aphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682956426; x=1685548426;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AHCvaMVOKuP5Psy3lUxpAfKZTInr8/mfZ6hebsctOuM=;
        b=GXgVzz1Qgyfg9x+3zpgpVkkpdFfL4+ZlawMcTc8pnFJM94N5dTPRuMUYlZ2PHsSWjH
         W1NmOgXV6UCBl3zyQOM3pgEXAw2LP/wAo+Z0hopny5PPlDQaNVRWVC4qe2LOMhI0Snr4
         IWLt2sF4V0ljmsmoejtHQ6xaozLgQNPGR4m8F5nGwfnaLUS9z2Ey8jtDemKEk/C4Niqh
         nbrxTCtARQ0q6LeENknnWuQ2sKVnav4m++I+nh0/WrEwV2RKorI4jRCStt3jy5JGhgjm
         BWs5lnwhdI0UEtLh2ELsocAB0BTd1HL1ROvatmSEKP7MGncwbJfbbFSbBH37v2kp+Z8O
         GFZA==
X-Gm-Message-State: AC+VfDzPNvmtppiPX5oUwS2VC/8T2aPuK2QLIrzHGwon7tEtLd1Atn1E
        dObqjI10V9IvWWa8zkxqoDtvM8Xab2xuGY+4YpWNZQ==
X-Google-Smtp-Source: ACHHUZ5rsFeKpMt0TJgNoIZ52tG5G7AoMlSoEFo1Ei37j3H2DY0/CPHAXvlG8K0CkEWgiiP+C8kNhA==
X-Received: by 2002:a25:aae4:0:b0:b64:ed42:6124 with SMTP id t91-20020a25aae4000000b00b64ed426124mr14223125ybi.13.1682956425698;
        Mon, 01 May 2023 08:53:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u7-20020a252e07000000b00b98dbbedb73sm6336631ybu.43.2023.05.01.08.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 08:53:45 -0700 (PDT)
Date:   Mon, 1 May 2023 11:53:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 0/7] contrib/credential: avoid protocol injection attacks
Message-ID: <cover.1682956419.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series addresses a handful of potential protocol injection attacks
possible via some of the credential helpers in contrib/credential, and
the new "wwwauth[]" directive.

The attack is described in complete detail in 2/7, but roughly boils
down to using a long line to incur multiple fgets() calls which can
treat data in the middle of the line as if it appeared at the beginning.

Luckily, all protocol fields part of tagged versions of Git are immune
from this attack. Briefly:

  - "protocol" is restricted to known values
  - "host" is immune because curl will reject hostnames that have a '='
    character in them, which would be required to carry out this attack.
  - "username", and "path" are immune, because the buffer characters to
    fill out the first `fgets()` call would pollute the
    `username`/`path` field, causing the credential helper to return
    nothing
  - "password" is immune because providing a password instructs
    credential helpers to avoid filling credentials in the first place.

But the new "wwwauth[]" field does allow this attack to take place.

Since these credential helpers are tested via t0303 (which requires some
extensive set-up), we opted not to make these fixes during the last
embargo period, and instead do them before the "wwwauth[]" feature
becomes part of a tagged version.

With the additional time, we have been able to verify that the affected
credential helpers which are modified in this series all fail the new
test before their patches, and pass afterwords. Thanks to Peff for
looking at libsecret, Matthew Cheetham for looking at wincred. I looked
at osxkeychain.

Taylor Blau (7):
  credential.c: store "wwwauth[]" values in `credential_read()`
  t/lib-credential.sh: ensure credential helpers handle long headers
  contrib/credential: avoid fixed-size buffer in osxkeychain
  contrib/credential: remove 'gnome-keyring' credential helper
  contrib/credential: .gitignore libsecret build artifacts
  contrib/credential: avoid fixed-size buffer in libsecret
  contrib/credential: embiggen fixed-size buffer in wincred

 contrib/credential/gnome-keyring/.gitignore   |   1 -
 contrib/credential/gnome-keyring/Makefile     |  25 -
 .../git-credential-gnome-keyring.c            | 470 ------------------
 contrib/credential/libsecret/.gitignore       |   1 +
 .../libsecret/git-credential-libsecret.c      |  15 +-
 .../osxkeychain/git-credential-osxkeychain.c  |  10 +-
 .../wincred/git-credential-wincred.c          |  21 +-
 credential.c                                  |   2 +
 t/lib-credential.sh                           |  29 ++
 9 files changed, 63 insertions(+), 511 deletions(-)
 delete mode 100644 contrib/credential/gnome-keyring/.gitignore
 delete mode 100644 contrib/credential/gnome-keyring/Makefile
 delete mode 100644 contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
 create mode 100644 contrib/credential/libsecret/.gitignore

-- 
2.40.1.452.gb3cd41c833
