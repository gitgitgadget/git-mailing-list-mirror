Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D68C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239741AbiBWSbf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbiBWSbe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:31:34 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3CC45AE4
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:06 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id s13so12546549wrb.6
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=VfgCw8WRGvsHd1LzUdPi+JDV5jcLOE6DG3Aza+z8pF0=;
        b=Tz6Y2DpAa7k+gaH8vila5YGyGEkIEGY1Tz4vCgb+SP5bKAs1eiixNsAoru4I+E2T0q
         AB5X6JSnHjJh62aS2N09Mt/RkzNd/LcyI83zZlUfYO6hLWLL4dGombTaJsXklmoSQpnF
         JqDyJhZA2z0pVG897yVbbJ3ikJcZXugKy8rchxwHSDNUGpIgcaKekDaS0XC4CT9+JCMG
         YQCBqZnqP0+SOfIWRt7ITiZ8wxOS9aRtq60YsYigLJs5OceWmcXni3T+RjnMx9gfROyc
         LP8L5pGFVUo8+olNirtevdn7OcuadNC7gMHp4BLzEn0RVYI8rU/PcN0Hh7A4RoMg/529
         cf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=VfgCw8WRGvsHd1LzUdPi+JDV5jcLOE6DG3Aza+z8pF0=;
        b=YONGzjrgOzPe9u9H5k25NyHUFHXhySDM1MmD7qU/VPCCj9oPkmfisk6fC6WKh1osHT
         U77qsRMlgT135xLEkKlUwBHeGuWywTrQAa5BIoszgXhm7RExpboUfBqgV23SBEm5X7DZ
         iYQG52JAVRu0wyh41X7FAAiB/c89DYzzttUoxHUuoybBlpYPWb61pKEq+VbokFnGwa2w
         Fa7wo+eTXROW4DiFgsJaBGe28/Jyd1NYAN+LA0cIrV5hNcuJULMJe48zUfMuYB+KRFrK
         S2vq1ZThlqrSFG6rF4WfrOy9KYLKel5woz6UhkXlDJOOuL7sb4qAjy4LEAJc7F7u+vJZ
         zovA==
X-Gm-Message-State: AOAM532KGsHO+aobL+++SzUvrOLmQ0jHnZh6uHUPqPz2TD3OW4voTO/d
        nkyjE+sK+kHJC0Wp9WrL/+KT8MVCqdM=
X-Google-Smtp-Source: ABdhPJyqj1Jt/l7su/xRI5qL4Ge67/7/JXtZMmmiWuBzCMmr27ZzeE+JDZUX58cUyfGM+d8O2H+9RQ==
X-Received: by 2002:a5d:5448:0:b0:1eb:f72c:7f7a with SMTP id w8-20020a5d5448000000b001ebf72c7f7amr684269wrv.573.1645641064532;
        Wed, 23 Feb 2022 10:31:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k19-20020a05600c479300b00380e461a4d2sm594949wmo.0.2022.02.23.10.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:31:04 -0800 (PST)
Message-Id: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:30:38 +0000
Subject: [PATCH 00/25] [RFC] Bundle URIs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, aevar@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There have been several suggestions to improve Git clone speeds and
reliability by supplementing the Git protocol with static content. The
Packfile URI [0] feature lets the Git response include URIs that point to
packfiles that the client must download to complete the request.

Last year, Ævar suggested using bundles instead of packfiles [1] [2]. This
design has the same benefits to the packfile URI feature because it offloads
most object downloads to static content fetches. The main advantage over
packfile URIs is that the remote Git server does not need to know what is in
those bundles. The Git client tells the server what it downloaded during the
fetch negotiation afterwards. This includes any chance that the client did
not have access to those bundles or otherwise failed to access them. I
agreed that this was a much more desirable way to serve static content, but
had concerns about the flexibility of that design [3]. I have not heard more
on the topic since October, so I started investigating this idea myself in
December, resulting in this RFC.

I focused on maximizing flexibility for the service that organizes and
serves bundles. This includes:

 * Bundle URIs work for full and partial clones.

 * Bundle URIs can assist with git fetch in addition to git clone.

 * Users can set up bundle servers independent of the remote Git server if
   they specify the bundle URI via a --bundle-uri argument.

