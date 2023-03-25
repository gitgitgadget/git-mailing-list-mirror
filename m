Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2382C6FD1F
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 08:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjCYIGx convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 25 Mar 2023 04:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYIGw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 04:06:52 -0400
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7186A12841
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 01:06:51 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id d8so2386113pgm.3
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 01:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679731611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8mtjoIYqECyl+dRpMh7oB/TbpRLq8utc2Eyf91ar7o=;
        b=IREQDMa9/ts46cYBqzWaYevfjRR3kfm4ZSRDsofYSbR6VwK5OrKQP61of1Tyr4qe05
         CkyflT4kwPDplUFiYQRgCNcFLhE8dcftpE07NbTcymmgUCBaNX8CGf895C5Iacw9C2pU
         IQGMGiCGlkqNdDoG22UzmciQOC4xCXhVo4moJtnMujYJ9kWL/NXGD/cACGnSYybLVXbR
         qwG8r9DSQTtCL8ivUULF7sKVtlHFauZWsB7jEDuuQyE9ehuu+KSezQHYgAjJDVZDVwP3
         /OayCDeb7mptesyjIEb9W47a5AQt9HAoqvEgI37fbMRktNQf/g4RU6HV5cR4cMCXGKYR
         3O1A==
X-Gm-Message-State: AAQBX9cAbq6RgMC/Znqa/XG76M3Bf9t8aAqU7zZME73mizEIgW8aAiGx
        rVCQ0XxtGvnPlKGeWJsH3oDEwCSyyrq6ExIuJug=
X-Google-Smtp-Source: AKy350YhB1KzVw2gmDaOhUp+fHpw4ei5kj/od4kJJe/QFMZ3lmoToYZh0oMAHVY4gH4bt4nC0LkC7Z5fn0oNjHmWK1s=
X-Received: by 2002:a05:6a00:180c:b0:625:c55f:bc66 with SMTP id
 y12-20020a056a00180c00b00625c55fbc66mr2770899pfa.4.1679731610778; Sat, 25 Mar
 2023 01:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <13accf6f99d367d137eefd02e3f6bf05bf099e00.1679328580.git.phillip.wood@dunelm.org.uk>
 <3714ba2f6528c38eb9c438126316a08b0cefca7c.1679696180.git.git@grubix.eu>
 <20230325063731.GB562387@coredump.intra.peff.net> <CAPig+cT9zjP++ECkTMjh33gzWyh_ho6n8_XYkXTHxnuGiDbnow@mail.gmail.com>
 <20230325075832.GA579632@coredump.intra.peff.net>
In-Reply-To: <20230325075832.GA579632@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 25 Mar 2023 04:06:39 -0400
Message-ID: <CAPig+cSdBTeeWX-UAoUXzt1b+nC=xRgtPTHgtg+kSBAbeCKedg@mail.gmail.com>
Subject: Re: [PATCH] t3070: make chain lint tester happy
To:     Jeff King <peff@peff.net>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2023 at 3:58 AM Jeff King <peff@peff.net> wrote:
> On Sat, Mar 25, 2023 at 02:54:45AM -0400, Eric Sunshine wrote:
> > I am unable to reproduce any linting errors when running this script
> > through chainlint, which is why I was more than a little confused by
> > this patch when I read it, and I was just about to ask for more
> > information, such as the actual error message.
>
> It's not your chain-lint script, but rather the builtin one that sticks
> "(exit 117) &&" in front of the snippet and evals it. So it creates the
> exact "foo && bar &" situation by prepending a line to the snippet.

Thanks for clarifying that. I failed to infer that from the commit message.

> So running (on seen, which has 1f2e05f0b79):
>
>   ./t3070-wildmatch.sh
>
> gives me:
>
>   ok 1890 - ipathmatch (via ls-files): match '[Z-y]' 'Z'
>   error: bug in the test script: broken &&-chain or run-away HERE-DOC:
>         test-tool wildmatch wildmatch \
>                 aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab \
>                 "*a*a*a*a*a*a*a*a*a*a*a*a*a*a*a*a" &
>         pid=$! &&
>         sleep 2 &&
>         ! kill $!

Yes, I can reproduce it now. My mistake was that I tested 'seen'
rather than 1f2e05f0b79, not realizing that Junio had already applied
Michael's patch. (I meant to check if it had been applied, but forgot
to do so.)
