Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5462FC77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 13:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjEANwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 09:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjEANwN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 09:52:13 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5434195
        for <git@vger.kernel.org>; Mon,  1 May 2023 06:52:09 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50a14564d17so39775846a12.0
        for <git@vger.kernel.org>; Mon, 01 May 2023 06:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682949128; x=1685541128;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pgsmevLve8/0lEEevDIZLEDy2+9V6HmWhs4enmapgAg=;
        b=jDFfMlKZnfFOpBbv3UzMGfw2ktdKUSvcivT9RLKRTHKeGQSUODP90ZSn3dE1fa4XE2
         ALzh6RlzF67peuwOCGcTDLlKM1zCooitPRpgJg7VN5lz/hldhibsG8jUuGE5mqvbUkPx
         2E8tba7CURHx/USNC7Z5lCQsggsFpVcvtsu2wLKxzaZPhKU/J/xKN/6K5nyxJeD0a3Y3
         RTSmFg24jhzx09nrp7MMjFUBKsFxSSeUATEIkG8wH+fjnmvRLPo0OgZKzXBuQQXQKfO9
         KibUk9lnJcDSYdc/zbcmnRaUpoFiVnlZkoksKJXZ1/XXWpGW/uHdgnw0RwhTw64KywqC
         ELQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682949128; x=1685541128;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pgsmevLve8/0lEEevDIZLEDy2+9V6HmWhs4enmapgAg=;
        b=QDdHxMkV6aEO6vyBvj9ecIxUlTU97nlCxXhg5RUqdSbRC/weznllgKaxiIm7BAnjNB
         3t/jRZ0/LPqAbhx+3/RbN2PYoeZRyk8gu5KwrfsH5JX1R+v5BztHsRSkUPoMI17gCAp0
         kHQMvLFsAX4k/PSHgO39BVLo4hOfdGfM+wsAxifey0+ELnICPyiF9uXQGGSOAnpenU2O
         bzUM1NzWxRgQhpCn7t3xk7kk2Bw1wGAY/VDCwutJVRN/DkZx0AQ6jZ8gApT6LXTY5z5x
         dq8zDnU8m1cz8weObmnQndyAEIzNG8/Xo+Iyd1mOxGq+QVdyENNzBkrRiivSPNK2YbEb
         LChA==
X-Gm-Message-State: AC+VfDwQnk0ZbqHDY1XGphWxCZeRvQZ+XQ/q4dblXpNYxT4mISUekZKi
        0GoF0iNc7KQQhgyyvoj15T/6+sxk+ts=
X-Google-Smtp-Source: ACHHUZ78kTxUONs/f1lHxrE8RdkBb/pKTj5bKPb2w3NXocUoJ+c7VYyR0Hj0JGlp12FR2/4NyAHehQ==
X-Received: by 2002:a17:907:da4:b0:953:838a:ed61 with SMTP id go36-20020a1709070da400b00953838aed61mr13007103ejc.30.1682949127567;
        Mon, 01 May 2023 06:52:07 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id d9-20020a17090694c900b0095354acf666sm14898773ejy.92.2023.05.01.06.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 06:52:07 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ptTwk-0008NO-0e;
        Mon, 01 May 2023 15:52:06 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] cocci: remove 'unused.cocci'
Date:   Mon, 01 May 2023 15:27:54 +0200
References: <kl6lzg731xib.fsf@chooglen-macbookpro.roam.corp.google.com>
 <20230420205350.600760-1-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux 12 (bookworm); Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230420205350.600760-1-szeder.dev@gmail.com>
Message-ID: <230501.864jowjh15.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 20 2023, SZEDER G=C3=A1bor wrote:

> When 'unused.cocci' was added in 4f40f6cb73 (cocci: add and apply a
> rule to find "unused" strbufs, 2022-07-05) it found three unused
> strbufs, and when it was generalized in the next commit it managed to
> find an unused string_list as well.  That's four unused variables in
> over 17 years, so apparently we rarely make this mistake.
>
> Unfortunately, applying 'unused.cocci' is quite expensive, e.g. it
> increases the from-scratch runtime of 'make coccicheck' by over 5:30
> minutes or over 160%:
>
>   $ make -s cocciclean
>   $ time make -s coccicheck
>       * new spatch flags
>
>   real    8m56.201s
>   user    0m0.420s
>   sys     0m0.406s
>   $ rm contrib/coccinelle/unused.cocci contrib/coccinelle/tests/unused.*
>   $ make -s cocciclean
>   $ time make -s coccicheck
>       * new spatch flags
>
>   real    3m23.893s
>   user    0m0.228s
>   sys     0m0.247s
>
> That's a lot of runtime spent for not much in return, and arguably an
> unused struct instance sneaking in is not that big of a deal to
> justify the significantly increased runtime.
>
> Remove 'unused.cocci', because we are not getting our CPU cycles'
> worth.

It wasn't something I intended at the time, but arguably the main use of
this rule since it was added was that it served as a canary for the tree
becoming completely broken with coccinelle, due to adding C syntax it
didn't understand:
https://lore.kernel.org/git/220825.86ilmg4mil.gmgdl@evledraar.gmail.com/

So, whatever you think of of how worthwhile it is to spot unused
variables, I think that weighs heavily in its favor. There *are* other
ways to detect those sorts of issues, but as it's currently our only
canary for that issue I don't thin we should remove it.

If we hadn't had unused.cocci we wouldn't be able to apply rules the
functions that use "UNUSED", which have increased a lot in number since
then, and we wouldn't have any way of spotting similar parsing issues.

But it's unfortunate that it's this slow in the from-scratch case.

When we last discussed this I pointed out to you that the main
contribution to the runtime of unused.cocci is parsing
builtin/{log,rebase}.c is pathalogical, but in your reply to that you
seem to not have spotted that (or glossed over it):
https://lore.kernel.org/git/20220831180526.GA1802@szeder.dev/

When I test this locally, doing:

	time make contrib/coccinelle/unused.cocci.patch SPATCH=3Dspatch SPATCH_USE=
_O_DEPENDENCIES=3D

Takes ~2m, but if I first do:

	>builtin/log.c; >builtin/rebase.c

It takes ~1m.

So, even without digging into those issues, if we just skipped those two
files we'd speed this part up by 100%.

I think such an approach would be much better than just removing this
outright, which feels rather heavy-handed.

We could formalize that by creating a "coccicheck-full" category or
whatever, just as we now have "coccicheck-pending".

Then I and the CI could run "full", and you could run "coccicheck" (or
maybe we'd call that "coccicheck-cheap" or something).

I also submitted patches to both make "coccicheck" incremental, and
added an "spatchcache", both of which have since been merged (that tool
is in contrib/).

I understand from previous discussion that you wanted to use "make -s"
all the time, but does your use-case also preclude using spatchcache?

I run "coccicheck" a lot, and haven't personally be bothered by this
particular slowdown since that got merged, since it'll only affect me in
the cases where builtin/{log,rebase}.c and a small list of other files
are changed, and it's otherwise unnoticeable.

It would also be rather trivial to just add some way to specify patterns
on the "make" command-line that we'd "$(filter-out)", would that also
address your particular use-case? I.e.:

	make coccicheck COCCI_RULES_EXCLUDE=3D*unused*

Or whatever.



