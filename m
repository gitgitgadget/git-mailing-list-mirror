Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24320C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiLOJ7Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiLOJ7L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:59:11 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713D0193EB
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:59:10 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id y16so2490261wrm.2
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FfgdCVUC8SJagDcMpljlwGpTFQApFDpg6PYQFcTYwxQ=;
        b=hF0BiQtLFTF70aLFaAXDgm9aPHQrdr77ppDDt4OVpb7qYGj/wZPPXOKcu5LJD/ri3h
         zzcvVntm7tt+xYv8uLpT9osbPBKv2QQtUI2+1p+td9tibnVOSHApsO7uml9khue/Qqg+
         dvKMDVYu/jHXCi87cOYNiY5njI16j51atRNfKwKDTBVoylcbeB3KazV0oCffXjI3f35c
         jT0PyGn4bSQY7Ht4TQSxwZ2QPKsKMGj4DLVp43p4vcRqpw7pPVG9PZwiHA7Lh4tno1uF
         NXYTUN152AuYea6g+OtP/cexRdtqsXTFCq8JaEi7mTcQkqGuDgkMSvoBmYgfGs+0uk5W
         cjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FfgdCVUC8SJagDcMpljlwGpTFQApFDpg6PYQFcTYwxQ=;
        b=Owyc4teRUD0rLFoW3XlzOY0d0i46qBDJ1Qm8YiklO8OOfWdl+MDCxHB0Ai/yNyiWbW
         2iKbAW+bsQdMOTNiNJU59GUVJuUB1EgdbmJRfzxCXmvr/McwDviT9+xMpeBNteBa3Yjp
         VYjgeq7wkiAraHFMpCEg+NPI+GY0I4vZdTHZLjoeDbLyTIV9nSxcrPn0TLFh8mva3yye
         vdrPNVNjJ5U+MLBwlaDJ8F6h/YmwoJKDEKKj2iQsuObQqspk4DNTt8PlQoRGuZpptykL
         s8nSOHooEaMwFFc23k46Uq+ojtBkL7V4DTwBj9GF3xVsX+EpUZGErmJ+XKt0s0shh1/m
         5olQ==
X-Gm-Message-State: ANoB5pmHln+bzZqEhMdKyoW9groFZF7+fstOahbHD5nIxbDDdVnau5Ly
        gDo8y2/rm1mWVBZGHf3HY925vY+ZapagQg==
X-Google-Smtp-Source: AA0mqf5kNIy/J35csePfPpcPdx0kcOssL+pvpt6ICRGneaPLBpN4t1uDXeusTLRmyzCOjs6tQub1FQ==
X-Received: by 2002:a5d:5b1c:0:b0:242:1bdf:a02 with SMTP id bx28-20020a5d5b1c000000b002421bdf0a02mr18896319wrb.37.1671098348603;
        Thu, 15 Dec 2022 01:59:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a13-20020adfe5cd000000b00228cbac7a25sm5495948wrn.64.2022.12.15.01.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:59:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/6] remove USE_THE_INDEX_COMPATIBILITY_MACROS
Date:   Thu, 15 Dec 2022 10:58:59 +0100
Message-Id: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My recent now-landed topic[1] to remove most use of
"USE_THE_INDEX_COMPATIBILITY_MACROS" was merged in 041df69edd3 (Merge
branch 'ab/fewer-the-index-macros', 2022-11-28).

It left out use of the macros that would have conflicted with
in-flight changes, but as those topics have landed we can now complete
the migration.

As before this is almost entirely a matter of applying the existing
"pending" coccinelle rules, the exceptions being 1/6, and the *.h
changes where we remove the macro definitions (the macro users being
edited by coccinelle).

The 4-5/6 then handle some edge cases we had left (but the code change
itself is done by coccinelle).

1. https://lore.kernel.org/git/cover-v2-00.11-00000000000-20221119T125550Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (6):
  builtin/rm.c: use narrower "USE_THE_INDEX_VARIABLE"
  cocci & cache.h: fully apply "active_nr" part of index-compatibility
  cocci & cache.h: apply pending "index_cache_pos" rule
  cocci & cache-tree.h: migrate "write_cache_as_tree" to "*_index_*"
  cache-tree API: remove redundant update_main_cache_tree()
  cocci & cache.h: remove "USE_THE_INDEX_COMPATIBILITY_MACROS"

 builtin/am.c                                  |  6 ++--
 builtin/commit.c                              | 18 +++++-----
 builtin/merge.c                               |  8 ++---
 builtin/mv.c                                  |  8 +++--
 builtin/rm.c                                  |  2 +-
 builtin/stash.c                               | 11 +++---
 builtin/update-index.c                        |  4 +--
 builtin/write-tree.c                          |  5 +--
 cache-tree.h                                  | 15 --------
 cache.h                                       | 12 +------
 contrib/coccinelle/index-compatibility.cocci  | 36 ++++++++++++++-----
 .../index-compatibility.pending.cocci         | 24 -------------
 12 files changed, 62 insertions(+), 87 deletions(-)
 delete mode 100644 contrib/coccinelle/index-compatibility.pending.cocci

-- 
2.39.0.rc2.1048.g0e5493b8d5b

