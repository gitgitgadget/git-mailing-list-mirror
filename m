Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A3EC2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 21:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 462372083E
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 21:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roscspbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgKXVEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 16:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbgKXVEs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 16:04:48 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84280C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 13:04:47 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id f18so5684125ljg.9
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 13:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mwWGXJ/qIC5i/hOOOJ3oEAWIbrAHun3Vgddpk2WYjgM=;
        b=roscspbW4AUvAcG9OsxeNGftn1F2DMrDTAtbcYDrddBz9HkEylMo7PQLjY0Qw53W4M
         e60E8E5W/MhnG3K7VzWsrEgUmd7xJ/bE0D4/wVp9ydDGGpJ8VzwfYp++qBKQBEhDwe3r
         a+96m2kNNj4iSqktMrGVTcUKuA0eLOYBH23LwFDMKu6jyRQcLslTdfiR3+4aRm7VCsgj
         e45dg502yNj/775didIfI3DrBpAEh0Ki6G5PqrjAbEcqaEETu7hxzRZK98SIDLN0dY/N
         Uw+qa+N+2pHG9fLKWGqxZVZOYbBAYMAKabb/efGJrES3HSOfwdGFga8QmtdWmGIBOwQ6
         MCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mwWGXJ/qIC5i/hOOOJ3oEAWIbrAHun3Vgddpk2WYjgM=;
        b=HfiEV6mn9p2Y0N9BiKgf/ew7bNkMXHJTUZ0HAyyNzIwfDGe50h9UNyWaeUYqbjuuKn
         tflXL1dLUh1jDpIL+sLeLhDFE2SBoODaGoCpwnqWAIxXmSetSw5R+iisBpA/cd8xDhfI
         gMfc9CHj1bYIa6oKBrkiqvqGZ/7f76niDt0CIU4gqjHCjqPievWZTnxNKUMSTOpN7zAg
         QEorrTNeUo5P9EXcFGh3BryTuH8/O5dwVW8t/LuwonAtiWsin8+MUJqCDSsXLWEXWwlL
         FNHMDcFM9R/1Jt3Kh5d1O2N68+d5WcYAjnzCGe871/sPcAfNLeaey0KxNj1QUqfUwU0s
         5Orw==
X-Gm-Message-State: AOAM533ND1/oCtuXKarj0jviCboXnebqUNFS1zW7pamYOISJlhPq9zNT
        L44KND4KtQ/buGQp2oNpnVF6CTUt3ie3Pg==
X-Google-Smtp-Source: ABdhPJyJ6k8B1rOQF08qq8dJ4dvhrQXRjPUzWDaCJsyeRUQBJPe23qKi7fgFLg9ka1Gl5iLyN61zSQ==
X-Received: by 2002:a2e:6a0d:: with SMTP id f13mr65761ljc.11.1606251885790;
        Tue, 24 Nov 2020 13:04:45 -0800 (PST)
Received: from localhost.localdomain (h-79-136-116-123.NA.cust.bahnhof.se. [79.136.116.123])
        by smtp.gmail.com with ESMTPSA id z20sm22911ljm.138.2020.11.24.13.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 13:04:45 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 0/4] grep: simplify "grep defaults" handling
Date:   Tue, 24 Nov 2020 22:04:12 +0100
Message-Id: <cover.1606251357.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2
In-Reply-To: <cover.1605972564.git.martin.agren@gmail.com>
References: <cover.1605972564.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v2 of my series [1] to simplify the setup and use of the `struct
grep_opt grep_defaults`. The only difference compared to v1 is in the
third patch which now drops more code in favor of copying the whole
struct in one go.

[1] https://lore.kernel.org/git/cover.1605972564.git.martin.agren@gmail.com/

Martin Ågren (4):
  grep: don't set up a "default" repo for grep
  grep: use designated initializers for `grep_defaults`
  grep: copy struct in one fell swoop
  MyFirstObjectWalk: drop `init_walken_defaults()`

 Documentation/MyFirstObjectWalk.txt | 34 +----------
 grep.h                              |  1 -
 builtin/grep.c                      |  1 -
 builtin/log.c                       |  1 -
 grep.c                              | 90 +++++++++--------------------
 revision.c                          |  1 -
 6 files changed, 28 insertions(+), 100 deletions(-)

-- 
2.29.2.454.gaff20da3a2

