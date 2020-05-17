Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EF2C433DF
	for <git@archiver.kernel.org>; Sun, 17 May 2020 18:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D91F20809
	for <git@archiver.kernel.org>; Sun, 17 May 2020 18:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkNEx+4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgEQSwk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 14:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQSwj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 14:52:39 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4A7C061A0C
        for <git@vger.kernel.org>; Sun, 17 May 2020 11:52:37 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b6so7529826ljj.1
        for <git@vger.kernel.org>; Sun, 17 May 2020 11:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Bd5HGQCrM1JbTkDwfeEOZ6TB0lawENQ0GxN5Vy/VDs4=;
        b=AkNEx+4EYTETVzbe/fjAraSOzZCRHhyvLLaxqyM2t7qS7GgmP67AIepw/owjY8KJKa
         8XEhBK5axjCEZDCZJtMCPrwP1/skhttLZfO/3AFCHglPs+gboqQZ/Yed9/CXnhDCXWXD
         NiNJkYIdGD5F/PNCKp2OfTgyZom2HVgt64SOjPFbDgOXWPfICBuLZw2SEOrISkJGSQe1
         tYOMgm5egxfvQF7IRXGSij40Je2ccKMMKiwWZKC+1S5NbCs05gs1z2mlcgb0yTxsjF16
         lgPbYcwP1AoCmTX4Rd5uYRCitzPQFygjAKYRclKRAMHcKJOTjrecvbU/hLn8R4mFJ8uU
         ovSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bd5HGQCrM1JbTkDwfeEOZ6TB0lawENQ0GxN5Vy/VDs4=;
        b=ADJGyzQVy+1DBdekGq2dbneZCNE3SvDI6QEpnIdP0znBQOxtFtyVBIgH82XtijQKcg
         y0qGpGyhR9DxpYK6n2WktmQV/NV6R9yCh9F8rr941eJse+rU2G7ITDuovvOLy/S3ZbAH
         Qc9Xf6+fGNmWahPtQ9wC8VWiJ2D1Hehk6WnhV9bpyECOMntOZFgJqg8N9pqv6SQm8U39
         r0EkYbH442RcetDG/RQZqRdAvItGGWvlncauGPunW8XzvkAGY7Bu6MkvhEYolXIQ1MGX
         wG6asBEcTWFezQIC0HgexNiLSXtlPGDEirgP/+w/E6NEG7AaNeg/QrcBlQeOlGUn1ojQ
         WyZw==
X-Gm-Message-State: AOAM533IPjCWbTokO6J3NsTM3xlCObnQk//sYTcr6i/4s1AwDs/q8/7k
        cobmebljGCbZIxHcC3qkV9KFKep5
X-Google-Smtp-Source: ABdhPJw7AAzTP/bHgsp7vNGTr+IBrEUCSrXQmJ2QMhTw81hYPBBonRChcxUzW1sNsADZHda/Av5qmg==
X-Received: by 2002:a2e:3a10:: with SMTP id h16mr7635061lja.49.1589741556186;
        Sun, 17 May 2020 11:52:36 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id a12sm4513938ljj.64.2020.05.17.11.52.35
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 11:52:35 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 3/7] git-commit-graph.txt: fix grammo
Date:   Sun, 17 May 2020 20:52:18 +0200
Message-Id: <af1e7c7d7d123d1187a7ef62cbf11fc41ce2fdc7.1589739920.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <cover.1589739920.git.martin.agren@gmail.com>
References: <cover.1589739920.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's easy to mix up the possessive "its" and "it's" ("it is"). Correct
an instance of this.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-commit-graph.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 53a650225a..258bf66e46 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -58,7 +58,7 @@ With the `--append` option, include all commits that are present in the
 existing commit-graph file.
 +
 With the `--changed-paths` option, compute and write information about the
-paths changed between a commit and it's first parent. This operation can
+paths changed between a commit and its first parent. This operation can
 take a while on large repositories. It provides significant performance gains
 for getting history of a directory or a file with `git log -- <path>`.
 +
-- 
2.27.0.rc0

