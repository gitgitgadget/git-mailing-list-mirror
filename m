Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64097C636D6
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 22:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjBQWuJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 17:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjBQWuH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 17:50:07 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991095FD7
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 14:50:05 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id cn2so9820107edb.4
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 14:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3O6IwTirF/wOT1jNbPRrNutIiOwCJmvNz/X17D23vJM=;
        b=rUCdwkC1rdYIAgNFrTJxRLZT64URdhL0o0ztTyaePTGR8N6Pz2Pgyo55kqXhkKkxnm
         iAMrPj2a7C3q2z6sehr7Z8GYkk43KzocG7PMzNCPk33d3SLZap4m9omDhDXBXiVLxov+
         N2hLWAiTCLD1WeeYbeKXcijWUx5TqOYpwj0fJdfjboK2rt8SS26/7EiF2fikoJU453pz
         5gvDG7avrFWUKZ+ul9fV2CO4tIP7leQn5ld5qqU7fNjNvckifhkEIeYFBqyYxP1sk4nL
         p+Q0hDYJ1IsNDjBZi7YJ2f2KnN5v1oaCx/3WKYgt/9rjJmKVyIYSThaY6zIEgZb/63tN
         9MZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3O6IwTirF/wOT1jNbPRrNutIiOwCJmvNz/X17D23vJM=;
        b=PUNkwP36q5cBcq30FGQL4UDkOF8O/7ydHNETT+dob2CTXV44HsDb34TKsYNOtsTY21
         GU01n4cSoUo7vUwX1Ouv+//q+wF1r2s6ARCcJJ+vbXVfR+ozV8HMAA8nILwitj4xDahV
         HHt+fk+u94vclHuC+054F2pZAUbYSufS8KwlpJS+yravuY8D84AvSQznCaFQjAlwQIPB
         PCXIY0nTlRpovOYUcYKqoAQQs1CmL0CPQPorRYp+Za3xhDKCIeWUZi7OQ0mlJ505n5k8
         AoEWn5HtglxWYTpYlmluYHHSwE982UR+Ulqx91U5P+Dwecyf2zB1YLzPoXbNBw0KqsCt
         P+ag==
X-Gm-Message-State: AO0yUKV+66Jx6MSA517gafJjs0ChtzdsBIESaQN1STuYbSgJW1HrX/UU
        RLhHGOcwWIDYkQXEkObAzRFNr5NqplmqrehjuVFGW73vJO8TdgAc
X-Google-Smtp-Source: AK7set9qsHAbBAyBfuhxgXMSKzEUstU98PU/lQyirtUKtflGiC9mboj6A/5edKIFmAJi5tm10GiNzmbxw/WCo6g9DjU=
X-Received: by 2002:a17:906:4f0a:b0:8b1:30eb:9dba with SMTP id
 t10-20020a1709064f0a00b008b130eb9dbamr1192078eju.6.1676674203883; Fri, 17 Feb
 2023 14:50:03 -0800 (PST)
MIME-Version: 1.0
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
 <Y+/v15TyCbSYzlVg@tapette.crustytoothpaste.net> <CAJoAoZmMQ-ROdCp0=4oaFa836-PqxwYntnRSBSzzJc5chp16eQ@mail.gmail.com>
 <Y/ACqlhtLMjfgJFQ@tapette.crustytoothpaste.net>
In-Reply-To: <Y/ACqlhtLMjfgJFQ@tapette.crustytoothpaste.net>
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Fri, 17 Feb 2023 14:49:51 -0800
Message-ID: <CAJoAoZkMR9Acy7thVs-_e=Fz8wwjoDGDKb46wmwn8yxk0ODGow@mail.gmail.com>
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Emily Shaffer <nasamuffin@google.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2023 at 2:41 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2023-02-17 at 21:38:34, Emily Shaffer wrote:
> > For example, I seem to remember you saying during the SHA-256 series
> > that the next hashing algorithm would also be painful to implement;
> > would that still be true if the hashing algorithm is encapsulated well
> > by a library interface? Or is it for a different reason?
>
> Right now, most of the code for a future hash algorithm wouldn't be too
> difficult to implement, I'd think, because we can already support two of
> them.  If we decide, say, to implement SHA-3-512, we basically just add
> that algorithm, update all the entries in the tests (which is kind of a
> pain since there's a lot of them, but not really difficult), and then
> move on with our lives.
>
> The difficulty is dealing with interop work, which is basically
> switching from dealing with just one algorithm to rewriting things
> between the two on the fly.  I think _that_ work would be made easier by
> library work because sometimes it involves working with submodules, such
> as when updating the submodule commit, and being able to deal with both
> object stores more easily at the same time would be very helpful in that
> regard.

Ooh, I see what you mean. Thanks for the extra context here.

> I can imagine there are other things that would be easier as well, and I
> can also imagine that we'll have better control over memory allocations
> and leak less, which would be nice.  If we can get leaks low enough, we
> could even add CI jobs to catch them and fail, which I think would be
> super valuable, especially since I find even after over two decades of C
> that I'm still not very good about catching all the leaks (which is one
> of the reasons I've mostly switched to Rust).  We might also be able to
> make nicer steps on multithreading our code as well.
>
> Personally, I'd like to see some sort of standard error type (whether
> integral or not) that would let us do more bubbling up of errors and
> less die().  I don't know if that's in the cards, but I thought I'd
> suggest it in case other folks are interested.

Yes!!! We have talked about this a lot internally - but this is one
thing that will be difficult to introduce into Git without making
parts of the codebase a little uglier. Since obviously C doesn't have
an intrinsic to do this, we'll have to roll our own, which means that
manipulating it consistently at function exits might end up pretty
ugly. So hearing that there's interest outside of my team to come up
with such a type makes me optimistic that we can figure out a
neat-enough solution.

> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA
