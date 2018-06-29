Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C7661F516
	for <e@80x24.org>; Fri, 29 Jun 2018 15:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934776AbeF2PPH (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 11:15:07 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53764 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934241AbeF2PPG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 11:15:06 -0400
Received: by mail-wm0-f65.google.com with SMTP id b188-v6so2580066wme.3
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 08:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=27EA1CV1dWi4ip7UkBHZ9BQdjjRICm34OKcR8SENxyc=;
        b=KsY/vf+RxgDGgGtX+MqVvi2b2bo3m+eaBIkDSjlnjKorhSHu2oHotOZKd268Xnss8t
         Mkhv5XRR3ie7lHjEIZ0ZHIfENZtdBMXMPVhgIxw890hgmR3X67j/4auYtqNkKhdMpbg/
         iq3LU821x1oQZOWGI4F6bbs1HAFN06If+NEGaLW+e7XME2DWWXo38P1aFZjRB19T1sEE
         FByx2pXu0DtVfARwSKRPBobeViLbSOYUlcZQmFW6zCap39BxErnX6P5yXM0TA2Nds6wI
         SUGdRwP7090nv+zI6D1Wr8KGxCmqHDGHWPBooNxbvbNKS1lH0iYIKV46RyTAaanUeli7
         T3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=27EA1CV1dWi4ip7UkBHZ9BQdjjRICm34OKcR8SENxyc=;
        b=jXmn+KFv5HmRcCeZ7mbgZa6K7uc/MBUNW95Ow2Vxkq1YkBA9jCqD4ea+Ogbs7ADJ2s
         7QdTNS1ooc56AELFoWTROIygISmwkbK2HqugrwriSffykNtMI13dQMqzh756AExRWbbN
         auyDs12z7b1xe9aE4WphBs2gKp5R6ksRFtG7SIqNZXw3sWzuTcdKrDR5n7VbiktzIavB
         nlgP44OtyerYYvj/l9xAKcxL6nVu7GaVIj4DpQipjxy9iXEw1bD1YfSQ5QnAD95GziE7
         U2Wa/ZJwNBFdqsBD1i9ItlJLoGgZRQkHiqbce8I5pE0pF+aQATzTh3wfi+yHtRJYj1ls
         cUqQ==
X-Gm-Message-State: APt69E2IEekcHi/zTastv/tgVf2gQeMSyy6ZIMx46oLxNDmG3/CWfMHg
        BfKJnlKnUdWerD0M30mcBJ9H47T7
X-Google-Smtp-Source: AAOMgpdR+IGbiKsIK13bDsOoNYpqVGojtCdam9c3/7kYzHXoBhLVdRxR1KR+ZbrR6sWOI15205GjUQ==
X-Received: by 2002:a1c:4787:: with SMTP id m7-v6mr2169034wmi.92.1530285304805;
        Fri, 29 Jun 2018 08:15:04 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-72-143.w92-156.abo.wanadoo.fr. [92.156.124.143])
        by smtp.googlemail.com with ESMTPSA id l78-v6sm3301601wmb.39.2018.06.29.08.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 08:15:03 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v5 0/3] rebase -i: rewrite reflog operations in C
Date:   Fri, 29 Jun 2018 17:14:32 +0200
Message-Id: <20180629151435.31868-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180625134419.18435-1-alban.gruin@gmail.com>
References: <20180625134419.18435-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series rewrites the reflog operations from shell to C.  This
is part of the effort to rewrite interactive rebase in C.

The first commit is dedicated to creating a function to silence a
command, as the sequencer will do in several places with these patches.

This branch is based on ag/rebase-i-rewrite-todo, and does not conflict
with pu (as of 2018-06-29).

Changes since v4:

 - Changing the order of setup_reflog_action() and checkout_onto()
   rewrites in the series

 - checkout_onto() is no longer renamed in C

 - setup_reflog_action() is renamed to prepare_branch_to_be_rebased(),
   and not to checkout_onto().

Alban Gruin (3):
  sequencer: add a new function to silence a command, except if it
    fails.
  rebase -i: rewrite setup_reflog_action() in C
  rebase -i: rewrite checkout_onto() in C

 builtin/rebase--helper.c   |  14 ++++-
 git-rebase--interactive.sh |  39 ++------------
 sequencer.c                | 101 +++++++++++++++++++++++++++----------
 sequencer.h                |   6 +++
 4 files changed, 98 insertions(+), 62 deletions(-)

-- 
2.18.0

