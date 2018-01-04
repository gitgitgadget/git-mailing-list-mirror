Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EECE1F404
	for <e@80x24.org>; Thu,  4 Jan 2018 22:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753644AbeADWwu (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 17:52:50 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:38329 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753307AbeADWwt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 17:52:49 -0500
Received: by mail-pg0-f54.google.com with SMTP id t67so1274230pgc.5
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 14:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LMyCsLOTDlPnWhu3hWV1wMJwWejLYlcCpCeBVX08C+s=;
        b=ZcdPOy4rNvYfCO4AI3Pad/c8k0VQY/KzLW+l4sS74R+J6XDNHrJKF5RjhNpWAmNW6Y
         mbH6iaP+glXxpURQUPN39FLlxgcVwOtWm8o2gyQr7QvaA1oNCC5metc+OCtEfIaikD9L
         fWRkbdsGLgO6I0mQ0Mow9x+iuWu0tl3hLuK0/THnwhxPS0pwvJrRqpfp6VNTimtZhkO/
         5tNLRiqqdqw872QBPC1o4ZYuJazXZibG4Pn6DWk4d0cGGvzqZGrI+U7stNQlsS5VtslR
         m0NHOBHiKd+afP2HlMvevtXLnwj4IER/3rdhY8bdM++sW9pOcxzzSgzFYaLVZ0KY6EKV
         lmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LMyCsLOTDlPnWhu3hWV1wMJwWejLYlcCpCeBVX08C+s=;
        b=i4Ag3nJ7bBQ8SDs1KFIAwlagTpBBQaEOZCW5vEOjCdR6MtY8ys+Rze+cWdngn37yFY
         QI3mDii2908b4O6LK+v6Iyjh9dxLrrj4F22ov1yfSlYt9LertMtdlrKp/bMhhVMcxM13
         e/Rnkog2/w1VTxp5OoIZjcSJ3cBxCokIrbFUEPaAhe+0KIzCySFuDdMxxHS26kuu/Yug
         8dvhGNkJabd1F4vZtcUa1eoednghUS/at9EojKCu7/trsIU77ij2t1Ug3hRB0mjaaDRb
         JpFXfpbNj2GMR4SozCXEsuFvhOj1cDrVAGe7BTNV2kNuAxgXwaGlI27Jpy/tw9YFsrjv
         v/YA==
X-Gm-Message-State: AKGB3mJ68Xxw1cv8QOFgOJ0lNSsttX2kEAR5uxjnC5nwtiqpRkHDwrgt
        D/qHFFr82+be4TK/z+TmPQoO7g==
X-Google-Smtp-Source: ACJfBosiRjiQG4jIbUxMeOzzagIXWkTqpRYQ+Dd5hr3bvGHosCOGKrbucrI49bjwhZAWiOZKTahdCA==
X-Received: by 10.99.63.141 with SMTP id m135mr831052pga.367.1515106368810;
        Thu, 04 Jan 2018 14:52:48 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id j3sm8187615pgp.74.2018.01.04.14.52.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jan 2018 14:52:48 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jacob.keller@gmail.com
Subject: [PATCHv2 0/6] pickaxe refactorings and a new mode to find blobs (WAS: diffcore: add a pickaxe option to find a specific blob)
Date:   Thu,  4 Jan 2018 14:50:38 -0800
Message-Id: <20180104225044.191220-1-sbeller@google.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac83678-goog
In-Reply-To: <20180103004624.222528-1-sbeller@google.com>
References: <20180103004624.222528-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:
Thanks Junio and Jacob for review!
* fixed up the last patch to rephrase the error message to contain an 'and'
* use HAS_MULTI_BITS as well
* a bonus patch that uses HAS_MULTI_BITS for the existing code, too.

v1
After some discussion [1], we're convinced that the original approach for
adding in just another pickaxe mode to find blobs was too hacky.

So I went the less hacky way and did some refactoring first (patches 1-3),
Then we'll have the new pickaxe mode to find blobs in patch 4. It grew
slightly larger as it had issues with the setup (we neither have a regex
nor a KWS to init) in this new world, so there are a few more lines in there.

The last patch is just the cherry on the cake, helping to keep users sane by
warning when they try to use different pickaxe modes at the same time.

Thanks,
Stefan


[1] https://public-inbox.org/git/CAGZ79kaB0G9zetF6QtC45+ZGLM3gOsYWV7e+gkCe2yKOhb0Ssg@mail.gmail.com/


Stefan Beller (6):
  diff.h: Make pickaxe_opts an unsigned bit field
  diff: migrate diff_flags.pickaxe_ignore_case to a pickaxe_opts bit
  diff: introduce DIFF_PICKAXE_KINDS_MASK
  diffcore: add a pickaxe option to find a specific blob
  diff: properly error out when combining multiple pickaxe options
  diff: use HAS_MULTI_BITS instead of counting bits manually

 Documentation/diff-options.txt | 10 +++++++
 builtin/log.c                  |  4 +--
 combine-diff.c                 |  2 +-
 diff.c                         | 43 ++++++++++++++++++--------
 diff.h                         | 13 ++++++--
 diffcore-pickaxe.c             | 48 ++++++++++++++++-------------
 revision.c                     |  7 +++--
 t/t4064-diff-oidfind.sh        | 68 ++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 155 insertions(+), 40 deletions(-)
 create mode 100755 t/t4064-diff-oidfind.sh

-- 
2.16.0.rc0.223.g4a4ac83678-goog

