Return-Path: <SRS0=1y/A=EO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CE1C56202
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7020F206E3
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+n0JqFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgKHVlx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 16:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbgKHVlp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 16:41:45 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05ECC0613CF
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 13:41:44 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id i6so9588224lfd.1
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 13:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F7skkKHM5R05UGdkMu1617woWQOZ5h6BpD7foIYbeG8=;
        b=a+n0JqFDkA8ivX4qrmvKKujhbSRA3jmn0stWt4t4rPm0i3TclwtJJQucXXZqQkXeOK
         UZeEzDt+oQyGacwGnARv0LXAR2MDYlyL5rgcY5hKJEcrH089lUFrM6QTYQ0nZ9Wkw7+O
         j0KbSkmqhQpO7TaopNMUYrc3mFo8vWmKE4AudXNxpZuYOSx7f+TKuJfErHTH68ZTMPBh
         JSfZKaRQogjvQMRMzQ7qEYOvYIJp2BjH3dCS9Fzw8Nr/IoXFR9StkDf6hpG4uCyfmWfz
         uCyg0F0uTwaovyMWnBs0r4AsowNTdDwTtWmrnWfXO/PJuyCqZqZ49oChSLbswKXCrtIN
         VDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F7skkKHM5R05UGdkMu1617woWQOZ5h6BpD7foIYbeG8=;
        b=YkxEPheEE/hZMZ5WWL591vtv173Ji2Z2mu37k5485JgiErnYbZP8C9uXcE9qs74Cd8
         ZvEbRqiEqp+Nmesw+hiAr8MSUg7oDSzAzYivG4qvlSwWtK31tX5RN+1uhfG4lO9BB4VU
         PJhvl69agHKwO7+vn607Dcb8tQSxAVaJovmm0CamO2tmIwlhD197c8WOTbpIrGN7FuiP
         kABbMP2U8GkKD8v96ASrUFj/d+UXxUtf2CzXL30pUeYvm6brXJDIOdjz5UK6sSmW6mdP
         5Ja5tp3juL8LpR/fJiXvEkHk6vNF26ChhKVBMddOxl0Nt5NHczYARxsD/yTGBCBlaKIL
         4Hmw==
X-Gm-Message-State: AOAM531gCtQZxp7/0pS2IunzugewrtSMRCK2mbXhmqyxMRds3hvGblCw
        M33y6PoJ2v+KoOKLhBjGVTA1z7+pF58=
X-Google-Smtp-Source: ABdhPJxR0GBnLQp3qpaC/5qwHrG+uB0+fNj2QcN7x/OH0ehfN56Etb0tservhW6yxcnPCdJ5sdC10Q==
X-Received: by 2002:a19:dce:: with SMTP id 197mr4698042lfn.503.1604871703533;
        Sun, 08 Nov 2020 13:41:43 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k21sm1937392ljb.43.2020.11.08.13.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 13:41:42 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 25/27] doc/diff-generate-patch: mention new --diff-merges option
Date:   Mon,  9 Nov 2020 00:38:36 +0300
Message-Id: <20201108213838.4880-26-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108213838.4880-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201108213838.4880-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mention --diff-merges instead of -m in a note to merge formats to aid
discoverability, as -m is now described among --diff-merges options
anyway.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/diff-generate-patch.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index b10ff4caa6c5..2db8eacc3ec7 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -81,9 +81,9 @@ Combined diff format
 Any diff-generating command can take the `-c` or `--cc` option to
 produce a 'combined diff' when showing a merge. This is the default
 format when showing merges with linkgit:git-diff[1] or
-linkgit:git-show[1]. Note also that you can give the `-m` option to any
-of these commands to force generation of diffs with individual parents
-of a merge.
+linkgit:git-show[1]. Note also that you can give suitable
+`--diff-merges` option to any of these commands to force generation of
+diffs in specific format.
 
 A "combined diff" format looks like this:
 
-- 
2.25.1

