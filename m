Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 952101F461
	for <e@80x24.org>; Sun, 18 Aug 2019 18:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfHRS2M (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 14:28:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43417 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfHRS2L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Aug 2019 14:28:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id y8so6376094wrn.10
        for <git@vger.kernel.org>; Sun, 18 Aug 2019 11:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ucdaAgV+ktYYGKrAYHwTS7QycDZtd8h/ZwDBAx5ec2g=;
        b=nh8TR4Qmm1xLAaxrEVOlaXZmLlUtCjOtZMDoa8yvbn2tFNuOxLsKLNgvb1di/9GSBO
         gHGAD3CVkZr0ZkVRin7O3ZUAS/xGBmnWDaXxCDVWF70VNvyBLlJ6vhv9d6Ga3yNOo0lb
         ljXlyp1glWYUqLhIbq1Uu1D/HvhaFWqmH0bF5xrAIPRCjwDYCnMEzGhwm86kEJEsSCQ9
         Fsnxd9aomGvE8OQc6LF/LqsBdEd3/FT/+6sI77GSXIQvtAYDuT5NJQljSu6n4UAgYcXu
         xZ5UsSKhHJIZwyYkvVRdVlxOTRko0C1QUeZMpQSQifyOvHjI2XtIEkOAns6OI6UsqB3N
         /gXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ucdaAgV+ktYYGKrAYHwTS7QycDZtd8h/ZwDBAx5ec2g=;
        b=pYEKwmFfcle4SJukc31mfY5TK2GhPps7vVT76W1OqXvM7bFRd4TIQ6jypZvv5lLjEh
         mL0U+p//fQCZvszN9fpNlKoinUTUZdA9VzUQmGm34Sctc+OPPawFGVHdJjWbAI2goFbd
         /04HJna2RjIGJKxLAvPm3S++LedMSphufmAh8f4DdDh7MBwftooS5GeR6SEEcMfYz1PN
         goLjKqilk5icHmZ7JAXruEzFW6+h6eXgwffIwcTkzfyG4Gm2xhBsrxJBCF/9f4FrB01H
         By4fytOscglXWXGE2NB30997Qh6wvUWZ+SE6DnWfy1fbbdqn1hSc8bCpMmBEVJYVBHns
         I88A==
X-Gm-Message-State: APjAAAWT5UU7OtUgH+c6Skc2yVZon/diq3ig1p5yYTY9OdL1IZNUfJxW
        DlYcPrnqi15oVsuI+JZVlyDNF/9G
X-Google-Smtp-Source: APXvYqyX5I3Qg+bvX768B4u2vZHNDcxjEllQCS3aE7iIGFhjxmT0pmppVgNAGKFrBkJCWlqcCT2AGg==
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr22709217wrv.39.1566152889235;
        Sun, 18 Aug 2019 11:28:09 -0700 (PDT)
Received: from localhost.localdomain (x4db53457.dyn.telefonica.de. [77.181.52.87])
        by smtp.gmail.com with ESMTPSA id c201sm24112584wmd.33.2019.08.18.11.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Aug 2019 11:28:08 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [RFC PATCH 0/5] line-log: towards a more responsive, incremental 'git log -L'
Date:   Sun, 18 Aug 2019 20:27:56 +0200
Message-Id: <20190818182801.7580-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.349.g73f10e387d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Line-level log performs a preprocessing step in
prepare_revision_walk(), during which it filters and rewrites history
to keep only commits modifying the given line range.  This
preprocessing causes significant delay before the first commit is
shown, wastes CPU time when the user asks only for a few commits, and
does parent rewriting with no way to turn it off.

This patch series addresses these issues by integrating line-level log
filtering into the revision walking machinery and making it work
together with generation number-based topo-ordering (though for now
only in the case when the user doesn't explicitly asks for parent
rewriting, which is probably the common case).

The first two patches are quite straightforward (and arguably somewhat
unrelated), but the rest deals with history traversal and parent
rewriting, which I don't usually do, hence the RFC.


SZEDER Gábor (5):
  completion: offer '--(no-)patch' among 'git log' options
  line-log: remove unused fields from 'struct line_log_data'
  t4211-line-log: add tests for parent oids
  line-log: more responsive, incremental 'git log -L'
  line-log: try to use generation number-based topo-ordering

 contrib/completion/git-completion.bash |  1 +
 line-log.c                             |  4 +-
 line-log.h                             |  5 +-
 revision.c                             | 38 +++++++++++---
 t/t4211-line-log.sh                    | 68 ++++++++++++++++++++++++++
 5 files changed, 105 insertions(+), 11 deletions(-)

-- 
2.23.0.349.g73f10e387d

