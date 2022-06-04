Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66388C43334
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 12:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbiFDMZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 08:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235981AbiFDMZH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 08:25:07 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F03BE15
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 05:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1654345477;
        bh=ebX+oAF/v88CTDIyLcBK1yNyQjyymm3K65msfIyzZRw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=AYw7VUZQBzEO++FGW+glThp0GOLlJBIFVL6C+cxGkXW1/6+PhrrfQmcvkrn6kCbA8
         twy9/0Pp2V7gQbi7oNLNcTeyBoQSw0tECJSF5VU3+AHfconflEeR67GgZ4ksktrZ98
         CUGJADKdRZIy+ho3v3/wGDAhK8/eQbxcKQa8MYX0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUUAM-1oNpQ50R84-00QW8B; Sat, 04
 Jun 2022 14:24:37 +0200
Message-ID: <bb05e942-eccd-5f88-d3c7-de903464d866@web.de>
Date:   Sat, 4 Jun 2022 14:24:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [RFC PATCH 07/15] strbuf.c: placate -fanalyzer in strbuf_grow()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
 <RFC-patch-07.15-cf1a5f3ed0f-20220603T183608Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <RFC-patch-07.15-cf1a5f3ed0f-20220603T183608Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m0ATlClL3SBk8wb3iiShdJPfnHze1OI9pvjIr5JJbflV83o+Qbo
 cdMvJVXT4FuXNpoKW3OPdtRFhpugvqgTwEJuy+0+lIbbxWb9D2LOjM6/MNLxUrzSvcSFgPk
 Aw5Idx/w4XgGj7LyZxA4NNYAwGSwmkhMMj4qFpbtkpt65UnZUTBvt6BE7691CzsJDp5Br+M
 Nf37MosBrZUk1a31nXWBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fck27VbYfRg=:n54iJp3PiM+czPmr4lxShl
 vAtjuG4GCoCbcPO3MeS5Fr0GJC63X0ScHtTD+qe+8hg0cey7rQVcgr64tt5FJmJXzR09dWZ7Z
 R7nc/YGAKZcmIVAfjCgiZpeSqPnK/T/VFwsHWyxgFDvH3cuLJFBWlcGMMVVQ/e833us1NA2ok
 v8rzq0Peme6BLzNchzNB9F6JL6UMlNqipy9SeipsD0bbbRH3TBvl6RjxMrCm4/DOrqNR/DqsP
 fpdw4VSTJJ7j3njI8RGz+FpnTy5LvRulHXz64vLbA7lOHA/0J8fbWxFR22ur0aGEHeEDny/wr
 vMdTzMp34otol5irC+g95TSPVzBLv3wVEzboU/NYuACUBw3/GUkVCGHsGMZ9X/6uHB593ctR2
 OGmnJU55PeAbdXWYYtmI+ziUN7AKYpJ/jBXmF1qGwSHBdbwSKxRDjMnj7YCi3Uy5EUJleNfIV
 2quLkR4y5afEoi47fBWcZqJ6U/HRyGLkY9E5BfC2C1aaOcvQlfF7LDr0gRDP5oo/ME2XfdTuM
 woecDFbqo8aOcbdUoKYcyH+TYnjknmP30Ia9X0A7CGZDQ3pThdf304NJe6Zb5/6pdP/ww0wBP
 mTb5PlFngx9gOmzxuWKzxgETJ7FcTUSaB+EGaRXtI5HaZuhZMf5dQ/Gem5fOe2ZtGHuEmY10g
 ZOpA796eosXMET17MxAnC14fn4jEjbF5bKzb8LmJOnG/peNnrWqKHaid63OlH2dw0IFL4o+7o
 KOo8NFtc5MkX5lDGBdxqkZ4bfILX0eNWA7EkNOt/TKVXHOCYU97rtpN+xlK7K6e3c9AFimtAK
 xqYJfT2cdlCqUxTYUU09ugR8BdwsXB5xygiCUJrBKw2flO9zZ66Dlth1zo5pUrx2TNe0rvMIN
 0KtlLwI2cOjI+xU8RJaMOM6pEPdzIFRGgZnfvtDD8J0zTF6BCkOpAt/2r2sDKY7dbivMYHh+K
 2f4v5QsR2gPjKHx2CJ9mhfh3h9S4ZEJEGRDuNYDyWHJHOB7j7qg/7R4TkZfz1ATl6q3kE3NnH
 glfb+lMCmIHZZ444ksrUHc73acFrOz5culJDNPCXAvDe1Cd9BBHDgem6u2e03E5fj2iadMesj
 r6dQ3MyOyuZimsjvUkpAIRe3fQPOYWk6KMr
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.06.22 um 20:37 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Change the strbuf_grow() function so that GCC v12's -fanalyze doesn't
> yell at us about sb->buf[0] dereferencing NULL, this also makes this
> code easier to follow.
>
> This BUG() should be unreachable since the state of our "sb->buf" and
> "sb->alloc" goes hand-in-hand, but -fanalyzer isn't smart enough to
> know that, and adding the BUG() also makes it clearer to human readers
> that that's what happens here.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  strbuf.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/strbuf.c b/strbuf.c
> index dd9eb85527a..61c4630aeeb 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -97,6 +97,8 @@ void strbuf_grow(struct strbuf *sb, size_t extra)
>  	if (new_buf)
>  		sb->buf =3D NULL;
>  	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
> +	if (new_buf && !sb->buf)
> +		BUG("for a new buffer ALLOC_GROW() should always do work!");

new_buf is !sb->alloc.  ALLOC_GROW sets buf if sb->len + extra + 1 is
bigger than sb->alloc, which is always true because the variables in the
sum are unsigned, so we end up with at least 1 > 0.  That's easy enough
to see; I wonder why the compiler doesn't agree.  Am I missing
something?

Does setting the attribute returns_nonnull for xrealloc help?
Specifying it explicitly makes sense to me -- expecting the compiler to
infer it automatically across compilation units is probably a bit too
much to ask for, or at least needlessly expensive.

>  	if (new_buf)
>  		sb->buf[0] =3D '\0';
>  }
