Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2439C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 11:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 968F461212
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 11:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237427AbhIPLOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 07:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236774AbhIPLOn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 07:14:43 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF86BC061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 04:13:22 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id v5so15220875edc.2
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 04:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=j/xj1cm7Ubo3BIcC1HzLHYnI7fX/baj4DbOnIKdkvUo=;
        b=DOqYl90jS6hgIYNyVhBH9o6hm0ihPdQzGJima2WO/mmz3S0L3HTbdp2XOfos6HgqOU
         EUOu7YHqiLwm9/LaGWH8Kkp88aAKYMZbf7Tzp19YzrpiqGfDMclnV14D0MLuHdL1qlet
         IDT4WU5q1samZ2xMmng8EjEB2dppSJqqaQ/Tb2WjIXORHkZqcfU5RcNm5gSF3DPHEh3m
         ly1/jG6x8ObeM1lnMrKUIGx5+AqQG3X3bi+OPL0IesmOz7iV+VcBs2kHgdi3DTzfMx5q
         DEKo2hXzcrho3g0mUEGydvD2CJCakWfljex8cVb5ao3aZrWNQgKv7hFOvacVs69BdzJi
         vnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=j/xj1cm7Ubo3BIcC1HzLHYnI7fX/baj4DbOnIKdkvUo=;
        b=k+0EWjxTRxL6Mu9nEwTq5yjT5c2hKBJ5guLuuRX9VyfJzGDuf8saQwyOrP4EpksOgJ
         R2M3w9XnrOmWjdXGYWkdSOQNRrculZ1Is0Cgx2Bs1l7pZVinyzQU+C2nYDTMYqBEEsOA
         EZzcr/xIktpPZqjBW9xyK0aqPLCVC6sVw1AnJwOntSJm7wqfNszSwWfXPi/H9Wzpd77f
         SGKAUbER64WOzCfBOd7IubWJ8S8wHt7XC8ECDADuVZXghqWE+JuPh4+gkhMzICln75u+
         36GcaMv1UZrFuixgvWqcOg2fOxAAO3Re4nHCpV7rgHV0WVllE5+iHzD6qJoH8RKQa+oT
         xXOw==
X-Gm-Message-State: AOAM533B2oxb07rr859XEZhJ1y9FFTxzj/CQaR/8tlYCzK21hPQ56bVa
        PwWn6cJgff7oZJlqi+0zKEU=
X-Google-Smtp-Source: ABdhPJwcmLaYrdrONBrQubCj03e0ui1fDFNYYv0SWKlRqVkj6VYLG9HftZvyAmMbtGn2cneey+ePRg==
X-Received: by 2002:a17:906:e299:: with SMTP id gg25mr5649545ejb.339.1631790801117;
        Thu, 16 Sep 2021 04:13:21 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x25sm1055892ejy.46.2021.09.16.04.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 04:13:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH 2/2] t0000: avoid masking git exit value through pipes
Date:   Thu, 16 Sep 2021 12:45:52 +0200
References: <20210916023706.55760-1-carenas@gmail.com>
 <20210916023706.55760-3-carenas@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210916023706.55760-3-carenas@gmail.com>
