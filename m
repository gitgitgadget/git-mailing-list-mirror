Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1ABDC433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 23:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74FE021D82
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 23:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s75jojjk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbgFSXgc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 19:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730480AbgFSXgb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 19:36:31 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0466FC06174E
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 16:36:31 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id q8so13285296iow.7
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 16:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+ZLt4Q8nFQmX2hByj8rJYu7ALCEkeGp3vyCy9JECNU=;
        b=s75jojjknOK9ExsAXb/t/yarAXf7yHTMsbOKGkOle6dy4SryrIMcUOo+mTx4762icG
         eIi0j3JB02VAgZDyvhOHN6AYG1rFbuB6e3BODAoUUWluGi+Vq9qNjqyaYTTdvyDWfGzq
         uhMO0P2BdFQ+qxQ90mTP37YzNQwTzXvKvrNPpq5FBXzJrOVuduSV1JQ7wYzdImsIP6+U
         X8DKl7MqaLRw8bnOCoD8k5sbaWcyd98GO/NmNgSQAWiB47WzMTveeIS06DEBeTiuVsOY
         UxUGx9h50sQaEqj++7LbGfyilhnSm36v+fmr4Loi9HenQ0wh0WdiE7Q/FDCfgRvAhNI3
         eYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=T+ZLt4Q8nFQmX2hByj8rJYu7ALCEkeGp3vyCy9JECNU=;
        b=gEtgMHytRgvuPFH62d0VieF8geyyaJqj5Qwe+YJuyR6wVWQzbLAXuz2yVVuh2+Jpr8
         fEgwZtn/mDob1Kk1+iSzxVmQUTbHL1j7y1gith/xHyigBl7hoxuqiPq8ylFR5SxmkT/W
         HaI63q15ADzFpoeYSlokkRZnVVmsuvlKWd9CaClzjSjUezdmYPABFmPyQtFKzH2tgW8f
         bTqzeY7mXeArUkbdicfNBUUAcFmSLotJvYLVEwlEJNjvesSWlx0BrsZG6NAb2PCczFuU
         eAzKibBA3RLm8PHTtqMS7ymGGvWXl/6ym7JTFQfl557wDdbCyNnDthJoatMvx7MtTkyZ
         xpYA==
X-Gm-Message-State: AOAM530owLTaK/bXBWlMhc+kgunaVu1phPS0hpbHIqNUormPjPaupipj
        NFyMupdyizqeDZolBDOL/7cAXDfrn14=
X-Google-Smtp-Source: ABdhPJzOjBTWJcU6AuCi3JEekyBeWLRMoN4aHBTyC8z7oggHKH+6ZysZg9k0Qk0wubVyhCv8MJOqlQ==
X-Received: by 2002:a5e:9b0b:: with SMTP id j11mr6997346iok.17.1592609789913;
        Fri, 19 Jun 2020 16:36:29 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id q5sm3890723ile.37.2020.06.19.16.36.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2020 16:36:29 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/2] drop specialized knowledge from generic worktree code
Date:   Fri, 19 Jun 2020 19:35:42 -0400
Message-Id: <20200619233544.42025-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.27.0.221.g4d328a12d9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series removes specialized knowledge from the libified
worktree code about how front-end "git worktree list" wants worktrees
sorted, and instead makes it the responsibility of "git worktree list"
itself to do the sorting.

It is built atop es/worktree-duplicate-paths since that series adds
another caller of get_worktrees() which this series touches.

A possible argument against this patch series is that some other entity
may someday want worktrees sorted in the same fashion as "git worktree
list", however, that seems a case of YAGNI.

Eric Sunshine (2):
  worktree: drop get_worktrees() special-purpose sorting option
  worktree: drop get_worktrees() unused 'flags' argument

 branch.c                  |  2 +-
 builtin/branch.c          |  2 +-
 builtin/config.c          |  2 +-
 builtin/fsck.c            |  2 +-
 builtin/reflog.c          |  2 +-
 builtin/worktree.c        | 32 ++++++++++++++++++++++++++------
 ref-filter.c              |  2 +-
 revision.c                |  4 ++--
 t/helper/test-ref-store.c |  2 +-
 worktree.c                | 20 +++-----------------
 worktree.h                | 11 +++--------
 11 files changed, 41 insertions(+), 40 deletions(-)

-- 
2.27.0.221.g4d328a12d9

