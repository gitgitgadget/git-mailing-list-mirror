Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29C1C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 18:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 917EF61443
	for <git@archiver.kernel.org>; Thu, 13 May 2021 18:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhEMSTR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 14:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhEMSTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 14:19:16 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E85C061756
        for <git@vger.kernel.org>; Thu, 13 May 2021 11:18:05 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a2so18763436lfc.9
        for <git@vger.kernel.org>; Thu, 13 May 2021 11:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jSMXV7gSzftX0Dt+we4xPj5RMpmc3MVy4YqVZiA/lsI=;
        b=vJKuk63cSNY6fTulE/XI7yp4MJTcN9H1HoSOP61PNQH0VCBspBEQTa2TWbgjvOJf3b
         x6xjva0qZKmw61+fjK/GgiBwW9w2FTER37fNEJbuNHSGRV8HwIOeNsPT6gQaUwKlLGiz
         QyIKiwj5TFndoZWJVgV31Vz5fZpkkKkwLNvlO/f1yLU1ReFXZ3jQyXbDP0/zrKT56EMx
         zdUjEKAfYrZRfKZIq8t8NsMkU4FEkThFV0Ag7rmG6x2KVeT6jejsnIhKMR+MHy5FaSmT
         dNHVkCrxwmR0zysE4Hz1fziggaK37sS2JwtPedBu4A7DXRcaVC0BnraR+SuIn0FUqNTa
         sbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jSMXV7gSzftX0Dt+we4xPj5RMpmc3MVy4YqVZiA/lsI=;
        b=eXn8DiyQ2RpSyBkaEMY4/VQ4Gzjw2m9QvGGOZbYf0m4jpjitikwqwgWoDMzwVzENXG
         ZNpMiU6VVK+GpwOx3h7MnZZfvNhGj+uIXqn+OEHNsQpytrS4GwTCllD1FZwX4ocxTmNf
         2U70gIaLJ55+P9H6nKrGd30TmEMst/7EE+M89ZYFAaXOhKGzp1rtE8cdwgtjmeKMghVx
         nlSUu7MczR22KNtOdS1gWDwuyRgle9vpALFv0FZaTgemd0lWJCOwo38Br4PG4j7jgep5
         3r/tortChwuN1vte5nKUzVerKHVDPtGXgFwDeQlpQsLMWxn7P/L3XIqu7Vgbn9MXtrhL
         8kFw==
X-Gm-Message-State: AOAM531pExRyjkl3L8sZe16xyIn+9ADwY5gxyw5jpfGqqLYeg0+ujzfq
        Axcdfk5PwPrj6aCs/bub3qmjPa2QqHA=
X-Google-Smtp-Source: ABdhPJzLDPJjS4ybRo1c/qNob8JdXrntisReY3bs4x7W/djukjbjoFGKo7XME6zDs9w2kdDrrOmCuQ==
X-Received: by 2002:ac2:5b1a:: with SMTP id v26mr30022297lfn.534.1620929883900;
        Thu, 13 May 2021 11:18:03 -0700 (PDT)
Received: from localhost.localdomain (81-231-136-235-no600.tbcn.telia.com. [81.231.136.235])
        by smtp.gmail.com with ESMTPSA id v8sm554153ljn.17.2021.05.13.11.18.03
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 11:18:03 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/6] git-http-push.txt,git-send-pack.txt: avoid single quote
Date:   Thu, 13 May 2021 20:17:40 +0200
Message-Id: <04e2d9de24db1e69803c495710f1f0908a12c91a.1620928059.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd
In-Reply-To: <cover.1620928059.git.martin.agren@gmail.com>
References: <cover.1620928059.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

AsciiDoc matches up the very first backtick with the single quote
towards the end, and renders that first backtick literally:

    `--force, ... other peoples' commits

Rewrite the "other peoples' commits" construction to drop the single
quote mark.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-http-push.txt | 2 +-
 Documentation/git-send-pack.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index ea03a4eeb0..cbb7d2de6d 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -85,7 +85,7 @@ Without `--force`, the <src> ref is stored at the remote only if
 <dst> does not exist, or <dst> is a proper subset (i.e. an
 ancestor) of <src>.  This check, known as "fast-forward check",
 is performed in order to avoid accidentally overwriting the
-remote ref and lose other peoples' commits from there.
+remote ref and losing commits of other people from there.
 
 With `--force`, the fast-forward check is disabled for all refs.
 
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 44fd146b91..d8c8acb96e 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -144,7 +144,7 @@ Without `--force`, the <src> ref is stored at the remote only if
 <dst> does not exist, or <dst> is a proper subset (i.e. an
 ancestor) of <src>.  This check, known as "fast-forward check",
 is performed in order to avoid accidentally overwriting the
-remote ref and lose other peoples' commits from there.
+remote ref and losing commits of other people from there.
 
 With `--force`, the fast-forward check is disabled for all refs.
 
-- 
2.31.1.751.gd2f1c929bd

