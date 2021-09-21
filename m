Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB10C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 07:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A6361156
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 07:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhIUHjb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 03:39:31 -0400
Received: from mout.web.de ([212.227.15.14]:46255 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230172AbhIUHjb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 03:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1632209845;
        bh=o+rLBNdvSNT1CEpVMwLshXd6ocsWDbRbumn/Pvv3e/8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lkZGVwvQcpki4lzlkz6rpgy17xH6GcwXYUAFhQAtTJWvP4/2bYatDG9gkHGdz77KN
         M1uN+BWo6ce1fEFm8JUGK3rgXJCju2m9gr4qrj4rKz8qew1SGEIscp+SPDTm0hgbYI
         fQ59kaX3Aj+WX0bcKCizPV1md8dAEhmMT+3gtoH4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb002 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0M6DjG-1mms503F74-00yBt2; Tue, 21 Sep 2021 09:37:24 +0200
Subject: Re: [PATCH 1/5] grep: stop modifying buffer in strip_timestamp
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Hamza Mahfooz <someguy@effective-light.com>
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
 <YUlVsLkFGRfRqpKG@coredump.intra.peff.net>
 <CAPUEsphSyZB-vtubjYhN_5Gy3Zv0HQ=fH=+G8kMYzJyrOLXPxQ@mail.gmail.com>
 <CAPig+cQnC1LLPtuC0qVX7EQ_ki4pev6scRox3utA45XeLHfGig@mail.gmail.com>
 <YUlw6V7AL8l6mbSh@coredump.intra.peff.net> <YUl+w8Tn3jqfLqt2@carlos-mbp.lan>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <7d791c04-d122-1eb9-a84c-939294817395@web.de>
Date:   Tue, 21 Sep 2021 09:37:23 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YUl+w8Tn3jqfLqt2@carlos-mbp.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j0JYmPGWwHlCgLOmH8+8T+bVRWpHavFQ40e31IZ8swww/z3MTnN
 5TU7c0mLiK5FObpkNNiXajny53n7rs3JB7Ji93r55bNRbwCNMUqM8il9Dc++BDIWrGB6mQp
 COrzyj5hz9TwO6BO1wFKK4Xh8BgFCLh+b+TjgoxpUmSYTvc2S4Sk8jP0T1M6SgswA/bNoWY
 1h1nrpl3k5fLIS12Lsb3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BzuGY4F8eY4=:FL06mOaa6DHGh+dFlDw05m
 sX6TA9B5sNNlNvUZsO0l/6TEHUIGWRFIwA+tysFrDU8yQcaezPYnrFe2IxqS4ybrdY7adhXxh
 Ve7QhKOn1qCAdMEEipMzV7NPbidXeEsIqOP06yclyMRFoz7ZpDC29TjAA29fXqGn4bROD4NEN
 wie4XYy30ovBoUc2pH+YPndGIYoZUnHuqd1n2Agwd3aOVYYuYNgpyMs/I+698boFUrTfw4wf+
 YAx5o1wxR+gw6oYiQaAmRuUAvhVsko3G3feJnkXhWEKwrgYBWfsLDYySnxYg31cQFK9LBAu75
 ayu4sTLCDVo/nZeCLqnRr77VFSXPZURZ+vPyCZS3p3obj3k3WWQ0iuZ07faZ98EaKST7mTLPP
 ee+hcTn7WFwIpI2/TflDMRw5aLPYoMQnw+uU++9qsLoN3PZL+v7lDkLiWFXWw9DlEdGtj1kS0
 77auxCF6KINTlYzZ6/fGpGpUTXehGUkdzPHgBlK0dWbI1EzwS0H+wwp8k9EGIBqlkcf1tNV7X
 ExynclmBei+z9GamrWbJKxkIM+ETRhDWK5IMeJI4yPYhFs4JaOiZt1l0psJsolP7ldZXtOYDc
 EFso4tpDiDc2KKFY4VktgBaUdwDRxJWZpKINlGXJ+FFH7CVoZH0ULKEFIqUo51vYIW6XaMQL6
 jldrY3zQBN2aMTEiMJqd9yJc1qxIthna+lj6QnrjbI2zSPrdmcJPG6Hj8sywwc50j4LkZ2jQO
 hgjIry5ug81+II44c3diy5UI3QLWbJdyqQ+/QlSTqmnVa2nAS38dhd/GYauF67s70iFlphJrb
 eMQvIdtWWL2dMnC49ta0ZfKS0jpavfXfyD3j/7sZMwJttpARWSaetwfwdHENIyI1hAgt1+lsa
 JwS0QSkT/Kk24vRXdJmLcy8ohiFm3rJ0yeqCiu+PDVEMaURoX0sCu5UTH1nFjFm/QmOXBcWxh
 Qsut55k9RcRehTmvzAOzVuLJB5JuZvpuSJOgtcGrQsWg6jfSyaeVxzibesXVau53m4HUcXn0A
 YCWgwHoQx4gYvFAg0m2sn/twkOju3XHfGfl3j/KIsdKX8Q72M+PPlHfeBvE4lOSwpA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.09.21 um 08:42 schrieb Carlo Marcelo Arenas Bel=C3=B3n:
> On Tue, Sep 21, 2021 at 01:43:05AM -0400, Jeff King wrote:
>>
>> So yeah, I'm sure it could be rewritten around memrchr() or something,
>> but I doubt it would be much shorter, and the chance of introducing an
>> off-by-one seems non-trivial. :)
>
> Considering I am writing it, it is most likely warranted ;)
>
> but it doesn't look that bad IMHO
>
> Carlo
>
> PS. I tested it in macOS with the compatibility layer that will be neede=
d

Right; memrchr is a GNU extension.  We'd need a compat/ implementation to
be able to use it.

> ------ 8> -------
> Subject: [PATCH] grep: retire strip_timestamp()
>
> After recent changes, the name is no longer valid, as the function
> doesn't strip anything.

It still does; the input string slice between bol and eol contains a
trailing timestamp and the output slice doesn't.

>
> Having the code in the main function also helps with readability
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  grep.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index 5b1f2da4d3..56fd86a7d8 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -922,18 +922,6 @@ static int patmatch(struct grep_pat *p, char *line,=
 char *eol,
>  	return hit;
>  }
>
> -static void strip_timestamp(char *bol, char **eol_p)
> -{
> -	char *eol =3D *eol_p;
> -
> -	while (bol < --eol) {
> -		if (*eol !=3D '>')
> -			continue;
> -		*eol_p =3D ++eol;
> -		break;
> -	}
> -}
> -
>  static struct {
>  	const char *field;
>  	size_t len;
> @@ -965,9 +953,12 @@ static int match_one_pattern(struct grep_pat *p, ch=
ar *bol, char *eol,
>  		bol +=3D len;
>  		switch (p->field) {
>  		case GREP_HEADER_AUTHOR:
> -		case GREP_HEADER_COMMITTER:
> -			strip_timestamp(bol, &eol);
> +		case GREP_HEADER_COMMITTER: {
> +			char *em =3D memrchr(bol, '>', eol - bol);
> +			if (em)
> +				eol =3D em + 1;

The old code documents the intent via the function name.  The new one
goes into the nitty-gritty without further explanation, which I find
harder to read.

>  			break;
> +		}
>  		default:
>  			break;
>  		}
>

