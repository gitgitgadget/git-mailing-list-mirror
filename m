Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C751CEB64DC
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 14:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjFUOk2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 10:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjFUOk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 10:40:27 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E88170C
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 07:40:25 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f9b1a117caso31462375e9.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 07:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687358424; x=1689950424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsKiJVvupMyCQ+O75aVRJGx/+UHlA+Nxv0c9dsRVBbc=;
        b=ZbFB/rHIg4GT7utqw1K37M1PtXQJyZc0MmCYXpKQz7IIArfvNG5nJm44PKZdszr12X
         lmXe2JFq7F4aLjZgMMQ6Wm0K49oHjP9SNAQQut6gN1rLkIqYiLECHcJO8A7FFMe+fs5U
         aHtsntqy65knSfdw4bFyVoJ4fyOPQiU98nYJmUQXEDq6/tazNFollHRG2axYn/dbW0l6
         BHfzvDJMd9kWldPIkH+POQ1UflDVq11xLnexCDE8txnHTYX1ou5JH92ZYopF0wbMylJw
         nlUbEFj2ej97RmFh80aR1SJk5w/vUSPAHfkc8dr640vNdxFffvupKWa1mDRKYjunrCeI
         eF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687358424; x=1689950424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsKiJVvupMyCQ+O75aVRJGx/+UHlA+Nxv0c9dsRVBbc=;
        b=fTq8JsnHb0vJZO0uDwCsaqP1KtGmaAoTI87K+gYW5OtfurY/3zWQnD90abFMtYddoh
         +mwV+V0drh2n6/IStsCSpcMhMetKxb35OSUnosBWSqTIBOj+kpKBw5v8b6XKTOyvvcQX
         OLK2dUEdtpDBJKjo6czUy3iJp9ARUVqOF8Gi+DPiCp7Rec9ImjgcCea5pC0+sZuFQpuQ
         Ms+yxk3Xicd2RSsjinq20dtWP+Q7BDF8IIpANzUMzzPn1CoUxA8CFDM+i0/b+r5y+sgi
         2ac8xjKdlS3hL4UAWi7sEHRu9Vw0s+ID8fsQ5V1+XOZMl/RZE5v36Hc7A2Xa4r5IUkWc
         jPgQ==
X-Gm-Message-State: AC+VfDy0E/9YOGRg7dcDMlXxPPWfla/fpY80mqkKrf1oSoGH4GP1xnMa
        r1F5AVxD4j4KBQPO5MqZ8pUha50UQZN44LeAQKw=
X-Google-Smtp-Source: ACHHUZ5qBxp8u9e3+ISgpVOuCilPEY5f409T9KniT4FhnT5S7TohHLVBvJiBQTRZt7v2LK1TeCMfUYwBsIJHgFaZRP8=
X-Received: by 2002:a1c:721a:0:b0:3f9:c19:dfbd with SMTP id
 n26-20020a1c721a000000b003f90c19dfbdmr6783883wmc.0.1687358423631; Wed, 21 Jun
 2023 07:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230614192541.1599256-7-christian.couder@gmail.com> <xmqqmt10s0cw.fsf@gitster.g>
In-Reply-To: <xmqqmt10s0cw.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 21 Jun 2023 16:40:10 +0200
Message-ID: <CAP8UFD3864uUjb0vR+B7xETJTFJoWdEqA5Gdyr42Lg3t8Auk=Q@mail.gmail.com>
Subject: Re: [PATCH 6/9] repack: add `--filter=<filter-spec>` option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 16, 2023 at 2:43=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > After cloning with --filter=3D<filter-spec>, for example to avoid
> > getting unneeded large files on a user machine, it's possible
> > that some of these large files still get fetched for some reasons
> > (like checking out old branches) over time.
> >
> > In this case the repo size could grow too much for no good reason and a
> > way to filter out some objects would be useful to remove the unneeded
> > large files.
>
> Makes sense.
>
> If we repack without these objects, when the repository has a
> promisor remote, we should be able to rely on that remote to supply
> them on demand, once we need them again, no?

Yeah, sure.

> > Deleting objects right away could corrupt a repo though,...
>
> Hmph, could you elaborate why it is the case?  Isn't it the whole
> point to have promisor remote and use a lazy clone with the --filter
> option, so that objects that _ought_ to exist from connectivity's
> point of view _are_ allowed to be missing because the promisor
> promises to make them available on-demand?
>
>         Side note: I think I know the answer. While trying to remove
>         UNNEEDED large files, doing so may discard NEEDED large
>         files when done carelessly (e.g. the file may have been
>         created locally and haven't been pushed back).

Yeah, right.

>         But (1) if
>         that is the problem, perhaps we should be more careful in
>         the first place?

Yeah, but earlier when we implemented `repack --filter=3D...` that was
removing objects, saying that one should be very careful in the docs
and implementing safeguards didn't seem to be safe enough for
reviewers. Reviewers said that the feature would anyway provide a too
easy way for users to shoot their own foot.

>        (2) if it inherently is impossible to tell
>         which ones are unneeded reliably, the reason why it is
>         impossible, and the reason why "try sifting into two bins,
>         one that we _think_ are unneeded and another for the rest,
>         and verify what we _thought_ are unneeded are all available
>         from the promisor remote" is the best we can do, must be
>         described, I think.

You mean described in the `repack --filter=3D` doc? Yeah, I can describe
this use case in the doc, but see below.

> > ... so it might be
> > better to put those objects into a separate packfile instead of
> > deleting them. The separate pack could then be removed after checking
> > that all the objects in it are still available on a promisor remote it
> > can access.
>
> Surely, sifting the objects into two bins (i.e. those that we
> wouldn't have received if we cloned from the promisor remote just
> now, which are prunable, and those that we cannot lose because the
> promisor remote would not have them, e.g. we created them and have
> not pushed them to the remote yet) without removing anything would
> be safe, but if the result of such sifting must be verified, doesn't
> it indicate that the sifting step was buggy or misdesigned?

It might indicate that we prefer to be safe, do things in different
steps and not provide an easy way for users to shoot their own foot.
For example it seems pretty safe to do things like this:

  1) put all the objects we think should be on the promisor remote in
