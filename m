Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BA9EB64D9
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 00:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjFPAnb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 20:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjFPAna (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 20:43:30 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB532943
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 17:43:28 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-666a228d244so251852b3a.1
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 17:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686876208; x=1689468208;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J17EhZbY5wWzCCc+lnSv/0GJ+YXs/j8FK+7ilGj63xM=;
        b=CS7RhdYN8Lcw2tVEly6I+ka4Klp/Q7JIBxKemfSdewT/qDiHNIMv8JNI4xynTR5KS5
         Y7kWgTh77nLMTIOulatKamBZEfKYO9RSw4xA4K33zRZA4HR1GH99KVlxEJvN8EyJg+Bp
         7CdCciFUFI0RQiI7Cxw0szsk9bhWoxjzgiaCS+PpBWwDfmkv5svogPTjD/Lm5kivhxSb
         qYb9zefc05nz1kxLbduYA7gSd4Q9x2rYRjlKN8QZzpuCdZDpR2s0ZIManprnNOcXYGrd
         OQLdrkT4wyvfsiCjGnywDRaFsED5KUgP0YEC9Kk/WCekaSW2Q3lTLDQaFy9RYao0iGfl
         jyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686876208; x=1689468208;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J17EhZbY5wWzCCc+lnSv/0GJ+YXs/j8FK+7ilGj63xM=;
        b=H2rxvSFSQ6TuykF8LxoFVUDSj2ffoFers4GA7fyYeypFAgEEs1CQ8Y4YI8RyKnCcOG
         ha5/IwIcBbGaQrMFrDRGgxKB3pytHoPwy5XZRGEAHuMEV1nsLtQKUXo9pGYr2JCGbKTq
         RMuVEmwxuzVpFMIj+nOOZ81L33UnfekH0sSRsmQeyuIhgGZmXZh+R+pcMsYQWCojn3Bz
         H864SkHE0S5OYVZIpOdbAwLthLkc1r6jZIZe+ezm8X9eWuCYq5cpv99z2Y/yne0iJa+W
         Xrvfx8ydB2/rfz1lvqbqc096eEPaZyd+X/6rgKNhnvhZZ2U3C1boCqQj6mGqJJopC0ai
         U50Q==
X-Gm-Message-State: AC+VfDxXXdZCdcNAtRl/MULGUu/yBGKuS0Mzs/i0bRFu6m3A/hsBNBpg
        JBZdulTfvfVvfW8pxX0sNnE=
X-Google-Smtp-Source: ACHHUZ6IslYD9JZkQIJwYJ9Y+Nik5yfJIg2I3oWjfNyRSEnToJJL7pA6em/1oI5RZIfhcF7baMnZuQ==
X-Received: by 2002:a05:6a00:189a:b0:666:3735:32bd with SMTP id x26-20020a056a00189a00b00666373532bdmr695443pfh.32.1686876208264;
        Thu, 15 Jun 2023 17:43:28 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id c16-20020aa781d0000000b0063f0068cf6csm12536893pfn.198.2023.06.15.17.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 17:43:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 6/9] repack: add `--filter=<filter-spec>` option
References: <20230614192541.1599256-1-christian.couder@gmail.com>
        <20230614192541.1599256-7-christian.couder@gmail.com>
Date:   Thu, 15 Jun 2023 17:43:27 -0700
In-Reply-To: <20230614192541.1599256-7-christian.couder@gmail.com> (Christian
        Couder's message of "Wed, 14 Jun 2023 21:25:38 +0200")
Message-ID: <xmqqmt10s0cw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> After cloning with --filter=<filter-spec>, for example to avoid
> getting unneeded large files on a user machine, it's possible
> that some of these large files still get fetched for some reasons
> (like checking out old branches) over time.
>
> In this case the repo size could grow too much for no good reason and a
> way to filter out some objects would be useful to remove the unneeded
> large files.

Makes sense.

If we repack without these objects, when the repository has a
promisor remote, we should be able to rely on that remote to supply
them on demand, once we need them again, no?

> Deleting objects right away could corrupt a repo though,...

Hmph, could you elaborate why it is the case?  Isn't it the whole
point to have promisor remote and use a lazy clone with the --filter
option, so that objects that _ought_ to exist from connectivity's
point of view _are_ allowed to be missing because the promisor
promises to make them available on-demand?

	Side note: I think I know the answer. While trying to remove
	UNNEEDED large files, doing so may discard NEEDED large
	files when done carelessly (e.g. the file may have been
	created locally and haven't been pushed back). But (1) if
	that is the problem, perhaps we should be more careful in
	the first place? (2) if it inherently is impossible to tell
	which ones are unneeded reliably, the reason why it is
	impossible, and the reason why "try sifting into two bins,
	one that we _think_ are unneeded and another for the rest,
	and verify what we _thought_ are unneeded are all available
	from the promisor remote" is the best we can do, must be
	described, I think.

> ... so it might be
> better to put those objects into a separate packfile instead of
> deleting them. The separate pack could then be removed after checking
> that all the objects in it are still available on a promisor remote it
> can access.

Surely, sifting the objects into two bins (i.e. those that we
wouldn't have received if we cloned from the promisor remote just
now, which are prunable, and those that we cannot lose because the
promisor remote would not have them, e.g. we created them and have
not pushed them to the remote yet) without removing anything would
be safe, but if the result of such sifting must be verified, doesn't
it indicate that the sifting step was buggy or misdesigned?  It does
not sound like a very good justification to save them in a separate
packfile.  It does smell somewhat similar to the cruft packs but not
really (the choice over there is between exploding to loose and
keeping in a pack, and never involves loss of objects).

> Also splitting a packfile into 2 packs depending on a filter could be
> useful in other usecases. For example some large blobs might take a lot
> of precious space on fast storage while they are rarely accessed, and
> it could make sense to move them in a separate cheaper, though slower,
> storage.

This one, outside the context of partial clone client, does make
tons of sense.

I guess what I suspect is that this option, while it would be very
useful for the "in other usecases" scenario above, may not become
all that useful in the "our lazy clone got bloated and we want to
trim objects we know we can retrieve from the promisor remote again
if necessary" scenario, until the repack machinery learns to use an
extra piece of information (namely "these are objects that we can
fetch from the promisor remote") at the same time.

> This commit implements a new `--filter=<filter-spec>` option in
> `git repack` that moves filtered out objects into a separate pack.
>
> This is done by reading filtered out objects from `git pack-objects`'s
> output and piping them into a separate `git pack-objects` process that
> will put them into a separate packfile.

So, for example, you may say "no blobs" in the filter, and while
packing the local repository with the filter, resulting in a pack
that exclude all blobs, we will learn what blob objects we did not
pack into that packfile.  We can pack them into a separate one, and
most of the blobs are what we could retrieve again from the promisor
remote, but some of the blobs are what we locally created ourselves
and haven't pushed back to the promisor remote yet.  Now what?  My
earlier suspicion that this mechanism may not be all that useful for
the "slim bloated lazy clone" comes from that I cannot think of a
good answer to this "Now what?" question---my naive solution would
involve enumerating the objects in that "separate packfile" that is
a mixture of precious ones and expendable ones, and then learning
which ones are precious, and creating a new pack that is a subset of
that "separate packfile" with only the precious ones.  But if I do
so, I do not think we need this new mechanism that seems to go only
the half-way.
