Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A807AC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FBDB60EC0
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhG2Tom (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 15:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhG2Tol (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 15:44:41 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA161C061765
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 12:44:36 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id f6so2771802ioc.6
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 12:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cWTIM9Yp/mx/8K2YUIqXrIbiXQG1TvlX6LLtVMiETiI=;
        b=vwXokPOkfOhS0UrfM6UWnJieM2OMTvjfI0WP2OENikespF/QflpgVtIQpQg4Eesg//
         ZUu6j6NMybJmuAVE8Pw4DBIU1q8uhFGK56sleDnrnR21IYwkr9dJrh2WKkYQ8ZKCOVb2
         WAsyfNE/ND1le7QxINoD5/Zv4y0IGMGg43xfMlSUUHdbKhTPYR+0pntFvHV/vJne+pKG
         ydOhjwGV90iwXo8ggZK9vpunGlwmYdoxvRJmg0htrnZ9f5u31KbMgtwKti4vAXvGksLK
         Q0gnrkvYi5FdUQYdjzWdJrWqNTvURQ801oYJH0bS9CUlAKDeJqRL6LcMLqgwTcLDiX4L
         PMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cWTIM9Yp/mx/8K2YUIqXrIbiXQG1TvlX6LLtVMiETiI=;
        b=ikOvgBb2EKzHHvCkFidVUjH6dlioBK9kdCnDoKfe55fP+yxYrcT+vtCyikfuGXzWXi
         jJFXusxGkFGnNHybLO85Nd9Vw79H3wv/5maDk+lTTBmJiYpIOY18b79+Gi+kBO1vKV4n
         kwbYrJ7a5AeY1k9UbYv/qqZUvau7q2+l+Yhve26WH8nZis817BX4YfhxvXwm0HvJC89P
         0u6h4sbukX0dG4WryAvghP3oLKuhff7pddE0EZH67Dx+S3y8G9nER7toBSZ+G7qnTJ9l
         sjzAGTekQN/SBjlAjRphYDflcFohQXnR1dGnQ9zBOKzojtv1a6E70CIH0BuT9iLChF+m
         EBZA==
X-Gm-Message-State: AOAM532j3HSOPWHkRNItInTirSuXjRsUlHegU/zYY0U5GX2zASmvZu+y
        xku7I6a4/rQaIuEhb5BHuwXHnw==
X-Google-Smtp-Source: ABdhPJxEC7xuEmUycFSVZe3med+vzbywx9sTcp4ShsL/IFomxWzo2xwDESaPaAmiztDGoXSfdbrW9Q==
X-Received: by 2002:a6b:ba02:: with SMTP id k2mr5438641iof.164.1627587876155;
        Thu, 29 Jul 2021 12:44:36 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:46df:20:8c6c:2d4b])
        by smtp.gmail.com with ESMTPSA id u13sm2835570iot.29.2021.07.29.12.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 12:44:35 -0700 (PDT)
Date:   Thu, 29 Jul 2021 15:44:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 08/24] midx: respect 'core.multiPackIndex' when writing
Message-ID: <YQMFIljXl7sAAA/L@nand.local>
References: <YPp98QgXW5PQHzyy@coredump.intra.peff.net>
 <YP8F9ttlMXwNZBam@nand.local>
 <YP8zsR+W8JeCWc1Q@nand.local>
 <YQBCjSmdOPfrnNnK@coredump.intra.peff.net>
 <YQBEIrRfcq5dhpZn@nand.local>
 <YQBFi70c1wfXdKQf@coredump.intra.peff.net>
 <YQBGvEQoZpw49Z7L@nand.local>
 <YQBIqO5j0VHXL6V7@coredump.intra.peff.net>
 <YQBnE+ft/MR3zs1t@nand.local>
 <YQGX7SMu4UoTJ2VK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQGX7SMu4UoTJ2VK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 28, 2021 at 01:46:21PM -0400, Jeff King wrote:
> On Tue, Jul 27, 2021 at 04:05:39PM -0400, Taylor Blau wrote:
>
> > > I actually think having write_midx_internal() open up a new midx is
> > > reasonable-ish. It's just that:
> > >
> > >   - it's weird when it stuffs duplicate packs into the
> > >     r->objects->packed_git list. But AFAICT that's not actually hurting
> > >     anything?
> >
> > It is hurting us when we try to write a MIDX bitmap, because we try to
> > see if one already exists. And to do that, we call prepare_bitmap_git(),
> > which tries to call open_pack_bitmap_1 on *each* pack in the packed_git
> > list. Critically, prepare_bitmap_git() errors out if it is called with a
> > bitmap_git that has a non-NULL `->pack` pointer.
>
> It doesn't error out. It does produce a warning(), though, if it ignores
> a bitmap (and that warning is doubly confusing because it is ignoring
> bitmap X because it has already loaded and will use that exact same X!).
>
> This causes t7700.13 to fail because it is being picky about stderr
> being empty.

