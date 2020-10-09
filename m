Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1844CC433DF
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 21:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D804422400
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 21:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oE31qcyt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388099AbgJIVNH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 17:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgJIVNG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 17:13:06 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396A5C0613D2
        for <git@vger.kernel.org>; Fri,  9 Oct 2020 14:13:06 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x13so5273941pfa.9
        for <git@vger.kernel.org>; Fri, 09 Oct 2020 14:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6/Bk+vPjLv3YkWdS8mnfVGcZZO3D/zbNqIctYk1FJk0=;
        b=oE31qcytifewlfA4x3h/aPfR2x1SVP2jVbjME9gyqr4VQaTKr0ycR2rLt4qhLFTruj
         fpH2JEN+2TSWcjIYyLx+JU7bc9TP56rC3IM+bEs22ZJhMTEdB37oJa6jCfuhkVjO/xDd
         8EyhvPJPvg1zlBpnqRwwR/FRt7C7qz8afPl5zyQCn9GtOzrwU2ocHfJC5Xim5QRY5S4y
         G4lgiGhQajRnjSjUJYbPSn3yXVzkx5JMzfa6wKdhUA7OnaWwfZMuqw6W7PdrlkVfu8Fe
         KlD6Fj9+nTQDnwXBnP0Ge/e2GITzDjGDo9tMitAvf6bqyXO/cfKXTHAwOXTQ6c7HTpQl
         eYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6/Bk+vPjLv3YkWdS8mnfVGcZZO3D/zbNqIctYk1FJk0=;
        b=d1v+w4zHF1FcYbNc+/090PMR/LeY0h5g8JyNEaXoHXGZYeS58xgX2Q2XIBz2wB4zi8
         n7XPn25v68Ytuftj0+0KUsge0qfyOoCuwkYgS0EsmPQMwYND9bH7X9zyRvdlYef5cYqS
         8zXBz/YNsPQWiRdt5KpY16oS838S4643E9zgujxDxp9+tXYls95EMK0747vAOeH8GYNj
         7qF4ZBX/fF7/XHyf3dllCONxpluSZ4SSzAVuPYd6i4AFavqP7R8dnQrAad2qrVps2jMY
         A9IO88XajlrXQpfqDOGERPkwK7KA+O/slOt9WigDuygkPoTRcH0zH2oeoykh2DhOAvF1
         uV5w==
X-Gm-Message-State: AOAM533dKPG4OlJXQkHjiFKq2WTpHlNORsFuXnjpoLtbCXpbn0lpuis/
        HgE88ISxvHaNbJwDDH7SIpHZrQ==
X-Google-Smtp-Source: ABdhPJx4goTP3Bm/Av9r+Vy0Ua59Q/1oF/1ffP7vvI4faGyXhtd/V9ClE34YB8wGT9qqMGML3ewBHA==
X-Received: by 2002:a63:f60f:: with SMTP id m15mr4667540pgh.298.1602277985489;
        Fri, 09 Oct 2020 14:13:05 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id q65sm11297260pga.88.2020.10.09.14.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 14:13:04 -0700 (PDT)
Date:   Fri, 9 Oct 2020 14:13:00 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 02/13] reftable: define the public API
Message-ID: <20201009211300.GA2774782@google.com>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
 <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
 <5d1b946ab5473504e9599d90c0feda407a179a05.1601568663.git.gitgitgadget@gmail.com>
 <20201002035851.GB3252492@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002035851.GB3252492@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 01, 2020 at 08:58:51PM -0700, Jonathan Nieder wrote:
> 
> Hi,
> 
> Han-Wen Nienhuys wrote:
> 
> >  reftable/reftable.h | 585 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 585 insertions(+)
> >  create mode 100644 reftable/reftable.h
> 
> Adding a header in a separate patch from the implementation doesn't
> match the usual practice.  Can we add declarations in the same patch
> as the functions being declared instead?
> 
> We could still introduce the header early in its own patch if we want,
> but it would be a skeleton of a header that gets filled out by later
> patches.

To poke a little deeper into what I think Jonathan is trying to say:

When we reviewed this for review club, the general feeling was that A)
this commit structure is still pretty difficult to review, and B) we
want to make sure you aren't spending a ton of time reorganizing the
code only to find that people still don't like the structure (as may
have happened with the current iteration).

One point I think Jonathan is making is that each commit should stand
alone: compile, be tested, and do something succinct. Another point (or
maybe the same point from a different angle) is that a series of commits
should tell a progressive story. That is, something like

  add infrastructure to support reftable library
  reftable: read/write blocks
  reftable: write files
  reftable: read files
  reftable: generate binary tree from file
  ...

is much more compelling (and easier to review) than

  reftable: LICENSE
  reftable: headers
  reftable: tests
  ...

Towards the latter end of your series it seems like you started to take
that approach; but some commits, like this one (reftable: define the
public API) are not quite so. That is, this commit is hard to review
without the context of the rest of the series: I read it, I say, "well
WHY do we need these functions?", and then I cannot continue my review
of this patch until I've completed my review of the rest of the series.

Of course, taking a completed project - like your initial reftable
submission - and then chopping it up into a cute story of commits is a
pain in the ***. Doing it twice - or more - is just aggravating. So I
wonder whether we can bikeshed what story would look nice before you
even pick up your 'git rebase -i'? Doing that bikeshedding here on list
means that we also have a chance for someone to interrupt and say, "no,
that organization doesn't make sense" - or even for someone to say
"Emily, there is no need to reorganize these commits, go sit down" ;)

> All in all, I like this API.  Thanks for putting it together
> thoughtfully.
> 
> The API builds up in layers (blocks, reftables, merged reftables, etc),
> suggesting a natural division for the patch series.  I think the rest of
> the series follows that --- let's see.

Or maybe what I said runs contrary to what Jonathan was actually saying.
Please, correct me :)

 - Emily
