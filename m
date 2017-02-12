Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B35A1FC45
	for <e@80x24.org>; Sun, 12 Feb 2017 18:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbdBLSlf (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 13:41:35 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35101 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbdBLSle (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 13:41:34 -0500
Received: by mail-pf0-f194.google.com with SMTP id 68so3880163pfx.2
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 10:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y2P0G+e8b669yu/Ojrd4p3PvZFwXqaEuDCf4rhNnrGM=;
        b=qsL+mctN/bdmbsCTWHech8UNVNUz37IZGxiUwUvsSm3Lt5nx2/jc33yDUgkbthHHt3
         x43Mpf35uYGCi/k2lHUfwD0vSl1Fy/pVfUJJST3bvcPjAgSC54RX1lDuBi5pisY40STK
         ARHcDURCwMwqXlIbbjQsf47nlrZMB0VKjDlq3aVv+Fu7rrK2d2y4e3Qx5neUtAaR9YZV
         l7lIi83GBclKlMPnihC8p1OoVUju6MeIicsx0YnbIz5ja6f8CFwYPK3mSibjfwBPj1ex
         4kb3Zx2J5UDIhV0AbJaaanBcnVnys+UArcybjdh9+mleo+5kUtqcMwnIS5II/wP75lA5
         IgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Y2P0G+e8b669yu/Ojrd4p3PvZFwXqaEuDCf4rhNnrGM=;
        b=F9bmT0NtBzY3b8v2MFWfUpZs+EQ0qCRvn6P5oEQjrBdnW/uB1tSq3DKoVdEgFtywTo
         Rn1LmRxFod2xtCjxS0ktuIvetBzFpFamEXDsCo3QG1O5hiIiSU8jlS2dVYAtXgp0UOwP
         NNX6mLbp3aAI3P+HyJOghOvLcmoN7xYgbLU9kB8chINLcsnyljMDxhYsDsRjJPHYPKIU
         8F7PPg7zsDxe9Zzn18psra2Dbb8ihjvCJYcagOqVf1IqvcVCBQYYW4o07Zz5tHgFO+E3
         7HiVUaZdbwvwWTvMtELS8tL1uEeZOyl/N1i3N0iSZ8acVNUnpaCSdGJBxYfumcdSNU5u
         BARg==
X-Gm-Message-State: AMke39maUBVodzglAoxfuwMykY1vgvgCZbGIuiGztNlKK4SK+11N+84OSLCQzb+HqdeDTg==
X-Received: by 10.98.194.22 with SMTP id l22mr21706371pfg.178.1486924893938;
        Sun, 12 Feb 2017 10:41:33 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:644a:2999:a3b7:74ee])
        by smtp.gmail.com with ESMTPSA id p14sm13195915pfl.75.2017.02.12.10.41.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 12 Feb 2017 10:41:33 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: [PATCH 0/3] prepare for a rev/range that begins with a dash
Date:   Sun, 12 Feb 2017 10:41:29 -0800
Message-Id: <20170212184132.12375-1-gitster@pobox.com>
X-Mailer: git-send-email 2.12.0-rc1-212-ga9adfb24fa
In-Reply-To: <xmqqa89sguu4.fsf@gitster.mtv.corp.google.com>
References: <xmqqa89sguu4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It turns out that telling handle_revision_opt() not to molest argv[left++]
does not have heavy fallout.

Junio C Hamano (3):
  handle_revision_opt(): do not update argv[left++] with an unknown arg
  setup_revisions(): swap if/else bodies to make the next step more readable
  setup_revisions(): allow a rev that begins with a dash

 revision.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

-- 
2.12.0-rc1-212-ga9adfb24fa

