Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064C9C2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 20:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB42824679
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 20:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRURpBPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgA0U1A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 15:27:00 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:42751 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgA0U07 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 15:26:59 -0500
Received: by mail-qt1-f173.google.com with SMTP id j5so8454908qtq.9
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 12:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w8J1rrekRQBKLxC/AIo2zRv7EF2nI8ZlyVq9ML/6QvE=;
        b=SRURpBPyAP1JSjjihzXrTSTDKy0p0iKuwvksdgMvwULWwugB3Iy5TPG/RwLkCw7rCj
         jx8InfhaOn0GdMJVnKb9KEWorhQ54LJn2XrxEuYP7SlUlimROZrchE7eEEr1BbIA7gKi
         BDEaJuvRoH+yD8mg2qxxoFy+qOJnJGMGznXRBMHyP7kvLbL3FgCV3Ixdygx0/+eW1sSD
         Dps97NIhN5DkqwlT0T9wTSpSxlySlhzmreDUQGLKcTKRIan4UNuB0w8l7QuxhP/Nis2M
         2Cf0rvJjXEBDI92UnRycxJSZnapUuLNdzEwuNhdWBvvpH5IOhUnehKA3F6PcEv48XQTm
         7UYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w8J1rrekRQBKLxC/AIo2zRv7EF2nI8ZlyVq9ML/6QvE=;
        b=h/7p5LBLvLvJeMmAYIeUq81cIXmH3RlpE3J2mdfqyvNELUn8ZXvpBm8QfERFSTqPpf
         GBgqhgqGjXZjCvAneRU63Ugy9qq2YYgmZJHaQNtNher6H7xMjYvvU0J/5cSe1MYATg7P
         hL1G0rrd/fsaVCno9ZcrsL1/0r7/qkaAYx/N9dIREGM1h7aKEd2eeOF6B+/0lybr49FT
         0nlHdl6oMeqeX9A9SYO+xnq+UJKp7Bo/z/Ghgx6IzRBSY9TblmMmvEa7tKoNdoH8lBxw
         bTyqiWjs6d7OTM6WHBvw3mvKcUnJ75UMvp4ftNL1pf4+6UF91sungqh9sSOj2aSe0Sk6
         JCcw==
X-Gm-Message-State: APjAAAXsXm1P7tHWinD05Lu8LI+ibtXruvjSOUX2GDWbwPUYvgp9gXzC
        1JfxHe00CYWZKy6Ag7j9iITd6Kgb
X-Google-Smtp-Source: APXvYqy994VR/2PJ4XGqfIBGTDRPFgJ92uKxKh4Thi5QsPZZhO0VEC9qndJlLV3e9rrLvVYQJG0WRA==
X-Received: by 2002:ac8:2e53:: with SMTP id s19mr410000qta.354.1580156818739;
        Mon, 27 Jan 2020 12:26:58 -0800 (PST)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id v10sm4718650qtq.58.2020.01.27.12.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 12:26:57 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] .mailmap: fix erroneous authorship for Derrick Stolee
Date:   Mon, 27 Jan 2020 15:26:38 -0500
Message-Id: <6bcdfa906b6f1ea2296ade8c0b7eaf0c4540d681.1580156690.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.rc1.180.g49a268d3eb
In-Reply-To: <xmqqr1zkbvnp.fsf@gitster-ct.c.googlers.com>
References: <xmqqr1zkbvnp.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 4c6c7971e0 (unpack-trees: correctly compute result count,
2020-01-10), the commit author is listed as "Derrick Stolee via
GitGitGadget <gitgitgadget@gmail.com>", however this authorship is
erroneous. Fix the authorship by mapping the erroneous authorship to
Derrick Stolee's canonical authorship information.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
Whoops, I didn't realise that the branch had already been merged into
'next'. Anyway, we can apply this mailmap patch on the tip of
'ds/sparse-cone' to fix that issue.

 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 14fa041043..cf3f68ecaf 100644
--- a/.mailmap
+++ b/.mailmap
@@ -59,6 +59,7 @@ David S. Miller <davem@davemloft.net>
 David Turner <novalis@novalis.org> <dturner@twopensource.com>
 David Turner <novalis@novalis.org> <dturner@twosigma.com>
 Derrick Stolee <dstolee@microsoft.com> <stolee@gmail.com>
+Derrick Stolee <dstolee@microsoft.com> Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
 Deskin Miller <deskinm@umich.edu>
 Dirk Süsserott <newsletter@dirk.my1.cc>
 Eric Blake <eblake@redhat.com> <ebb9@byu.net>
-- 
2.25.0.rc1.180.g49a268d3eb

