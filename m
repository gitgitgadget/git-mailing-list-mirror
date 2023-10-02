Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C7CE77361
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 20:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbjJBUbF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 16:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236028AbjJBUbD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 16:31:03 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBDBBF
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 13:31:00 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77428510fe7so11713785a.1
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 13:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696278660; x=1696883460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PwY1+oCI6IWc/fIuO15XPVkxqbgzRneGTAIGlZMYZcA=;
        b=uYC6sGV7amrKYGz2+d20/xBmRVQ7JY1iVM/TCKNBZLO4ZESb1C0NtVZFBbsm86Pzxj
         YHQxHL6NJbsHV9Y8/TwOYMpy/+5g/5gz1MGciJwCkT9pqpwHnoJso6KIrKzP9i6LcGoc
         G75Ph8u06GKY6tVBeEhTbhFhkShlhm+MSSQy9A7SCAU9r3o63sCswtUUn2Gih91IbYkB
         LzBvdjbUjFkE4ZgqpZfijUcRV8o4gS8/ImhGHPnBe9uSFGeLer3+RFlUiyEiZlxZmzRB
         d+v4+zQ0bquwUcdbfqboJHFKrz6OXNQxs5Kdbc7LzmcysX7J3K8EQJe1i1/FfqKJea5z
         u7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696278660; x=1696883460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwY1+oCI6IWc/fIuO15XPVkxqbgzRneGTAIGlZMYZcA=;
        b=c72IK7okFYl3yn6avMLmo+aktFHIDb73s1TZdheudT2Ue3BzRJywXq61XkU0YfzgI1
         9Zum7TnJsG1DjTXGtHJ8hvb5cTlL4+M89MxgAbJKwiSDyUyHSpriu6R7K0pEcfcQiomF
         6jo6L1hxc3QPUcv2o7DJSCjrg/W0n7eraplO1lttyB6qFl6hY9CwjJtjWZPCaWyCphr0
         FunOZrOoNhGJRDTWt02LI28If6z6Hi5Glsjnhqtg046z48vg7LmdypjAZ42DA5GvZLce
         6x/+AfXLpt2cl3JmYMMHWOcofxD+yPl5BdonLVO1mpKn8i3fjy1+oPho/tioICDXdKgC
         5EUw==
X-Gm-Message-State: AOJu0YwyZxh0bzS9j2ilLgdXm+BYM+ngnuPKBYHJWSNjMjiifFTV+6J/
        ZQ1WsxBsAZ4YkgXP/oRdP0AYFQ==
X-Google-Smtp-Source: AGHT+IHNwCBa9ngOOgz1KXLIXZXPJ5+4roRQ53Ts1pRinjquOPe433EnSo3O1MR9knv8DeyJ4ukj/Q==
X-Received: by 2002:a05:620a:29c3:b0:775:9bb1:9b5d with SMTP id s3-20020a05620a29c300b007759bb19b5dmr925835qkp.26.1696278659833;
        Mon, 02 Oct 2023 13:30:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y17-20020ac87091000000b00419732075b4sm3064247qto.84.2023.10.02.13.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 13:30:59 -0700 (PDT)
Date:   Mon, 2 Oct 2023 16:30:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 2/2] builtin/repack.c: implement support for
 `--cruft-max-size`
Message-ID: <ZRsogqtbd6klqypL@nand.local>
References: <cover.1694123506.git.me@ttaylorr.com>
 <7e4e42e1aacf2111f04a933c0725a8c81769f8d6.1694123506.git.me@ttaylorr.com>
 <ZPsDyKOa76Mxb9u-@tanuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZPsDyKOa76Mxb9u-@tanuki>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 08, 2023 at 01:21:44PM +0200, Patrick Steinhardt wrote:
