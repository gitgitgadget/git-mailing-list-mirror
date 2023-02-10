Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2D4C636D4
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 17:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjBJRON (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 12:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjBJROL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 12:14:11 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62F029424
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 09:13:57 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d8so5916907plr.10
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 09:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t+14xD819xrZfbZVNAMvc/qb6BvNee6khAbKrixRjwM=;
        b=TLTnvAINYEt4CGUJqayBYGO31q/I1yLGlOYQ6YaBA4ZbgU7S8JNRAbn7x8awbMHsir
         cgj0y1DUsqKsEwV5NBtROhVUDvQtP4KpYBDYK3NzWycnP4RHaUJE33YNyLn63TWdKp1x
         sTYhFNkg8YMO/qLqNdUIWoj0cxDKaN8/MqRroniXakQGUQeBnijhmiy4DoenOcvEdmdv
         c/E9t+aFocNEFeTMFAiOjDxx61JdMieAcMZKs/FEKvmJByBVH1Mm0XUbkJt2mHNY/8r3
         CeAvKJWyMC3nlPLLmA8xoEysnH1QthGBVvqp1kw8lypOhZ51wP6Yt1bPYLx9ONkaRB3y
         GBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+14xD819xrZfbZVNAMvc/qb6BvNee6khAbKrixRjwM=;
        b=HUshDo/UMz1dGUTJQeb231Y5XGqxYn5Vlm60d924vL15RRfPxhZ+isT3cvKCH5zXoW
         X4JQt6rMc1+C//aIjt+aOSH1dxngh0IWuHOS594OK+lg/FB9v1hyyFdl4mSQLk+sm7La
         sk6ptEi71+bo1lLBu05NdgByij91zU3+mC6GHLtw57oLQKtq0FANvp4FbLabwYzDe7eK
         xF54Dxusvu0suuu880NFUeCOfjuQQqcsnpMDAmgNo36quBwMFhB8ukBmKC//MEIYITpq
         meeCRUZVsqFhP032T6M9/+gCZZPKZShDx3nhR8XG+Ejb2y1PiDlpZJVhwt9sVzSiI3pB
         uYLQ==
X-Gm-Message-State: AO0yUKVIed94+thl2OHzUW5v1vvP+skyF7Vk3UR4L3o7QQFDTLgqnmrP
        hvXoIsYp32V0Wi0tFmpwHgpgqWtvUzW4Pw==
X-Google-Smtp-Source: AK7set/MDb8IbBcnm8z9PzXyyqoDgZBbwuVOXCcYYMnLqeWRnRPiwYlVf0+pl4SS1x+8uEScBsjXrg==
X-Received: by 2002:a17:902:f114:b0:19a:75b8:f4fd with SMTP id e20-20020a170902f11400b0019a75b8f4fdmr1631185plb.25.1676049237438;
        Fri, 10 Feb 2023 09:13:57 -0800 (PST)
Received: from localhost.localdomain ([2405:201:6805:20dd:94a9:fa14:fe37:b9ef])
        by smtp.gmail.com with ESMTPSA id l10-20020a170902eb0a00b001928c204428sm3622401plb.142.2023.02.10.09.13.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Feb 2023 09:13:56 -0800 (PST)
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, Vinayak Dev <vinayakdev.sci@gmail.com>
Subject: [PATCH v2 0/3] {apply,alias}: convert pre-processor macros to enums
Date:   Fri, 10 Feb 2023 22:43:35 +0530
Message-Id: <20230210171338.81906-1-vinayakdev.sci@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Revert changes to alias.c, and change variable types in apply.c

It is needed to revert changes to alias.c as the changed #define macros were actually returned values,
so it is not right to change their types to enums.

Also, SPLIT_CMDLINE_BAD_ENDING is returned after changing to negative sign,
breaking the validity of the conversion to enum. 

The changes to apply.c are actually useful only if the variable types are enum,
so change the type of variable int patch_method and function argument int side to enums as well.

Changes are in accordance to Eric's review of v1:
https://lore.kernel.org/git/CADE8NappDSaZrMLeqak4is59oL=X1wJOj2eCLLjaCKyrnoK9PQ@mail.gmail.com/T/

Vinayak Dev (2):
  Revert added enum to #define
  Change types of int patch_method and int side to enum

Vinayak Dev (1):
  Change #define to enum in apply.c and alias.c

 alias.c |  1 +
 apply.c | 17 +++++++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)

Range-diff against v1:
1:  f64b1af2a5 = 1:  eaaa09dfb1 Change #define to enum in apply.c and alias.c
-:  ---------- > 2:  86e27e7f64 Revert added enum to #define
-:  ---------- > 3:  17233eb3fe Change types of int patch_method and int side to enum
-- 
2.39.1

