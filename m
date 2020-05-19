Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDA3C433E0
	for <git@archiver.kernel.org>; Tue, 19 May 2020 18:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B51EF207D3
	for <git@archiver.kernel.org>; Tue, 19 May 2020 18:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gCpARe0G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgESSBC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 14:01:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64228 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESSBC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 14:01:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1D76AD1BB6;
        Tue, 19 May 2020 14:00:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=O9ssQcKQ2WcL
        iZ39pWpHZCkQUwg=; b=gCpARe0GKdVR0i//4fgbixsJ7yv/6O6TW1gLQmr/2cfQ
        Nr3YY5rg7xq7Z5C8/389xa2pMrPqm2X/P4p+JBx0LeRB29fYPB4u1882rT1Bg8Tr
        RETSNdbiYompUuhs9DHBMDUZRb3cY2KRiI2TJSbZ8nh26HMdiurWd6hvghqJfU0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=cB7sFQ
        Pl/F12rs9JwcWi4ot9SBFUuUReao9462QyNgQyJLXaHGcBgurawPUuLMkCkN2i2H
        8d2HBWW0HuZz3Y9dEO1tI+PmDogesxM/CQk/1ekQOsEIHMzNOwWawCCLS43mvrnr
        AZQAOAv6l1Y7A84t1r5njj1Ufjxtk5lfCdi/g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 14B6DD1BB5;
        Tue, 19 May 2020 14:00:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 35901D1BB4;
        Tue, 19 May 2020 14:00:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Laurent Arnoud <laurent@spkdev.net>, phillip.wood@dunelm.org.uk,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v5] diff: add config option relative
References: <20200516173828.GB34961@spk-laptop>
        <92cb6302-09a8-6780-9398-890b1e766680@gmail.com>
        <20200516194033.GA2252@spk-laptop> <20200517021452.GA2114@danh.dev>
        <xmqqlflq7fyd.fsf@gitster.c.googlers.com>
        <20200518094021.GA2069@spk-laptop> <20200518135656.GB1980@danh.dev>
        <xmqq4ksd5ggq.fsf@gitster.c.googlers.com>
        <20200518191205.GA1999@danh.dev>
        <xmqqo8ql0yjg.fsf@gitster.c.googlers.com>
        <20200519003006.GC1999@danh.dev>
Date:   Tue, 19 May 2020 11:00:54 -0700
In-Reply-To: <20200519003006.GC1999@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s message
        of "Tue, 19 May 2020 07:30:06 +0700")
Message-ID: <xmqqv9krztwp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B0074564-99FA-11EA-B219-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> Sane people wouldn't want to read that document when we don't have the
> config for diff.relative
>
> But, now, we have. Let's document --no-relative, specifically for
> git-format-patch(1).
>
> Perhaps something like this (maybe just fixing up to Laurent's)

I love it when a contributor pushes back with a well thought out
counter-argument.  Yes, I think the reasoning along the line makes
sense.

If a project binds another project with -Xsubtree=3D<path>, a change
to that part would be a good candidate to use "format-patch" with
the "--relative=3D<path>".  We didn't consider it a use case that is
interesting enough, but it may be, which gives another reason why
documenting "--[no-]relative[=3D<path>]" for the command may not be a
bad thing, not just for the purpose of defeating "diff.relative".

For that reason, it may even make sense to use the same text for
--no-relative and --relative[=3D<path>] we use for other commands in
the diff family, i.e. leaving only -R inside the ifndef block.

Thanks.

> -----------------8<--------------
> From: =3D?UTF-8?q?=3DC4=3D90o=3DC3=3DA0n=3D20Tr=3DE1=3DBA=3DA7n=3D20C=3D=
C3=3DB4ng=3D20Danh?=3D
>  <congdanhqx@gmail.com>
> Date: Tue, 19 May 2020 07:24:48 +0700
> Subject: [PATCH] Documentation: document --no-relative for format-patch
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> git-format-patch(1) accepts --relative for a long time, but the
> generated patch couldn't be applied without accompanying information.
>
> Hence, we've never document --relative for git-format-patch(1).
>
> Now, we've introduced `diff.relative` config, let's tell Git's users
> that they have an option to override it.
>
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@g=
mail.com>
> ---
>  Documentation/diff-options.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
> index 167b451b89..0f5c108324 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -654,6 +654,11 @@ ifndef::git-format-patch[]
>  	`--no-relative` can be used to countermand both `diff.relative` confi=
g
>  	option and previous `--relative`.
>  endif::git-format-patch[]
> +ifdef::git-format-patch[]
> +--no-relative::
> +	Countermand `diff.relative` config. Show all changes in the repositor=
y
> +	with pathname relative to top-level directory of the repository.
> +endif::git-format-patch[]
> =20
>  -a::
>  --text::
