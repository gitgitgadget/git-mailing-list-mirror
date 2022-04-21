Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA71AC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 20:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392260AbiDUURe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 16:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392286AbiDUURc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 16:17:32 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF48D63C8
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 13:14:41 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so6599454wmb.4
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 13:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+dUfzmaTJ9okEyUq367hBd8ykAhsoHMoPYy4fAiH89Q=;
        b=m/AuqYGMIZ9pOAF8NvjG0Sbnqq+hFnIzDLLTj6YaMYx1Ks2eaonikIXUAxeCPP4m9/
         kOysyT1mUS8FiF8KV2psNQWk00/4qXrQkQ/UdzOMtdB8JqAQ3TvdQcKHCm6QQyQvIe8p
         AOLIKQ2YDD/iislZrLIcrf9gcLsQIEJRnmioAvt1IgyNtAirv3UdAo8RKwvDB+0OtXMD
         XM+TDEAcw8Js7xGw4UmbyX01dtlmbFHgHG6lKdQsAKoRzl5sMNriyTRWGSBUqJdRhQKi
         pJfGsOw9KUtFwu3zMFWQyBgQcoGr1q0pYlnSG8bNVNa3MllsJWf6YIK/GQnvu1d+tbzP
         qLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+dUfzmaTJ9okEyUq367hBd8ykAhsoHMoPYy4fAiH89Q=;
        b=T6Ug68Ggz54cvaT4FQQ/cao3FbEVNYbub+NQBgCw7gJax4oS2d7KAWa/QaGPxV26X0
         y7ZLqKR8LrbWvNi4i+ACkvgkezb5Z0P6hxzGV2X2cbEVOizR9ryWCPlBm5ktJBPTp844
         UJTvC7LAHKaIHdRsRFowvgYf3FtS20kDEVlSln//83SFFjmXa6XAzw3oVL+F3n0HDKAP
         cRL73F4jUmS6260BJZh7pcdndyP0vUaaivfspxlSUdr382vJ3Qdccl3SZV3hj5+zFsPi
         NgsfF2vFiJ8zJEQ3tVqT9ZB6KR5febgm++cDAZx0t9egeyrEftXLySoOTNB2Haag1NRh
         rf+g==
X-Gm-Message-State: AOAM533CdU3zb/XnJIC2JdyQdVEzzfyOfT1IuyTpGX3QBoMMprkWy68s
        6bEDm8lMn9ZAwM5iVFFseXnyD+GBvZyvaw==
X-Google-Smtp-Source: ABdhPJx4SVpeELZ9aFI9LnhKz9uTYgmI8JoVLb1y7EsbUhpxKnFDEsIhd0Q5Est/U8IVcSTdSAtslQ==
X-Received: by 2002:a7b:c844:0:b0:38e:7c92:a9e3 with SMTP id c4-20020a7bc844000000b0038e7c92a9e3mr908563wml.140.1650572079956;
        Thu, 21 Apr 2022 13:14:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l9-20020a1c7909000000b0038eb8171fa5sm1309wme.1.2022.04.21.13.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 13:14:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/4] Fix issues and a regression noted by valgrind
Date:   Thu, 21 Apr 2022 22:14:33 +0200
Message-Id: <cover-0.4-00000000000-20220421T200733Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.gd068ac2c328
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I spotted these when testing v2.36.0, but waited until after the
release since there's no v2.36.0 regressions here.

The scariest issue here by far is one I caused and am now fixing in
4/4. As noted I don't think it had any real practical fallout, but we
should obviously fix it sooner than later.

I think the 3/4 issue is likewise just a bit scary, but I haven't
analyzed it as much. In that case we'd pass uninitialized memory to a
syscall.

It's clear that the --valgrind mode for the test suite is useful, but
it's sooo sloooow (it takes around a full day to complete, and for me
the full tests otherwise run in ~2 minutes). I'll try to run it in the
background with some regularity going forward anyway.

Aside: I do see that there's occasionaly FreeBSD runs in the "main"
git/git CI. How are those hooked up? Running it in GitHub CI would
take approximately forever (I think it would run into a hard timeout),
but if we can hook up a CI runner on some dedicated hardware.

Ævar Arnfjörð Bjarmason (4):
  tests: make RUNTIME_PREFIX compatible with --valgrind
  log test: skip a failing mkstemp() test under valgrind
  commit-graph.c: don't assume that stat() succeeds
  object-file: fix a unpack_loose_header() regression in 3b6a8db3b03

 commit-graph.c        |  6 ++++--
 object-file.c         |  8 ++++++--
 t/t0060-path-utils.sh |  4 ++--
 t/t1006-cat-file.sh   | 10 ++++++++--
 t/t1450-fsck.sh       | 13 +++++++++++--
 t/t4202-log.sh        | 11 +++++++----
 t/test-lib.sh         |  1 +
 7 files changed, 39 insertions(+), 14 deletions(-)

-- 
2.36.0.879.gd068ac2c328

