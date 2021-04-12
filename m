Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61505C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13D0661350
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241052AbhDLVhR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237701AbhDLVhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:37:16 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD92C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:36:56 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r22so16806334edq.9
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1ww3ds4kM9JKLxhEckP7/hRjJeIbiuoEJOyyntzuB6c=;
        b=OMCm3W4iPibeFPbEqLfWN2GBX02snzhdMbHmHIDUnGBwcSlPJA9CGIuxy0LoBFSgny
         cMCe429flHT7Ixdxh8Axnejv8+WDDlCIX+3of9EAoimoQCCPl6hlt9F92LnVjMKbmtNG
         Zdoo7LRpWQcwsP5y8Z9olWIZbttKHNETfPgyFflRV0nq/tP+ymHiyao4G1LWP4t6uSrp
         ocnYqrnaYZu+enxF/s/KQcndoUr2ESgS84v5t0+TIPoKnO/pBPOaL0TAToVT2XDMRNCC
         Gtog1thUPyt/7sResFoCOI88+Y4OdGsxSLjMncGzlttYxlFWAr0ljB6vf2w8IMq77Met
         RreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1ww3ds4kM9JKLxhEckP7/hRjJeIbiuoEJOyyntzuB6c=;
        b=to+dcW46NTNSHKl2sqD9tfy3c4firf1t3795B2ZU4BD8y1PKSYS+jlqBEz7Ez+3At4
         s09hl5dZRZPK5SZSVEbN+5K0xgtAgu9NYtmJpwqukQojgDXgK1uQWvCl80qs/ToJPD38
         AoIoQFTBCd8JAWmRICdrjGp35Vd6W25Trf6STXV/jKwVpwi9ymDiZJn3G2C9Btx7BFrl
         91EMf07bkeiDLqEesrWrXfhaPuiNIh38Kt3jh8upJV+avXJVVwqPT4tusy+JNNoDt62H
         KxyMvnu59CR83yIqqYc4OOQns9JBiYY75vHfA59SE2dLJ5JqzS16MsV2WBEGSS9kHkbC
         d3zA==
X-Gm-Message-State: AOAM532Io8rHA3lFJBMEfCBo5zdBO4E5fWTzrLy/g53zwfLC7ldk0bBL
        tBGH8o2aEsHMIkhe2LgkL78=
X-Google-Smtp-Source: ABdhPJxaHJ46tWtO9SBUxj4ZOg8NLQWFZXwU6AN/vqkh9iZTgggoBPbDl28NmBeigRqefMaooscnyg==
X-Received: by 2002:a05:6402:51c6:: with SMTP id r6mr30639351edd.278.1618263415451;
        Mon, 12 Apr 2021 14:36:55 -0700 (PDT)
Received: from szeder.dev (94-21-23-40.pool.digikabel.hu. [94.21.23.40])
        by smtp.gmail.com with ESMTPSA id kt22sm2379470ejb.7.2021.04.12.14.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:36:55 -0700 (PDT)
Date:   Mon, 12 Apr 2021 23:36:53 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: rather slow 'git repack' in 'blob:none' partial clones
Message-ID: <20210412213653.GH2947267@szeder.dev>
References: <20210403090412.GH2271@szeder.dev>
 <gohp6ko8et3jdm.fsf@cpm12071.fritz.box>
 <YG4hfge2y/AmcklZ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YG4hfge2y/AmcklZ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 07, 2021 at 05:17:50PM -0400, Jeff King wrote:
