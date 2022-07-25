Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6FFC43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 20:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbiGYUF0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 16:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbiGYUFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 16:05:25 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59856385
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:05:23 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o20-20020a17090aac1400b001f2da729979so1727197pjq.0
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3+YXmW66lnP6WSKJvHkPm+OD1lmX1+UOs8CO13WuZ4I=;
        b=KH5lpok5jZUhy0ULYclh8dzk+Xf2mBeKWLwInBFZMXgtfPNSNutn2j6fhZWtUmzXdl
         gRtW8vX7fbB6ODVU53zIIcw6Gb7rqgFN3N7/rRfkum20yfdCK6GKJPRrhQsztSkY9GIi
         ssqLwv4urO7epc89AXijWEOyoNGW4vnfcDHFnME0f7kuHkjHmSUGSU2r7PXUtACwRkMG
         d/3FGTOngqdAc1bPaecuXmS5NwdQCjLs+37X1kaS0Cv+iQ3EngwoJJ1MjyNAw4ebimPE
         OEmki7wZhftkn1BD5yJX1e+5AgMQ/078DWpa9eggO4/l2j//HvUsZTMsEqR1j0Z+IBGk
         NdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=3+YXmW66lnP6WSKJvHkPm+OD1lmX1+UOs8CO13WuZ4I=;
        b=Xovq4kwKHI1l2wzMkdW1SaYxvPCOGXhIwaC37nyvGw11t7csYKZKdOxqp3EezdNBLf
         N5E/3XVZpBdwkAcJDIyemYZ/D92ldPmvmXoyuL8llQJuFQ4QoTrYvNrOBpWG9prz1gjY
         Jt5aR7E6XOX6jmjmPh7fCHXiSc9DdPrJjhlDAeOi86M5Ogpq0q8PYnLwnx95RHUdiHWe
         7kpJNuPWa7qEk2rtTtnxgo9hFnHlvvldBQzSsZFNwUX0m2ktpDik2Onzc5vqwyM7v196
         k9iZmqVNCPxvM6sotvTjfMpg6ma65e1cK83KMsCqCxHPzzEiUvAmJ0PYKd+hlOGHBoAj
         /K2Q==
X-Gm-Message-State: AJIora+r65gceN47Ru4cZ/4hu+5ggYRXDVXOvn4HKWvIfVvePbXpyv3s
        FxEMTt+LpD+HwH+aRz6V9tuDEg==
X-Google-Smtp-Source: AGRyM1tHu1MIqpGqlpvdU7swFk8bxjnHbB0oPuDeusxhdJfo2+1Ph0oQlC1g9DYvYluw+y8DdDAoQg==
X-Received: by 2002:a17:90a:fe07:b0:1f2:1a1e:e0db with SMTP id ck7-20020a17090afe0700b001f21a1ee0dbmr16262075pjb.106.1658779522967;
        Mon, 25 Jul 2022 13:05:22 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:8deb:5580:a49a:d605])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902e19400b0016c35b21901sm9515632pla.195.2022.07.25.13.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 13:05:22 -0700 (PDT)
Date:   Mon, 25 Jul 2022 13:05:15 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, dyroneteng@gmail.com,
        Johannes.Schindelin@gmx.de,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/2] bundle URIs: design doc and initial git fetch
 --bundle-uri implementation
Message-ID: <Yt73eyk0PKBYoyKn@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, dyroneteng@gmail.com,
        Johannes.Schindelin@gmx.de,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
 <pull.1248.v3.git.1658757188.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.1248.v3.git.1658757188.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.07.25 13:53, Derrick Stolee via GitGitGadget wrote:
