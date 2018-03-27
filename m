Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 491391F404
	for <e@80x24.org>; Tue, 27 Mar 2018 21:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbeC0Vjd (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 17:39:33 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36061 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbeC0Vjc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 17:39:32 -0400
Received: by mail-pl0-f67.google.com with SMTP id 91-v6so246759pld.3
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 14:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/iKcZZjW+uCHxH6MAoFQl3EOUP8m1JTZr0tc9Zvd+H8=;
        b=ibuZZ63GQNSjgvsXZN4UuBzKe7HKegfpTG8YxyEXttkdaKGnDB0lACQOdlkYvVdARk
         qk0rqkGOkEGQWW9ZXN/PdM0/OtF54t9jCuN7s9M4xqoyK1LX0srDNRsSHPKwfdEAN0hx
         dtMEq3rngSIAOllyyMn3zIKZnfy28HLS3ddmG0oQXSh12mO/oNP2OR2Bsf3M8cMCBtPc
         zivdbahLx1/DE861dwrnzU7f3CA3SUAfiUugvkvWfKmVBskDV81lrmZyxe8uhhLt0bhT
         XREIdlWls2j6eiy9+D0CKfWBBsvRT4jVGIL68ujB0nSlLYLPtx4zGGcpO81BM+QAD11O
         /1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/iKcZZjW+uCHxH6MAoFQl3EOUP8m1JTZr0tc9Zvd+H8=;
        b=P6rclPepFMxn8/uUPzporK96QQRwCLj3f2tbvyFce6/Sb5/4p4icbEAj17gdFaxcKk
         hvpwzUiZHJiCs/fDngeE6v/5HzhGiMAREiLNWS1xeNlTLF4j/8WVW/qj0LL/kH2aJjw6
         PGhsfyZj35nNowXti7LbPkfzkHZb89K8YArtnUb9zw742d1kHv9XQyeF8FYBWZ9tiBds
         zHdF4S7Bqu63dOarGeOaRBAkYEipZbC4OiDByDmFaRxiAXJ4Ci1BB8whAY7CNGjDxK+d
         V2C8Q8Qupao84mENy/QsByb1vUnlCL6rWu9fca4sjSlaqNOYgM9x1et2sCoaAtcxUUUE
         6g6Q==
X-Gm-Message-State: AElRT7EqnvEi2vvBEng8rC3vtWwA3BpD4oSmQEh4QbPuMv95uRLGcqZk
        KJIlr99lLDHwCloIdBKGVIyUzzIT74o=
X-Google-Smtp-Source: AIpwx4+o9+sjw/JArbOysUvyW+5f3rc55vrNIM6J8RK4bZ5jE4aTclUu4gDb/YHDFmhVOcy0D0GZ2g==
X-Received: by 2002:a17:902:6941:: with SMTP id k1-v6mr959733plt.185.1522186771545;
        Tue, 27 Mar 2018 14:39:31 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id u22sm3589744pgv.77.2018.03.27.14.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Mar 2018 14:39:30 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     seanwbehan@riseup.net, bmwill@google.com, hvoigt@hvoigt.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/5] Moving submodules with nested submodules
Date:   Tue, 27 Mar 2018 14:39:13 -0700
Message-Id: <20180327213918.77851-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes the bug reported in [1] ("Bug: moving submodules that have submodules
inside them causes a fatal error in git status")

[1] https://public-inbox.org/git/20180306192017.GA5797@riseup.net/

Thanks,
Stefan

Stefan Beller (5):
  submodule.h: drop declaration of connect_work_tree_and_git_dir
  submodule-config: allow submodule_free to handle arbitrary
    repositories
  submodule-config: add repository argument to submodule_from_{name,
    path}
  submodule-config: remove submodule_from_cache
  submodule: fixup nested submodules after moving the submodule

 .../technical/api-submodule-config.txt        |  2 +-
 builtin/grep.c                                |  2 +-
 builtin/mv.c                                  |  6 +-
 builtin/submodule--helper.c                   | 17 +++--
 dir.c                                         | 70 ++++++++++++++++++-
 dir.h                                         | 12 +++-
 repository.c                                  |  2 +-
 submodule-config.c                            | 29 +++-----
 submodule-config.h                            |  9 +--
 submodule.c                                   | 40 ++++++-----
 submodule.h                                   |  1 -
 t/helper/test-submodule-config.c              |  8 ++-
 t/t7001-mv.sh                                 |  2 +-
 unpack-trees.c                                |  2 +-
 14 files changed, 135 insertions(+), 67 deletions(-)

-- 
2.17.0.rc1.321.gba9d0f2565-goog

