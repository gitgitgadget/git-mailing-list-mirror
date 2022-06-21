Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F01FC43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 22:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354787AbiFUWoK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 18:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiFUWoI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 18:44:08 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB7D31DD7
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:44:07 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id s1so20861607wra.9
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QaoiW2/puoKZXZuF4QtRQHLxn48F61wHJA2Rxr4TPEQ=;
        b=UJkX7IfxZiCFjOMrCigK+temhP1sS/OCKk+3o4nImiZbMl60jWFRcXWXlIuKlIJojV
         Nplllnvchd0RjDVc8P6r05NttZsLOPoDV2mMHU61M6N/UCE7blVsJqFcKlOJ5IblDTiU
         LqD606M2+y6kkwJOV/xnd1kIwom26D5VtYjvO6gkx1+b+ullcZ+QSrdeGgqCXsbb8vBu
         nyoNtzZGun5VFS4CRwtah9dNgCyotWz6GWbBal3/u9ztCp4h+3qabxRhV+F/C3Wrzgzs
         Id1zspsLja4ZD5NsdonbEwxwFHXX6dBaSLSXf11/sL5s9pGC1PuYRvGlqct9nc3bfpEo
         5+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QaoiW2/puoKZXZuF4QtRQHLxn48F61wHJA2Rxr4TPEQ=;
        b=wgrWvVRG6zcknCjsN0fX74EER0Y9DgwSkTYL3vzWAwyYoZVriXIRukhHZK+CU+UbWe
         4hmpNUybYxteo7IBBxvH6DSFs3h2ioLZnAWpzWFgmpdq7r2D8Uw/emqDicY5yBcR42Vb
         yy1FpfHhMDl2eahmKLcM3o8o9ilEzk+44+NzBroWhSnpro75jJW3Wen3bGtbtFpX0y2s
         FgCkAkXaoBwyyH2zRUi4k6JOlDGI3Ot/8DG7nZZ6aNJAkfmKuEaFURr1HJ4iLuy3qI/E
         G2o4VDHbIraD0TiNluhgQ0KqnkBqYJ5zr/Tvbd/LtoF0tWLnnCRCVwgyPhx5Psy4qL+V
         UTvw==
X-Gm-Message-State: AJIora8LnSmUS78AGuqUoiQ3YzzuWfKVo+tfXutvkklAeUcYvFcvjY5D
        p7oq9T+D4NqQfpCnKn8PBLU3R/oz99czwg==
X-Google-Smtp-Source: AGRyM1thl3XcfPVb5mMS/oP3hzX6epTXE0K6R8mog+WZSrI+p4rIVKN1EjLeCfcZEkpfk894TX8c2g==
X-Received: by 2002:adf:d1ea:0:b0:210:3e22:51b0 with SMTP id g10-20020adfd1ea000000b002103e2251b0mr262789wrd.72.1655851445996;
        Tue, 21 Jun 2022 15:44:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j12-20020a5d564c000000b0021b9585276dsm4024261wrw.101.2022.06.21.15.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 15:44:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] add and apply a rule to find "unused" init+free
Date:   Wed, 22 Jun 2022 00:44:01 +0200
Message-Id: <cover-v2-0.2-00000000000-20220621T223954Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <patch-1.1-7d90f26b73f-20220520T115426Z-avarab@gmail.com>
References: <patch-1.1-7d90f26b73f-20220520T115426Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This re-roll of [1] gets to the same end-state as far as the changed C
code is concerned, but I rewrote the coccinelle rule to be much more
general, based on the more recent discussion at [2].

See the "contrib/coccinelle/unused.cocci" part of 1/2 for extensive
commentary and what the rule does & doesn't spot, which I won't repeat
here.

The 2/2 is then split up to show the effect that "when strict" has on
this.

I noted in [2] that I had a WIP rule to to remove that unused
"get_worktrees()" but couldn't figure out a bug, this coccinelle code
will properly remove that sort of code, but only if it's actually
unused.

1. https://lore.kernel.org/git/patch-1.1-7d90f26b73f-20220520T115426Z-avarab@gmail.com/
2. https://lore.kernel.org/git/220620.865ykvw2l4.gmgdl@evledraar.gmail.com/

Ævar Arnfjörð Bjarmason (2):
  cocci: add and apply a rule to find "unused" variables
  cocci: remove "when strict" from unused.cocci

 builtin/fetch.c                 |  3 +-
 builtin/merge.c                 |  4 ---
 builtin/repack.c                |  2 --
 contrib/coccinelle/unused.cocci | 64 +++++++++++++++++++++++++++++++++
 contrib/scalar/scalar.c         |  3 +-
 diff.c                          |  2 --
 6 files changed, 66 insertions(+), 12 deletions(-)
 create mode 100644 contrib/coccinelle/unused.cocci

Range-diff against v1:
1:  7d90f26b73f < -:  ----------- cocci: add and apply a rule to find "unused" variables
-:  ----------- > 1:  d14036521ab cocci: add and apply a rule to find "unused" variables
-:  ----------- > 2:  4130dc15287 cocci: remove "when strict" from unused.cocci
-- 
2.36.1.1239.gfba91521d90

