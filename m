Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16C6C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A70496112F
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346009AbhIGTnv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 15:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345764AbhIGTnt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 15:43:49 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C7DC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 12:42:42 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q11so16097927wrr.9
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 12:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V2hvaqR0mvKbLU2cHSEKbTXghosh/yilvLG7gjbR4nE=;
        b=ORrgXJojJ3OajHoE7uLK/cqoFn8sCU5QWlZFAjx26HWWtfYCa+toWLS7QeSVE02PMj
         FhgRrPbOTRurXg98U65GxKacNdLTZB/U/0Pt9pjnJroPTPzV7B8koxFfh2dYxMjzXqtD
         DXbd6AXU3++ib/4UnlbFlIfI8gdXZeb9l8WrzKbZdpNMhKdmpHDTDfggfPbqSevH0dLh
         itvZnoVp6JWfc+eIbflsM64UD4VxB+RPZomN6+gw4A2P8MN074ZV5ByycyAPjvuKUdjn
         G7wHfaGzwSUQrpW2FNe5vUi/eavKOiRAcq/efDW3sIf/AVmfYqKBgNuqwNsfh3EOOnet
         HZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V2hvaqR0mvKbLU2cHSEKbTXghosh/yilvLG7gjbR4nE=;
        b=OBjwJMVWxVept9pNXyKWhHPklKfxWBnV0qAG5o82p0J/LzQxH3//R1INKa8rj8pCRP
         uAY/XKB+ciOXeCcMnuYixt3cQX6EUtvcfjvZ25d1WJ3alpeaAKX36EG+yjA7SWHVJhVZ
         9FTQAaTgRiLk/HeR3EK/TW3HRWwtC9xUSmMQ0iSY6KPn8YneLOfyB84jMhkVPTKwpE6O
         wzhMmo2CQM/U9W88sv411GmPzx0wdezpWyOPa+XPclBtKaZhtTaiXk8Q/DqGu5qZ6p74
         4q8B/AgV0OCswBOL0E1OLQimOdS3KfhRX2A1acZyGCDR7E49qm36DYm1p+jjPXAcaFBb
         QdVA==
X-Gm-Message-State: AOAM5330gz1ODNmflp/7KWO3ekjyYonjtE53Ezj6RHplh4ZUlTZge89A
        /pJ/TxqCibZ07kKp3BYhPigEwsm+9qYa/Q==
X-Google-Smtp-Source: ABdhPJwbYn7qmNSbRCKy8Ch+dsXQ2ZjhSYt+8VtQvCkLJP5bNZukz5n/sDOPLBZGxv/5lRNlcB5O3Q==
X-Received: by 2002:adf:c550:: with SMTP id s16mr54612wrf.25.1631043761217;
        Tue, 07 Sep 2021 12:42:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a10sm12075320wrd.51.2021.09.07.12.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 12:42:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] rename *.idx file into place last (also after *.bitmap)
Date:   Tue,  7 Sep 2021 21:42:35 +0200
Message-Id: <cover-0.3-00000000000-20210907T193600Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.818.gd2ef2916285
In-Reply-To: <cover.1630461918.git.me@ttaylorr.com>
References: <cover.1630461918.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I came up with this on top of Taylor's series which fixes the order in
which we write files associated with pack files[1]. His series fixes a
race where we write *.idx before *.rev, but left the issue of writing
*.bitmap after *.idx, this series fixes that. Now we'll really write
the *.idx last.

There's still a race in these combined serieses, but now it's to do
with our general lack of fsync(), i.e. there's no guarantee that just
because we write files A, B and C in that order that without doing the
proper fsync() dancing on the files and the fd for the directory that
other processes will see it that way. In practice though there is, as
few/no OS's are so pedantic as to expose inconsistent ordering of
written files in a directory, even though POSIX et al leave that
possibily open.

1. https://lore.kernel.org/git/cover.1630461918.git.me@ttaylorr.com/

Ævar Arnfjörð Bjarmason (3):
  pack-write: use more idiomatic strbuf usage for packname construction
  pack-write: split up finish_tmp_packfile() function
  pack-write: rename *.idx file into place last (really!)

 builtin/pack-objects.c | 33 +++++++++++++++++------
 builtin/repack.c       |  8 ++++++
 pack-write.c           | 60 ++++++++++++++++++++++++++++--------------
 pack.h                 | 16 ++++++++++-
 4 files changed, 88 insertions(+), 29 deletions(-)

-- 
2.33.0.818.gd2ef2916285

