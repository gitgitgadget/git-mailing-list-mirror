Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E168CC33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF0820748
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNWK77Ww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388053AbgAPUgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:36:41 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36347 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbgAPUgl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 15:36:41 -0500
Received: by mail-pg1-f195.google.com with SMTP id k3so10493898pgc.3
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 12:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x/U6JJEl1swVZS467ydw4m6y6JYmCn+77u9HhScUGQc=;
        b=tNWK77WwZNM92RnksRDGuNUq7aLBMl24M6fIHwcobRyOfmnOnBpSWHzZRD0QdQ4yll
         XvixkVv2LNm9blRm+IoxzxY9nOvdPnwTpUxFlOX38LoX2IBFg2JuHNTjSn4ZTZ/2j/0w
         Mr/+i8X1VNJyjjvXtLynLWlYirMcLE+evnkOZups93vVnsEZXiP7quS5eRHVCVJt9dog
         OTL8oJfUemCAik83YjZdSkGZqjthYaTluRI6qn1ZlaZphzgelFOIDxElHFaTkyM7Aok7
         B4pPmJe8MG77Q42SoK94wGhw85UwfAStlb6AtTd6l9oulGVH9/HpabRmj28B7KpKT9sE
         Ae1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/U6JJEl1swVZS467ydw4m6y6JYmCn+77u9HhScUGQc=;
        b=dKQn8wBVIifU+rVlvbdGQtogYkYELc+nNZLLz/C577S9cvNgbSkBG78bDhJVUikgBl
         fNhnGsGwRkHMIDuCh3BV/QoHGO3GVG823HG5VUAgSOR+I6s92VBwCvXUiccAyP9VgPvr
         Dcsm/8MmhRQTIoh3h1Q0OY4e9KhYQaSzuQBLjGBtVzIbX7OB2MuU81xi/j0c15dQSwLE
         xXcHcNAqhYcELtpxJHYkgX5VbSeYUqbPBANtkHctb6Ut5nMUQE5ebDvY2ytEyOlEmylB
         ZokBLbaqT3sc1M42qDgaXX33/iskHGFilLXmcXddMwZJjXUKuLFppIUN3JlF+14LfJib
         oZ4Q==
X-Gm-Message-State: APjAAAW4N+lr4nei0TNU7NSivIVuZCEoFEqdRXu8ilCrx4PkvYSMiwlX
        nHFwNTzqNorTxTTJHCmcnFjskx3mH81aUg==
X-Google-Smtp-Source: APXvYqwjGJF2Wp9xpOP0kNYZv0GYr0mnZ7w7iYeIKs31jSyKLYS0Yt1lfY+lZ/mRi3QPvYuXExLr0Q==
X-Received: by 2002:a63:e84d:: with SMTP id a13mr43321431pgk.274.1579207000247;
        Thu, 16 Jan 2020 12:36:40 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.173])
        by smtp.gmail.com with ESMTPSA id d4sm3481167pjg.19.2020.01.16.12.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 12:36:39 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH 2/3] t6025: replace pipe with redirection operator
Date:   Fri, 17 Jan 2020 02:06:21 +0530
Message-Id: <20200116203622.4694-3-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116203622.4694-1-shouryashukla.oo@gmail.com>
References: <20200116203622.4694-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The exit code of pipes(|) are always ignored, which will create
errors in subsequent statements. Let's handle it by redirecting
its output to a file and capturing return values. Replace pipe
with redirect(>) operator.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 t/t6025-merge-symlinks.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t6025-merge-symlinks.sh b/t/t6025-merge-symlinks.sh
index b9219af659..41bae56ea9 100755
--- a/t/t6025-merge-symlinks.sh
+++ b/t/t6025-merge-symlinks.sh
@@ -18,13 +18,13 @@ test_expect_success 'setup' '
 	git branch b-symlink &&
 	git branch b-file &&
 	l=$(printf file | git hash-object -t blob -w --stdin) &&
-	echo "120000 $l	symlink" |
-	git update-index --index-info &&
+	echo "120000 $l	symlink" >foo &&
+	git update-index --index-info <foo &&
 	git commit -m master &&
 	git checkout b-symlink &&
 	l=$(printf file-different | git hash-object -t blob -w --stdin) &&
-	echo "120000 $l	symlink" |
-	git update-index --index-info &&
+	echo "120000 $l	symlink" >foo &&
+	git update-index --index-info <foo &&
 	git commit -m b-symlink &&
 	git checkout b-file &&
 	echo plain-file >symlink &&
-- 
2.20.1

