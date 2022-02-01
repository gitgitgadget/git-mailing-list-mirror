Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293E7C433FE
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 15:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240612AbiBAPt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 10:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240608AbiBAPt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 10:49:56 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B348C061741
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 07:49:56 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n8so13059955wmk.3
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 07:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=21tkZGRZRoaMAEOVM1CnWwI582YQaNQ04FwuLNQ9Um4=;
        b=RRlpkXkatZcSA+zGWRQimfNhAMQgfmvc4BFFTQB/axqTpUJ2pUosxtN9DuHdGDZtMZ
         SDgFe4PEKFqI1KaFKZkdwMTbRdmsxBOAZozKS7t8nbV336UT/YhsphqcoXhhU7DpuDZs
         nIUEGhu/IBcF0o6WR8q0YCd/FUd+xblyTnDQqx9R60hQDDP5zkHJPSXUKFeE13M1qurT
         dRXRnFp7cCnimk9LSROgDUCAue7FWJeB7HG8W3sV6QGlDUHG60nT7uxFn4CE01An3ycP
         fKTnxfYtICsbaTXirCZzalTok5gR8ZwwjsTNPbWsc1304c95Ikxzav/R2DteViav1Gks
         PTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=21tkZGRZRoaMAEOVM1CnWwI582YQaNQ04FwuLNQ9Um4=;
        b=vctvXF/kuNrXecxyfk82HSeigDckxEBYRNqSSbVNc94/fRnZjngfKS0QW8pkjckwHQ
         FweU1E85GhJXl2ETR1JHN2R2T6m0gQ5P7VbClOl/CGkI9k7jldvIVGppwA4phsMtWlcS
         tyUQ/ihG4uDDSm6MyZLaVUsVsTCXVcvhr3icFKCCaFiFoAdvBgKad+99t8PdjaVWtBZD
         Ka9hHIJdqNbojjslNBxCbg1FXAJAvf+iKoy+SEMFi5KvIhKQLztzPAZ/0glCnXg+u6pp
         vtt6cD2HwmtfiK9tfQHm6D2MCac6p95KH0+RT3eiXgc3RzqlxAM6UA6hn3IXU/Akkz0A
         99rA==
X-Gm-Message-State: AOAM530xj9TFo1o09zCDAqb/1cFW2jupyxlfEbxspnjdsDO2o3LwTPzT
        02XWz+oDpa7ioZcrQDGGys0+S9ohndc=
X-Google-Smtp-Source: ABdhPJwBzYIyToVpArPuw2He0QXwx2mOIMywHKSfnrNiAmCbIkMZwVY66SomQGvg/9pzXVrEf3Q/Og==
X-Received: by 2002:a05:600c:1596:: with SMTP id r22mr2360956wmf.33.1643730594846;
        Tue, 01 Feb 2022 07:49:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r8sm15065267wrx.2.2022.02.01.07.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 07:49:54 -0800 (PST)
Message-Id: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Feb 2022 15:49:47 +0000
Subject: [PATCH 0/6] [RFC] partial-clone: add ability to refetch with expanded filter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a filter is changed on a partial clone repository, for example from
blob:none to blob:limit=1m, there is currently no straightforward way to
bulk-refetch the objects that match the new filter for existing local
commits. This is because the client will report commits as "have" during
negotiation and any dependent objects won't be included in the transferred
pack. Another use case is discussed at [1].

This patch series proposes adding a --refilter option to fetch & fetch-pack
to enable doing a full fetch with a different filter, as if the local has no
commits in common with the remote. It builds upon cbe566a071
("negotiator/noop: add noop fetch negotiator", 2020-08-18).

To note:

 1. This will produce duplicated objects between the existing and newly
    fetched packs, but gc will clean them up.
 2. This series doesn't check that there's a new filter in any way, whether
    configured via config or passed via --filter=. Personally I think that's
    fine.
 3. If a user fetches with --refilter applying a more restrictive filter
    than previously (eg: blob:limit=1m then blob:limit=1k) the eventual
    state is a no-op, since any referenced object already in the local
    repository is never removed. Potentially this could be improved in
    future by more advanced gc, possibly along the lines discussed at [2].

[1]
https://public-inbox.org/git/aa7b89ee-08aa-7943-6a00-28dcf344426e@syntevo.com/
[2]
https://public-inbox.org/git/A4BAD509-FA1F-49C3-87AF-CF4B73C559F1@gmail.com/

Robert Coup (6):
  fetch-negotiator: add specific noop initializor
  fetch-pack: add partial clone refiltering
  builtin/fetch-pack: add --refilter option
  fetch: add --refilter option
  t5615-partial-clone: add test for --refilter
  doc/partial-clone: mention --refilter option

 Documentation/fetch-options.txt           |  9 ++++
 Documentation/git-fetch-pack.txt          |  4 ++
 Documentation/technical/partial-clone.txt |  3 ++
 builtin/fetch-pack.c                      |  4 ++
 builtin/fetch.c                           | 18 ++++++-
 fetch-negotiator.c                        |  5 ++
 fetch-negotiator.h                        |  8 ++++
 fetch-pack.c                              | 57 +++++++++++++++--------
 fetch-pack.h                              |  1 +
 remote-curl.c                             |  6 +++
 t/t5616-partial-clone.sh                  | 42 ++++++++++++++++-
 transport-helper.c                        |  3 ++
 transport.c                               |  4 ++
 transport.h                               |  4 ++
 14 files changed, 146 insertions(+), 22 deletions(-)


base-commit: 5d01301f2b865aa8dba1654d3f447ce9d21db0b5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1138%2Frcoup%2Frc-partial-clone-refilter-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1138/rcoup/rc-partial-clone-refilter-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1138
-- 
gitgitgadget
