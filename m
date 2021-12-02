Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB52DC433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 14:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358714AbhLBOsv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 09:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358698AbhLBOsU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 09:48:20 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19219C06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 06:44:58 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id g18so28146644pfk.5
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 06:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=T0bgW4Cl7PhXvaZq1sAOU3LrPeJLwCOrrQT4zK6Ob44=;
        b=Rzl4t4njf2ceSITCb2TtxkYKJKL7BtxbhXPsNs5MY4y4c68QJ6qHtvIxw4HGCrjzQh
         uAW1+menCUYx2rOsec2R0d/99Ak3ljDgg8A6OlBnfp85zaKhDPjJx+Ck4ywbReJEjQsv
         FA04pBCfxKFZRQZt/xhtC38veR/5UTaHVnNn+iuGBYhkZLClSASEXE51toJEH4QGr9Em
         0FdMcqMo0wjKK8v5AyyU0AsFnVQPQPgyrWnwxT04zAFEn0RWhJF5EeFl21En96OkF/Kk
         r16j1xZOg5sO5LzQiRjuuW4RbeR+HkZkQeN4LucAFUsc6Ru5LNot66BRFHL3wkalq4gX
         S3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T0bgW4Cl7PhXvaZq1sAOU3LrPeJLwCOrrQT4zK6Ob44=;
        b=GefPlk5mVVrCcRi5AJW4GxneNcTkr/SYOHyR0BKeBh0XJ4cdIxnb7NI9XuIQXONpAC
         vZCh92e7C/vrg2jFuWJzmmXr3CvDY9uWTYbwlnwqhUB3l4J2ctKMXGHalQixSKtcw2lD
         gjtRYQRxQPv1ZRaPjz8bSEnN5tEeSL2eklMZtamFvP/kAMvR3XHc5nQciyTUyNabZ2qi
         YmZBKkT9TP9exjsep6Oxjo1Hcu2KJZdPmfcW8k1acqv/5kcGrsZVnINoXIYclOTXTr/e
         6Vu66dPOJotqeWLL+g+gUzf5Lt1nbGB9gBUW//QgILdzJeEVMTSBtrE9YSNIBaj6Upmv
         eE2A==
X-Gm-Message-State: AOAM532jD00WnM6gI8z5beO691On6ZV4UhZ4BQj4JCbcYaoJg7fPJD4j
        P0L3PB66Ibde/y5Fui4H1rKBUwGeKag=
X-Google-Smtp-Source: ABdhPJzUqlf8DRUEw1+Zeilq39q6kVN4mPgm9uiYy8sHxVnoJn9JHVQD1IbDheteLa6QJWjiVYMRuw==
X-Received: by 2002:a63:88c1:: with SMTP id l184mr9704948pgd.460.1638456297149;
        Thu, 02 Dec 2021 06:44:57 -0800 (PST)
Received: from LAPTOP-FJDAS7G4.localdomain ([157.40.224.105])
        by smtp.gmail.com with ESMTPSA id mp12sm2784451pjb.39.2021.12.02.06.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 06:44:56 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     git@vger.kernel.org
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: [RFC PATCH 0/1] making --set-upstream have default arguments
Date:   Thu,  2 Dec 2021 20:13:53 +0530
Message-Id: <20211202144354.17416-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To track a upstream branch from a local branch we need to pass
<repository> and <refspec> to --set-upstream (in case of git push)
or to --set-upstream-to (in case of git branch). In most cases,
users track the upstream branch with the same name as the local
branch they are currently on. For example, users most of the time
do 'git push <repository> <current_branch_refspec>'.

So, it would be great if 'git push -u' by default do this. This
patch series address this. The patches of this patch-set set
some default values for <repository> and <refspec> if they are
not given. It first tries to get the value of <repository> from
'branch.<current_branch>.remote'. If not then it will set the
value of <repository> as 'origin'. <refspec>'s value would be
the short name of the current branch.

The first patch implements it for push command. However, before
moving to the 'git branch' part, it would be great to have
discussions about the proposed changes in this patch and whether
the current changes are the best way to address it or not.

Abhradeep Chakraborty (1):
  push: make '-u' have default arguments

 Documentation/git-push.txt |  6 +++++
 builtin/push.c             | 48 ++++++++++++++++++++++++++++----------
 t/t5523-push-upstream.sh   | 11 +++++++++
 3 files changed, 53 insertions(+), 12 deletions(-)

-- 
2.17.1

