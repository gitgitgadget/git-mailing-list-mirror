Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBBDCE7AB4
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 18:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjIYSBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 14:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjIYSB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 14:01:28 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533E99B
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 11:01:21 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-59f57ad6126so46105157b3.3
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 11:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1695664880; x=1696269680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PMEN5FLoyf/2CqGYlcdjQ+4UmXL5KfdtrfZ5IglHWo4=;
        b=YI8TDHDEmqc6CYV1XwR1+ZTt6H91zm/J6LV8ZVmRPuzPJ112BIW6pnn1WU5I3f9LXB
         6ajOaTRzaRPqeaKs3OVuVsVzCFQD4OqE+eusAJXyL3/tXKknOQd3IyToq8MBBR4aPAy8
         edzI8kfTkb0eiCbZAJQ+xwTVuxZi6MJR60Hm/1oURznIyaGxWQocQALTpLuOdNjDk5nO
         cB3V9nqvNJc8f9Bsjpgdwuq6GtbbVtolQBCFelmjBftGw/SSygHmdfqHaEj1g+qiwOzZ
         2Stc4fK5PFmuBXylG8eNTANC1jKNvPaVmMG9YRkeDbuhvSw2ocCJHJ4EOnFC89BcuGFw
         HHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695664880; x=1696269680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMEN5FLoyf/2CqGYlcdjQ+4UmXL5KfdtrfZ5IglHWo4=;
        b=cfT8jSBSLyd/SvCtN70Ore5uRrMmAt6VvKD/JXBqHlnt95hhjERQOXg+A4NoW/zmdW
         3FpBkLN/bpsoekSTGm+JEQj8le7L/2if+Ky2gj49uwIM4WPThUrHWaqOzHfbJCW1aSPF
         gF7W1Fqbn3nWFo2Px69/3u5bzJ73aEhzEb/1sqDKsbQVkazzq+X4GAJpikapl3NZYDWp
         eCSja3ltAcMTLMqZe+zP0TVQxUHLIJwdH1sA2S2mQp8CfIqb2AVVVI5fhHyxEFQTT+UI
         NnVCvyYV59rUf0S59sKzMxP/jv/b9C6H1BWB3E/Jhjd6e/ZMheXi0dFFCUwPL5PQ71cB
         +B1Q==
X-Gm-Message-State: AOJu0Yx2f0iFEJz+ztSYrydbQPfSVH3n744/e+9ncz2M/rvvAYG1jaiV
        dJokhh3DwcJ8ehHsdAHzWNnC3+G2JUn2UlwEIqs8NQ==
X-Google-Smtp-Source: AGHT+IFYZeVlnnw1Q6RTCy7i/tdF2Hf553p04D6zSh20o2fi2pSt6019U1/MQaUYYYEGq2NS2Fhx2g==
X-Received: by 2002:a05:690c:ecd:b0:59f:7f04:61b0 with SMTP id cs13-20020a05690c0ecd00b0059f7f0461b0mr4019191ywb.21.1695664880369;
        Mon, 25 Sep 2023 11:01:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bx6-20020a05690c080600b005928d602f44sm1354746ywb.31.2023.09.25.11.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:01:20 -0700 (PDT)
Date:   Mon, 25 Sep 2023 14:01:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 2/2] builtin/repack.c: implement support for
 `--cruft-max-size`
Message-ID: <ZRHK7+2Ta6U4CXuL@nand.local>
References: <cover.1694123506.git.me@ttaylorr.com>
 <7e4e42e1aacf2111f04a933c0725a8c81769f8d6.1694123506.git.me@ttaylorr.com>
 <xmqqtts5wnwn.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtts5wnwn.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 07, 2023 at 04:42:48PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > This all works, but can be costly from an I/O-perspective when a
> > repository has either (a) many unreachable objects, (b) prunes objects
> > relatively infrequently/never, or (c) both.
>
> I can certainly understand (a).  If we need to write a lot of
> objects into the craft pack, among which many of them are already in
> the previous generation of craft pack, we would be copying bits from
> the old to the new craft pack, and having to do so for many objects
> would involve expensive I/O.  But not (b).  Whether we prune objects
> infrequently or we do so very often, as long as the number and
> on-disk size of objects that has to go into craft packs are the
> same, wouldn't the cost of I/O pretty much the same?  IOW, (b) does
> not have much to do with how repacking is costly I/O wise, except
> that it is a contributing factor to make (a) worse, which is the
> real cause of the I/O cost.

