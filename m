Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F0AC433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 12:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF05F6108E
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 12:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbhITMQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 08:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbhITMQy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 08:16:54 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EF0C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 05:15:28 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t10so60685290lfd.8
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 05:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=JNi+PxUlcBTxhDNaPrhg9evTg+Cw5covteG/A57Bf90=;
        b=ikjE4pvLEoAxV27/Ju6hz6yfj3/G1kSkAyXFrcaFukS4el4EMPbe/gtCZYZuuCAria
         lW1j3kVXxo0kc+n0WHMX0do5CyGXrMqPvx6tg6WTSCwgaBSYewK+68uER+S4TX/rA080
         hKk49jmCeWlGfR6MNMBt225N14aYftI2wLYw9xRR9lHlEiK7AUkOnQKl8XxnP2GO7wcY
         RPUuUOohhQGBya6DZOGdCiVNfLLu6sDmH/pYTeJJQrDapn1tdzOf4BjmCq31U2jbr90D
         O6fF3a3UniJb1ppuJv9VuGXL9fd4OMe/3lkn7vYXVB+9XZPpLtd5yKg019v48xpoSgtQ
         Y8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JNi+PxUlcBTxhDNaPrhg9evTg+Cw5covteG/A57Bf90=;
        b=4jnuaYBCUNFRX7QEaqt+C+MVHpzXRj+DnZ/VZPZeM5yQ+BPcYqJeilVYy0eoLOyQQ7
         ddcmLeXM/HJVCn0dcA3msLm0oaXoVV4ujLVJYIm/jFjofObKrgNXuOYiq3zp5fReV1V1
         cQFiz+ezy8+or7psb96YudNOsGgg7EI+ZyYrXVDUITWWKGXIJiA/0/9wfc5Xhr5L0Pax
         MpSZvHo0sES/KVgiXHOvJLCdgzsnfIbUBBUzgoAC1DpUza0/uh4J5FzqTUVhNiCCkx7K
         tsAV+dHxlHlP+H9Ad0PFPm7J2MPllfN8Ezv0RZsnOW4omvfsr2ClgKOHVvBWEX0LA5wL
         +seA==
X-Gm-Message-State: AOAM532JWwFX3irHQeJDqG1aWeAlqKai2V8K1X2sCzZqYixYkOD+yhlX
        M01X1WYRWgFo7LqS9/ealBPGqKv+D/sAz1JP7FA6JOm9D3AwhQ==
X-Google-Smtp-Source: ABdhPJyQ3pM1q2tYNxQPUtEoRPzLQ8BUbiFIeTCyBhVrvK/f+ApiM/Vy06bEWHAtwm20/Mn7b8/7pSXqCE3JOg3AAOE=
X-Received: by 2002:a19:f00d:: with SMTP id p13mr19636135lfc.239.1632140125963;
 Mon, 20 Sep 2021 05:15:25 -0700 (PDT)
MIME-Version: 1.0
From:   Calbabreaker <calbabreaker@gmail.com>
Date:   Mon, 20 Sep 2021 21:45:14 +0930
Message-ID: <CAKRwm5a9PyqffEC5N__urSpNcZ-d5vz9GBM2Ei16eGS25B=-FQ@mail.gmail.com>
Subject: Memory leak with sparse-checkout
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

This was ran:

git clone https://github.com/Calbabreaker/piano --sparse
cd piano
git sparse-checkout add any_text
git checkout deploy-frontend
git sparse-checkout init --cone
git sparse-checkout add any_text

Basically clone any repository with --sparse, add anything to
sparse-checkout list
then checkout to another branch, init the sparse-checkout with --cone and add
anything to it again.

What did you expect to happen? (Expected behavior)

Nothing at all except for the sparse-checkout list to be updated.

What happened instead? (Actual behavior)

A massive memory leak using all the RAM with one of the cpu cores
being at 100% usage.

[System Info]
git version:
git version 2.33.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.10.63-1-MANJARO #1 SMP PREEMPT Wed Sep 8 14:13:59 UTC 2021 x86_64
compiler info: gnuc: 11.1
libc info: glibc: 2.33
$SHELL (typically, interactive shell): /usr/bin/zsh
