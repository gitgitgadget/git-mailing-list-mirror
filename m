Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE1AC77B7D
	for <git@archiver.kernel.org>; Mon, 15 May 2023 20:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245398AbjEOUiW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 16:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjEOUiV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 16:38:21 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1810173C
        for <git@vger.kernel.org>; Mon, 15 May 2023 13:38:19 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-56186035b61so1914307b3.3
        for <git@vger.kernel.org>; Mon, 15 May 2023 13:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684183099; x=1686775099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KjbTm2djDbRJo+VpjJ1iP97oMGd17fuJv0GnkghHiso=;
        b=VpXlP8hVKfkuigj3smPYkNyAakX6VJTYZtofM/lJlzcWFvCwGdpg7dZGn9XlZsN6Qq
         riGfqYhy0cfVLYkeYiVex4eyyL8nfOQtCGmEdxIKfjoymLx3Ec9qM9MvoeTjJE5UnClU
         nOkigWIIn3+VVuBeG2e1F+iaV10eVXt/nLbe/gKpLI3fIc4JfTcNgsu2rQw1pCCEx4er
         +P8kUsy1QqEqiyLlCQ2OoR9+QJ5NpY6ha557Reh46UqLBMJxClZbDKdx3HKnoimEq8dj
         xyvVL6L/a6klgRdiwOhU3XcXIG4eJmb21T5YdBrIKaCq3ANfb2KIKtwA+DMaDodSteM4
         BdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684183099; x=1686775099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjbTm2djDbRJo+VpjJ1iP97oMGd17fuJv0GnkghHiso=;
        b=kiZPIvxQRAbUQbeUOISd62khweXsAI8K4fvf+H1fqaBqYu4nlf6ORTrhY6Hni5ZF+m
         etaAnIvzMLUuM7BGg5CEcKl90/jvrxGv5isdfdqArYyroKLgFId2iUexneJKvES55hw6
         cPEaW6OlgYCETEJf1QQmA+yIrhiDWc+B1Z1iaCAv7QftdHlrZYVdWzKILXeMcrwWApSA
         XRI6wGDqyC5th+/ulUkCFOKrjSMBvyqQeKsdtea7AgV/+Fd2J7dbdAsaBFeBWUpKh02p
         39tZdkxbjgJLFmartD0QeSf3TPCdiTDK6KfGitMqMYoUBTvA32+31l5gcRqvrkpHPASX
         NIDA==
X-Gm-Message-State: AC+VfDxIT5aPiDLfaqn3MfTKW+3Q+yFoVoGwrJ+0WV6d6Zk2Fzlgzwl7
        6jVI+Y0wDQZLS87t7fxNFKKD9w==
X-Google-Smtp-Source: ACHHUZ5dIG0t82aAt5LG99fpcv4nYHNxL5a6VgOEJH7MdGYetPEhEoETn0gE/09RgIsW4cWa1LG8DQ==
X-Received: by 2002:a0d:ccc5:0:b0:55d:5c62:6be8 with SMTP id o188-20020a0dccc5000000b0055d5c626be8mr33260825ywd.21.1684183098799;
        Mon, 15 May 2023 13:38:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c127-20020a814e85000000b0055d892357ddsm67487ywb.57.2023.05.15.13.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 13:38:18 -0700 (PDT)
Date:   Mon, 15 May 2023 16:38:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] builtin/pack-objects.c: introduce
 `pack.recentObjectsHook`
Message-ID: <ZGKYOeMGs4fGO5bz@nand.local>
References: <cover.1683847221.git.me@ttaylorr.com>
 <2ce8a79fa4bf98947728da4e6e22304a2f203fac.1683847221.git.me@ttaylorr.com>
 <20230512212456.GA2495860@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230512212456.GA2495860@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2023 at 05:24:56PM -0400, Jeff King wrote:
> I think this description suffers a bit from being adapted from the
> original patch which was targeting cruft packs. It's not clear to me
> what "the caller" means here. And really, I think this is getting into
> the details before giving an overview and motivation.
>
> I'd expect something the rationale to be something like:

Re-reading it myself, I tend to agree with you. I modified it quite a
bit, and I'm much happier with the result. Thanks for mentioning it.

> One option I don't see here is: update the mtime on the objects you want
> to salvage.
>
> Why would we want this patch instead of just having the caller update
> the mtimes of objects (or in a cruft-pack world, call a command that
> rewrites the .mtimes file with new values)?
>
> I can think of some possible arguments against it (you might want to
> retain the old mtimes, or you might find it a hassle to have to
> continually update them before gc kills them). But I think the commit
> message should probably make those arguments.

I agree with everything you wrote here.

> > We then add those as tips to another reachability traversal (along with
> > any recent objects, if pruning), marking every object along the way
> > (either adding it to the cruft pack, or writing it out as a loose
> > object).
>
> I didn't understand this "if pruning" comment. If we are not pruning at
> all, wouldn't we skip the extra traversal entirely, since we know we are
> saving everything?

I was talking about the rescuing traversal for generating a cruft pack.
But I ended up dropping this whole paragraph anyway, since I don't think
it's adding anything in the context of the new patch message.