Yeah, (b) on its own isn't enough to cost us a significant amount of I/O
overhead. (b) definitely exacerbates (a) if we are repacking relatively
frequently. I'll clarify in the patch notes.

> > This limits the I/O churn up to a quadratic function of the value
> > specified by the `--cruft-max-size` option, instead of behaving
> > quadratically in the number of total unreachable objects.
>
> ... I do not quite see how you would limit the I/O churn.

In the above (elided here for brevity) response, you are correct: the
idea is that once a cruft pack has grown to whatever threshold you set
via `--cruft-max-size`, it is effectively frozen, preventing you from
incurring the same I/O churn from it in the future.

> > When pruning unreachable objects, we bypass the new paths which combine
>
> "paths" here refers to...?  code paths, I guess?

Yep.

> > +gc.cruftMaxSize::
> > +	Limit the size of new cruft packs when repacking. When
> > +	specified in addition to `--cruft-max-size`, the command line
> > +	option takes priority. See the `--cruft-max-size` option of
> > +	linkgit:git-repack[1].
>
> Hmph.
>
> I am reasonably sure that I will mix the name up and call it
> gc.maxCruftSize in my configuration file and scratch my head
> wondering why it is not working.

I have no strong preference for either "gc.cruftMaxSize" or
"gc.maxCruftSize" (or anything else, really), so long as we are
consistent with the command-line option.

> > diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> > index 90806fd26a..8a90d684a7 100644
> > --- a/Documentation/git-gc.txt
> > +++ b/Documentation/git-gc.txt
> > @@ -59,6 +59,13 @@ be performed as well.
> >  	cruft pack instead of storing them as loose objects. `--cruft`
> >  	is on by default.
> >
> > +--cruft-max-size=<n>::
> > +	When packing unreachable objects into a cruft pack, limit the
> > +	size of new cruft packs to be at most `<n>`. Overrides any
> > +	value specified via the `gc.cruftMaxSize` configuration. See
> > +	the `--cruft-max-size` option of linkgit:git-repack[1] for
> > +	more.
>
> At least this side giving --max-cruft-size=<n> (which I think is a
> lot more natural word order) would cause parse-options to give an
> error, so it won't risk mistakes go silently unnoticed.

Yeah, that's compelling. I'm convinced ;-).

> > diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
> > index 4017157949..23fd203d79 100644
> > --- a/Documentation/git-repack.txt
> > +++ b/Documentation/git-repack.txt
> > @@ -74,6 +74,15 @@ to the new separate pack will be written.
> >  	immediately instead of waiting for the next `git gc` invocation.
> >  	Only useful with `--cruft -d`.
> >
> > +--cruft-max-size=<n>::
> > +	Repack cruft objects into packs as large as `<n>` before
> > +	creating new packs. As long as there are enough cruft packs
> > +	smaller than `<n>`, repacking will cause a new cruft pack to
> > +	be created containing objects from any combined cruft packs,
> > +	along with any new unreachable objects. Cruft packs larger
> > +	than `<n>` will not be modified. Only useful with `--cruft
> > +	-d`.
>
> Here, the missing fourth point I pointed out above is mentioned,
> which is good.
>
> Describe the unit for <n> (I am assuming that is counted in bytes,
> honoring the human-friendly suffix, like 100M).

Yep, thanks.

> There may be some "interesting" behaviour around the size boundary,
> no?  If you pack too many objects, your resulting size may slightly
> bust <n> and you will get a complaint, but by fixing that "bug", you
> will always stop short of filling the whole <n> bytes in the
> produced packfiles, and they will not be excempt from rewriting
> (becuase they are not "larger than <n>"), which defeats the point of
> this patch.

Yeah, the boundary conditions are definitely the most interesting part
of this patch IMHO. When packing with `--max-cruft-size`, we still do
cap the pack size of the resulting pack, so any excess spills over into
the next pack.

> Describe that <n> is a threshold that we stop soon after passing to
> explicitly allow us to go beyond it would solve the above problem, I
> would presume.

