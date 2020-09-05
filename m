Return-Path: <SRS0=od8b=CO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF306C433E2
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 21:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 989D120760
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 21:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Dhg5ewRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgIEV7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Sep 2020 17:59:53 -0400
Received: from mout.web.de ([212.227.15.3]:41039 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728449AbgIEV7u (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Sep 2020 17:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1599343186;
        bh=aMNeNCRnD9I2/3loXGkBr7ABl2i2EWeVJ2+Wwqgwwpg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Dhg5ewRqdrvAlXCk5LH0P6fW49RpohOh27Wf/aJ8e7cl240DQMxUAfsRhVasiOo6D
         Qwffww0XPoiEDkZmGCwIW1cW6Ow5dRviA4QRPFDhEZzdphZwI3x1RdWeFgZExhySHi
         NWMNzxzGzb8SwXClQLDMbqM2vo/Qz1xekR19Q7a8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.149.245]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MCIYT-1kNn2h2Gf3-0097OJ; Sat, 05
 Sep 2020 23:59:46 +0200
Subject: Re: [PATCH 1/2] pretty.c: refactor trailer logic to
 `format_set_trailers_options()`
To:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>
References: <pull.726.git.1599335291.gitgitgadget@gmail.com>
 <4180f54c1de51a3b9e29ef42b035bb31215875e3.1599335291.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <bf4423d5-c0ee-6bef-59ff-fcde003ec463@web.de>
Date:   Sat, 5 Sep 2020 23:59:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <4180f54c1de51a3b9e29ef42b035bb31215875e3.1599335291.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k64n8J/wlWeNXtJPlQ/YfD8MY1U1ycZ7cxbk4gabXpBXtfGWO5a
 DGU2963F9y9iNBiLjqcVUSxVH0UnlEGvJbB2hJX/6L3+v2endCRqacli+mNDabROvAsX80W
 6baEs6okEgM1tKW+oAVuMLjq9GYnDh9oU4HK4qjpo7awPDLVE94Wdffs86lLFh8dfgvhjlo
 zh9sHFDMUfu08CzxPGJyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UlSbzHe17mY=:h5kdq72m3zOWlGO9+W9jbf
 hTAHwBO3aTowlwfsHxenCz20ZFksjVDqC3jwhs7oIQ7R+wBDIwWWa7wAxfrAwHa1p8cojWCdc
 TGerXcDeI726CRpjkS+clWYiKZc5oACGuTG4QQaSqBW+YzrJdoqRp8BUknFNjtRc+CAAAnIG8
 qL238XaNFXJnLDmgg0zogKKJ0Uk9lG0KqBKkbg5RkrZ5b95U8+u2gUo8HE5QPINeNyGpMXTpD
 r8M6acq1c+kDG20EnCSjSMXqQ1wOMljY4DzVA3OMZvGQw2CGxaS4oIPhFaldn+pXCi/VPu8T8
 qQ1r9TxTOC3i6pY+v2qhQqUJ1rprub3l5AP15QL5Dipq1hDsvUM+iPv4OOrbAylS5AqMWAxza
 4YI1DprwHVLoDp2sO7cVVI3aw3lbiZaBRqsZzgQkKSwgQUGLutlZtoxa71mbhtAsUzrkY/yvP
 iIim5HKboQhFZ9H4egU5crQc32W7sYQzoonicigshhw/MntsVdeUvgZrYeIa7Ifa8nTlMmfBk
 wZ00NY2cpKyVmPtFTfcXu1sfAH1EGpznX2GtD/E9R2/6Otki8KNrjS0K+vTyt0U/N3A4WegDf
 qd4GPvvgQ3Kshm548Ufkj/Z+hW4Bx1N6yz91p9iVpyno1EzcLARRL4ow9JzfCbvkPq+mtGT4i
 22NHbGD9gdXEflbGU835TFM77t3B8cXqY+txuJQ/FnPLLjFufVqzN9IV8BBeAs/T9WoVxPCsI
 ubnHr2sCeKpSCcEjF1xvHYdSPU9OcdvIL6lgBslbAZZ5ejkSFMGuARo+T+Ytb9ZLZhww54bsq
 N9ff45i5DSSnIEi9AnPHlrGFMq1jUJOXZ6A1gGVgGm40HMGAjlF5if6s7mAqB2uA86ORuzp/N
 UA3Q3gkdY1sB8PnSdHov2+QENH9doQF4R/4R8FgvJFVpVf2/SBuWDSBKjFO/0HEMNK7pPWxZu
 PbP2bs2WNVWZ0aTDIJhWdPFclXPpuKFVD8Z876x2FvRCc79qZeI0P3g0ChEktFbnUl+rU4IJg
 IWUl6a6WyLjZqpsnwXOgghOVmKze/IW3HL3g0FOa/XuGyLXtyyNczIwU+UkPLqMTR1I4GQhN9
 g3YwiRqUHpnNoY7kjt6IxtmA/o+9t+/0MHsnM3pAYeTxTj5Rjhv/afrgNav4N+asfSJMOCY+V
 bk/dcV1Utf71cmVHTJV8lUK4PmStCIM3C/8zCgTvHT40ULEQAENe6rEcfV0db90smD65trmHP
 +cz6iOmRwWwAAc3Y0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.09.20 um 21:48 schrieb Hariom Verma via GitGitGadget:
> From: Hariom Verma <hariom18599@gmail.com>
>
> Refactored trailers formatting logic inside pretty.c to a new function
> `format_set_trailers_options()`.
>
> Also, introduced a code to get invalid trailer arguments. As we would
> like to use same logic in ref-filter, it's nice to get invalid trailer
> argument. This will allow us to print accurate error message, while
> using `format_set_trailers_options()` in ref-filter.

This error reporting feature is probably worth its own separate commit.

>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Heba Waly <heba.waly@gmail.com>
> Signed-off-by: Hariom Verma <hariom18599@gmail.com>
> ---
>  Hariom Verma via GitGitGadget |  0
>  pretty.c                      | 83 ++++++++++++++++++++++-------------
>  pretty.h                      | 11 +++++
>  3 files changed, 64 insertions(+), 30 deletions(-)
>  create mode 100644 Hariom Verma via GitGitGadget
>
> diff --git a/Hariom Verma via GitGitGadget b/Hariom Verma via GitGitGadg=
et
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/pretty.c b/pretty.c
> index 2a3d46bf42..bd8d38e27b 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1147,6 +1147,55 @@ static int format_trailer_match_cb(const struct s=
trbuf *key, void *ud)
>  	return 0;
>  }
>
> +int format_set_trailers_options(struct process_trailer_options *opts,
> +				struct string_list *filter_list,
> +				struct strbuf *sepbuf,
> +				const char **arg,
> +				const char **err)

