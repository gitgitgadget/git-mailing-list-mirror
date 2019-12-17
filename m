Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D49C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C3A207FF
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ/ylk7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfLQMB4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:01:56 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44985 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfLQMBy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 07:01:54 -0500
Received: by mail-pf1-f193.google.com with SMTP id d199so7414863pfd.11
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 04:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xbfAXn74Dj6IEWvOst/CxgC1juY7ioFICG2DQe/nYfk=;
        b=UQ/ylk7jp44S1WrDMh6NL5hb10MTZUnLMam9ecZ1kJ82McZ+Qzftv0ZtWIYJk9esyA
         joMHA6eleqsR+4GsMxHpcAH3SIizPWeaoWcAnf2VFJ+JYtBzsFp31iezanz3iQmUPgJ+
         9cfcDUZNeJ5vxqp1pan/fXsE3hN7g4w2jC2xnKKz4H5WvBCIt0Bj/GVLt7wbJH3oS3Zw
         q4XzmHKvZd4w93Ptm9VTxuHebIyA4BN9fCdPGEkp7ko49y1x6DPxIriPbvmRYjGC4E3W
         sQ6luMv8CfDASb6RoeB0zaYWdIglaODuk6TTx4L5cxrpqVTnEFEHgvjeKSZAC6goqf/C
         nWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xbfAXn74Dj6IEWvOst/CxgC1juY7ioFICG2DQe/nYfk=;
        b=ksKzLkDjxbSzf8NFJbVk7ApqAH2Nt8Oj2Y7GaErhgbDpYALhPMbKq6azKPaTCufWUT
         AsmMp8nwhKywl4O79ud9S8wPe1VHSGZ/NzyA1M0afO57TkJdeEksKoCrMVBh8oQbVL9i
         p/sGInksYXAo1zQpK9Di01zASpOX2KykTTPAwtdft8C1xVr870G1WL4YqL10LhTmqejg
         F0zyN8H0dXO8nW+AhHigyu+CPDD/ncm7FPnpxITLUmtFet0eImzNnkjKzR8ac60DgcbF
         H4PBtDXdSoQ+Ym2AQHDDKULP+8WaAf/C8/agMbkTE3I/9QfiOPkcuU4YMI20F9PgQl1/
         +b/g==
X-Gm-Message-State: APjAAAWX1SVtf8PeIK5cMKs5JFWEY1IrR/6975CBguR6J2wZzFxDXSta
        KW5OIz5N1GvwFmdy75TPbkC3LjTo
X-Google-Smtp-Source: APXvYqx0ZcaM4jJgA1BZEnBZsGOLJhapIsawsUu2hkqAHGte9DYIVEjcvxQhweEJlSYsMas8fC9SBA==
X-Received: by 2002:a63:d406:: with SMTP id a6mr24989599pgh.264.1576584113161;
        Tue, 17 Dec 2019 04:01:53 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id a15sm27531723pfh.169.2019.12.17.04.01.52
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 04:01:52 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 14/15] t1501: remove use of `test_might_fail cp`
Date:   Tue, 17 Dec 2019 04:01:39 -0800
Message-Id: <3d36511d5d95d2a2713b3cc8e2138b689d381c79.1576583819.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.0.627.geba02921db
In-Reply-To: <cover.1576583819.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail() family of functions (including test_might_fail())
should only be used on git commands. Replace test_might_fail() with
test_non_git_might_fail().

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t1501-work-tree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1501-work-tree.sh b/t/t1501-work-tree.sh
index 3498d3d55e..067301a5ab 100755
--- a/t/t1501-work-tree.sh
+++ b/t/t1501-work-tree.sh
@@ -350,7 +350,7 @@ test_expect_success 'Multi-worktree setup' '
 	mkdir work &&
 	mkdir -p repo.git/repos/foo &&
 	cp repo.git/HEAD repo.git/index repo.git/repos/foo &&
-	test_might_fail cp repo.git/sharedindex.* repo.git/repos/foo &&
+	test_non_git_might_fail cp repo.git/sharedindex.* repo.git/repos/foo &&
 	sane_unset GIT_DIR GIT_CONFIG GIT_WORK_TREE
 '
 
-- 
2.24.0.627.geba02921db

