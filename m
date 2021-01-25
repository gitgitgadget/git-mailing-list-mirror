Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E557BC433E9
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC2F22B3F
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbhAYR4D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 12:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731301AbhAYRzK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:55:10 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8371FC061A28
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:44:58 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id u20so4685585qku.7
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/V1kGVbRnPI+UMPUs053RM1+N3T40LN8b1CLJxPkpss=;
        b=uaVrcA2v5/+mUTMhBy7M3Kn7hyTPcdZJoo0iujccutr7OkbyUdL3tlrYUwjZd/lrea
         Jw0lBXvIUMg/o/qpViV0aPzpea0Xli7adDro0eucP5/JppCM6iWDQOyb0lxQ+ocWUb5D
         plkylOUSCxVg9MiQBsT60czPnwd2xOGTbEO7LdilMIIJ0AhUzsZh+l+teStS2ef3auSa
         exCRelg/ujAiOP2c5KTNf86x+p2uvz/o8r6K1WWT1uZ0oYitQ8TM1jpm+hLm+t120iNW
         ru9Y3NUR2avI4ivvExemL6CjjqG5sbPg0nwTK3txzMdfqrzUVE5RKQKCrQ+p5Ke3thKj
         OsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/V1kGVbRnPI+UMPUs053RM1+N3T40LN8b1CLJxPkpss=;
        b=CuyGr5wULJn7ZkijgK69tEU+T07jpbr/0XDrOnMM1RT5qqEbyup4kNBp+kcuGZdv/A
         Plw/JyTGkLpuEzZswei9N7qQSKg0GWIwXi7/Oas7vrSDufL674OAafP8uHc4PrXiqQyf
         zh/jpxf8yt0hqbBN3SpXWr2TnVXLEfn7tqgvUFbi3ZZFK3Rmft3PqVvbkfND8QWz9Nrd
         ae9cMWEfxMJq6TDHves0z6D4LW0YszU8hMV6wsUJEywgdpJZaUBGImcv3mpqbZuitBnZ
         lyNFQi5pqMdVTrbalwq6aJFA1X8JycboaWYKaYJaFmjRvzmqeN77V8WSsSuNDTvf1mIs
         i9AA==
X-Gm-Message-State: AOAM5301t8Y/03gnpaD9NO+Ed84SQfA5BWmhNVO3b4oxQFrU2hfRZdVU
        rvu1+HzOxQc4JLdZc0bviqU7+A==
X-Google-Smtp-Source: ABdhPJy03ASccbsAZ7JivZEazoed1OYGxdjTKUEBbyW4YKWmUQqSo71/Ot1SpuVNJwbbvkFmu4j7Sw==
X-Received: by 2002:a05:620a:2227:: with SMTP id n7mr1808050qkh.153.1611596697662;
        Mon, 25 Jan 2021 09:44:57 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5e9f:a2e5:e7ac:394d])
        by smtp.gmail.com with ESMTPSA id z26sm12351927qki.40.2021.01.25.09.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:44:56 -0800 (PST)
Date:   Mon, 25 Jan 2021 12:44:53 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v2 1/8] packfile: prepare for the existence of '*.rev'
 files
Message-ID: <YA8DlQwSzNZXq+AU@nand.local>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1610576805.git.me@ttaylorr.com>
 <6742c15c84bafbcc1c06e2633de51dcda63e3314.1610576805.git.me@ttaylorr.com>
 <YAtXmie2kHNrcBwY@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAtXmie2kHNrcBwY@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 22, 2021 at 05:54:18PM -0500, Jeff King wrote:
> All of which is a really verbose way of saying: you might want to add a
> few words after the comma:
>
>   In real-world usage, Git is often performing many operations in the
>   revindex (i.e., rather than asking about a single object, we'd
>   generally ask about a range of history).
>
> :) But hopefully it shows that including the offsets is not really
> making things better for the cold cache anyway.

Thanks for including a compelling argument in favor of the approach that
I took in this patch.

I added something along the lines of what you suggested to the final
paragraph, so now it concludes nicely instead of ending in a comma. I
briefly considered whether I should add something about how these
operations scale and how the warming efforts are really amortized across
all of the objects, but I decided against it.

I think that this argument is already documented here, and that there's
no way to concisely state it in an already long patch. Interested
readers will easily be able to find our discussion here, which is good.

