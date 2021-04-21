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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DA8C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 07:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFAF460FDC
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 07:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236726AbhDUHIw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 03:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbhDUHIq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 03:08:46 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15989C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 00:08:12 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id j12so23011023edy.3
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 00:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=FTmggB3QZ3ZyjJ85nzmE6TVesey+XaN5TCeqxDJHXkc=;
        b=GuLsCG28ok4fzDJsXxu/8KIGGfiPZ3M6EVRU94fz9UCtLHYVfBmdnAiR9ILjtRnkBb
         r0zSeNFsmptwv6LvMpDYKbMJGSgenXkI4ZIWCW/bI9kBUwNMj0j1D9AFcJ+kSx3SJJh+
         AJFdJEZeqv9a8a2UZylaB5iaeX/gHQB4XiNXUwrqxE0WsPdoE5VSnTXPNbdmhnqtib65
         1MUWrAOS+8OZjAX18LcDYvFSbe4sE1xKpC0LNc57m8i1PTHZnPsrUskUcOdqCLbLFyoB
         6NdKPvPYKk5OkJa7+EbQL6lck+9qRbz2fp06rxsgVykWmdLDw2w1CAf+IqiGiHH/pNpX
         WB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=FTmggB3QZ3ZyjJ85nzmE6TVesey+XaN5TCeqxDJHXkc=;
        b=A9rA+OB3ca6fWjtIcWea3N6la9MFaYe1W/88Yz6hA51ttJmBwFjCjYha+Y550AkDpD
         tdenVFinGRvl8X+qfpzBK3J43BEQZte/35pufQVfLZ0n6/NGbECYBw1XD298JWc9EEUx
         kjy7ipbj+5yRYzTuO2uqfYdypkujtd8VO0FImBvcgVKxOdrw0tugQ9lYwQMlEXc349us
         qYgwZDE1F2+pZVrpdiK9bL+dlq39PsRWWXqYtHersL4R4/P+qol89xMB+qcw4oq1+wr7
         gQkERc4DDqh1ZvKZlo9SkDe6DNODZEqVd4jIREsIGU4PlyDakSAGzsACfdPVcISl32vv
         PHZQ==
X-Gm-Message-State: AOAM533nsAyljKRZdF/PurNHURIUGq3acvXeLuoWiAk3Wr69yx/RuCnL
        D0pPNvlEZgK0Mm8r7QMKO2B/zg8ZfL/4+w==
X-Google-Smtp-Source: ABdhPJwXp9q78OwrC+HxlY9vyCT+PfLEgKTmkvRZBR0idrcP2Gh/RdHdm4Oc/zTtiAaCrGFMPSV43A==
X-Received: by 2002:a05:6402:1109:: with SMTP id u9mr37325478edv.174.1618988890600;
        Wed, 21 Apr 2021 00:08:10 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id z22sm1357269ejr.60.2021.04.21.00.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 00:08:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 17/18] t4202: mark bogus head hash test with REFFILES
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <a2cce772d44f5939475a1dfddc1a55ab9bbb8ac5.1618829584.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <a2cce772d44f5939475a1dfddc1a55ab9bbb8ac5.1618829584.git.gitgitgadget@gmail.com>
Date:   Wed, 21 Apr 2021 09:08:09 +0200
Message-ID: <87eef43yjq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 19 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> In reftable, hashes are correctly formed by design

With the file backend this hits this in revision.c:

        if (!refname || !(flags & REF_ISSYMREF) || (flags & REF_ISBROKEN))
                die(_("your current branch appears to be broken"));

There's a REF_ISBROKEN is the reftable code, so is hitting this codepath
impossible under reftable and therefore we won't need this test at all?

Maybe, and that would be cool, but re [1]'s 3rd item ("[...]what we
*don't* cover[...]") shouldn't revision.c have a "if (reftable) BUG()"
condition there then?

1. https://lore.kernel.org/git/87wnt2th1v.fsf@evledraar.gmail.com/

> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t4202-log.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index c575deaad4fb..ed6d4ecd3a28 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -1834,7 +1834,7 @@ test_expect_success 'log --graph --no-walk is forbidden' '
>  	test_must_fail git log --graph --no-walk
>  '
>  
> -test_expect_success 'log diagnoses bogus HEAD hash' '
> +test_expect_success REFFILES 'log diagnoses bogus HEAD hash' '
>  	git init empty &&
>  	test_must_fail git -C empty log 2>stderr &&
>  	test_i18ngrep does.not.have.any.commits stderr &&

