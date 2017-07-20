Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D77831F600
	for <e@80x24.org>; Thu, 20 Jul 2017 21:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935214AbdGTVwo (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 17:52:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55700 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934927AbdGTVwn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 17:52:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E2B508E433;
        Thu, 20 Jul 2017 17:52:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mxLKEjTk1bYc
        ikMVDZ6jFQDemM8=; b=QEBkqaJf8naOrlME3EsxN6CQcxHpt631Y7snb2XUYujD
        qVEKqBEMnB6XeH8idTifYoRvlBIa4mp71W5KbF851q5cYi0i2ZsFVCQPbW38oFsz
        tXj2vqryu4agf/0dGzH6n9N60qcDZjdY8ZkyKV99WT0+A3UtVw5uKoYxPBWhGkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ECC73J
        k0Pessg9aeu73ZFsrcVRFUzE6q2I0L4VKV/vwHJL2KBcBtTncR3DAMsFduzsP85W
        pRUGLc3wfC66fcjLjm013NRFPU64RLyvZGiBvkTsQZFCxVpSTQkvxjSgWpRDMpFq
        mdP8rXj92QBA15qt89g04LajgRH+i1uH90S3A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA6228E432;
        Thu, 20 Jul 2017 17:52:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3DE208E431;
        Thu, 20 Jul 2017 17:52:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Fwd: New Defects reported by Coverity Scan for git
References: <596ddaa620821_77f83e7330107c4@ss1435.mail>
        <CAGZ79kaPFDMn2K0f529-Crzv+vhU3XUMsSM6w3QV4RXKBv5s_g@mail.gmail.com>
        <xmqqa841fylf.fsf@gitster.mtv.corp.google.com>
        <0110b370-a515-df44-8d46-9a72ac336ee7@web.de>
Date:   Thu, 20 Jul 2017 14:52:33 -0700
In-Reply-To: <0110b370-a515-df44-8d46-9a72ac336ee7@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 20 Jul 2017 22:32:56 +0200")
Message-ID: <xmqq7ez2kc7y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BD5DC420-6D95-11E7-920A-EFB41968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> We could remove that NULL check -- it's effectively just a shortcut.
> But how would that improve safety?  Well, if the array is unallocated
> (NULL) and _num is greater than zero we'd get a segfault without it,
> and thus would notice it.  That check currently papers over such a
> hypothetical bug.  Makes sense?
>
> -- >8 --
> Subject: [PATCH] pack-objects: remove unnecessary NULL check
>
> If done_pbase_paths is NULL then done_pbase_paths_num must be zero and
> done_pbase_path_pos() returns -1 without accessing the array, so the
> check is not necessary.
>
> If the invariant was violated then the check would make sure we keep
> on going and allocate the necessary amount of memory in the next
> ALLOC_GROW call.  That sounds nice, but all array entries except for
> one would contain garbage data.
>
> If the invariant was violated without the check we'd get a segfault in
> done_pbase_path_pos(), i.e. an observable crash, alerting us of the
> presence of a bug.
>
> Currently there is no such bug: Only the functions check_pbase_path()
> and cleanup_preferred_base() change pointer and counter, and both make
> sure to keep them in sync.  Get rid of the check anyway to allow us to
> see if later changes introduce such a defect, and to simplify the code.
>
> Detected by Coverity Scan.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---

It's always amusing to see that a removal of conditional codepath
would result in better chance of finding possible invariant
breakers, as we often think that belt-and-suspenders safety would
require more conditionals and asserts ;-)



>  builtin/pack-objects.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index e730b415bf..c753e9237a 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1289,7 +1289,7 @@ static int done_pbase_path_pos(unsigned hash)
> =20
>  static int check_pbase_path(unsigned hash)
>  {
> -	int pos =3D (!done_pbase_paths) ? -1 : done_pbase_path_pos(hash);
> +	int pos =3D done_pbase_path_pos(hash);
>  	if (0 <=3D pos)
>  		return 1;
>  	pos =3D -pos - 1;
