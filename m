Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67671C432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EBFC60EBC
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhHYXUk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 19:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhHYXUh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 19:20:37 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EC4C061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:19:50 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id d22-20020a1c1d16000000b002e7777970f0so5481892wmd.3
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fqJYlA9Kz8QA/fh42ceHu9CiaoWiG+2dk01PnU/iUBA=;
        b=RnpI+tWDQjIcuUe92ryjVm2p+/jAE/CIKsd6OeuFaUEol8QD5jpVkUc3lB+80dZAcX
         /0iMJFs+izzVi+dtjrGX0LNOQKk+KqXI1/6RheRUeG0qpOKSCDCxmQbgmmi6TnbYP+gF
         tflX4xzbtBU4pBj7mbvcZa8BfpoudpaGnL5vielJ2ltT8yS3RebBIJpXtLMsTOGZdvlg
         TsFi8YwkJQYq0jyJ5qKQlgLOwCbLR+WejEGy4t89ocEbeXIzmY76qK7m2udAIhVt8Yh1
         8wSRcQHyVJAaqtQ7E+00JXO0FnoqY7SZjL8CK3j38M+ZGO0EQZm9QX8giPpsZh9q2Drs
         Gn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fqJYlA9Kz8QA/fh42ceHu9CiaoWiG+2dk01PnU/iUBA=;
        b=JE8uDw36qLNU3B8ZVfSKz7+gksF0HqOmy82canCtdH1osST58uPpZbEDWWsr6hLRKn
         iYtg0BEb1E+/Oey29Qm8zHpPZQw/yF9bvWNF03ikQXAaPZ3XRxWOmyvl32dygcBq6fYA
         2j6RNJO02acJymlW09XQbP8zTOwbgBMBddSi4LTTtCobZprIdTChE/2v+a0cbOdVmz0V
         /ztFZmX0zwOlwpBAe2SMSu4X4iTLHzWl8B/HOD1Qsr7/vwjnY63a/YXM03Pl2nufL7Gg
         R/D2rbW2I1qWYh4jU7hT2q3wW1vuhmxP16Wy9O9ub9g/CFCDSQyinxU51D36fWpFYhiT
         qkbQ==
X-Gm-Message-State: AOAM532c7rBZH/2XxlOxWGHwS18mKe9hZ8568tgtbe3npN059eZFItd0
        Ph51HhY8+JqxS20vf3w08+rQ1JO54M8=
X-Google-Smtp-Source: ABdhPJyJUzontBLHnZKYbyozVoQtsDMR2vb1AeLxefODhcDOHU6AiROu4UblR6EbnIl2RO4OUyiZvA==
X-Received: by 2002:a1c:1b53:: with SMTP id b80mr749815wmb.133.1629933589265;
        Wed, 25 Aug 2021 16:19:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u23sm6327166wmc.24.2021.08.25.16.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 16:19:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/6] tr2: plug memory leaks + logic errors + Win32 & Linux feature parity
Date:   Thu, 26 Aug 2021 01:19:18 +0200
Message-Id: <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.733.ga72a4f1c2e1
In-Reply-To: <87o8agp29o.fsf@evledraar.gmail.com>
References: <87o8agp29o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The just-landed 6f64eeab605 (Merge branch
'es/trace2-log-parent-process-name', 2021-08-24) added parent process
name logging, but under Linux we'd only log the immediate parent, and
the full process chain on Windows.

This brings the Linux implementation in parity with the Windows
implementation. As it turns out /proc/<PID>/stat is a bit of a pain to
parse.

This is preceded by some minor memory leak fixes to
es/trace2-log-parent-process-name, and the fixing of a bug where we'd
log the empty string as a parent if we didn't have procfs.

Ævar Arnfjörð Bjarmason (6):
  tr2: remove NEEDSWORK comment for "non-procfs" implementations
  tr2: clarify TRACE2_PROCESS_INFO_EXIT comment under Linux
  tr2: stop leaking "thread_name" memory
  tr2: fix memory leak & logic error in 2f732bf15e6
  tr2: do compiler enum check in trace2_collect_process_info()
  tr2: log N parent process names on Linux

 compat/linux/procinfo.c | 151 +++++++++++++++++++++++++++++++++-------
 trace2/tr2_tls.c        |   1 +
 2 files changed, 128 insertions(+), 24 deletions(-)

-- 
2.33.0.733.ga72a4f1c2e1

