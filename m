Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B197EB64D9
	for <git@archiver.kernel.org>; Sun,  2 Jul 2023 20:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjGBUKl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jul 2023 16:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjGBUKa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jul 2023 16:10:30 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07C749FF
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 13:09:13 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-55b66ce047cso1014828a12.0
        for <git@vger.kernel.org>; Sun, 02 Jul 2023 13:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688328546; x=1690920546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lQGuKTWkgJs638JAfQrkKevTZk+oajzYVRKDPczlo5M=;
        b=E0eDZXKKgTR6U3IU2v3UdEeGXcNQMIQJRu8aWJemWtlIo79yBKeMq7joxvpNjlKRwE
         ZCNy5gKxyF0rzkfQE2/QQtWwhu+0Eox4AqHKnfCliUZYXiOWZuz6fL610T/5xFzY4Zq3
         9WK7T70s4gYflXgleA0g5WWcPW2emR9trU+v+i3JRzoTiKpIGvMfiGG/dKGuX4moY1CD
         +LHvxPBmK/ijN1LgSTf5xGhsDz4pgJxF0da04+BJW+IvF/DH1NGN/hzoeoTIgwLAd1Vj
         AAalLvDj9xLeR2TKsIIxxxR6nfwRETKQoXFvJ3XkKvgfmLyM1UiD6G8lvYVYq3H0dLh8
         c6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688328546; x=1690920546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQGuKTWkgJs638JAfQrkKevTZk+oajzYVRKDPczlo5M=;
        b=cx0vtUmyrutrDHZFGUZKBmjaIIOQfxgIlp0dhdllnHdoc5RnS6fHiv7WEP8SNfSZ6u
         o/2ndzwZB0YGYlMgDZEP46K9IAQKFAQQTgF5jBvfxMF+p86+aoqMrIQvaEUWYAUcHdrR
         ailmsqXLkmb2z4NnK34wUe8FCAGtgTXKl/alS0KMaVZAFVd4dZb21lFWREKmnaYc5U0h
         jm6llg3GEcxdiqJBDFKNIxYkRgVZ8SKxHavuKgG3LZyxT4KDlG68bxhhyQbVCgopQVM5
         rEVXmjcqu0J2m8D/tn1FPmRidq2MmQhwKaqclNep/RUJA//KdSEHeiCG44vo6G8xpRTQ
         8lsA==
X-Gm-Message-State: AC+VfDzB8oCJPRulyS0FZaqqg/nTrTVA5aoVzQ5x+spAXvx7ay/G1fpI
        Zd264lXU+M7rONQIn6r0u4GyEsLps4o=
X-Google-Smtp-Source: ACHHUZ6//gmYQhUTpzyzAxGkmFyUDWV5HO2bEh9FyeK0QY9vCk0D+vSqmarlZJTJNYZCpNZYodnqzw==
X-Received: by 2002:a05:6a20:970a:b0:125:5693:4270 with SMTP id hr10-20020a056a20970a00b0012556934270mr6726759pzc.17.1688328546219;
        Sun, 02 Jul 2023 13:09:06 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id c14-20020aa78c0e000000b0067b24701daasm9342937pfd.86.2023.07.02.13.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 13:09:05 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email, gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH 0/2] advise about force-pushing as an alternative to reconciliation
Date:   Sun,  2 Jul 2023 14:08:15 -0600
Message-ID: <20230702200818.1038494-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many times now, I have seen novices do the following:

1. Start work on their own personal topic branch
2. Push the branch to origin
3. Rebase the branch onto origin/master
4. Try to push again, but Git says they need to pull
5. Pull and make a mess trying to reconcile the older topic branch with
   the rebased topic branch

Help avoid this mistake by giving advice that mentions force-pushing,
rather than assuming that the user always wants to do reconciliation.

Alex Henrie (2):
  remote: advise about force-pushing as an alternative to reconciliation
  push: advise about force-pushing as an alternative to reconciliation

 builtin/push.c | 22 +++++++++++++---------
 remote.c       |  3 ++-
 2 files changed, 15 insertions(+), 10 deletions(-)

-- 
2.41.0

