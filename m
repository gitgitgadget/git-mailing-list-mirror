Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 434C71F404
	for <e@80x24.org>; Sun,  4 Feb 2018 22:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbeBDWNJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Feb 2018 17:13:09 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35561 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbeBDWNI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Feb 2018 17:13:08 -0500
Received: by mail-wr0-f196.google.com with SMTP id w50so27772196wrc.2
        for <git@vger.kernel.org>; Sun, 04 Feb 2018 14:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w7YKi2+nM7JQENur4nxu+8wAhhXme/lad+Nob7Dhg8U=;
        b=CbT9ihlxqnQU4puJb0mPhkyf731TJXTLNHWhSZGgwH1zAJajnOJUcSMFnhR2/hO4ql
         3Iiwd6/nJ13ejqfU0kMft+fkdTMpjr26Z5COVjaM1kWgoveLEWmLUklkpqpdl0Sv6/Ag
         1gl+emX3r3gqZFYWQYYHpNsex4UeTjoWV7IpoJsy8SwjlcTOQphUDZqn5Tgrp2D4noNC
         lyFcnha2/Bz6fjEAYeDB88MQJSsc0stROWUgHp70G6t8I1BnUkaMLZN5ow+qZw0lfvkn
         LD0UtQy1p/ep2+FOXlpHCI9EwYfjeBhwc3H9/E3NmbAfgbWeQFpixixdfjq/pBzPLQbz
         Gx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w7YKi2+nM7JQENur4nxu+8wAhhXme/lad+Nob7Dhg8U=;
        b=Um7Yg3Hn8Lcn7TOyBHMn1JLxg9FEF4nObMHNDcaHKcVRO1fbB2D1lPyK1cJSMQpbGn
         rPcc/xDBKM5IwZGSWk8Yc59DZR5n25FTXty4/uRwuNTa6I7j5IgJ1bvdxMsHU2TH2n68
         b87wkobG9U937gtlXPRVC2dtglAjOG+KIIR63d+MV9Mq8QBZTnTnDTnKue0HhkJ1k0a/
         giRsRWQjYoDQvpLJ8kkCXLyrge430NF9SQHTux+FdC5/J1tj2yOcezhlvEPTIMrkKeOv
         K3O5VKPHgM+1bYjF4XvTVO/dyfi2ccnLCkfxVXu9BqcXgaBF6j4H+sNfon738gNpLFix
         R3HA==
X-Gm-Message-State: AKwxytcb53mEI6uXUd1Whq2QGtL4MKvIM1SLn1NWM3TxWbqAqZKCzxnG
        5TZFfCGPBlOUQsKqf+v+rrBQAtyw
X-Google-Smtp-Source: AH8x2260lldg4R4bR67OunieyAdCEsFfPn750bf5GiH49d508quSkZoUGRBhly5uVH4GpoO1WVWc4w==
X-Received: by 10.223.132.103 with SMTP id 94mr6478311wrf.115.1517782386996;
        Sun, 04 Feb 2018 14:13:06 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id v20sm2098101wrd.32.2018.02.04.14.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Feb 2018 14:13:05 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 0/3] worktree: teach "add" to check out existing branches
Date:   Sun,  4 Feb 2018 22:13:02 +0000
Message-Id: <20180204221305.28300-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.101.gde0f0111ea
In-Reply-To: <20180121120208.12760-1-t.gummerer@gmail.com>
References: <20180121120208.12760-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous round was at <20180121120208.12760-1-t.gummerer@gmail.com>.
Thanks Duy for the comments on the previous round.

In addition to the additional functionality, this series now includes
improvements to the output of the "git worktree add" command.  It
doesn't include any new magic to guess the branchname, as was
suggested, as that would be a bigger change in the behaviour of git
worktree, and is not a particular itch I have right now, so I'd prefer
to keep it separate.

Thomas Gummerer (3):
  worktree: improve message when creating a new worktree
  worktree: be clearer when "add" dwim-ery kicks in
  worktree: teach "add" to check out existing branches

 Documentation/git-worktree.txt |  9 +++++++--
 builtin/worktree.c             | 45 +++++++++++++++++++++++++++++++++---------
 t/t2025-worktree-add.sh        | 15 +++++++++++---
 3 files changed, 55 insertions(+), 14 deletions(-)

-- 
2.16.1.101.gde0f0111ea