I am not sure I understand what you're getting at here.

> > diff --git a/builtin/gc.c b/builtin/gc.c
> > index 1f53b66c7b..b6640abd35 100644
> > --- a/builtin/gc.c
> > +++ b/builtin/gc.c
> > @@ -52,6 +52,7 @@ static const char * const builtin_gc_usage[] = {
> >  static int pack_refs = 1;
> >  static int prune_reflogs = 1;
> >  static int cruft_packs = 1;
> > +static char *cruft_max_size;
>
> I do not think this type is a good idea.

Yeah, I marked this as a string because we don't ourselves do anything
with it in 'gc', and instead just immediately pass it down to 'repack'.
We could parse it ourselves and catch any malformed arguments earlier,
though, which sounds worthwhile to me.

> > diff --git a/builtin/repack.c b/builtin/repack.c
> > index 44cb261371..56e7f5f43d 100644
> > --- a/builtin/repack.c
> > +++ b/builtin/repack.c
> > @@ -26,6 +26,9 @@
> >  #define LOOSEN_UNREACHABLE 2
> >  #define PACK_CRUFT 4
> >
> > +#define DELETE_PACK ((void*)(uintptr_t)1)
> > +#define RETAIN_PACK ((uintptr_t)(1<<1))
>
> Shouldn't these look more similar?  That is
>
> 	((void *)(uintptr_t)(1<<0))
> 	((void *)(uintptr_t)(1<<1))

Yeah, these have been shored up from some helpful review on the repack
internals cleanup series I posted earlier.

> > +		if (existing_cruft_nr >= existing->cruft_packs.nr)
> > +			BUG("too many cruft packs (found %"PRIuMAX", but knew "
> > +			    "of %"PRIuMAX")",
>
> Is that a BUG() that somehow miscounted the packs, or can it be a
> runtime error that may happen when a "git push" is pushing new
> objects into the repository, creating a new pack we did not know
> about?  Something like the latter should not be marked a BUG(), but

This would be the former. We load the set of packs at the beginning of a
repack operation from collect_pack_filenames() via a call to
get_all_packs(). So the set won't change between our view of it in
collect_pack_filenames() and collapse_small_cruft_packs(). IOW, we
should expect to see as many cruft packs as we saw in
collect_pack_filenames(), and any difference there would indeed be a
BUG().

> > +			    (uintmax_t)existing_cruft_nr + 1,
> > +			    (uintmax_t)existing->cruft_packs.nr);
> > +		existing_cruft[existing_cruft_nr++] = p;
> > +	}
> > +
> > +	QSORT(existing_cruft, existing_cruft_nr, existing_cruft_pack_cmp);
>
> We use the simplest "from smaller ones to larger ones, combine one
> by one together until the result gets large enough", which would not
> give us the best packing, but it is OK because it is not our goal to
> solve knapsack problem here, I presume?

Exactly. Whatever spill-over we generate (if any) will be the seed of
the next "generation" of cruft packs, which are allowed to grow and
accumulate until they themselves reach the size threshold, at which
point the process starts itself over again.

> > +	for (i = 0; i < existing_cruft_nr; i++) {
> > +		off_t proposed;
> > +
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
> > +	}
>
> This is exactly what I talked about the possibly funny behaviour
> around the boundary earlier, but it may be even worse.  This time,
> we may decide that a pack with size <n-epsilon> is to be retained,
> only because the pack that came next in the existing list happened
> to be larger than epsilon, but next time around, it may not be the
> case (i.e. our pack may be smaller than epsilon, the next one in the
> current round may be larger than epsilon, but before we repack the
> next time, a new pack that is slightly smaller than epsilon that is
> larger than our pack may have been created---now our pack will be
> combined with it), so the algorithm to choose which ones are kept
> does not depend on the pack itself alone but also depends on its
> surroundings.

If I understand your comment correctly, that behavior is as-designed. We
try to grow cruft packs by combining other cruft packs that are not yet
frozen, and I think that is going to be dependent on the entire set of
packs rather than the characteristic of any one pack.

An alternative approach might be to combine *all* cruft packs smaller
than some threshold, and let any spill-over get handled by pack-objects
with its --max-pack-size option. I do not have a strong preference
between the two.

Thanks,
Taylor
