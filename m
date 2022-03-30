Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0635C433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 22:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351649AbiC3WdX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 18:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347908AbiC3WdW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 18:33:22 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41585BD2E
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 15:31:35 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id i11-20020a9d4a8b000000b005cda3b9754aso15915866otf.12
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 15:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UnfMly3FOWzodrYUhACU1s+ojNgNTgPZ5Tjpceu8mQ8=;
        b=OedliNKjpXbL4Z0k6Hl70BNvdabmp/55GHiIZHszIhqgxTNubhLxR03BBZhColQxmN
         qV1fyyVAxg244E7wh2IvCzaIbe0doBZjka32b7xNzccLgKU6TDJzCHb79tAWrgJeq7/Y
         /QWkO6REVGxPDRsTPydQ8g4/u+8+PqN3Ac8yQf873nNliwcWMYvB+iFNR5jYTI1y/vIj
         ZQt858KiFzl0mruaFc3uX7iZGug6CjNWhJOnS7I07mzM/pqBNYGXRcfyu/VpDVC+WgxN
         TPBi5HaU1q0mBGA4lYvetAJTHVZ1RvwnhEDHht9aQhDLrYY3hLgMWLeGV3XLPioKL2wm
         ZsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UnfMly3FOWzodrYUhACU1s+ojNgNTgPZ5Tjpceu8mQ8=;
        b=ThV5qMqDZaTftP7UimBqoW6RZdxW4TcmnLl+288xeZQITlPUF8njF+6MYVsx4w8S/t
         dCVYsAT0MJOMtKSfD2lqDvyHgohvO7Wk/4zh90bb2gK+rWAR/pz8VmwmMIPdyV240or7
         bD5J2Gwl0MZvJomnFzJqkfblqSxip7d43zJ3eJv99Hhe9jIDXVEhN5ltishTtEGbfb1m
         L8btysmbJcmz1gcamoK/2zE8vypHngLusiXkouFTcZK5P3myqFW204eag62/30JCBXDd
         OHrigp7pMZlNzg+U8XJ2zuJVCDlzcIy4rGB6FvK+SDmBT68pdj8WDizfKcEwytoFD93E
         iHtA==
X-Gm-Message-State: AOAM532bzpKNLhHh9yyuJde1ZvhQ1TCBP5Jx8Qe1pqEy846Q673/yy/M
        7UAZkhJ3BQPgFEf2SjMVRq1pFEioCKEbqrVJXKff5A==
X-Google-Smtp-Source: ABdhPJyfOxkeKnb/IG8wE1VxaCTibWXxL73mQ1q8eSRroILCEM1lAZYU+evLnuxVoGXjDUqIarUYfietXzMrH+IdQX8=
X-Received: by 2002:a05:6830:2478:b0:5c9:289c:597f with SMTP id
 x56-20020a056830247800b005c9289c597fmr4335508otr.130.1648679494937; Wed, 30
 Mar 2022 15:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220208235631.732466-1-calvinwan@google.com> <20220328191112.3092139-1-calvinwan@google.com>
 <20220328191112.3092139-4-calvinwan@google.com> <xmqqmth8qsiv.fsf@gitster.g> <xmqq4k3gqn7n.fsf@gitster.g>
In-Reply-To: <xmqq4k3gqn7n.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 30 Mar 2022 15:31:24 -0700
Message-ID: <CAFySSZB3hAhUF2ODK5YaPP8VcPa=_LovD82zOm0BHcpQzk_T-Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] object-info: add option for retrieving object info
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Overall, I agree that this option does not belong in fetch. I wouldn't
say I chose to put it there for the sake of implementation
convenience, but because "it does what fetch is supposed to do minus
the object itself". This logic no longer makes any sense to me, and I
regret not seeing the problems with it as I was coming up with
workarounds.

> I think that "Object 'size' is currently the only one the server
> knows to emit", combined with the lack of any client side support so
> far, means that it is not too late to rework the object-info thing
> and possibly reuse more from "cat-file --batch-check".

I talked this over with Jonathan Tan and we came to the conclusion
that this is the next option I should look into, rather than
separating it out into its own command.

Thank you for the review Junio! I appreciate how straightforward all
of your comments are.

On Tue, Mar 29, 2022 at 5:49 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Shouldn't we be making the part that we truly need to reuse into a
> > separate API out of fetch-pack and either (1) allow new commands be
> > easily written reusing the code to create "git remote-object-info"
> > and "git remote-blame", or (2) come up with a single "do things on
> > remote" command with various subcommands, i.e. "git over-there
> > object-info" and "git over-there blame"?
>
> For completeness, we could also make the "git archive" the gold
> standard.  If we want "git blame" that is mostly executed on the
> remote site, we could teach "git blame --remote <there>", which may
> be where a user, who does not know nor care about how things are
> implemented, would expect to find the feature.  Is "object-info" in
> principle like executing "cat-file --batch-check" remotely?
>
> I think that "Object 'size' is currently the only one the server
> knows to emit", combined with the lack of any client side support so
> far, means that it is not too late to rework the object-info thing
> and possibly reuse more from "cat-file --batch-check".
>
> If we can create a system where running things locally and remotely
> are comparable in feature, that would be great, but I do not think
> that is a realistic goal to aim for.
>
> Thoughts?
>
>
>