> > @@ -126,8 +198,14 @@ static int want_recent_object(struct recent_data *data,
> >  			      const struct object_id *oid)
> >  {
> >  	if (data->ignore_in_core_kept_packs &&
> > -	    has_object_kept_pack(oid, IN_CORE_KEEP_PACKS))
> > +	    has_object_kept_pack(oid, IN_CORE_KEEP_PACKS)) {
> > +		if (!data->extra_recent_oids_loaded)
> > +			load_pack_recent_objects(data);
> > +		if (oidset_contains(&data->extra_recent_oids, oid))
> > +			return 1;
> > +
> >  		return 0;
> > +	}
> >  	return 1;
> >  }
>
> This hunk I'm less sure about. The purpose of this function is that the
> caller has told us about some packs which are "special", and we avoid
> adding their objects to the traversal.
>
> This kicks in for cruft packs, when the git-repack caller says "I just
> made pack xyz.pack; do not bother saving anything in it to the cruft
> pack, since xyz.pack is here to stay". So if a hook says "you should
> keep object X", why would we want to override that check? It is already
> a reachable object that has been packed into xyz.pack, so we know there
> is no point in even considering its recency.

Yup, you're absolutely right here. Thanks for catching it.

> > --- a/t/t5329-pack-objects-cruft.sh
> > +++ b/t/t5329-pack-objects-cruft.sh
> > @@ -739,4 +739,175 @@ test_expect_success 'cruft objects are freshend via loose' '
> >  	)
> >  '
> >
> > +test_expect_success 'additional cruft tips may be specified via pack.extraCruftTips' '
>
> This title (and others below) seems out of date. :)

Thanks for noticing, fixed.

> > diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
> > index ebb267855f..d2eea6e754 100755
> > --- a/t/t7701-repack-unpack-unreachable.sh
> > +++ b/t/t7701-repack-unpack-unreachable.sh
> > @@ -113,6 +113,28 @@ test_expect_success 'do not bother loosening old objects' '
> >  	test_must_fail git cat-file -p $obj2
> >  '
> >
> > +test_expect_success 'extra recent tips are kept regardless of age' '
> > +	obj1=$(echo one | git hash-object -w --stdin) &&
> > +	obj2=$(echo two | git hash-object -w --stdin) &&
> > +	pack1=$(echo $obj1 | git pack-objects .git/objects/pack/pack) &&
> > +	pack2=$(echo $obj2 | git pack-objects .git/objects/pack/pack) &&
> > +	git prune-packed &&
> > +
> > +	git cat-file -p $obj1 &&
> > +	git cat-file -p $obj2 &&
> > +
> > +	write_script extra-tips <<-EOF &&
> > +	echo $obj2
> > +	EOF
> > +	git config pack.recentObjectsHook ./extra-tips &&
> > +
> > +	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.pack &&
> > +	git repack -A -d --unpack-unreachable=1.hour.ago &&
> > +
> > +	git cat-file -p $obj1 &&
> > +	git cat-file -p $obj2
> > +'
>
> And this is the new test in this iteration covering the "repack -A"
> case.
>
> It is checking that $obj2, which our hook mentions, is saved. It also
> checks that $obj1 is saved because it is still recent. But there are two
> other possibly interesting cases:
>
>   - an object that is too old and is _not_ saved. It seems useful to
>     confirm that the new patch does not simply break the ability to drop
>     objects. ;)
>
>   - an object that is reachable from $obj2 is also saved. From a
>     white-box perspective this is less interesting, because we should
>     already test elsewhere that this works for recent objects, and we
>     know the new feature is implemented by faking recency. But it might
>     be worth it for completeness, and because it's easy to do (making
>     $obj2 a tag pointing to a blob should work).

All very good cases to check for. Here's a patch on top (which I'll
obviously squash into my new version, but figured I'd send it as a
response to you directly, too):

--- 8< ---
S
diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index d2eea6e754..fa2df6016b 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -116,23 +116,33 @@ test_expect_success 'do not bother loosening old objects' '
 test_expect_success 'extra recent tips are kept regardless of age' '
 	obj1=$(echo one | git hash-object -w --stdin) &&
 	obj2=$(echo two | git hash-object -w --stdin) &&
+	obj3=$(echo three | git hash-object -w --stdin) &&
 	pack1=$(echo $obj1 | git pack-objects .git/objects/pack/pack) &&
 	pack2=$(echo $obj2 | git pack-objects .git/objects/pack/pack) &&
+	pack3=$(echo $obj3 | git pack-objects .git/objects/pack/pack) &&
 	git prune-packed &&

 	git cat-file -p $obj1 &&
 	git cat-file -p $obj2 &&
+	git cat-file -p $obj3 &&

-	write_script extra-tips <<-EOF &&
-	echo $obj2
+	git tag -a -m tag obj2-tag $obj2 &&
+	obj2_tag="$(git rev-parse obj2-tag)" &&
+
+
+	write_script precious-objects <<-EOF &&
+	echo $obj2_tag
 	EOF
-	git config pack.recentObjectsHook ./extra-tips &&
+	git config pack.recentObjectsHook ./precious-objects &&

 	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.pack &&
+	test-tool chmtime =-86400 .git/objects/pack/pack-$pack3.pack &&
 	git repack -A -d --unpack-unreachable=1.hour.ago &&

 	git cat-file -p $obj1 &&
-	git cat-file -p $obj2
+	git cat-file -p $obj2 &&
+	git cat-file -p $obj2_tag &&
+	test_must_fail git cat-file -p $obj3
 '

 test_expect_success 'keep packed objects found only in index' '
--- >8 ---

Thanks,
Taylor
