Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F5DECAA24
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 17:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242093AbiHYRJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 13:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiHYRJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 13:09:57 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F19291
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 10:09:54 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m3-20020a05600c3b0300b003a5e0557150so3289151wms.0
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 10:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=k5B3mUHMyNS08CygNO1Lk9pViOn4ZepnWSLsnzWB1hU=;
        b=MNB3AEO9dGFadO4uVaUE9XNA6GD2/d5eu6kfE7dea2LQKOwkgmLFIoUheU3KXwqkFq
         uxKGEQqmnjJT/aiNSfjggVRh94jXUzfKr5SPK/a5NzmNuqS/Um7pPPWRjQ4Nq0Le5OXb
         1VBIKP6DV/YoL3ReIrxl4kZiSi0wcjibmxmamcHS57qxJTjrB0XFHDpVRq/1gyyybM9w
         Yef7czoPcO6cWVlI1boMxSF8+oj3Or1khrL1wM2CLJBR3tfpKrUCiKkWA6P7W//exi4O
         X0gv3Usrnlpcu5zzoHcQOzKyABkAswMjL0lNalZIz8LHj7eKB0/8z6jalTvQFMnKEx0l
         FaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=k5B3mUHMyNS08CygNO1Lk9pViOn4ZepnWSLsnzWB1hU=;
        b=OxvPhoHENP7Rgx4O3FSJpITGzln79qF7nofzKz7STL0rLnmLXx94rmhjM70N7dFnm+
         3kICd30o5Yc/5G5iJaOeB3BP60P2/qzuDVMa6Z5qow9z6Vu7Pii1qz6FpIvZCR1M8kHS
         D1kUelB44UHEmZJ7pLEWzl8a75tE9vUPHVtoYpwCoiYO8eflCCqlaNxwHrXeZZv9SCA/
         pW6MVwacIF4v9IOTdZK0kplv6l5SmBS/zMqTs/Py4tq0XKTwRQopLeHIgfaVmxjVTk7f
         vsIDVLs7ZnLq7KpDGN+26Qx/pLsJjhhMI8bGxOWg73GeF5cCQTvEf9rjElP15+Sl9Tvy
         dDMg==
X-Gm-Message-State: ACgBeo0zEjEQbz4J6VqF1h6+ZHydzO/0jiErEeJCXztrAgEM3p9b6IWp
        yft3zisSr9pAA8f7szABEZQiKVgQDRUGcw==
X-Google-Smtp-Source: AA6agR4vRmLJGLYw3XJpZ7oNGSkJhCVEqnbzbBB184WhqCv/9+l2fhakXnA6UKPTyYhO1Skba8dNPg==
X-Received: by 2002:a05:600c:a02:b0:39d:bdf8:a4f4 with SMTP id z2-20020a05600c0a0200b0039dbdf8a4f4mr2956802wmp.201.1661447392507;
        Thu, 25 Aug 2022 10:09:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bt4-20020a056000080400b0022583786cd9sm1583810wrb.111.2022.08.25.10.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 10:09:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] git-compat-util.h: change UNUSED(var) to UNUSED
