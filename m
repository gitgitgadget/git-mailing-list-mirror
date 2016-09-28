Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 454961F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 21:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754389AbcI1VvT (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 17:51:19 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36124 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754334AbcI1VvR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 17:51:17 -0400
Received: by mail-pa0-f48.google.com with SMTP id qn7so20486723pac.3
        for <git@vger.kernel.org>; Wed, 28 Sep 2016 14:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cAj3lKzwxef6R8P9o2j9jj+JuZEkIGI3pRzGtD1Uzzk=;
        b=CQIWjJf550zQ/WELF+v1ygSm3FnVcOh+gTJxdkWd6wVro+Sqjz0WGRNEsuM60u7yRW
         LMbg6C5cRWifN0MA2mcNE8vm2ZqFnyl0B/zS400IDBhCcmvZQjq1/ZSQqxYmzjBh/Cgn
         QotcSgJ3Pq2slVaety9Nt6kAIWKXx7lCEgWq9YPqKak9/YCXiRHp/0W41Oh3I0aeg+4K
         JL6lbB54EHkPdlusaKuauqs6AhZNdPtNQf5hRA+k2rtVIYm08HSCCP1Ef4neqk38R/zm
         RN72tSGyNFUrz68NSe6yLemWwHJgAQibk9LzphvzSRlmc6WakLbanSGVUzGyoQmp3yt0
         VYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cAj3lKzwxef6R8P9o2j9jj+JuZEkIGI3pRzGtD1Uzzk=;
        b=OX+hOPyWXqkRX6+HHNq5gPzCiiGWFSb8jhZDG+Wje77hfqt56HFUQEK8D8IkYIRkDA
         wdVIQ3mdqLFziW6nUbis26rmtM4cCDQWtmZh3MSXhYjozluwGvkTAfsTsDrBAmvXaaqo
         np0ZYqZIVH2IcqNoma/9I5HMVN3s/S4hJ3svMyjODvrJs06Wau2RWTGMf9PORGtsVg1K
         Rw5PIQRBP1eKB68Nf+uUUJlnGJdu1ahxcX7TPm42arI7BBtjX/ytiPccbjFFWnEEp0ZU
         QSmclzYOkzJUbO4OYkwRANRBx9rUnkZFIqANdEUlYNrWA0DYJZhW/K2Ak7y8MBiTIOwm
         X/kw==
X-Gm-Message-State: AE9vXwObXetG0CjErT+l5x20zZ7N2wKXLOYZ9bKGMUCpjVY0m6Ax5mEB7cKmKsJW4b16SM3V
X-Received: by 10.66.52.42 with SMTP id q10mr60385671pao.34.1475099476713;
        Wed, 28 Sep 2016 14:51:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8def:9119:a35:c58b])
        by smtp.gmail.com with ESMTPSA id cu2sm14754881pad.18.2016.09.28.14.51.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 28 Sep 2016 14:51:15 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, gitster@pobox.com
Subject: [PATCH v5 0/4] recursive support for ls-files
Date:   Wed, 28 Sep 2016 14:50:39 -0700
Message-Id: <1475099443-145608-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1474930003-83750-1-git-send-email-bmwill@google.com>
References: <1474930003-83750-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The big change in this version is the introduction of a --super-prefix option
to the top level git.  After much discussion this seemed to be a better naming
scheme than 'submodule-prefix' as it could be an option other cmds could use
independent of submodules.

In 3/4 I changed the compile_submodule_options function to compile all options that can be realistically passed through and when an option that isn't supported (or rather safe) yet is provided the caller will be errored out.

Brandon Williams (4):
  git: make super-prefix option
  ls-files: optionally recurse into submodules
  ls-files: pass through safe options for --recurse-submodules
  ls-files: add pathspec matching for submodules

 Documentation/git-ls-files.txt         |   7 +-
 Documentation/git.txt                  |   6 +
 builtin/ls-files.c                     | 202 ++++++++++++++++++++++++-------
 cache.h                                |   2 +
 dir.c                                  |  46 +++++++-
 dir.h                                  |   4 +
 environment.c                          |  10 ++
 git.c                                  |  24 +++-
 t/t3007-ls-files-recurse-submodules.sh | 209 +++++++++++++++++++++++++++++++++
 9 files changed, 466 insertions(+), 44 deletions(-)
 create mode 100755 t/t3007-ls-files-recurse-submodules.sh

-- 
2.8.0.rc3.226.g39d4020

