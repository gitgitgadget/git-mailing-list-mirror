Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1385EC6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A9760FEE
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhGVLa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 07:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhGVLax (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 07:30:53 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C9DC061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:11:28 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id f9so5669790wrq.11
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fCDWOg5eZ8bNC/MNVj5bXuRE46bQngGmXAOk0QVNfI4=;
        b=jsLl2mblIXm478NkM1qH7UNt39iIkVdErml5aG4CG/z/JZNbKSkRNVq2pNPYpDnmSP
         XAin1wcHh1hAIxrAJrbgQZgF/nwfCcUpFy5B81TuEsSoiWkeFi1CqEWNf7nDFapCLJyE
         sxWb9WsRo3GQTEng0AgYm49bmDcPcH1PFrxSGxwWCJ0RWXSSojBeRUT1QKrZSSaaa754
         2xTSrusK45yCza1Jcs1qO/LaiGFhJWPkUyFOO8PWbi7Uw3RqVriPIO9jxPFhyimuMjvb
         DIGOzFbGOT4SUaUzjOgxyz2mncEhd9E/AGHIUtOloPIV8Nelvoc1+OD4oVnwW4FBAA7L
         LbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fCDWOg5eZ8bNC/MNVj5bXuRE46bQngGmXAOk0QVNfI4=;
        b=IoIKPVgwRdAMQ3Xnmr3CuYwq+DxSnt7FATuvzBSaAVwUGIOXC20E6HueOBtPiI2+Cx
         UserTk8042GqSUtyDyiLXy16w8V5rnoWOQJAwxyFjItKgsM0eDkPS16cSHhl5pp+TB4Q
         HvkHkAVgW/Vs2zaqrtPOp65roSuG5DJJ/mWGMBM5gug9LCaOCpFcx5RnjAX5wCrV/dMb
         MshI4zsp+9h6PSe94V0dE8WOxmsYuhQdYfWvCdakNb3lSRlNzyFrIr8cIBcaPOp4Gjb/
         B14r7yAmiFZ6kOmxiKTcN2uh/TDDkcCBvQlNp2JCcTB5YJM+lTDjPX3IYRLT+rTo6Xmn
         DAAQ==
X-Gm-Message-State: AOAM5305g5aVt0DKu68iKimdwsRyiERfYgaJ9c0lCQBkmokMvA6MkJEE
        NCa0xUurnErgO5kTg5p0kq/dvJzjirF11A==
X-Google-Smtp-Source: ABdhPJwWoEusoa0nNEgRp35z/8nq0v3ATRdBmwqFwJ+gLyHvUydo9EY6PdI8Im01zWZJMKVhZJEUNg==
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr47605245wrn.398.1626955886782;
        Thu, 22 Jul 2021 05:11:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k24sm30964130wrh.30.2021.07.22.05.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 05:11:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Dave Huseby <dwh@linuxprogrammer.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/2] SubmittingPatches: talk about GitHub CI, not Travis + move-only
Date:   Thu, 22 Jul 2021 14:11:22 +0200
Message-Id: <cover-0.2-0000000000-20210722T120746Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.957.gd9e39d72fe6
In-Reply-To: <cover-0.3-0000000000-20210607T110044Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210607T110044Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a late-re-roll of this v2:
https://lore.kernel.org/git/cover-0.3-0000000000-20210607T110044Z-avarab@gmail.com/

I fixed the problems Đoàn Trần Công Danh and SZEDER Gábor pointed out
in v2.

I ejected the removal of the inline patch for Pine from this
verison. Johannes suggest another approach in
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2106072346560.55@tvgsbejvaqbjf.bet/

I think we're spending way too much reader time on [Al]pine still, but
I don't want to write something that's accurate advice for an E-Mail
client I've never used, so I'm dropping it. Perhaps someone else will
pick that cleanup up...

Ævar Arnfjörð Bjarmason (2):
  SubmittingPatches: move discussion of Signed-off-by above "send"
  SubmittingPatches: replace discussion of Travis with GitHub Actions

 Documentation/SubmittingPatches | 207 +++++++++++++++-----------------
 1 file changed, 96 insertions(+), 111 deletions(-)

Range-diff against v2:
1:  6e2749d307 = 1:  4283f000c5 SubmittingPatches: move discussion of Signed-off-by above "send"
2:  788b198520 ! 2:  ecb9924a6a SubmittingPatches: replace discussion of Travis with GitHub Actions
    @@ Documentation/SubmittingPatches: the feature triggers the new behavior when it s
     -GitHub-Travis CI hints section for details.
     +Pushing to a fork of https://github.com/git/git will use their CI
     +integration to test your changes on Linux, Mac and Windows. See the
    -+GitHub CI section for details.
    ++<<GHCI,GitHub CI>> section for details.
      
      Do not forget to update the documentation to describe the updated
      behavior and make sure that the resulting documentation set formats
     @@ Documentation/SubmittingPatches: their trees themselves.
    +   entitled "What's cooking in git.git" and "What's in git.git" giving
        the status of various proposed changes.
      
    - [[travis]]
    +-[[travis]]
     -== GitHub-Travis CI hints
    -+== GitHub CI
    ++== GitHub CI[[GHCI]]]
      
     -With an account at GitHub (you can get one for free to work on open
     -source projects), you can use Travis CI to test your changes on Linux,
    @@ Documentation/SubmittingPatches: Follow these steps for the initial setup:
     -
     -. Open your Travis CI profile page: https://travis-ci.org/profile
     -
    - . Enable Travis CI builds for your Git fork.
    - 
    - After the initial setup, Travis CI will run whenever you push new changes
    +-. Enable Travis CI builds for your Git fork.
    +-
    +-After the initial setup, Travis CI will run whenever you push new changes
    ++After the initial setup, CI will run whenever you push new changes
      to your fork of Git on GitHub.  You can monitor the test state of all your
     -branches here: https://travis-ci.org/__<Your GitHub handle>__/git/branches
     +branches here: https://github.com/<Your GitHub handle>/git/actions/workflows/main.yml
3:  fecc3459f1 < -:  ---------- SubmittingPatches: remove pine-specific hints from MUA hints
-- 
2.32.0.957.gd9e39d72fe6