Right, sorry for suggesting that the error was more severe than it
actually is.

> So the overall behavior is correct, but I agree it's sufficiently ugly
> that we should make sure it doesn't happen.

100% agreed. I think the most unfortunate thing is the state of
r->objects->packed_git, since it's utterly bizarre to have the same pack
opened twice and have both of those copies in the list. That is
definitely worth preventing.

>   Side note: IMHO the "check all packs to see if there are any other
>   bitmaps to warn about" behavior is kind of pointless, and we should
>   consider just returning as soon as we have one. This is already
>   somewhat the case after your midx-bitmap patches, as we will not even
>   bother to look for a pack bitmap after finding a midx bitmap. That is
>   a good thing, because it means you can keep pack bitmaps around for
>   flexibility. But let's leave any changes to the pack-only behavior out
>   of this series for simplicity.

I agree. I'd be in favor of something like

diff --git a/pack-bitmap.c b/pack-bitmap.c
index f599646e19..5450ffb04c 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -378,13 +378,6 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 		return -1;
 	}

-	if (bitmap_git->pack || bitmap_git->midx) {
-		/* ignore extra bitmap file; we can only handle one */
-		warning("ignoring extra bitmap file: %s", packfile->pack_name);
-		close(fd);
-		return -1;
-	}
-
 	bitmap_git->pack = packfile;
 	bitmap_git->map_size = xsize_t(st.st_size);
 	bitmap_git->map = xmmap(NULL, bitmap_git->map_size, PROT_READ, MAP_PRIVATE, fd, 0);
@@ -465,16 +458,15 @@ static int open_pack_bitmap(struct repository *r,
 			    struct bitmap_index *bitmap_git)
 {
 	struct packed_git *p;
-	int ret = -1;

 	assert(!bitmap_git->map);

 	for (p = get_all_packs(r); p; p = p->next) {
-		if (open_pack_bitmap_1(bitmap_git, p) == 0)
-			ret = 0;
+		if (!open_pack_bitmap_1(bitmap_git, p))
+			return 0;
 	}

-	return ret;
+	return -1;
 }

 static int open_midx_bitmap(struct repository *r,

...but agree that we should wait until after the dust has settled on
this already-complex series.

> >   - We should always be operating on the repository's
> >     r->objects->multi_pack_index, or any other MIDX that can be reached
> >     via walking the `->next` pointers. If we do that consistently, then
> >     we'll only have at most one instance of a MIDX struct corresponding
> >     to each MIDX file on disk.
>
> Certainly that makes sense to me in terms of the Windows "must close the
> current midx before writing" behavior. We have to realize that we're
> operating in the current repo.
>
> But we do allow an "--object-dir" option to "multi-pack-index write",
> and I don't see any other code explicitly requiring that it be part of
> the current repository. What I'm wondering is whether this would be
> breaking:
>
>   cd $REPO/..
>   git multi-pack-index --object-dir $REPO/.git/objects write
>
> or:
>
>   cd /some/other/repo
>   git multi-pack-index --object-dir $REPO/.git/objects write
>
> The latter does seem to work, but the former segfaults (usually -- if
> there's already a midx it is OK).

The former should work, but doesn't, because (as you pointed out to me
in our regular weekly discussion off-list) that the "multi-pack-index"
entry in git.c's commands array has the RUN_SETUP_GENTLY option, and
probably should have RUN_SETUP so that we complain with die() instead of
BUG.

And the latter will continue to work, but only if in your scenario that
$REPO is an alternate of /some/other/repo.

I wrote a little bit more in [1] about this behavior, but the upshot is
that we used to technically support passing *any* directory to
`--object-dir`, including directories that didn't belong to an
alternated repository.

And that will cease to work after the patch that [1] is in response to
is applied. But for the reasons that I explain there, I think that is a
sufficient outcome, because the behavior is kind of bizarre to begin
with.

[1]: https://lore.kernel.org/git/YQMB32fvSiH9julg@nand.local/

Thanks,
Taylor
