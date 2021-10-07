Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE1AC433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 19:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98BF9610A1
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 19:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243828AbhJGTJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 15:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbhJGTJM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 15:09:12 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C2CC061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 12:07:18 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i12so9560705wrb.7
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 12:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=/840E1OeiWI/JfRLNPo5xJL6D8nJTOtXLsEEZFWT0pE=;
        b=cm82vYFNiVFovVTZovaVAwMrdNnyc3BTAXQxRZFP0pE7XcYqtvnE79QjjjxSPzm+Wd
         7oT2lU1iQ4HFnhxEOKqFdk/1jGzkPJevbRaaLNtc6a1uJJ7WQexkIgojBRPJ3kXdFOtf
         9Hxylw0a2xutkCTgFJrALn2KYo6stnqkdOBE5iYn1Uca1qz/QFHOIx3qITxV3ekD6sQ9
         Usi/OwtvoqQeVjY9rwmPIaBSRcF4F/95cKzM2aLVKJaC1KwcZB5AsbVRyflmseqmcO4u
         rhGhKLLrph4M/8wOXPw1HGRYgUe0qdF5+BH52OsNyDLRzdB6xmmd24JPgdEajaO168PI
         hBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/840E1OeiWI/JfRLNPo5xJL6D8nJTOtXLsEEZFWT0pE=;
        b=G90ImMf6g+Yjw0dm75uQUv4fRIX9Wpdg9+2UhuGF0fT67sCREcBZdFsJlIH0+7OXas
         YP3EDumI4jzE4Oor5iBwgKPFgRbpVDIbk2F14EypYw1hBWnsOqSV6U22bZIGZla/qFY7
         qQcq2KQv0ov09yNnkuOX8Q4voP6N061fKeEcEm6DD3Yq31jq2pNJMW9ds1FHUPz4v6Wh
         3vaFs7yR0HieioBf6c8d0DRiWonmlKhqQCt2V56c2Ks4LZV2IdANOdrK3a87yBlijEEl
         zAd39gpMx3wLTuARRFj9vVGkJW7FngDqVeCXFwwXU6QvkF3Zx5oFW/1SwzR+lqXoJInJ
         nWHw==
X-Gm-Message-State: AOAM533OHA5L0YyFhrLD/46zo+vwUdlsKX6EHD2yNNX2ziPYfQWQ9s6w
        wJcGTsgIonOc92sO5wxbMF0owNpKSLM=
X-Google-Smtp-Source: ABdhPJw4P3ke2xF5fYD+Y3GgBmmuD/GekUmNtI37hKHkYtHBohqZJhh52ZXm9v1TK9ECfMiAEvCptw==
X-Received: by 2002:adf:fe4e:: with SMTP id m14mr7510748wrs.14.1633633636719;
        Thu, 07 Oct 2021 12:07:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p11sm7037690wmi.0.2021.10.07.12.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 12:07:16 -0700 (PDT)
Message-Id: <pull.1103.git.git.1633633635.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 19:07:13 +0000
Subject: [PATCH 0/2] remote: replace static variables with struct remote_state
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series aims to make the remotes subsystem work with non-the_repository,
which will allow submodule remotes to be accessed in-process, rather than
through child processes. This is accomplished by creating a struct
remote_state and adding it to struct repository.

One motivation for this is that it allows future submodule commands to run
in-process. An example is an RFC series of mine [1], where I tried to
implement "git branch --recurse-submodules" in-process but couldn't figure
out how to read the remotes of a submodule.

For the most part, this was a mechanical process of taking static variables
and putting them in a struct. As such, I think this series might benefit
from thoughtful review, especially from people with more insight into this
area. Some areas I am extra concerned about are:

 * Naming, especially the renaming of variables in patch 1 and the field
   names in patch 2. I don't really like the name "remote_state", but I
   can't think of a better one.
 * Memory leaks - I am not confident that remote_state_clear() frees all of
   the memory that it should. I tried to eliminate as many leaks as I could
   with "make SANITIZE=address,leak", but I'm not confident that I've caught
   them all.

[1] https://lore.kernel.org/git/20210921232529.81811-1-chooglen@google.com/

Glen Choo (2):
  remote: move static variables into struct
  remote: add remote_state to struct repository

 remote.c     | 245 ++++++++++++++++++++++++++++++---------------------
 remote.h     |  69 +++++++++++++--
 repository.c |   8 ++
 repository.h |   4 +
 4 files changed, 222 insertions(+), 104 deletions(-)


base-commit: 0785eb769886ae81e346df10e88bc49ffc0ac64e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1103%2Fchooglen%2Fremote%2Fstruct-no-global-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1103/chooglen/remote/struct-no-global-v1
Pull-Request: https://github.com/git/git/pull/1103
-- 
gitgitgadget
