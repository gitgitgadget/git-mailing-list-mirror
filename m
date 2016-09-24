Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 375EB207EC
	for <e@80x24.org>; Sat, 24 Sep 2016 00:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754170AbcIXANx (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 20:13:53 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34428 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752987AbcIXANw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 20:13:52 -0400
Received: by mail-pf0-f177.google.com with SMTP id p64so46750944pfb.1
        for <git@vger.kernel.org>; Fri, 23 Sep 2016 17:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=mRwz1kk/mSzXmRVIJG2UT0TiGHZJ1xyCtdMax0nUFMc=;
        b=FnfTs8hUPoPs4QHG5DgZ9KW5opXL9q3pY8KmQtKaHFQCR+/eKJauP/QN2ALSIdNfBC
         UlGmLnGYSC150I42Gqd+k66REa4SpVEgh79El8Xs3w9Jw2VRngN23FhUeqz0IwFHt9CS
         +uAG77g2UiIMrQp2qORuXEhdhClvJknT24kLyu47cS5LQeOCVCVgRGtOVNeHYsARGvhW
         vQXTOnDxGlnMt/2Y5Z7rNZ1/fYMNFLfOmNXLJDcDWaUzZs5pbdwo11Q2I2xlYI/3NHiu
         V2fA+EAxGKrGQKuFUkljSBkMfLuGA28kOO6eKbesRlkNwDxvLmcfjW9ne05dUjiN+5Md
         ajHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mRwz1kk/mSzXmRVIJG2UT0TiGHZJ1xyCtdMax0nUFMc=;
        b=eW6KO2A97H7xK7f+E91ldbhi5Vki82ZLLPwR+NvyOha/HUWcXYGsTciBq1PDBraeQS
         C+DPrVGTy1V82s8UY5yqDYD/4DGXHS4hBjuW0VjkUuhjhScPtTuWK7Fyj85fjxRm2IjE
         KOeVMhfwW3vSzmbWs5yz0YyizUv8Bakd225IrsKzc1UYAPdSFwaXVHusoeo+phDnSilr
         sH+q3yDKhCYT1r6ZKuCf7sswhhgjWZOY9UFTo/9CZDP6dozvOu4uC20W2qWO3O92bFiw
         TpQVYFWWKyVX2upHJuaacwBLFtMfICFF+424jKlxQx9fcdsj5dfhdrUN/FTR62vwc4+D
         F+1g==
X-Gm-Message-State: AE9vXwP1KPEW4PIIdbNSHWrz7359NN5EfYr765a/E2+L+IMtm4I6IgWZezXguJVE2f93ViRp
X-Received: by 10.98.93.85 with SMTP id r82mr16972019pfb.168.1474676031456;
        Fri, 23 Sep 2016 17:13:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:4836:46ae:fc5e:2de9])
        by smtp.gmail.com with ESMTPSA id sy4sm8640387pac.48.2016.09.23.17.13.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Sep 2016 17:13:50 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 0/3] recursive support for ls-files
Date:   Fri, 23 Sep 2016 17:13:31 -0700
Message-Id: <1474676014-134568-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After looking at the feedback I rerolled a few things, in particular the
--submodule_prefix option that existed to give a submodule context about where
it had been invoked from.  People didn't seem to like the idea of exposing this
to the users (yet anyways) so I removed it as an option and instead have it
being passed to a child process via an environment variable
GIT_INTERNAL_SUBMODULE_PREFIX.  This way we don't have to support anything to
external users at the moment.

Also fixed a bug (and added a test) for the -z options as pointed out by Jeff
King.

Brandon Williams (3):
  submodules: make submodule-prefix option an envvar
  ls-files: optionally recurse into submodules
  ls-files: add pathspec matching for submodules

 Documentation/git-ls-files.txt         |   7 +-
 builtin/ls-files.c                     | 173 ++++++++++++++++++++-------
 cache.h                                |   1 +
 dir.c                                  |  46 +++++++-
 dir.h                                  |   4 +
 environment.c                          |   1 +
 t/t3007-ls-files-recurse-submodules.sh | 209 +++++++++++++++++++++++++++++++++
 7 files changed, 398 insertions(+), 43 deletions(-)
 create mode 100755 t/t3007-ls-files-recurse-submodules.sh

-- 
2.8.0.rc3.226.g39d4020

