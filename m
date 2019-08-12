Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 325271F45D
	for <e@80x24.org>; Mon, 12 Aug 2019 21:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfHLVfn (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 17:35:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34767 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfHLVfn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 17:35:43 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so48412445plt.1
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 14:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=SKnOSJzOltEcMKK1yZ3O7P1rZ1poFRhSohga71r8vUE=;
        b=iGB5xUCxbMaRx31exdaQGnaJ74tZs5rlGQAUty6BxRMGOqYgzhMjnFZxymCg6Lk+Xy
         zcg1Y9OnprFEqsoKhOuckzB3gX7Kz0z+g7hxXVcvazp27sNb4Ue+a1ETJbfQNoGXPqSJ
         5csyRJYdBVUQj5/FTxmx4TImTbuDvagld1kK/XDt0c1xh2O2CLvfUlG/Px4np8RTjKcM
         X6kBCAbGYScwob4+T2iGgcLuH+YGzys5gZvv7swxbBMX5kMqgtqPWLMhcW/t/LZrS/z1
         bycosfOso6bHB80vKBtmBF5kwaxtiljmEcCkwR9vYsUkzsStgJM1Mt4wyUWJe9RL0FLE
         73Og==
X-Gm-Message-State: APjAAAXccwnIdZyQEqD5HxDZkqfyteog3Nw2wKHWG1NBeBgYKbrr1uMC
        Wfa8ONw+S+jHEWTYRpj5V30c9k9F9JA=
X-Google-Smtp-Source: APXvYqwktY2z4z9rIUhi250qZKTZaL1GOdosqNY13/ehkTXBAo5mkLiiDniwgV8MDyDgmi+2lJO3Pw==
X-Received: by 2002:a17:902:6b86:: with SMTP id p6mr35574477plk.14.1565645741770;
        Mon, 12 Aug 2019 14:35:41 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id bt18sm474195pjb.1.2019.08.12.14.35.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 14:35:41 -0700 (PDT)
Subject: [PATCH v2 0/5] fetch: Extend --jobs to multiple remotes
Date:   Mon, 12 Aug 2019 14:34:43 -0700
Message-Id: <20190812213448.2649-1-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     peff@peff.net, e@80x24.org, chriscool@tuxfamily.org,
        gitster@pobox.com, jonathantanmy@google.com, tboegi@web.de,
        bwilliams.eng@gmail.com, jeffhost@microsoft.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems like the feedback for v1 was fairly positive, so I managed to
find some time to go ahead finish it.  The result is a much cleaner
patch set.  I think this could be merged in its current state, but there
are a few outstanding concerns I have:

* fetch.jobs isn't documented because I couldn't find any
  documentation for submodule.fetchjobs so I didn't know where to start
  writing.
* I took the complicated approach and added --submodule-fetch-jobs and
  --fetch-jobs before converting --jobs over to set both.  At the time I
  thought it wouldn't add too much extra complexity.  I wasn't looking
  closely enough and ended up with a custom parsing function which is a
  bit ugly.

I'm happy to fix either of these, but I wanted to send out the v2 before
going any farther because I wasn't sure if --jobs would be converted
over right away or if there was going to be a deprecation period.  I've
written the patch set such that the final patch can easily be dropped to
avoid changing existing behavior.

I'm also happy to re-spin this to just make --jobs control remotes and
drop the --fetch-jobs and --submodule-fetch-jobs arguments, which would
make the patch set somewhat simpler but preclude a deprecation period.

Changes since v1 <20190717015903.4384-1-palmer@sifive.com>:

* fetch_multiple() has been rewritten to use
  run_processes_parallel_tr2() rather than manage children on its own.
* The --fetch-jobs argument has been added.
* The --jobs arugemnt has been used, instead of the --parallel argument.


