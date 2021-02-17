Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45666C433E6
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F28566186A
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbhBQS7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 13:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhBQS7w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 13:59:52 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73918C061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 10:59:12 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id f17so13854682qkl.5
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 10:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wtk00yXwZPHmUDUjDyOFmloeMjNRDxDbnNtONsrVgqs=;
        b=PiVwGq2KZ2LCn5Y52/+S5NwIXN9rTunPLG/ELXoI7lYurhpJcE9E/b8BVMP0atACkt
         R8VigXKrGwOccpjtmgbCOuhbM48f2BqmDfDKmp7aNRkXojFxOE1ZOeRi7S2dMBX7+SwN
         H5b69N2D/3C8BEtfJ/G8qe75kuHsI+fcRYjk7rVqfPSEwAasVZwn90WDLZapTGvNsQ8H
         wYWmbqv86TgkPzdaseY87W4KaRc87+GkSmnpwRqvkFsJ/rpwJlNBId8zvGLLjRpuU2Bg
         ktoQodAR5QQ5Jw4JcWvD2jEn6lYzCyYBBX2ftcFdIFUH+J+DF082eQ/parjVAfvBQnda
         u+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wtk00yXwZPHmUDUjDyOFmloeMjNRDxDbnNtONsrVgqs=;
        b=Rx9xERRBpv78saWNXZrNJKiAOUvwe0CG1l4ewINJu6+jG8jb3DNh5oxj49XYrQ+wd5
         Mu8dqoj5cNN5Rx/VJTaDayUsIS2Hp7Epp+MjbZpRbDvxDleVXr+BYOiKlOfD/MAZBDES
         JgWmFi0aAn2PwgOk1W42gh+4mZou5yrS62fnhsVaTfEmGmmDMuvfWVxZViGl/VPYlaEh
         4BiecNqCp3xpVSYPcXMfGXx3lWP7OCHCwwZ8Z+9RqrdhA3VZeZSfhonHsm85aDeaZqPh
         +kzMRXPJ1DOCKOL5NA1qSbkDoOViribOvox2kZ69QsPLPg8RuFe6mST4r6vDtK1GeLaL
         8Qag==
X-Gm-Message-State: AOAM5330SFY/yHaEW5g9J4s/SXnf9UmqdJm4oxI7QhqJkKfYxSC3KSnY
        0vaM+Z4gsMW1uJ3DnViVuEqOXA==
X-Google-Smtp-Source: ABdhPJzQduIrRdgrzYHsigybA3HJgHJi794d0tfdm+q7x11AfiYUgLs65wEmWodQVrRZGV9l9OY69A==
X-Received: by 2002:a05:620a:88f:: with SMTP id b15mr604912qka.445.1613588351618;
        Wed, 17 Feb 2021 10:59:11 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:aeda:db8b:7233:8f54])
        by smtp.gmail.com with ESMTPSA id n5sm1796257qtd.5.2021.02.17.10.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 10:59:11 -0800 (PST)
Date:   Wed, 17 Feb 2021 13:59:08 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v2 3/8] builtin/pack-objects.c: add '--stdin-packs' option
Message-ID: <YC1nfH356wfmAKE2@nand.local>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
 <c96b1bf99582beefb96c3774b13a4f5a12fc61cc.1612411124.git.me@ttaylorr.com>
 <YCxZcz5JGtxObOF3@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCxZcz5JGtxObOF3@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 16, 2021 at 06:46:59PM -0500, Jeff King wrote:
> Do we use this partial traversal to impact the write order at all? That
> would be a nice-to-have, but I suspect that just concatenating the packs
> (presumably by descending mtime) ends up with a similar result.

We don't; the objects are written in pack order. In the version of the
patch you reviewed, the order of packs was determined by their hash (due
to the string_list_sort()), but the version I just prepared re-sorts by
mtime.

It's kind of gross, since we need to use QSORT directly on the
string_list internals in order to have access to the ->util field of the
string_list_items (string_list_sort() only lets you compare strings
directly for obvious reasons).

I added a comment describing this hack.

> > +--stdin-packs::
> > +	Read the basenames of packfiles from the standard input, instead
> > +	of object names or revision arguments. The resulting pack
> > +	contains all objects listed in the included packs (those not
> > +	beginning with `^`), excluding any objects listed in the
> > +	excluded packs (beginning with `^`).
> > ++
> > +Incompatible with `--revs`, or options that imply `--revs` (such as
> > +`--all`), with the exception of `--unpacked`, which is compatible.
>
> I know you say "basename" here, but I wonder if it is worth giving an
> example (`pack-1234abcd.pack`) to make it clear in what form we expect
> it. Or possibly something in the `EXAMPLES` section.

Good idea, thanks.

> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -2979,6 +2979,164 @@ static int git_pack_config(const char *k, const char *v, void *cb)
> >  	return git_default_config(k, v, cb);
> >  }
> >
> > +static int stdin_packs_found_nr;
> > +static int stdin_packs_hints_nr;
>
> I scratched my head at these until I looked further in the code. They're
> the counters for the trace output. Might be worth a brief comment above
> them. (I do approve of adding this kind of trace debugging info; I'm
> pretty accustomed to using gdb or adding one-off debug statements, but
> we really could do a better job in general of making these kinds of
> internals visible to mere mortal admins).

