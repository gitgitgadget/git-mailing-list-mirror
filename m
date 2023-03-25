Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EADC6FD1F
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 09:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjCYJJ3 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 25 Mar 2023 05:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjCYJJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 05:09:28 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288399034
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 02:09:27 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id z18so2404274pgj.13
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 02:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679735366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mh4o2SumimjG1WQ7OHcJW9PXt2Q4TqE7ULP9VW/YB/c=;
        b=r4iOktyo8T89Ny8OP/wb1mVsvVJlc4Mna7WBtP0280kCTSXRl47cdfrkvfZkC+jEyw
         X1v03cPnTo0Ii752Bb7hzmwtSdx8z7HmEDI/Zn5+I4LmWUnuiuzOkDPktWWASJQFyziZ
         P7dAy6V0ABalO6ypJZtfofgXJjhiFqVSokJ94/2Rb74QiGeR9Lir2Vm6XpyStw2Q/0kr
         H981mD+P3BHlIbHkBC7xBp2Wh30qPiWpC57QgbqiaNgaNpoM/luxIm/wj9q/IjxafA08
         WN2MvxbvTKeSupc9N+soXAi40eav8bp2MQT2Px/su8dn7sgDsjRp8WAVsLTbH9ilbqWh
         FmcQ==
X-Gm-Message-State: AAQBX9e5SzsxzzdHmWh+50csjYHodBoQzcmpPpZMpUa2GL7d5IlI6/68
        ML7wvZHSYhw4KpKUk4T9/VCU7HRVVsUN3GAA4dM=
X-Google-Smtp-Source: AKy350bGv3cEbEI/SBaUIWuGcBklyruyidqIbYUWw+6nkk6B4Rx1CjqNRkpvHjTyjN4x9kT0PXwzxGn7HIwItbMyMuo=
X-Received: by 2002:a63:60d:0:b0:4fb:9902:fc4a with SMTP id
 13-20020a63060d000000b004fb9902fc4amr1399620pgg.10.1679735366491; Sat, 25 Mar
 2023 02:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <13accf6f99d367d137eefd02e3f6bf05bf099e00.1679328580.git.phillip.wood@dunelm.org.uk>
 <3714ba2f6528c38eb9c438126316a08b0cefca7c.1679696180.git.git@grubix.eu>
 <20230325063731.GB562387@coredump.intra.peff.net> <CAPig+cT9zjP++ECkTMjh33gzWyh_ho6n8_XYkXTHxnuGiDbnow@mail.gmail.com>
 <20230325075832.GA579632@coredump.intra.peff.net> <20230325080453.GA852237@coredump.intra.peff.net>
 <CAPig+cTBwAugUL_u_SPebFRj4j1Gv6FMuH8vn+uUy=6_+GXy3A@mail.gmail.com>
 <20230325084107.GB3738217@coredump.intra.peff.net> <20230325085127.GA26684@coredump.intra.peff.net>
In-Reply-To: <20230325085127.GA26684@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 25 Mar 2023 05:09:15 -0400
Message-ID: <CAPig+cQtLFX4PgXyyK_AAkCvg4Aw2RAC5MmLbib-aHHgTBcDuw@mail.gmail.com>
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

On Sat, Mar 25, 2023 at 4:51 AM Jeff King <peff@peff.net> wrote:
> On Sat, Mar 25, 2023 at 04:41:08AM -0400, Jeff King wrote:
> > Right, the chainlint.pl one is much more thorough. I just wondered if
> > there were any cases we were worried about it missing, that the internal
> > one catches. We found one in this thread, but as discussed, it is not a
> > problem (presumably chainlint.pl catches a "real" case where an
> > earlier line is hidden by the "&", but I wouldn't mind seeing it
> > complain here as a matter of style/future-proofing).
>
> Hmm, actually chainlint.pl does not seem to catch this:
>
> -- >8 --
> test_expect_success 'ok, first line cannot break &&-chain' '
>         true &
>         pid=$!
> '
>
> test_expect_success 'not ok, failure is lost' '
>         false &&
>         true &
>         pid=$!
> '
> -- >8 --

Right, that's one of the "special cases" I mentioned earlier; an
intentional simplification of implementation to keep the complexity
level down. Although the linter is genuinely parsing the shell code,
it doesn't really understand or check shell semantics, and is just
using simple heuristics to detect the common types of &&-breakage and
missing `return 1`.

This particular simplification is that if it encounters one of the
special cases in which some construct (such as "&") should not be
considered as a break in the &&-chain, it clears all "??AMP??" flags
which come before that point in the current parse context.

More specifically, it's not even building a parse tree; it's just
trying to detect problems on-the-fly as it parses, so when it finds
something like "&" which is _not_ a breakage, it can't easily go back
and recheck which earlier "??AMP??" annotations are still needed. So,
it just clears the earlier ones unconditionally with the hope of not
letting too many false-negatives through. It would certainly be
possible to make it do a better job of detection, but doing so would
complicate the code quite a bit. (Eventually, I think it would be best
to build a parse tree, which would make it easier to incorporate other
linting ideas I have in mind, but I don't have any immediate plans to
do so.)

> It's a little funny, because we actually background the whole "false &&
> true" chain. So if you did "wait $pid" at the end, you would see the
> failure. But the test in this thread doesn't actually do that (it
> depends on kill after 2 seconds not finding the pid). Plus in general
> this seems like an accident that we should be flagging.

As above, it was a judgement call regarding linter implementation
complexity versus letting a few potential breakages slip through
undetected. As it stands, we get a pretty big pay off detecting >99.9%
of real-world breakage without the additional complexity. (That is not
an argument against improving its accuracy in the future, but rather
an explanation of the current state of the linter.)
