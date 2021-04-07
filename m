Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CA2C433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 20:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 003F1611C1
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 20:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbhDGUbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 16:31:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51037 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbhDGUbk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 16:31:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E808CBC4C4;
        Wed,  7 Apr 2021 16:31:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nUbpSCEP/fAd
        lW6WE3dn8z6SsiM=; b=kk6SMeUmVmsG6iedXGAf/4tO/XqI9M/ecyQbTSW08V5d
        DVv5ftFc2mCK5d4HcGUPrRqB2vH7TkClH12cW7oXn7NWMvnoyq6LBmD92Tafy7Iy
        Rp62o7rsgSgUVJfw93H+ukcyHGmU3MgrkMe/qXneVkim4MirXdZGvKroMkbyORI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=fhQT0d
        3NthgCQjtynlq/EesdSHBzoMe29vW/yA8KMyBKLtXZTCLqV2UvoZwkiycFKcJNPg
        c5lc5uBU62Cj9TxQMqiUfSZiwN1rVOVeLIR9SoiAawAQTamKdZkXdyT6qY1UOj3i
        jPUN3sVhFjU7PY3go/TkW5pJM2m62EwjpJcTQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF983BC4C3;
        Wed,  7 Apr 2021 16:31:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A0C0BC4C2;
        Wed,  7 Apr 2021 16:31:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2] [GSOC] ref-filter: use single strbuf for all output
References: <pull.927.git.1617631280402.gitgitgadget@gmail.com>
        <pull.927.v2.git.1617809209164.gitgitgadget@gmail.com>
Date:   Wed, 07 Apr 2021 13:31:28 -0700
In-Reply-To: <pull.927.v2.git.1617809209164.gitgitgadget@gmail.com> (ZheNing
        Hu via GitGitGadget's message of "Wed, 07 Apr 2021 15:26:48 +0000")
Message-ID: <xmqqczv5zvj3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3B98C812-97E0-11EB-B74C-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH v2] [GSOC] ref-filter: use single strbuf for all ou=
tput

The implementation changed so much from the initial attempt, for
which the above title may have been appropriate, that reusing single
strbuf over and over is not the most important part of the change
anymore, I am afraid.  Besides, it uses TWO strbufs ;-)

Subject: [PATCH] ref-filter: introduce show_ref_array_items() helper

or something like that?

> From: ZheNing Hu <adlternative@gmail.com>
>
> When we use `git for-each-ref`, every ref will call
> `show_ref_array_item()` and allocate its own final strbuf
> and error strbuf. Instead, we can reuse these two strbuf
> for each step ref's output.
>
> The performance for `git for-each-ref` on the Git repository
> itself with performance testing tool `hyperfine` changes from
> 18.7 ms =C2=B1 0.4 ms to 18.2 ms =C2=B1 0.3 ms.
>
> This approach is similar to the one used by 79ed0a5
> (cat-file: use a single strbuf for all output, 2018-08-14)
> to speed up the cat-file builtin.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>     [GSOC] ref-filter: use single strbuf for all output
>    =20
>     Now git for-each-ref can reuse two buffers for all refs output, the
>     performance is slightly improved.
>    =20
>     Now there may be a question : Should the original interface
>     show_ref_array_items be retained?
> ...
>        /*  Callback function for parsing the sort option */

Again, not a very useful range-diff as the implementation changed so much=
.


>  builtin/for-each-ref.c |  4 +---
>  ref-filter.c           | 20 ++++++++++++++++++++
>  ref-filter.h           |  5 +++++
>  3 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index cb9c81a04606..d630402230f3 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -16,7 +16,6 @@ static char const * const for_each_ref_usage[] =3D {
> =20
>  int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>  {
> -	int i;
>  	struct ref_sorting *sorting =3D NULL, **sorting_tail =3D &sorting;
>  	int maxcount =3D 0, icase =3D 0;
>  	struct ref_array array;
> @@ -80,8 +79,7 @@ int cmd_for_each_ref(int argc, const char **argv, con=
st char *prefix)
> =20
>  	if (!maxcount || array.nr < maxcount)
>  		maxcount =3D array.nr;
> -	for (i =3D 0; i < maxcount; i++)
> -		show_ref_array_item(array.items[i], &format);
> +	show_ref_array_items(array.items, &format, maxcount);

The intention of this call is to pass an array and the number of
elements in the array as a pair to the function, right?  When you
design the API for a new helper function, do not split them apart by
inserting an unrelated parameter in the middle.

> diff --git a/ref-filter.c b/ref-filter.c
> index f0bd32f71416..27bbf9b6c8ac 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2435,6 +2435,26 @@ int format_ref_array_item(struct ref_array_item =
*info,
>  	return 0;
>  }
> =20
> +void show_ref_array_items(struct ref_array_item **info,
> +			 const struct ref_format *format,
> +			 size_t n)

IOW,

	void show_ref_array_items(const struct ref_format *format,
				  struct ref_array_item *info[], size_t n)

> +{
> +	struct strbuf final_buf =3D STRBUF_INIT;
> +	struct strbuf error_buf =3D STRBUF_INIT;
> +	size_t i;
> +
> +	for (i =3D 0; i < n; i++) {
> +		if (format_ref_array_item(info[i], format, &final_buf, &error_buf))
> +			die("%s", error_buf.buf);

OK, the contents of error_buf is already localized, so it is correct
not to have _() around the "%s" here.

> +		fwrite(final_buf.buf, 1, final_buf.len, stdout);
> +		strbuf_reset(&error_buf);
> +		strbuf_reset(&final_buf);
> +		putchar('\n');

This is inherited code, but splitting fwrite() and putchar() apart
like this makes the code hard to follow.  Perhaps clean it up later
when nothing else is going on in the code as leftoverbits, outside
the topic.

> +	}
> +	strbuf_release(&error_buf);
> +	strbuf_release(&final_buf);
> +}
> +
>  void show_ref_array_item(struct ref_array_item *info,
>  			 const struct ref_format *format)
>  {

Isn't the point of the new helper function so that this can become a
thin wrapper around it, i.e.

	void show_ref_array_item(...)
        {
		show_ref_array_items(format, &info, 1);
	}

> diff --git a/ref-filter.h b/ref-filter.h
> index 19ea4c413409..eb7e79a6676d 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -121,6 +121,11 @@ int format_ref_array_item(struct ref_array_item *i=
nfo,
>  			  struct strbuf *error_buf);
>  /*  Print the ref using the given format and quote_style */
>  void show_ref_array_item(struct ref_array_item *info, const struct ref=
_format *format);
> +/*  Print the refs using the given format and quote_style and maxcount=
 */
> +void show_ref_array_items(struct ref_array_item **info,
> +			 const struct ref_format *format,
> +			 size_t n);

The inconsistency between "maxcount" vs "n" is irritating.  Calling
the parameter with a name that has the word "info" (because the new
parameter is about that array) and a word like "nelem" to hint that
it is the number of elements in the array) would be sensible.

void show_ref_array_items(const struct ref_format *format,
			  struct ref_array_item *info[], size_t info_count);

or something along the line, perhaps?

