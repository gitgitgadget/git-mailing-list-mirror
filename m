Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCFBC433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A87A661130
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhINRW7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 13:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhINRW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 13:22:58 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E49C061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 10:21:41 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y17so12942559pfl.13
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 10:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A2+V+WpsDq0T91IeugNK8MEleavV6FezSOXoP+U0kLk=;
        b=EulhF+tYaqt/v2Yb9bjR6mmHr6ioRBQnWCm2eQgIxA/U6mRzF6Y+CsiExdXnJ+Z7ER
         GE5gcuaQ/e+/qoJOO39pbO4RrpjCXChfNZt9De/ALnxHG+GFAMzTCbnUD6ZeFU/4v60q
         UiuUUVBjsMvG6kIP2SBM9VKderKXFwiWkB+aam5N9n8RiuMyFe5wM+7YL8yIje3a2KMI
         rmb1iIxdxzKMavNhDuY8LhVZhdLoK1ADvysrpzTAttqtPCFKPssocUxSX0ygvi5PeQMd
         +pxqzGqPuRR4XCmDjbPj226D/JW7FoMHxYssfhPkufvgdOg0KjRNH/EDgpHR76g4ig9I
         QWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A2+V+WpsDq0T91IeugNK8MEleavV6FezSOXoP+U0kLk=;
        b=OwpWN/hMc0TTcS9osbK3Bph6Rwn7SKrGNnkjeoSj9q0/e3Ah6Xuw9lp0/AsKCOu5xX
         y81JTDC8ZZl6DCcwSswMzF0a3a4Dpm1s0ByPY9FhpOpDlIq622c9AcPaswnbNWtODmRZ
         sy0Mcq0xTnKJ5ghl8xcz34pDcGale+BIhckkCSQ2WijyXPXfSOAcf5+WE+20BHOuTxVL
         V0VZqgxVKlZpFskGZriy7YXhaqvwLJD0oU8CikEFMefVsG6TLLS1icc5aLxaa9vUjQ5J
         flLI00ba9rbvDeqzTpUrbtpOoLwOex6BscMsIfT1lyX46swhsIHMwQ45swNk5c8pGs4g
         d/IA==
X-Gm-Message-State: AOAM5336gA9QS1X+kLWQCZZb5mpcO4I2hg1yfG4iPPOBHQig4QU5NBAK
        +/mxT3gFm0CxppaddBw20noenw==
X-Google-Smtp-Source: ABdhPJwW6m7UNwSeDua3BBto5rKDj3Kh532cEdft3ykgZiQ4y9mF43FLED7+zcc8R5zz/w1Hm4eOpQ==
X-Received: by 2002:a65:6487:: with SMTP id e7mr16267641pgv.27.1631640100137;
        Tue, 14 Sep 2021 10:21:40 -0700 (PDT)
Received: from chooglen-macbookpro.roam.corp.google.com ([2a00:79e1:abc:133:f15c:da0e:3668:c36e])
        by smtp.gmail.com with ESMTPSA id f127sm6216550pfa.25.2021.09.14.10.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 10:21:39 -0700 (PDT)
From:   Glen Choo <chooglen@google.com>
X-Google-Original-From: Glen Choo <chooglen@chooglen-macbookpro.roam.corp.google.com>
Date:   Tue, 14 Sep 2021 10:21:37 -0700
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        emilyshaffer@google.com
Subject: Re: [PATCH] MyFirstContribution: Document --range-diff option when
 writing v2
Message-ID: <YUDaIc19rhendwc9@chooglen-macbookpro.roam.corp.google.com>
References: <20210913194816.51182-1-chooglen@google.com>
 <xmqqwnnkcfz8.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwnnkcfz8.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 02:39:39PM -0700, Junio C Hamano wrote:
> What's missing here is on which branch this new description expects
> the user to work on.  From its name, I am assuming that psuh-v2 will
> be modified while leaving psuh untouched, but spell your expectation
> out.
> 
> The following review is based on the assumption that the user is
> expected to futz with psuh-v2, leaving psuh intact.  If that is not
> the case, it is a strong sign that you caused confusion on one
> reader by not spelling out your expectation.

That's fair, I was suggesting a specific workflow and should have been more
explicit.

> I do not think it is a good suggestion at all to use a new topic
> branch, especially a one that forked from the tip of the original
> submission, and work on that branch to produce the new round.  It
> would be much better to create a topic branch or a lightweight tag
> "psuh-v1" that points at the old tip and keep working on the same
> branch.  But that is a separate story.

Given that this is a "my first contribution" guide, I think it would be
beneficial to be at least mildly opinionated on the workflow. Since the
specifics of range-diff would depend on the workflow we choose to promote, it
would be nice to make it as helpful as possible the first time around.

That is to say, I'd really appreciate your thoughts on your recommended workflow
and I'd like to structure my additions around your recommendation :) What I've
documented is just my own workflow, but I'm sure you have more insight into
this area.

> But you do not necessarily have to touch all the commits during
> "rebase -i" session.  What happens when the first few commits did
> not need to be touched?
> 
> Since the --range-diff says psuh..psuh-v2, these early and
> unmodified commits are excluded from the range, no?  That would mean
> what appears to be commit #1 in the range-diff on the new side would
> not be the [PATCH 1/n] of the output, no?

Yes, good catch. This was an oversight on my part.

> Perhaps it would make it easier to manage if we used psuh-v1 as the
> anchoring point to represent where the tip of the last round was?
> 
> With something like:
> 
> 	$ git checkout psuh
> 	$ git branch psuh-v1 ;# optional -- "git tag" is also OK.
> 	... work work work with "rebase -i" ...
> 	$ git format-patch -v2 --cover-letter -o psuh/ \
> 		--range-diff master..psuh-v1 master..

Having an explicit psuh-v1 is a good idea.

> 	# ..psuh-v1 can be ..@{yesterday} or whatever reflog reference

If we make it clear that psuh-v1 is just the tip of the last round, perhaps the
readers who would do this can already infer this from context, and we can omit
the comment for brevity?

> > +Afer you run this command, `format-patch` will output the patches to the `psuh/`
> > +directory, alongside the v1 patches. That's fine, but be careful when you are
> > +ready to send them.
> 
> It is unclear what "That's fine, but" is trying to convey.

Very valid.

> I'd replace it with something like:
> 
> 	You can refer to the old v1 patches while giving the final
> 	proofreading on the v2 patches, but you now need to say "git
> 	send-email psuh/v2-*.patch" to send them out ("*.patch" would
> 	match both v1 and v2 patches).

Here, I have to confess that I'm not sure why the guide reuses the psuh/
directory. When I was first going through this, having v1 and v2 patches in the
same directory seemed like a risky default because of the inherent risk of
sending both v1 and v2 together.

I believe the unspoken intent is that having v1 patches in the same directory as
v2 patches makes it easy to refer to both versions, and in turn, this promotes
better quality discussion between v1 and v2. There might be other strong reasons
to reuse the directory, but these are not obvious to me from reading this guide
alone. It would be helpful to make these reasons explicit to the reader.
