Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3F4B2023D
	for <e@80x24.org>; Mon, 22 May 2017 18:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935103AbdEVSdz (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 14:33:55 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:34741 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934590AbdEVSdy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 14:33:54 -0400
Received: by mail-io0-f182.google.com with SMTP id k91so87003484ioi.1
        for <git@vger.kernel.org>; Mon, 22 May 2017 11:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=foVElRqmgJhkWWOrPvBK3oE3ROmE0J7h0Mpd86MKnDU=;
        b=kgQufdPReNIVeoW1enOEH8fcLOafcMh1A4aMe0PdN0crDU/Di2LaCkq3Jqkai2LS1g
         ST7sUOvW33V25ZIHmvfu1SQMl65pU3WFAhLKGsEXa3wEBIUitthNTCWqYkGWLPCxYa1F
         v7XXSTkM7RrBktIg9kDhwZ3QEbuQSyjEcAWMRM7Ivv47PkLe05mHtY3fhQA9cu6Bqgd9
         hW4SE6Hkr0Tyq5Q1s0NUb+ittLFDum2uRXPq1/K40pr5pUBF+i3xOWZP7FwVtt2HfOLr
         refuiZ9B1wDE+69Gmn0V015Xe1ytnAHVNKuXXasVDGgQCV81itBvpTl9Evi8SPyPEt/a
         rh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=foVElRqmgJhkWWOrPvBK3oE3ROmE0J7h0Mpd86MKnDU=;
        b=sfDx9gKZLeIEvkkMNFyxk99IT9O46f07auPapPDafVeLnkJUidvbX7KFhI9f0mUfGl
         1fptXN9Wmr4b2/N2dlSTbHbNQkgqmDzPsxT7SjA7BZTUwnpWz3UknPSW2Iixpn8tY1qj
         Oe0QpFS/KtMBu1k5y/79QlQe2FXo2TVB7577MnWt8vHPa8GMFv3Zzh5dBK3tbAA6GXlj
         eP+k+nd/acSTLTFnDaMUbH266O6mQ/JM4q3Z+0OIR7VOuhrKN4g++W21By9CdgPiRtAT
         rxzing2ykpam5rSx11a7Y3ToK2e0dqGpzUeZ/YB0AGur7Ar7hFLnjqJM6tBhZuPxMfXJ
         AEXw==
X-Gm-Message-State: AODbwcCP8xISP5yUMRFa1ASRCmfNUAKFXWAu/iu3b4Xg/wYV0euKtrpn
        yKKSqLcCPfNXwqwNb9OauHGFePrHZQ==
X-Received: by 10.107.178.12 with SMTP id b12mr22127070iof.50.1495478034094;
 Mon, 22 May 2017 11:33:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 22 May 2017 11:33:33 -0700 (PDT)
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 22 May 2017 20:33:33 +0200
Message-ID: <CACBZZX41yrAtBvkVeL9Q=2_TxcwrDXh55gu3qLN54P_go318OA@mail.gmail.com>
Subject: BUG: The .gitignore rules can't be made to cross submodule boundaries
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I was adding the sha1collisiondetection submodule to git.git I
noticed that building git would dirty the submodule.

This is because our own Makefile adds .depend/ directories. I hacked
around it by just getting the upstream project accept carrying an
ignore rule for that around:
https://github.com/cr-marcstevens/sha1collisiondetection/commit/e8397b26

A workaround for this is to have the Makefile add such a rule to
.git/modules/sha1collisiondetection/info/exclude, but that's less
convenient than being able to distribute it as a normal .gitignore
rule.

The submodule.<name>.ignore config provides an overly big hammer to
solve this, it would be better if we had something like
submodule.<name>.gitignore=<path>. Then we could have e.g.
.gitignore.sha1collisiondetection which would be added to whatever
rules the repo's own .gitignore provides.
