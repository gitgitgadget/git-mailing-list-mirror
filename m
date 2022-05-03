Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D24EC433F5
	for <git@archiver.kernel.org>; Tue,  3 May 2022 06:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiECG7W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 02:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiECG61 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 02:58:27 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7CA192BD
        for <git@vger.kernel.org>; Mon,  2 May 2022 23:54:55 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id x9so12746010qts.6
        for <git@vger.kernel.org>; Mon, 02 May 2022 23:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OAZ4m2UivnQzTmKnB2sunKJ1lkTfhSN8VHRm1933XDk=;
        b=Sw+nAbxBQh0dkdfhADGhxVDi/wyyyeaiSbP+q8haRlDiy3pb5Sli3ttWdkRxlrPnD0
         V8/jTpBz0OZQ7tkFOeGTGOm0Xq57bbIik7gjQGN+mAyMBxnQyuMEU2530D+PZvqSqsIa
         C8CoZj23XkV4rViRVEEktQFzG0aSL59OoxTdtsbi28sIQhsx5LLWzqzX4WrqAQEQli10
         07zDYcDh90EVznTZQ9i8C4JTI8lMNhKqJRLuD5cHCCTwQBSz3DY3+bVUDO5mjkaa4zy6
         mLq/hPlK462rHD6kumSk70CQh3nc6FtBiv+uhSwvaAbl533gtIfOzSgmjaDWEcOiWTbq
         TB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OAZ4m2UivnQzTmKnB2sunKJ1lkTfhSN8VHRm1933XDk=;
        b=Z+COKeVH6dBALJHAotvskPexuHZwVFH9Sk+HibUcxHVY/NMvG8Xt46WqPBAWyZoh8L
         UG98OzVALDOGkijIKvqe6GQaNXtrVQF7+qLYt9hV79pTFjK4vTWqfR6SIJzZm/nViSHb
         bx9xH29R4N07kqaHiSZ+QxFbm3mX+09mTVgCI26x5cA4bpO1kFvzgWmyzq6uUrpwVodB
         WrFsvZ//LMb59qMIkDGYuNrxmUAnzsB8ujVKz9u34W56pmpQ8/tM+hXAkS5NlR38aLoV
         xgU1fNSMdDZZflCK7h8meYsCH0RkmV0goQ1fQrfqqUdXITSxMjCHrGxuG2jb7RXvLDm4
         ayyw==
X-Gm-Message-State: AOAM530rXIURNkU56pRixewDdFfQLSyhMe6oqo2ZRAQ4awXy9wgcQQXe
        0ykFrYkx7318Xhg40bhza1+PwsZMABg=
X-Google-Smtp-Source: ABdhPJw/DcKJ14bJ8mXDygl2DY3xOzyrKqRg4IxAhBRg0MnEgA7RqwjxaDGIOuvqrfqLnbSq1s04wQ==
X-Received: by 2002:a05:622a:2c4:b0:2f3:b061:8184 with SMTP id a4-20020a05622a02c400b002f3b0618184mr428187qtx.685.1651560893961;
        Mon, 02 May 2022 23:54:53 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id t1-20020ac85301000000b002f39b99f68bsm5333369qtn.37.2022.05.02.23.54.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 May 2022 23:54:53 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, bagasdotme@gmail.com, phillip.wood123@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v3 0/3] fix `sudo make install` regression in maint
Date:   Mon,  2 May 2022 23:54:39 -0700
Message-Id: <20220503065442.95699-1-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.352.g0cd7feaf86f
In-Reply-To: <20220428105852.94449-1-carenas@gmail.com>
References: <20220428105852.94449-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since RFC v3:
* Cleaner split of tests so patch1 will not break if called under sudo
  and will be less likely to break any CI by restricting its runs to
  IKNOWWHATIAMDOING=YES
* Simplified patch3 with all requested enhancements, except that it is
  still keeping the (currently unused) possibility to override the shell
  used in run_with_sudo with an optional first parameter.

Carlo Marcelo Arenas Belón (3):
  t: document regression git safe.directory when using sudo
  git-compat-util: avoid failing dir ownership checks if running
    privileged
  t0034: enhance framework to allow testing more commands under sudo

 Documentation/config/safe.txt  |   9 +++
 git-compat-util.h              |  40 +++++++++++-
 t/lib-sudo.sh                  |  13 ++++
 t/t0034-root-safe-directory.sh | 115 +++++++++++++++++++++++++++++++++
 4 files changed, 176 insertions(+), 1 deletion(-)
 create mode 100644 t/lib-sudo.sh
 create mode 100755 t/t0034-root-safe-directory.sh

A range-diff against RFC v3 shown below to easy review:

1:  51d0d485b5f ! 1:  27192634476 t: document regression git safe.directory when using sudo
    @@ t/t0034-root-safe-directory.sh (new)
     +
     +. ./test-lib.sh
     +
    ++if [ "$IKNOWWHATIAMDOING" != "YES" ]
    ++then
    ++	skip_all="You must set env var IKNOWWHATIAMDOING=YES in order to run this test"
    ++	test_done
    ++fi
    ++
     +# this prerequisite should be added to all the tests, it not only prevents
     +# the test from failing but also warms up any authentication cache sudo
     +# might need to avoid asking for a password
    @@ t/t0034-root-safe-directory.sh (new)
     +	)
     +'
     +
    -+# this MUST be always the last test
    ++# this MUST be always the last test, if used more than once, the next
    ++# test should do a full setup again.
     +test_expect_success SUDO 'cleanup' '
     +	sudo rm -rf root
     +'
2:  4928ad698e2 = 2:  58b4671b9ef git-compat-util: avoid failing dir ownership checks if running privileged
3:  98aae872efd < -:  ----------- t0034: enhance framework to allow testing more commands under sudo
-:  ----------- > 3:  7c029c66666 t0034: enhance framework to allow testing more commands under sudo

Albeit not ideal, if needef patches 1 and 2 could be fastracked to close the
regression while patch 3 goes through further iterations.

Carlo
-- 
2.36.0.352.g0cd7feaf86f