This function is supposed to allocate *err, so it shouldn't be const.

> +{
> +	for (;;) {
> +		const char *argval;
> +		size_t arglen;
> +
> +		if (**arg !=3D ')') {
> +			size_t vallen =3D strcspn(*arg, "=3D,)");
> +			const char *valstart =3D xstrndup(*arg, vallen);

This is owned by this block and released a few lines down, so it
shouldn't be const.

> +			if (strcmp(valstart, "key") &&
> +				strcmp(valstart, "separator") &&
> +				strcmp(valstart, "only") &&
> +				strcmp(valstart, "valueonly") &&
> +				strcmp(valstart, "unfold")) {

Weird indentation of the second and later strcmp() calls.  And they
duplicate the checks done by the parsing code below, right?

> +					*err =3D xstrdup(valstart);

Here's the *err allocation mentioned above.

> +					return 1;
> +				}
> +			free((char *)valstart);
> +		}
> +		if (match_placeholder_arg_value(*arg, "key", arg, &argval, &arglen)) =
{
> +			uintptr_t len =3D arglen;
> +
> +			if (!argval)
> +				return 1;
> +
> +			if (len && argval[len - 1] =3D=3D ':')
> +				len--;
> +			string_list_append(filter_list, argval)->util =3D (char *)len;

You didn't add this, but I wonder what's up with the arglen-in-util
trickery here -- strcasecmp() might even be faster.

And also why all this expensive-looking %(trailers) parsing is done
for each commit and not just once.

(Both outside the scope of this series, unless you want to address
them as well.)

> +
> +			opts->filter =3D format_trailer_match_cb;
> +			opts->filter_data =3D filter_list;
> +			opts->only_trailers =3D 1;
> +		} else if (match_placeholder_arg_value(*arg, "separator", arg, &argva=
l, &arglen)) {
> +			char *fmt =3D xstrndup(argval, arglen);
> +			strbuf_expand(sepbuf, fmt, strbuf_expand_literal_cb, NULL);
> +			free(fmt);
> +			opts->separator =3D sepbuf;
> +		} else if (!match_placeholder_bool_arg(*arg, "only", arg, &opts->only=
_trailers) &&
> +				!match_placeholder_bool_arg(*arg, "unfold", arg, &opts->unfold) &&
> +				!match_placeholder_bool_arg(*arg, "valueonly", arg, &opts->value_on=
ly))

Weird indentation of the second and third match_placeholder_bool_arg()
calls.

> +			break;

If you need to capture an invalid argument value, you can do that here
without adding duplicate checks.

> +	}
> +	return 0;
> +}
> +
>  static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>  				const char *placeholder,
>  				void *context)
> @@ -1417,41 +1466,14 @@ static size_t format_commit_one(struct strbuf *s=
b, /* in UTF-8 */
>  		struct string_list filter_list =3D STRING_LIST_INIT_NODUP;
>  		struct strbuf sepbuf =3D STRBUF_INIT;
>  		size_t ret =3D 0;
> +		const char *unused =3D NULL;

This function is going to free() unused later, so it shouldn't be const.

>
>  		opts.no_divider =3D 1;
>
>  		if (*arg =3D=3D ':') {
>  			arg++;
> -			for (;;) {
> -				const char *argval;
> -				size_t arglen;
> -
> -				if (match_placeholder_arg_value(arg, "key", &arg, &argval, &arglen)=
) {
> -					uintptr_t len =3D arglen;
> -
> -					if (!argval)
> -						goto trailer_out;
> -
> -					if (len && argval[len - 1] =3D=3D ':')
> -						len--;
> -					string_list_append(&filter_list, argval)->util =3D (char *)len;
> -
> -					opts.filter =3D format_trailer_match_cb;
> -					opts.filter_data =3D &filter_list;
> -					opts.only_trailers =3D 1;
> -				} else if (match_placeholder_arg_value(arg, "separator", &arg, &arg=
val, &arglen)) {
> -					char *fmt;
> -
> -					strbuf_reset(&sepbuf);
> -					fmt =3D xstrndup(argval, arglen);
> -					strbuf_expand(&sepbuf, fmt, strbuf_expand_literal_cb, NULL);
> -					free(fmt);
> -					opts.separator =3D &sepbuf;
> -				} else if (!match_placeholder_bool_arg(arg, "only", &arg, &opts.onl=
y_trailers) &&
> -					   !match_placeholder_bool_arg(arg, "unfold", &arg, &opts.unfold) =
&&
> -					   !match_placeholder_bool_arg(arg, "valueonly", &arg, &opts.value=
_only))

The match_placeholder_bool_arg() calls were still properly indented
here.

> -					break;
> -			}
> +			if (format_set_trailers_options(&opts, &filter_list, &sepbuf, &arg, =
&unused))
> +				goto trailer_out;
>  		}
>  		if (*arg =3D=3D ')') {
>  			format_trailers_from_commit(sb, msg + c->subject_off, &opts);
> @@ -1460,6 +1482,7 @@ static size_t format_commit_one(struct strbuf *sb,=
 /* in UTF-8 */
>  	trailer_out:
>  		string_list_clear(&filter_list, 0);
>  		strbuf_release(&sepbuf);
> +		free((char *)unused);

Here is the free() call I mentioned above.

>  		return ret;
>  	}
>
> diff --git a/pretty.h b/pretty.h
> index 071f2fb8e4..cfe2e8b39b 100644
> --- a/pretty.h
> +++ b/pretty.h
> @@ -6,6 +6,7 @@
>
>  struct commit;
>  struct strbuf;
> +struct process_trailer_options;
>
>  /* Commit formats */
>  enum cmit_fmt {
> @@ -139,4 +140,14 @@ const char *format_subject(struct strbuf *sb, const=
 char *msg,
>  /* Check if "cmit_fmt" will produce an empty output. */
>  int commit_format_is_empty(enum cmit_fmt);
>
> +/*
> + * Set values of fields in "struct process_trailer_options"
> + * according to trailers arguments.
> + */
> +int format_set_trailers_options(struct process_trailer_options *opts,
> +				struct string_list *filter_list,
> +				struct strbuf *sepbuf,
> +				const char **arg,
> +				const char **err);
> +
>  #endif /* PRETTY_H */
>

