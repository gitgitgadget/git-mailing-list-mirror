Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D656C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 23:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C4F6113B
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 23:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbhINXtb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 19:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhINXta (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 19:49:30 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A608CC061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 16:48:12 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id x2so905058ila.11
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 16:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tVtZOrmUMt/z5ALteZEDFy8qDJX7vK7JgaC1y+3SNNU=;
        b=OwmZC6tmYlZ6i67GzTgMVkas34YhM5A7YIF4eTn3tTAoI2xv2de03nz42plNYoze2I
         AitGmvBI+agxyOBvh67Dyu2k0teTWcMTCYLpNz1fqqrmfkpq2KXdwHi5vBSzz2+dDZ2B
         rzwvYpiOHZD2HpO52QiaIEVBRcmXpBeHmldc0qOtlWJR8zgcoPxof5NuqqJWfH5yifgZ
         Ub+r/I6z1LFrayFCXrh31i4c9IAho+z+mMqb3PXzOGsN1fmG6KHiG3R3jQf5UlDGhs1I
         0f1ffJHHZ96tkLOcnuvO1bjhKEvYrkgehBdUIbaaGIjADKCH2GIyjdVYS4hYdby9e3Xp
         UHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tVtZOrmUMt/z5ALteZEDFy8qDJX7vK7JgaC1y+3SNNU=;
        b=3ossgUgfwbFowgEOP/BfFtQgoGtaPGMf4d7qtMD+2i1MLNiQ9EgJJ5Ys0ylj5B8mSS
         OR5Cza3C0p/vljfKwe4l3oCO9Avv5IUeBS5wwUsExGeLQwnyYzKMDhJu6Iww6qQg8yDv
         ABe6Hj8nOW+jpH2eNnmHeGTDGI1H/A7QVXtqjvbmZrtkRjUbO5wSnAlWxk/8eomSR4qk
         SjtOW3XmeV5x0ANcbDQl/19syWE+XknPmRNGBHZMhkdVeEhVN3yEt0kR0qSm9ZpGspxj
         /Q5P54NWZFIUNiE+xQpxTS+KzFkIgzU6b2QEFgQxLAhTWCm7rLgU+ZvIU4h85cDPbvZp
         xK4g==
X-Gm-Message-State: AOAM533ym6plcfv5u8nLE/hiYYv6RuLkuWci4qTQu1CxZ1mm3v5IrpoH
        7EilN/gnxfYQfY/GQumGLHDD4g==
X-Google-Smtp-Source: ABdhPJxZ1BMeegD3ID6QpYaNxSzCl1gRHMueruqSh3GE1fmEYGFJh54qVFYbfH5ZmNjv03MINYnt5g==
X-Received: by 2002:a05:6e02:1ba3:: with SMTP id n3mr8155522ili.253.1631663292046;
        Tue, 14 Sep 2021 16:48:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 9sm7717948ily.9.2021.09.14.16.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 16:48:11 -0700 (PDT)
Date:   Tue, 14 Sep 2021 19:48:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/8] builtin/multi-pack-index.c: support --stdin-packs
 mode
Message-ID: <YUE0u+T/CL8D5WV/@nand.local>
References: <cover.1631331139.git.me@ttaylorr.com>
 <2a16f11790b79ab452233b6f28acac607c0abd28.1631331139.git.me@ttaylorr.com>
 <87ee9va0ie.fsf@evledraar.gmail.com>
 <YTzYYfBGqG87O5mN@nand.local>
 <YUDxzhAnzI5Anm6F@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUDxzhAnzI5Anm6F@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 03:02:38PM -0400, Jeff King wrote:
> On Sat, Sep 11, 2021 at 12:25:05PM -0400, Taylor Blau wrote:
>
> > > Before calling string_list_clear(). I.e. we didn't strdup(), but during
> > > free() we pretend that we did, because we did, just not in
> > > string_list_append().
> >
> > Good catch. It's kind of gross, but the result is:
> >
> > --- 8< ---
> >
> > diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> > index 77488b6b7b..e6cab975e3 100644
> > --- a/builtin/multi-pack-index.c
> > +++ b/builtin/multi-pack-index.c
> > @@ -64,7 +64,7 @@ static struct option *add_common_options(struct option *prev)
> >
> >  static void read_packs_from_stdin(struct string_list *to)
> >  {
> > -	struct strbuf buf = STRBUF_INIT;
> > +	struct strbuf buf = STRBUF_INIT_NODUP;
>
> Did you mean to use STRING_LIST_INIT_NODUP on the string-list
> declaration?

Yeah, and I thought that I even mentioned it in [1], but I apparently
sent the contents of my buffer before I saved it. So, I did notice it at
the time, but failed to tell anybody about it!

[1]: https://lore.kernel.org/git/YTzZPti%2FasQwZC%2FD@nand.local/

> >  	while (strbuf_getline(&buf, stdin) != EOF) {
> >  		string_list_append(to, strbuf_detach(&buf, NULL));
> >  	}
> > @@ -107,6 +107,11 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
> >  		ret = write_midx_file_only(opts.object_dir, &packs,
> >  					   opts.preferred_pack, opts.flags);
> >
> > +		/*
> > +		 * pretend strings are duplicated to free the memory allocated
> > +		 * by read_packs_from_stdin()
> > +		 */
> > +		packs.strdup_strings = 1;
> >  		string_list_clear(&packs, 0);
> >
> >  		return ret;
>
> I think the root of the problem here is the non-idiomatic use of
> strbuf_getline(). The usual thing (and in fact the thing done by the
> quite-similar code in read_packs_list_from_stdin() in pack-objects.c)
> is not to detach, because strbuf_getline() will reset the buffer each
> time. I.e.:
>
>   struct string_list to = STRING_LIST_INIT_DUP;
>   ...
>   struct strbuf buf = STRBUF
>   while (strbuf_getline(&buf, stdin) != EOF)
> 	string_list_append(to, &buf);

(Assuming that you meant `s/&buf/buf.buf/`, but otherwise this makes
sense). There is no need to call strbuf_reset() inside the body of the
loop, since strbuf_getline() calls it via strbuf_getwholeline().

>   strbuf_release(&buf);

...But we should still be careful to release the memory used by the
strbuf at the end (which is safe to do, since the whole point is that we
copy each buffer linewise into the string_list).

> That avoids any clever string-list allocation games. The number of heap
> allocations is about the same (one strbuf and N list items, versus N
> strbufs and 0 list items). There's a little extra copying (from the
> strbuf into the list items), but the strings themselves are more
> efficiently allocated (strbuf may over-allocate, and we lock in
> that choice forever by handing over the string).
>
> Not that efficiency probably matters either way for this spot. I'd do it
> this way because it's simple and idiomatic for our code base.

More than anything, I'm persuaded by that (though I was quite partial to
Eric's suggestion, which I found very clever).

Thanks,
Taylor
