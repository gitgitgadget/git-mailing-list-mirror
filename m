Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472F2C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 16:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2360261184
	for <git@archiver.kernel.org>; Thu, 27 May 2021 16:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbhE0Qh4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 12:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhE0Qhy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 12:37:54 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDBCC061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 09:36:21 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id o14-20020a4a384e0000b029020ec48a2358so241048oof.13
        for <git@vger.kernel.org>; Thu, 27 May 2021 09:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Y7FW0pMExlk+WljYkcd8ci4bqPSnAExZtcQfhT/LTP0=;
        b=abCjkGXy1aLXVGketAKlE7QOWSVbzdo3Zz/+bZCqz/r2+oeOkPtfbNrUGxDCc2i5Vm
         /lYKEKvDVIR6at0ljCRbsQE+2toptwKCjOOa6OZ0wInzcTFfj2wqupTQgwZGiHYA66nR
         w1PlSW6jWqXJCBeoPVyItalV9a+j6nkEjClUts7O7Eks27AXwDwtMnMyHeRr/rnXwr9t
         Bj1oib3+tMkIJHzuUeiaLx8I3CbJerR9OQIsSXi5uXtZYQ6CtJP/RD9n1Jase7ff7he4
         HUlwkDRX1yDCaC5ymD4a4DC1eqW54NehNlULF6IWvvf2eWrS+/ro6CUcReqqVMg6T8cu
         PO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Y7FW0pMExlk+WljYkcd8ci4bqPSnAExZtcQfhT/LTP0=;
        b=dfkwEk2LjGs7ZnZ+hE/BRL9h9dVtYc33IaWa/VpoiIn4GsnFDYXH4xcJSN/DjyFxT7
         TLYjwdzmcy47yL0arjMlCSNGxhGIWm7jOZy4a5qTUBOcl721UOPJTrZZrms2YsmUXZ+l
         D/z35mGkqLagQVxzeXOuSZo/sQa6sCAz75WDb5S9AU2b7gGqYFziB1bLuUhMjbu/p6AZ
         HJ4g6ahfWTUbvPKrRXS4/+cqO/mONxqAmD8grx5bEwHJI0S3Q33R3aRPaCQx+NTGxmUF
         75AuMF0vQAsFk8TgRmB7BkK9ErglZXrINQQqzgqiwrLyzP6cEOYajOB1BRhutpChaUAK
         0E/g==
X-Gm-Message-State: AOAM532zycV0HWpDGEKh0W8I6wzb1F1P8pV+Wz47GXhPi+tcOGoXekmN
        WO9BJJwmmI5HzTB5UcVQOLw=
X-Google-Smtp-Source: ABdhPJweUm+mr2wkNjmjtG9+Vct0tkUnNZXENdJsi6EIkvHwT+6DydrP9ZhlC9Dq2+x5iRDRZS1UQQ==
X-Received: by 2002:a4a:8706:: with SMTP id z6mr3445547ooh.41.1622133380815;
        Thu, 27 May 2021 09:36:20 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id v19sm579823otq.35.2021.05.27.09.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 09:36:20 -0700 (PDT)
Date:   Thu, 27 May 2021 11:36:18 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Message-ID: <60afca827a28f_265302085b@natae.notmuch>
In-Reply-To: <b3848f24f2d3f91fc96f20b5a08cbfbe721acbd6.1622126603.git.gitgitgadget@gmail.com>
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
 <b3848f24f2d3f91fc96f20b5a08cbfbe721acbd6.1622126603.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH 1/2] [GSOC] ref-filter: add %(raw) atom
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu via GitGitGadget wrote:

