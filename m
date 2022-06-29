Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C23DC43334
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 20:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiF2Uky (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 16:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiF2Ukw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 16:40:52 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463FF13F3D
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 13:40:50 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k22so24179046wrd.6
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 13:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ujm+AfnzoDH564+75UOYgMSADf1tsZkQGwtrrC18c2k=;
        b=Rf4pxQ9n63aiTcvJYq180y3TLQpgrfevg2bWeVQOmLXkvMHlIgANViLHqgmasZjAWA
         y8pwRfXspIJ22pHLX38pseyp8HcxCC/U6uyDW/XTXoWszQiG98lhaEHJDshjyGYDSl+M
         4qQQNGMh9V9OJ1KyF/0IGnhRvKS+bPIbAgUYYPmyT0cMqAefCtx1JS5PW8Px9DxBtCo5
         aDHXs4nuICcfc+CqUCrMM1/PfOkwdwsnsa5BLhsrhrDjGWV+03KFwyJmimE/DZ4lmWWZ
         qq9gIT+9y9Vj+gSczi0dP+AsiB8hMM+IiiFSZEeD5WCBCtu9AgVsC5tkqDg+lqWBk8xI
         gLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ujm+AfnzoDH564+75UOYgMSADf1tsZkQGwtrrC18c2k=;
        b=qozAtwoWLw3PKKzM8RSsDS9CkAbZaY5+hP3SzzEzD8Gns38O7GMNhTO8YEpTn0cIyJ
         UQW3dNi0p0unpfSCjAryEvut/1UG62UeqjohHnzD2nQQ6S5QvZO3ncpPZ4BWTXL/Yawg
         MO/slZZEklqPs4ECC+vd/w191M20sOK0YjMPxvP3bHTlUQh0zjj7hM6qw+TBP7X+qH5n
         eDUciAVVv+FOaD29hG3ZgoI/OIcBWJAruGubeQM3BjPtEr1wiVee4uD7YhG/XiffM0gN
         a/hZ2LA3p08VChABnCOW6KmaM2l2jhGajH03deeD2xsDfd+aw8w2nU0YcXr5aaP7tM2D
         2YQg==
X-Gm-Message-State: AJIora9yB6yjJ5IHBPto/wTvuHtHyVUm7JwByFpUm4dOqOxOksLukfMw
        P/VpgLkryY91I9o9WEQUpyB1OXEH5Y8rTg==
X-Google-Smtp-Source: AGRyM1tprc0eTjF0PZUZ/vmytKeGaXyqxWi/ZV5z+LvxFZAN7+pu+colkgJ8IPdex23DptUHSfuD+A==
X-Received: by 2002:adf:dc08:0:b0:21b:bcaf:8500 with SMTP id t8-20020adfdc08000000b0021bbcaf8500mr4872599wri.133.1656535247089;
        Wed, 29 Jun 2022 13:40:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i206-20020a1c3bd7000000b003a03ae64f57sm4549867wma.8.2022.06.29.13.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 13:40:46 -0700 (PDT)
Message-Id: <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
In-Reply-To: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Jun 2022 20:40:39 +0000
Subject: [PATCH v2 0/6] bundle URIs: design doc and initial git fetch --bundle-uri implementation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first of series towards building the bundle URI feature as
discussed in previous RFCs, specifically pulled directly out of [5]:

[1]
https://lore.kernel.org/git/RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com/
[2]
https://lore.kernel.org/git/cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com/
[3]
https://lore.kernel.org/git/pull.1160.git.1645641063.gitgitgadget@gmail.com
[4]
https://lore.kernel.org/git/RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com/
[5]
https://lore.kernel.org/git/pull.1234.git.1653072042.gitgitgadget@gmail.com

The first patch details the long-term design and goals of the bundle URI
feature, including complicated features such as the bundle-uri protocol v2
verb and bundle lists with heuristics.

However, then intention is to start small with the simplest features that
allow user benefit as soon as possible. In that direction, the rest of this
series creates the ability to run 'git fetch --bundle-uri=' to skip fetching
from any remote and instead download the file at the given . Currently, that
data is expected to be a bundle, which Git will then unbundle and modify the
refs to be in the 'refs/bundle/' namespace.

Currently, the can be a literal filename, a file:// URI, or an http[s]://
URI. Tests are added for both of these cases.

As outlined in [5], the next steps after this are:

 1. Add 'git clone --bundle-uri=' to run this 'git fetch --bundle-uri=' step
    before doing a fetch negotiation with the origin remote. [6]
 2. Allow parsing a bundle list as a config file at the given URI. The
    key-value format is unified with the protocol v2 verb (coming in (3)).
    [7]
 3. Implement the protocol v2 verb, re-using the bundle list logic from (2).
    Use this to auto-discover bundle URIs during 'git clone' (behind a
    config option). [8]
 4. Implement the 'creationToken' heuristic, allowing incremental 'git
    fetch' commands to download a bundle list from a configured URI, and
    only download bundles that are new based on the creation token values.
    [9]

I have prepared some of this work as pull requests on my personal fork so
curious readers can look ahead to where we are going:

[6] https://github.com/derrickstolee/git/pull/18 [7]
https://github.com/derrickstolee/git/pull/20 [8]
https://github.com/derrickstolee/git/pull/21 [9]
https://github.com/derrickstolee/git/pull/22

As mentioned in the design document, this is not all that is possible. For
instance, Ævar's suggestion to download only the bundle headers can be used
as a second heuristic (and as an augmentation of the timestamp heuristic).


Updates in v2
=============

 * The design document has been updated based on Junio's feedback.
 * The "bundle.list." keys are now just "bundle.".
 * The "timestamp" heuristic is now "creationToken".
 * More clarity on how Git parses data from the bundle URI.
 * Dropped some unnecessary bundle list keys (*.list, *.requires).

Thanks, -Stolee

Derrick Stolee (6):
  docs: document bundle URI standard
  remote-curl: add 'get' capability
  bundle-uri: create basic file-copy logic
  fetch: add --bundle-uri option
  bundle-uri: add support for http(s):// and file://
  fetch: add 'refs/bundle/' to log.excludeDecoration

 Documentation/fetch-options.txt        |   6 +
 Documentation/git-fetch.txt            |   1 +
 Documentation/gitremote-helpers.txt    |   9 +
 Documentation/technical/bundle-uri.txt | 464 +++++++++++++++++++++++++
 Makefile                               |   1 +
 builtin/fetch.c                        |  10 +
 bundle-uri.c                           | 167 +++++++++
 bundle-uri.h                           |  14 +
 remote-curl.c                          |  33 ++
 t/t5557-http-get.sh                    |  37 ++
 t/t5558-fetch-bundle-uri.sh            |  77 ++++
 transport-helper.c                     |   5 +-
 12 files changed, 823 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/technical/bundle-uri.txt
 create mode 100644 bundle-uri.c
 create mode 100644 bundle-uri.h
 create mode 100755 t/t5557-http-get.sh
 create mode 100755 t/t5558-fetch-bundle-uri.sh


base-commit: 89c6e450fe4a919ecb6fa698005a935531c732cf
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1248%2Fderrickstolee%2Fbundle-redo%2Ffetch-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1248/derrickstolee/bundle-redo/fetch-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1248

Range-diff vs v1:

 1:  e771b2971d0 ! 1:  d444042dc4d docs: document bundle URI standard
     @@ Documentation/technical/bundle-uri.txt (new)
      +  bundle provider to use different URIs for different geographies.
      +
      +* The bundle provider can organize the bundles using heuristics, such as
     -+  timestamps or tokens, to help the client prevent downloading bundles it
     -+  does not need. When the bundle provider does not provide these
     -+  heuristics, the client can use optimizations to minimize how much of the
     -+  data is downloaded.
     ++  creation tokens, to help the client prevent downloading bundles it does
     ++  not need. When the bundle provider does not provide these heuristics,
     ++  the client can use optimizations to minimize how much of the data is
     ++  downloaded.
      +
      +* The bundle provider does not need to be associated with the Git server.
      +  The client can choose to use the bundle provider without it being
     @@ Documentation/technical/bundle-uri.txt (new)
      +SSH URIs.)
      +
      +Assuming a `200 OK` response from the server, the content at the URL is
     -+expected to be of one of two forms:
     -+
     -+1. Bundle: A Git bundle file of version 2 or higher.
     -+
     -+2. Bundle List: A plain-text file that is parsable using Git's
     -+   config file parser. This file describes one or more bundles that are
     -+   accessible from other URIs.
     ++inspected. First, Git attempts to parse the file as a bundle file of
     ++version 2 or higher. If the file is not a bundle, then the file is parsed
     ++as a plain-text file using Git's config parser. The key-value pairs in
     ++that config file are expected to describe a list of bundle URIs. If
     ++neither of these parse attempts succeed, then Git will report an error to
     ++the user that the bundle URI provided erroneous data.
      +
      +Any other data provided by the server is considered erroneous.
      +
     @@ Documentation/technical/bundle-uri.txt (new)
      +
      +A few keys focus on properties of the list itself.
      +
     -+bundle.list.version::
     -+	(Required) This value provides a version number for the table of
     -+	contents. If a future Git change enables a feature that needs the Git
     ++bundle.version::
     ++	(Required) This value provides a version number for the bundle
     ++	list. If a future Git change enables a feature that needs the Git
      +	client to react to a new key in the bundle list file, then this version
      +	will increment. The only current version number is 1, and if any other
      +	value is specified then Git will fail to use this file.
      +
     -+bundle.list.mode::
     ++bundle.mode::
      +	(Required) This value has one of two values: `all` and `any`. When `all`
      +	is specified, then the client should expect to need all of the listed
      +	bundle URIs that match their repository's requirements. When `any` is
     @@ Documentation/technical/bundle-uri.txt (new)
      +	`any` option is used to list a number of different bundle servers
      +	located in different geographies.
      +
     -+bundle.list.heuristic::
     ++bundle.heuristic::
      +	If this string-valued key exists, then the bundle list is designed to
     -+  work well with incremental `git fetch` commands. The heuristic signals
     -+  that there are additional keys available for each bundle that help
     -+  determine which subset of bundles the client should download.
     ++	work well with incremental `git fetch` commands. The heuristic signals
     ++	that there are additional keys available for each bundle that help
     ++	determine which subset of bundles the client should download.
      +
      +The remaining keys include an `<id>` segment which is a server-designated
      +name for each available bundle.
     @@ Documentation/technical/bundle-uri.txt (new)
      +	bundles across a large number of servers or CDNs with different domain
      +	names.)
      +
     -+bundle.<id>.list::
     -+	This boolean value indicates whether the client should expect the
     -+	content from this URI to be a list (if `true`) or a bundle (if `false`).
     -+	This is typically used when `bundle.list.mode` is `any`.
     -+
      +bundle.<id>.filter::
      +	This string value represents an object filter that should also appear in
      +	the header of this bundle. The server uses this value to differentiate
      +	different kinds of bundles from which the client can choose those that
      +	match their object filters.
      +
     -+bundle.<id>.timestamp::
     -+	This value is the number of seconds since Unix epoch (UTC) that this
     -+	bundle was created. This is used as an approximation of a point in time
     -+	that the bundle matches the data available at the origin server. This is
     -+	used when `bundle.list.heuristic=timestamp`.
     -+
     -+bundle.<id>.requires::
     -+	This string value represents the ID of another bundle. When present, the
     -+	server is indicating that this bundle contains a thin packfile. If the
     -+	client does not have all necessary objects to unbundle this packfile,
     -+	then the client can download the bundle with the `requires` ID and try
     -+	again. (Note: it may be beneficial to allow the server to specify
     -+	multiple `requires` bundles.) This is used when
     -+	`bundle.list.heuristic=timestamp`.
     ++bundle.<id>.creationToken::
     ++	This value is a nonnegative 64-bit integer used for sorting the bundles
     ++	the list. This is used to download a subset of bundles during a fetch
     ++	when `bundle.heuristic=creationToken`.
      +
      +bundle.<id>.location::
      +	This string value advertises a real-world location from where the bundle
      +	URI is served. This can be used to present the user with an option for
     -+	which bundle URI to use. This is only valuable when `bundle.list.mode`
     -+	is `any`.
     ++	which bundle URI to use or simply as an informative indicator of which
     ++	bundle URI was selected by Git. This is only valuable when
     ++	`bundle.mode` is `any`.
      +
      +Here is an example bundle list using the Git config format:
      +
      +```
     -+[bundle "list"]
     ++[bundle]
      +	version = 1
      +	mode = all
     -+	heuristic = timestamp
     ++	heuristic = creationToken
      +
      +[bundle "2022-02-09-1644442601-daily"]
     -+	uri = https://bundles.fake.com/git/git/2022-02-09-1644442601-daily.bundle
     ++	uri = https://bundles.example.com/git/git/2022-02-09-1644442601-daily.bundle
      +	timestamp = 1644442601
     -+	requires = 2022-02-02-1643842562
      +
      +[bundle "2022-02-02-1643842562"]
     -+	uri = https://bundles.fake.com/git/git/2022-02-02-1643842562.bundle
     ++	uri = https://bundles.example.com/git/git/2022-02-02-1643842562.bundle
      +	timestamp = 1643842562
      +
      +[bundle "2022-02-09-1644442631-daily-blobless"]
      +	uri = 2022-02-09-1644442631-daily-blobless.bundle
      +	timestamp = 1644442631
     -+	requires = 2022-02-02-1643842568-blobless
      +	filter = blob:none
      +
      +[bundle "2022-02-02-1643842568-blobless"]
     @@ Documentation/technical/bundle-uri.txt (new)
      +	filter = blob:none
      +```
      +
     -+This example uses `bundle.list.mode=all` as well as the
     -+`bundle.<id>.timestamp` heuristic. It also uses the `bundle.<id>.filter`
     ++This example uses `bundle.mode=all` as well as the
     ++`bundle.<id>.creationToken` heuristic. It also uses the `bundle.<id>.filter`
      +options to present two parallel sets of bundles: one for full clones and
      +another for blobless partial clones.
      +
      +Suppose that this bundle list was found at the URI
     -+`https://bundles.fake.com/git/git/` and so the two blobless bundles have
     ++`https://bundles.example.com/git/git/` and so the two blobless bundles have
      +the following fully-expanded URIs:
      +
     -+* `https://bundles.fake.com/git/git/2022-02-09-1644442631-daily-blobless.bundle`
     -+* `https://bundles.fake.com/git/git/2022-02-02-1643842568-blobless.bundle`
     ++* `https://bundles.example.com/git/git/2022-02-09-1644442631-daily-blobless.bundle`
     ++* `https://bundles.example.com/git/git/2022-02-02-1643842568-blobless.bundle`
      +
      +Advertising Bundle URIs
      +-----------------------
     @@ Documentation/technical/bundle-uri.txt (new)
      +protocol v2 capability specifically for discovering bundle URIs.
      +
      +The client could choose an arbitrary bundle URI as an option _or_ select
     -+the URI with lowest latency by some exploratory checks. It is up to the
     ++the URI with best performance by some exploratory checks. It is up to the
      +bundle provider to decide if having multiple URIs is preferable to a
      +single URI that is geodistributed through server-side infrastructure.
      +
     @@ Documentation/technical/bundle-uri.txt (new)
      +   Git server.
      +
      +2. If the downloaded data from a bundle URI is a bundle, then the client
     -+   inspects the bundle headers to check that the negative commit OIDs are
     -+   present in the client repository. If some are missing, then the client
     -+   delays unbundling until other bundles have been unbundled, making those
     -+   OIDs present. When all required OIDs are present, the client unbundles
     -+   that data using a refspec. The default refspec is
     -+   `+refs/heads/*:refs/bundles/*`, but this can be configured.
     ++   inspects the bundle headers to check that the prerequisite commit OIDs
     ++   are present in the client repository. If some are missing, then the
     ++   client delays unbundling until other bundles have been unbundled,
     ++   making those OIDs present. When all required OIDs are present, the
     ++   client unbundles that data using a refspec. The default refspec is
     ++   `+refs/heads/*:refs/bundles/*`, but this can be configured. These refs
     ++   are stored so that later `git fetch` negotiations can communicate the
     ++   bundled refs as `have`s, reducing the size of the fetch over the Git
     ++   protocol. To allow pruning refs from this ref namespace, Git may
     ++   introduce a numbered namespace (such as `refs/bundles/<i>/*`) such that
     ++   stale bundle refs can be deleted.
      +
      +3. If the file is instead a bundle list, then the client inspects the
     -+   `bundle.list.mode` to see if the list is of the `all` or `any` form.
     ++   `bundle.mode` to see if the list is of the `all` or `any` form.
      +
     -+   a. If `bundle.list.mode=all`, then the client considers all bundle
     ++   a. If `bundle.mode=all`, then the client considers all bundle
      +      URIs. The list is reduced based on the `bundle.<id>.filter` options
      +      matching the client repository's partial clone filter. Then, all
     -+      bundle URIs are requested. If the `bundle.<id>.timestamp` heuristic
     -+      is provided, then the bundles are downloaded in reverse-
     -+      chronological order, stopping when a bundle has all required OIDs.
     -+      The bundles can then be unbundled in chronological order. The client
     -+      stores the latest timestamp as a heuristic for avoiding future
     -+      downloads if the bundle list does not advertise newer bundles.
     -+
     -+   b. If `bundle.list.mode=any`, then the client can choose any one of the
     ++      bundle URIs are requested. If the `bundle.<id>.creationToken`
     ++      heuristic is provided, then the bundles are downloaded in decreasing
     ++      order by the creation token, stopping when a bundle has all required
     ++      OIDs. The bundles can then be unbundled in increasing creation token
     ++      order. The client stores the latest creation token as a heuristic
     ++      for avoiding future downloads if the bundle list does not advertise
     ++      bundles with larger creation tokens.
     ++
     ++   b. If `bundle.mode=any`, then the client can choose any one of the
      +      bundle URIs to inspect. The client can use a variety of ways to
      +      choose among these URIs. The client can also fallback to another URI
      +      if the initial choice fails to return a result.
      +
      +Note that during a clone we expect that all bundles will be required, and
     -+heuristics such as `bundle.<uri>.timestamp` can be used to download bundles
     -+in chronological order or in parallel.
     ++heuristics such as `bundle.<uri>.creationToken` can be used to download
     ++bundles in chronological order or in parallel.
      +
     -+If a given bundle URI is a bundle list with a `bundle.list.heuristic`
     ++If a given bundle URI is a bundle list with a `bundle.heuristic`
      +value, then the client can choose to store that URI as its chosen bundle
      +URI. The client can then navigate directly to that URI during later `git
      +fetch` calls.
     @@ Documentation/technical/bundle-uri.txt (new)
      +
      +The fetch operation follows the same procedure to download bundles from a
      +bundle list (although we do _not_ want to use parallel downloads here). We
     -+expect that the process will end when all negative commit OIDs in a thin
     -+bundle are already in the object database.
     ++expect that the process will end when all prerequisite commit OIDs in a
     ++thin bundle are already in the object database.
      +
     -+When using the `timestamp` heuristic, the client can avoid downloading any
     -+bundles if their timestamps are not larger than the stored timestamp.
     -+After fetching new bundles, this local timestamp value is updated.
     ++When using the `creationToken` heuristic, the client can avoid downloading
     ++any bundles if their creation tokenss are not larger than the stored
     ++creation token. After fetching new bundles, Git updates this local
     ++creation token.
      +
      +If the bundle provider does not provide a heuristic, then the client
      +should attempt to inspect the bundle headers before downloading the full
     @@ Documentation/technical/bundle-uri.txt (new)
      +  use the `credential.helper` to attempt authentication after the first
      +  `401 Not Authorized` response, but a second such response is a failure.
      +
     -+* The client receives data that is not parsable as a bundle or table of
     -+  contents.
     ++* The client receives data that is not parsable as a bundle or bundle list.
      +
      +* The bundle list describes a directed cycle in the
      +  `bundle.<id>.requires` links.
      +
      +* A bundle includes a filter that does not match expectations.
      +
     -+* The client cannot unbundle the bundles because the negative commit OIDs
     ++* The client cannot unbundle the bundles because the prerequisite commit OIDs
      +  are not in the object database and there are no more
      +  `bundle.<id>.requires` links to follow.
      +
     @@ Documentation/technical/bundle-uri.txt (new)
      +  the client is using hourly prefetches with background maintenance, but
      +  the server is computing bundles weekly. For this reason, the client
      +  should not use bundle URIs for fetch unless the server has explicitly
     -+  recommended it through the `bundle.list.forFetch = true` value.
     ++  recommended it through the `bundle.flags = forFetch` value.
      +
      +Implementation Plan
      +-------------------
     @@ Documentation/technical/bundle-uri.txt (new)
      +
      +2. Implement the ability to parse a bundle list from a bundle URI and
      +   update the `git fetch --bundle-uri` logic to properly distinguish
     -+   between `bundle.list.mode` options. Specifically design the feature so
     ++   between `bundle.mode` options. Specifically design the feature so
      +   that the config format parsing feeds a list of key-value pairs into the
      +   bundle list logic.
      +
     @@ Documentation/technical/bundle-uri.txt (new)
      +   (This choice is an opt-in via a config option and a command-line
      +   option.)
      +
     -+4. Allow the client to understand the `bundle.list.forFetch` configuration
     -+   and the `bundle.<id>.timestamp` heuristic. When `git clone` discovers a
     -+   bundle URI with `bundle.list.forFetch=true`, it configures the client
     -+   repository to check that bundle URI during later `git fetch <remote>`
     ++4. Allow the client to understand the `bundle.flag=forFetch` configuration
     ++   and the `bundle.<id>.creationToken` heuristic. When `git clone`
     ++   discovers a bundle URI with `bundle.flag=forFetch`, it configures the
     ++   client repository to check that bundle URI during later `git fetch <remote>`
      +   commands.
      +
      +5. Allow clients to discover bundle URIs during `git fetch` and configure
     -+   a bundle URI for later fetches if `bundle.list.forFetch=true`.
     ++   a bundle URI for later fetches if `bundle.flag=forFetch`.
      +
      +6. Implement the "inspect headers" heuristic to reduce data downloads when
     -+   the `bundle.<id>.timestamp` heuristic is not available.
     ++   the `bundle.<id>.creationToken` heuristic is not available.
      +
      +As these features are reviewed, this plan might be updated. We also expect
      +that new designs will be discovered and implemented as this feature
 2:  977f0af40fc = 2:  0a2cf60437f remote-curl: add 'get' capability
 3:  8a18acfbf05 ! 3:  abec47564fd bundle-uri: create basic file-copy logic
     @@ bundle-uri.c (new)
      +{
      +	int fd;
      +	/*
     -+	 * Find a temporray filename that is available. This is briefly
     ++	 * Find a temporary filename that is available. This is briefly
      +	 * racy, but unlikely to collide.
      +	 */
      +	fd = odb_mkstemp(name, "bundles/tmp_uri_XXXXXX");
     @@ bundle-uri.c (new)
      +	if ((bundle_fd = read_bundle_header(file, &header)) < 0)
      +		return 1;
      +
     -+	result = unbundle(r, &header, bundle_fd, &extra_index_pack_args);
     ++	if ((result = unbundle(r, &header, bundle_fd, &extra_index_pack_args)))
     ++		return 1;
      +
      +	/*
      +	 * Convert all refs/heads/ from the bundle into refs/bundles/
 4:  f9e416164e4 ! 4:  f6255ec5188 fetch: add --bundle-uri option
     @@ Commit message
           4. git fetch origin
           5. git checkout FETCH_HEAD
      
     +    Since the unbundle_from_file() in bundle-uri.c stores the bundled refs
     +    into the refs/bundle/* namespace, those references are useful for the
     +    fetch negotiation in step 4, reducing the size of the download in that
     +    step.
     +
          Later changes will make this seamless within a 'git clone' command, but
          this implementation is large enough to delay that integration.
      
 5:  923feef84e4 ! 5:  bfbd11b48bf bundle-uri: add support for http(s):// and file://
     @@ Metadata
       ## Commit message ##
          bundle-uri: add support for http(s):// and file://
      
     -    The previous change created the logic for copying a file by name. Now,
     -    first inspect the URI for an HTTP(S) prefix and use git-remote-https as
     -    the way to download the data at that URI. Otherwise, check to see if
     -    file:// is present and modify the prefix accordingly.
     +    The previous change created the 'git fetch --bundle-uri=<uri>' option.
     +    Currently, <uri> must be a filename.
     +
     +    Update copy_uri_to_file() to first inspect the URI for an HTTP(S) prefix
     +    and use git-remote-https as the way to download the data at that URI.
     +    Otherwise, check to see if file:// is present and modify the prefix
     +    accordingly.
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
 6:  5ca02b841db ! 6:  a217e9a0640 fetch: add 'refs/bundle/' to log.excludeDecoration
     @@ t/t5558-fetch-bundle-uri.sh: test_expect_success 'fetch file bundle' '
      -	test_cmp expect actual
      +	test_cmp expect actual &&
      +
     -+	test_config log.excludedecoration refs/bundle/
     ++	test_config -C fetch-to log.excludedecoration refs/bundle/
       '
       
       test_expect_success 'fetch file:// bundle' '
     @@ t/t5558-fetch-bundle-uri.sh: test_expect_success 'fetch file:// bundle' '
      -	test_cmp expect actual
      +	test_cmp expect actual &&
      +
     -+	test_config log.excludedecoration refs/bundle/
     ++	test_config -C fetch-file log.excludedecoration refs/bundle/
       '
       
       #########################################################################

-- 
gitgitgadget
