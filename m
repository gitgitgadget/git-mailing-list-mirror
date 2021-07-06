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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79927C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FDDA61C69
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhGFSWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 14:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhGFSWp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 14:22:45 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20047C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 11:20:07 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id p17-20020a17090b0111b02901723ab8d11fso2436431pjz.1
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 11:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gQLaGK3VJvVzDg+NwR9X/uM98xBxu9Jafp5BA4j8Tu4=;
        b=O1f30mYObt+hLZtZwGIvrFj99fLD/xbLhmqzLTI11m7AFCFbOaeB4yl8OJmRmzXmSK
         7lcqwqubRYWiKT2A4RRJIKJ4UrDLIE4xsExIcEpj/jXFk2gkVyTyyPUWEWDHK4nLefJT
         AFlEKXXRqOgnjL63JH673NCXVB5xCXXSo0KQkrxzy8f02AJqvsfcD/7WVplpslUovxHU
         HMTeejwQF1w4ldkNDoKOZ6cHx7d4/hjKXOKhCJH9XHYLLZPOP8WetoVQCXTP6L1WXPtd
         ER8ekshkLJJ1uzdX8tD2j60cPVpcgA5UEjaChrwujImsC2Z08vcF9veRBOSv3+rW/pJy
         /uUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gQLaGK3VJvVzDg+NwR9X/uM98xBxu9Jafp5BA4j8Tu4=;
        b=BkAJzOsvwbEqhmiol/QvKterjbMiOuVb1P3u3g8eZVRDgYQQ/Wcs/HXgKyrv6Ruyql
         4zOViaUpne92ZetA4Yh5vw2syhnTyao5JdrMeXU7qcLvfdHisi3+M3gMfFSEkxM9Ucci
         CY+44tm819jX5P/FRKkLZwdSLdC0syPry3HAhhL+zrF/erh0JYVi3cihlMxkYfIA5Bue
         OPG4aQzk8D87+3kVV6TYTztLPHnEb9u0T5TPZu5qf39lkTMnPSGLJfJYuQTI+KgwZe/R
         9nqY63ItSP6g1b5mmrds9hHUSdRKu264e/8bUI1Vjgx3cyu7N6O6DG5DFz4Ow+XS9ANc
         n0nw==
X-Gm-Message-State: AOAM533Smsa1NUOzMXzFLK5Q0RKYRVVs6pBqN+wRKrQWGn42EeNhM4Kw
        nrUjWIUsvZ/eyD9b+zSzKj8vKiyKbISPfx61
X-Google-Smtp-Source: ABdhPJwSW9dcaJKEcfVgQo61SImnIgpgVKfz6WcAk9JRrg9cz5XajHLFMWwxUpiuGErnQfVj6OTMLg==
X-Received: by 2002:a17:90b:3655:: with SMTP id nh21mr1718908pjb.105.1625595606464;
        Tue, 06 Jul 2021 11:20:06 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id b22sm3779809pje.1.2021.07.06.11.20.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jul 2021 11:20:06 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [GSoC] [PATCH 0/3] submodule add: partial conversion to C
Date:   Tue,  6 Jul 2021 23:49:33 +0530
Message-Id: <20210706181936.34087-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on a previous series I sent[1] which got a bunch of reviews at the
time from Christian, Danh, Junio, Rafael and Eric.

This series only includes changes pertaining to the 'add-clone' subcommand, and
the patches have remained the same as before, except for the inclusion of a
custom die routine 'submodule_die()' that makes all the die()'s behave identical
to the shell version of 'die'. I am particularly interested in opinions about
this change.

A test has been added to ensure no regressions are introduced during the
conversion.

I am holding on to a full conversion of submodule add[2], and sending only a
portion of it, so that the parts that already have been seen before on the list
and refined can be merged. I then plan to send the rest of the patches that
build on top of this series.

You can fetch this series from: https://github.com/tfidfwastaken/git.git

[1]: https://lore.kernel.org/git/20210615145745.33382-1-raykar.ath@gmail.com/
[2]: https://github.com/tfidfwastaken/git/commits/submodule-helper-add-6

Atharva Raykar (3):
  t7400: test failure to add submodule in tracked path
  submodule--helper: refactor module_clone()
  submodule--helper: introduce add-clone subcommand

 builtin/submodule--helper.c | 428 ++++++++++++++++++++++++++----------
 git-submodule.sh            |  38 +---
 t/t7400-submodule-basic.sh  |  11 +
 3 files changed, 327 insertions(+), 150 deletions(-)

-- 
2.32.0

