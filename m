Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8D0720248
	for <e@80x24.org>; Wed,  3 Apr 2019 09:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfDCJc5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 05:32:57 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44203 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDCJc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 05:32:57 -0400
Received: by mail-io1-f67.google.com with SMTP id u12so13460001iop.11
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 02:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gwmKXKuL997ZvbzZwVFWd1c8MiV6wUx2e0Pim6Pr+lY=;
        b=JdVKJFqcu0vhd1C9obCUqbtiYINVsUuDyIS9p1lcs1n3YpnRvEhddHe3GhHIm8U3Af
         9F0YbPfH1BgGFBLudyLg0vtgACboxDEGYGYmldcmVtJJ3OT7biUV5fBLNTBvfgjOommp
         lz3WZT7wuh9LD6S6bmH8abmgDD5M5GH+plyuv+6sYdqPn/UEdUPqyaJ8zo7T6CdetVpU
         BE3bhj7K/9SmxFkgO9K20WQMxNXNvSP9j7tzlHnPzWHwfiIRRAwWnV0OTUBqpzFhc6kt
         wI8cIxDZIoZ/pKqFNTuskFK41BF8HbwBnfT/DhlRYY1AYwBejmwVlhRjpWxQXctDJkdY
         L+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gwmKXKuL997ZvbzZwVFWd1c8MiV6wUx2e0Pim6Pr+lY=;
        b=C7pGbHesRAqxvPb/7brL/fBSl6TKu+s3QZUWyklzGrfR8cRTNvPnKex/DtR6ySz1Fb
         /0gYVfdZ3V04vuL6RiUPsmsvKR0DjJP7sG1uBI1sxciFwOIvl5VbLHGAPRqZSsZRQvLy
         pskeSZrObf7+G+RIXhYmdob7sNL3pvboZl9AHS1t2XNxfHs16E4T7NllJrs04mkiNDbw
         gp5UK+s5JPUmNBctRl1brEsIYI8F+wbtnxWt7sZjSuzLpkC9j00ka6Yz8Q8lsxoO9tXd
         I/VYzAGhFyU3jSpxk69dQNG38+RmomlswPsglk8u/mw+gOzAdFdODMhXIlpwkcyAlKt3
         1olQ==
X-Gm-Message-State: APjAAAU/pESMoCptJEuoLj/Z4LqjKESB59kvS3/i8hdAJ6OdqnhXRMoG
        EgH+L2+J+/PvxL9qjIOLujFCMkIfimjbF1WgZo4ukS47
X-Google-Smtp-Source: APXvYqzVpxpqXVOGsxFpqXh4BebsJt+WWpw4Lm/ynVe7Qhp4VxZr0IeOjGZVe27WjQrPj4RnHNgyN+Va9PTlmm7S7L0=
X-Received: by 2002:a5e:9805:: with SMTP id s5mr36113894ioj.149.1554283976223;
 Wed, 03 Apr 2019 02:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190402115625.21427-1-dak@gnu.org> <xmqqv9zvsfay.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqv9zvsfay.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 3 Apr 2019 16:32:30 +0700
Message-ID: <CACsJy8AbkmJ69ucCfGMdXHGvfko89SxH=DKjra6Ltwf7wpy-Og@mail.gmail.com>
Subject: Re: [PATCH] blame.c: don't drop origin blobs as eagerly
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Kastrup <dak@gnu.org>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 3, 2019 at 2:45 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> David Kastrup <dak@gnu.org> writes:
>
> > When a parent blob already has chunks queued up for blaming, dropping
> > the blob at the end of one blame step will cause it to get reloaded
> > right away, doubling the amount of I/O and unpacking when processing a
> > linear history.
> >
> > Keeping such parent blobs in memory seems like a reasonable optimization
> > that should incur additional memory pressure mostly when processing the
> > merges from old branches.
>
> Thanks for finding an age-old one that dates back to 7c3c7962
> ("blame: drop blob data after passing blame to the parent",
> 2007-12-11).
>
> Interestingly, the said commit claims:
>
>     When passing blame from a parent to its parent (i.e. the
>     grandparent), the blob data for the parent may need to be read
>     again, but it should be relatively cheap, thanks to delta-base
>     cache.
>
> but perhaps you found a case where the delta-base cache is not all
> that effective in the benchmark?

Interesting. For some reason I keep remembering the delta-base cache
is for caching base objects, not all packed objects.

That might explain why I could not see significant gain when blaming
linux.git's MAINTAINERS file (0.5s was shaved out of 13s) even though
the number of objects read was cut by half (8424 vs 15083).

I just tried again. The number of actual pack reading is slightly
reduced with the patch (498260 vs 502140). Not by a large margin. But
I imagine if the cache is under pressure (MAINTAINERS file is quite
small, 426k), we may get more eviction and misses from delta-base
cache.

It might still help when we need to read loose objects though. But I
guess this matters even less.

And I don't know how lazy clones behave in this case. If we get new
objects and store as loose, then it helps a bit more.

> Will queue.  Thanks.
>
>
>
>
> >
> > Signed-off-by: David Kastrup <dak@gnu.org>
> > ---
> >  blame.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/blame.c b/blame.c
> > index 5c07dec190..c11c516921 100644
> > --- a/blame.c
> > +++ b/blame.c
> > @@ -1562,7 +1562,8 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
> >       }
> >       for (i = 0; i < num_sg; i++) {
> >               if (sg_origin[i]) {
> > -                     drop_origin_blob(sg_origin[i]);
> > +                     if (!sg_origin[i]->suspects)
> > +                             drop_origin_blob(sg_origin[i]);
> >                       blame_origin_decref(sg_origin[i]);
> >               }
> >       }



-- 
Duy