Good call.

> > +static int add_object_entry_from_pack(const struct object_id *oid,
> > +				      struct packed_git *p,
> > +				      uint32_t pos,
> > +				      void *_data)
> > +{
> > +	struct rev_info *revs = _data;
> > +	struct object_info oi = OBJECT_INFO_INIT;
> > +	off_t ofs;
> > +	enum object_type type;
> > +
> > +	display_progress(progress_state, ++nr_seen);
> > +
> > +	ofs = nth_packed_object_offset(p, pos);
> > +
> > +	oi.typep = &type;
> > +	if (packed_object_info(the_repository, p, ofs, &oi) < 0)
> > +		die(_("could not get type of object %s in pack %s"),
> > +		    oid_to_hex(oid), p->pack_name);
>
> Calling out for other reviewers: the oi.typep field will be filled in
> the with _real_ type of the object, even if it's a delta. This is as
> opposed to the return value of packed_object_info(), which may be
> OFS_DELTA or REF_DELTA.
>
> And that real type is what we want here:
>
> > +	else if (type == OBJ_COMMIT) {
> > +		/*
> > +		 * commits in included packs are used as starting points for the
> > +		 * subsequent revision walk
> > +		 */
> > +		add_pending_oid(revs, NULL, oid, 0);
> > +	}
>
> And later when we call create_object_entry().

:-). Yes indeed. As I'm sure that you will recall, the pack-objects
code _does not_ behave well when you give it the packed type of an
object (which is not entirely unexpected, since the pack-objects code
only operates on the true type, so passing the packed type--as I did
when originally writing this patch--is a bug).

> I wondered whether it would be worth adding other objects we might find,
> like trees, in order to increase our traversal. But that doesn't make
> any sense. The whole point is to find the paths, which come from
> traversing from the root trees. And we can only find the root trees by
> starting at commits. Adding any random tree we found would defeat the
> purpose (most of them are sub-trees and would give us a useless partial
> path).

Right.

> Should we avoid adding the commit as a tip for walking if it won't end
> up in the resulting pack? I.e., should we check these:
>
> > +	if (have_duplicate_entry(oid, 0))
> > +		return 0;
> > +
> > +	if (!want_object_in_pack(oid, 0, &p, &ofs))
> > +		return 0;
>
> ...first? I guess it probably doesn't matter too much since we'd
> truncate the traversal as soon as we saw it was in a kept pack anyway.

I agree it doesn't make a difference, but I think placing the extra
guards first makes it easier to read (since the reader doesn't have to
consider how the subsequent traversal would treat it).

> > +static void show_commit_pack_hint(struct commit *commit, void *_data)
> > +{
> > +}
>
> Nothing to do here, since commits don't have a name field. Makes sense.

Yeah. I added a comment to say the same thing, just for extra clarity.

>
> > +static void show_object_pack_hint(struct object *object, const char *name,
> > +				  void *_data)
> > +{
> > +	struct object_entry *oe = packlist_find(&to_pack, &object->oid);
> > +	if (!oe)
> > +		return;
> > +
> > +	/*
> > +	 * Our 'to_pack' list was constructed by iterating all objects packed in
> > +	 * included packs, and so doesn't have a non-zero hash field that you
> > +	 * would typically pick up during a reachability traversal.
> > +	 *
> > +	 * Make a best-effort attempt to fill in the ->hash and ->no_try_delta
> > +	 * here using a now in order to perhaps improve the delta selection
> > +	 * process.
> > +	 */
> > +	oe->hash = pack_name_hash(name);
> > +	oe->no_try_delta = name && no_try_delta(name);
> > +
> > +	stdin_packs_hints_nr++;
> > +}
>
> But for actual objects, we do fill in the hash. I wonder if it's
> possible for oe->hash to have been already filled. I don't think it
> really matters, though. Any value we get is equally valid, so
> overwriting is OK in that case.

Right.

> > +	trace2_data_intmax("pack-objects", the_repository, "stdin_packs_found",
> > +			   stdin_packs_found_nr);
>
> I wonder if it makes sense to report the actual set of packs via trace
> (obviously not as an int, but as a list). That's less helpful for
> debugging pack-objects, if you just fed it the input anyway, but if you
> were debugging "git repack --geometric" it might be useful to see which
> packs it thought were which (though arguably that would be a useful
> trace in builtin/repack.c instead).

I could see an argument in both ways. I'd rather pass for now until we
have a clearer need for it.

> [passing --unpacked to the namehash traversal]
>
> I'm OK to consider that an implementation detail for now, though. We can
> change it later without impacting the interface.

Agreed.

> > +		if (rev_list_unpacked)
> > +			add_unreachable_loose_objects();
>
> Despite the name, that function is adding both reachable and unreachable
> ones. So it is doing what you want. It might be worth renaming, but it's
> not too big a deal since it's local to this file.

Yeah, I tend to err on the side of "it's fine as-is" since this isn't
exposed outside of pack-objects internals. If you feel strongly I'm
happy to change it, but I suspect you don't.

Thanks,
Taylor
