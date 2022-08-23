Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259DCC32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 19:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiHWTXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 15:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiHWTXF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 15:23:05 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C66C2287
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 11:04:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a4so17966298wrq.1
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 11:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=7+f9M7Go5Zcuvjm5B7MaNFBaqeFOeIHZAAb3EN0vCvY=;
        b=R2RuaOxDMz4l/L34+4RdJC8ic49/NCw4xzuAvCbcm7ivKkoE3Q/HAY127eNci7/Tlg
         3tKwCk8k9xRRB0Ic4ZgB3S40OLcNUYX5v+Rg6GaFiWP0AVTlDF3k8EGBgXHkbuQL3LaI
         /oEOiLNGh1mVdlNAmIVbeZso9+8/HlUBnnVxK2HXTPajbjaHmKLtXOSJRfibXPu3w2yF
         /nFCXmcM0hGz9HetVD1mZ1Vuqbh0oBDZZNGsta46FSpXuuAiqF+CKlPIFG8YNT9JTxrd
         mUbvkLITkQzEmoQodEfsCoPURtG5Dm1AgCH9DaN/cGxrZwGrNwrt42Ose9HDc6rhTsFa
         Mdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=7+f9M7Go5Zcuvjm5B7MaNFBaqeFOeIHZAAb3EN0vCvY=;
        b=ZzM1HDOnFJ/lxH/9ojpobIuKqW02ju5IULYcAzw1E1ytj6YlRtDrAGgQVxhqN/E9Fd
         4WR9HUaKKUYtwLqr//6mp04l1H+ToVJl2vNA7UAOiJrCYJ2ab6tUi9GMgSA+dZK+k3Wq
         N1Z7Obcdu1ThahG/BAR+7G/LuYGxcvuRV0PszICrZ9/aiOOYp14bTh6PDMAWFrWgXlpN
         BmSfBHhPKVC98HGCU3o9mk4/fhggXPlIL/adnG1boiMOpxddE/TF7yuefrluAFKj8Rzo
         XpjOtn0MmTs5MO3rY9aCuv8OMSBKWuP7N7AjvkYBeCe52u8cG9qnCboAo+AtEbsU7QSY
         D1Vg==
X-Gm-Message-State: ACgBeo3sOze40CCQvfpRB+lLj0o53MbvDH5fB1vCxg+4jOkIl6PTiN/p
        YN/cP4vw4xzsle7i/dBMW1J7Idpg1hs=
X-Google-Smtp-Source: AA6agR5+K7/mYkufeWgB90jzpyKwaajXqUv0ga6U31rzs+DkTbSH4jX9eDXSi1T2PJA3JcTGwSWSZA==
X-Received: by 2002:a5d:6e8e:0:b0:220:5fa1:d508 with SMTP id k14-20020a5d6e8e000000b002205fa1d508mr15019332wrz.337.1661277872125;
        Tue, 23 Aug 2022 11:04:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n189-20020a1ca4c6000000b003a540fef440sm22516684wme.1.2022.08.23.11.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 11:04:31 -0700 (PDT)
Message-Id: <pull.1336.git.1661277870.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 18:04:27 +0000
Subject: [PATCH 0/3] built-in add -p: support diff-so-fancy better
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain reported in
https://lore.kernel.org/git/ecf6f5be-22ca-299f-a8f1-bda38e5ca246@gmail.com
that there is a problem when running the built-in version of git add -p with
diff-so-fancy [https://github.com/so-fancy/diff-so-fancy] as diff colorizer.
The symptom is this:

    error: could not parse colored hunk header '?[36m?[1m?[38;5;13m@ file:1 @?[1m?[0m'


This patch series addresses that and should fix
https://github.com/so-fancy/diff-so-fancy/issues/437

Johannes Schindelin (3):
  t3701: redefine what is "bogus" output of a diff filter
  add -p: gracefully ignore unparseable hunk headers in colored diffs
  add -p: handle `diff-so-fancy`'s hunk headers better

 add-patch.c                | 21 ++++++++++++---------
 t/t3701-add-interactive.sh | 12 +++++++++++-
 2 files changed, 23 insertions(+), 10 deletions(-)


base-commit: 795ea8776befc95ea2becd8020c7a284677b4161
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1336%2Fdscho%2Fdiff-so-fancy-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1336/dscho/diff-so-fancy-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1336
-- 
gitgitgadget
