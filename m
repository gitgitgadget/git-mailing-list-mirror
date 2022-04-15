Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA60AC433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 23:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356670AbiDOX7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 19:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356664AbiDOX7O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 19:59:14 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EE67EB25
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 16:56:44 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD78510DC7D;
        Fri, 15 Apr 2022 19:56:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BniEIehWlI1p
        drIaeU6O/3YGSrf8vPnUZnqHOK7/aX8=; b=Z17LD3jKYiSDFGr5pDBw7mELz6Eh
        kjZ4uCSYniXETLyWsu3CoIbWfFpwDNa+OSAtfvzWcEzogJYYWKwbctsidVKI3gMD
        XGyPrD8oQWy1qNU/cdp4oFUPKGK1rxTVcDLpu2rPAAa+waLBdHGR3SYuMDcBtYPG
        ESuj9C53RS5za6A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D64C110DC7C;
        Fri, 15 Apr 2022 19:56:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A5F210DC7A;
        Fri, 15 Apr 2022 19:56:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@talktalk.net, avarab@gmail.com
Subject: Re: [PATCH 1/2] config.mak.dev: workaround gcc 12 bug affecting
 "pedantic" CI job
References: <20220415123922.30926-1-carenas@gmail.com>
        <20220415231342.35980-1-carenas@gmail.com>
        <20220415231342.35980-2-carenas@gmail.com>
Date:   Fri, 15 Apr 2022 16:56:42 -0700
In-Reply-To: <20220415231342.35980-2-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Fri, 15 Apr 2022 16:13:41 -0700")
Message-ID: <xmqqbkx1aojp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B363E004-BD17-11EC-AEF7-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> Originally noticed by Peff[1], but yet to be corrected[2] and planned t=
o
> be released with Fedora 36 (scheduled for Apr 19).
>
>   dir.c: In function =E2=80=98git_url_basename=E2=80=99:
>   dir.c:3085:13: error: =E2=80=98memchr=E2=80=99 specified bound [92233=
72036854775808, 0] exceeds maximum object size 9223372036854775807 [-Werr=
or=3Dstringop-overread]
>    3085 |         if (memchr(start, '/', end - start) =3D=3D NULL
>         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I've seen this one; is this accepted on their side that the compiler
is hurting us with a false positive here?

> +# https://bugzilla.redhat.com/show_bug.cgi?id=3D2075786
> +ifneq ($(filter gcc12,$(COMPILER_FEATURES)),)
> +DEVELOPER_CFLAGS +=3D -Wno-error=3Dstringop-overread
> +endif

If this does not break the build further, and it makes the -Werror
build succeed, I wouldn't be too much worried.  I think this one and
the other one are innocuous enough that they can be fast-tracked.

Thanks.
