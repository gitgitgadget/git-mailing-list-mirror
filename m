Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AE2EB64DD
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 22:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjGTWSP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 18:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGTWSN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 18:18:13 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BED030E7
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 15:17:40 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-314172bac25so1037121f8f.3
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 15:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689891437; x=1690496237;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=al6PGyLOw8CwDE09wUraUyf3mLFgq9k1nVOXwmOHG74=;
        b=pD+zn2rIro9UJ/EeSd1uNNY8Byz72zlImGhiOoaw3oF2bJK2JpXLldoM4KO3rNZGsx
         0aFOowdsAypyVqg1+tp+PnDV4diPkemIfyC3VOsJ4+z9FpXPWaDIUgYohYrwgEHgXD25
         SzzIlZhIuyvkiwvu/XwQJDf3fa25Tm6ViqCeDqSqRaNyBqVvrRWwa/rj93mUy2tkVpDE
         a+Vg3JWVhzqMnuEvDwfq27KfjfVNy26Ip9fUhLqBP4GSp5+vl8IIpaXi390tOIufVmB5
         TWXHfGFOXmLleWhJrgbsDbPGi/tujLgh9WTNm1xX6VQStrLES6Vd+piPdVMo3sjnORGI
         D/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689891437; x=1690496237;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=al6PGyLOw8CwDE09wUraUyf3mLFgq9k1nVOXwmOHG74=;
        b=IJ1OQ4wtjk1/Ga14BP5MZK9x/IalKeRZnzbDSenJPkzMjPStB66t2usiG+5FOZVs9U
         kQacRVtAeFi/NPY4kZi70H0m3sT8J7aWgqEbT8FPkywsyP07/Ojg9gL0R1ZzsMFyVDF2
         NBKoXl+HjMa8/om0Z/fdI3TWwFBTpNJrPmlZiyWg3stsdM/FQPbW0Xshg8b/oThBnz8S
         tRt3HdeV7/0gajkT4Yy6YmUCQZvwsOCTAIMA6yCuLiM/891MtJDk6xr+iu3w+ZgpLBUh
         4zOlrgfNc5ZeKcje/9i6JmTrc17dyqgZgKitOUloorsQyzCTUrPlzsEQWieEM9ucev3I
         2qyw==
X-Gm-Message-State: ABy/qLY3ZPxGh1Sxr4FBfTtKyQvvMpviJgPpO52jfNHCg+9gGRQnqOeQ
        KIbLnaoUgZGbwd73JINw1c0JQJTgsY8=
X-Google-Smtp-Source: APBJJlGXDqUP2ZWPk+BF2Z0/7KrBeYFLO7biPxgausu91s8je/2G0GcZq1v7CBkO8hM6Ck95giG8Lw==
X-Received: by 2002:adf:e888:0:b0:314:3f82:7959 with SMTP id d8-20020adfe888000000b003143f827959mr54158wrm.14.1689891437267;
        Thu, 20 Jul 2023 15:17:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d6b8c000000b003143c6e09ccsm2420385wrx.16.2023.07.20.15.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 15:17:16 -0700 (PDT)
Message-ID: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Jul 2023 22:17:14 +0000
Subject: [PATCH 0/2] config-parse: create config parsing library
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Config parsing no longer uses global state as of gc/config-context, so the
natural next step for libification is to turn that into its own library.
This series starts that process by moving config parsing into
config-parse.[c|h] so that other programs can include this functionality
without pulling in all of config.[c|h].

To use config-parse.[c|h], an external caller has to obey our convention of
using "#include git-compat-util.h" at the start of the .c file. This is
doable by including the in-tree git-compat-util.h and linking against the
libgit.a Make target (which is admittedly cumbersome), and we've verified
this by compiling and linking to the library using the Google-internal
version of Bazel.

This series is not meant to distract from Calvin's git-std-lib series [1].
In fact, the two are complementary: git-std-lib will make it possible for
external callers to compile a smaller subset of files in order to use a
library. Doing this for config-parse will make config-parse easier to use,
while testing that git-std-lib does what we want it to.

I considered calling the library config-ll (like we do in other parts of the
codebase) instead of config-parse, with the intention of adding more "low
level" config code to it in the future. A benefit to that is that by having
fewer modules, dependency management is easier to reason about. However, I
struggled to think of what other config code could be considered "low level"
but doesn't make sense as its own module. (E.g. struct config_set is a low
level implementation detail, but I think it's well-scoped enough to be its
own config-set module.) I'd appreciate suggestions on how the config
libraries could be organized.

[1]
https://lore.kernel.org/git/20230627195251.1973421-1-calvinwan@google.com/

Glen Choo (2):
  config: return positive from git_config_parse_key()
  config-parse: split library out of config.[c|h]

 Makefile           |   1 +
 builtin/config.c   |   3 +-
 config-parse.c     | 611 +++++++++++++++++++++++++++++++++++++++++++
 config-parse.h     | 182 +++++++++++++
 config.c           | 636 +--------------------------------------------
 config.h           | 146 +----------
 submodule-config.c |   4 +-
 t/t1300-config.sh  |  16 ++
 8 files changed, 816 insertions(+), 783 deletions(-)
 create mode 100644 config-parse.c
 create mode 100644 config-parse.h


base-commit: aa9166bcc0ba654fc21f198a30647ec087f733ed
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1551%2Fchooglen%2Fconfig%2Fparse-lib-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1551/chooglen/config/parse-lib-v1
Pull-Request: https://github.com/git/git/pull/1551
-- 
gitgitgadget
