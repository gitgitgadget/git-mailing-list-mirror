Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A16851F406
	for <e@80x24.org>; Mon, 14 May 2018 21:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752098AbeENV4i (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:56:38 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:36007 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752054AbeENV4h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:56:37 -0400
Received: by mail-vk0-f74.google.com with SMTP id g134-v6so17207102vke.3
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=ibRZriZuBE3XaQL7bGzYt6HhmaVK1J1VKSMndVv6BH4=;
        b=IBzyP333uRXHW+1Kp6cKybkXj4CNXReVV/cQmadXqv1RbsvSL2XtuoyGXolfIZ/KhU
         bDNvUHm7jUS8/42090UY0XbiGlOP377+9Ch5POmgxu5QlUsC2P6mVNlOUfDCq3caAlUJ
         uViCJZnD8EyIz2T7GuInUTF4nHipel6qJDtcpv/U4jOqf2G/cC/RMgIJhawHMUOregZq
         USlUOkQex9Yni99kKd6x2EHGcy8fbEZRuqfXgADsWSG9tfsE3AEB8ICC3a6qgj+bYLlX
         dwDG2GtOe5T7V4YMlCP2iezhdzHA/7QKA05TLTagfXhBNjGEDGXJ8UZVELgLCRVBFWmg
         yJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=ibRZriZuBE3XaQL7bGzYt6HhmaVK1J1VKSMndVv6BH4=;
        b=Drq8ShTvzZmhQ2Goqp7Nr2kWZqOjLk1Flp9rWnLmkTCH86TiMx3/M4774wIDrDz8kb
         mM3pGLXVXaqkqR0s56QN8Qan+MlRoXVxgeBc/t8YUKh1vjenTDy/UDI5b+5EAnYf2K02
         80wdwDj0hymncbEM3/tLY+f8QyH3TdFFhWUXBATJBrr9SalXVvz2fTdvi+Xnx0B2ZSC4
         GuiQSohpyYeatO7PGhFCCHKBHx0HGyXdlWUZeZz9newMV7PuTQTN/wMHOHzrEn/SBs7C
         y6ZCYgcIGFErj4tzSteVY3hSH+RCSEj+yxrhPBUCE8jS7nOtGWuWyqDZn9arW/pJQuEh
         M4og==
X-Gm-Message-State: ALKqPwfeQLvE0ESsesLdTaCdkBgy+qoqfVdekbirb3/tqP1Jjyk8Xgu0
        I4MRlJqWO1aWsKYr4R9q9RMjJvkhLFnb8adFd5HYdb5oTAx6t8QGVai25yeAfKEKsnggsdlkc0N
        iso38Wyjzn7hwcm7sx4ScZNKpiguMSz2YHqrbE7WlRAFs6lW1iIl9M5D1PA==
X-Google-Smtp-Source: AB8JxZp4smivYeHAMIIFprU1Tjxv7SMTaJdfgEx0CHmpVpDaXorJsdxRMCvVkSIMb7MRyAJsaGAHPcr9P/w=
MIME-Version: 1.0
X-Received: by 2002:ab0:5088:: with SMTP id c8-v6mr13196609uaa.43.1526334996519;
 Mon, 14 May 2018 14:56:36 -0700 (PDT)
Date:   Mon, 14 May 2018 14:55:51 -0700
Message-Id: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 00/35] refactoring refspecs
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When working on protocol v2 I noticed that working with refspecs was a
little difficult because of the various api's that existed.  Some
functions expected an array of "const char *" while others expected an
array of "struct refspec".  In all cases a length parameter needed to be
passed as a parameter as well.  This makes working with refspecs a
little challenging because of the different expectations different parts
of the code base have.

This series refactors how refspecs are handled through out the code base
by renaming the existing struct refspec to refspec_item and introducing
a new 'struct refspec' which is a container of refspec_items, much like
how a pathspec contains pathspec_items.  This simplifies many callers
and makes handling pathspecs a bit easier.

I have some follow on work which I'll build on top of this series, but
since this was already getting a bit lengthy at 35 patches I'll save
that for another time.

Brandon Williams (35):
  refspec: move refspec parsing logic into its own file
  refspec: factor out parsing a single refspec
  refspec: rename struct refspec to struct refspec_item
  refspec: introduce struct refspec
  refspec: convert valid_fetch_refspec to use parse_refspec
  submodule--helper: convert push_check to use struct refspec
  pull: convert get_tracking_branch to use refspec_item_init
  transport: convert transport_push to use struct refspec
  remote: convert check_push_refs to use struct refspec
  remote: convert match_push_refs to use struct refspec
  clone: convert cmd_clone to use refspec_item_init
  fast-export: convert to use struct refspec
  remote: convert push refspecs to struct refspec
  remote: convert fetch refspecs to struct refspec
  transport-helper: convert to use struct refspec
  fetch: convert fetch_one to use struct refspec
  fetch: convert refmap to use struct refspec
  refspec: remove the deprecated functions
  fetch: convert do_fetch to take a struct refspec
  fetch: convert get_ref_map to take a struct refspec
  fetch: convert prune_refs to take a struct refspec
  remote: convert get_stale_heads to take a struct refspec
  remote: convert apply_refspecs to take a struct refspec
  remote: convert query_refspecs to take a struct refspec
  remote: convert get_ref_match to take a struct refspec
  remote: convert match_explicit_refs to take a struct refspec
  push: check for errors earlier
  push: convert to use struct refspec
  transport: convert transport_push to take a struct refspec
  send-pack: store refspecs in a struct refspec
  transport: remove transport_verify_remote_names
  http-push: store refspecs in a struct refspec
  remote: convert match_push_refs to take a struct refspec
  remote: convert check_push_refs to take a struct refspec
  submodule: convert push_unpushed_submodules to take a struct refspec

 Makefile                    |   1 +
 branch.c                    |   7 +-
 builtin/clone.c             |  13 +-
 builtin/fast-export.c       |  22 +--
 builtin/fetch.c             | 128 +++++++-------
 builtin/merge.c             |   1 +
 builtin/pull.c              |   9 +-
 builtin/push.c              |  80 ++++-----
 builtin/remote.c            |  37 ++--
 builtin/send-pack.c         |  24 +--
 builtin/submodule--helper.c |  14 +-
 checkout.c                  |   5 +-
 http-push.c                 |  18 +-
 refspec.c                   | 194 +++++++++++++++++++++
 refspec.h                   |  44 +++++
 remote.c                    | 324 ++++++++----------------------------
 remote.h                    |  48 ++----
 submodule.c                 |  19 +--
 submodule.h                 |   3 +-
 transport-helper.c          |  39 ++---
 transport.c                 |  51 ++----
 transport.h                 |   4 +-
 22 files changed, 514 insertions(+), 571 deletions(-)
 create mode 100644 refspec.c
 create mode 100644 refspec.h

-- 
2.17.0.441.gb46fe60e1d-goog