This series is based on the recently-submitted series that adds object
filters to bundles [4]. There is a slight adjacent-line-add conflict with
js/apply-partial-clone-filters-recursively, but that is in the last few
patches, so it will be easy to rebase by the time we have a fully-reviewable
patch series for those steps.

The general breakdown is as follows:

 * Patch 1 adds documentation for the feature in its entirety.

 * Patches 2-14 add the ability to run ‘git clone --bundle-uri=’

 * Patches 15-17 add bundle fetches to ‘git fetch’ calls

 * Patches 18-25 add a new ‘features’ capability that allows a server to
   advertise bundle URIs (and in the future, other features).

I consider the patches in their current form to be “RFC quality”. There are
multiple places where tests are missing or special cases are not checked.
The goal for this RFC is to seek feedback on the high-level ideas before
committing to the deep work of creating mergeable patches.


Testing with this series
========================

To get a full test of the features being proposed here, I created an MVP of
a bundle server by pushing bundle data to some publicly-readable Azure
Storage accounts. These bundle servers mirror the following public
repositories on GitHub:

 * git/git
 * git-for-windows/git
 * homebrew/homebrew-core
 * cocoapods/specs
 * torvalds/linux

In addition, the Azure Storage accounts are available in different regions:

 * East US: https://gitbundleserver.z13.web.core.windows.net
 * West US: https://gitbundleserverwestus.z22.web.core.windows.net
 * Europe: https://gitbundleservereurope.z6.web.core.windows.net
 * East Asia: https://gitbundleservereastasia.z7.web.core.windows.net
 * South Asia: https://gitbundleserversouthasia.z23.web.core.windows.net
 * Australia: https://gitbundleserveraustralia.z26.web.core.windows.net

To test this RFC against these servers, choose your $org/$repo to clone and
your region's bundle server $url and run

$ git clone --bundle-uri=$url/$org/$repo/ https://github.com/$org/$repo


Note that these servers are set up using "almost free" storage in Azure.
Network connectivity of this storage can be slower than that of GitHub data
centers, so your results may vary.

From my location in Raleigh, NC, USA, I am able to clone torvalds/linux from
the bundle servers quite a bit faster than from GitHub:

@derrickstolee With Bundles Without Bundles Full Clone 491.9s 964.9s Partial
Clone 132.3s 171.7s

I recruited GitHub employees from across the globe to test this experimental
deployment of bundle servers and found mixed results. Some users had better
performance with bundle servers, and many had very close results. Some had
much worse connections to bundle servers than the GitHub remote, because of
the use of the cheapest form of Azure Storage services compared to highly
optimized GitHub infrastructure.

I plan to keep these servers running for a while, so this test should be
possible throughout the review of this RFC and the patch series as they are
reviewed. I'd love to hear if anyone else does this experiment and has
anything to say about the results.


Implementation Plan
===================

The first patch contains a design document that is "aspirational": It
describes the feature as it should be when the implementation is complete.
Most of that implementation is included in this RFC, though there are some
minor tweaks to the functionality I want to change or add before the patches
are under full review. In particular, things are poorly tested and
undocumented the further you look in the RFC.

Here is a potential plan for splitting this RFC into digestible pieces that
can be reviewed in sequence:

 0. Update the git bundle create command to take a --filter option, allowing
    bundles to store packfiles restricted to an object filter. This is
    necessary for using bundle URIs to benefit partial clones. This step was
    already submitted for full review [4]. These patches are based on those.

 1. Integrate bundle URIs into git clone with a --bundle-uri option. This
    will include the full understanding of a table of contents, but will not
    integrate with git fetch or allow the server to advertise URIs.

 2. Integrate bundle URIs into git fetch, triggered by config values that
    are set during git clone if the server indicates that the bundle
    strategy works for fetches.

 3. Create a new "recommended features" capability in protocol v2 where the
    server can recommend features such as bundle URIs, partial clone, and
    sparse-checkout. These features will be extremely limited in scope and
    blocked by opt-in config options. The design for this portion could be
    replaced by a "bundle-uri" capability that only advertises bundle URIs
    and no other information.