> This is the first of series towards building the bundle URI feature as
> discussed in previous RFCs, specifically pulled directly out of [5]:
> 
> [1]
> https://lore.kernel.org/git/RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com/
> [2]
> https://lore.kernel.org/git/cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com/
> [3]
> https://lore.kernel.org/git/pull.1160.git.1645641063.gitgitgadget@gmail.com
> [4]
> https://lore.kernel.org/git/RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com/
> [5]
> https://lore.kernel.org/git/pull.1234.git.1653072042.gitgitgadget@gmail.com
> 
> THIS ONLY INCLUDES THE DESIGN DOCUMENT. See "Updates in v3". There are two
> patches:
> 
>  1. The main design document that details the bundle URI standard and how
>     the client interacts with the bundle data.
>  2. An addendum to the design document that details one strategy for
>     organizing bundles from the perspective of a bundle provider.
> 
> As outlined in [5], the next steps after this are:
> 
>  1. Add 'git clone --bundle-uri=' to run a 'git bundle fetch ' step before
>     doing a fetch negotiation with the origin remote. [6]
>  2. Allow parsing a bundle list as a config file at the given URI. The
>     key-value format is unified with the protocol v2 verb (coming in (3)).
>     [7]
>  3. Implement the protocol v2 verb, re-using the bundle list logic from (2).
>     Use this to auto-discover bundle URIs during 'git clone' (behind a
>     config option). [8]
>  4. Implement the 'creationToken' heuristic, allowing incremental 'git
>     fetch' commands to download a bundle list from a configured URI, and
>     only download bundles that are new based on the creation token values.
>     [9]
> 
> I have prepared some of this work as pull requests on my personal fork so
> curious readers can look ahead to where we are going:
> 
> [6] https://github.com/derrickstolee/git/pull/18 [7]
> https://github.com/derrickstolee/git/pull/20 [8]
> https://github.com/derrickstolee/git/pull/21 [9]
> https://github.com/derrickstolee/git/pull/22
> 
> As mentioned in the design document, this is not all that is possible. For
> instance, Ævar's suggestion to download only the bundle headers can be used
> as a second heuristic (and as an augmentation of the timestamp heuristic).
> 
> 
> Updates in v3
> =============
> 
>  * This version only includes the design document. Thanks to all the
>    reviewers for the significant attention that improves the doc a lot.
>  * The second patch has an addition to the design document that details a
>    potential way to organize bundles from the provider's perspective.
>  * Based on some off-list feedback, I was going to switch git fetch
>    --bundle-uri into git bundle fetch, but that has a major conflict with
>    [10] which was just submitted.
>  * I will move the git bundle fetch implementation into [6] which also has
>    the git clone --bundle-uri implementation. [10]
>    https://lore.kernel.org/git/20220725123857.2773963-1-szeder.dev@gmail.com/
> 
> 
> Updates in v2
> =============
> 
>  * The design document has been updated based on Junio's feedback.
>  * The "bundle.list." keys are now just "bundle.".
>  * The "timestamp" heuristic is now "creationToken".
>  * More clarity on how Git parses data from the bundle URI.
>  * Dropped some unnecessary bundle list keys (*.list, *.requires).
> 
> Thanks, -Stolee
> 
> Derrick Stolee (2):
>   docs: document bundle URI standard
>   bundle-uri: add example bundle organization
> 
>  Documentation/Makefile                 |   1 +
>  Documentation/technical/bundle-uri.txt | 573 +++++++++++++++++++++++++
>  2 files changed, 574 insertions(+)
>  create mode 100644 Documentation/technical/bundle-uri.txt
> 
> 
> base-commit: e72d93e88cb20b06e88e6e7d81bd1dc4effe453f
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1248%2Fderrickstolee%2Fbundle-redo%2Ffetch-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1248/derrickstolee/bundle-redo/fetch-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/1248
> 
> Range-diff vs v2:
> 
>  1:  d444042dc4d ! 1:  e0f003e1b5f docs: document bundle URI standard
>      @@ Commit message
>       
>           Signed-off-by: Derrick Stolee <derrickstolee@github.com>
>       
>      + ## Documentation/Makefile ##
>      +@@ Documentation/Makefile: TECH_DOCS += SubmittingPatches
>      + TECH_DOCS += ToolsForGit
>      + TECH_DOCS += technical/bitmap-format
>      + TECH_DOCS += technical/bundle-format
>      ++TECH_DOCS += technical/bundle-uri
>      + TECH_DOCS += technical/cruft-packs
>      + TECH_DOCS += technical/hash-function-transition
>      + TECH_DOCS += technical/http-protocol
>      +
>        ## Documentation/technical/bundle-uri.txt (new) ##
>       @@
>       +Bundle URIs
>       +===========
>       +
>      ++Git bundles are files that store a pack-file along with some extra metadata,
>      ++including a set of refs and a (possibly empty) set of necessary commits. See
>      ++linkgit:git-bundle[1] and link:bundle-format.txt[the bundle format] for more
>      ++information.
>      ++
>       +Bundle URIs are locations where Git can download one or more bundles in
>       +order to bootstrap the object database in advance of fetching the remaining
>       +objects from a remote.
>      @@ Documentation/technical/bundle-uri.txt (new)
>       +	If this string-valued key exists, then the bundle list is designed to
>       +	work well with incremental `git fetch` commands. The heuristic signals
>       +	that there are additional keys available for each bundle that help
>      -+	determine which subset of bundles the client should download.
>      ++	determine which subset of bundles the client should download. The only
>      ++  heuristic currently planned is `creationToken`.
>       +
>       +The remaining keys include an `<id>` segment which is a server-designated
>      -+name for each available bundle.
>      ++name for each available bundle. The `<id>` must contain only alphanumeric
>      ++and `-` characters.
>       +
>       +bundle.<id>.uri::
>       +	(Required) This string value is the URI for downloading bundle `<id>`.
>      @@ Documentation/technical/bundle-uri.txt (new)
>       +
>       +Here is an example bundle list using the Git config format:
>       +
>      -+```
>      -+[bundle]
>      -+	version = 1
>      -+	mode = all
>      -+	heuristic = creationToken
>      ++	[bundle]
>      ++		version = 1
>      ++		mode = all
>      ++		heuristic = creationToken
>       +
>      -+[bundle "2022-02-09-1644442601-daily"]
>      -+	uri = https://bundles.example.com/git/git/2022-02-09-1644442601-daily.bundle
>      -+	timestamp = 1644442601
>      ++	[bundle "2022-02-09-1644442601-daily"]
>      ++		uri = https://bundles.example.com/git/git/2022-02-09-1644442601-daily.bundle
>      ++		creationToken = 1644442601
>       +
>      -+[bundle "2022-02-02-1643842562"]
>      -+	uri = https://bundles.example.com/git/git/2022-02-02-1643842562.bundle
>      -+	timestamp = 1643842562
>      ++	[bundle "2022-02-02-1643842562"]
>      ++		uri = https://bundles.example.com/git/git/2022-02-02-1643842562.bundle
>      ++		creationToken = 1643842562
>       +
>      -+[bundle "2022-02-09-1644442631-daily-blobless"]
>      -+	uri = 2022-02-09-1644442631-daily-blobless.bundle
>      -+	timestamp = 1644442631
>      -+	filter = blob:none
>      ++	[bundle "2022-02-09-1644442631-daily-blobless"]
>      ++		uri = 2022-02-09-1644442631-daily-blobless.bundle
>      ++		creationToken = 1644442631
>      ++		filter = blob:none
>       +
>      -+[bundle "2022-02-02-1643842568-blobless"]
>      -+	uri = /git/git/2022-02-02-1643842568-blobless.bundle
>      -+	timestamp = 1643842568
>      -+	filter = blob:none
>      -+```
>      ++	[bundle "2022-02-02-1643842568-blobless"]
>      ++		uri = /git/git/2022-02-02-1643842568-blobless.bundle
>      ++		creationToken = 1643842568
>      ++		filter = blob:none
>       +
>       +This example uses `bundle.mode=all` as well as the
>       +`bundle.<id>.creationToken` heuristic. It also uses the `bundle.<id>.filter`
>      @@ Documentation/technical/bundle-uri.txt (new)
>       +* The client fails to connect with a server at the given URI or a connection
>       +  is lost without any chance to recover.
>       +
>      -+* The client receives a response other than `200 OK` (such as `404 Not Found`,
>      -+  `401 Not Authorized`, or `500 Internal Server Error`). The client should
>      -+  use the `credential.helper` to attempt authentication after the first
>      -+  `401 Not Authorized` response, but a second such response is a failure.
>      ++* The client receives a 400-level response (such as `404 Not Found` or
>      ++  `401 Not Authorized`). The client should use the credential helper to
>      ++  find and provide a credential for the URI, but match the semantics of
>      ++  Git's other HTTP protocols in terms of handling specific 400-level
>      ++  errors.
>       +
>      -+* The client receives data that is not parsable as a bundle or bundle list.
>      ++* The server reports any other failure reponse.
>       +
>      -+* The bundle list describes a directed cycle in the
>      -+  `bundle.<id>.requires` links.
>      ++* The client receives data that is not parsable as a bundle or bundle list.
>       +
>       +* A bundle includes a filter that does not match expectations.
>       +
>       +* The client cannot unbundle the bundles because the prerequisite commit OIDs
>      -+  are not in the object database and there are no more
>      -+  `bundle.<id>.requires` links to follow.
>      ++  are not in the object database and there are no more bundles to download.
>       +
>       +There are also situations that could be seen as wasteful, but are not
>       +error conditions:
>      @@ Documentation/technical/bundle-uri.txt (new)
>       +  the client is using hourly prefetches with background maintenance, but
>       +  the server is computing bundles weekly. For this reason, the client
>       +  should not use bundle URIs for fetch unless the server has explicitly
>      -+  recommended it through the `bundle.flags = forFetch` value.
>      ++  recommended it through a `bundle.heuristic` value.
>       +
>       +Implementation Plan
>       +-------------------
>      @@ Documentation/technical/bundle-uri.txt (new)
>       +   that the config format parsing feeds a list of key-value pairs into the
>       +   bundle list logic.
>       +
>      -+3. Create the `bundle-uri` protocol v2 verb so Git servers can advertise
>      ++3. Create the `bundle-uri` protocol v2 command so Git servers can advertise
>       +   bundle URIs using the key-value pairs. Plug into the existing key-value
>       +   input to the bundle list logic. Allow `git clone` to discover these
>       +   bundle URIs and bootstrap the client repository from the bundle data.
>  2:  0a2cf60437f < -:  ----------- remote-curl: add 'get' capability
>  3:  abec47564fd < -:  ----------- bundle-uri: create basic file-copy logic
>  4:  f6255ec5188 < -:  ----------- fetch: add --bundle-uri option
>  5:  bfbd11b48bf < -:  ----------- bundle-uri: add support for http(s):// and file://
>  6:  a217e9a0640 < -:  ----------- fetch: add 'refs/bundle/' to log.excludeDecoration
>  -:  ----------- > 2:  a933471c3af bundle-uri: add example bundle organization
> 
> -- 
> gitgitgadget

Looks good to me, thanks for the series!

Reviewed-by: Josh Steadmon <steadmon@google.com>
