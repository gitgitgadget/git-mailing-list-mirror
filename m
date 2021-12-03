Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B58DC433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 14:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381356AbhLCOdD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 09:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbhLCOdD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 09:33:03 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E38C061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 06:29:38 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id w1so12307443edc.6
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 06:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=KTkxTTMA15rWlO0qv/7Q3bwl3AwsbKvjBf4ep0lOa4w=;
        b=bE2WYZ8KF2pObYS+jzTsghNJVGuuS57NWoFTEUWHX/T0E3TsWW5AkfEjPQs3eq5WmO
         WFC8k2d1SPPdHNJXJS0lJujcc0hi/uP7F3y0Nxkhc2Ek3gY82/mtC/enKcneudD9G/Iw
         Ng9AlXzpbkJs6Cl2RcPb5o0xdDrPalW11t0YD8Vuc8H6yuLQm4ljie+7jLEYiEQsotI8
         xXjCm/Mz/+KWrfahdKo6E093NdpRgsDPkHct446D7YwP/ZSxtxHNvc/Ujlj/XFNllUiQ
         aahcIrblTUMq1qF4GjZrbF2TxOdsThfsICZLHiBQdwUvQtkvS5uCuDmtH7GL9vt2R2nB
         U3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=KTkxTTMA15rWlO0qv/7Q3bwl3AwsbKvjBf4ep0lOa4w=;
        b=cYRl0isGrHSDcxrXUCxXzdJ2/bZzZyqWmXLEN9scFNpt/q4xkUbULiVjS6Uiw48SAk
         ht7c3i+BuSSHvMD9L8SaLkHEIN3Mc7TnvQeBbdzsRb/h26KLYKI4jXxR7hUllvPbgtZG
         pSIWfTf7gctE09r/1nccl0ktyC5lVFfxUaFhP9Dr8WZfcXogTWh0EW27akDHp622TCZD
         N8v+xMYywWUILvQdv6lHeN+sF4Nx+koHuXyx9JE1tDeLQzCpqgDNqzNRB63sE2zRV4L5
         JYbDAQe7JxU39DLJObYYqoYxUpVgdi1ky9Wbm21OWuwuo8HMCjdL7YYcmXy8mMiTJMaf
         GdFQ==
X-Gm-Message-State: AOAM531HPogNfjw6THeNFB+ULnDIQ+vY1uhd6Iysus8jHWwTwosipvoI
        AmKToy555PMthLkA0oWB1S0=
X-Google-Smtp-Source: ABdhPJzJjedV5vhUock0+wOH6DpFnjdotJFJqAbjN4hmKG6aWv6dphwvfNwy+OzAR3KKIB4YvBvJMw==
X-Received: by 2002:a17:907:2da3:: with SMTP id gt35mr24157775ejc.314.1638541777360;
        Fri, 03 Dec 2021 06:29:37 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qz24sm2024737ejc.29.2021.12.03.06.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 06:29:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mt9ZA-000AFD-53;
        Fri, 03 Dec 2021 15:29:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH v4 5/5] unpack-objects: unpack_non_delta_entry() read
 data in a stream
Date:   Fri, 03 Dec 2021 15:05:44 +0100
References: <20211122033220.32883-1-chiyutianyi@gmail.com>
 <20211203093530.93589-6-chiyutianyi@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211203093530.93589-6-chiyutianyi@gmail.com>
Message-ID: <211203.86a6hhsqwf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 03 2021, Han Xin wrote:

> From: Han Xin <hanxin.hx@alibaba-inc.com>
> [..]
> +static void write_stream_blob(unsigned nr, unsigned long size)
> +{
> +	char hdr[32];
> +	int hdrlen;
> +	git_zstream zstream;
> +	struct input_zstream_data data;
> +	struct input_stream in_stream = {
> +		.read = feed_input_zstream,
> +		.data = &data,
> +		.size = size,
> +	};
> +	struct object_id *oid = &obj_list[nr].oid;
> +	int ret;
> +
> +	memset(&zstream, 0, sizeof(zstream));
> +	memset(&data, 0, sizeof(data));
> +	data.zstream = &zstream;
> +	git_inflate_init(&zstream);
> +
> +	/* Generate the header */
> +	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX, type_name(OBJ_BLOB), (uintmax_t)size) + 1;
> +
> +	if ((ret = write_loose_object(oid, hdr, hdrlen, &in_stream, 0, 0)))
> +		die(_("failed to write object in stream %d"), ret);
> +
> +	if (zstream.total_out != size || data.status != Z_STREAM_END)
> +		die(_("inflate returned %d"), data.status);
> +	git_inflate_end(&zstream);
> +
> +	if (strict && !dry_run) {
> +		struct blob *blob = lookup_blob(the_repository, oid);
> +		if (blob)
> +			blob->object.flags |= FLAG_WRITTEN;
> +		else
> +			die("invalid blob object from stream");
> +	}
> +	obj_list[nr].obj = NULL;
> +}

Just a side-note, I think (but am not 100% sure) that these existing
occurances aren't needed due to our use of CALLOC_ARRAY():
    
    diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
    index 4a9466295ba..00b349412c5 100644
    --- a/builtin/unpack-objects.c
    +++ b/builtin/unpack-objects.c
    @@ -248,7 +248,6 @@ static void write_object(unsigned nr, enum object_type type,
                            die("failed to write object");
                    added_object(nr, type, buf, size);
                    free(buf);
    -               obj_list[nr].obj = NULL;
            } else if (type == OBJ_BLOB) {
                    struct blob *blob;
                    if (write_object_file(buf, size, type_name(type),
    @@ -262,7 +261,6 @@ static void write_object(unsigned nr, enum object_type type,
                            blob->object.flags |= FLAG_WRITTEN;
                    else
                            die("invalid blob object");
    -               obj_list[nr].obj = NULL;
            } else {
                    struct object *obj;
                    int eaten;

The reason I'm noting it is that the same seems to be true of your new
addition here. I.e. are these assignments to NULL needed?

Anyway, the reason I started poking at this it tha this
write_stream_blob() seems to duplicate much of write_object(). AFAICT
only the writing part is really different, the part where we
lookup_blob() after, set FLAG_WRITTEN etc. is all the same.

Why can't we call write_object() here?

The obvious answer seems to be that the call to write_object_file()
isn't prepared to do the sort of streaming that you want, so instead
you're bypassing it and calling write_loose_object() directly.

I haven't tried this myself, but isn't a better and cleaner approach
here to not add another meaning to what is_null_oid() means, but to just
add a HASH_STREAM flag that'll get passed down as "unsigned flags" to
write_loose_object()? See FLAG_BITS in object.h.

Then the "obj_list[nr].obj" here could also become
"obj_list[nr].obj.flags |= (1u<<12)" or whatever (but that wouldn't
strictly be needed I think.

But by adding the "HASH_STREAM" flag you could I think stop duplicating
the "Generate the header" etc. here and call write_object_file_flags().

I don't so much care about how it's done within unpack-objects.c, but
not having another meaning to is_null_oid() in play would be really
nice, and it this case it seems entirely avoidable.