> On Mon, Apr 05, 2021 at 03:02:33AM +0200, Rafael Silva wrote:
> 
> > When I was digging into the code and adding trace2_region_*() calls, I
> > notice most of the time spent on the `git gc` (for the reported
> > situation) was in:
> > 
> >        # In builtin/pack-objects.c
> >        static void get_object_list(int ac, const char **av)
> >        {
> >                ...
> >                if (unpack_unreachable)
> >                        loosen_unused_packed_objects();
> >                ...
> >        }
> 
> Yeah, good find.
> 
> This is my first time looking at the repacking strategy for partial
> clones. It looks like we run an initial pack-objects to cover all the
> promisor objects, and then do the "real" repack for everything else,
> with "--exclude-promisor-objects".
> 
> The purpose of loosen_unused_packed_objects() is to catch any objects
> that will be lost when our caller deletes all of the packs. But in this
> case, those promisor objects are in a pack which won't be deleted, so
> they should not be included.
> 
> > Another interesting thing is, the loosen_unused_packed_objects()
> > function is being called twice because the function loads all packs
> > files, via get_all_packs(), which will return the .temp-*pack file that
> > is created by the `git pack-objects` child process from `git gc`:
> > 
> >     git pack-objects ... --delta-base-offset objects/pack/.tmp-82853-pack ...
> 
> Yes, this is the "promisor" pack created by git-repack. It seems like
> git-repack should tell pack-objects about the new pack with --keep-pack,
> so that we know it is not going to be deleted.
> 
> That would also solve the rest of the problem, I _think_. In your
> suggestion here:
> 
> > I'm not entirely sure about this (not this late in the day), but it seems to
> > me that we should simply skip the "missing" (promisor) files when
> > operating on a partial clone.
> > 
> > Perhaps something like:
> > 
> > --- >8 ---
> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index 525c2d8552..fedf58323d 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -3468,6 +3468,8 @@ static int loosened_object_can_be_discarded(const struct object_id *oid,
> >  {
> >         if (!unpack_unreachable_expiration)
> >                 return 0;
> > +       if (exclude_promisor_objects && is_promisor_object(oid))
> > +               return 1;
> >         if (mtime > unpack_unreachable_expiration)
> >                 return 0;
> >         if (oid_array_lookup(&recent_objects, oid) >= 0)
> > --- >8 ---
> 
> you are avoiding writing out the file. But we should realize much
> earlier that it is not something we need to even consider loosening.
> 
> In the loop in loosen_unused_packed_objects(), we skip packs that are
> marked as "keep", so we'd skip the new promisor pack entirely. But we'd
> still see all these objects in the _old_ promisor pack. However, for
> each object there, we call has_sha1_pack_kept_or_nonlocal(), so that
> would likewise realize that each object is already being kept in the
> other pack.
> 
> Something like this seems to work, but I only lightly tested it, and it
> could probably use some refactoring to make it less horrible:
> 
> diff --git a/builtin/repack.c b/builtin/repack.c
> index fdee8e4578..457525953a 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -574,6 +574,23 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  		repack_promisor_objects(&po_args, &names);
>  
>  		if (existing_packs.nr && delete_redundant) {
> +			/*
> +			 * tell pack-objects about our new promisor pack, which
> +			 * we will also be keeping
> +			 */
> +			for_each_string_list_item(item, &names) {
> +				/*
> +				 * yuck, we seem to only have the name with the
> +				 * packdir prefixed
> +				 */
> +				const char *prefix;
> +				if (!skip_prefix(packtmp, packdir, &prefix) ||
> +				    *prefix++ != '/')
> +					BUG("confused by packtmp");
> +				strvec_pushf(&cmd.args, "--keep-pack=%s-%s.pack",
> +					     prefix, item->string);
> +			}
> +
>  			if (unpack_unreachable) {
>  				strvec_pushf(&cmd.args,
>  					     "--unpack-unreachable=%s",
> 

All what you wrote above makes sense to me, but I've never looked at
how partial clones work, so it doesn't mean anything...  In any case
your patch brings great speedups, but, unfortunately, the memory usage
remains as high as it was:

  $ /usr/bin/time --format=elapsed: %E  max RSS: %Mk /home/szeder/src/git/bin-wrappers/git -C git-partial.git/ gc
  Enumerating objects: 188450, done.
  Counting objects: 100% (188450/188450), done.
  Delta compression using up to 4 threads
  Compressing objects: 100% (66623/66623), done.
  Writing objects: 100% (188450/188450), done.
  Total 188450 (delta 120109), reused 188450 (delta 120109), pack-reused 0
  elapsed: 0:15.18  max RSS: 1888332k

And git.git is not all that large, I wonder how much memory would be
necessary to 'gc' a 'blob:none' clone of e.g. chromium?! :)

BTW, this high memory usage in a partial clone is not specific to
'repack', 'fsck' suffers just as much:

  $ /usr/bin/time --format=elapsed: %E  max RSS: %Mk git -C git-full.git/ fsck
  Checking object directories: 100% (256/256), done.
  warning in tag d6602ec5194c87b0fc87103ca4d67251c76f233a: missingTaggerEntry: invalid format - expected 'tagger' line
  Checking objects: 100% (305662/305662), done.
  Checking connectivity: 305662, done.
  Verifying commits in commit graph: 100% (65031/65031), done.
  elapsed: 0:33.99  max RSS: 281936k
  $ /usr/bin/time --format=elapsed: %E  max RSS: %Mk git -C git-partial.git/ fsck
  Checking object directories: 100% (256/256), done.
  warning in tag d6602ec5194c87b0fc87103ca4d67251c76f233a: missingTaggerEntry: invalid format - expected 'tagger' line
  Checking objects: 100% (188450/188450), done.
  Verifying commits in commit graph: 100% (65031/65031), done.
  elapsed: 0:29.96  max RSS: 1877340k


And a somewhat related issue: when the server doesn't support filters,
then 'git clone --filter=...' prints a warning and proceeds to clone
the full repo.  Reading ba95710a3b ({fetch,upload}-pack: support
filter in protocol v2, 2018-05-03) this seems to be intentional and I
tend to think that it makes sense (though I managed to overlook that
warning twice today...  I surely wouldn't have overlooked a hard
error, but that would perhaps be too harsh in this case, dunno).
However, the resulting full clone is still marked as partial:

  $ git clone --bare --filter=blob:none https://git.kernel.org/pub/scm/git/git.git git-not-really-partial.git
  Cloning into bare repository 'git-not-really-partial.git'...
  warning: filtering not recognized by server, ignoring
  remote: Enumerating objects: 591, done.
  remote: Counting objects: 100% (591/591), done.
  remote: Compressing objects: 100% (293/293), done.
  remote: Total 305662 (delta 372), reused 393 (delta 298), pack-reused 305071
  Receiving objects: 100% (305662/305662), 96.83 MiB | 2.10 MiB/s, done.
  Resolving deltas: 100% (228123/228123), done.
  $ ls -l git-not-really-partial.git/objects/pack/
  total 107568
  -r--r--r-- 1 szeder szeder   8559608 Apr 12 21:13 pack-53f3ee0dfeaa8cea65c78473cd5904bf5ddfaa20.idx
  -r--r--r-- 1 szeder szeder 101535430 Apr 12 21:13 pack-53f3ee0dfeaa8cea65c78473cd5904bf5ddfaa20.pack
  -rw------- 1 szeder szeder     49012 Apr 12 21:13 pack-53f3ee0dfeaa8cea65c78473cd5904bf5ddfaa20.promisor
  $ cat git-not-really-partial.git/config 
  [core]
  	repositoryformatversion = 1
  	filemode = true
  	bare = true
  [remote "origin"]
  	url = https://git.kernel.org/pub/scm/git/git.git
  	promisor = true
  	partialclonefilter = blob:none

I wonder whether this is intentional, or that it is really the desired
behavior, considering that 'gc/repack/fsck' still treat it as a
partial clone, and, consequently, are affected by this slowness and
much higher memory usage, and since the repo now contains a lot more
objects than expected (all the blobs as well), they are much slower:

  $ /usr/bin/time --format=elapsed: %E  max RSS: %Mk git -C git-not-really-partial.git/ gc
  Enumerating objects: 305662, done.
  Counting objects: 100% (305662/305662), done.
  Delta compression using up to 4 threads
  Compressing objects: 100% (75200/75200), done.
  Writing objects: 100% (305662/305662), done.
  Total 305662 (delta 228123), reused 305662 (delta 228123), pack-reused 0
  Removing duplicate objects: 100% (256/256), done.
  elapsed: 4:28.96  max RSS: 1985100k
  # with Peff's patch above:
  $ /usr/bin/time --format=elapsed: %E  max RSS: %Mk /home/szeder/src/git/bin-wrappers/git -C git-not-really-partial.git/ gc
  Enumerating objects: 305662, done.
  Counting objects: 100% (305662/305662), done.
  Delta compression using up to 4 threads
  Compressing objects: 100% (75200/75200), done.
  Writing objects: 100% (305662/305662), done.
  Total 305662 (delta 228123), reused 305662 (delta 228123), pack-reused 0
  elapsed: 1:21.83  max RSS: 1959740k

