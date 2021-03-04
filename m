Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7063C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 22:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C4DF64FE3
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 22:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240031AbhCDV41 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 16:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbhCDV4D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 16:56:03 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925B9C061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 13:55:23 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id b130so17939045qkc.10
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 13:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p3TquEOqMnDhJRN4xCEtHzrALK9vkLRuhCyOezHWekU=;
        b=F8VvWc5fuNbn192gxmdu/pK5GM94cvJB1O2RUuUonotCWGqkJ5/N2ABBiwHaZ7rj7E
         LWUutnBTkijWksaJc3ANpCjLd7RQL9LtaTUtjTKnoW+F1/OQxwFbleRFIlS2S4K25QAk
         4TYZi/iqUU0/t/cuXyZEHb93H1SYGSjg00CfB7O9VIMjw/vZRqQa6oZ0l37tjWL9C1kJ
         eAG0zSAbd83H198TV0v1Gv/O/5Ud57Cjk/0aWCLfOVpOB7i+DwBph0zd5VmBc9kil91l
         9xaf5aAmrvagDWtHjfg4zRsbXebKfpzLe6L/Mgc2d1q2lhoyvgKpnscE7EcDgFn85LSu
         8i5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p3TquEOqMnDhJRN4xCEtHzrALK9vkLRuhCyOezHWekU=;
        b=NNJ5LVRhPuNNYo9lOLllYNs5pdN9HldbnM8aqOE79w+sZ2DP7EJcpfLAiuqFnV4cj1
         G3VXcpVIyW/n1s/BahwK7DCtT0eadnK8szxJmiagHwN7tvv2v+01ehRF7mswO98yFOTD
         RtTlzKsMUC4U2ToNiJpbcpQSAOamVwVA3D7jP4iTDi5K6W9nq3rX+qnZfzN0umoDrK0t
         VVuMzGQbKSYVkuoKJMJKIYRTh+1r+zRPqcQlzFyo0r/yBCstVcyInrkBCl/uHo+/ehF+
         Nu/PqE2phaufY3sGaxzDIOn3RXjzerioZis6GHWDw0MNYTQUd4GGCjrbO/qDJB4KYDB9
         9MDw==
X-Gm-Message-State: AOAM530vCWn61xZ9S78o9bZnCI39E7bQOiIFFwIrQQIUgggmGEGwI1Zt
        10fBOx+gu0pKEtWItdD1TAbw4Q==
X-Google-Smtp-Source: ABdhPJyjomleiMcKr1yL6d7fVQXgo+H8sjHnxbgIsmFZ0+XN2LG9wx2eo23TSfuf0/rR9JvQ6J9OIg==
X-Received: by 2002:a37:7985:: with SMTP id u127mr6128335qkc.333.1614894922495;
        Thu, 04 Mar 2021 13:55:22 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:4ce8:219:f731:dbf5])
        by smtp.gmail.com with ESMTPSA id a4sm572230qta.71.2021.03.04.13.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 13:55:22 -0800 (PST)
Date:   Thu, 4 Mar 2021 16:55:19 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH v4 8/8] builtin/repack.c: add '--geometric' option
Message-ID: <YEFXRwyMpyXHgArH@nand.local>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1614047097.git.me@ttaylorr.com>
 <51f57d5da23244ebde27ad6c14cbf4b63da3317d.1614047097.git.me@ttaylorr.com>
 <xmqqv9ahxddp.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv9ahxddp.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 24, 2021 at 03:19:30PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Concretely, say that a repository has 'n' packfiles, labeled P1, P2,
> > ..., up to Pn. Each packfile has an object count equal to 'objects(Pn)'.
> > With a geometric factor of 'r', it should be that:
> >
> >   objects(Pi) > r*objects(P(i-1))
> >
> > for all i in [1, n], where the packs are sorted by
> >
> >   objects(P1) <= objects(P2) <= ... <= objects(Pn).
> >
> > Since finding a true optimal repacking is NP-hard, we approximate it
> > along two directions:
> >
> >   1. We assume that there is a cutoff of packs _before starting the
> >      repack_ where everything to the right of that cut-off already forms
> >      a geometric progression (or no cutoff exists and everything must be
> >      repacked).
>
> When you order existing packs like how you explained the next
> "direction" below, do we assume loose ones would sit before
> (i.e. "newer and smaller" than) all of the packs?

Kind of. We don't consider them to be part of any pack when deciding
where to place the split (in other words, we don't consider them at
all until the subsequent repack by which time they are packed).

