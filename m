Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81EAEB64DD
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 10:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbjGMKz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 06:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjGMKzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 06:55:25 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343D8212E
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 03:55:23 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-992b66e5affso88489066b.3
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 03:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=akorzy-net.20221208.gappssmtp.com; s=20221208; t=1689245721; x=1691837721;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ehPum1BByH/e0veyWYVeJ7d1CBCwHxjBvqNiJ9yilb0=;
        b=eSXm2Vz6DZOGKxuYBo9MFGSPgKqGdSRjO7qREutlRE+P83lpu5i1tLTSJw4XmR5r1Q
         QaE5ihCOeruntt5kZzeG33W5RYoySH0vjglCch6enIV+9agPFEVYj+LGk+mbhdCIrU9K
         /RjDaxfaA97RuzWbvgGUDq2Z4th3p9TODcPufcuZoHKsI6bwLW/4YG8YtmszYKI2/B7U
         u2NqsNCn9XdDK3Vgyimwy6N25+njRUh51NWbJmHrzlWEqbrlw+QMcqfCcdZUZriRtkox
         vstJW7lBN373tASzHzcri6iaMphY8kLMVsSwhabolnRxpU4iY3ZaEXLZ/oelK0n7mxJV
         Qshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689245721; x=1691837721;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehPum1BByH/e0veyWYVeJ7d1CBCwHxjBvqNiJ9yilb0=;
        b=U/eRgucS23pZSuJxhbPZXy1+RT7LdfZeOys1JdkZF9yIr794rl5PtP1A8wWNKY6ehv
         csgyTqzBGbm+3ZQC71xxqbpRzYi6KKa50IeVfL8rKG4x8GdesytQ6YdXwVfvP/tsGuLI
         kuU8S8QwhZxg4KJkNht6oIrWyVvT/19lAluAQoq87Zjk21/0bSYaCuEeYushMecRqTTe
         f/PoKim5pUAzc2/ER/zX0EHE2Ye25U25W0EQuB/xO1GBMKM319Yy7unb5mBXBJknGfNB
         iDrToriv91bbXUa6jhgn2CSuUTKf9jsF7bslcsa6hjpfHWZmN30I8aBmFOKwLIxGDJCB
         5ybw==
X-Gm-Message-State: ABy/qLaZ1F/DqKSVEbOfJfBNNsrDMYUGJl8ySW04sArv6OpfxZuTO+jO
        FDs4ym/SoTlMcmbx0PhLSZa0guVkRkiMvzzdqok=
X-Google-Smtp-Source: APBJJlHDHWW6yZTPp6MR+t6eEA38NFetlIFt/UzT1joyFY0DzsvbkRlR7PqWqIfpqizJAGNDSCu+Fg==
X-Received: by 2002:a17:906:2091:b0:987:6372:c31f with SMTP id 17-20020a170906209100b009876372c31fmr1122957ejq.37.1689245720949;
        Thu, 13 Jul 2023 03:55:20 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id h14-20020a170906110e00b009829dc0f2a0sm3885292eja.111.2023.07.13.03.55.19
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 03:55:20 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-992ca792065so88566166b.2
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 03:55:19 -0700 (PDT)
X-Received: by 2002:a17:906:ae12:b0:98e:37fe:691b with SMTP id
 le18-20020a170906ae1200b0098e37fe691bmr946239ejb.34.1689245719144; Thu, 13
 Jul 2023 03:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <CADWu+UnThMq2M+kCMADP9rZ5c6nL+Hz+z0-OqRnuG2oYVzbvWw@mail.gmail.com>
 <xmqqwmz6z8j1.fsf@gitster.g>
In-Reply-To: <xmqqwmz6z8j1.fsf@gitster.g>
Reply-To: ak@akorzy.net
From:   =?UTF-8?Q?Aleksander_Korzy=C5=84ski?= <ak@akorzy.net>
Date:   Thu, 13 Jul 2023 12:55:07 +0200
X-Gmail-Original-Message-ID: <CADWu+Ukgnc241jsYwqorAJ20qeGvqYvyqRbDa4CFXXjiEeDOkw@mail.gmail.com>
Message-ID: <CADWu+Ukgnc241jsYwqorAJ20qeGvqYvyqRbDa4CFXXjiEeDOkw@mail.gmail.com>
Subject: Re: Beyond Merge and Rebase: The Upstream Import Approach in Git
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Junio,

Thanks for the insightful response.

Firstly, let me add some context, which will be helpful for responding
to your comments. This strategy was created at a large organization,
where the "main" branch was used as the integration branch for changes
made within the organization and for the organization. So whenever an
employee needed to make a change, they would start a topic branch off
"main" and the topic branch would be later merged or rebased onto
"main". When the employee was ready to contribute the change upstream,
they would only present the topic branch upstream. The "main" branch
was never presented upstream. Release branches were created from the
"main" branch to work on releases to production at the organization.
Tags were created on the release branches to mark stable and tested
versions. Deployments to production were made from the tagged
versions.

The rest of my response is inline:

> So from the upstream point of view,
> throwing a pull request for c" (not the original a, b and c) would
> be a reasonable way to finalize your work.  That way, what you are
> offering to the upstream is not an ancient original commits (i.e. a,
> b, and c) that you haven't been using at all once you created S and
> T.

Yes, this is how it's intended to be used.

> it is unclear what the eventual
> presentation to and adoption by the upstream would look like.  As
> an upstream maintainer, for example, I do not want to merge S
> above to the upstream tree.

Presentation to upstream would only involve submitting a pull request
for c". Merge S would not be presented to upstream.

> how does this help those who have older versions of your
> work, *and* built their own changes on top?  They would not just
> need to update their remote-tracking branch that has your older
> version of the work to the latest, but also rebase their work on
> top.
>
>     o---o---o---o---o  upstream/main
>          \           \
>           \           a'---b'---c'---d'---e'
>            \                     \
>             a---b---c-------------S  main
>                      \
>                       d---e  your coworker

The coworker would either merge their topic branch to "main" or rebase
it on top of "main":

    o---o---o---o---o  upstream/main
         \           \
          \           a'---b'---c'
           \                     \
            a---b---c-------------S---M  main
                     \               /
                      d-------------e


    o---o---o---o---o  upstream/main
         \           \
          \           a'---b'---c'
           \                     \
            a---b---c-------------S---d'---e'  main

> However, once you keep going this way for several rounds, would
> the result really be much better than bushy history with full of
> reverse merges from upstream?   Would it help to add new history
> simplification mechanisms and options to help visualize the
> history, or do we already have necessary support (e.g. if the
> convention for these "merge to cauterize the older versions of
> history with the newly rebased history" S and T merges is to
> record the rebased history as the first-parent, then "git log
> --first-parent upstream/main..main" should be sufficient).

Good point. I believe the proposed method has two advantages over
using "git log --first-parent":

* consider the scenario where the cauterizing merge is not the only
merge in the "main" branch - a topic branch from a coworker has also
been merged to "main". In that case, "git log --first-parent" would
not show the commits from the merged topic branch.

* a user unfamiliar with the command-line interface can use a history
visualization tool (such as gitk or tig) to obtain a clear view of the
differences between the last imported version of upstream and the tip
of "main".

> The users would benefit to have an easy way, given only T or S, to
> get range-diff among (a,b,c) and (a',b',c') and (a",b",c").

I like that idea. It would be great to have a simple git command to
display such a range-diff. The command would have to correctly
identify the commits.

--
Best regards,
Aleksander Korzynski
