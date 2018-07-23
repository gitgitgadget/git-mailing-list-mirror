Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2100B1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 18:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388060AbeGWTzg (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 15:55:36 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34798 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387982AbeGWTzf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 15:55:35 -0400
Received: by mail-yw0-f195.google.com with SMTP id j68-v6so615383ywg.1
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 11:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DWkYu4IuQZAG27JQwHS5YhCG8j34M0j0Q6o5JopuEWo=;
        b=sQNJkCilXC5ORLmY3qB/9CWwHHN5SlEKEoDZID5I+q8HM3tKso3skUCHG93LPf6PvM
         2LkZzUpjHBZoHa5zrkJPTgiXLccsKJXI9F5wppjqqJj8QA4D8VRe0M/HlKkxXUPkimnt
         rUNGwHGksxEGcs2/fY3SZz8e+3vFfmF6fSCADDHLSRs0uyo3742RLLvaS8NlRcaHGjZo
         xlEAgKJK2ZUVujQlt+JDK6eYtYDKatsmNrA9jlAQQrRdLuW51eKv/fSiLafueH3JPfBE
         YQi9vKx9RQLkhswfTWyWyXQN8quJ7GFlHzXgdqEVgVgSGlyIf7d9zIw1OrRqTnEVo3u7
         RT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DWkYu4IuQZAG27JQwHS5YhCG8j34M0j0Q6o5JopuEWo=;
        b=Fe4Rq17fVzeybT1l0me6LYLcGe63FjwPtPapk/r+EO5azxz4ZxFXA8bVgF7R7tFFQu
         0I/1SC5JBGu1t1KmOHVREMuNA5q59XMUXn8vLhU0b/zcjKpAeI9xAiELIpP0vlhP+2rd
         8mA+xj/vLjAJwfrWJ6jwe7QdpWcg4jN3XC1QpWYvMt9A7Bzs60VjV3HokCmMvQ8Ci+vz
         N1jXw+wyJPXLVOPwJoWUnGVcvw8Wa3lafsxj9d7cGmSmYFDyQYd/kY1ARD+sw5G0xTLR
         LbJeSTsGLVe8XlP0DVkrgw4yhimkORIWGTAuG27RUUCf4GR7Gq1qe8Wbllsn6zT+XHVx
         BIBQ==
X-Gm-Message-State: AOUpUlFLbbK+C3aVHQ5T5h4csinHoTXrj/H4qFXHD5FL7ARKml+x3Rg3
        qu8txCMXPWYkIAotof7vo0sIVrPr5BXFWToUVeql+A==
X-Google-Smtp-Source: AAOMgpettVoVUZA2itQw7YKxstcLdYaM43Q/Yr8Www8FCUpqbbcBRMWxWgLzYc4NX7NgfvGQLZGBnIBQkgZq9qCQCv8=
X-Received: by 2002:a81:3758:: with SMTP id e85-v6mr7538233ywa.340.1532371980819;
 Mon, 23 Jul 2018 11:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180722054836.28935-1-chriscool@tuxfamily.org> <20180722054836.28935-4-chriscool@tuxfamily.org>
In-Reply-To: <20180722054836.28935-4-chriscool@tuxfamily.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Jul 2018 11:52:49 -0700
Message-ID: <CAGZ79kbF7g3E4hBa0VqMqBoovbAb2dHaGFNRL=+f7Lce1AduVg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] pack-objects: add delta-islands support
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 21, 2018 at 10:49 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> From: Jeff King <peff@peff.net>
>
> Implement support for delta islands in git pack-objects
> and document how delta islands work in
> "Documentation/git-pack-objects.txt".
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-pack-objects.txt |  88 +++++++++++++++++++
>  builtin/pack-objects.c             | 130 ++++++++++++++++++++---------
>  2 files changed, 177 insertions(+), 41 deletions(-)
>
> diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
> index d95b472d16..7b7a36056f 100644
> --- a/Documentation/git-pack-objects.txt
> +++ b/Documentation/git-pack-objects.txt
> @@ -289,6 +289,94 @@ Unexpected missing object will raise an error.
>  --unpack-unreachable::
>         Keep unreachable objects in loose form. This implies `--revs`.
>
> +--delta-islands::
> +       Restrict delta matches based on "islands". See DELTA ISLANDS
> +       below.
> +
> +
> +DELTA ISLANDS
> +-------------
> +
> +When possible, `pack-objects` tries to reuse existing on-disk deltas to
> +avoid having to search for new ones on the fly. This is an important
> +optimization for serving fetches, because it means the server can avoid
> +inflating most objects at all and just send the bytes directly from
> +disk. This optimization can't work when an object is stored as a delta
> +against a base which the receiver does not have (and which we are not
> +already sending). In that case the server "breaks" the delta and has to
> +find a new one, which has a high CPU cost. Therefore it's important for
> +performance that the set of objects in on-disk delta relationships match
> +what a client would fetch.
> +
> +In a normal repository, this tends to work automatically. The objects
> +are mostly reachable from the branches and tags, and that's what clients
> +fetch. Any deltas we find on the server are likely to be between objects
> +the client has or will have.
> +
> +But in some repository setups, you may have several related but separate
> +groups of ref tips, with clients tending to fetch those groups
> +independently. For example, imagine that you are hosting several "forks"
> +of a repository in a single shared object store, and letting clients
> +view them as separate repositories through `GIT_NAMESPACE` or separate
> +repos using the alternates mechanism. A naive repack may find that the
> +optimal delta for an object is against a base that is only found in
> +another fork. But when a client fetches, they will not have the base
> +object, and we'll have to find a new delta on the fly.
> +
> +A similar situation may exist if you have many refs outside of
> +`refs/heads/` and `refs/tags/` that point to related objects (e.g.,
> +`refs/pull` or `refs/changes` used by some hosting providers). By
> +default, clients fetch only heads and tags, and deltas against objects
> +found only in those other groups cannot be sent as-is.
> +
> +Delta islands solve this problem by allowing you to group your refs into
> +distinct "islands". Pack-objects computes which objects are reachable
> +from which islands, and refuses to make a delta from an object `A`
> +against a base which is not present in all of `A`'s islands. This
> +results in slightly larger packs (because we miss some delta
> +opportunities), but guarantees that a fetch of one island will not have
> +to recompute deltas on the fly due to crossing island boundaries.
> +
> +Islands are configured via the `pack.island` option, which can be
> +specified multiple times. Each value is a left-anchored regular
> +expressions matching refnames. For example:
> +
> +-------------------------------------------
> +[pack]
> +island = refs/heads/
> +island = refs/tags/
> +-------------------------------------------
> +
> +puts heads and tags into an island (whose name is the empty string; see
> +below for more on naming). Any refs which do not match those regular
> +expressions (e.g., `refs/pull/123`) is not in any island. Any object
> +which is reachable only from `refs/pull/` (but not heads or tags) is
> +therefore not a candidate to be used as a base for `refs/heads/`.
> +
> +Refs are grouped into islands based on their "names", and two regexes
> +that produce the same name are considered to be in the same island. The
> +names are computed from the regexes by concatenating any capture groups
> +from the regex (and if there are none, then the name is the empty
> +string, as in the above example). This allows you to create arbitrary
> +numbers of islands. For example, imagine you store the refs for each
> +fork in `refs/virtual/ID`, where `ID` is a numeric identifier. You might
> +then configure:
> +
> +-------------------------------------------
> +[pack]
> +island = refs/virtual/([0-9]+)/heads/
> +island = refs/virtual/([0-9]+)/tags/
> +island = refs/virtual/([0-9]+)/(pull)/
> +-------------------------------------------
> +
> +That puts the heads and tags for each fork in their own island (named
> +"1234" or similar), and the pull refs for each go into their own
> +"1234-pull".
> +
> +Note that we pick a single island for each regex to go into, using "last
> +one wins" ordering (which allows repo-specific config to take precedence
> +over user-wide config, and so forth).