Message-ID: <871r5ohiy7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 15 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> 9af0b8dbe2 (t0000-basic: more commit-tree tests., 2006-04-26) adds
> tets for commit-tree that mask the return exit from git as described
> in a378fee5b07.
>
> Fix the tests, to avoid pipes by using instead a temporary file.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  t/t0000-basic.sh | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index cb87768513..545ff5af13 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -1270,26 +1270,31 @@ test_expect_success 'no diff after checkout and g=
it update-index --refresh' '
>  P=3D$(test_oid root)
>=20=20
>  test_expect_success 'git commit-tree records the correct tree in a commi=
t' '
> -	commit0=3D$(echo NO | git commit-tree $P) &&
> -	tree=3D$(git show --pretty=3Draw $commit0 |
> -		 sed -n -e "s/^tree //p" -e "/^author /q") &&
> +	echo NO | git commit-tree $P >out &&
> +	commit0=3D$(cat out) &&
> +	git show --pretty=3Draw $commit0 >out &&
> +	tree=3D$(cat out | sed -n -e "s/^tree //p" -e "/^author /q") &&
>  	test "z$tree" =3D "z$P"
>  '
>=20=20
>  test_expect_success 'git commit-tree records the correct parent in a com=
mit' '
> -	commit1=3D$(echo NO | git commit-tree $P -p $commit0) &&
> -	parent=3D$(git show --pretty=3Draw $commit1 |
> -		sed -n -e "s/^parent //p" -e "/^author /q") &&
> +	echo NO | git commit-tree $P -p $commit0 >out &&
> +	commit1=3D$(cat out) &&
> +	git show --pretty=3Draw $commit1 >out &&
> +	parent=3D$(cat out | sed -n -e "s/^parent //p" -e "/^author /q") &&
>  	test "z$commit0" =3D "z$parent"
>  '
>=20=20
>  test_expect_success 'git commit-tree omits duplicated parent in a commit=
' '
> -	commit2=3D$(echo NO | git commit-tree $P -p $commit0 -p $commit0) &&
> -	     parent=3D$(git show --pretty=3Draw $commit2 |
> +	echo NO | git commit-tree $P -p $commit0 -p $commit0 >out &&
> +	commit2=3D$(cat out) &&
> +	git show --pretty=3Draw $commit2 >out &&
> +	parent=3D$(cat out |
>  		sed -n -e "s/^parent //p" -e "/^author /q" |
>  		sort -u) &&
>  	test "z$commit0" =3D "z$parent" &&
> -	numparent=3D$(git show --pretty=3Draw $commit2 |
> +	git show --pretty=3Draw $commit2 >out &&
> +	numparent=3D$(cat out |
>  		sed -n -e "s/^parent //p" -e "/^author /q" |
>  		wc -l) &&
>  	test $numparent =3D 1

Well spotted. This looks good to me sans the cat v.s. pipe to sed that
was already pointed out. In addition to that (Taylor may have meant
this, but not said so explicitly) it looks like you can also e.g.:

    v=3D$(echo foo | ...) &&
    git show ... $v

Instead of:

    echo foo | ... >out &&
    v=3D$(cat out) &&
    git show ... $v

But that's a small nit either way.

On the change as a whole:

For what it's worth two ways we could have avoided this sort of edge
case is if my SANITIZE=3Dleak series would e.g. save the log of leaks
somewhere and scour it later, i.e. something like what Jeff King
suggested in[1]. I just re-rolled it at [2], but not with that approach
(but response to your comments on another thread).

I don't think that's worth doing for an intial implementation of that
feature for the reasons argued in its 2/2, just say'n.

The other (and more general) way would be to resurrect my
GIT_TEST_PIPEFAIL mode[3]. I just tried it now in combination with the
SANITIZE=3Dleak test mode, and it would have caught this issue[4]!

I'll see if I can re-poke the bash maintainer (Chet Ramey) about some
way forward for that mode. I had an off-list discussion with him about
my proposed "set -o pipefail" change back in January and he rightly
pointed out that it's intended behavior, meant to catch the sort of
thing that was discussed here on-list in the thread around pagers and
pipefail [5].

So since writing that WIP patch I've come around to his view that "set
-o pipefail" can't be changed like that in general, but perhaps he'd
accept a patch for an optional configuration on top of that. I'll
contact him.

1. https://lore.kernel.org/git/cover-v4-0.3-00000000000-20210907T151855Z-av=
arab@gmail.com/
2. https://lore.kernel.org/git/cover-v6-0.2-00000000000-20210916T085311Z-av=
arab@gmail.com/
3. https://lore.kernel.org/git/20210116153554.12604-12-avarab@gmail.com/
4. https://lore.kernel.org/git/cover-v4-0.3-00000000000-20210907T151855Z-av=
arab@gmail.com/
5. https://lore.kernel.org/git/YAG%2FvzctP4JwSp5x@zira.vinc17.org/
