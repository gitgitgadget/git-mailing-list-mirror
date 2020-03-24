Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402C5C10DCE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 06:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E44A20719
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 06:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="V8SeOyC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgCXGEv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:04:51 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41152 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgCXGEu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 02:04:50 -0400
Received: by mail-qk1-f195.google.com with SMTP id q188so12857299qke.8
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 23:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2knhCG4e47jXy9EaAyMXuKMtl8AG8KR4CmVT3wOUSl8=;
        b=V8SeOyC0EJJP6THu7CutBwGJ5PwLjsev1QFyKbw+2q2+8YLgHVRodkuKtviOYd+M5j
         m2qJIdC5aBrin6HkWQ7MqgDsyunGmAzMAagTNknz8jkvYgKNpvakZ/9FX3fA0x4CCTA0
         BqDymyh6nmn+y9IENgHFNfsqkF5ux1xRkDamDBhlWmVjVm7F2dGaxxnoznX1oSfD6AB3
         dhZVOdJgMhpzai03fAWC2rXSF2gLLkDwIsPQKz+s2eMdbO2gtUxPGc77fxtRTFA7xBle
         Khu1U+aEQlMdt3VcxL9XFA+bL7L2SbR/x8st38dQoHWEgcUTejun5VSKgKld7X/Tes1j
         JCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2knhCG4e47jXy9EaAyMXuKMtl8AG8KR4CmVT3wOUSl8=;
        b=D498VO8dK/tVroZTRYYvaXXEr8bN91HYOhn9Peiy1vSCGSwan1HAEx9wDOA3fv3je3
         8AKFCOgGJ89k+PFfxP4uDO3/ptC8JPF1K8Y07XzBKeQvU99GGUHfuBjn4R5cyWE5ZPqv
         mgu4+dBKf0cj6g8RFVhzC522GPsYcrstm6PLpCYrP0MqyCwAD6VXb3D/SaKMOnCCt1b+
         aN2GypdpySOP00XmrPHWqHR2fzT6OK66MsQHVNcUJHdJ3Y6ty6/BLvWqb3SNS08WkuID
         gB1/1M4PYYp1XZd0ldO6B18A4sdOZfelBgF82G6ZmBURrfzRcNl5MWfMhkaVCB/t57YT
         7Rvw==
X-Gm-Message-State: ANhLgQ2EHj6kPC7Xq4yUGJMy8zk0FYacgGsc0JUV/9pHEsMD5ipMdgfU
        WXdlluMWZsKSTXmXV+BnqAj+ovv2l8A=
X-Google-Smtp-Source: ADFU+vtJNWqxh5Mts4rUzV9TVQ+SX6hxOTx1B9RQbJvSk/8LgcFgIOEubOcvk67xd6rX5qC6KWI7kA==
X-Received: by 2002:a05:620a:84d:: with SMTP id u13mr24300099qku.94.1585029889656;
        Mon, 23 Mar 2020 23:04:49 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id f13sm14348323qte.53.2020.03.23.23.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 23:04:48 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, newren@gmail.com
Subject: [RFC PATCH 0/3] grep: honor sparse checkout and add option to ignore it
Date:   Tue, 24 Mar 2020 03:04:36 -0300
Message-Id: <cover.1585027716.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on the discussions we had some months ago[1], about
git-grep not currently honoring the sparsity patterns. To summarize, the
idea is that, since a sparse checkout is used to limit the set of files
in which users are interested, git-grep should, by default, only search
within this boundary.  But it would be good to also have an
'--ignore-sparsity' option, to restore the old behavior when needed, as
there are also valid use cases for it. The following patches seek to
address these suggestions. The first patch is not really related, it is
a cleanup, used by the third one.

[1]: https://lore.kernel.org/git/CAHd-oW7e5qCuxZLBeVDq+Th3E+E4+P8=WzJfK8WcG2yz=n_nag@mail.gmail.com/t/#u

Matheus Tavares (3):
  doc: grep: unify info on configuration variables
  grep: honor sparse checkout patterns
  grep: add option to ignore sparsity patterns

 Documentation/config/grep.txt    |  10 ++-
 Documentation/git-grep.txt       |  40 +++-------
 builtin/grep.c                   |  36 ++++++++-
 t/t7011-skip-worktree-reading.sh |   9 ---
 t/t7817-grep-sparse-checkout.sh  | 130 +++++++++++++++++++++++++++++++
 5 files changed, 180 insertions(+), 45 deletions(-)
 create mode 100755 t/t7817-grep-sparse-checkout.sh

-- 
2.25.1