I had to read all of this [background information] to understand the
concept and I think it is misnamed, as my gut instinct first told me
to have deltas only "within an island and no island hopping is allowed".
(This message reads a bit like a commit message, not as documentation
as it is long winded, too).

This feature makes sure that the "common foundation" base is packed
in a way that it is not borrowing construction pieces from any of
the different things atop the common foundation.
It really is about packing the base, but naming it related to the
islands, that are on top of the common sea bed led me to think
that the islands are important of this feature, but really it is about
making the sea bed easy to use and not tied to one of the islands?

What about renaming this feature to

[pack]
    excludePartialReach = refs/virtual/[0-9]]+/tags/

  "By setting `pack.excludePartialReach`, object deltafication is
  prohibited for objects that are not reachable from all
  manifestations of the given regex"

Cryptic, but it explains it in my mind in a shorter, more concise way. ;-)


> @@ -3182,6 +3225,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>                   option_parse_missing_action },
>                 OPT_BOOL(0, "exclude-promisor-objects", &exclude_promisor_objects,
>                          N_("do not pack objects in promisor packfiles")),
> +               OPT_BOOL(0, "delta-islands", &use_delta_islands,
> +                        N_("enable islands for delta compression")),

We enable this feature, but we disallow certain patterns to be used in packing,
so it sounds weird to me as we tell Git to *not* explore the full design space,
so we're not enabling it, but rather restricting it?
