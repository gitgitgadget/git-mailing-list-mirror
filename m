Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0001FC38A2D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 23:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJUXK4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 19:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJUXKz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 19:10:55 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F6F22C616
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 16:10:53 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id e15so3577584iof.2
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 16:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hZYXickauaDJJnLR8UvPalyET45jousg0fxL+vzijPk=;
        b=ylawnhSGs+OP2kadmV01Su3ELF3DbjS4z0+Q4+G3jP4Uq/EVJ8Ra5UjftN4AthCQRn
         GHNjhUtu2FHYNapMW/GNUz316Mlldea3k00JXJ2noNmLvCWp882WojUQDP/7d4qrPLeX
         fx/O2liMaQ2xcWwAc/nMe3XlWPUReuO3/J16UCxmNtDJ018+OlqdR1/LEPJRcBp5ddYV
         aC3NE0jKiR/7nDnIUtp0wh3Og9oKPdUkSkCq5i6X/54T5HN1PxQmvX1ASkxDm7rUVkkW
         XeETRv78Od/ZZq0OPAl+Ufph0gSdACh22dF23Ftn0uyQEQUgesWOXAYYgRJOg+HnrVZX
         mp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZYXickauaDJJnLR8UvPalyET45jousg0fxL+vzijPk=;
        b=ksmarr8kGnsLtwuLCQn1naGG9zeBGjsV4uHSBCoR462dxitNIX8komNZovhsfULmoQ
         d2DcUPVGUwLAGErfnpgBQ4KQCqchk5hBEorpIOKK2J4+JaHHIgkiuwDkGXPxnWb8YXmG
         Cpdys7SkVX1PXRxLUYe7jHH93bvwZcUe901fcREl9L7yC26XRdpxo54Z++DFgxOAxqC0
         hanLibBfL9Bu/E4rC8197ih0mizUuqxBj8DapiW6l/uEKFPHW7FCW1FsBMpB06TQQwvO
         qTGmTgtdFh5lZqc7rP/uH3uHi0uhgwsa6715Ot/xEkbtGKn0jzmdSmVewBUBTJF9Jg5d
         Ybrg==
X-Gm-Message-State: ACrzQf2xNbyXOY6ZxD9MdEq6b7j4/oZvY8vv9ELnIWuGJYJb9hZDE3aI
        kFJSR0ioxlQOBVIGyVKsJeM2Pw==
X-Google-Smtp-Source: AMsMyM4/TJtHaUV5pfomqHENl2Jm5OPmepnspsCad05hDMUKWlz/uL7pFDCJvvT7JYg/Xkk+hwOvYw==
X-Received: by 2002:a05:6602:14c1:b0:689:34d0:a0ef with SMTP id b1-20020a05660214c100b0068934d0a0efmr14502396iow.69.1666393853139;
        Fri, 21 Oct 2022 16:10:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a18-20020a027352000000b0036348f096acsm4728725jae.6.2022.10.21.16.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 16:10:52 -0700 (PDT)
Date:   Fri, 21 Oct 2022 19:10:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>
Subject: Re: [PATCH 1/4] repack: convert "names" util bitfield to array
Message-ID: <Y1Mm9zTX3XwN3IWu@nand.local>
References: <Y1MR7V8kGolLd8eh@coredump.intra.peff.net>
 <Y1MSWAx+baTklfLL@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1MSWAx+baTklfLL@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 05:42:48PM -0400, Jeff King wrote:
> We keep a string_list "names" containing the hashes of packs generated
> on our behalf by pack-objects. The util field of each item is treated as
> a bitfield that tells us which extensions (.pack, .idx, .rev, etc) are
> present for each name.
>
> Let's switch this to allocating a real array. That will give us room in
> a future patch to store more data than just a single bit per extension.
> And it makes the code a little easier to read, as we avoid casting back
> and forth between uintptr_t and a void pointer.

Thanks, this is a nice summary that matches my own recollection from
working in this area.

> diff --git a/builtin/repack.c b/builtin/repack.c
> index a5bacc7797..8e71230bf7 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -247,11 +247,15 @@ static struct {
>  	{".idx"},
>  };
>
> -static unsigned populate_pack_exts(char *name)
> +struct generated_pack_data {
> +	char exts[ARRAY_SIZE(exts)];
> +};

Makes sense, this replaces the individual bits of the `void *` we were
treating as an array of "which extensions associated with this pack were
generated by pack-objects"?

> +
> +static struct generated_pack_data *populate_pack_exts(const char *name)
>  {
>  	struct stat statbuf;
>  	struct strbuf path = STRBUF_INIT;
> -	unsigned ret = 0;
> +	struct generated_pack_data *data = xcalloc(1, sizeof(*data));

I'm nitpicking, but we could replace this with;

  struct generated_pack_data *data;

  CALLOC_ARRAY(data, 1);

so that we don't have to rely on calling sizeof(*data). But
sizeof(*data) will always give us the right answer anyway, even if the
name of data's type changed, so what you have is fine, too.

> @@ -261,11 +265,11 @@ static unsigned populate_pack_exts(char *name)
>  		if (stat(path.buf, &statbuf))
>  			continue;
>
> -		ret |= (1 << i);
> +		data->exts[i] = 1;

Great. I'm happy to see this bit-twiddling go away, but..

> @@ -320,7 +324,7 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
>  					  line.buf);
>  		write_promisor_file(promisor_name, NULL, 0);
>
> -		item->util = (void *)(uintptr_t)populate_pack_exts(item->string);
> +		item->util = populate_pack_exts(item->string);

I'm even happier to see this go away ;-).

> @@ -1115,7 +1121,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  		write_midx_file(get_object_directory(), NULL, NULL, flags);
>  	}
>
> -	string_list_clear(&names, 0);
> +	string_list_clear(&names, 1);

Good. Now that we're actually allocating memory in the `->util` field,
we care about freeing it, too. Thanks for remembering this.

Thanks,
Taylor
