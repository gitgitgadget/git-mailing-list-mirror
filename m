Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5A8C433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 19:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EE3921D7D
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 19:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ocmYYFim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgIITzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:55:08 -0400
Received: from mout.web.de ([212.227.15.4]:43297 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgIITzG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 15:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1599681299;
        bh=wm1X3tYgR+Aa/aIMMnysUenpa1mrFqZZJgeDOVt6jyM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ocmYYFimfx4e7hwnOiHhmKB/Lux8oVsSNVmt5sqQfBmkAahrLx07vTK1i8zFuOAG+
         ri3PvJahPsbIMycSrLcle6pXqHxr9cqhT5oaOAUQv7IB2oNp5TDTKGJNygw9A5aQlc
         x7Wi/kSe3DFtcLPzN2limhDuqJYzWrX4O8xrwAtU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.149.245]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LlWFD-1kqoJI1UL1-00bNdD; Wed, 09
 Sep 2020 21:54:59 +0200
Subject: Re: [PATCH] blame.c: replace instance of !oidcmp for oideq
To:     Jeff King <peff@peff.net>,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, whydoubt@gmail.com,
        Git List <git@vger.kernel.org>
References: <20200907171639.766547-1-eantoranz@gmail.com>
 <ce94b41f-e829-d7ca-a5f5-e41748caea81@gmail.com>
 <20200909091149.GB2496536@coredump.intra.peff.net>
 <CAOc6etZS3mGxsPPh25XFi2-qR0TNzq0Gx1NrydgQwmHbsjxejA@mail.gmail.com>
 <20200909191345.GA2511547@coredump.intra.peff.net>
 <20200909191746.GA2514794@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0773b560-b456-fc88-42d7-f214246ddd1b@web.de>
Date:   Wed, 9 Sep 2020 21:54:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200909191746.GA2514794@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WbxsmezSIKh2Q6XDApGl6trYmwJ1xbi9TeKlQA7VtR8ce7cuPpI
 AsKU5RCTyBeXBRkpAgLH6qeOsJWGxtcCF2tEcqDbJzKXGrDNa2hTXsg6jkitJ/mMVJPMe6q
 Eh7p0Muhj5IQZLllXu5Uv0FPdrghbPKeG4kSk0Ek/Uo6ojz8MtNZd8yyoheZN8JbMz8Th7t
 kmji0yPStN8Jtke36kx6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GbIlLP7GIXU=:i4ttU0+fJQxy4Wj7v9syim
 1pnrANktXDz9Hd/Ia5FxupdVHDOCtFdlIf/FPgf2YYha9svYm2ufJBnrhIis0Rt00crmBXokn
 dst1/+1NoLOfZPzH8mFCfME1E+ONRg8DDJ4xVEaaRQI081MX7FFsMbbAYmx7+rI9ZcoWvl15N
 QpU7QVzOEivKYWAVm0+Lbh87l8UWZvQBHIwRsntjMvFutQaJwUG6u9TUy+kz5/XxRBneNBAqV
 u1rajTrxgY83G3NKqjBhCbb7CLzpwBYckBFjY+pKJqm7ofxuW+TL/AkoJ7aUgOS/YEfGoaaqH
 8luntL2DvVU3MzZyc6fV5AAf3pvZSeHbvNgxLSIH8OSY1oQsY6hCoh/JICwItCcX/B+boAwmD
 oc3988LSdcZhdPCDACNYOUCtamHGoNdOK+RoYcIbYh63cIe8Y8/mjlvgtcxrzkLvtdo5MXVth
 JM54sRi0KRtDk45MqIoeY+eQHch6WDwYoMP6RqCyaRMkOYL+yPPTDW5jYEYx33JdDpwZE5VeM
 Ua27uMhJo/oIie/x69LGWtGZ26V3/zq2Ev5ZsXSRQOHdJZo8JncFHCSnzRFnKNK/mST1PEhF8
 l1AGWpiv/juaj57QDdLtf/yzoIkRTybcMfjJGTWZ29EMzdJ4ft4+BGsNUrvv+mOKZSYX54Oc3
 N8XRRRE6rBOjm7wWZ3lysfpcBGlmiFuv4a4pYwLI1zktA4n4zNQo8X6REqn42M0jgVNgtaiFh
 WWMd66hW0hPeLNbJx6MVHxeThykEaRVyymx6Kq+OnqlZAwj21MyX7BZscFcfwX/+BxszS0AkE
 ei68COJRbFPJ+gNZTP/1izpacVbT4PrP65kLsMeHrzxrfx7up9biactz4KfmlJpAhMNmueCnJ
 pajiJVlcHZS6pSTZTsLi7aWf66TcIM0nFZCtbUe2FuX8v/U2HClkIy5pVSE2YYwET3OLNK0+G
 GXP6ftQSFoYw5lA6rJEszccexjv0WSrHevS+6182QeFt6sPLqlcVLeKnpG4HJ/X9bec1d6Bfn
 l3tQGUGXKU6uPUoJAF1c232YNoKz05pgkZxKSeGgWqDDOjcfr4ZD+wRQTw0fzC9n3Jk3OCc5S
 SIy1o/dk4dPxfiXpTmPTeznHNrw/bcmtayw2eLv6EmQ35Hcd9gknb5VW5vtpwPZK+RpWVuRNo
 tkzHuJh+L6WRZiO7S8vIeQ6cvGkq5CntfeSXNmCHwpf+lC6i8bTqaNix39lgS1p1DNkFSDBD8
 DLVOVmrxPByOenVka
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.09.20 um 21:17 schrieb Jeff King:
> On Wed, Sep 09, 2020 at 03:13:46PM -0400, Jeff King wrote:
>
>> Which really _seems_ like a bug in coccinelle, unless I am missing
>> something. Because both of those parameters look like object_id pointer=
s
>> (and the compiler would be complaining if it were not the case).  But I
>> also wonder if giving the specific types in the coccinelle rule is
>> buying us anything. If you passed two void pointers or ints or whatever
>> to !oidcmp(), we'd still want to rewrite it as oideq().

Right, using expressions for such a like-for-like transformation is safe
and practical in the sense that it won't break correct code, and broken
code will be flagged by the compiler.

>
> And indeed, just blindly swapping out "struct object_id" for
> "expression" in the coccinelle file (patch below), shows another spot
> that was missed:
>
> diff -u -p a/packfile.c b/packfile.c
> --- a/packfile.c
> +++ b/packfile.c
> @@ -735,7 +735,7 @@ struct packed_git *add_packed_git(const
>  	p->mtime =3D st.st_mtime;
>  	if (path_len < the_hash_algo->hexsz ||
>  	    get_sha1_hex(path + path_len - the_hash_algo->hexsz, p->hash))
> -		hashclr(p->hash);
> +		oidclr(p);
>  	return p;
>  }
>
>
> Maybe it's worth being looser in our cocci patch definitions. I'm having
> trouble thinking of a downside...

For transformations that change the type as in the example above we
should insist on getting the right one, otherwise we might introduce
bugs -- like in the example above.  p points to a struct packed_git and
not to a struct object_id, so this introduces a type mismatch.

We better make sure our semantic patches are safe, otherwise we have to
check all conversions very carefully, and then we might be better off
doing them manually..

Ren=C3=A9