> +static int raw_atom_parser(const struct ref_format *format, struct used_atom *atom,
> +				const char *arg, struct strbuf *err)
> +{
> +	if (!arg) {
> +		atom->u.raw_data.option = RAW_BARE;
> +	} else if (!strcmp(arg, "size"))

No need for braces.

  if (!arg)
    ...
  else

> @@ -1307,10 +1349,22 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
>  			continue;
>  		if (deref)
>  			name++;
> -		if (strcmp(name, "body") &&
> -		    !starts_with(name, "subject") &&
> -		    !starts_with(name, "trailers") &&
> -		    !starts_with(name, "contents"))
> +
> +		if (starts_with(name, "raw")) {
> +			if (atom->u.raw_data.option == RAW_BARE) {
> +				v->s = xmemdupz(buf, buf_size);
> +				v->s_size = buf_size;
> +			} else if (atom->u.raw_data.option == RAW_LENGTH)
> +				v->s = xstrfmt("%"PRIuMAX, (uintmax_t)buf_size);

I think it's better to be consistent: if you used braces in the if, uses
braces in else.

> +			continue;
> +		}

> +static int memcasecmp(const void *vs1, const void *vs2, size_t n)

Why void *? We can delcare as char *.

> +{
> +	size_t i;
> +	const char *s1 = (const char *)vs1;
> +	const char *s2 = (const char *)vs2;

Then we avoid this extra step.

> +	for (i = 0; i < n; i++) {
> +		unsigned char u1 = s1[i];
> +		unsigned char u2 = s2[i];

There's no need for two entirely new variables...

> +		int U1 = toupper (u1);
> +		int U2 = toupper (u2);

You can do toupper(s1[i]) directly (BTW, there's an extra space: `foo(x)`,
not `foo (x)`).

While we are at it, why keep an extra index from s1, when s1 is never
used again?

We can simply advance both s1 and s2:

  s1++, s2++

> +		int diff = (UCHAR_MAX <= INT_MAX ? U1 - U2
> +			: U1 < U2 ? -1 : U2 < U1);

I don't understand what this is supposed to achieve. Both U1 and U2 are
integers, pretty low integers actually.

If we get rid if that complexity we don't even need U1 or U2, just do:

  diff = toupper(u1) - toupper(u2);

> +		if (diff)
> +			return diff;
> +	}
> +	return 0;
> +}

All we have to do is define the end point, and then we don't need i:

	static int memcasecmp(const char *s1, const char *s2, size_t n)
	{
		const char *end = s1 + n;
		for (; s1 < end; s1++, s2++) {
			int diff = tolower(*s1) - tolower(*s2);
			if (diff)
				return diff;
		}
		return 0;
	}

(and I personally prefer lower to upper)

Check the following resource for a detailed explanation of why my
modified version is considered good taste:

https://github.com/felipec/linked-list-good-taste

>  static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, struct ref_array_item *b)
>  {
>  	struct atom_value *va, *vb;
> @@ -2304,6 +2382,7 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
>  	int cmp_detached_head = 0;
>  	cmp_type cmp_type = used_atom[s->atom].type;
>  	struct strbuf err = STRBUF_INIT;
> +	size_t slen = 0;
>  
>  	if (get_ref_atom_value(a, s->atom, &va, &err))
>  		die("%s", err.buf);
> @@ -2317,10 +2396,32 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
>  	} else if (s->sort_flags & REF_SORTING_VERSION) {
>  		cmp = versioncmp(va->s, vb->s);
>  	} else if (cmp_type == FIELD_STR) {
> -		int (*cmp_fn)(const char *, const char *);
> -		cmp_fn = s->sort_flags & REF_SORTING_ICASE
> -			? strcasecmp : strcmp;
> -		cmp = cmp_fn(va->s, vb->s);
> +		if (va->s_size == ATOM_VALUE_S_SIZE_INIT &&
> +		    vb->s_size == ATOM_VALUE_S_SIZE_INIT) {
> +			int (*cmp_fn)(const char *, const char *);
> +			cmp_fn = s->sort_flags & REF_SORTING_ICASE
> +				? strcasecmp : strcmp;
> +			cmp = cmp_fn(va->s, vb->s);
> +		} else {
> +			int (*cmp_fn)(const void *, const void *, size_t);
> +			cmp_fn = s->sort_flags & REF_SORTING_ICASE
> +				? memcasecmp : memcmp;
> +
> +			if (va->s_size != ATOM_VALUE_S_SIZE_INIT &&
> +			    vb->s_size != ATOM_VALUE_S_SIZE_INIT) {
> +				cmp = cmp_fn(va->s, vb->s, va->s_size > vb->s_size ?
> +				       vb->s_size : va->s_size);
> +			} else if (va->s_size == ATOM_VALUE_S_SIZE_INIT) {
> +				slen = strlen(va->s);
> +				cmp = cmp_fn(va->s, vb->s, slen > vb->s_size ?
> +					     vb->s_size : slen);
> +			} else {
> +				slen = strlen(vb->s);
> +				cmp = cmp_fn(va->s, vb->s, slen > va->s_size ?
> +					     slen : va->s_size);
> +			}
> +			cmp = cmp ? cmp : va->s_size - vb->s_size;
> +		}

This hurts my eyes. I think the complexity of this chunk warrants a
separate function. Then the logic would be easer to see.

Cheers.

-- 
Felipe Contreras
