Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A030C38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 13:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FF8820870
	for <git@archiver.kernel.org>; Thu,  7 May 2020 13:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qeh9uQro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgEGNRq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 09:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbgEGNRp (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 09:17:45 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531C3C05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 06:17:45 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z6so6800413wml.2
        for <git@vger.kernel.org>; Thu, 07 May 2020 06:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=roesc0R7rf5z7+M51Nny255rPoiJGZ01wPexEggVa4Y=;
        b=Qeh9uQro7F+6BC0WBxgyEkzW2FujPEe1o0rK+TwxwXqYj+Zi2PKCurWGnr8GXVq2WR
         6G5M1hUVKzSh7beJZcz5PS13i2/uYGtwwZprU/qpeQh18dRy8FkO7+bU5oXtYc31gi8l
         j1alVJumHGtO+p3YeTcd8K3qf49OnBPtzKagzp2siGtYyOzAsFYSKIKUXq2GgbNvLcqK
         ygM1VmZASg+mdGTQeruWM+shFCnglcjkZ+OU4s/qrjpICApowYAzltQDN4Own0ZNw9yN
         +JF8U8tquFOlLt8XasnjrWW5EIQDRs6A9ADB5loq7WAwDnxu/Oj3kRl/rsB74JPTyCQa
         b88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=roesc0R7rf5z7+M51Nny255rPoiJGZ01wPexEggVa4Y=;
        b=k/5BO0+0+rtSl86Gnzxsq/hTLPSEeZ20n0kBRMEXGMfCHKj01fbiyng95Et0AByeuv
         EV5YpzS5iRPHMmDDJoHj5QJFvLmAaUgUlq1LL+bfIRd8C5ImKIp3UiC80sK4c9IinsjY
         5z1emPfdsIgp+OFaHnXHjYU7TPn9FcXjqzQYjbtKcA87rX2T/G1WbhQdRrHeVfBhYCES
         ISGXo8SBQKpSdmRehuidjfIBZfXMF+WvG0t023nyrkfvSZgzHPPR2c6GZEgenVRSGJ4w
         yf+B1uLwdGpzTDQpiUcMAQVKaHEzHhbhyRIDHBRBcLdk3maAsHPX2vde5S4/Dpcy1Z0U
         P4TA==
X-Gm-Message-State: AGi0PuazYvNfA3cPLQcr/ngct/DLzm6MviNOmC/GpTBWndbIewQY5+so
        F0b6HX+2144M2+K+LYaWEAemahB6
X-Google-Smtp-Source: APiQypJs4Mxo+MzRRDGgVH81cbcJcQq/fMgcnrw6MIe9/kWHHQHEVv/kn9ouLvzthsnXi/x1/lxQ/g==
X-Received: by 2002:a1c:2b81:: with SMTP id r123mr10228782wmr.34.1588857463593;
        Thu, 07 May 2020 06:17:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b20sm6762296wme.9.2020.05.07.06.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 06:17:43 -0700 (PDT)
Message-Id: <pull.627.git.1588857462.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 May 2020 13:17:32 +0000
Subject: [PATCH 00/10] [RFC] In-tree sparse-checkout definitions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmaill.com, peff@peff.net, me@ttaylorr.com,
        jrnieder@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on ds/sparse-allow-empty-working-tree.

BACKGROUND
==========

After discussing the future of sparse-checkout at the Git Contributor
Summit, Minh Tai caught me during the break to introduce a very interesting
idea: in-tree sparse-checkout definitions.

Here is the context: I was talking about how the Office team is building a
tool to update the sparse-checkout definition dynamically as their build
definitions change. They have a very compartmentalized build system, and
certain "projects" depend on each other. To ensure that builds do not break
as dependencies change, the plan was to have this tool run as a hook when
HEAD changes. This is a bit expensive to do, and we were discussing how much
we need this to be automated versus a part of the build process.

This kind of idea would need to be replicated for every team that wants to
use sparse-checkout in this way. That doesn't bode well for wide adoption of
the feature.

IN-TREE SPARSE-CHECKOUT DEFINITIONS
===================================

Minh's idea was simple: have sparse-checkout files in the working directory
and use config to point to them. As these in-tree files update, we can
automatically update the sparse-checkout definition accordingly. Now, the
only thing to do would be to ensure that the sparse-checkout files are
updated when someone updates the build definitions. This requires some extra
build validation, but would not require special tools built on every client.

As soon as I sat down to implement this idea, I discovered some
complications to that basic idea. Each of these sparse-checkout definitions
should fit a "role" on the team. To continue with the Office analogy,
suppose we had a definition for developers working on each of Word,
PowerPoint, and Excel. What happens when someone wants to port a feature
from Excel to Word? That user would want to take the union of the two
sparse-checkout definitions. But what does that mean when we are working
with arbitrary sparse-checkout files?

This leads to the restriction that I built into this feature: we only care
about "cone mode" definitions. These rely on directory-based prefix matches
that are very fast. With this restriction, it is simple to understand what
the "union" operation should do: take all directories that would be included
by either.

Once we restrict to cone mode, there is no reason to continue storing files
using the sparse-checkout file format. The list of patterns is larger than
the input to "git sparse-checkout set" or output from "git sparse-checkout
list" in cone mode, and more prone to user error. Thus, let's be simpler and
use a list of directories to specify the sparse-checkout definition.

This leads to the second issue that complicates things. If a build
dependency changes to a core library, but there are N "roles" that depend on
that library, then the person changing that library also needs to change and
validate N sparse-checkout definitions! This does not scale well. So, let's
take a page from build dependencies and allow these in-tree sparse-checkout
definitions to depend on each other!

The end result is a mechanism that should be flexible enough to future needs
but simple enough to build using existing Git features. The format re-uses
the config file format. This provides good re-use of code as well as being
something easy to extend in the future. In Patch 4, I tried to describe
several alternatives and why this is the best of those options. I'm open to
suggestions here.

OUTLINE
=======

 * Patch 1 is a bugfix that should work on its own. I caught it in tests
   after Patch 5.
   
   
 * Patches 2-7 implement the feature.
   
   
 * Patches 8-9 make the Git build system a bit more robust to missing
   directories.
   
   
 * Patch 10 adds a .sparse directory to Git as well as two in-tree
   sparse-checkout definitions. One is for a bare-bones Linux developer and
   the other adds the compat code for Windows on top.
   
   

As mentioned in patch 10, this allows the following workflow for Git
contributors that want to "eat our own dogfood" with the partial clone and
sparse-checkout features:

 $ git clone --sparse --filter=blob:none https://github.com/git/git$ cd git
$ git sparse-checkout set --in-tree .sparse/base.deps

Then, we have a smaller working directory but can still build and test the
code.

FUTURE DIRECTIONS
=================

There are definitely ways to make this feature more seamless, or more useful
to us.

 * It would be nice to extend git clone to have a string value to 
   --sparse=<file> and possibly have it multi-valued. This would initialize
   the in-tree sparse-checkout definition immediately upon cloning.
   
   
 * I think there are some ways we could reorganize the Git codebase to make
   our "most basic" sparse-checkout file have even fewer files. Mostly, it
   would require modifying the build to ask "do these files exist on-disk?
   if not, then disable this build option." This would also require adding
   test dependencies that also disable some tests when those do not exist.
   
   
 * Currently, if we have an in-tree sparse-checkout definition, then we
   can't add more directories to it manually. If someone runs git
   sparse-checkout set --in-tree <file> followed by git sparse-checkout add
   <dir>, then will disappear as it is overridden by the in-tree definition.
   The only way I can think to get around this would be to add these
   directories through Git config, since we were using the sparse-checkout
   file as the storage of "what directories do I care about?" but it is no
   longer the source of truth in this situation. I'm open to ideas here, and
   it would be nice to have this interaction hardened before moving the
   series out of RFC status.
   
   

Thanks, -Stolee

Derrick Stolee (10):
  unpack-trees: avoid array out-of-bounds error
  sparse-checkout: move code from builtin
  sparse-checkout: move code from unpack-trees.c
  sparse-checkout: allow in-tree definitions
  sparse-checkout: automatically update in-tree definition
  sparse-checkout: use oidset to prevent repeat blobs
  sparse-checkout: define in-tree dependencies
  Makefile: skip git-gui if dir is missing
  Makefile: disable GETTEXT when 'po' is missing
  .sparse: add in-tree sparse-checkout for Git

 .sparse/base.deps                     |  19 ++
 .sparse/windows.deps                  |   3 +
 Documentation/config.txt              |   2 +
 Documentation/config/sparse.txt       |  15 +
 Documentation/git-sparse-checkout.txt |  70 ++++-
 Makefile                              |  19 +-
 builtin/commit.c                      |   4 +-
 builtin/read-tree.c                   |   4 +
 builtin/sparse-checkout.c             | 268 +++--------------
 read-cache.c                          |   8 +-
 sparse-checkout.c                     | 418 ++++++++++++++++++++++++++
 sparse-checkout.h                     |  30 ++
 t/lib-gettext.sh                      |   1 -
 t/t0200-gettext-basic.sh              |   6 +-
 t/t1091-sparse-checkout-builtin.sh    | 143 +++++++++
 t/test-lib.sh                         |   7 +-
 unpack-trees.c                        |  10 +-
 17 files changed, 785 insertions(+), 242 deletions(-)
 create mode 100644 .sparse/base.deps
 create mode 100644 .sparse/windows.deps
 create mode 100644 Documentation/config/sparse.txt
 create mode 100644 sparse-checkout.c
 create mode 100644 sparse-checkout.h


base-commit: ace224ac5fb120e9cae894e31713ab60e91f141f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-627%2Fderrickstolee%2Fsparse-checkout-in-tree-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-627/derrickstolee/sparse-checkout-in-tree-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/627
-- 
gitgitgadget