Intended Focus of this RFC
==========================

This RFC is very large, and that's even with many patches not including full
documentation or tests. These commits are not intended to be reviewed as if
I intended to merge this as-is.

One thing this feature establishes is a new standard by which the Git client
will communicate with external servers. The goal of this RFC is to determine
if this standard is well designed, and whether we need to make it more
robust. Alternatively, the design might need to be changed for reasons I
cannot predict.

For that reason, hopefully most of the feedback is directly on the first
patch, which contains the design document. In particular, the design
document repeats the implementation plan, and I'd like extra eyes on that,
too.

[0]
https://github.com/git/git/blob/master/Documentation/technical/packfile-uri.txt
The packfile URI feature in Git (Created June 2020)

[1]
https://lore.kernel.org/git/RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com/
An earlier RFC for a bundle URI feature. (August 2021)

[2]
https://lore.kernel.org/git/cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com/
An earlier patch series creating a 'bundle-uri' protocol v2 capability.
(October 2021)

[3]
https://lore.kernel.org/git/e7fe220b-2877-107e-8f7e-ea507a65feff@gmail.com/
My earlier thoughts on the previous RFCs, many of which are integrated into
this RFC (August 2021)

[4]
https://lore.kernel.org/git/pull.1159.git.1645638911.gitgitgadget@gmail.com/
Add object filters to bundles (February 2022)

Thanks, -Stolee

Derrick Stolee (24):
  docs: document bundle URI standard
  bundle: alphabetize subcommands better
  dir: extract starts_with_dot[_dot]_slash()
  remote: move relative_url()
  remote: allow relative_url() to return an absolute url
  http: make http_get_file() external
  remote-curl: add 'get' capability
  bundle: implement 'fetch' command for direct bundles
  bundle: parse table of contents during 'fetch'
  bundle: add --filter option to 'fetch'
  bundle: allow relative URLs in table of contents
  bundle: make it easy to call 'git bundle fetch'
  clone: add --bundle-uri option
  clone: --bundle-uri cannot be combined with --depth
  config: add git_config_get_timestamp()
  bundle: only fetch bundles if timestamp is new
  fetch: fetch bundles before fetching original data
  protocol-caps: implement cap_features()
  serve: understand but do not advertise 'features' capability
  serve: advertise 'features' when config exists
  connect: implement get_recommended_features()
  transport: add connections for 'features' capability
  clone: use server-recommended bundle URI
  t5601: basic bundle URI test

Ævar Arnfjörð Bjarmason (1):
  connect.c: refactor sending of agent & object-format

 Documentation/gitremote-helpers.txt    |   6 +
 Documentation/technical/bundle-uri.txt | 404 +++++++++++++++++++++
 builtin/bundle.c                       | 478 ++++++++++++++++++++++++-
 builtin/clone.c                        |  51 +++
 builtin/fetch.c                        |  17 +
 builtin/submodule--helper.c            | 129 -------
 bundle.c                               |  21 ++
 bundle.h                               |   9 +
 config.c                               |  39 ++
 config.h                               |  14 +
 connect.c                              |  69 +++-
 dir.h                                  |  11 +
 fsck.c                                 |  14 +-
 http.c                                 |   4 +-
 http.h                                 |   9 +
 protocol-caps.c                        |  66 ++++
 protocol-caps.h                        |   1 +
 remote-curl.c                          |  32 ++
 remote.c                               | 104 ++++++
 remote.h                               |  35 ++
 serve.c                                |  23 ++
 t/t5601-clone.sh                       |  12 +
 t/t5701-git-serve.sh                   |   9 +
 transport-helper.c                     |  14 +
 transport-internal.h                   |   9 +
 transport.c                            |  38 ++
 transport.h                            |   5 +
 27 files changed, 1467 insertions(+), 156 deletions(-)
 create mode 100644 Documentation/technical/bundle-uri.txt


base-commit: ec51d0a50e6e64ae37795d77f7d33204b9b71ecd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1160%2Fderrickstolee%2Fbundle%2Frfc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1160/derrickstolee/bundle/rfc-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1160
-- 
gitgitgadget
