Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3944A1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 18:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388133AbeGWTMN (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 15:12:13 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34913 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387861AbeGWTMM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 15:12:12 -0400
Received: by mail-yw0-f195.google.com with SMTP id t18-v6so563976ywg.2
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 11:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F2Uf+BpDgBnTycAbVITmIUmmgTFhPjxlPodUpNsOlHs=;
        b=asHJo8ou9Y3h16uUQ6IZrtruF1c6M6FTx+Z3DN0y7lDjm3EiUPF6Sx1Cd23qjsMrSC
         myAynFL4amzN6DLrCDADY65BfQSz1IQp3mbe0m4pfAKHuosTdTIx4ErvhrqP9RqM9goQ
         tAXaK+eIn3qa47r6YvSqXX8cNt2uy7frDyAnOSBHaRtuKeySFaBChUCh3aZNehrqakPg
         +OF/fAdcMTxMJJJWUS3IEw5VFb20PP553y2Sby7YC9E3U11UYKomAFdnrSVGmf0CfYyG
         9ZTb/Ddod8RM29l92OEqcE5aBzDyjUdlZ81aszhwfy4W7m+Spqgm0cNzxUbbTw+yzume
         CNwQ==
X-Gm-Message-State: AOUpUlF7pNHykUEB573hDYM7n0FnNdnwNqZF0DyvAVk/wO91On18W7Bp
        fJkB94kJVeQIkRUb9qpOFHUgaeqng1aAR+M44GE=
X-Google-Smtp-Source: AAOMgpcDmZRz9Es+1vhsa56ty1bJK2omM1cIOSnrgesvXvXEfI+LKBWP0EKIeCo8LkmZ8qbgQ/PTneEuBRITD5T+TF4=
X-Received: by 2002:a81:1001:: with SMTP id 1-v6mr7321442ywq.120.1532369387862;
 Mon, 23 Jul 2018 11:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <5a8d1098-b4c5-64e1-da98-dac13521e7ba@gmail.com>
 <20180721063428.20518-1-newren@gmail.com> <20180721063428.20518-2-newren@gmail.com>
 <CAPig+cTjQ74gOt8gJbYUBaTRsHBvqtcmucoVdiudFt2TrhCn+g@mail.gmail.com> <b56598a1-e543-500a-a39b-cee07fe1e533@gmail.com>
In-Reply-To: <b56598a1-e543-500a-a39b-cee07fe1e533@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 23 Jul 2018 14:09:36 -0400
Message-ID: <CAPig+cR3ic5OAAhNNaSu3YXMnpm=zw6XjspYSU4jouH6po05gg@mail.gmail.com>
Subject: Re: [PATCH 1/2] t3507: add a testcase showing failure with sparse checkout
To:     Ben Peart <peartben@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>, kewillf@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 9:12 AM Ben Peart <peartben@gmail.com> wrote:
> On 7/21/2018 3:21 AM, Eric Sunshine wrote:
> > On Sat, Jul 21, 2018 at 2:34 AM Elijah Newren <newren@gmail.com> wrote:
> >> +       rm .git/info/sparse-checkout
> >
> > Should this cleanup be done by test_when_finished()?
>
> I think trying to use test_when_finished() for this really degrades the
> readability of the test.  See below:
>
> test_expect_success 'failed cherry-pick with sparse-checkout' '
>         pristine_detach initial &&
>         test_config core.sparsecheckout true &&
>         echo /unrelated >.git/info/sparse-checkout &&
>         git read-tree --reset -u HEAD &&
>         test_when_finished "echo \"/*\" >.git/info/sparse-checkout && git
> read-tree --reset -u HEAD && rm .git/info/sparse-checkout" &&
>         test_must_fail git cherry-pick -Xours picked>actual &&
>         test_i18ngrep ! "Changes not staged for commit:" actual
> '
>
> Given it takes multiple commands, I'd prefer to keep the setup and
> cleanup of the sparse checkout settings symmetrical.

Some observations:

The test_when_finished() ought to be called before the initial
git-read-tree, otherwise you risk leaving a .git/info/sparse-checkout
sitting around if git-read-tree fails.

The tear-down code could be moved to a function, in which case,
test_when_finished() would simply call that function.

Multi-line quoted strings are valid, so you don't need to string out
all the tear-down steps on a single line like that, and instead spread
them across multiple lines to improve readability.

test_when_finished() doesn't expect just a single quoted string as
argument. In fact, it can take many (unquoted) arguments, which also
allows you to spread the tear-down steps over multiple lines to
improve readability.

Multiple test_when_finished() invocations are allowed, so you could
spread out the tear-down commands that way (though they'd have to be
in reverse order, which would be bad for readability in this case,
thus not recommended).

Correctness ought to trump readability, not the other way around.

So, one possibility, which seems pretty readable to me:

    test_expect_failure 'failed cherry-pick with sparse-checkout' '
       pristine_detach initial &&
       test_config core.sparseCheckout true &&
       test_when_finished "
           echo \"/*\" >.git/info/sparse-checkout
           git read-tree --reset -u HEAD
           rm .git/info/sparse-checkout" &&
       echo /unrelated >.git/info/sparse-checkout &&
       git read-tree --reset -u HEAD &&
       test_must_fail git cherry-pick -Xours picked>actual &&
       test_i18ngrep ! "Changes not staged for commit:" actual &&
    '

Notice that I dropped the internal &&-chain in test_when_finish() to
ensure that the final 'rm' is invoked even if the cleanup
git-read-tree fails (though all bets are probably off, anyhow, if it
does fail).
