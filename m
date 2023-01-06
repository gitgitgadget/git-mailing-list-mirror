Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455BEC61DB3
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 20:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbjAFUg4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 15:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbjAFUgv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 15:36:51 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B12BB1
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 12:36:48 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so4404824wmb.2
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 12:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FsdeLUf1+fSD9Un0ALtJQxvb66eHOaQyPBV8liDXRME=;
        b=G7r2IKYZ4I0sp9GdBdcbSCL87poM2nMqE2P+s0RC2nzzz4uji0u9pmBfXFeiEjgB34
         2mdikU4GOZx1N5QTGAFwlCraBCC1J0x/lUP1Wo1kNr57LuvmLE9Xd17k4tA+UR96nmRv
         CirJhiZ8kEvx8JnVRW9l4471te7joYz4G/Z7cwII6kbpxQA/KalbIWPqnk0wW08eWkmo
         seP4GLavlj/Q9fEe6teKxU7MSmr57hs/2q4tPF3MO+KMSf5iS7U6zd1XAETdxjCPYeZT
         eEg3w5b6ipHcEm5OmsZ1wYBZl6BYD+DK76H6Ujkew0LDmmFEJhXosWmTsza92YA6xBWF
         CimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsdeLUf1+fSD9Un0ALtJQxvb66eHOaQyPBV8liDXRME=;
        b=RJXurEd+2/fq/IZvA/VC9NAxAsCzn61dcSOPP/4qzEyhc+VfbopGJMub4AangET+RO
         E7I8b3deby2E80DnHU4UfqllxTsJLdwHnMmIJPQaOrHuxy4992tUBetHkjRVUvMhKLNH
         68PdcAGaPbZ9kfi4EGwEAi6qB37F2xB8a3Xw6tS069/gYd9oC6UmFmRthwRmhi+3DFrL
         pfA2EXCExRTemiFzDnffcYRP7za/AZjPeIiCOkEM/wcL4+Mqs41WS3Sxm4a1kx6bktmo
         9gxxbrO9d1Jivlyo2OUNrQG972KN0rPC4LigS5Q7hGsob05E/JcErvWM4hFnk2gWzx5w
         Dklg==
X-Gm-Message-State: AFqh2krQJ5ZOAjKezfm9s7N7DujerjKfwdJJHE4PXszSNCH7Pxieyi+h
        UhvEUgCI3AtkvPWXX9S4tbqSP8VZXj8=
X-Google-Smtp-Source: AMrXdXuWf+JCZvCUL7XxdIqmHoYQ+4XPVie0KLad1oH5PUm2Ls/jzwXVAM1bdZyc7ny0PSagRhPa5w==
X-Received: by 2002:a05:600c:348b:b0:3d1:fcb4:4074 with SMTP id a11-20020a05600c348b00b003d1fcb44074mr49233641wmq.22.1673037406977;
        Fri, 06 Jan 2023 12:36:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z25-20020a1c4c19000000b003d1e1f421bfsm7233162wmf.10.2023.01.06.12.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:36:46 -0800 (PST)
Message-Id: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Jan 2023 20:36:37 +0000
Subject: [PATCH 0/8] Bundle URIs V: creationToken heuristic for incremental fetches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fifth part to the bundle URIs feature follows part IV (advertising via
protocol v2) which recently merged to 'master', so this series is based on
'master'.

This part introduces the concept of a heuristic that a bundle list can
advertise. The purpose of the heuristic is to hint to the Git client that
the bundles can be downloaded and unbundled in a certain order. In
particular, that order can assist with using the same bundle URI to download
new bundles from an updated bundle list. This allows bundle URIs to assist
with incremental fetches, not just initial clones.

The only planned heuristic is the "creationToken" heuristic where the bundle
list adds a 64-bit unsigned integer "creationToken" value to each bundle in
the list. Those values provide an ordering on the bundles implying that the
bundles can be unbundled in increasing creationToken order and at each point
the required commits for the ith bundle were provided by bundles with lower
creationTokens.

At clone time, the only difference implied by the creationToken order is
that the Git client does not need to guess at the order to apply the
bundles, but instead can use the creationToken order to apply them without
failure and retry. However, this presents an interesting benefit during
fetches: the Git client can check the bundle list and download bundles in
decreasing creationToken order until the required commits for these bundles
are present within the repository's object store. This prevents downloading
more bundle information than required.

