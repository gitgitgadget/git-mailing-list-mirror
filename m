Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B587C43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 17:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11A72464D
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 17:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wR3O0iOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbfLER3y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 12:29:54 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52378 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730033AbfLER3x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 12:29:53 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BE36DA24AE;
        Thu,  5 Dec 2019 12:29:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6TaFpfG0t3bu
        Bgiym/Y5Jch7kEI=; b=wR3O0iOKrIHmMqNwyAjyfYnJnnVFOzD29xAJdQrUaN8U
        PZJDh9sNSObW/eCw0eOYgAKVhG+hKxkDh49ukLFNp2O+bj3byIHUVnRGbrSuDkdx
        EB20oV9FUxz51gZAk/vfXmx+Im6fIhYeKnIRtgYUlA3lDWAlaM3F2erzuAY8uZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=iam7Fu
        5Hsw+LlcMvLXwzC81Nrv2ZTl9/4VJ8xNzk44+PNSJnsfsWAAbWNTyVl+YFIvsuOe
        1ucqaXouRYUYOgtEtBuesgjNF/BRzy/7yDH0lpyNJT4PYDV9hTEMk3LuDSxMoeM9
        wEpsaqwf8Gj5mhVJdRtRebzhz9dWEVkvP29wY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B64E4A24AD;
        Thu,  5 Dec 2019 12:29:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B3B54A24AC;
        Thu,  5 Dec 2019 12:29:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?5YiY54Kc?= <lw17qhdz@gmail.com>
Subject: Re: [PATCH] xdiff: unignore changes in function context
References: <3053f7a8-0723-aaa7-fe43-9b8b13b2e259@web.de>
Date:   Thu, 05 Dec 2019 09:29:46 -0800
In-Reply-To: <3053f7a8-0723-aaa7-fe43-9b8b13b2e259@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 5 Dec 2019 17:15:31 +0100")
Message-ID: <xmqq5ziu1y0l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D6594490-1784-11EA-9216-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Changes involving only blank lines are hidden with --ignore-blank-lines=
,
> unless they appear in the context lines of other changes.  This is
> handled by xdl_get_hunk() for context added by --inter-hunk-context, -u
> and -U.
>
> Function context for -W and --function-context added by xdl_emit_diff()
> doesn't pay attention to such ignored changes; it relies fully on
> xdl_get_hunk() and shows just the post-image of ignored changes
> appearing in function context.  That's inconsistent and confusing.
>
> Improve the result of using --ignore-blank-lines and --function-context
> together by fully showing ignored changes if they happen to fall within
> function context.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  t/t4015-diff-whitespace.sh |  6 +-----
>  xdiff/xemit.c              | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index eadaf57262..5888ae5ed3 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -2025,11 +2025,6 @@ test_expect_success 'compare mixed whitespace de=
lta across moved blocks' '
>  	test_cmp expected actual
>  '
>
> -# Note that the "6" in the expected hunk header below is funny, since =
we only
> -# show 5 lines (the missing one was blank and thus ignored). This is h=
ow
> -# --ignore-blank-lines behaves even without --function-context, and th=
is test
> -# is just checking the interaction of the two features. Don't take it =
as an
> -# endorsement of that output.

Nice to see that somebody anticipated that we may fix this some day.

> @@ -2039,6 +2034,7 @@ test_expect_success 'combine --ignore-blank-lines=
 with --function-context' '
>  	cat <<-\EOF >expect &&
>  	@@ -1,6 +1,4 @@
>  	 1
> +	-
>  	 2
>  	 3
>  	 4

And I think this is a more intuitive outcome people would expect.

> diff --git a/xdiff/xemit.c b/xdiff/xemit.c
> index 30713ae9a9..9d7d6c5087 100644
> --- a/xdiff/xemit.c
> +++ b/xdiff/xemit.c
> @@ -172,10 +172,12 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr,=
 xdemitcb_t *ecb,
>  	struct func_line func_line =3D { 0 };
>
>  	for (xch =3D xscr; xch; xch =3D xche->next) {
> +		xdchange_t *xchp =3D xch;
>  		xche =3D xdl_get_hunk(&xch, xecfg);
>  		if (!xch)
>  			break;
>
> +pre_context_calculation:
>  		s1 =3D XDL_MAX(xch->i1 - xecfg->ctxlen, 0);
>  		s2 =3D XDL_MAX(xch->i2 - xecfg->ctxlen, 0);
>
> @@ -212,6 +214,21 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, =
xdemitcb_t *ecb,
>  			if (fs1 < s1) {
>  				s2 =3D XDL_MAX(s2 - (s1 - fs1), 0);
>  				s1 =3D fs1;
> +
> +				/*
> +				 * Did we extend context upwards into an
> +				 * ignored change?
> +				 */
> +				while (xchp !=3D xch &&
> +				       xchp->i1 + xchp->chg1 <=3D s1 &&
> +				       xchp->i2 + xchp->chg2 <=3D s2)
> +					xchp =3D xchp->next;
> +
> +				/* If so, show it after all. */
> +				if (xchp !=3D xch) {
> +					xch =3D xchp;
> +					goto pre_context_calculation;
> +				}
>  			}
>  		}
>
> --
> 2.24.0