a separate packfile
  2) start checking that each object in that packfile is available on
the promisor remote
  3) if an object in that packfile isn't on the promisor remote, try
to send it there
  4) if we couldn't send the object, error out
  5) if we haven't errored out after checking all the objects in the
packfile, it means all these objects are now available from the
promisor remote and we can safely delete the packfile

The above steps can be done while new objects are created on the repo,
or fetched, or pushed into the repo. And, at least for now, it would
be done by a custom script, so users writing and installing it should
know what they are doing and would hopefully not complain that we
provided an easy way for them to shoot their foot.

If we don't even document the above in the --filter=3D... doc, it makes
it even less likely that they will do this and that their script might
be wrong. So even if I could document it in version 2, I am not sure I
should.

>  It does
> not sound like a very good justification to save them in a separate
> packfile.  It does smell somewhat similar to the cruft packs but not
> really (the choice over there is between exploding to loose and
> keeping in a pack, and never involves loss of objects).

If we are still worried about possible loss of objects, I am Ok with
not talking at all about use cases involving possible loss of objects.

> > Also splitting a packfile into 2 packs depending on a filter could be
> > useful in other usecases. For example some large blobs might take a lot
> > of precious space on fast storage while they are rarely accessed, and
> > it could make sense to move them in a separate cheaper, though slower,
> > storage.
>
> This one, outside the context of partial clone client, does make
> tons of sense.

Ok, so perhaps it is enough to justify this feature and patch series.
And I can just avoid talking about other use cases at all?

> I guess what I suspect is that this option, while it would be very
> useful for the "in other usecases" scenario above, may not become
> all that useful in the "our lazy clone got bloated and we want to
> trim objects we know we can retrieve from the promisor remote again
> if necessary" scenario, until the repack machinery learns to use an
> extra piece of information (namely "these are objects that we can
> fetch from the promisor remote") at the same time.

Yeah, perhaps we should wait for a command or a repack option or some
helper scripts to be able to perform steps 2) to 4) or 2) to 5) above
before talking about use cases involving a promisor remote.

On the other hand, it's possible to imagine other steps than the steps
2) to 4) described above. For example, if we want to repack on a
server where new large blobs can hardly be created and where there is
a receive hook that automatically sends all the large blobs to a
promisor remote as soon as they are received, we might not need steps
3) and 4) to send objects to the promisor remote. Just checking that
they are on the promisor remote might be enough.

Also even if we think we should have features covering all the 5
steps, should we cover all the ways blobs could be sent to the
promisor remote as part of step 3)? Some people or server platforms
might want to use git for that purpose, but others might prefer for
example FTP or plain HTTP(S) so that a transfer can be restarted if it
fails.

So should we really wait until we have all possible such use cases
covered by some features or scripts, or not? When does it become Ok to
talk about this? And then how much is it Ok to talk about this?

> > This commit implements a new `--filter=3D<filter-spec>` option in
> > `git repack` that moves filtered out objects into a separate pack.
> >
> > This is done by reading filtered out objects from `git pack-objects`'s
> > output and piping them into a separate `git pack-objects` process that
> > will put them into a separate packfile.
>
> So, for example, you may say "no blobs" in the filter, and while
> packing the local repository with the filter, resulting in a pack
> that exclude all blobs, we will learn what blob objects we did not
> pack into that packfile.  We can pack them into a separate one, and
> most of the blobs are what we could retrieve again from the promisor
> remote, but some of the blobs are what we locally created ourselves
> and haven't pushed back to the promisor remote yet.  Now what?  My
> earlier suspicion that this mechanism may not be all that useful for
> the "slim bloated lazy clone" comes from that I cannot think of a
> good answer to this "Now what?" question---my naive solution would
> involve enumerating the objects in that "separate packfile" that is
> a mixture of precious ones and expendable ones, and then learning
> which ones are precious, and creating a new pack that is a subset of
> that "separate packfile" with only the precious ones.  But if I do
> so, I do not think we need this new mechanism that seems to go only
> the half-way.

I hope the above 2) to 5) steps and related explanations are a good
answer to the "Now what?" question.

Thanks,
Christian.