Date:   Thu, 25 Aug 2022 19:09:47 +0200
Message-Id: <cover-0.2-00000000000-20220825T170709Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g8741a0e3ea3
In-Reply-To: <xmqq1qt4486e.fsf@gitster.g>
References: <xmqq1qt4486e.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 25 2022, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> What's happening here is that coccinelle can no longer properly parse
>> the file after the UNUSED() macros were applied to refs.c.
>
> Sigh.
>
>>      diff --git a/refs.c b/refs.c
>>      index 607694c2662..37e7d88920c 100644
>>      --- a/refs.c
>>      +++ b/refs.c
>>      @@ -442,7 +442,7 @@ struct warn_if_dangling_data {
>>       };
>>
>>       static int warn_if_dangling_symref(const char *refname,
>>      -                                  const struct object_id *UNUSED(oid),
>>      +                                  const struct object_id *oid UNUSED2,
>>                                         int flags, void *cb_data)
>>       {
>>              struct warn_if_dangling_data *d = cb_data;
>
> This is almost "the most simple and stupid and nobody would get
> confused" version, which I may actually be able to live with.
>
> Unfortunately it will not get the "somebody by mistake uses 'oid'
> and we can break the build no matter what compiler is used by them
> before sending the patch out to the list".
>
> Doing s/oid UNUSED2/oid_UNUSED/ without any __attribute__((unused))
> would give that benefit to us, but that won't squelch compilation
> with -Wunused which makes it a non-starter.

I think per the 2/2 that it should be OK, but if you still think it's
a non-starter we'll need some other approach.

When I merge this with "seen" it suggests no "unused.cocci" changes to
refs.c anymore, i.e. it unbroke the interaction between the UNUSED
topic in next and the change that happened to reveal it.

Ævar Arnfjörð Bjarmason (2):
  git-compat-util.h: use "UNUSED", not "UNUSED(var)"
  git-compat-util.h: use "deprecated" for UNUSED variables

 add-interactive.c           |  2 +-
 archive-tar.c               |  4 ++--
 archive-zip.c               |  4 ++--
 archive.c                   |  2 +-
 attr.c                      |  4 ++--
 bisect.c                    |  6 +++---
 bloom.c                     |  4 ++--
 builtin/am.c                |  2 +-
 builtin/bisect--helper.c    | 12 ++++++------
 builtin/checkout.c          |  4 ++--
 builtin/commit-graph.c      |  2 +-
 builtin/config.c            |  6 +++---
 builtin/describe.c          |  4 ++--
 builtin/difftool.c          | 10 +++++-----
 builtin/fast-export.c       |  2 +-
 builtin/fast-import.c       |  2 +-
 builtin/fetch.c             |  8 ++++----
 builtin/fsck.c              | 12 ++++++------
 builtin/gc.c                |  4 ++--
 builtin/log.c               |  4 ++--
 builtin/ls-tree.c           | 10 +++++-----
 builtin/multi-pack-index.c  |  2 +-
 builtin/name-rev.c          |  2 +-
 builtin/pack-objects.c      | 12 ++++++------
 builtin/receive-pack.c      |  4 ++--
 builtin/reflog.c            |  4 ++--
 builtin/remote.c            | 14 +++++++-------
 builtin/repack.c            |  4 ++--
 builtin/rev-parse.c         |  4 ++--
 builtin/show-branch.c       |  6 +++---
 builtin/show-ref.c          |  6 +++---
 builtin/stash.c             | 12 ++++++------
 builtin/submodule--helper.c |  4 ++--
 color.c                     |  2 +-
 commit-graph.c              |  4 ++--
 commit.c                    |  6 +++---
 compat/terminal.c           |  2 +-
 config.c                    |  8 ++++----
 convert.c                   |  4 ++--
 delta-islands.c             |  4 ++--
 diff.c                      |  4 ++--
 dir.c                       |  4 ++--
 environment.c               |  4 ++--
 fetch-pack.c                | 12 ++++++------
 git-compat-util.h           | 13 +++++++------
 gpg-interface.c             |  2 +-
 hashmap.c                   | 10 +++++-----
 help.c                      |  4 ++--
 http-backend.c              |  2 +-
 ident.c                     |  2 +-
 ll-merge.c                  |  2 +-
 log-tree.c                  |  2 +-
 ls-refs.c                   |  2 +-
 merge-recursive.c           | 12 ++++++------
 name-hash.c                 |  4 ++--
 negotiator/default.c        |  4 ++--
 negotiator/skipping.c       |  4 ++--
 notes.c                     |  4 ++--
 object-name.c               | 12 ++++++------
 object-store.h              |  2 +-
 oidmap.c                    |  2 +-
 packfile.c                  |  2 +-
 pager.c                     |  2 +-
 patch-ids.c                 |  2 +-
 pretty.c                    |  2 +-
 range-diff.c                |  2 +-
 ref-filter.c                |  2 +-
 reflog.c                    | 18 +++++++++---------
 refs.c                      | 12 ++++++------
 refs/files-backend.c        | 14 +++++++-------
 refs/iterator.c             |  6 +++---
 refs/packed-backend.c       | 16 ++++++++--------
 remote.c                    | 24 ++++++++++++------------
 replace-object.c            |  4 ++--
 revision.c                  | 18 +++++++++---------
 send-pack.c                 |  2 +-
 sequencer.c                 |  4 ++--
 server-info.c               |  2 +-
 shallow.c                   | 10 +++++-----
 strbuf.c                    |  2 +-
 streaming.c                 |  6 +++---
 strmap.c                    |  4 ++--
 sub-process.c               |  4 ++--
 submodule-config.c          |  8 ++++----
 submodule.c                 | 12 ++++++------
 t/helper/test-config.c      |  2 +-
 t/helper/test-ref-store.c   |  4 ++--
 t/helper/test-userdiff.c    |  2 +-
 trailer.c                   |  4 ++--
 transport.c                 |  2 +-
 upload-pack.c               |  6 +++---
 walker.c                    |  6 +++---
 wt-status.c                 | 16 ++++++++--------
 93 files changed, 270 insertions(+), 269 deletions(-)

-- 
2.37.2.1279.g8741a0e3ea3