> On Thu, Sep 07, 2023 at 05:52:04PM -0400, Taylor Blau wrote:
> [snip]
> > @@ -125,17 +133,39 @@ static void mark_packs_for_deletion_1(struct string_list *names,
> >  		if (len < hexsz)
> >  			continue;
> >  		sha1 = item->string + len - hexsz;
> > -		/*
> > -		 * Mark this pack for deletion, which ensures that this
> > -		 * pack won't be included in a MIDX (if `--write-midx`
> > -		 * was given) and that we will actually delete this pack
> > -		 * (if `-d` was given).
> > -		 */
> > -		if (!string_list_has_string(names, sha1))
> > -			item->util = (void*)1;
> > +
> > +		if (pack_is_retained(item)) {
> > +			item->util = NULL;
> > +		} else if (!string_list_has_string(names, sha1)) {
> > +			/*
> > +			 * Mark this pack for deletion, which ensures
> > +			 * that this pack won't be included in a MIDX
> > +			 * (if `--write-midx` was given) and that we
> > +			 * will actually delete this pack (if `-d` was
> > +			 * given).
> > +			 */
> > +			item->util = DELETE_PACK;
> > +		}
>
> I find the behaviour of this function a tad surprising as it doesn't
> only mark a pack for deletion, but it also marks a pack as not being
> retained anymore. Shouldn't we rather:
>
>     if (pack_is_retained(item)) {
>         // Theoretically speaking we shouldn't even do this bit here as
>         // we _un_mark the pack for deletion. But at least we shouldn't
>         // be removing the `RETAIN_PACK` bit, I'd think.
>         item->util &= ~DELETE_PACK;
>     } else if (!string_list_has_string(names, sha1)) {
>         // And here we shouldn't discard the `RETAIN_PACK` bit either.
>         item->util |= DELETE_PACK;
>     }

I think the new version should address these issues. But yeah, I
definitely understand your confusion here. I think what's written in
this patch is OK, because we check only whether the `->util` field is
non-NULL before deleting, which is why we have to remove the RETAINED
bit.

But the new version looks like this instead:

    if (pack_is_retained(item))
        pack_unmark_for_deletion(item);
    else if (!string_list_has_string(names, sha1))
        pack_mark_for_deletion(item);

the RETAINED bits still stick around (pack_unmark_for_deletion() just
does `item->util &= ~DELETE_PACK`), but we don't consult them after
mark_packs_for_deletion_1() has finished executing. Instead we just
check for the existence of the DELETE_PACK bit, rather than whether or
not the whole util field is NULL.

> > @@ -799,6 +831,72 @@ static void remove_redundant_bitmaps(struct string_list *include,
> >  	strbuf_release(&path);
> >  }
> >
> > +static int existing_cruft_pack_cmp(const void *va, const void *vb)
> > +{
> > +	struct packed_git *a = *(struct packed_git **)va;
> > +	struct packed_git *b = *(struct packed_git **)vb;
> > +
> > +	if (a->pack_size < b->pack_size)
> > +		return -1;
> > +	if (a->pack_size > b->pack_size)
> > +		return 1;
> > +	return 0;
> > +}
> > +
> > +static void collapse_small_cruft_packs(FILE *in, unsigned long max_size,
>
> We might want to use `size_t` to denote file sizes instead of `unsigned
> long`.

We can safely change these to use size_t, but let's leave OPT_MAGNITUDE
alone (and treat that portion as #leftoverbits).

> > +		p = existing_cruft[i];
> > +		proposed = st_add(total_size, p->pack_size);
> > +
> > +		if (proposed <= max_size) {
> > +			total_size = proposed;
> > +			fprintf(in, "-%s\n", pack_basename(p));
> > +		} else {
> > +			retain_cruft_pack(existing, p);
> > +			fprintf(in, "%s\n", pack_basename(p));
> > +		}
>
> It's a bit funny that we re-check whether we have exceeded the maximum
> size in subsequente iterations once we hit the limit, but it arguably
> makes the logic a bit simpler.

Yeah. Those checks are all noops (IOW, once we end up in the else
branch, we'll stay there for the rest of the loop). But we don't want to
break early, because we have to call retain_cruft_pack() on everything.
In theory you could do something like:

    for (i = 0; i < existing_cruft_nr; i++) {
        size_t proposed;
        p = existing_cruft[i];
        proposed = st_add(total_size, p->pack_size);

        if (proposed <= max_size) {
            total_size = proposed;
            fprintf(in, "-%s\n", pack_basename(p));
        } else {
            break;
        }
    }

    for (; i < existing_cruft_nr; i++) {
        retain_cruft_pack(existing, existing_cruft[i]);
        fprintf(in, "%s\n", pack_basename(existing_cruft[i]));
    }

But I think that the above is slightly more error-prone than what is
written in the original patch. I have only the vaguest of preferences
towards the former, but I'm happy to change it around if you feel
strongly.

> If I understand correctly, we only collapse small cruft packs in case
> we're not expiring any objects at the same time. Is there an inherent
> reason why? I would imagine that it can indeed be useful to expire
> objects contained in cruft packs and then have git-repack(1) recombine
> whatever is left into larger packs.
>
> If the reason is basically "it's complicated" then that is fine with me,
> we can still implement the functionality at a later point in time. But
> until then I think that we should let callers know that the two options
> are incompatible with each other by producing an error when both are
> passed.

Your understanding is correct. We could try to leave existing cruft
packs alone when none of their objects are removed as a result of
pruning, but that case should be relatively rare. Another thing you
could do is handle cruft packs which have only part of their objects
being pruned by combining the non-pruned parts into a new pack.

The latter should be mostly straightforward to implement, but since
we're often ending up with very few cruft objects post-pruning, it
likely wouldn't help much.

Thanks,
Taylor
