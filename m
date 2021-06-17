Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA91C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 07:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B109613B9
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 07:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhFQHZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 03:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbhFQHYp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 03:24:45 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC62C0611C2
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 00:22:30 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id n20so2538521edv.8
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 00:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=uvI3PzQ0N1rkX8CK2LQ2ZVa5yZU7V3UtRi13B3h8gyg=;
        b=ClX8SUQBAyOoZx8jbrpx1u+UzU8jmCw6YxEVvT/Z2AT8gxA07eNgV7u5D5oZgRvdg7
         6tfHNzBcCfTO2aMqgHWR841Wm2ZC/6vsmtgHe02lmiuv9D1sc90PFKzfN96/OwWDCTz6
         NcicuNiVaXDLy+UXOgBsOUu4yF1kQX2glsEyNEVPuxBHAQH2svFI2MCAppPKIpTDoh3d
         gCGay6Nzcj8eaG0+9AuKjmUJg0SIvJmS/3+Ta6ROhLCH5PUlWnRVYHbtLY/calGgDz57
         Yx1ChF7vufeyLnxiaZSJ4WzuzHAiaxJzA3IlO6AN1ljGZxGW1nhXdqoeQHQejmyIdxY7
         Pmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=uvI3PzQ0N1rkX8CK2LQ2ZVa5yZU7V3UtRi13B3h8gyg=;
        b=QmYmtGpGWbEGwyElwmV6ovRzCR51KedOW0SgjFw9ucGK7pyG7wZ5H2Zr4yrSoklHmH
         nqkCfspOA8kK14cVyZhfWjsdBQ4seTMNv+8f5UsTzABcoIuiRhaG3LIS9EI4Z/8qI9AR
         1UQOsN+Thmwyiilasuj6VK1VtpzcqAtUZZbAZ1ROIe3XP2FUTCfwar3Zr5/zFQVsExLQ
         hfD17h+obBq8ndK21eqB9ifF+CNlcaq9Oczs1l+Ad/RRJtCKvGmvEdtWyUyzKgJvhc2y
         3JBGJ04AB7YI4l494lC/qGNtVTpxCi0V2UWwwnT2iAwvCz5qTjBLb7KHpIWja44+S/Il
         VsCg==
X-Gm-Message-State: AOAM531hdjsTTo7/Nc+cuAzUlbHHHLbYRRGX7gLWGveMpIASntAU8CoR
        v0llVEeue1LhrNvo+t3b/6jX8QNmJrFUaw==
X-Google-Smtp-Source: ABdhPJxW1WzocJlGs0X2jp3JVLnNSLrFUIa5kZqQFAAgQj5GH3m500OzSXHl/5n1Pio25YTU0D+ZNQ==
X-Received: by 2002:aa7:cdc8:: with SMTP id h8mr4540021edw.323.1623914548608;
        Thu, 17 Jun 2021 00:22:28 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id q9sm3570970edv.31.2021.06.17.00.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 00:22:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 8/8] [GSOC] cat-file: re-implement --textconv, --filters
 options
Date:   Thu, 17 Jun 2021 09:18:18 +0200
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
 <0004d5b24a0fb735d7fa9cb9a8e214d6e838baeb.1623496458.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <0004d5b24a0fb735d7fa9cb9a8e214d6e838baeb.1623496458.git.gitgitgadget@gmail.com>
Message-ID: <87zgvpvtu4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jun 12 2021, ZheNing Hu via GitGitGadget wrote:

> From: ZheNing Hu <adlternative@gmail.com>

>  	opt->format.format = format.buf;
> +	if (opt->cmdmode == 'c')
> +		opt->format.use_textconv = 1;
> +	if (opt->cmdmode == 'w')
> +		opt->format.use_filters = 1;
> +


Style nit: if/if -> if/else if, both can't be true.

> +		/* get the type and size */
> +		if (oid_object_info_extended(the_repository, &oi->oid, &oi->info,
> +					OBJECT_INFO_LOOKUP_REPLACE))
> +			return strbuf_addf_ret(err, 1, _("%s missing"),
> +					       oid_to_hex(&oi->oid));
> +
> +		oi->info.sizep = NULL;
> +		oi->info.typep = NULL;
> +		oi->info.contentp = temp_contentp;

Here we have a call function and error if bad, then proceed to populate
stuff (good)...

> +
> +		if (use_textconv) {
> +			act_oi = *oi;
> +
> +			if(!ref->rest)
> +				return strbuf_addf_ret(err, -1, _("missing path for '%s'"),
> +						       oid_to_hex(&act_oi.oid));
> +			if (act_oi.type == OBJ_BLOB) {
> +				if (textconv_object(the_repository,
> +						    ref->rest, 0100644, &act_oi.oid,
> +						    1, (char **)(&act_oi.content), &act_oi.size)) {
> +					actual_oi = &act_oi;
> +					goto success;
> +				}
> +			}
> +		}


Maybe change the if (A) { if (B) {} ) to if (A && B) {} ?

>  	}
>  	if (oid_object_info_extended(the_repository, &oi->oid, &oi->info,
>  				     OBJECT_INFO_LOOKUP_REPLACE))
> @@ -1748,19 +1786,43 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
>  		BUG("Object size is less than zero.");
>  
>  	if (oi->info.contentp) {
> -		*obj = parse_object_buffer(the_repository, &oi->oid, oi->type, oi->size, oi->content, &eaten);
> +		if (use_filters) {
> +			if(!ref->rest)
> +				return strbuf_addf_ret(err, -1, _("missing path for '%s'"),
> +						       oid_to_hex(&oi->oid));
> +			if (oi->type == OBJ_BLOB) {
> +				struct strbuf strbuf = STRBUF_INIT;
> +				struct checkout_metadata meta;
> +				act_oi = *oi;
> +
> +				init_checkout_metadata(&meta, NULL, NULL, &act_oi.oid);
> +				if (convert_to_working_tree(&the_index, ref->rest, act_oi.content, act_oi.size, &strbuf, &meta)) {
> +					act_oi.size = strbuf.len;
> +					act_oi.content = strbuf_detach(&strbuf, NULL);
> +					actual_oi = &act_oi;
> +				} else {
> +					die("could not convert '%s' %s",
> +					    oid_to_hex(&oi->oid), ref->rest);
> +				}

... but here instead of "if (!x) { bad } do stuff" we have if (x) {do
stuff} else { bad }". Better to get the die out of the way, and avoid
the indentation on the "do stuff" IMO.


> -#define REF_FORMAT_INIT { NULL, NULL, 0, 0, 0, -1 }
> +#define REF_FORMAT_INIT { NULL, NULL, 0, 0, 0, 0, 0, -1 }

Not a new problem, but an earlier cleanup to simply change this to
designated initializers would be welcome, see recent work of mine in
fsck.h for an example.

I.e. we keep churning on changing this *_INIT just to populate the one
-1 field at the end, can also be simply:

    #define FOO_INIT { .that_field = 1 }

