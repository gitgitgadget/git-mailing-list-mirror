Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8EFC43460
	for <git@archiver.kernel.org>; Wed,  5 May 2021 04:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 744E6613EA
	for <git@archiver.kernel.org>; Wed,  5 May 2021 04:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhEEE2e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 00:28:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54613 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhEEE22 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 00:28:28 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 98FCA11B64C;
        Wed,  5 May 2021 00:27:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=d5z8MH5tMHAT
        IOSAZq7xQiAsl3+PwEv6VMbKI5lx/PQ=; b=PwPBTlhBlLIFZyDq5tQH+hVUPqYx
        uIxAf3x7AmghOKXPpL9zjUMwyJNNx10QpLHFvC/Pt1dbqHyPXtwwC3d+nxpTbgGF
        xm4EpD/iKYDXEE5rl64KJyBAHlQbkQv2/LJa8IyYG+wxHxaQKKYFopZI6X0hTdrU
        AEf5cCBzFQJr8AI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 913A911B64B;
        Wed,  5 May 2021 00:27:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CE71B11B649;
        Wed,  5 May 2021 00:27:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 4/5] mailinfo: strip quoted CR on users' wish
References: <20210421013404.17383-1-congdanhqx@gmail.com>
        <cover.1620148732.git.congdanhqx@gmail.com>
        <01d4a4853b8a0b6911a2d7773f836620566b4293.1620148732.git.congdanhqx@gmail.com>
Date:   Wed, 05 May 2021 13:27:04 +0900
In-Reply-To: <01d4a4853b8a0b6911a2d7773f836620566b4293.1620148732.git.congdanhqx@gmail.com>
        (=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Wed, 5 May
 2021 00:20:01 +0700")
Message-ID: <xmqqa6p94xgn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 25D8D870-AD5A-11EB-AA34-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> Subject: Re: [PATCH v2 4/5] mailinfo: strip quoted CR on users' wish

Again, perhaps

    mailinfo: allow stripping quoted CR without warning

By the way, the previous one said "skip", but I do not think it was
skipping quoted CR, so its title was misleading.  Perhaps

  [3/5] mailinfo: allow squelching quoted CR warning

or something.

> In previous changes, we've turned on warning for quoted CR in base64 or
> quoted-printable email messages. Some projects sees those quoted CR a l=
ot
> and they know that it happens most of the time.

    ... a lot, they know that it happens most of the time, and they
    know it always is harmless to behave as if these CRs are not
    there.

The last sentence is an important precondition for the use of this
new option to be safe.

> diff --git a/mailinfo.c b/mailinfo.c
> index fe7ffd01d0..68f4eba72a 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -998,6 +998,11 @@ static void handle_filter_flowed(struct mailinfo *=
mi, struct strbuf *line,
>  		    line->buf[len - 2] =3D=3D '\r' &&
>  		    line->buf[len - 1] =3D=3D '\n') {
>  			*have_quoted_cr =3D 1;
> +			if (mi->quoted_cr =3D=3D quoted_cr_strip) {
> +				strbuf_setlen(line, len - 2);
> +				strbuf_addch(line, '\n');
> +				len--;

The last one is beating a dead variable immediately before this
function returns, even though it is good for consistency (i.e. there
is an invaliant throughout the function that len is the number of
bytes contained in line->buf[]).

I am not sure what to think about this.  I wish there weren't need
for a separate len variable, with the need for this extra invariant.
After all, strbuf already has such an invariant that is well
understood by readers of this code (i.e. line->buf[]'s end is at
line->len).  For now, until we get rid of "len" from this function,
let's leave the final decrement in to make it absolutely clear that
we are aware of this extra invariant.

