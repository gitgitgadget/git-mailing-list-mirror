Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEB0C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 23:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242150AbiBWXXP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 18:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235909AbiBWXXO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 18:23:14 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7774BFF5
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 15:22:45 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id lw4so555259ejb.12
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 15:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=lRN9KIebP/5qwnnrtyB+B9QO7MhXqlJdcIHJBEAwx7A=;
        b=LK7Fe+kllHzG3equKveU7/3uaWJEDyAGVWAEEs+S9GNuL1L/7K1T+TQeY6Hyk4F95w
         HGKRmy9WKqDnwUV3lh3AWKXWXP+keP3PA6csuBhwat+KJfj2pfJyZ9zGEIdg1mRyaCZL
         xqoAskBRjM7NMJm8Afp4uIQE9Q7yaHC8y5rFvRZwpEuZy1XD/Y0vFTr7KMowzYn6Xkry
         /lhpkJ0R/GlZuPHyMLadmw/20l4MKgxd5ZKO3K/L/IuHVRLVk50FKhsrKkdH6tiomIXK
         E6UaeL3fKJUq1Dweh63JAPUqpeqj9WtjRKuLw6Et/wWMMaBGqvlw+ZC/aCzIqv7s/E1B
         W2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=lRN9KIebP/5qwnnrtyB+B9QO7MhXqlJdcIHJBEAwx7A=;
        b=ueGHjuT2I90234s0F4HJtOyDMDx36H7oE9hd6s+1O9Mk4VaCt4EGN+UqAJn6sEe5wi
         rg81deWlwjUGk2vg2CbsemCf57R4a4YTviip4oCg5rhSGffyIl3cZFowDJe0vfQjSSXJ
         2llWJ5ImJmnQSodskOunplU6WGWD+eVo3QlJY+cvtpggMbeyFXmNmR35mwTD+fsy6iRL
         2Lqt7WFtnws7Xt3cTIl7Gsz1VZZktEhV3nln30X3kWW4VMLD3MVrpK0HZR+ApEgjspFR
         tG1atDdUrEq9ElvzhlFawy83kos1ozYdLQVj4ZmUFQU7fUp0bcYAmdtdxdDGvJiHmUaf
         +73Q==
X-Gm-Message-State: AOAM530rfn0T86Vmgx1bcH2GLHo9gRM5nW0pwqmA3NsKqhmG2znHw7pM
        uwOELG9DwCf8lXDtQV+MhNyFag7krDo=
X-Google-Smtp-Source: ABdhPJw3EgIMVzv5GLG9KJKRtMQycpiZSgIiznOtkxEzCzQITClzcOQQ0CbMCZu8dwcCAPXLg7MH+w==
X-Received: by 2002:a17:907:920d:b0:6ce:a6fc:1ad8 with SMTP id ka13-20020a170907920d00b006cea6fc1ad8mr36616ejb.448.1645658563411;
        Wed, 23 Feb 2022 15:22:43 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id oz23sm430537ejb.174.2022.02.23.15.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 15:22:42 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nN0y2-00065k-6k;
        Thu, 24 Feb 2022 00:22:42 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH 00/25] [RFC] Bundle URIs
Date:   Wed, 23 Feb 2022 23:17:22 +0100
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
Message-ID: <220224.86czjdb22l.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 23 2022, Derrick Stolee via GitGitGadget wrote:

[Note: The E-Mail address you CC'd for me (presumably, dropped in this
reply) is not my E-Mail address, this one is]

[Also CC-ing some people who have expressed interest in this are, and
would probably like to be kept in the loop going forward]

> There have been several suggestions to improve Git clone speeds and
> reliability by supplementing the Git protocol with static content. The
> Packfile URI [0] feature lets the Git response include URIs that point to
> packfiles that the client must download to complete the request.
>
> Last year, =C3=86var suggested using bundles instead of packfiles [1] [2]=
. This
> design has the same benefits to the packfile URI feature because it offlo=
ads
> most object downloads to static content fetches. The main advantage over
> packfile URIs is that the remote Git server does not need to know what is=
 in
> those bundles. The Git client tells the server what it downloaded during =
the
> fetch negotiation afterwards. This includes any chance that the client did
> not have access to those bundles or otherwise failed to access them. I
> agreed that this was a much more desirable way to serve static content, b=
ut
> had concerns about the flexibility of that design [3]. I have not heard m=
ore
> on the topic since October, so I started investigating this idea myself in
> December, resulting in this RFC.

This timing is both quite fortunate & unfortunate for me, since I'd been
blocked / waiting on various things until very recently to submit a
non-RFC re-roll of (a larger version of) that series you mentioned from
October.

I guess the good news is that we'll have at least one guaranteed very
interested reviewer for each other's patches, and that the design that
makes it into git.git in the end will definitely be well hashed out :)

I won't be able to review this in any detail right at this hour, but
will be doing so. I'd also like to submit what I've got in some form
soon for hashing the two out.

It will be some 50+ patches on the ML in total though related to this
topic, so I think the two of us coming up with some way to manage all of
that for both ourselves & others would be nice. Perhaps we could also
have an off-list (video) chat in real time to clarify/discuss various
thing related to this.

Having said that, basically:

