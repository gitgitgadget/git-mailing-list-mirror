Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8B6C43334
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 18:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbiFDSH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 14:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiFDSH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 14:07:56 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD611BE9E
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 11:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1654366054;
        bh=kRVb6ttPsy5rSt5Tw8cg2FYjoKR0vaowBYncTLPt4LM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=JvOaZFP7zGOXt9VIsh7wrU7sNOE4AUSr8E6ndtf3qpgUutYLeFh6KHl4c+y7Xt6UK
         5Lkdz6w3L8wqwc1KKNg9cK2msc3nCZb5kJ8DuI7wRojBBWOxL0bW0G4dZ6OLFPqh3i
         6uMZhNhaUQ/dYVj6uxYJude0S5WEo9YkjutOXUoY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDMvE-1o6vZL3XNe-00Avoj; Sat, 04
 Jun 2022 20:07:33 +0200
Message-ID: <6679c09e-e691-f360-ace8-aae17ecabdc4@web.de>
Date:   Sat, 4 Jun 2022 20:07:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [RFC PATCH 06/15] ref-filter.c: BUG() out on show_ref() with NULL
 refname
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
 <RFC-patch-06.15-2d04035d7aa-20220603T183608Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <RFC-patch-06.15-2d04035d7aa-20220603T183608Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:udm9zd28e+mYXCrRgHpFe10ZyBhbKLGjjmu3AAu2Oge4Ajb+Lph
 TQwuBVFpTEIidNHI46uD5qNPwB4hPstLoBJxhnd1SedWCt7+74XwbYDrc5NlPpqqec4WLN3
 IxcuGE2fR1CuxGNAiAeqGVnPVsar4T+No3V+Ap21gm0VjUN/cIqsOzjqLqqCFX5IwOid9jx
 7pTTzzM9F1YfjiB3JqYQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rax/6DE3LHA=:uTOqySrhGH4WNpFAaSEWxK
 2mytPs88rhXm1/oS948NDZ4Ip0yrLeI04LC0ula50pjQpWMWW5ClIZBkypLRi+llNqOaBVK1V
 x39msNdE1Lgk2d4cgWuI8s6S2y9w4Oec9iCKr00nmnKN19vpw5NXcznTyPJg1jPaCc/G/YZik
 blHSDNuFQnfRsK7fJwzj0ruAlG0w9YnBtVvSUrNbdzdroev1psTmu8jkV2p0+HJMf7ZtInXbS
 UvJOnmcgtfeENXtuvNV3S1jUQvnSQysJ9ivjLWhGQ8+/evqRLHFTYibhPXBRcZu9twO0sAxni
 zasdS1xYQY5lYKnKoHljMR/wijtEiX9QuNMF7UFPFv8sWeDqJqkzp9Mt+FDPcK7l2mS6lJZ2f
 ebj+w9wdmoLE+mI3xA2L0fslg8pKmFya76Q2vcRtm6unxbYWtJL9nVp8N+QYgk72UzjuaQTUW
 hC6BjuKh9YHNcAvbQEzeb2P97jrNXXOlZLRiqpvX36mc6CSrXfQPANiL5GaVV702r5bnTxm+3
 BWXrK+MOfcQqEP9Y7RhHHQv1uKCGXg43UCwDjStgGKBHcxyJu9ODfNczwaAvPnOJlpex2kETZ
 9Q0pd9cs2hf/kzQHZMuB0iQFc1gv1MkIlLlUvmGCvJ+9qo//s2jcKZfpDF3oUSIURbv7ekiEJ
 xW3EhogPyhiet2SZMwDNfS8Exc6z+bRS9GbEzfMWhRyf6R6uhVV5LWyNLIZzjxjAPF8O53WG+
 cPR/ExP6mD2+iQgJxq2Vm8RENnXCwXtLIQemFutltLY+gfPfZEUr74gRMSHDQp5ORAPKUamAh
 Q1H6hZHIsYwAu17QeGNJfwQJLpFtbX3YaENwTGZJSHE/jwqpVqAuuv0pMjhhUpSfkj5D14pY5
 6S2O2kXaP1Zwutl3OsIW7A31Pkn4s5vTg9e+In5UlChGCJrmpQgYKWVMRT1W6nOoMft3Exivp
 Ws8ikYQj2LEmK+Q3x8+pP9QsYIxHdL7CGmPLmpS/bzdV2lICuwxfUHWgA7cfCmJe7n/348T4L
 wH7htKGCCSCA3LVgolw3kjIJl82fpjZguPwFAFsb3BF8UQ7PL9KQjPaEb71RMQBQ62ZW8lO9v
 m3QNxsnki2WARND2f4xy0Pi/FfdRSioWnQ8
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.06.22 um 20:37 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Adjust code originally added in 5339bdad96a (ref-filter: introduce
> remote_ref_atom_parser(), 2016-02-17) to BUG() out rather than
> potentially segfault if we get a NULL refname here.
>
> As noted by GCC v12's -fanalyzer that will happen if this follows the
> "refname =3D NULL" branch added in cc72385fe35 (for-each-ref: let
> upstream/push optionally report the remote name, 2017-10-05).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  ref-filter.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 2413f889f48..91aa8e89268 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1644,7 +1644,9 @@ static void fill_remote_ref_details(struct used_at=
om *atom, const char *refname,
>  				    struct branch *branch, const char **s)
>  {
>  	int num_ours, num_theirs;
> -	if (atom->u.remote_ref.option =3D=3D RR_REF)
> +	if (atom->u.remote_ref.option =3D=3D RR_REF && !refname)
> +		BUG("must get refname with [...]remote_ref.option =3D=3D RR_REF");
> +	else if (atom->u.remote_ref.option =3D=3D RR_REF)

The related code not shown here looks tricky.  IIUC refname cannot be
NULL if option is RR_REF, because remote_ref_atom_parser() only sets
.push_remote for other option values and only if that's set we can get a
NULL refname passed to fill_remote_ref_details().  Right?

Do we need to have two different ways to indicate remote-ness?  Having
just one like after the patch below should reduce the risk of confusion.

>  		*s =3D show_ref(&atom->u.remote_ref.refname, refname);
>  	else if (atom->u.remote_ref.option =3D=3D RR_TRACK) {
>  		if (stat_tracking_info(branch, &num_ours, &num_theirs,


diff --git a/ref-filter.c b/ref-filter.c
index 2413f889f4..260257b92c 100644
=2D-- a/ref-filter.c
+++ b/ref-filter.c
@@ -183,7 +183,7 @@ static struct used_atom {
 				RR_REF, RR_TRACK, RR_TRACKSHORT, RR_REMOTE_NAME, RR_REMOTE_REF
 			} option;
 			struct refname_atom refname;
-			unsigned int nobracket : 1, push : 1, push_remote : 1;
+			unsigned int nobracket : 1, push : 1;
 		} remote_ref;
 		struct {
 			enum { C_BARE, C_BODY, C_BODY_DEP, C_LENGTH, C_LINES,
@@ -295,10 +295,8 @@ static int remote_ref_atom_parser(struct ref_format *=
format, struct used_atom *a
 			atom->u.remote_ref.nobracket =3D 1;
 		else if (!strcmp(s, "remotename")) {
 			atom->u.remote_ref.option =3D RR_REMOTE_NAME;
-			atom->u.remote_ref.push_remote =3D 1;
 		} else if (!strcmp(s, "remoteref")) {
 			atom->u.remote_ref.option =3D RR_REMOTE_REF;
-			atom->u.remote_ref.push_remote =3D 1;
 		} else {
 			atom->u.remote_ref.option =3D RR_REF;
 			if (refname_atom_parser_internal(&atom->u.remote_ref.refname,
@@ -1891,7 +1889,8 @@ static int populate_value(struct ref_array_item *ref=
, struct strbuf *err)
 				continue;
 			branch =3D branch_get(branch_name);

-			if (atom->u.remote_ref.push_remote)
+			if (atom->u.remote_ref.option =3D=3D RR_REMOTE_NAME ||
+			    atom->u.remote_ref.option =3D=3D RR_REMOTE_REF)
 				refname =3D NULL;
 			else {
 				refname =3D branch_get_push(branch, NULL);
