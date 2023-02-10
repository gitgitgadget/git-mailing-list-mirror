Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7879FC05027
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 10:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjBJK25 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 05:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBJK2v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 05:28:51 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CC16C7F8
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 02:28:50 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ba1so4583502wrb.5
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 02:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WD0W18k/H5+IC2GSkC5IjZ9XpSoFx/9PC/fJg95P2FQ=;
        b=nTFQIi5lea0Ku9lbW1zAcZEhcFqp2IrHPu1pw7uevi2+2GKteHPB3+zKdKd/TTV6dn
         TXrJKIa10/1XX9gCaa1Cl5isKYgmUW0VjPFTHItj56hF/K3xKm/KDI70Oue3Py6J09hj
         EOYGshuFD6gJTULfBbRLJapWJPv7TvNX9+ekk2SZXlqKUhn31yBbWovFQSMt7USsKuJz
         T4RBao/cFPhQS38KpSHoJW+IGBJ1GhgQJzba7UFoUgNt5T7dDXqDI4NmmG8U3xD1B5iA
         xFxzR7A2s7o7dPemwJsPcXJudcQV6AC3SuBsTzrhnoZUUUFttyHxU+vb/MCr3QR6iLQ7
         Znxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WD0W18k/H5+IC2GSkC5IjZ9XpSoFx/9PC/fJg95P2FQ=;
        b=tRq5Vh5DGi66/AXFoJO/o0si5y6smyxMki++ctgzie+/8UfXphLihiuBTSAB895rym
         p8/AXUEap4I2bIx0ns0pQ3gF2H4KzZkMNXSFJ6na2GPsEOQpv0y8ytahdhL3/s+CjfkH
         eJGAPjBiAxrT1bxkSkLAkj3QB2en2vmTp8MQedS+SAJcKUnxKeeR1xNibjgqcgr1XldI
         k6zD3b8o3WjHRj4+NM0j1rR417Yg3KjH4/J+lnZsKKBK4Bk+vbjLEJ/JFm/n79za6Tzh
         IPvNAdv7YWH0xQyJVbBLebwpn8LX4e4aR/NN1g5ooZOvYQJDB34H/SuVc1v/9wOPkdUb
         zpjg==
X-Gm-Message-State: AO0yUKXB1ddUf/Z0JsV2lQVfGzxBVP9Ba6a5obC4lbtEBp/wp6fA9j0P
        TJkqJ4r2RgWCD9qLMvzxAasL7SXVov6PuyN2
X-Google-Smtp-Source: AK7set+6ztpfZzvXiee+S/3UcO0lLm/P9PeguK4o+1emArIp0dEGlbwr0C0aQT44Xaga1xPbkvGFmw==
X-Received: by 2002:adf:f34d:0:b0:2c5:3fcb:681e with SMTP id e13-20020adff34d000000b002c53fcb681emr3784266wrp.4.1676024928301;
        Fri, 10 Feb 2023 02:28:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d514d000000b002c3f50228afsm3244792wrt.3.2023.02.10.02.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 02:28:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/6] remove USE_THE_INDEX_COMPATIBILITY_MACROS
Date:   Fri, 10 Feb 2023 11:28:33 +0100
Message-Id: <cover-v2-0.6-00000000000-20230210T102114Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1475.gc2542cdc5ef
In-Reply-To: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most of our use of these compatibility macros went away with
041df69edd3 (Merge branch 'ab/fewer-the-index-macros', 2022-11-28) ,
which was part of v2.39.0.

That topic left out these stragglers, as some of this would have
conflicted with in-flight topics, and I'd skipped the cache-tree.h
cases altogether.

The update in v2 is trivial, just to rebase the series for changes on
"master". There are no semantic or textual conflicts with "seen"
either, so finishing this migration before we get another user of them
would be nice.

The v1 had a side discussion that didn't need resolving here. The
question was what a series like this might do if we needed to convert
library code to make new use of "the_index" (as opposed to converting
the functions themselves to take it from their callers).

That's an interesting question, but irrelevant to this topic, as
there's no such library users to deal with, and this migration closes
the door on that hypothetical question needing to be addressed in the
future.

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

Range-diff against v1:
1:  3517389f732 = 1:  916761cb50f builtin/rm.c: use narrower "USE_THE_INDEX_VARIABLE"
2:  03c6e404367 = 2:  6040edad622 cocci & cache.h: fully apply "active_nr" part of index-compatibility
3:  2dbe4f45363 = 3:  3e9d97dbff2 cocci & cache.h: apply pending "index_cache_pos" rule
4:  679ddc857c1 ! 4:  e36a0ae562f cocci & cache-tree.h: migrate "write_cache_as_tree" to "*_index_*"
    @@ builtin/am.c
      #include "config.h"
      #include "builtin.h"
     @@ builtin/am.c: static void do_commit(const struct am_state *state)
    - 	if (run_hooks("pre-applypatch"))
    + 	if (!state->no_verify && run_hooks("pre-applypatch"))
      		exit(1);
      
     -	if (write_cache_as_tree(&tree, 0, NULL))
5:  7f956fd8b75 = 5:  ab8794da29c cache-tree API: remove redundant update_main_cache_tree()
6:  4807a3fe8ff = 6:  77c30cfe455 cocci & cache.h: remove "USE_THE_INDEX_COMPATIBILITY_MACROS"
-- 
2.39.1.1475.gc2542cdc5ef