> I focused on maximizing flexibility for the service that organizes and
> serves bundles. This includes:
>
>  * Bundle URIs work for full and partial clones.
>
>  * Bundle URIs can assist with git fetch in addition to git clone.
>
>  * Users can set up bundle servers independent of the remote Git server if
>    they specify the bundle URI via a --bundle-uri argument.
>
> This series is based on the recently-submitted series that adds object
> filters to bundles [4]. There is a slight adjacent-line-add conflict with
> js/apply-partial-clone-filters-recursively, but that is in the last few
> patches, so it will be easy to rebase by the time we have a fully-reviewa=
ble
> patch series for those steps.
>
> The general breakdown is as follows:
>
>  * Patch 1 adds documentation for the feature in its entirety.
>
>  * Patches 2-14 add the ability to run =E2=80=98git clone --bundle-uri=3D=
=E2=80=99
>
>  * Patches 15-17 add bundle fetches to =E2=80=98git fetch=E2=80=99 calls
>
>  * Patches 18-25 add a new =E2=80=98features=E2=80=99 capability that all=
ows a server to
>    advertise bundle URIs (and in the future, other features).
>
> I consider the patches in their current form to be =E2=80=9CRFC quality=
=E2=80=9D. There are
> multiple places where tests are missing or special cases are not checked.
> The goal for this RFC is to seek feedback on the high-level ideas before
> committing to the deep work of creating mergeable patches.

Having skimmed through all of this a *very rough* overview of what
you've got here & the direction I chose to go in is:

1. I didn't go for an initial step of teaching "git bundle" any direct
   remote operation, rather it's straight to  the protocol v2 bits etc.

   I don't think there's anything wrong with that, but didn't see much
   point in teaching  "git bundle" to do that when the eventual state is
   to have "git fetch" do so anyway.

   But in either case the "fetch" parts are either a thin wrapper for
   "git bundle fetch", or a "git bundle fetch/unbundle" is a thin
   equivalent to "init" "fetch" (with bundle-uri) + "unbundle".

2. By far the main difference is that you're heavily leaning on a TOC
   format which encodes certain assumptions that aren't true of
   clones/fetches in general (but probably are for most fetches), whereas
   my design (as we previously discussed) leans entirely on the client
   making sense of the bundle header & content itself.

   E.g. you have a "bundle.tableOfContents.forFetch", but e.g. if you've
   got a git.git clone of "master" and want to:

       git fetch origin refs/heads/todo:todo

   The assumption that we can cleanly separate "clone" from "fetch" breaks
   down.

   I.e. such a thing needs to assume that "clone" implies "you have
   most of the objects you need already" and that "fetch" means "..an
   incremental update thereof", doesn't it?

   Whereas I think (but we'll hash that out) that having a client fetch the
   bundle header and working that out via current reachability checks will
   be just as fast/faster, and such a thing is definitely more
   general/applicable to all sorts/types of fetches.

   (A TOC mechanism might still be good/valuable, but I hope it can be a
   cheap/discardable way to simply cache those bundle headers, or serve
   them up all at once)

3. Ditto "bundle.<id>.timestamp" in the design (presumably assumes not-rewo=
und
   histories), and "requires" (can also currently be inferred from bundle
   headers).

4. I still need to go over your just-submitted "bundle filters"
   (https://lore.kernel.org/git/pull.1159.git.1645638911.gitgitgadget@gmail=
.com/)
   in detail but by adding a @filter to the file format (good!) presumably =
the
   "bundle.<id>.filter" amounts to a cache of the headers (which was 100% i=
n line
   with any design I had for such extra information associated with a bundl=
e).

In (partial) summary: I really want to lean more heavily into the
distributed nature of git in that a "bundle clone" be no more special
than the same operation performed locally where "clone/fetch" is
pointed-to a directory containing X number of local bundles, and has to
make sense of whether those help with the clone/fetch operation. I.e. by
parsing their headers & comparing that to the ref advertisement.

Maybe a meta-format TOC will be needed eventually, and I'm not against
such a thing.

I'd just like to make sure we wouldn't add such a thing as a premature
optimization or something that would needlessly complicate the
design. In particular (quoting from a part of 01/25:
=20=20=20=20
    +A further optimization is that the client can avoid downloading any
    +bundles if their timestamps are not larger than the stored timestamp.
    +After fetching new bundles, this local timestamp value is updated.

Such caching seems sensible, but to me seems basically redundant to what
you'd get by doing the same with just:

 * A set of dumb bundle files in a directory on a webserver
 * Having unique names for each of those (e.g. naming them
   https://<host>/<hash-of-content>.bundle instead of
   https://<host>/weekly.bundle)
 * Since the content wouldn't change (HTTP headers indicating caching
   forever) a client would have downloaded say the last 6 of your set of
   7 "daily" rotating bundles already, and we'd locally cache their
   entire header, not just a timestamp.

I.e. I think you'd get the same reduction in requests and more from
that. I.e. (to go back to the earlier example) of:

    git fetch origin refs/heads/todo:todo

You'd get the tip of "ls-refs" for TODO, and locally discover that one
of the 6 "daily" bundles whose headers (but not necessarily content) you
already downloaded had that advertised OID, and grab it from there.

The critical difference being that such an arrangement would not be
assuming linear history/additive only (i.e. only fast-forward) which the
"forFetch" + "timestamp" surely does.

And, I think we'll be much better off both in the short and long term by
heavily leaning into HTTP caching features and things like request
pipelining + range requests than a custom meta-index format.

IOW is a TOC format needed if we assume for a moment for the sake of
argument that for a given repository the say 100 bundles you'd
potentially serve up aren't remote at all, but something you've got
mmap()'d and can inspect the bundle headers for and compare with the
remote "ls-refs"?

Because if that's the case we could basically get to the same place via
HTTP caching features, and doing it that way has the advantage of
piggy-backing on all existing caching infrastructure.

Have 1000 computers on your network that keep fetching torvalds/linux?
Stick a proxy configured to cache the first say 1MB of <bundle-base-url>
in front of them.

Now all their requests to discover if the bundles help will be local
(and it would probably make sense to cache the actual content
too). Whereas any type of custom caching strategy would be
per-git-client.

Just food for thought, and sorry that this E-Mail/braindump got so long
already...
