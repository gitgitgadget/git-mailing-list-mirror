Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CB5C433EF
	for <git@archiver.kernel.org>; Sun, 10 Apr 2022 11:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbiDJLVf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Apr 2022 07:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbiDJLVc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Apr 2022 07:21:32 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80AD140A7
        for <git@vger.kernel.org>; Sun, 10 Apr 2022 04:19:21 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso8331757wml.5
        for <git@vger.kernel.org>; Sun, 10 Apr 2022 04:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x3G7OVa3PD6L8799KCjW3lXCa7beTCVs2e8gdcLlRV8=;
        b=dYCljflr8zqs8C5bIl/wYbjr1l2qErcDMnfpbYF4rk9MSzeBx+FH/N1dqhy5bltJYS
         oLf40/5wqTwVk6XLuIsHFoFH41ZFRkW1mAmNnFd3Vcav/3BCWmr+4AwfsahY45RaAqPm
         bJE61sCXBSK5UezAGQcWdYD4l3WU0eJ5m+oPTBkBfrgNqHlZN8GaSfQNeGfMtAc4b9Zj
         fa01arFU9Rx04VNnhVsIqoWm4hTOm87kPssP2qQtxq6pLkmoBBJrSxAx7Zog78iZjxZL
         E9IePlqQQzY1aIo89UQVGMD3Aq5V0mt0NQVrAOrYAbGDC6XsIMgo4rc+dvCK3zgdUcEa
         DBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x3G7OVa3PD6L8799KCjW3lXCa7beTCVs2e8gdcLlRV8=;
        b=pFPrkz5CfvOPR3vd6Z1Ilf4lTLpXKRQkWq7zrJebTmaBuU1uGItT3YvHO0E8VJdQCs
         n+vB8Kk4IxdY1A14/kddjisPUIdWgW1+ayWbC8vudJTBIXsKGC/Ikj7lCMb2srdBlddp
         sAoRhiE5ZEHqNPMg3p/Ib3PK6W97xsJDsTYjme++uqmKfIbDEgxB7PtZEb4g1K+/4uQN
         kJc29Z2m6RgQcvK2jL5bznb4lYWJxW4AHpsxJxWjOowqdYGFk57b/4wscuv8W1NbTZAk
         zk6zQLaNUoHVoxOKtSLLk401uSfXKeUvrGvfQJ7IUa7u1vJ6DiRouzDJXty4e5MOCRjN
         Okqg==
X-Gm-Message-State: AOAM5303pL4W9c0Rr8+xuIDUdPUVBRbpE3fC1WJuA2uXQ6Idwg/KrE+U
        6lYamnA2CVzpa5kyKzAAhrg0ZOG1cKw=
X-Google-Smtp-Source: ABdhPJxgMjtzyzZwcRkkJ4fc+CbZJLXXD4eXiHsSolRc2pxrjHxMnw+wI/8tH8WAvBt01LbMwG/5fA==
X-Received: by 2002:a05:600c:4e52:b0:38c:f41f:3718 with SMTP id e18-20020a05600c4e5200b0038cf41f3718mr25260278wmq.101.1649589559044;
        Sun, 10 Apr 2022 04:19:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2149:8a18:7100:c718:bf46:5915:85be])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0037bdfa1665asm19149452wmj.18.2022.04.10.04.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 04:19:18 -0700 (PDT)
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     git@vger.kernel.org
Cc:     matheus.bernardino@usp.br, mhagger@alum.mit.edu,
        Plato Kiorpelidis <kioplato@gmail.com>
Subject: [RFC PATCH 0/6][GSoC] iterate dirs before or after their contents
Date:   Sun, 10 Apr 2022 14:18:46 +0300
Message-Id: <20220410111852.2097418-1-kioplato@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello. Some time ago I worked on converting opendir/readdir calls to use
dir-iterator [1], however this cleanup required to iterate directory paths after
their contents. Matheus pointed me out to a previous patch series[2] that
attempted to implement such functionality in dir-iterator. From it, I mainly
used Michael's feedback and feature requests and tried to include it in my work.

