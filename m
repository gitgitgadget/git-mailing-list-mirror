Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2400C433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 03:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9AD020829
	for <git@archiver.kernel.org>; Wed, 20 May 2020 03:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5F0pjMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgETDpD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 23:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgETDpD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 23:45:03 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3E1C061A0E
        for <git@vger.kernel.org>; Tue, 19 May 2020 20:45:03 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t7so784471plr.0
        for <git@vger.kernel.org>; Tue, 19 May 2020 20:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VDmYA/0DSm05/5nXK94Xi2UfV5UKqKc7LZVONxsIMB0=;
        b=g5F0pjMqqt2YnnHet/BG8LM+4ex2XHzySd1wOF1IRUizGwLse8Iz+udl1qTXP2/VyU
         akVh7Vs4BmElEMAQNhPjBE394qij0JdJ3paHhF8zK08d7oTShtzMqYzwffjnhdym9kNH
         EJL6TYs6k+YOeRsTLlANFlv9QsdVcQKxkGuBjvUPWvvKNqQ4bR8NXVzIoZhV1t7DOpoF
         85AW3Qn7G+UsNfP/QmqJ2nAJUqC3yw2apxw+dk1Z9m+qynuCaB7NowuXd45DgS2w0s+k
         Ub2EUIMTRb+rXQA1Oz2QknCIrb9wQqp3wZwhJ0T+86T2wCZ8kFib5sDhWZ0wI3Sk7KVz
         xakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VDmYA/0DSm05/5nXK94Xi2UfV5UKqKc7LZVONxsIMB0=;
        b=HI7Z8MfdJvfy1ka7TfKbgx23xMz1s3/r0y5O4sNbDawrzvCfvAaHGMkS4fDeLJCQQL
         b0maqk8LzVgLbx0Two5Tke8aPWyEESQhwGhm15oSEGp7AA10XBI5pAQuhyzsGOMiUqNL
         hI/OaIWwRBgawFrWw+ARY3vDyPqUBZjky7tC2WUCT1fBrf0hwQLpTpcdgvd1ckSSW7Fg
         X6YTKa/Xid6akau3UOLjyrUZ1mTMrE9SHlx5YYJTH3iqSUY5IZcRgizLzB1O/ZFmZNdD
         13NOmq2GKqo7OieZY/XL673gVOdcFGQUWff7dQ298H79NePNmjciYL6aSbJ1YAcmd1f9
         9cSA==
X-Gm-Message-State: AOAM531f9Uais4ilMk0hI3Una0elIP+w5TaXSLt/8CiKYv9+nUoxsiKT
        iLeYE/nLb2jLKV0ypdrhnHLaC3Md
X-Google-Smtp-Source: ABdhPJzR4EzTU9G7Ncbu4gPrwkW6F6rmh2Xx/G+FAEd90Q6Wxhqzbc0wqVccu9b/vMara5D1P45VGA==
X-Received: by 2002:a17:90a:c393:: with SMTP id h19mr3092334pjt.125.1589946302453;
        Tue, 19 May 2020 20:45:02 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id h4sm762820pfo.3.2020.05.19.20.45.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2020 20:45:01 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     liu.denton@gmail.com, chwarr@microsoft.com,
        garima.singh@microsoft.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 0/3] openbsd: fixes for 2.27.0-RC0
Date:   Tue, 19 May 2020 20:44:41 -0700
Message-Id: <20200520034444.47932-1-carenas@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0.187.gede8c892b8
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First one is the only one exclusive to OpenBSD (tested with 6.7)
while the other 2 are likely also needed in other POSIX systems.

Carlo Marcelo Arenas Belón (3):
  t4216: avoid unnecessary subshell in test_bloom_filters_not_used
  bisect: remove CR characters from revision in replay
  t5520: avoid alternation in grep's BRE (not POSIX)

 git-bisect.sh        | 5 +++--
 t/t4216-log-bloom.sh | 2 +-
 t/t5520-pull.sh      | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.27.0.rc0.187.gede8c892b8

