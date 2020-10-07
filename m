Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5F4C4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 05:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC16C208C7
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 05:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZqMr5D9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgJGFJ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 01:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJGFJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 01:09:26 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924BCC0613D2
        for <git@vger.kernel.org>; Tue,  6 Oct 2020 22:09:26 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id y14so613375pgf.12
        for <git@vger.kernel.org>; Tue, 06 Oct 2020 22:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rSDQFwwU9U0XPnizLMK7RwRZdstZGhgKUdKQUokSiLU=;
        b=GZqMr5D9b7hiEjtIqnm2nZtVKNBLfBwOKRpBGnmYyEHMaYNa6gluaQ1AU9KnIJ3M+N
         9LNnWQ4zUmlS+293D56VqsaOTOHJkN5/jHn5cJ4oZD0sZbeo8PKWEi6hv+OUQ3FqLvw0
         Sfpdpzfxgr8MADa237bpUOQ6uRAl1upyoNGMmO6XMltJrENICvObuaDoOncyuXoB5X4g
         MtH1ls8+GOxgU786A+Hug45cVdPa0w+LZUAJZ5Jv1RAt52ph9PbH2A15EGnxTvmtFnm1
         0GWPDnHbh48RvdGOWn8+HgkQ21dauCljMCbCqSbvCAyUG83Y2duA+AXacee4IcQOgECW
         r8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rSDQFwwU9U0XPnizLMK7RwRZdstZGhgKUdKQUokSiLU=;
        b=BAiR0xfgT3KeXpLOk131ENxk9reaRMqr8l55hTpFolBIa2+5/21XR4+wkxud0yfxqw
         f7W+5xHhmdYq8yWysmdbSsyVPbI3RX5Na1i4TIWe7DtubDXFgvsxQRkMDJWs8fg6KLQu
         MTaO7oSM2biVZvUVunIDOhrCYZUrLkizdNm5FU70xrHEYnqVNTa1L55B/3zgKe7aL8Ot
         LOFWF4NxZAysZj39n11W6BUbCKnw9KaCSACVbIvDxWXDmnmCxMzPVrDT5zix0wYL9OVj
         v8zaYWK50+z/6Ehm2NESwM1RXGBCypq0RC9t7I7j+Pxf20cR9zvgdyZlyCVN0ub++SfU
         J2QQ==
X-Gm-Message-State: AOAM530IpmEHGqk6IH/g1XQsP/Y1CQ4oYnSK92/ctR9WoUa7zYGE8uvM
        E4gB7+k4NBZ0vrDo1LFVAZY7r2tg84g=
X-Google-Smtp-Source: ABdhPJznuD70D/Fx3zZAgnL6lFeQiMvcUI9+rr2hmp20qoZWyv0nJNsI7ljsVAVN33Xvg6km5ZJPuQ==
X-Received: by 2002:a63:f4c:: with SMTP id 12mr1464990pgp.65.1602047365823;
        Tue, 06 Oct 2020 22:09:25 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net (c-67-188-114-10.hsd1.ca.comcast.net. [67.188.114.10])
        by smtp.gmail.com with ESMTPSA id x23sm1053621pfc.47.2020.10.06.22.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 22:09:25 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] Documentation/config/checkout: replace sq with backticks
Date:   Tue,  6 Oct 2020 22:09:08 -0700
Message-Id: <f08d3f796a806b5ec20f12cc85683b2c2e99b1a8.1602047333.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.942.g77c4c6094c
In-Reply-To: <cover.1602047333.git.liu.denton@gmail.com>
References: <cover.1601810233.git.liu.denton@gmail.com> <cover.1602047333.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The modern style for Git documentation is to use backticks to quote
any command-line documenation so that it is typeset in monospace.
Replace all single quotes with backticks to conform to this.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/checkout.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/checkout.txt b/Documentation/config/checkout.txt
index 6b646813ab..e3684a5459 100644
--- a/Documentation/config/checkout.txt
+++ b/Documentation/config/checkout.txt
@@ -1,18 +1,18 @@
 checkout.defaultRemote::
-	When you run 'git checkout <something>'
-	or 'git switch <something>' and only have one
+	When you run `git checkout <something>`
+	or `git switch <something>` and only have one
 	remote, it may implicitly fall back on checking out and
-	tracking e.g. 'origin/<something>'. This stops working as soon
-	as you have more than one remote with a '<something>'
+	tracking e.g. `origin/<something>`. This stops working as soon
+	as you have more than one remote with a `<something>`
 	reference. This setting allows for setting the name of a
 	preferred remote that should always win when it comes to
 	disambiguation. The typical use-case is to set this to
 	`origin`.
 +
 Currently this is used by linkgit:git-switch[1] and
-linkgit:git-checkout[1] when 'git checkout <something>'
-or 'git switch <something>'
-will checkout the '<something>' branch on another remote,
-and by linkgit:git-worktree[1] when 'git worktree add' refers to a
+linkgit:git-checkout[1] when `git checkout <something>`
+or `git switch <something>`
+will checkout the `<something>` branch on another remote,
+and by linkgit:git-worktree[1] when `git worktree add` refers to a
 remote branch. This setting might be used for other checkout-like
 commands or functionality in the future.
-- 
2.28.0.942.g77c4c6094c

