Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5751C43381
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CCCA64FF8
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhBEWac (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:30:32 -0500
Received: from mout.gmx.net ([212.227.17.20]:37211 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232518AbhBEOTS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612540554;
        bh=evRWW79tPYazgrykCoZ1bjsI2skMCygvK0flOozNt2c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=b6LwdRZKyaCw/S/1pl3TDVIJH3JP4kdRqo49ytUm0qhH6iXtQ4c/TIgXJ84p/Insj
         xwpgplKHm5nJrTWF5hC6IC0012YZ/Ik1hOBGRQm5T2YBKol1c4Njnjs0tfWrq4XhZq
         Y+4cM4u30Ifj2TbrSwy97WXGl0CBFeDXH2guNXDk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([89.1.214.8]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSc1B-1lVvME1CY5-00Sstb; Fri, 05
 Feb 2021 15:08:55 +0100
Date:   Fri, 5 Feb 2021 15:09:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 2/3] range-diff/format-patch: handle commit ranges
 other than A..B
In-Reply-To: <xmqqim772tal.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2102051504080.54@tvgsbejvaqbjf.bet>
References: <pull.841.v4.git.1612431093.gitgitgadget@gmail.com>        <pull.841.v5.git.1612481392.gitgitgadget@gmail.com>        <04b5d75adbc3d80e9f9cf9cd380294949e7c68e8.1612481392.git.gitgitgadget@gmail.com>        <xmqqmtwj2ugg.fsf@gitster.c.googlers.com>
 <xmqqim772tal.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DEu/Dah+QH+5VOxwboSv5SvguqF0BNYfeC9A3cCS4QMYEp4l1QO
 qHG4+SI9ZTxUy/zzbQfdZcp+oyFekdj9tQFHotHO6OSBjDO7BeqQ5SivCw8kdwtdtOhS8F3
 YDvGPeQrOL5HaonDnkNBDHQpNydffK5wbHCIE5oyJQ5u+9LHqNlD9GeOWZqupJlkNJDgWer
 AT4c1Rj621XPGubs+s0gw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MsDrlV9yC0c=:g/Mr4YgjETaiN2tXbHY3Ot
 RzH7FwPxKwZiHQMNAkUnrK7eCZpF4+oZCZgSNf83Jklv0VwoMH9nEfdezn7nJVZwVwR2rh3BL
 zrbfGD9BSz3Cy3FJj4gKrxKwtvsxEAVj6z6vQrh3/rzo9me13GptCJTL9ZIN8x5a0+vqe8RJ6
 56GyeDQaCznAG2tBRhtWQ6vArNN+uxIiCrsqF0s5xs14IB12T6qB5cRRivMN4pJM2JiOPVz6R
 cq+U/FaWQXEOsfen0Qw3dxB4M1zLxGTvBQKehJOp98s+erGsyY9oR5laQMeX6/WREZkdqDpFM
 m5x4lON+7Uct9fSCouEIMoFynUVwhwBvc9u38ZpfylX/4T2FGqo03dI3j9ioBPvgIn4mBVSvw
 j3nSZ+a43MrPn+knVZDujDq/ywpGpuHI2h+a1CQtJnC1Q0PaOWwGAVgsbgFAvSm/jE2RxaJno
 OdvDN2Yo+e9t2wLpBRAtMojyb06dpvgxlGpsQu8/UVU1FFM3mHY11exCnGu4ekWW9Ynak7bi8
 FHwGXSrbxxgosty3WKEUwjUHNsfkrSag+r6Sc4C4dW6YZgN26PjGHgKA/ocpURRhMSQvQS7QJ
 1cbMxDup3RHZ5C0UAGU2iZjvkUVwjOH0ZY1pzz9jkYI1UXRO7yxQBjhdqhylFGU86VQ9FV0o5
 u7dCC8aKBj2SCaf5Rx1TsW+l05RVB6tv1E8fxmLKo4TMXVOy7I1WzEtzpmEx8/AUH1Q9dKnJ+
 j3ttMpUaTAZH6kzeJrFOQ7WeSUArOAJHniZq/qL6Y9+PUhNlgh1Vw4ay0ZO7n5yZeML2hv05D
 GBvfS293F/68XJqjNg9wsmLVaURMFEqVrAKw6y3VVLSrHczb8dpPUF+phg+myJDea3CPJ1lam
 ICIF5RfJcFKghqW5hWNGRmmjU5l0IKE+kGSjRzmm8=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 4 Feb 2021, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > Ah, I didn't think of adding this inside the same loop.  As long as
> > the pending objects are independent, this should work, but it is
> > unsafe, I think.
>
> Here is what I added on top of the 3-patch series for tonight's
> pushout.
>
>  * No need to count positive/negative; just seeing both exists is
>    sufficient and there is no need to examine any later elements, if
>    any.

Your code is substantially harder to read. I really dislike that `npmask`
idea.

>  * Clearing commit marks needs to be done after we have seen enough,
>    or it can clear the stuff we would want to inspect before we
>    have a chance to.  Do it in a separate post-cleaning loop.

I implemented that.

>  * Dedent by judicious use of 'goto'.

Not necessary: the code is short and narrow enough.

>  * The last parameter to setup_revisions() is a pointer, so spell it
>    NULL not 0.

I had missed that in your review. Fixed, too.

>  * "rang" -> "range" typofix (it might be even better to look for
>    "range:")

Technically, it is not necessary, as we're only verifying that the
intended error message is shown, and that "e" does not make any
difference.

But it _was_ a typo, so I fixed it, too.

Next iteration is coming soon,
Dscho

>
> ----- >8 ---------- >8 ---------- >8 ---------- >8 ---------- >8 -------=
--- >8 -----
> Subject: [PATCH] fixup! range-diff/format-patch: handle commit ranges ot=
her than A..B
>
>  range-diff.c          | 30 +++++++++++++++++-------------
>  t/t3206-range-diff.sh |  2 +-
>  2 files changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/range-diff.c b/range-diff.c
> index c307bca9de..7a38dc8715 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -570,24 +570,28 @@ int is_range_diff_range(const char *arg)
>  {
>  	char *copy =3D xstrdup(arg); /* setup_revisions() modifies it */
>  	const char *argv[] =3D { "", copy, "--", NULL };
> -	int i, positive =3D 0, negative =3D 0;
> +	int i;
>  	struct rev_info revs;
> +	unsigned npmask =3D 0;
>
>  	init_revisions(&revs, NULL);
> -	if (setup_revisions(3, argv, &revs, 0) =3D=3D 1)
> -		for (i =3D 0; i < revs.pending.nr; i++) {
> -			struct object *obj =3D revs.pending.objects[i].item;
> +	if (setup_revisions(3, argv, &revs, NULL) !=3D 1)
> +		goto cleanup;
>
> -			if (obj->flags & UNINTERESTING)
> -				negative++;
> -			else
> -				positive++;
> -			if (obj->type =3D=3D OBJ_COMMIT)
> -				clear_commit_marks((struct commit *)obj,
> -						   ALL_REV_FLAGS);
> -		}
> +	for (i =3D 0; i < revs.pending.nr && npmask !=3D 3; i++) {
> +		struct object *obj =3D revs.pending.objects[i].item;
> +
> +		npmask |=3D (obj->flags & UNINTERESTING) ? 01 : 02;
> +	}
> +
> +	for (i =3D 0; i < revs.pending.nr; i++) {
> +		struct object *obj =3D revs.pending.objects[i].item;
> +		if (obj->type =3D=3D OBJ_COMMIT)
> +			clear_commit_marks((struct commit *)obj, ALL_REV_FLAGS);
> +	}
>
> +cleanup:
>  	free(copy);
>  	object_array_clear(&revs.pending);
> -	return negative > 0 && positive > 0;
> +	return npmask =3D=3D 3;
>  }
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index 45f21ee215..2b518378d4 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -160,7 +160,7 @@ test_expect_success 'A^! and A^-<n> (unmodified)' '
>
>  test_expect_success 'A^{/..} is not mistaken for a range' '
>  	test_must_fail git range-diff topic^.. topic^{/..} 2>error &&
> -	test_i18ngrep "not a commit rang" error
> +	test_i18ngrep "not a commit range" error
>  '
>
>  test_expect_success 'trivial reordering' '
> --
> 2.30.0-601-g9b6178ed87
>
>
