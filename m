Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA0C220958
	for <e@80x24.org>; Thu, 30 Mar 2017 01:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933292AbdC3Bmp (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 21:42:45 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34803 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933103AbdC3Bmo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 21:42:44 -0400
Received: by mail-pg0-f53.google.com with SMTP id 21so23659028pgg.1
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 18:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=s1OLyLC0ljNeA8ZC6K+JSR3N+9cXIJwX8UNGPWFdNzM=;
        b=QYcz+qJopM9g9rF7CRjaXKQhcAWDhn8vgQSM6EyhDZMJ86pqUGANmcuENTZssT542P
         1Yx+dNaDepNDEPFZiHIFkTbb8evgH46HRR6bGHslZeMKoIPxtqjHajXB3Vq3JlVbpaxC
         pHaRYnuASpu4XRjlej4kBUMzFGBC0k+fc38whXDfR/3e9ooHR6igGUDr7wqT95zUQfHU
         7RZDCGBkREkFmL8u16+rQ+zaMnPAlOlDX1YK/XE+UR2FdqcyZwngsMSvoR5mix+jiI6u
         +bPr4cbN4RO9iAUGFqqs9uMBSWH6Z//kC1q2wxjhj8ENKreItrrYt3sYvvcGOBGVagce
         KiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s1OLyLC0ljNeA8ZC6K+JSR3N+9cXIJwX8UNGPWFdNzM=;
        b=HklFjEzcQqK75h7S1DquPoSbfeu0sOv5XkSmz0R65lZCDEsSVdGPJRFzavWIcXQLas
         EIIsTAtShJoBwKd/H3yC7JtCR/0ADv03jt4KXU27nE3H0u5w+iHgBvOJ3x+OxDVMQrPM
         AjT/++yNejkHTkHlmd9Wq5glXiUDUPAwVaNHd5QMeopVZYSV9+Ro/zvhKSdGIOoS3zDN
         f6g+Gx6RddMqToa++4ueHEAQSMRDEhZtFV2pN5GnSkLpmnMr2XUvkX9FIS/YrxStTSa1
         0R7mbCcKc68hAfi2b51me0YJFGPMixhiYHlTgmJ8gLLm/HhEzul8urXV7jCn/N93pOw9
         ScHg==
X-Gm-Message-State: AFeK/H3tAAvYuWZ33sqyphA7q+agtRXYWR8wT5Q9AkE3QtK0A5+f75ZNjAHJxwHs5Evzadsl
X-Received: by 10.84.136.34 with SMTP id 31mr4023211plk.52.1490838162387;
        Wed, 29 Mar 2017 18:42:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:cc96:1eab:fd67:9864])
        by smtp.gmail.com with ESMTPSA id n4sm569840pfg.73.2017.03.29.18.42.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 18:42:41 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, peff@peff.net
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/3] Respect column.ui in commented status in git-commit
Date:   Wed, 29 Mar 2017 18:42:35 -0700
Message-Id: <20170330014238.30032-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.511.g2abb8caf66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When studying the code, I was nerd-sniped by the commit message of
4d2292e9a9 (status: refactor colopts handling, 2012-05-07)
as I did not understand why it was so important to reset the s.colopts to 0
in builtin/commit.c.

In my adolescent hybris I nearly sent out a patch claiming that line to be
useless and wrong, but then I studied a bit more. After the background story
became clear, I decided to "just write the missing piece", how hard can it be?

I would consider the following three patches a hack, but they work. You can
have untracked files in column mode in the commented text for a commit.

Thanks,
Stefan

Stefan Beller (3):
  column.c: pass column_options to down to display_plain
  column: allow for custom printf
  WIP - Allow custom printf function for column printing

 builtin/commit.c |  1 -
 column.c         | 21 +++++++++++++--------
 column.h         |  3 +++
 wt-status.c      | 29 ++++++++++++++++++++++++-----
 4 files changed, 40 insertions(+), 14 deletions(-)

-- 
2.12.2.511.g2abb8caf66

