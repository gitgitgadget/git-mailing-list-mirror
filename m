Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E408C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 07:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03C49610C8
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 07:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhIIHr2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 03:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbhIIHq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 03:46:59 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61F6C061575
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 00:45:50 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 9so1376099edx.11
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 00:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=qj4WCldC5O/ArCaSxKT3gfs8LrhLxNnclDYpwJzlkj4=;
        b=Z7oItC1Qzi1fOMZeazKZoxuUlIvi+QE63d51VJJwH4NOnJ5bZt6MJvGDg41BDqjN1D
         xEnBMVqwyCxA9tZLIzPIRVWrzFtkOzD/X+htSAGlYtWyl4PrWBcQamRHfGa3amRXXg1C
         xnXS6EUjT4YTAGI9JZz/ZA3vTWu/QDts3VUFZ1oehIzeO72mm8iyCK/VtYQKp5IKblz3
         0SA9+1/cYOS4bgm7Sr0sifWQ/0QlWT6nnrVDui+p0oEW4mDt7xRVQROtY1L8tCcXkitu
         KjIY1GsIyM8TIOt24VorlSFKKZiI/A9UC3+rC3AcXrYQ5j9oDvuFdpPa69upX9aaoEgG
         ahXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=qj4WCldC5O/ArCaSxKT3gfs8LrhLxNnclDYpwJzlkj4=;
        b=qF4vvghJwOWK24EnxPh1P6ZIUBJEss/6K3a66EsXfkJTS8Ud9pL8Ap3hpPkIGO8/7q
         9abTeij9QOWtdvn+/2KK4oQoJ2z3gLyafMWg3BEaU6nn2O3nhztgh7F/xwl8OuetWvTx
         hejk1PGA7rnFOEK323QoGXl4k/fk8ogNji2vs6WUPkEQXxkj8CPlr7e2ZT1oF87aC4ju
         JXUQ/WpG7gEh33VxyoLElPUzKXUCxMiGyeED9NN/NJINALAXPUYN+cw6EHH3/YsIAPvq
         krEeLOCLvOXaoUHzqXUNdplDX1i16m/pZbQ+P/X1BVoLJxhO6depYN4apt25Z9xzOA7f
         QLhA==
X-Gm-Message-State: AOAM532YqelMmaDIrE3AMUZ/th6CJ9seds4VIdRh1+L/VK9vbeEX94fD
        7DHIbjnHjkW3TQ/V2S/wT2YF2S5qJf4TqA==
X-Google-Smtp-Source: ABdhPJyNiP8/vTk5NtuUKr239HKetT5wzEF9CJZs1wS65JQtYjMjuU1Lt/a7Uas9xV9avF6172Sxuw==
X-Received: by 2002:a05:6402:1d36:: with SMTP id dh22mr1812908edb.16.1631173549027;
        Thu, 09 Sep 2021 00:45:49 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id dh16sm306290edb.63.2021.09.09.00.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 00:45:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/9] bulk-checkin.c: store checksum directly
Date:   Thu, 09 Sep 2021 09:38:48 +0200
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631157880.git.me@ttaylorr.com>
 <20b35ce0505d7bcc84b6fd68a33e0b6b1afa31e6.1631157880.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20b35ce0505d7bcc84b6fd68a33e0b6b1afa31e6.1631157880.git.me@ttaylorr.com>
Message-ID: <87lf46faz9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 08 2021, Taylor Blau wrote:

> finish_bulk_checkin() stores the checksum from finalize_hashfile() by
> writing to the `hash` member of `struct object_id`, but that hash has
> nothing to do with an object id (it's just a convenient location that
> happens to be sized correctly).
>
> Store the hash directly in an unsigned char array. This behaves the same
> as writing to the `hash` member, but makes the intent clearer (and
> avoids allocating an extra four bytes for the `algo` member of `struct
> object_id`).
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  bulk-checkin.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index b023d9959a..6283bc8bd9 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -25,7 +25,7 @@ static struct bulk_checkin_state {
>  
>  static void finish_bulk_checkin(struct bulk_checkin_state *state)
>  {
> -	struct object_id oid;
> +	unsigned char hash[GIT_MAX_RAWSZ];
>  	struct strbuf packname = STRBUF_INIT;
>  	int i;
>  
> @@ -37,11 +37,11 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
>  		unlink(state->pack_tmp_name);
>  		goto clear_exit;
>  	} else if (state->nr_written == 1) {
> -		finalize_hashfile(state->f, oid.hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
> +		finalize_hashfile(state->f, hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
>  	} else {
> -		int fd = finalize_hashfile(state->f, oid.hash, 0);
> -		fixup_pack_header_footer(fd, oid.hash, state->pack_tmp_name,
> -					 state->nr_written, oid.hash,
> +		int fd = finalize_hashfile(state->f, hash, 0);
> +		fixup_pack_header_footer(fd, hash, state->pack_tmp_name,
> +					 state->nr_written, hash,
>  					 state->offset);
>  		close(fd);
>  	}
> @@ -49,7 +49,7 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
>  	strbuf_addf(&packname, "%s/pack/pack-", get_object_directory());
>  	finish_tmp_packfile(&packname, state->pack_tmp_name,
>  			    state->written, state->nr_written,
> -			    &state->pack_idx_opts, oid.hash);
> +			    &state->pack_idx_opts, hash);
>  	for (i = 0; i < state->nr_written; i++)
>  		free(state->written[i]);

[This commit looks good, nothing needs to be fixed here, just a
digression]:

This is a good change, FWIW I came up with in my version, and then ended
up ejecting it to resist the urge to go on some general cleanup spree, I
guess we can just fix *this* one :)

Anyway, I agree that this should be in & having it is good.

The code pattern being fixed here is more insidious than your commit
message describes though, since fa33c3aae23 (bulk-checkin.c: convert to
use struct object_id, 2015-03-13) when this was converted from "unsigned
char sha1[20]" to "struct object_id" we've had a landmine waiting to be
stepped on here.


The "oid" automatic variable will get initialized to some garbage, we
then write to just the "hash" member, but leave the "algo" member in
some undefined state.

Thus when you e.g. call oid_to_hex(&oid) here you might get a segfault,
e.g. on my box because in hex.c we'll try to access
&hash_algos[oid->algo], where oid->algo happens to be set to the garbage
-9872.

If somebody's interested in some follow-up cleanup renaming the "hash"
member to say "hash2" in hash.h, and compiling with "make -k" will find
all the sites that are using it directly,

I looked in detail at a few, and many can either be converted to just
use "struct object_id" without playing around with "oid.hash", and some
share the bug/landmine being fixed here.


