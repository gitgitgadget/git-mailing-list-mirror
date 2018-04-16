Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C826E1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 22:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbeDPWlX (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 18:41:23 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:36703 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeDPWlW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 18:41:22 -0400
Received: by mail-wr0-f172.google.com with SMTP id q13so26829819wre.3
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 15:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5A5mwcVZORgWJn+0om5KRfukR+iTVjTe57/2TRuDaWE=;
        b=bDyPQCWFZHdwuW16xuIpo5zKAsHl4iFxRMtHArMu4WepXPVOcvHZ0UsmR0HzAHUQcI
         NzGpUpfrvUhDoRKqmwKSj8zxd1tOmPxp7y/v+cXeAMVadwATSp1DrGxXaJ81Q2Jzlyzz
         YKal2m9Wkmi3rDedEvyn36KSj+Imo5HFNgLFtyv9WYpiJR38bLfhBrcsY1iYTYlvsxU4
         1iGBcNgqSKkUbCGYkhmLTKiELChblt9LFdUaSzXnlpHYy9oc6PsIPpR7YhyQm81isM1Z
         /Op4uc5U9xhLdHfXXbydGCK4Buu4lNotv/8MJZoi6ZxKgTo1fMKffRLF0f7Pp7kaUjjQ
         yNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5A5mwcVZORgWJn+0om5KRfukR+iTVjTe57/2TRuDaWE=;
        b=aLaKgJabXTrIlbSQ6Zfr6QbIpVj5QATt7jaXVmmLhIfiGjN8Ykz4g+ieqEA3gcFZ/q
         ha4tedIReRJP9zKj/2EVdHD3Iewq8Eep76CEgGj4EPvqlfjtAFi1OTAFc54wiCo/WpIB
         ukzXCzgKmeyCN49qlKgXjmkaEPuH/RVVaNWMEr92sCZInlhvRrvetDXnu3nU7EMW6m1m
         l1VFJP4AEdNgncD8pNdhyYYYsBBBqchJ1g3CXFxv5Ba8pRH8YRAgMHp8zhLRF/fV7I73
         2ivqlL4HrE6w9AK1lV77Vrxii9XVTgwcOv5bYzR/UF7JfLWfhIDXy66k+BGSL71Ec4CP
         O4og==
X-Gm-Message-State: ALQs6tAJgszc0bd7ZumJTaXXWWiFgFc+b/wxCffORmwb8rj+frplC0my
        lhbrUyureTucDRCZ9BFoNKttmw==
X-Google-Smtp-Source: AIpwx48OV4vigw0w+NWH6GVDLSwQGPHO1XmehOih5nLBBJAuUxWtXTCA0bd/9/cbp1/UGPaePwCTYA==
X-Received: by 10.223.225.2 with SMTP id d2mr11803377wri.56.1523918481260;
        Mon, 16 Apr 2018 15:41:21 -0700 (PDT)
Received: from localhost.localdomain (x590d89db.dyn.telefonica.de. [89.13.137.219])
        by smtp.gmail.com with ESMTPSA id p128sm14977788wmd.45.2018.04.16.15.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Apr 2018 15:41:20 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Clemens Buchacher <drizzd@gmx.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Manlio Perillo <manlio.perillo@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 00/11] completion: path completion improvements: speedup and quoted paths
Date:   Tue, 17 Apr 2018 00:41:04 +0200
Message-Id: <20180416224113.16993-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.366.gbe216a3084
In-Reply-To: <20180318012618.32691-1-szeder.dev@gmail.com>
References: <20180318012618.32691-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So, the highlights of this patch series are:

  - At the top of the worktree in linux.git with over 62k files the time
    needed for 'git rm <TAB>' goes down from 2.15s to 0.052s.

  - Same place, uniquely completing Makefile with 'git rm Mak<TAB>' goes
    down from 2.16s to 0.033s.

  - Completing paths containing escaped or quoted characters (except
    newline) will work properly, and won't fall back to Bash's filename
    completion, e.g. git add File\\w<TAB>' will list
    'File\with\backslashes.c', but not the corresponding ignored object
    file.

Well, at least it appears to be working for me, but dealing with quoting
especially is nuts.  If someone knows simpler ways to remove escaping
and quoting than in the functions added in patches 5 and 10, then
please, I would really love to learn something :)

Someone using ZSH regularly should have a look and test it.

SZEDER Gábor (11):
  t9902-completion: add tests demonstrating issues with quoted pathnames
  completion: move __git_complete_index_file() next to its helpers
  completion: simplify prefix path component handling during path
    completion
  completion: support completing non-ASCII pathnames
  completion: improve handling quoted paths on the command line
  completion: let 'ls-files' and 'diff-index' filter matching paths
  completion: use 'awk' to strip trailing path components
  t9902-completion: ignore COMPREPLY element order in some tests
  completion: remove repeated dirnames with 'awk' during path completion
  completion: improve handling quoted paths in 'git ls-files's output
  completion: fill COMPREPLY directly when completing paths

 contrib/completion/git-completion.bash | 218 +++++++++++++++++++++----
 contrib/completion/git-completion.zsh  |   9 +
 t/t9902-completion.sh                  | 153 ++++++++++++++++-
 3 files changed, 348 insertions(+), 32 deletions(-)

-- 
2.17.0.366.gbe216a3084