My fork: https://github.com/kioplato/git/tree/dir-iterator
CI: https://github.com/kioplato/git/actions/runs/2141288008
There are some memleaks, I'll track them down in v2.

I aim to implement more functionality in dir-iterator, my goal being to simplify
the codebase by introducing an abstraction layer for iterating directories.
I would like to eventually simplify read_directory_recursive(). I wanted to
check in with you to make sure I'm heading in the right direction with what I've
implemented.
  * Are my tests overly exhaustive?
  * As of now we can't thoroughly test dir-iterator on directories with complex
  structure since readdir produce dirents with undefined order in a directory.
  I thought about introducing a tool for generating permutations with stable
  parts in test-lib. Is there a need to something like this for other tests?
  Or maybe should I sort each level iterated by dir-iterator inside
  test-dir-iterator before printing to stdout? In these patches I did enumerate
  the path permutations for some tests by hand, but that's not viable really.
  * We also don't test for deleted entries between dir_iterator_advance() calls.
  * Are my comments too much? Throughout git, .c files don't have many comments,
  should I remove mine as well? I think they provide better context when reading
  through the source code.

I do understand that it probably is too early to worry about most of these.
However I wanted to communicate my thoughts and setup for the following
versions.

While I wait for review, I'll implement/fix:
  * DIR_ITERATOR_RECURSE proposed here[3], but with finer control. Instead of a
  flag I'll introduce a new integer parameter in dir_iterator_begin(), which
  will specify the maximum iteration depth.
    * Supplying 0 will have the same behavior as DIR_ITERATOR_RECURSE i.e. it
    will iterate over the entries of the root directory.
    * Supplying -1 will iterate to maximum depth. This is the default right now.
  * DIR_ITERATOR_DIRS_ONLY proposed here[4]. Enabling this, dir-iterator will
  show only directories. Failing to enable DIR_ITERATOR_DIRS_BEFORE and/or
  DIR_ITERATOR_DIRS_AFTER will result in dir_iterator_begin() returning NULL.
  Is this a good way to encode "show only directories" in the flags?

I'll include them along with feedback and suggestions from this version in the
next one.

I didn't refactor entry.c to use dir-iterator. It's a good first issue for
someone else to become introduced to the community. I applied my patch[1] and it
does not pass t/, as it used to, because of 15th test in t1092. Should I work on
entry.c in my next version or leave it alone for a newcomer?

This serves as my microproject for GSoC. Could my future work on dir-iterator
and cleanup of read_directory_recursive() and other customers of dir-iterator
become a seperate GSoC project I could undertake?

[1]: https://public-inbox.org/git/20191208180439.19018-1-otalpster@gmail.com/
[2]: https://public-inbox.org/git/1493226219-33423-1-git-send-email-bnmvco@gmail.com/
[3]: https://public-inbox.org/git/CACsJy8DBa-oH3i+5P=iVr9NhJwsicZ43DO89WmvpYEQu90RrMw@mail.gmail.com/
[4]: https://public-inbox.org/git/xmqqmvc265hk.fsf@gitster.mtv.corp.google.com/

Plato Kiorpelidis (6):
  t0066: improve readablity of dir-iterator tests
  t0066: better test coverage for dir-iterator
  dir-iterator: refactor dir_iterator_advance()
  dir-iterator: iterate dirs before or after their contents
  t0066: remove redundant tests
  test-dir-iterator: handle EACCES errno by dir-iterator

 builtin/clone.c              |    4 +-
 dir-iterator.c               |  302 ++++++---
 dir-iterator.h               |   34 +-
 refs/files-backend.c         |    2 +-
 t/helper/test-dir-iterator.c |   23 +-
 t/t0066-dir-iterator.sh      | 1202 +++++++++++++++++++++++++++++++---
 6 files changed, 1371 insertions(+), 196 deletions(-)

-- 
2.35.1

