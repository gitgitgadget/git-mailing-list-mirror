Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5E37207EB
	for <e@80x24.org>; Thu, 27 Apr 2017 03:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752559AbdD0D5G (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 23:57:06 -0400
Received: from mail-ua0-f180.google.com ([209.85.217.180]:33104 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751986AbdD0D5E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 23:57:04 -0400
Received: by mail-ua0-f180.google.com with SMTP id j59so12558063uad.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 20:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=tc2Wcd46yHejQTriq9XWxd7FJdu63JYa3J0KINlpVJU=;
        b=HpGRYgx+m6Mknkk2OaUKR7jnc+maUntnUX1x+1Jfc+gBm/wydu0Zl/oV1znp0niuq5
         T4OpUGvu29+MJyU3d93JOOQpkInLWBKkiZ0FUSPef8L2OOL1uuyJeYPN3P6geUxPMDe8
         zktUPv7dGV1BtaAjmx7DVflyh9zvyUb1bB8A74Y3qzWagZfSXUoGt9NaM3Q07kcB5neK
         0FoLoEC+aEns3pprhaSiuOY8tfhypEA9McSFx8E/pLaGi3NbfekU1ZVtIWDTs1RmS7YS
         EHPHkPAjGnRmi6RaGxi2esZb0UQvkalqyEPvbKYWB5RONyIi2yRpVkJavWiAgxz5rUVV
         YCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tc2Wcd46yHejQTriq9XWxd7FJdu63JYa3J0KINlpVJU=;
        b=L74lHkzBhNaZXReI4Ybb1FgFNV+ByW4KDd5E2JeyVyOetBvnQQiCmz8FgTiuvKlqpa
         58nIvryFgoPB4DRECBVmTdIWVo/gD4GImepfuS3rYmI5Ns+5QvpbqHVYDudc12T2PRuj
         f+0X09MCFEG9JzrbKJRUYcxy2++u7+/fFEyJEsWDPia7OuZlW4exuAwjIpi5p5tspA0p
         8UURLOp2oJ2iEtXe0ZDCqDC/7Qeu5fobdgjB6BGoKZzsttdTBWHfnVCG4+24DjA+27Ax
         U4r8LsnFlhyhJ4wXBk9I4jTbqCMuxZ8goFicBYNlimc+6eX+SKbU6Pmh1wQfGPreLEj2
         CpyQ==
X-Gm-Message-State: AN3rC/54r+qE/luNQwERm2ckGwFGXKIRrO7O7ikPe3X9hb83hPPWFzg7
        aF6VQuPM0OsIc14ZkzDhtE8Ji6Ek9vV9
X-Received: by 10.176.68.65 with SMTP id m59mr1510563uam.127.1493265423491;
 Wed, 26 Apr 2017 20:57:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.6.105 with HTTP; Wed, 26 Apr 2017 20:56:23 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Wed, 26 Apr 2017 22:56:23 -0500
Message-ID: <CAJZjrdWPezo6=JHcp9mp8C5Pm1uJodSj3Mbgn7ix78MAqpUUXw@mail.gmail.com>
Subject: Question re testing configuration
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I'm a new developer trying to get my feet wet and I'm running into an
issue with the tests that I can't figure out at this point.

I *know* that the changes I'm working on are causing the tests to
fail, but I can't figure out how to induce the failure manually (so
that I can throw gdb at the problem).

Specifically I'm seeing t5000-tar-tree.sh fail (as a result of adding
extra diff_populate_filespec() calls before the estimate_similarity()
loop in diffcore_rename()) on #52 "set up repository with huge blob"
and #55 "set up repository with far-future commit".

If I run the commands fed into test_expect_success in t5000, though
(in an empty repo initialized with git init), making sure to use the
binary compiled with the breaking changes, the command doesn't fail,
so I'm clearly missing something in the testing environment setup when
I try to manually reproduce it.

Can someone point me in the right direction? I've spent some time now
going through t/test-lib.sh and I haven't figured it out yet.

Thanks,
Sam
