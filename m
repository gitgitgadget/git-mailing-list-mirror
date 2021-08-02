Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216A0C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 20:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0516E60F41
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 20:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhHBUuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 16:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbhHBUus (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 16:50:48 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D96C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 13:50:37 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id s11so9548190qvz.7
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 13:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pZsshCoPbU+Xvwkde1/t7mkjDoZbao15WBSeCI4trsY=;
        b=hsxQEGI3NEo2y53QkrZ8JMm5jGbq4gUuRkZBudC2lyY6YOesK6t/dN/UHvsT04c3i5
         F5xjPliqjFgZ0LzIWffdrIwvJSD0FGZU/bkKSZs7Jb5q6mqf0itxJKZ1ZsIFPJpdReTh
         +7+BtJj5nXD4alzSf0MJLOaylsjHAbIdGaPt0icLTFGD2U3k+pQrhLG4jdkpFnsujaWL
         GypGIhUPuRu9Hnf/KwpfxIt8sdE/wwDiW6MwqijYOxMyauhBt67ERdr2S8MBAAxQuxlz
         4mzWuKBl8R6Sp993dlQqBHH8CbR6tzYw30Uz3xqZOYaR28f3QYDyJYvte+R5+56sXWi+
         EDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pZsshCoPbU+Xvwkde1/t7mkjDoZbao15WBSeCI4trsY=;
        b=ERrHtacn0YdHNAeSP8D7BXDARKBvb7xP2CTX7tnZjNW1NMpopCHwf8drTXlCKZekve
         no//NCIuiOVUu2aPu63p7vo0wdwTZ9syleK4du0zzLGJ4kJ2By/4xK5d4JBFkCMu6keE
         L+WO/8e//jekrMKBA2F+F3ETqbba+FJq+orzKSktA479I8CDwa8a4zH9ir2/BxDfr+NK
         L8aDl/p/vxVwZLXgRJI7N7zZm5Xzxw5XHfaglUnhZ8H33RWkmoSsCeIyFyv1ZXx/u1NO
         243ZRq9cvsYIL7sFhGDVHu/BAIcy2oOESGD5yy+QU7R5kdFSjklPuY9xeg9FlXRyTZyz
         KrGg==
X-Gm-Message-State: AOAM531iNrhtEJ22YhSVotmsMrkNibhvMDeSy2DxyGwntREJZJwISuHQ
        RQCYrCXCzPQ6kBFwXhjD/HIOrlUqAZI=
X-Google-Smtp-Source: ABdhPJzS1JIHiwm+WJiBMMH1weDV7o/k0RW9Emu65ZyBCofAVr94u3zRqpo8LhM7jUk2tP5P0Vtv1Q==
X-Received: by 2002:a05:6214:134c:: with SMTP id b12mr16762154qvw.39.1627937436895;
        Mon, 02 Aug 2021 13:50:36 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id v5sm6539073qkh.39.2021.08.02.13.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 13:50:36 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     git@vger.kernel.org
Cc:     Thiago Perrotta <tbperrotta@gmail.com>
Subject: [PATCH 0/3] git-send-email options and completion improvements
Date:   Mon,  2 Aug 2021 16:49:50 -0400
Message-Id: <20210802204953.229867-1-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch makes git-send-email completion (bash, zsh) uniform,
centralizing the completion options on git-send-email.perl instead of
git-completion.bash

The overall result is that git send-email --git-completion-helper now
properly emits send-email specific options. Previously, it was only
emitting format-patch flags.

Additionally there's a sentence in git-send-email(1) to explicitly
mention that format-patch options can also be passed to it. Currently
it's not obvious this is the case from the man page alone.

Thiago Perrotta (3):
  Print newline for git-send-email --git-completion-helper.
  Move bash git-send-email completions to original script.
  Expand git-send-email docs to mention format-patch options.

 Documentation/git-send-email.txt       |  2 ++
 contrib/completion/git-completion.bash | 11 +-------
 git-send-email.perl                    | 35 ++++++++++++++++++++++++++
 t/t9902-completion.sh                  |  3 +++
 4 files changed, 41 insertions(+), 10 deletions(-)

-- 
2.32.0

