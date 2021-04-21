Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F265C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 06:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C7F961422
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 06:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbhDUGX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 02:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235900AbhDUGX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 02:23:58 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0905C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 23:23:25 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s15so47931730edd.4
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 23:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=tMFi35V0gjYMhOn5l+ehcz3TTJoP+/OgHh1Tm+aAd4c=;
        b=EYKm5MFAT0pjlxD+3p+gGpyCIPyYHRAcRMhlxn8h9NFiEc6n45a2VNsgm7buu6SY2W
         u+VhK7W90EZINN4LbtuFHO1EZ8r19CHNhJriVYbFfJoJ+o4H4FtgCrkcDSa0M1UChw1y
         na4w7CsCEBrM5ebe5fWdmh1YvHB9Q/0GCQkTNdLsMNVU/bIBvbE3aSUsM/jzPjko3yOv
         0SseqT4WRvAa432ZjhCE4YYFcGWMRWpHFK/ABARciwAx3F9vvXM1QAYojd5pAVXIn3jk
         HUkW44QfS4/yQi+dBGYoXtj6dy71huW9uYlE0ZkeJTOu/q07oornvYOWeOoVzSImktPj
         FjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=tMFi35V0gjYMhOn5l+ehcz3TTJoP+/OgHh1Tm+aAd4c=;
        b=GrCa/bf2Ciudvb6xxw8J8Va/dBeQhLnF4C2YqYTv8hgiNbsra9ppWgZjSq0cB4oM2O
         Jj+yQsBHzgo+hSPX31AhQPIUlgz70xCmdmzmaX+8xUHCxZA6wRDs3G1gCur9qWjBYlpV
         zGYLIM1DsEpHJzg9b04k5JFh4QpuL5CxFOjIjuhnOkMnlSy78eyJIHm/S8K0vOs9B+fy
         G2P8h4RTZeS6JaH1m3BSZgaie9Rs733Bx6EKRyD4KhJIrIVHFYKRhoID8Xx8AxbX+XrX
         0cYiA5gfuHSOWuo9H5FkCgZLWTCF8KsaUD2um6JteJIKNDUai5fvfPK8owQn262Qy3uR
         iBfQ==
X-Gm-Message-State: AOAM5323davSDqSLlZL0habIZ1nfvsoawV6UKVJhmED4R1OG2Zmm7YRt
        /VGwlU9aAZ2Y+I5mpm++sEXqerFlLZU1Ew==
X-Google-Smtp-Source: ABdhPJzWl4ZrEe+tVfjPbd4fHfMob49RT1b9vugFzaq53kmfRxxC/ofijZ+1Gi9KJ7t/gwzM+q1xSg==
X-Received: by 2002:aa7:c683:: with SMTP id n3mr35778552edq.214.1618986204363;
        Tue, 20 Apr 2021 23:23:24 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c7sm1765843edt.84.2021.04.20.23.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 23:23:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 11/18] t1407: require REFFILES for for_each_reflog test
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <dd1f6969c28d95027d1ac9f7b6f6a43640babada.1618829583.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <dd1f6969c28d95027d1ac9f7b6f6a43640babada.1618829583.git.gitgitgadget@gmail.com>
Date:   Wed, 21 Apr 2021 08:23:23 +0200
Message-ID: <87sg3k40mc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 19 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> It tries to setup a reflog by catting to .git/logs/
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t1407-worktree-ref-store.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t1407-worktree-ref-store.sh b/t/t1407-worktree-ref-store.sh
> index d3fe77751122..27b57f248a94 100755
> --- a/t/t1407-worktree-ref-store.sh
> +++ b/t/t1407-worktree-ref-store.sh
> @@ -52,7 +52,7 @@ test_expect_success 'create_symref(FOO, refs/heads/main)' '
>  	test_cmp expected actual
>  '
>  
> -test_expect_success 'for_each_reflog()' '
> +test_expect_success REFFILES 'for_each_reflog()' '
>  	echo $ZERO_OID > .git/logs/PSEUDO-MAIN &&
>  	mkdir -p     .git/logs/refs/bisect &&
>  	echo $ZERO_OID > .git/logs/refs/bisect/random &&

Hrm, so already the first use of REFFILES has me questioning the need
for it.

I mean obviously this depends on ref-files in the strict sense.

But it seems to me that there's two classes of those issues:

 A. Test where we inherently depend 100% on "reffiles", e.g. the later
    tests of "empty directories" in .git/refs/, presumably there's no
    equivalent of those in reftable.

 B. Tests that are really wanting to test some specific type of ref
    corruption, that could (or not!) happen under reftable, but just
    uses ref files for the setup now.

I think (but am not sure) that this is the latter case. I.e. the
distiniction I noted in [1].

Just skimming the context I wonder which of these can/can't happen under
reftable:

 * We have a PSEUDO-MAIN ref
 * It's set to $ZERO_OID
 * We have a $ZERO_OID in a refs/bisect/random

Etc., the test is just a setup for a call to refs_for_each_reflog().

If I'm wrong and it really is a case of "A" then presumably that has
implications down to refs/iterator.c and beyond.

I don't think we need to exhaustively dig into every one of these for
some initial pass at getting the test suite running, but again re [1] I
worry that if we over-skip we'll end up not marking the distinction
between "A" and "B" above, and thus will have an end-state of losing
test coverage.

1. https://lore.kernel.org/git/87wnt2th1v.fsf@evledraar.gmail.com/