> >  Documentation/technical/pack-format.txt |  17 ++++
> >  builtin/repack.c                        |   1 +
> >  object-store.h                          |   3 +
> >  pack-revindex.c                         | 112 +++++++++++++++++++++---
> >  pack-revindex.h                         |   7 +-
> >  packfile.c                              |  13 ++-
> >  packfile.h                              |   1 +
> >  tmp-objdir.c                            |   4 +-
> >  8 files changed, 145 insertions(+), 13 deletions(-)
>
> Oh, there's a patch here, too. :)

:-).

> It mostly looks good to me. I agree with Junio that "compute" is a
> better verb than "load" for generating the in-memory revindex.

Yeah, I settled on load_pack_revindex() either calling
"create_pack_revindex_in_memory()" or "load_pack_revindex_from_disk()".

> > +static int load_pack_revindex_from_disk(struct packed_git *p)
> > +{
> > +	char *revindex_name;
> > +	int ret;
> > +	if (open_pack_index(p))
> > +		return -1;
> > +
> > +	revindex_name = pack_revindex_filename(p);
> > +
> > +	ret = load_revindex_from_disk(revindex_name,
> > +				      p->num_objects,
> > +				      &p->revindex_map,
> > +				      &p->revindex_size);
> > +	if (ret)
> > +		goto cleanup;
> > +
> > +	p->revindex_data = (char *)p->revindex_map + 12;
>
> Junio mentioned once spot where we lose constness through a cast. This
> is another. I wonder if revindex_map should just be a "char *" to make
> pointer arithmetic easier without having to cast.
>
> But also...
>
> > +	if (p->revindex)
> > +		return p->revindex[pos].nr;
> > +	else
> > +		return get_be32((char *)p->revindex_data + (pos * sizeof(uint32_t)));
>
> If p->revindex_data were "const uint32_t *", then this line would just
> be:
>
>   return get_be32(p->revindex_data + pos);
>
> Not a huge deal either way since the whole point is to abstract this
> behind a function where it only has to be written once. I don't think
> there is any downside from the compiler's view (and we already use this
> trick for the bitmap name-hash cache).

Honestly, I'm not a huge fan of implicitly scaling pos by
sizeof(*p->revindex_data), but I can understand why it reads more
clearly here. I don't really feel strongly either way, so I'm happy to
change it in favor of your suggestion.

Of course, since RIDX_HEADER_SIZE is in bytes, not uint32_t's (and it
has to be, since it's also used in the RIDX_MIN_SIZE macro, which is
compared against the st_size of stating the .rev file), you have to do
gross stuff like:

  p->revindex_data = (const uint32_t *)((const char *)p->revindex_map + RIDX_HEADER_SIZE);

But I guess the tradeoff is worth it, since the readers are easier to
parse.

> Thinking out loud a bit: a .rev file means we're spending an extra map
> per pack (but not a descriptor, since we close after mmap). And like the
> .idx files (but unlike .pack file maps), we don't keep track of these
> and try to close them when under memory pressure. I think that's
> probably OK in terms of bytes. It may mean running up against operating
> system number-of-mmap limits more quickly when you have a very large
> number of packs, as mentioned in:
>
>   https://lore.kernel.org/git/20200601044511.GA2529317@coredump.intra.peff.net/
>
> But this is probably bumping the number of problematic packs from 30k to
> 20k. Both are sufficiently ridiculous that I don't think it matters in
> practice.

Agreed.

> > diff --git a/tmp-objdir.c b/tmp-objdir.c
> > index 42ed4db5d3..da414df14f 100644
> > --- a/tmp-objdir.c
> > +++ b/tmp-objdir.c
> > @@ -187,7 +187,9 @@ static int pack_copy_priority(const char *name)
> >  		return 2;
> >  	if (ends_with(name, ".idx"))
> >  		return 3;
> > -	return 4;
> > +	if (ends_with(name, ".rev"))
> > +		return 4;
> > +	return 5;
> >  }
>
> Probably not super important, but: should the .idx file still come last
> here? Simultaneous readers won't start using the pack until the .idx
> file is present. We'd probably prefer they see the whole thing
> atomically, than see a .idx missing its .rev (they won't ever produce a
> wrong answer, but they'll generate the in-core revindex on the fly when
> they don't need to).
>
> I guess one could argue that .bitmap files should get similar treatment,
> but we'd not generally see those in the quarantine objdir anyway, so
> nobody ever gave it much thought.

Yeah, you're right (.idx files should come last, and probably an
argument to include .bitmap files here, too, exists. I'll leave the
latter as #leftoverbits).

> -Peff

Thanks,
Taylor
