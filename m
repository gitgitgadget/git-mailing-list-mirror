Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BA8C433F5
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 15:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 551EF60F6E
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 15:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbhJIPOa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Oct 2021 11:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbhJIPO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Oct 2021 11:14:29 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824E1C061570
        for <git@vger.kernel.org>; Sat,  9 Oct 2021 08:12:32 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t16so25977871eds.9
        for <git@vger.kernel.org>; Sat, 09 Oct 2021 08:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=RLXGv1wdHg17JNCIOuo8od8ZIjZB8zgzaHyQUKps3S8=;
        b=itO84BHfNiFvRLYgxgHdcMqlBFbVxLoHAp5SrHeEksFcRj0CX2gCaFmg9Jja0W1qma
         mITM9s0BMET2wKAtyvwHapGKXBS/X+qy3IhbczAgn1vGFs+Or9N8Y1UiEVcZiXMacwIP
         G6vSzjfapBOeP1PdAEk79P/BaaanH3FWn5LuYrbbnEYcPytlURu7xmQ2auKbp6jnB8Is
         onUSvua7X5ef5jmj03KfUive/9EjPlMvoiqXC1W2HjqQeCVUcXxdBxKGCBmZclAxJ0Gf
         QtxH5eywwF1efT3gJ4TBqf41VbXdnjxb8tibA5REMTFrKFEsaJVJ/O1q+wk7mxQEJI4e
         FIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=RLXGv1wdHg17JNCIOuo8od8ZIjZB8zgzaHyQUKps3S8=;
        b=QfnrxPFVV4Ar+b8ibXRTXs4z3b6nLG8O1CjVS+I+W+UmksbklT7XPNuI2TXduzn/V0
         UQSrOyDXvrHmJDcHUlVOnrnRXG5PJES5lXK5mOWE0UCBNj1Q3XVcUS5CBp2aQqR8RS8S
         SK1o/m3XFgFqnXIICqyp3ljYaKWiIciRkO7guCKoa+shrZXi0PjPvuq6i1i+QrbTPT2Q
         YBlebmSMhw8gGKPY828J/GDJXyCXoPXSsa9hmWhaBmOaYGCXCtomsnI74SwBwNWM7a08
         fa86KeCRu33A99zgOn0LOG5YYjwR/W85GI9JWQUsXCg9a8mgl9SrPedYC+OwtOQO94UQ
         7Y7A==
X-Gm-Message-State: AOAM5311smZUJF9iFgnL9zF4IqxIrfz7q7YKB/40/F92LpCmoLBtqZS4
        N9Xuq5yKP9hmuCbjlR9tN2+99bBufHqqmA==
X-Google-Smtp-Source: ABdhPJyX14cVj0TL7SJNELcKFfeQQy0eJKhPyo5Rz8cp/nPaOAp+UEYbHh/iu1bWXxZxdzAzkTK4lg==
X-Received: by 2002:a50:e043:: with SMTP id g3mr24947523edl.196.1633792350969;
        Sat, 09 Oct 2021 08:12:30 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id og39sm1073736ejc.93.2021.10.09.08.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 08:12:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: "git reflog expire" blindly trusting timestamps in reflogs
Date:   Sat, 09 Oct 2021 16:57:20 +0200
References: <b25ac1cc-8e77-17e6-602a-b289c1e1cfeb@web.de>
 <30df5e39-3f2a-00d8-541b-347c43f36b38@gmail.com>
 <581663a7-9b16-e464-ada7-368f20c99ff1@web.de> <xmqqsfxersvy.fsf@gitster.g>
 <ba3e16f7-bf9c-c5f3-4c0d-8288db6f44c7@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <ba3e16f7-bf9c-c5f3-4c0d-8288db6f44c7@web.de>
Message-ID: <87wnmmkzaa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


[Changed subject]

On Sat, Oct 09 2021, Ren=C3=A9 Scharfe wrote:

> Turn off automatic background maintenance for perf tests by default to
> avoid interference with performance measurements.

Turning off background GC during the perf tests seems like a good idea
in general, so I think this patch should go in. Even with the WIP
(haven't picked it up again in a while) test mode I menitoned in[1] it
still wouldn't make any sense to run detached background GC in t/perf.

Because first of all we take the repo as-is (hardlinks and all), so
changing it is a bug in itself.

But...

> Do that by using the
> new file t/perf/config and using it as the system config file for perf
> tests.  Future tests intended to measure gc performance can override
> the setting locally or call "git gc" explicitly.
>
> This fixes a breakage in p2000 caused by gc automatically emptying the
> reflog due its fake dates from 2005 being older than 90 days.

I think the behavior of git-reflog is probably just broken here and
needs fixing in general.

I.e. we don't actually change the ctime the relevant reflog files, so
surely this is pointing to deeper edge cases where e.g. someone might
import old history, only to see it wiped away due to the commits being
"old", but the mtime is just seconds/minutes old...

But I never had the time/chance to dig into that, maybe there's a good
reason for it.

Of course we can't rely on *just* the mtime since the whole point is to
expire older entries, we need to walk the file and trust the timestamps
therein. See the show_one_reflog_ent().

But my recollection & reading of [2] is that we nuke the whole
file. Surely we should have a "uh oh?" safeguard when we encounter a
file whose tip timestamp_t is from 2005, it's 2021, and our lstat()
mtime says it was changed seconds ago.

I.e. shouldn't reflog expiry at least have the invariant that nothing
should expire in a given file if the tip commit is old enough to be
expired, *AND* the mtime of the file is more recent than the expiry
epoch, because such a scenario points to either git's own test suite
(and we should just fake up the time there), or that we're about to
corrupt some user's repository because they're either doing similar
import work, or their clock was screwy?

> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  t/perf/config      | 2 ++
>  t/perf/perf-lib.sh | 4 ++++
>  2 files changed, 6 insertions(+)
>  create mode 100644 t/perf/config
>
> diff --git a/t/perf/config b/t/perf/config
> new file mode 100644
> index 0000000000..b92768b039
> --- /dev/null
> +++ b/t/perf/config
> @@ -0,0 +1,2 @@
> +[gc]
> +	auto =3D 0
> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index f74cfd35d6..4c4c568a37 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -27,6 +27,10 @@ TEST_NO_MALLOC_CHECK=3Dt
>
>  . ../test-lib.sh
>
> +unset GIT_CONFIG_NOSYSTEM
> +GIT_CONFIG_SYSTEM=3D"$TEST_DIRECTORY/perf/config"
> +export GIT_CONFIG_SYSTEM
> +
>  if test -n "$GIT_TEST_INSTALLED" -a -z "$PERF_SET_GIT_TEST_INSTALLED"
>  then
>  	error "Do not use GIT_TEST_INSTALLED with the perf tests.

1. https://lore.kernel.org/git/8735pfjg47.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/b25ac1cc-8e77-17e6-602a-b289c1e1cfeb@web.de/
