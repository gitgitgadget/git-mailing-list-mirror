Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FF0C433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 19:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA30D64F28
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 19:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhBYTCg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 14:02:36 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56481 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhBYTCc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 14:02:32 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D8CEF120769;
        Thu, 25 Feb 2021 14:01:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yjrUQ04yS3p1
        bwAHva+pOlpXAc0=; b=tAAW5fJ1hwxzARSXdiP2iFH9Qs1TCqr4KrglZe5Ef6R1
        b6eOm6pcKU6idgohBqoB3wo6rkZEhIdsj1/WGe+gRvP4/3XcxzM3k0QTnhYwq3st
        m/qE91W/hfLx/RsrmcqvcVaX+o653WcDSiqphtJIHTH70nD4l7Zw+F22bdOSAmY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ySBRux
        V87eQo/mlEZzZIfmPLmqygDs5YmATxBy7Gcq7hJGM+W86u8CjxAQo8ijniqLiYXB
        UAOchZ2rbo045LNQjz19EfkdShLhyzDO5JUVwlVAkQfc5SCd7OEavuLSQVkRSqAo
        KRBb4xUyAsjkfZXcWoWhWXUZyOVREzfkyiC5g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D1608120768;
        Thu, 25 Feb 2021 14:01:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0C0FD120767;
        Thu, 25 Feb 2021 14:01:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>
Subject: Re: [PATCH v5 0/2] difftool.c: learn a new way start at specified file
References: <pull.870.v4.git.1613308167239.gitgitgadget@gmail.com>
        <pull.870.v5.git.1613480198.gitgitgadget@gmail.com>
        <xmqqblcjrgvc.fsf@gitster.c.googlers.com>
        <CAOLTT8T=R-M1eK9thSuzHNOJ8wkaTX3yYsLEgpqmHiEYWgM1XA@mail.gmail.com>
        <YCz6oDZCAODPS8sY@generichostname>
        <CAOLTT8Ri+XbSg_=KaLOCmNX4Nrii1ssN9_FFbnmm7ew4vYN5nA@mail.gmail.com>
        <xmqqo8gile02.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2102251206080.57@tvgsbejvaqbjf.bet>
Date:   Thu, 25 Feb 2021 11:01:44 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2102251206080.57@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 25 Feb 2021 12:08:36 +0100 (CET)")
Message-ID: <xmqqpn0oug2v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E7FCE49A-779B-11EB-9161-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio, ZheNing & Denton,
>
> On Wed, 17 Feb 2021, Junio C Hamano wrote:
>
>> ZheNing Hu <adlternative@gmail.com> writes:
>>
>> > Denton Liu <liu.denton@gmail.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=8817=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=887:14=E5=86=99=E9=81=93=EF=BC=
=9A
>> >>
>> >> On Wed, Feb 17, 2021 at 12:12:10PM +0800, ZheNing Hu wrote:
>> >> > Oh, I am sorry.
>> >> > Then I only need to squash the two commit, right?
>> >>
>> >> I've never used GGG before but I suspect that in your GitHub PR, yo=
u
>> >> need to set the PR base to 'master' instead of 'jc/diffcore-rotate'=
.
>
> Yes, that is my understanding of what needed to be done.

Thanks.

>> > You mean I should cherry-pick Junio's patch to my topic branch, righ=
t?
>
> That, too.

Not quite.  The 'jc/diffcore-rotate' topic would be the 'upstream'
branch of their topic, so patches in jc/diffcore-rotate won't need
to and should not be cherry-picked, I think.

>> ZheNing, the end result we want to see on the list is just a single
>> patch, your 2/2 alone, that says "this patch depends on the
>> diffcore-rotate topic" _under_ its "---" three-dash lines (where
>> "meta" comments on the patch to explain how it fits the rest of the
>> world, etc.).  As a single patch "topic", there won't be even 1/1
>> marking, i.e. something like:
>> ...
>> I do not know how to achieve that end result with GGG and I do not
>> know if GGG allows its users to do so easily, though.
>
> For single-patch contributions, the PR description is not turned into a
> separate cover letter (per your request, Junio), but it is put between =
the
> commit message and the diff as you illustrated.
>
> So yes, the comment can go into the PR description (AKA the first comme=
nt
> on the PR) and the next `/submit` will include it in the single mail.

Good.  FWIW, the part I said "I do not now how" was not about making
the single-patch topic look the way we want, but about making the
work a single-patch topic to begin with (which was answered by the
above "set the PR base" suggestion).
