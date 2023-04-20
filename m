Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6568EC77B72
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 16:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjDTQbn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 12:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbjDTQbi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 12:31:38 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A624910E5
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 09:31:32 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-54ee0b73e08so51234397b3.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 09:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682008292; x=1684600292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BF5LdrwHYQsOhJLb7EjpcoZVG1VvYCnXGLSeoHbaCvQ=;
        b=SDsjnrYRS/KTB26knI1q8GbNn+gQQdWkQpilJ6LsiTT0NnuLcc+WW+8NFIKBUIY6jv
         LtvtO3n9340PfEJcyKH6BwEG45xLfBtH00lY06vrg6NjdMrvK7jeGlUDnsVu1BGo++lT
         RdBXOmjpUlxkUBQ9iAbPWnNZRwcjBqcNfyGBbw2g1cD9864it5AIBpsAOX5zWxvIoQp9
         v+4HiJlWnklgNHQWBL4si8poZ3L6IfGVpTfSxMTzn+vDDVHGpHKsG4NgWb746GkZXlfT
         OGcm19+PLUJ6lrlvGt8w+hJn32ynghE+vV32R4KMz+IYOIwzTXh0zxik3z/8t8cErJ9y
         jhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682008292; x=1684600292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BF5LdrwHYQsOhJLb7EjpcoZVG1VvYCnXGLSeoHbaCvQ=;
        b=YqHpAtzdBBO2ooxjvWD+q0FlUvQTTzJGU2MKzj6sgls/HWMudZwMg9Zzz5svE+J8rE
         xzyP+f8jrFqlps6h5z0ANWEV+yxhzGpXT7jr70FTQkDKdyw6i2YRohSoh41bxdOW0t0r
         R2EH7wBdML+ZZ7XR83BHDuBo298LQ66Q+HV2qnBc8HAqVagfC+G8l1SzNwoBlIAuo2iZ
         ht9cEo1Gg9ID3S4IHB9+SbWZkI3RRxmPrTvAgyXrci9ms6n9bXu9UF70F5Qwod8h78j0
         ewSRQFnbGsNdqrcRg782+aY+V5mnhUIygDMHJd9vtEIhjFHwDc5ywW0BhqQIXsD49RlF
         YFOA==
X-Gm-Message-State: AAQBX9eWv98P9Vvc1EzPx72eN6tqj1acvshobdAw1Ax01Y/Ht94fQ5PC
        2VcccVk98eFO5gyQUTfzS66RSg==
X-Google-Smtp-Source: AKy350av+JRgwyQDAadY47YaQF3Gf6pIgFTzV31ToVZUPT0x1hk6qCYC9cwT1hEvUtQDd9YO5GGLAA==
X-Received: by 2002:a81:9196:0:b0:54f:b9bc:bd31 with SMTP id i144-20020a819196000000b0054fb9bcbd31mr1290370ywg.29.1682008291793;
        Thu, 20 Apr 2023 09:31:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g124-20020a0ddd82000000b0054fdb1dad0fsm422556ywe.43.2023.04.20.09.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 09:31:31 -0700 (PDT)
Date:   Thu, 20 Apr 2023 12:31:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 01/10] pack-write.c: plug a leak in
 stage_tmp_packfiles()
Message-ID: <ZEFo4iGFTg1UWpL0@nand.local>
References: <cover.1681764848.git.me@ttaylorr.com>
 <cover.1681850424.git.me@ttaylorr.com>
 <c477b754e7ddde0d6e696cfd4027ad88c18aeff3.1681850424.git.me@ttaylorr.com>
 <xmqqpm7z7crz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpm7z7crz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 19, 2023 at 03:00:48PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > The function `stage_tmp_packfiles()` generates a filename to use for
> > staging the contents of what will become the pack's ".mtimes" file.
> >
> > The name is generated in `write_mtimes_file()` and the result is
> > returned back to `stage_tmp_packfiles()` which uses it to rename the
> > temporary file into place via `rename_tmp_packfiles()`.
> >
> > `write_mtimes_file()` returns a `const char *`, indicating that callers
> > are not expected to free its result (similar to, e.g., `oid_to_hex()`).
> > But callers are expected to free its result, so this return type is
> > incorrect.
>
> Indeed the string that holds the name of the file returned by
> write_mtimes_file() is leaking.  Does the same logic apply to the
> returned filename from write_rev_file() and stored in rev_tmp_name
> that is not freed in stage_tmp_packfiles() in another topic?

They are similar, but unfortunately different.

Here, our temporary name is generated by `write_mtimes_file()` which
*always* comes up with a new name from scratch. So we know that it
should always be free()'d at the end of `stage_tmp_packfiles()`.

But in the case of `write_rev_file()`, it only *sometimes* generates a
new name from scratch. The first parameter can be NULL, in which case
`write_rev_file()` will generate a new name. Or it can be non-NULL, in
which case that name will be used instead.

So in that topic, it's less clear on what the ultimate right path
forward is. But in this topic, changing `mtimes_tmp_name` and the return
type of `write_mtimes_file()` to be a non-const `char *` (and free()ing
it, of course ;-)) is the right thing to do.

Thanks,
Taylor
