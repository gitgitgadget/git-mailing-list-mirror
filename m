Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E960C64E90
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 19:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D9C020786
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 19:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Siq/OanZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgK2Tx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 14:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgK2Tx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 14:53:28 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38A4C0613CF
        for <git@vger.kernel.org>; Sun, 29 Nov 2020 11:52:47 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id v14so16524432lfo.3
        for <git@vger.kernel.org>; Sun, 29 Nov 2020 11:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YjCjI8cKRKXq0aT7bTTD2Qa4LPycJXxnAUEmOMGlK+c=;
        b=Siq/OanZMRLGhaCcBZxw/AOE+EnVw01hsI7Bto/N4USjg67H7U/jf1cTrTFapBoX0O
         cEHPbIjKlHBEPP12S2JGkJ/Q9gUSJeiesWjl91TZFVHm82nFW2URgyt0F0C19yCZmehM
         QuZHv0W7rIU+mBCmlWXLsveDMUX0wNSxUK9uFNliyT+KQ4yKhXmwDXLk/hImh90eO4Xo
         rBE+OD03uWWpWL6fai8eazQPgAuGY+bl18TvxeGYBitjHdzpbgFoPXAWFLXmZQ5aK8X8
         b8YflDH2eHRFsDe6YdKJM703bzKw9PHLdBJ20RUL7GcHkeYPpnknevC4b7ZRNTIuVuYl
         PjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YjCjI8cKRKXq0aT7bTTD2Qa4LPycJXxnAUEmOMGlK+c=;
        b=NMbqW/a+ioV//SR8R3/5Y4NUhHnpzWXnRuxmDfO0gIrWGKNbBsrwiV+i8e9mnJ/+Ji
         lgZYHzBsR7G05AuKiJsUq5gmOgjfHzcJAUyoJPJwnYhYypcJznkmBAbiJjacrpRK3QhT
         2+zP9p1otooJuXrhuxamNN+LFU6Afs+Bdho2hM+T0AYJpKp+jXSaSmpzi6qwVOVX+dIT
         Ux/9vZyLXxtLrAtQjk6qtSuMPTuAVvHA2xXsE1v0c2BcEUc2R+T1ABRHarE0ABv2QvCJ
         WjhKq+sdwkbjJ1pf79/OPTnx77ao0JYxQJrEnIv16o+zIFl/1IpS9xaMmIunz4cF0jQL
         O6rA==
X-Gm-Message-State: AOAM531k/zuZ9jmIRDkG/7BhtT+bv0JRHjPk2VOnKcyhM1dSOQLjxj6K
        jvlyduK24I3NSAjiDzs1hpdjaxoYEw0=
X-Google-Smtp-Source: ABdhPJzedRbgySmtS82+2zKHb7kTh6OeHTAj5cWM1jz1egKs3Fwnd7hkZOOG+f8Y3omxm5WyKmpuTw==
X-Received: by 2002:ac2:456a:: with SMTP id k10mr7535344lfm.88.1606679566050;
        Sun, 29 Nov 2020 11:52:46 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id w72sm1808707lff.89.2020.11.29.11.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 11:52:45 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3 0/4] grep: simplify "grep defaults" handling
Date:   Sun, 29 Nov 2020 20:52:18 +0100
Message-Id: <cover.1606679312.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2
In-Reply-To: <cover.1606251357.git.martin.agren@gmail.com>
References: <cover.1606251357.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v3 of my series [1] [2] to simplify the setup and use of the
`struct grep_opt grep_defaults`. The only difference compared to v2 is
an added comment in the third patch.

[1] https://lore.kernel.org/git/cover.1605972564.git.martin.agren@gmail.com/
[2] https://lore.kernel.org/git/cover.1606251357.git.martin.agren@gmail.com/

Martin Ågren (4):
  grep: don't set up a "default" repo for grep
  grep: use designated initializers for `grep_defaults`
  grep: copy struct in one fell swoop
  MyFirstObjectWalk: drop `init_walken_defaults()`

 Documentation/MyFirstObjectWalk.txt | 34 +---------
 grep.h                              |  1 -
 builtin/grep.c                      |  1 -
 builtin/log.c                       |  1 -
 grep.c                              | 98 +++++++++++------------------
 revision.c                          |  1 -
 6 files changed, 36 insertions(+), 100 deletions(-)

-- 
2.29.2.454.gaff20da3a2

