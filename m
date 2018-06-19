Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA5171F403
	for <e@80x24.org>; Tue, 19 Jun 2018 00:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937038AbeFSAGS (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 20:06:18 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:52031 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936996AbeFSAGR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 20:06:17 -0400
Received: by mail-vk0-f74.google.com with SMTP id f18-v6so7615729vki.18
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 17:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=ncPv11BHP+UJnJoqAAYENjqqLN0YNWFQPvTZ6VsE+1c=;
        b=cgwlh1kfwWi0hwagtFJe1w8DTVm8gHD8JOWvgXd4hT+GzcyujMXtvj0FP7Qwv+jkj/
         UO2nBu9QhjLrMrOBsuq2pKUNWloCe3lIkrdDETL8/3i2FVFz2pyCyA/8fkrWeR6BQpgu
         mg5plm1U77Tx+qPKE0eoMkULRwyUPzY6Uedq9GnDbXpKkXc81p5UFduiIxh+6+TmFYVh
         8gONGBGq08dJ3JZOhpnkBlGR1V5eijk5tHs3Rlewb6UOmnhqkgw+Ol0LCxXw35GLrgqJ
         yl2+bkuGyXrJwz2HJ3exKUcfuBRm3o5E3QlV7HgFo78j18TWN3nhrp2LvnOkAvcaLS+P
         hZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=ncPv11BHP+UJnJoqAAYENjqqLN0YNWFQPvTZ6VsE+1c=;
        b=qZYGMwrBvLZ44p4VyO3oGbE47+sQ0MvvCIf34tzte6BEI1S5ibpNmtwCI2bcChZlyp
         538WoB8vgpgItsE/746m6Q7GZnEMPXha0AZoOn7MQ6SFXZ/K+bd9bA8OJzssZDVKv8AD
         MmyUuJsCOh2A92Y8qw49jeGL5Wz9zqTI+WqTWyiCRjIjxNdrS9DHpzCSGV0XhRFyuqSf
         mBTUZXRPMjiN+NmZ2PS1OPljL+rLMdiRMoX3puJ80UzyQ8jdiyf9p7ESmUCykusTxzTM
         OgvvoqxtTEHrfdkH1B1mTBaMe7wyTI+gM5yUYZ9L6yHvDoYs0yLl1d9dz99SdA+TnOt9
         uFhg==
X-Gm-Message-State: APt69E12DKEs/lggYKhvb5X5t4C36dnvPCj6t3zLqoC79vHxERMNP/0Q
        AB7MG689nbI7wCLYnxWyt8OBlsnrDCny
X-Google-Smtp-Source: ADUXVKLeQnfd7dy5YKcVRhzC6FytYMa+IRcu/WezFcjYjRFMKSYScJt2xr3Fr8gB3KQbKqO2VmKpDYMBUusg
MIME-Version: 1.0
X-Received: by 2002:ab0:16f:: with SMTP id 102-v6mr6693231uak.62.1529366777141;
 Mon, 18 Jun 2018 17:06:17 -0700 (PDT)
Date:   Mon, 18 Jun 2018 17:06:05 -0700
In-Reply-To: <20180612235825.12271-1-sbeller@google.com>
Message-Id: <20180619000608.147422-1-sbeller@google.com>
References: <20180612235825.12271-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH 0/3] submodules with no working tree shall unset core.worktree
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:
* fixed quoting issues for white space'd names/paths

v1:
The first patch teaches checkout/reset (with --recurse-submodules) to unset
the core.worktree config when the new state of the superprojects working tree
doesn't contain the submodules working tree.

The last patch is teaching "git submodule deinit" to unset the core.worktree
setting as well. It turned out this one is tricky, as for that we also
have to set it in the counter part, such as "submodule update".

Thanks,
Stefan

Stefan Beller (3):
  submodule: unset core.worktree if no working tree is present
  submodule: ensure core.worktree is set after update
  submodule deinit: unset core.worktree

 builtin/submodule--helper.c | 26 ++++++++++++++++++++++++++
 git-submodule.sh            |  5 +++++
 submodule.c                 | 14 ++++++++++++++
 submodule.h                 |  2 ++
 t/lib-submodule-update.sh   |  5 +++--
 t/t7400-submodule-basic.sh  |  5 +++++
 6 files changed, 55 insertions(+), 2 deletions(-)

-- 
2.18.0.rc1.244.gcf134e6275-goog

