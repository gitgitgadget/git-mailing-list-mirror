Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB5BC43463
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 08:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B77EF2085B
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 08:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="YUliohTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgIUIP4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 04:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgIUIP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 04:15:56 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476D3C061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 01:15:56 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l9so11584415wme.3
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 01:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=67t9e7opO7KlZHvdD8wwD2xhIy8IOO4Ea/NSPSE4HuI=;
        b=YUliohTPB/Mg9SksNZCzCCmOYBZbL69czDt72agMBT9tySNLvrzzZOzVuancczPw/Z
         QqiixtRst0F304gpRomz1SeGKe91YZm0y9afCqFqwFMPlBKvf9C1gBhfManpwAuYNEiw
         ChNjjVConDvBEcCG63ONMnJAC1s8CgTNkJ+Gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=67t9e7opO7KlZHvdD8wwD2xhIy8IOO4Ea/NSPSE4HuI=;
        b=CH+7uSO/R3mN23jDT3T74BUqRyDPYiiZEEA8dF5XUu0wqNsrgXaS85NBwjpXKUwCnV
         BuNeOVMHSaAy+aF267Mb0wxKKh5cGCAhaNNMKf7OvYQcMuKipbZcgc3l6Y3+uM92/Fjz
         H2yabgT0XaBSyeW/xWPepg+9kvBg2JjRYiZe8vJWp3laDc47Q0GVV6hP6iTs2z92Mer5
         1fupQsZMqednqIizmzTm3rCABhtfmUyp91M8bNNwOaHTMTnpQ2gbMgAZWFetHLYh96Te
         uVLrPcbDlHF8Jm/YYTfjJMIJs0CCe/h4EKIgWGLM0zhSXp9DU2GWiikI+yeNxCAiYgxr
         i6QQ==
X-Gm-Message-State: AOAM533pS+wxGbZHMoX/4ne4bq+Oj93AtXcb3z/zB2Je6qxdGAXOLPSI
        R2kt4aZ/Iw/MLdq3rwXSrvi/WulfG5kzxA==
X-Google-Smtp-Source: ABdhPJye0n/89kTdCHtY33ZYnf6QdAJrh28ikfQWw2AoCNFmFsWbGX2n+qBEg5eWzGmBJJMOtQM1ag==
X-Received: by 2002:a7b:cbd4:: with SMTP id n20mr30502563wmi.105.1600676154812;
        Mon, 21 Sep 2020 01:15:54 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc149478-cmbg20-2-0-cust747.5-4.cable.virginm.net. [86.16.90.236])
        by smtp.gmail.com with ESMTPSA id u17sm21108187wri.45.2020.09.21.01.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 01:15:54 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     kartic Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH 0/1] Test case for checkout of added/deleted submodules in clones
Date:   Mon, 21 Sep 2020 09:15:36 +0100
Message-Id: <20200921081537.15300-1-luke@diamand.org>
X-Mailer: git-send-email 2.28.0.762.g324f61785e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I hit some quite confusing (to me anyway) corner cases in `git
submodule` handling of checking out revisions where submodules have been
added or removed.

If you clone a repo with an "old" submodule which is missing from HEAD,
and then try to checkout an older revision, you can sometimes get:

    fatal: not a git repository: ../.git/modules/old
    fatal: could not reset submodule index

If you clone a repo with a "new" submodule, and then checkout an older
revision where it is deleted, you can sometimes find that new submodule
is left lying around.

Luke Diamand (1):
  Test case for checkout of added/deleted submodules in clones

 t/t5619-submodules-missing.sh | 104 ++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100755 t/t5619-submodules-missing.sh

-- 
2.28.0.762.g324f61785e

