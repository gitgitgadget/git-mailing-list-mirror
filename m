Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF5CC43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 13:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377162AbiFPNyp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 09:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377307AbiFPNyn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 09:54:43 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D8C3A5D1
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 06:54:42 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id n28so2293877edb.9
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 06:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=y6LgYYl2irF2wLX2d+z7RK9gvu8CGJY57shuqn7TdiE=;
        b=NqhplSZ+5N8OMdD7fHSURD5K6+kLJeIhLRZhE86nZTvI3CB/nrlL2VOyuH6zHyLzTH
         BYP//inF+PHmVNrFbAqZS3BKBZM2jlIxqcfhmEm4xC4N8zKDHa/nULOVdYJd3Y0Lhq/q
         tJOuQkMHlXvXaLc95bRbspigm5QkuBMyhX6jp/irJVo2qtR+tdYMpMDyvHZPRl1kzRgx
         2xtZ/cq8HdPuZDp9HybGbCUHeXbn7OukLkn7JEC3iMF0kjTScGpvtuWVXQCQgjVVjDxP
         5gmUGUwPn+M4Zb9H5s5jWsW/hP9OUhOOmUB1gpCp+0egwUFZVXAApuacVe9maoMv9YO6
         IVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=y6LgYYl2irF2wLX2d+z7RK9gvu8CGJY57shuqn7TdiE=;
        b=Yz2IrxxcvOqydgu097HNtNE7ZrKJs4HVVBKxHYt1oIiXcNE9ie26WFjajYTCv+F/cY
         LASWOqt7pHW+a+PYqR53BIoaY40VLhXcQsrRFwul0vvptJm7mZz2RckU6UjKDa+p8q21
         N07Jaqn7RLTErGmwBdjcvCRUR9+H31LxxffWfpAGHLZ1x7pfuIWiu8sHMvD+Rw+puONv
         Q1EY37KxCJLGarK9SIL9ajk6RjZ36JgzDlnzEi5yLm3+yjaC2XdVXWHySw6tFKlrYpgp
         4BySX+6WU/eLXEYr7rfaiEKPg1EL7oJJPuM433Gj7lBk3MOB52HTi/AGY8VgaA+jM5MZ
         z/MQ==
X-Gm-Message-State: AJIora/TJqmtyoqIrM0MPNKbM1iQ9Nzx1sLSec49tK3ESFPd3ZnYg+I7
        dsTAs93ApOZLQGoNrjb4Nck7/wYpm0s=
X-Google-Smtp-Source: AGRyM1syqj5/5O9Bz4ykgmmpg6fLm8+goQ+jHY8RscJCs7t8rA67ZLkC56chTwemu3LRr/H4G8L5xw==
X-Received: by 2002:a05:6402:1f82:b0:42f:c541:4fd1 with SMTP id c2-20020a0564021f8200b0042fc5414fd1mr6600950edc.172.1655387680685;
        Thu, 16 Jun 2022 06:54:40 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g10-20020a056402424a00b00435390befe2sm1054054edb.58.2022.06.16.06.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 06:54:39 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o1pxG-0015NV-VM;
        Thu, 16 Jun 2022 15:54:38 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>, Kyle Zhao <kylezhao@tencent.com>
Subject: Re: [PATCH v2] send-pack.c: add config push.useBitmaps
Date:   Thu, 16 Jun 2022 15:38:36 +0200
References: <pull.1263.git.1655291320433.gitgitgadget@gmail.com>
 <pull.1263.v2.git.1655350617442.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1263.v2.git.1655350617442.gitgitgadget@gmail.com>
Message-ID: <220616.86fsk4ww69.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 16 2022, Kyle Zhao via GitGitGadget wrote:

> From: Kyle Zhao <kylezhao@tencent.com>
>
> This allows you to disable bitmaps for "git push". Default is false.
>
> Reachability bitmaps are designed to speed up the "counting objects"
> phase of generating a pack during a clone or fetch. They are not
> optimized for Git clients sending a small topic branch via "git push".
> In some cases (see [1]), using reachability bitmaps during "git push"
> can cause significant performance regressions.
>
> Add a new "push.useBitmaps" config option to disable reachability
> bitmaps during "git push". This allows reachability bitmaps to still
> be used in other areas, such as "git rev-list --use-bitmap-index".
>
> [1]: https://lore.kernel.org/git/87zhoz8b9o.fsf@evledraar.gmail.com/
> [...]
> +	mk_test testrepo heads/main &&
> +	git checkout main &&
> +	GIT_TRACE2_EVENT="$PWD/default" \
> +	git push testrepo main:test &&
> +	test_subcommand git pack-objects --all-progress-implied --revs --stdout \
> +	--thin --delta-base-offset -q --no-use-bitmap-index <default &&

Nit: We tend to indent these ase we wrap, so e.g.:

	test_subcommand git ... \
		--thin --delta [...]

The rest all looks good as far as the diff goes, if what we want to do
is to disable this by default, and this isn't worth a re-roll in itself.

But I still think that completely disabling bitmaps might be premature
here, especially per Taylor's comment on v1 (which I understand to mean
that they should help some of the time, even with push).

And since this is linking to that old thread I started in 2019 I really
think the commit message should be exploring and justifying why this
might be slower in all cases, or at least a sufficient number of cases
to flip the default.

if it's not are we throwing out a generally useful optimization (by
default) due to some edge cases we've found?

E.g. have you tried to follow-up on this comment by Jeff King?
https://lore.kernel.org/git/20190523113031.GA17448@sigill.intra.peff.net/

At the time I didn't, because as noted in a follow-up I'd lost my test
case by the time I read that, but it seems you haven't, and have a
current test case.

If you apply that patch on that old git version at the time (as it
probably won't apply cleanly), does it make a difference for your case?

To be clear I'm *not* confident that this isn't the right thing to do as
far as the diff is concerned. But I *am* confident that the proposed
commit message isn't selling me on the idea.

I think a really good start would be to come up with some benchmarks for
a few common cases, e.g. how do bitmaps do if we have a big repo but few
refs, how about a lot of refs? Does their stale-ness make a difference
or not (per previous discussions) etc. etc.

Or, if you don't have time for any of that I think a good change for now
would be to add the flag, but not flip the default, and say "we don't
have enough data to say if bitmaps are overall worse for pushes, but
here's an opt-opt".

But the change as it stands is effectively saying "bitmaps on push
hinder more than they help, and turning them on for push was a mistake".

Maybe that's true, but I don't think we've got any data to support
that. Even though I've got one of those anecdotes (and from occasional
investigations of slow "git push" I'm pretty sure this would help my
use-cases more than it would harm them) the plural of anecdote isn't
data.

I've only personally run into this with repos with a large number (>30k
at least) number of refs, and where the bitmaps were in some state of
staleness (this usually being my working copy, where I rely on "git gc
--auto").