The creationToken value is also a promise that the Git client will not need
to download a bundle if its creationToken is less than or equal to the
creationToken of a previously-downloaded bundle. This further improves the
performance during a fetch in that the client does not need to download any
bundles at all if it recognizes that the maximum creationToken is the same
(or smaller than) a previously-downloaded creationToken.

The creationToken concept is documented in the existing design document at
Documentation/technical/bundle-uri.txt, including suggested ways for bundle
providers to organize their bundle lists to take advantage of the heuristic.

This series formalizes the creationToken heuristic and the Git client logic
for understanding it. Further, for bundle lists provided by the git clone
--bundle-uri option, the Git client will recognize the heuristic as being
helpful for incremental fetches and store config values so that future git
fetch commands check the bundle list before communicating with any Git
remotes.

Note that this option does not integrate fetches with bundle lists
advertised via protocol v2. I spent some time working on this, but found the
implementation to be distinct enough that it merited its own attention in a
separate series. In particular, the configuration for indicating that a
fetch should check the bundle-uri protocol v2 command seemed best to be
located within a Git remote instead of a repository-global key such as is
being used for a static URI. Further, the timing of querying the bundle-uri
command during a git fetch command is significantly different and more
complicated than how it is used in git clone.


What Remains?
=============

Originally, I had planned on making this bundle URI work a 5-part series,
and this is part 5. Shouldn't we be done now?

There are two main things that should be done after this series, in any
order:

 * Teach git fetch to check a bundle list advertised by a remote over the
   bundle-uri protocol v2 command.
 * Add the bundle.<id>.filter option to allow advertising bundles and
   partial bundles side-by-side.

There is also room for expanding tests for more error conditions, or for
other tweaks that are not currently part of the design document. I do think
that after this series, the feature will be easier to work on different
parts in parallel.


Patch Outline
=============

 * Patch 1 creates a test setup demonstrating a creationToken heuristic. At
   this point, the Git client ignores the heuristic and uses its ad-hoc
   strategy for ordering the bundles.
 * Patches 2 and 3 teach Git to parse the bundle.heuristic and
   bundle.<id>.creationToken keys in a bundle list.
 * Patch 4 teaches Git to download bundles using the creationToken order.
   This order uses a stack approach to start from the maximum creationToken
   and continue downloading the next bundle in the list until all bundles
   can successfully be unbundled. This is the algorithm required for
   incremental fetches, while initial clones could download in the opposite
   order. Since clones will download all bundles anyway, having a second
   code path just for clones seemed unnecessary.
 * Patch 5 teaches git clone --bundle-uri to set fetch.bundleURI when the
   advertised bundle list includs a heuristic that Git understands.
 * Patch 6 updates the design document to remove reference to a bundle.flag
   option that was previously going to indicate the list was designed for
   fetches, but the bundle.heuristic option already does that.
 * Patch 7 teaches git fetch to check fetch.bundleURI and download bundles
   from that static URI before connecting to remotes via the Git protocol.
 * Patch 8 introduces a new fetch.bundleCreationToken config value to store
   the maximum creationToken of downloaded bundles. This prevents
   downloading the latest bundle on every git fetch command, reducing waste.

Thanks,

 * Stolee

Derrick Stolee (8):
  t5558: add tests for creationToken heuristic
  bundle-uri: parse bundle.heuristic=creationToken
  bundle-uri: parse bundle.<id>.creationToken values
  bundle-uri: download in creationToken order
  clone: set fetch.bundleURI if appropriate
  bundle-uri: drop bundle.flag from design doc
  fetch: fetch from an external bundle URI
  bundle-uri: store fetch.bundleCreationToken

 Documentation/config/bundle.txt        |   7 +
 Documentation/config/fetch.txt         |  16 ++
 Documentation/technical/bundle-uri.txt |   8 +-
 builtin/clone.c                        |   6 +-
 builtin/fetch.c                        |   8 +
 bundle-uri.c                           | 208 ++++++++++++++++++++++++-
 bundle-uri.h                           |  28 +++-
 t/t5558-clone-bundle-uri.sh            | 204 +++++++++++++++++++++++-
 t/t5601-clone.sh                       |  50 ++++++
 t/t5750-bundle-uri-parse.sh            |  37 +++++
 10 files changed, 561 insertions(+), 11 deletions(-)


base-commit: 4dbebc36b0893f5094668ddea077d0e235560b16
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1454%2Fderrickstolee%2Fbundle-redo%2FcreationToken-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1454/derrickstolee/bundle-redo/creationToken-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1454
-- 
gitgitgadget
