Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B725FC433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 15:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345250AbiBBPDI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 10:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiBBPDH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 10:03:07 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3377DC061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 07:03:07 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id p12-20020a17090a2d8c00b001b833dec394so1221741pjd.0
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 07:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coup.net.nz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r2FxEOPWPcQAtuxbPNFnA9IJ1AORqNaRm9k0Q4WqBv0=;
        b=RCMTP5hsHRlvQlLRD6P4hSzerBFjvjx2vYyvqm7W572ho8eeINKuPyQupRV0joBdxP
         zu30/us0DcnC7wkn8Q3HqUHDBjgsAjj2aQOHdM9l8toWuGntNVeQM0RAEoFsJNejq7b3
         nTD+EI5ig1/X4bHgi9RVYrb/brPq7teSf+GB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r2FxEOPWPcQAtuxbPNFnA9IJ1AORqNaRm9k0Q4WqBv0=;
        b=fwjEDjh58f1RAi+Uxe0VvqKhVZxSb43RrDa+P38IuCdrVK7nOFRE99LQltOoFat4ik
         xpAI8YMUFkIb3/TKfom9rz8/gbh9dXYYkHlDX7yZxxPQN5TAJjyf5V5ZWUh35GaV8OZl
         TNfPK8FSFl161YS9vf+8hOpMgiPurhRU303vDHyeJV2zPKiXouvqc7eJFDpo4Hy4jJMZ
         7Wx0D8UaoUOJSVA4xoG6kyCHtMBO0cMykTMNArsZPwLuIohumscjBFJwoE+UAHzXBOGD
         hwl1oVmFIpQIx+8sKEN8fSV+wrvoUkMHBmW4X8ZjzsUqV2JxwmGYy4hOq+x+xRMD1Nn1
         hF9g==
X-Gm-Message-State: AOAM532SVSWtjlzAFWCVyf+LW2hNPnepcDkHE0K7aAnqGK472vr8sb1B
        UNJTuf46fI5FlT/VuZZAwm8Ka/n0fLyPBW3mIQEoDQ==
X-Google-Smtp-Source: ABdhPJwh9XeQICzfZM4Vmupq4Z/dRVisUzFtu5CbXzqxElakKdyNA0Rjiv7glXeGk5jKgDRHUIdEeIA6u+LeWjaZKFU=
X-Received: by 2002:a17:90b:4b88:: with SMTP id lr8mr8544816pjb.166.1643814186543;
 Wed, 02 Feb 2022 07:03:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com> <xmqqk0eecpl9.fsf@gitster.g>
In-Reply-To: <xmqqk0eecpl9.fsf@gitster.g>
From:   Robert Coup <robert@coup.net.nz>
Date:   Wed, 2 Feb 2022 15:02:55 +0000
Message-ID: <CACf-nVdmWyDnhJC=ikx85UST=u2ENAc4DhJJCp5c030Vb9=4+Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] [RFC] partial-clone: add ability to refetch with
 expanded filter
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

Thanks for your input. Hopefully some of the other partial-clone
interested folks will chime in too.

On Tue, 1 Feb 2022 at 20:13, Junio C Hamano <gitster@pobox.com> wrote:
>
> It sounds like a useful thing to have such a "refetch things"
> option.

Any improved suggestions on the argument name? I thought of
--refetch but `fetch --refetch` seemed more confusing to explain.

> Makes me wonder how well these two features work together (or if
> they are mutually exclusive, that is fine as well as a starting
> point).

I don't see any particular reason they can't work together - as you say,
the filtering is orthogonal to shallow on a conceptual level. I haven't
added a test for that scenario yet but will do for a v1.

> If you update the filter specification to make it narrower (e.g. you
> start from blob:limit=3D1m down to blob:limit=3D512k), would we transfer
> nothing (which would be ideal), or would we end up refetching
> everything that are smaller than 512k?

As you spot, the latter. I can't see a straightforward way of telling the
server "I have these trees/blobs already" without generating (one way
or the other) a list of millions of oids, then transferring & negotiating
with it.

> ... it is not smart enough to stell them to exclude what we _ought_
> to have by telling them what the _old_ filter spec was.  That's OK
> for a starting point, I guess.

The client doesn't really know what the local repository *has* =E2=80=94
potentially several filters could have been applied and used for fetches
at different points in the commit history, as well as objects dynamically
fetched in. Even a filter set in the config only applies to subsequent
fetches, and only if --filter isn't used to override it.

> Hopefully, at the end of this
> operation, we should garbage collect the duplicated objects by
> default (with an option to turn it off)?

I haven't explicitly looked into invoking gc yet, but yes, it'd be a bit of
a waste if it wasn't kicked off by default. Maybe reusing gc.auto

> In other words, a repository that used to be a partial clone can
> become a full clone by using the option _and_ not giving any filter.

For that specific case I think you can already do it by removing the
promisor flag in the remote config, potentially adding it back if you
wanted to keep it partial again from that point forward.

> I think that is an intuitive enough behaviour and a natural
> consequence to the extreme of what the feature is.  Compared to
> making a full "git clone", fetching from the old local (and narrow)
> repository into it and then discarding the old one, it would not
> have any performance or storage advantage, but it probably is more
> convenient.

It's certainly cleaner than abusing --deepen, or temporarily moving pack
files out of the way, or starting over with a fresh clone & copying config.

Thanks,

Rob :)
