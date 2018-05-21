Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 419621F51C
	for <e@80x24.org>; Mon, 21 May 2018 22:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751039AbeEUW5U (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 18:57:20 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:43425 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbeEUW5T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 18:57:19 -0400
Received: by mail-yw0-f196.google.com with SMTP id r202-v6so4983458ywg.10
        for <git@vger.kernel.org>; Mon, 21 May 2018 15:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eZjvHNjoz/T22P5vBSec1PaDHvD4RTfLazdfP5PRZyk=;
        b=XWBcvr983mLdr+TB9pAFjw5ia7mJsQMKsbK/UpQBNdfyAcgV3P8HPBxe3Df/d7wr90
         zRmHfiAPKvp6jKe4Wcu0ooE509zwS/cxEDe7rhko2cycIlnDClboiR60MXi0eEWW2uRM
         G/VadiOzdf9srcu4HPdDK+ieRwRpP782H1HUWgI1xohaadFtyIlchs32SU2jJItiLZTF
         O1qYG1xRIikfxfUzwV8Ims5lMWfPD1IHcA7k8ks093G4nkQ7jYFhS2nAhPPIpoq+DT3K
         po+9gptvNtBlgHRM9HKGMEM+ppKwtnFY7UMNeKhib4mZpN2ds0Hs8t1TPmOaw+i3d8Qp
         yXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eZjvHNjoz/T22P5vBSec1PaDHvD4RTfLazdfP5PRZyk=;
        b=mq8ukoei8OMZMGsVZIKETz/od6siIcKv55iZtBeZWJd6Gy3z6jPjrH8wtmc03zTBvR
         068V6Dt1rs1BIVVwYzNDghTJPhOKgumNE2IMzChwAzSoEXdSmbFyAGaztHA2drX4Ifs6
         Hl3xmaV1MiLqp5HgYYdZqn5J7ECZGk056RNqAROoXLT5amcOHpFGV6oyyaobnydYZeRq
         j7plU95olb+MUHsQvbGe4wKDi4WpM5mOrAEs34IEEF1qqKklUmFjb2tmk6wegQuWIjYk
         Knv6yY3H7lDFYYV9h3gfdB6zD/8auo05pUaY6+AUPQfGdVHU7ERStY5Iw5nNhpj4ywyN
         asmw==
X-Gm-Message-State: ALKqPwf/TO4/2vXzoASxYwdCbNwwG4LU5DpDOY/0Xqrp7ss+Hv7LrFco
        s/EkscMzYveH/lw0ECWZEkXXIiCiSNQwjGSj8W0F09R84ac=
X-Google-Smtp-Source: AB8JxZpui84vkT5hUysnPv6EitbWqkXCJIs3di7zxaoUHmdS+MESlFytBPLmeYWBrx4dXBIUP+J3hMIvMmWtJ023L30=
X-Received: by 2002:a81:b205:: with SMTP id q5-v6mr11100509ywh.414.1526943438878;
 Mon, 21 May 2018 15:57:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Mon, 21 May 2018 15:57:18 -0700 (PDT)
In-Reply-To: <20180521204340.260572-1-jonathantanmy@google.com>
References: <20180521204340.260572-1-jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 May 2018 15:57:18 -0700
Message-ID: <CAGZ79kb96Fxf1OBbnqmAtAm_EA5y9+0NKcNqhKjXhavWe6WzWA@mail.gmail.com>
Subject: Re: [RFC PATCH] fetch-pack: space out sent "haves" in negotiation
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Mon, May 21, 2018 at 1:43 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> I was thinking about fetch negotiation in some non-ideal situations
> (specifically, when the client repo contains two or more independent
> branches that meet only somewhere far in the past) and thought about
> skipping over intermediate commits, using exponentially larger skips as
> we proceed, when generating "have" lines. This is in the hope of
> reducing the bandwidth and roundtrips needed when fetching, and does not
> require a modification to the server.

In an ideal world, the server and client would both estimate the potential
reduction of the packfile to send, and base the decision if to continue
negotiating on the trade off if the packfile reduction savings are greater
than the cost of negotiation (in terms of bandwidth or time).
(e.g. the server could keep track of the "potential largest packfile to
sent" as well as the "potential smallest packfile to sent" given the
state of negotiation. And as soon as the difference between those
two packs is smaller than the size of one round of negotiation,
it is better to stop and just sent the large file).

You state that you do not want to change the server side, and stick to
the current protocol, which makes this ideal world scenario moot, but
shifts the problem to "picking haves more intelligently".

> I'm not sure if this is the best way,

I think it is the best for a short term gain, as the picking algorithm is
not part of the protocol, so it can be easily extended/reverted/improved
as we go. So I would continue this way.

> (1) The implementation that I have
>
> This patch contains some drop-in code that passes all existing tests,
> but the new negotiation algorithm is not tested.
>
> To mitigate the effect of skipping, I included functionality wherein
> the client will retry the commits in a skip if the server ACKs the
> destination of the skip, but this is currently imperfect - in
> particular, the server might end the negotiation early, and the commits
> retried in my current implementation are a superset due to the fact that
> I didn't store the commits in the skip.

So we start with exponential hops, fall back to linear probing and then
"make off by one errors" in the linear probes?

> (2) Possible future work for my implementation
>
> Since each sent commit maintains pointers to sent descendants and sent
> ancestors (strictly speaking, only the "close" ones - to find all of
> them, you need the transitive closure), this can be used for some sort
> of error correction when, during a stateless RPC negotiation, the server
> (which may be a group of eventually consistent servers behind a load
> balancer) reports that it no longer has a commit that it said it had.
> For example, we could in this case mark that commit as "they_have=NO"
> and for all its closest ancestors, set it to "they_have=YES" unless they
> in turn have a descendant with "they_have=YES" or
> "they_have=HAVE_DESCENDANT".
>
> (3) Other ways of improving negotiation
>
> If we're prepared to commit-walk a significant part of the entire local
> repo (as we are, in the situation I described in the first paragraph),

> and if we have access to corresponding remote-tracking information,

This is a dangerous assumption, as not everyone is having a 1:1 relationship
with their remote server (for e.g. code review), but there are these triangle
workflows in the kernel community for example, where you push in one
remote direction and (re-)obtain the history merged into the bigger picture
from another remote. And these two remotes are not special to each other
on the client side.

>  fetch-negotiator.c | 309 +++++++++++++++++++++++++++++++++++++++++++++
>  fetch-negotiator.h |  40 ++++++

This patch is moving the algorithm driving the selection of new
commits to pick to
a new file, but there is no new algorithm, yet?
As hinted at from (1), this is smarter than what we did before by
picking commits
non-linearly but with some sort of exponential back off, how does it end the
exponential phase?

The way forward out of RFC state, might be to separate the introduction of a new
improved algorithm and the refactoring. So first move code literally into the
fetch-negotiator file, and then add improvements in there, or is it
just not worth
the refactoring and directly put in the new algorithm?

Another use case we discussed was "open-ended bisection", where you know
you are in a bad state and "once upon a time it worked", and now you are tasked
to find the offending commit. To find such a commit, you probably
would also start
with such an exponential back off until you run into a "good frontier"
of commits
and then use conventional bisect to narrow down the exact commit.


> +enum they_have {
> +       /*
> +        * We do not know if the server has this commit, or we know that the
> +        * server does not have this commit.
> +        */
> +       NO,
> +
> +       /*
> +        * The server has this commit, and we do not know (or did not keep
> +        * track of) whether it has any of its descendants.
> +        */
> +       YES,
> +
> +       /*
> +        * The server has at least one of this commit's descendants, and that
> +        * descendant is marked with YES. When resending "have" lines, we do
> +        * not need to resend this commit, because doing so is redundant.
> +        */
> +       HAVE_DESCENDANT
> +};

Thanks for the docs!

> diff --git a/fetch-negotiator.h b/fetch-negotiator.h
> new file mode 100644
> index 0000000000..c51d52a0d2
> --- /dev/null
> +++ b/fetch-negotiator.h
> @@ -0,0 +1,40 @@
> +#ifndef FETCH_NEGOTIATOR_H
> +#define FETCH_NEGOTIATOR_H
> +
> +#include "prio-queue.h"
> +
> +struct sent_commit;
> +
> +struct fetch_negotiator {
> +       struct sent_commit **sent_commits;
> +       size_t sent_commit_nr, sent_commit_alloc;
> +       struct prio_queue candidates;
> +};

Maybe we can just declare the struct fetch_negotiator here and not
define it, such that nobody outside the actual implementation tries
to access its internals?

> +
> +void fetch_negotiator_init(struct fetch_negotiator *n, struct commit **tips,
> +                          int tip_nr);
> +
> +struct commit *fetch_negotiator_next(struct fetch_negotiator *n);
> +
> +/*
> + * Indicate that the server has this commit. The commits passed to this function
> + * should be in order of their return from fetch_negotiator_next().
> + *
> + * Invocations of this function on the same commit after the first time have no
> + * effect.
> + */
> +void fetch_negotiator_ack(struct fetch_negotiator *n,
> +                         const struct commit *commit);
> +
> +/*
> + * Iterate through the commits invoked with fetch_negotiator_ack. The negotiator
> + * makes an effort to remove redundant commits from the list.
> + *
> + * This is useful for stateless connections, in which information about what the
> + * client knows needs to be replayed in every request.

So even if we do not use the skip commit logic, this would be a benefit for any
http(-v0) and v2 users of the protocol?

Thanks,
Stefan
