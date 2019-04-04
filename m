Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC69D20248
	for <e@80x24.org>; Thu,  4 Apr 2019 21:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbfDDVuZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 17:50:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37944 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730079AbfDDVuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 17:50:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so5628602wro.5
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 14:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oNSOJpoLOkf+B70Hd5I0C5O8aGZryviZ8NLrHIHlWcc=;
        b=aWb/BRgxYhUfrfr7gxQGL7ZbWvdbbbL7uh+DXe5loshe4iz4w+LVNmzl/IN+SChIaO
         fbBKk90M5ZaKcHfDTpiVSHfl1WP5wAMq6NxU9IZd3fev9+MlDgyYAI/Xj8UwEB43mVrM
         BqGtJ3Q8zmqFXhk/4CxACZPtd8Oyg8pAEszCNUXZ73+wO9KbyKuAPB/UsM+L8JAoe01p
         Cr0Bnyd12lX1DSkLCAgQbi+eao9QgFWaTZzZ4FsmYyvH2+JvFo4gUjUg4X0+qnj9XB6T
         xcRBLjcNIPCFb3A2wYfwpRb46WfodL8Vw9kfORQgZYnpk4ekosR2PIOdpo92VdbhxiKL
         GToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oNSOJpoLOkf+B70Hd5I0C5O8aGZryviZ8NLrHIHlWcc=;
        b=XTBKZqbkBldJ4RrqOLEtnUiMZKhXYHyWted0oucF1XQyiRhXRGqIhac5sKw3WUqgJ3
         +Yebjh4bYMHN+FSVMoKbSBP3niH7GpQ1sLCOHOidT+WK2vOsFGAtBcOVoVkMhzPd2/1k
         BiHQlPV3lw9XrlSIdBueMN6WdDq0eqhJScC9GUNj5/wb6DYKZ+w7LJNXjOdCwPd3hpch
         mJcPX8gYoXhOdDy7ldO0bCKfjAC525Mln2tnZJKVkAAM8Z8Lw+jaH5Veuta7QwtozwJn
         o65/BIelh30gxSCZHIFxkM4bika9UmFBS+u414nrJ7fVtjykJ9+6jI0BU4to1NFaFwYz
         bCkA==
X-Gm-Message-State: APjAAAVZOLkfNZz35R6lMJ1gWloFocOeQZRaAbxiUu5bcD8PGT/1iXr3
        mrI0kAVqOg4LiM/8FbzqGFg=
X-Google-Smtp-Source: APXvYqw9FxMtqXVcTuyICw9L8yKgeD4Fhhldc+kEhBBpmD7hzda6TvTWhq0xFe6+jC7DgtKj52S1aA==
X-Received: by 2002:adf:fe4d:: with SMTP id m13mr5920560wrs.267.1554414622681;
        Thu, 04 Apr 2019 14:50:22 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id w18sm30941370wru.24.2019.04.04.14.50.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 14:50:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2.5 2/2] tag: prevent nested tags
References: <1bd9ee28bc8726490ec0a93286056beeb147fc49.1554183429.git.liu.denton@gmail.com>
        <20190402230345.GA5004@dev-l>
        <xmqqzhp7sfw4.fsf@gitster-ct.c.googlers.com>
        <xmqq7ecbscay.fsf@gitster-ct.c.googlers.com>
        <CAHd499C9g3yPvs=wuaSuLrW=R09yjT5DcKHfpH9=PYYkAcpuhg@mail.gmail.com>
        <xmqqbm1mf74c.fsf@gitster-ct.c.googlers.com>
        <CAHd499Dr5sjzFCFYvkwcS0WOo0W51_RyL7nLAg_MaGeFy5eQKQ@mail.gmail.com>
Date:   Fri, 05 Apr 2019 06:50:20 +0900
In-Reply-To: <CAHd499Dr5sjzFCFYvkwcS0WOo0W51_RyL7nLAg_MaGeFy5eQKQ@mail.gmail.com>
        (Robert Dailey's message of "Thu, 4 Apr 2019 08:47:43 -0500")
Message-ID: <xmqqimvte8yr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Dailey <rcdailey.lists@gmail.com> writes:

> It might be fine within the realm of git itself, because git knows how
> to deal with them by peeling, as you say, but there are 3 reasons I
> dislike that this is allowed:

That sounds as if you have tools that forgets to peel when it should
in mind.  Isn't that what you should be looking into fixing?  After
all, tools that aim to work with Git should strive to come close to
"within the realm of git itsef" in the modern world.

> 1. The intent by the user was to create a tag pointing to the commit
> that another tag points to.

You make it sound as if you are convinced that is the truth.  I am
not.  If I want to tag the commit pointed at by tag v1.0, I'd say I
want to tag "v1.0^0", because otherwise there won't be a way to say

    $ git tag -s -m "i am aware of this tag" initial v1.0

i.e. making a tag that points at a tag.  So I take the lack of ^0
(or ^{commit}) peeling an explicit sign that shows the intent by the
user (well, those who know the tool, anyway) is clearly to create a
tag pointing to that tag.  In other words, peeling at the tagging
time is wrong, and rejecting tag creation is also wrong.

> 2. When users on my team do a `git show tag`, they see 2 descriptions
> and 2 tags. This creates a LOT of confusion.

So what?  Not everybody will forever stay to be a newbie ;-) 

As I said, an opt-in tag.allowCommitOnly is fine.  That would train
their fingers to peel with ^{commit} when they want to tag a commit.
An opt-in tag.autoPeelTags might also be fine, even though that
would not help training their fingers (so they will have to be
prepared for the same "confusion" on a fresh machine)

When the command line clearly tells us that the user wants to tag a
tag, we should not get overly "smart" and refuse to create a tag of
a tag, unless the user tells us otherwise with some means.

> 3. Even if Git internally handles peeling tags, external 3rd party
> tooling may not. As I mentioned in another thread, `git lfs migrate`
> was not programmed to peel tags. I reported the issue here:

That is good, and it is the right way.  After all, external 3rd
party tooling may tag a tag even after we castrate "git tag" to be
incapable of doing so, so a bug like the one you are helping to fix
in lfs needs to be fixed anyway.  In other words, thats the only
sensible way forward when you care about the entire Git ecosystem,
not just the main/reference implementation we work on here.

