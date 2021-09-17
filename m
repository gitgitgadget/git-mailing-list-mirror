Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A94C4332F
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 02:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07BBC6113E
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 02:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242851AbhIQCd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 22:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242805AbhIQCdu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 22:33:50 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79AAC061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 19:32:28 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id a22so10365660iok.12
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 19:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cEf70Fu0Guxs/eGU0I76MyJuJsGAKhkkXdmU/vvjJ58=;
        b=LgrBMdqFW9J21vQP1TSeXhoiZm2XsDaF22/pVvWMq6MWbrfiAr3rKExaAsZohwhkUg
         uHE1scBWGLJvYGfXxt0raGd9ukDt8z+UKLZUtx6Di47jI1sFyYntQkFXEBx5Q8jVQxMa
         80oaoeyHcVXT4AJ9XaP84wthfpItipIpjgtK1W2wG37ADsVbo5feqVWcEh6pToILc8nW
         0RlXUEt2+i8X09jEfA75Oij29meqfLTSoolndTJxPWOUFXYFgPJvVU9M0hLOumRK/jwz
         +47uNSzTv6oymJH6tY6eh4KbogS+zZ9gd5pRjo6PqUE2rKPs4I06X9svlk+uhbaVg+rY
         Cs5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cEf70Fu0Guxs/eGU0I76MyJuJsGAKhkkXdmU/vvjJ58=;
        b=w6d4cg32j9tVlXJT1NzXSuAyNreHJLXlBpggmGSgT9JScwmvBgTiTgphtDd4ezrpwi
         YOQkEUedrW+jXy3GnY4ND27SK/Cb/W+2NjXrye36UpkgClA+v9HQ+4wVB0Gdbc4E6Fos
         c2dqvgaz/ZI2Jkp9xd+73bps3nDuL+7KYHEPZx219HULU7dhQGUH2d7o/7LrTfyS3M+y
         HStklfSZqD2yFDvRckVEz5KzWqkX5p80wSpDcQ3nqxFzLHaOROfS6Fqe1WFyv5oqwX+v
         1mA2uOsmBtH0vJgWndHTcjZ8OYRUAqw/y8E2hIAt8v6NU5MKNG5R0KBdJZvA4deIVYYO
         vlWg==
X-Gm-Message-State: AOAM532oXNVdZwgBJ4HyOc42k1wq5xZqzDl9zNIexDuBNDr3DWEaeIeS
        OzobAhFEoXf3SFgMBCJvXHwbFkckqoVjMtGu
X-Google-Smtp-Source: ABdhPJxKhbWoX+Xcywk2+gRqd0BN6w/fIaHXPVam8dluKAk/T0it698/9pu1n7XsWOsSYSSC6oV0Gg==
X-Received: by 2002:a6b:5819:: with SMTP id m25mr6696904iob.105.1631845947925;
        Thu, 16 Sep 2021 19:32:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i14sm2758360iol.27.2021.09.16.19.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 19:32:27 -0700 (PDT)
Date:   Thu, 16 Sep 2021 22:32:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v6 14/22] object-file.c: stop dying in
 parse_loose_header()
Message-ID: <YUP+Ni1tFKolLZd4@nand.local>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
 <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
 <patch-v6-14.22-7c9819d37c5-20210907T104559Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v6-14.22-7c9819d37c5-20210907T104559Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 12:58:09PM +0200, Ævar Arnfjörð Bjarmason wrote:
> It thus makes sense to further libify the interface so that it stops
> calling die() when it encounters OBJ_BAD, and instead rely on its
> callers to check the populated "oi->typep".

Hmm. I thought we got rid of this behavior in a previous commit? Perhaps
I'm thinking of something else, but I would certainly appreciate a
clarification :).

> @@ -1369,15 +1367,6 @@ int parse_loose_header(const char *hdr,
>  	type = type_from_string_gently(type_buf, type_len, 1);
>  	if (oi->type_name)
>  		strbuf_add(oi->type_name, type_buf, type_len);
> -	/*
> -	 * Set type to 0 if its an unknown object and
> -	 * we're obtaining the type using '--allow-unknown-type'
> -	 * option.
> -	 */
> -	if ((flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE) && (type < 0))
> -		type = 0;
> -	else if (type < 0)
> -		die(_("invalid object type"));

Good, this part moved to loose_object_info() as you said it would.

> @@ -1463,18 +1460,20 @@ static int loose_object_info(struct repository *r,
>  		status = error(_("unable to unpack %s header"),
>  			       oid_to_hex(oid));
>  	}
> -
> -	if (status < 0) {
> -		/* Do nothing */
> -	} else if (hdrbuf.len) {
> -		if ((status = parse_loose_header(hdrbuf.buf, oi, flags)) < 0)
> -			status = error(_("unable to parse %s header with --allow-unknown-type"),
> -				       oid_to_hex(oid));
> -	} else if ((status = parse_loose_header(hdr, oi, flags)) < 0) {
> -		status = error(_("unable to parse %s header"), oid_to_hex(oid));
> +	if (!status) {
> +		if (!parse_loose_header(hdrbuf.len ? hdrbuf.buf : hdr, oi))
> +			/*
> +			 * oi->{sizep,typep} are meaningless unless
> +			 * parse_loose_header() returns >= 0.
> +			 */

This double negative is a little confusing. Clearer to say:
"oi->{size,type}p is meaningless if parse_loose_header() returns < 0"?

But I was also a little confused to see that the expression we are
checking here is just that parse_loose_header() returned zero. What
about other positive values?

I think we should either update the comment to say "unless it returns
zero" or the conditional expression to check for >= 0.

> diff --git a/object-store.h b/object-store.h
> index 4064710ae29..584bf5556af 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -500,8 +500,17 @@ int for_each_packed_object(each_packed_object_fn, void *,
>  int unpack_loose_header(git_zstream *stream, unsigned char *map,
>  			unsigned long mapsize, void *buffer,
>  			unsigned long bufsiz, struct strbuf *hdrbuf);
> -int parse_loose_header(const char *hdr, struct object_info *oi,
> -		       unsigned int flags);
> +
> +/**
> + * parse_loose_header() parses the starting "<type> <len>\0" of an
> + * object. If it doesn't follow that format -1 is returned. To check
> + * the validity of the <type> populate the "typep" in the "struct
> + * object_info". It will be OBJ_BAD if the object type is unknown. The
> + * parsed <len> can be retrieved via "oi->sizep", and from there
> + * passed to unpack_loose_rest().
> + */
> +int parse_loose_header(const char *hdr, struct object_info *oi);

OK, I guess this must be what I was confused about earlier (that I
thought we didn't support reading typep if returning OBJ_BAD). But it
seems odd to me that we would get rid of it elsewhere, yet continue
using this pattern here.

Or am I mistaken that the two are different?

Thanks,
Taylor
