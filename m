Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD8411F43C
	for <e@80x24.org>; Fri, 10 Nov 2017 10:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbdKJKe3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 05:34:29 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:54913 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751404AbdKJKe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 05:34:28 -0500
Received: by mail-wr0-f171.google.com with SMTP id l22so8168378wrc.11
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 02:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Ja2BtXvosgyH0G5/6bb1B50E52ByBEsQokOTZIDL8zY=;
        b=TaQcCx6Jj1uG30PBzOI5lJ66G7ELGPoo8dOnA3ni+JE/Rp1qQ4ifAVZk2oLV8NUH/z
         wGv3+euZ4Hs8a94b185vBqJX7jWRGwOXmhdgYLwA08nLpR9VE52fq1b4ulB0mk4joS2Z
         /OBoVm0FmwmH/zzS1AbwbJldMOdzqy4UO8XbtMdxJtLq9irIRCjhcrlVob/zI8YYtJgH
         HMFCdHPGkxn3bBNHjZW9Uu4P4iE/MneOujurTN94qaAWYKzVLfxKkGkvlyMAFaqydNKt
         SogONMvQUQDPIV/Jkm90yZCHhA0qBqdpLzHA9/bSZCeH2o4nh8huw8IUOXnt87fDQ+R4
         WSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Ja2BtXvosgyH0G5/6bb1B50E52ByBEsQokOTZIDL8zY=;
        b=DLRqZ614IHNzhF/g00uQoJWSZiOgv/gsDaG03a6UqWqgU8i3rA8XP1qUPTFRjXznsL
         fukjaW/11yAZ/M3w0/eXnLOVjXnBdrBpz/YdLbpwkglT9gOKJKS658vV9zYACZVSshnq
         7D12DThNamhjMuzRa8en+DW0qCrve6BjTVNm1kv2QkbbYivWilOij482l0VvUBysKZSP
         SX254wZtFdJhZeM6qLMb/VngCImKxZLnng9x3eoCBxhsJdYfmmldesgpTaxQ6vhcNt8u
         rFO4R2OyZRLlnl6wbTNMueGjyjw3myHMOvMX3w8k7/SG6S2DyqZF0yQcxFazZVLKQPmH
         dDFA==
X-Gm-Message-State: AJaThX47+XFNt9ZFNhkWPNbqV9F1Dhgm+oL2IlgQfm6PcnhlT5bCD1gd
        kmJar2EnWkpB1aXTLQdlCSM/K+YrF+MPKzAD2b6+8w==
X-Google-Smtp-Source: ABhQp+S1cNjQLYyAzzMB13Nw4RUMBYJpfVfiOIMrBn5dl2eA/U55mmEKQmDmPX7gt+VulpQu00mTg9vfbi/+Em8kCkc=
X-Received: by 10.223.174.142 with SMTP id y14mr2672915wrc.222.1510310067019;
 Fri, 10 Nov 2017 02:34:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.164.154 with HTTP; Fri, 10 Nov 2017 02:34:26 -0800 (PST)
From:   Sergey Sharybin <sergey.vfx@gmail.com>
Date:   Fri, 10 Nov 2017 11:34:26 +0100
Message-ID: <CAErtv26OrSVch=X8pi1Yf3s79B8SKD6fqfxhsEyMtt8B=TaqMg@mail.gmail.com>
Subject: `git commit -a` stages ignored submodules?
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

There seems to be a difference how Git 2.15.0 handles submodules in
comparison with 2.14.2.

In Git 2.14.2 `git commit -a` will not stage submodules which has
`ignore = all` set in their .gitmodule section. However, in Git 2.15.0
`git commit -a` will stage all submodules no matter what their
"ignore" setting is set to, and also no matter if submodule path is in
.gitignore.

Didn't see anything explicit about this in release logs. Is it an
expected new behavior?It is till possible to keep `git commit -a` to
ignore submodules which are configured to be ignored?

-- 
With best regards, Sergey Sharybin
