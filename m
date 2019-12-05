Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80862C43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 23:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41954206B8
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 23:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b30u/44v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfLEX6B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 18:58:01 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]:35015 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfLEX6A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 18:58:00 -0500
Received: by mail-qk1-f174.google.com with SMTP id v23so5017126qkg.2
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 15:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QpwWWamlnUU35lSEsLed57YxTIvEHOHaq7nIWrDdeDM=;
        b=b30u/44v01UlL5F1NVv9IGkv1wpv6E7SWIwCRjgvTGsGyg/IyadJrAN7jojtZhuWzX
         8Nl+vvaC6+F40Yl9cMLKMkn/AskFi5T+uBigv5O+SyQ1nJFdh2gys7N2j0t0oizFS/lf
         oNeh0hIYdo34pzPyS2ogIPrk1FBn7CMAqms4X9ummgP728jcc7+Ey+1B+bnyTi2pnBzp
         mRjqTUaWeVeJOjNXN8PBiWG8pDGOiHhTkM74pinI6vJ1/LLCZQ1zuQB6vLx29Rs/BDky
         mbaxjBMMn8yde+1/4eOeJtyaHYIzmBz5m0aQAdtQzGN7/HybPLUTJFfa52uRksYc2Jw5
         BwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QpwWWamlnUU35lSEsLed57YxTIvEHOHaq7nIWrDdeDM=;
        b=lbMH+dRJczUQhT8FeBs76Tf9Ef/qf062Toi8QHnWCpZm0lxagxC5MjoHSpOnySfeED
         bLezgiJA0hbaEr4i7XPSElFOQT1b3qLBh9byvPyFj13dEFLgQZrUHm6IAv7z3wHnUhUN
         LjRHsXqvXs4VC4y/5xgyFbq2uB9fGcdJUNwKyl1ybW9+bp9Mg3Lr9DdnfSWDoRqJ2AZ+
         hPZ1vjcy1Rk+WrHj7baeypweHh9ToBLHUGz3g4YvOBHL2ZHLIVSi8HoXAtL2PEyDxIsR
         23f+nSfU/bwqEaA9B/6lqjpL44wI38/QqBdsAna6UEPCXKOZxmVCCoAR4wwPM7Tckcp1
         9cUw==
X-Gm-Message-State: APjAAAVxN7mFXiponxN+CiCOmgWyMB3zZYlS+XC7DZ2kW6HTTzmcI74c
        nVlaaTZ3pBzGI2S4eV6ITHxtfVvQmIVvXA==
X-Google-Smtp-Source: APXvYqy3ejkkn3EHbQB0yc7ak3FSRbl0eRAAuvXcNzkQ84jaUEY9vu4jD3CCstLpQUrTaIsrk189cQ==
X-Received: by 2002:a37:b883:: with SMTP id i125mr11443054qkf.64.1575590279513;
        Thu, 05 Dec 2019 15:57:59 -0800 (PST)
Received: from alex-torok-7530.int.uberatc.com ([216.99.208.249])
        by smtp.googlemail.com with ESMTPSA id q34sm4641975qtc.33.2019.12.05.15.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 15:57:58 -0800 (PST)
From:   Alex Torok <alext9@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Torok <alext9@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] rebase: fix bug in --fork-point
Date:   Thu,  5 Dec 2019 18:57:02 -0500
Message-Id: <20191205235704.31385-1-alext9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205225322.5529-1-alext9@gmail.com>
References: <20191205225322.5529-1-alext9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reorder commits to include the fix and test in the same commit.

Alex Torok (2):
  rebase: refactor dwim_ref_or_die from merge-base.c
  rebase: find --fork-point with full ref

 builtin/merge-base.c         |  9 +--------
 builtin/rebase.c             |  4 +++-
 refs.c                       | 14 ++++++++++++++
 refs.h                       |  1 +
 t/t3431-rebase-fork-point.sh |  1 +
 5 files changed, 20 insertions(+), 9 deletions(-)

-- 
2.17.1

