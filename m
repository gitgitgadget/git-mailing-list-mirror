Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E85C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 20:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C042077D
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 20:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfHOf4Vz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgDVUvI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 16:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgDVUvI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 16:51:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CB3C03C1A9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 13:51:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g12so4141260wmh.3
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 13:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=rvd32UUKZ45GC4sAFR8q7Zo+QOuoGT+rxpJjWD4JuOU=;
        b=AfHOf4Vz2tkIXsk2d6t80tOxdy3ogxDheCHDPZtRDQ00iCwfHkMspO+o/HnDCSrD7j
         /JwW8zMUyZpj3YI+APaH3AOf0ameN8sbMz8H8Hy+3MGW7f+2B9BWQVok2tKsmj2D/G8q
         H/CTBRl2jywkQ6g70+eUbVmCnkUT1K1PemYYceZF3DGdSS/5p6NNrGBWVsf2oxC2PLoH
         H7NfZEF6da+wl4/3t26exlEuLwE/SUHZv1HAq9YqQNMsKShOx1o2+8iEqPbxeALgu07x
         cz7YIai7jPmFTJu7f+vEK9VDOmFVHzVZ/NEVrRRrW/zH36N8Mp7r9fv3Gpg/Th5AHu1j
         bZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rvd32UUKZ45GC4sAFR8q7Zo+QOuoGT+rxpJjWD4JuOU=;
        b=WUHB9GqUe01LSd0Qm7UeADM0/jx05gIuo1w5Ub4nKbAA+HBxUZalwzuugjGPQtLg6I
         LtpJd5fRhK2Q0rtU6d5U3fFPSEGDs3TpFjpQXh4BO67j9GJruZg5sfEgPRz8Fgu+reOL
         atm7nGvjcIXMm5MxvmH5vy7BVgoY0yXYdi450dwp+yxDNNTjr+CzdbjqU154qsCohpdD
         zPWcIZQ3ToW3D0STJcTWPbbuolzYn6LGLgU0Ami+rJRdNnqsQF6s0CfmgAPrGE8bQt/H
         bA7/DQHMFoOS9gyQ1whgvR5OLZgNVx/VZtph4OLV6hCiGnwGohW000q3iTHN0bDEM7mz
         riow==
X-Gm-Message-State: AGi0PuZXRWT/8DzwYE/ABIbJZV4dIawGhvnX6oBHQUNWrBxyBcM013pb
        XlOGaO2dzgfyYIdCd8Shd5uqFfuh
X-Google-Smtp-Source: APiQypKtl5jI1/NfMiGiJ5qmvrcKvuK4DFZ5Z7QH1EO4b/T35vluDDXZJOwnH0nLOm6M9sY21+GFIA==
X-Received: by 2002:a7b:c250:: with SMTP id b16mr377855wmj.100.1587588666291;
        Wed, 22 Apr 2020 13:51:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s6sm633406wmh.17.2020.04.22.13.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 13:51:05 -0700 (PDT)
Message-Id: <pull.615.git.1587588665.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Apr 2020 20:51:02 +0000
Subject: [PATCH 0/3] credential: handle partial URLs in config settings again
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes the problem illustrated by Peff's example
[https://lore.kernel.org/git/20200422040644.GC3559880@coredump.intra.peff.net/]
, in maint-2.17:

  $ echo url=https://example.com |
    git -c credential.example.com.username=foo credential fill
  warning: url has no scheme: example.com
  fatal: credential url cannot be parsed: example.com

The fix is necessarily different than what was proposed by brian
[https://lore.kernel.org/git/20200422012344.2051103-1-sandals@crustytoothpaste.net/] 
because that fix targets v2.26.x which has 46fd7b390034 (credential: allow
wildcard patterns when matching config, 2020-02-20).

This patch series targets maint-2.17 instead (and might actually not be able
to fix maint due to that wildcard pattern patch; I haven't had the time to
check yet).

Please note that Git v2.17.4 will not do what we would expect here: if any
host name (without protocol) is specified, e.g. -c
credential.golli.wog.username = boo, it will actually ignore the host name.
That is, this will populate the username:

  $ echo url=https://example.com |
    git -c credential.totally.bog.us.username=foo credential fill

Obviously, this is unexpected, as a Git config like this would leave the
last specified user name as "winner":

[credential "first.com"]
    username = Whos On
[credential "second.com"]
    username = Who

This patch series fixes this. The quoted part of [credential "<value>"] will
be interpreted as a partial URL:

 * It can start with a protocol followed by ://, but does not have to.
 * If it starts with a protocol, the host name will always be set (if the 
   :// is followed immediately by yet another slash, then it will be set to
   the empty string).
 * If it starts without a protocol, it is treated as a path if the value
   starts with a slash (and the host will be left unset).
 * If it starts without a protocol and the first character is not a slash,
   it will be treated as a host name, optionally followed by a slash and the
   path.

Johannes Schindelin (3):
  credential: fix grammar
  credential: teach `credential_from_url()` a non-strict mode
  credential: handle `credential.<partial-URL>.<key>` again

 credential.c           | 21 ++++++++++++++-------
 credential.h           |  8 ++++++--
 fsck.c                 |  2 +-
 t/t0300-credentials.sh | 13 +++++++++++++
 4 files changed, 34 insertions(+), 10 deletions(-)


base-commit: df5be6dc3fd18c294ec93a9af0321334e3f92c9c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-615%2Fdscho%2Fcredential-config-partial-url-maint-2.17-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-615/dscho/credential-config-partial-url-maint-2.17-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/615
-- 
gitgitgadget
