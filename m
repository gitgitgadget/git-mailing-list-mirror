Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996B9C433F5
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 20:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343499AbiAJURQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 15:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243965AbiAJURP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 15:17:15 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51237C06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 12:17:15 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id t24so10504036edi.8
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 12:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2l/d42bN7e80jL8tZsgcU1wVXkzs7iB2w+tPCoOUIYc=;
        b=mQxqdS8cpw7x3Qu76H3wSJJ5rRl+rqWiIvXbq4si+pHYOLHDdB0eFAPlz5AYGidvcM
         RcpvA2hvVScQhQeV7qzS92dAOTwBJLO9um2UloM0pCufVBBI6Fe+wHTxtHGH4FoJPoMb
         H+Hfzs0mJr6brGT6DMj1E8rbSz6dbRHt7Wg5twe78R2AUcs3OktXBtMbNNtakjVaPLfO
         /6N7caXETpptubuAOhphpkjJ3S9iX0B9l6RVtS7DTsgXJ/iRIyGZGB8MpvC6Dmsd4pq/
         G4lTP8SEe/iaKkOTnk0Hj7NfwSLX9jTRp1phnW4MoGJEdZFFZGGSzXZ8dGlQ1KJGdUaz
         bdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2l/d42bN7e80jL8tZsgcU1wVXkzs7iB2w+tPCoOUIYc=;
        b=IZyAOUOyljRz0WsgcCZtfmszIujQSd7OR9IRPqZN9bpmWLeopJDo9Wvgb//IKnTbmB
         bL+VkPVYEYLTFVbH/NV4SjFTG/OJ9a6e00cGQjjuCLg6kFcsUI7aOL4PTHGVgsvWW1e4
         xwepYUj1B1UpJgDV0xl3OPQVgo1PeEAjBn/2ryvNfMyggfodYp/tO06tpTz534VaDrVj
         C0YDK7lSUC3nJHqFWRkLhJrR1IK/WPtE6zYLU4TKQxz9wLWY8V2cncKVOyxrrG8XW68p
         I7h1LLZdSPiZVLOBsYxT+cLmNsZU/FJGIoM7/hkzHc/vB/lPfbSyInoUxdrw0dMk0NBI
         z6fQ==
X-Gm-Message-State: AOAM530ETycrRjm+XEDBqUejOq98//tihlgfg70vez8xnNpwVCqbHdhH
        DP9hwmICyI4Ddq3Y2B/tKxybIeYMUiSpVGpBOqE=
X-Google-Smtp-Source: ABdhPJxi92n/fqKuipuTA0HAbsI5W8wajKb2i4X+D+XSGc+zzlgOZLBH6XCdM9p7/jYIXoGgDg2SSTotRqU/qoytmmw=
X-Received: by 2002:a17:907:9712:: with SMTP id jg18mr1119045ejc.328.1641845833829;
 Mon, 10 Jan 2022 12:17:13 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BFLNqLuJ8o_6YZDYgd=Ft+wc9EjBPX+RRzwAdASKSW2bw@mail.gmail.com>
 <20220110192246.1124991-1-jonathantanmy@google.com>
In-Reply-To: <20220110192246.1124991-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 10 Jan 2022 12:17:02 -0800
Message-ID: <CABPp-BGtA1KwV8kdN52r5=XTCZrS_e3sPYfTxMnoEVyVV8Hc_w@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] Conditional config includes based on remote URL
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 10, 2022 at 11:22 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
> > On Wed, Dec 15, 2021 at 7:25 AM Jonathan Tan <jonathantanmy@google.com> wrote:
> > >
> > > Thanks, everyone, for your comments. I've followed Glen's code
> > > suggestion and Junio's documentation suggestion, as you can see in the
> > > range-diff.
> >
> > So, the basic idea is, in a setting like Google's, you can have users
> > install additional files on their system out-of-band, and have the
> > users specify a simple line in their configuration to make use of
> > those additional files -- or portions thereof.  It's a way of easily
> > providing potentially large blocks of pre-vetted configuration for
> > users.
> >
> > Seems to make sense.  (and I've read over the code lightly, so feel
> > free to take this as an Acked-by.)
>
> Thanks.
>
> > But can I back up and comment on a bigger picture item?
> >
> > This mechanism requires somehow getting additional files to the user
> > separately; projects that span companies (git.git, linux.git, etc.)
> > won't likely be able to make use of this.
>
> Yes, they would also need to use a separate mechanism in addition to
> Git.
>
> > Scalar also has a mechanism for providing potentially large blocks of
> > pre-vetted configuration for users.  It does so as part of a new
> > top-level command.  And it does so with a very opinionated set of
> > values that are not configurable.  Thus, while I'd like to use it,
> > they use a configuration option that would break things badly at my
> > $DAYJOB.  (Too many gradle plugins using jgit, which doesn't
> > understand index.version=4 and will blow up with a very suboptimal
> > error message when they see it.)  And, it's very specific to scalar;
> > we probably don't want to add a new toplevel command everytime someone
> > wants common configuration to be easily grabbed by some user.
>
> Do you have more information on this? The closest thing I've seen is
> "Scalar Config" under "Modifying Configuration Values" in [1], which
> seems to be more about bundling additional tools (which may change
> config, of course).
>
> Unless you're referring to the config bundled in the Scalar tool itself,
> in which case this patch set seems orthogonal and potentially
> complementary - I was envisioning config being provided by a package
> manager package, but Scalar could provide some too for users to use at
> their own discretion.
>
> [1] https://github.com/microsoft/git/blob/7a514b4c2d5df7fdd2f66f048010d8ddcb412d0b/contrib/scalar/docs/troubleshooting.md

Yes, I was referring to the config hardcoded in the Scalar tool itself
(see set_recommended_config() in
https://lore.kernel.org/git/4439ab4de0bc3f48a6bdcf4b5165b16fad792ebd.1638538470.git.gitgitgadget@gmail.com/).

I agree they are different solutions to "help others setup config in a
pre-vetted way", that the two don't seem to conflict, and one can't be
implemented in terms of the other.  It might even be possible for
someone somewhere to simultaneously take advantage of both (not sure
if anyone would try, but I don't forsee problems in doing so, except
in the narrow case that both schemes try to set the same config and
there are worries about which one "wins", which might boil down to
whether the include directive came first in the config file or the
specific config value that scalar set).

> > It would be nice if we could find some more generic solution.
> > Granted, I can't think of any, and I don't think this comment should
> > block this particular series (nor the scalar one), but I am worrying a
> > little bit that we're getting multiple completely different solutions
> > for the same general problem, and each brings caveats big enough to
> > preclude many (most?) potential users.  I don't know what to do about
> > that, especially since configuration that is too easy to propagate
> > comes with big security problems, but I wanted to at least raise the
> > issue and hope others have good ideas.  If nothing else, I want to
> > raise awareness to avoid proliferation of similar
> > pre-vetted-configuration-deployment mechanisms.  I'm CC'ing a couple
> > scalar folks as well for that point.
>
> That's a good point. As Glen said [2], it seems like transmitting config
> itself (or, at least, hooks) through Git is something that we (the Git
> project) don't want to do, so I have been working from the basis that
> Git should just make use of config/hooks delivered through a non-Git
> mechanism, and not deliver the config/hooks itself.
>
> [2] https://lore.kernel.org/git/kl6lee5w5nng.fsf@chooglen-macbookpro.roam.corp.google.com/

Yeah, makes sense.  And I don't know any better solutions.  I guess
all I'm really saying is that if a third narrowly targetted way to
provide pre-vetted configuration shows up on the list, it may be time
to ask folks to step back and try to find a more generic solution.
