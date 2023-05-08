Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3933C77B7D
	for <git@archiver.kernel.org>; Mon,  8 May 2023 02:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjEHCBD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 May 2023 22:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjEHCBB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2023 22:01:01 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7C012EAC
        for <git@vger.kernel.org>; Sun,  7 May 2023 19:01:00 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-19290ad942aso3116823fac.2
        for <git@vger.kernel.org>; Sun, 07 May 2023 19:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683511258; x=1686103258;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cy2Qi6jn/lPGEUPLgoW4fQyuYyqmZSE2c9Vr0FiAbcg=;
        b=aE67xQGcBPG/BIcmM2oG+fdGl7EJxfF7njtJfDAjjUpMAfxbrK+ttG/e/rMmxGuJ4w
         7HVPfz8eBiqyhu0GTXV+SDNhRGlp0ww61Dxsf4n2H2Sne/FTGLjrSsghBwSjKKqTwBoG
         8wzCaxa0eqFQDYQG3g0u6nUyDI7C0YMplQ1WWzLyW4vK0ig8rWbtahxMMQ/2Y5n/NFBN
         k5f/azODT7o3OpK/m9ZUf+6vT+NzpXf0lxJCQKEoBTZiKytozarsHm1FHnW2vXDq8eX9
         n3ENo5PUamXay9iwm8R8lYxcaFmbYfYVLGGk9WxjqRmwF63A7tJmaNIAXq47CDFqOVDs
         HSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683511258; x=1686103258;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cy2Qi6jn/lPGEUPLgoW4fQyuYyqmZSE2c9Vr0FiAbcg=;
        b=ivFep/SGyvGA7Al1wYOYoflq3Awd11Gk17LrqP2qwEhdNVPej8Wm2GrIE8F6nNOlz6
         WMropmKTO9rhodpGg2yLpeEOcj/FrBmvSWRYEuP30ptyA7zP8z7uEyCKFnDPYJ8iuuec
         kz5S6mPp90xk9+K5MCRUuBd3FGmksAxvoPsmqgiCycM9OCXUZ4qI89EkB4WdHPtqGkzv
         6+yRl4rouYz2EBFbnZ012l4voN9uXt9wNpD8TJZ7Zy5+CnlyWkk7gS3HgTHEXyo7yfRj
         /F7Uels3uOxlfs0DdcAmgs4TqolFWI2bXyK8SCrJeYO6whUv568UxdT2/amyGzwHjL1+
         xkzg==
X-Gm-Message-State: AC+VfDxjOAcMftjfGq8EfB5sgXLjUENPW5TVDFOub+toF2uJXhAvN0Ye
        MF1fAjgYJmHUrTh2yuA9Jys=
X-Google-Smtp-Source: ACHHUZ64hAMzU99e1fWzWXrr+cWG9ahVImz1+HlcWJmQmkHl8Ajzb4IbGVCJe3C46sUjmBe+tlid6Q==
X-Received: by 2002:a05:6871:542:b0:17e:cb7:29a3 with SMTP id t2-20020a056871054200b0017e0cb729a3mr4991928oal.15.1683511258342;
        Sun, 07 May 2023 19:00:58 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id w22-20020a056870431600b001925ab4a7ddsm4432816oah.22.2023.05.07.19.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 19:00:57 -0700 (PDT)
Date:   Sun, 07 May 2023 20:00:56 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Adam Majer <adamm@zombino.com>
Message-ID: <645857d8e8fd7_4e6129477@chronos.notmuch>
In-Reply-To: <ZFLmGYXgvyydLB5E@tapette.crustytoothpaste.net>
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
 <20230426205324.326501-1-sandals@crustytoothpaste.net>
 <20230426205324.326501-3-sandals@crustytoothpaste.net>
 <xmqqbkjaqqfp.fsf@gitster.g>
 <20230427054343.GE982277@coredump.intra.peff.net>
 <6451a0ba5c3fb_200ae2945b@chronos.notmuch>
 <ZFLmGYXgvyydLB5E@tapette.crustytoothpaste.net>
Subject: Re: Is GIT_DEFAULT_HASH flawed?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On 2023-05-02 at 23:46:02, Felipe Contreras wrote:
> > In my view one repository should be able to have part SHA-1 history,
> > part SHA3-256 history, and part BLAKE2b history.
> 
> That is practically very difficult and it means that it's hard to have
> confidence in the later history because SHA-1 is weak and you have to
> rely on it to verify the SHA-256 history later.

Why would I have to rely on SHA-1 to verify the SHA-256 history later
on?

> Since attacks always get better, SHA-1 will eventually be so weak that
> collisions can be computed in the amount of time we now take for MD4
> or MD5 collisions (i.e., seconds), and with your plan, we'd have to
> retain that history forever with the resulting lack of confidence in
> part of the history.

We have to do the same with your plan as well.

Your plan relies on SHA-256 being interchangeable with SHA-1, so if the
Git project decided to switch *today* to SHA-256, we would have two
object ids:

 1. 69c786637d7a7fe3b2b8f7d989af095f5f49c3a8
 2. 2b4ebdace10518280172449c012af17b51e9d46e023a91a5d3dd3a8ad9e4a116

This object would refer to a tree and a parent object with SHA-1 ids,
which would be OK, because they would be interchangeable with some
corresponding SHA-256 ids.

Isn't that your plan?

Therefore the SHA-1 of the parent of the commit, and the tree of the
commit would be trusted and retained forever.

> This also doesn't work with various structures like trees, the index,
> and pack and index formats, which have no indication of the algorithm
> used and simply rely on fixed-size, often 4-byte aligned object IDs
> without any metadata.

So? The index and pack objects can be regenerated, so at any point in
time they could be regenerated for SHA-1 or SHA-256.

The tree object is a no-brainer. For an object of type "commit:256" you
require a tree of type "tree:256". Easy.

> In addition, the internals of the code often don't pass around enough
> data to make these values variable and thus this approach would
> substantially complicate the code in many ways.

Really? `enum object_type` is not passed around?

> Also, we've already decided on the current design a long time ago with
> the transition plan after extensive, thoughtful discussion by many
> people.

Who is "we"?

I've participated in many discussions in the git mailing list where the
consensus is that 99% of people decide to do something, and that
something never happens.

The fact that "we" have decided something doesn't carry as much weight
as you seem to think it does.

Moreover, haven't "we" decided that this transitioning plan is
*tentantive*, and the SHA-256 feature is *experimental*?

> Very few people other than me have worked on sending patches to
> work on the hash function transition, and that work up to now has all
> been done on my personal time, without compensation of any sort, out of
> a desire to improve the project.

Which seems to suggest if there is a need, it's not very pressing.

Doesn't it?

> Lots of people have opined on how it should have been different
> without sending any patches.

As is typical.

> If you would like to propose patches for the extensive amount of work
> to implement your solution, then we could consider them, although I
> will warn you that your approach will likely require at least several
> hundred patches.

That's not an issue. I've started projects with several hundred patches
just to prove that something is possible.

> However, I refer you to the list archives to determine why
> your approach is not the one we chose and is not, in my view, the best
> path forward.

Yeah? Provide me with *one* mail proposing my approach.

> I should also be clear that I have no intention of submitting patches
> to change our approach now or in the future, or redoing the patches
> I've already sent.

You don't have to. (and it's not really necessary as it's typically the
case that people don't provide patches for designs that compete against
their own).

> > The fact that apparently it's so easy to clone a repository with
> > the wrong hash algorithm should give developers pause, as it means the
> > whole point of using cryptographic hash algorithms to ensure the
> > integrity of the commit history is completely gone.
> 
> No, it doesn't.  It means that our empty repositories until recently
> lacked any indication of the algorithm or other capabilities, which was
> a mistake in our original protocol design that has now been corrected.

Yes it does.

Can I clone a repository that already transitioned to SHA-256, and then
push a SHA-1 commit?

Well, of course I can't because that's not currently implemented, but if
we followed the current plan that apparently "we" have decided on, it
should be.

> If you interact with the repository later on when it has data, then if
> you're using the wrong hash algorithm, you'll find that you get a
> helpful error message that that's not yet supported.

That isn't true according to your plan.

SHA-1 would be interchangeable with SHA-256, would it not? So according
to the current plan, I would be able to push a SHA-1 commit on a SHA-256
repository.

---

Is it not the case that the current plan aims to have support for SHA-1
and SHA-256 object ids at the same time?

In other words: in your ideal world, the following object ids would
*both* refer to the same git object:

 1. 69c786637d7a7fe3b2b8f7d989af095f5f49c3a8
 2. 2b4ebdace10518280172449c012af17b51e9d46e023a91a5d3dd3a8ad9e4a116

Would they not?

-- 
Felipe Contreras