That's a fine assumption to make (as you note in the reply below this
one), since we'll eventually reach a geometric progression. This
approximation can be as wrong as there are loose objects (but hopefully
there aren't so many by the time we want to do a geometric repack).

> >   2. We assume that everything smaller than the cutoff count must be
> >      repacked. This forms our base assumption, but it can also cause
> >      even the "heavy" packs to get repacked, for e.g., if we have 6
> >      packs containing the following number of objects:
> >
> >        1, 1, 1, 2, 4, 32
> >
> >      then we would place the cutoff between '1, 1' and '1, 2, 4, 32',
> >      rolling up the first two packs into a pack with 2 objects. That
> >      breaks our progression and leaves us:
> >
> >        2, 1, 2, 4, 32
> >          ^
> >
> >      (where the '^' indicates the position of our split). To restore a
> >      progression, we move the split forward (towards larger packs)
> >      joining each pack into our new pack until a geometric progression
> >      is restored. Here, that looks like:
> >
> >        2, 1, 2, 4, 32  ~>  3, 2, 4, 32  ~>  5, 4, 32  ~> ... ~> 9, 32
> >          ^                   ^                ^                   ^
>
> This explanation is very intuitive and easy to understand (I assume
> we aren't actually repacking 1+1 into 2 and then 2+1 into 3 and then
> choosing to repack 3+2 to create 5, but we scan before doing any
> repacking and decide to repack 2+1+2+4 into a single 9).

Correct, and thanks. The split is determined ahead of time before we
actually get to writing any new packs.

> What is not so clear is how this picture changes depending on the
> value of 'r'.

It only means that subsequent packs need to contain at least 'r' times
as many objects as the previous pack does.

> > +static void split_pack_geometry(struct pack_geometry *geometry, int factor)
> > +{
> > +	uint32_t i;
> > +	uint32_t split;
> > +	off_t total_size = 0;
> > +
> > +	if (geometry->pack_nr <= 1) {
> > +		geometry->split = geometry->pack_nr;
> > +		return;
> > +	}
>
> When there is a single pack (or no pack), we place the split to 1
> (let's keep reading with the need to find out what split means in
> mind; it is not yet clear if it points at the pack that will be part
> of the kept set, or at the pack that is the last one among the
> repacked set, at this point in the code).

Everything that is strictly less than the split will get repacked, which
upon reading this again means that we'll repack a repository containing
just a single pack again. That's wasteful, so we may in the future want
to adjust this to set the split to 0 regardless of whether we have zero
or one pack here.

> > +	split = geometry->pack_nr - 1;
> > +
> > +	/*
> > +	 * First, count the number of packs (in descending order of size) which
> > +	 * already form a geometric progression.
> > +	 */
> > +	for (i = geometry->pack_nr - 1; i > 0; i--) {
> > +		struct packed_git *ours = geometry->pack[i];
> > +		struct packed_git *prev = geometry->pack[i - 1];
> > +		if (geometry_pack_weight(ours) >= factor * geometry_pack_weight(prev))
> > +			split--;
> > +		else
> > +			break;
> > +	}
>
> Instead of rolling up from smaller ones like explained in the log
> message, we scan from the larger end and see where the existing
> progression is broken.  When the loop breaks in the middle, the pack
> at position 'i-1' (prev) is too big.
>
> Why do we need to initialize 'split' before the loop and decrement
> it?  Wouldn't it be equivalent to assign 'i' after the loop breaks
> to 'split'?

Yep, they are equivalent.

> In any case, after the loop breaks, the packs starting at position
> 'i+1' (one after ours when the loop broke) thru to the end of the
> geometry->pack[] array are in good progression.  We have 'i' in
> 'split' at this point, so ...
>
> > +	if (split) {
> > +		/*
> > +		 * Move the split one to the right, since the top element in the
> > +		 * last-compared pair can't be in the progression. Only do this
> > +		 * when we split in the middle of the array (otherwise if we got
> > +		 * to the end, then the split is in the right place).
> > +		 */
> > +		split++;
> > +	}
>
> ... we increment it.  It means geometry->pack[split] is small enough
> relative to geometry->pack[split+1] and so on thru to the end of the
> array.
>
> What if split==0 when we exited the loop?  That would mean that the
> everything in the array was in good progression, which is in line
> with the "in the middle" case.  Either way, the pack at 'split' and
> later are in good progression.

Right (and ditto that we wouldn't do anything if split==0 in that case).

>  - we know many numbers are in uint32_t because that is how
>    packfiles limit their contents, but is it safe to perform the
>    multiplication with factor and comparison in that type?

We could arguably be more careful here, yes.

> > @@ -396,9 +525,19 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
> >  		strvec_pushf(&cmd.args, "--keep-pack=%s",
> >  			     keep_pack_list.items[i].string);
> >  	strvec_push(&cmd.args, "--non-empty");
> > -	strvec_push(&cmd.args, "--all");
> > -	strvec_push(&cmd.args, "--reflog");
> > -	strvec_push(&cmd.args, "--indexed-objects");
> > +	if (!geometry) {
> > +		/*
> > +		 * 'git pack-objects' will up all objects loose or packed
>
> "git pack-objects --stdin-packs" will?
> What verb is missing in "will VERB up all objects"?

Likely I meant to say "roll" here before "up".

> > +		 * (either rolling them up or leaving them alone), so don't pass
> > +		 * these options.
> > +		 *
> > +		 * The implementation of 'git pack-objects --stdin-packs'
> > +		 * makes them redundant (and the two are incompatible).
>
> I am not sure if that is true.
>
> More importantly, if you read this comment after you are done with
> the series and no longer feel that geometric repacking is the most
> important thing in the world, you'd realize that an important piece
> of information is missing to help readers.  It talks about what
> "geometric" code does (i.e. uses --stdin-packs hence no need to pass
> these options) in a block that is for !geometric.
>
> 	We need to grab all reachable objects, including those that
> 	are reachable from reflogs and the index.
>
> 	When repacking into a geometric progression of packs,
> 	however, we ask 'git pack-objects --stdin-packs', and it is
> 	not about packing objects based on reachability but about
> 	repacking all the objects in specified packs and loose ones
> 	(indeed, --stdin-packs is incompatible with these options).
>
> or something?  I suspect that --stdin-packs does not make --all and
> others "redundant".  The operation is about creating a new pack out
> of the objects contained in these packs, regardless of the objects'
> reachability from the usual "refs, index and reflogs" anchor points,
> no?

Exactly right. And I am certainly in favor of your wording above. Since
this series is already on next, I'd be happy to pick this up with the
few other minor things above in a separate series to apply on top (but
since I don't think any of these are correctness issues, you should feel
free to continue merging this down in the meantime).

> > @@ -507,6 +666,25 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
> >  			if (!string_list_has_string(&names, sha1))
> >  				remove_redundant_pack(packdir, item->string);
> >  		}
> > +
> > +		if (geometry) {
> > +			struct strbuf buf = STRBUF_INIT;
> > +
> > +			uint32_t i;
> > +			for (i = 0; i < geometry->split; i++) {
> > +				struct packed_git *p = geometry->pack[i];
> > +				if (string_list_has_string(&names,
> > +							   hash_to_hex(p->hash)))
> > +					continue;
> > +
> > +				strbuf_reset(&buf);
> > +				strbuf_addstr(&buf, pack_basename(p));
> > +				strbuf_strip_suffix(&buf, ".pack");
> > +
> > +				remove_redundant_pack(packdir, buf.buf);
> > +			}
> > +			strbuf_release(&buf);
> > +		}
>
> Before this new code, we seem to remove all pre-existing packfiles
> that are not in the output from the pack-objects already.  The only
> reason that code does not harm the geometry case is we assume
> get_non_kept_pack_filenames() call is never made while doing
> geometric repack (iow, ALL_INTO_ONE is not set) and the list of
> pre-existing packfiles &existing_packs is empty.  Am I reading the
> code correctly?
>
>  - It is a bit unnerving to learn (and it will be a maintenance
>    burden in the future) that a variable whose name is
>    existing_packs does not necessarily have a list of existing packs
>    depending on the mode we are operating in.
>
>  - The guard to make geometric incompatible with ALL_INTO_ONE does
>    not mention ALL_INTO_ONE, even though that bit is what would
>    corrupt the resulting repository if overlooked.  We should
>    probably need s/pack_everything/& \& ALL_INTO_ONE/ in the hunk
>     below.

Eek, yes. This is because the geometric code takes its own view of the
pack directory when figuring out where to place to split line, and so it
seemed easier to have separate paths.

I'm not sure whether I maintain that that was a good idea in hindsight
;). Certainly it does create a little bit of a maintenance burden for
us. But they really are two different things: the geometric code really
wants to have the packs laid out in order of object size, while the
"existing" string_list wants packs laid out in lexicographic order of
their filename to check whether certain packs exist or not.

> Other than that, it was a fun patch to read.

Thanks, I think the few suggestions you made here are good ones. I'll
put it on my to-do list of things to clean up in a separate little
series.

Since this is already in next, I would suggest continuing to merge it
down since none of these suggestions impact the patch's correctness.

Thanks,
Taylor
