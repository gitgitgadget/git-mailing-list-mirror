Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B476C33CB1
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 08:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A0A2468D
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 08:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vRys9C8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgARIdl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jan 2020 03:33:41 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37831 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgARIdk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 03:33:40 -0500
Received: by mail-pf1-f195.google.com with SMTP id p14so13108838pfn.4
        for <git@vger.kernel.org>; Sat, 18 Jan 2020 00:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x/U6JJEl1swVZS467ydw4m6y6JYmCn+77u9HhScUGQc=;
        b=vRys9C8wsQ/CcSwBCIoE3RTQdLieadD9AuYCrkqIMwZxT8zcED9sHecv/HaVPr1P9n
         tewYwQhl9jdSkYZeoxQuqzRWjQ6biVN4/nuj2Bge4D78dPYVKVStfzNVt4QMXM61lCax
         CEEJJRxHeBx7gCSvEWO4reyfoFRJlXHv+JkrmOItke0C17ry2Q6q2ANLBJvku2iPvXmM
         2/0R9IZE1pN4yZdUGIvTX3qUWlhN3DcRaXmrLqwO8EtXJYJ1fAzfAER44rq2DuGqW0Jq
         e6AAtkbTx0D3gI5N1b4pYHLfhSZoLnRhycJg4PQVnm8/KY3xipOJsU+eGc/28fmhJEV1
         MSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/U6JJEl1swVZS467ydw4m6y6JYmCn+77u9HhScUGQc=;
        b=to8QTgEDqBF93QUfGKLO3frqsu0zBPT0LqKP3xPRwx2kNeBamFqZqhohrljBJtPl5M
         cNM5yz+49uc62HRM4/qZxnqeWYfQyYnavDcpzlDfQnUdYjON6KXnX+KrHWaJwYadz7kV
         xDw8KWxDb0Ndz9jHHhzhJ2tslFScWDqiF8BnVzjyNOpcrpc3Ge90LsChp9xx6IA/mydm
         CCiPtLDdHvA0xOUUds37N7DEY2KAihaeHFCiW+23tJurHaf6mnpqmjKmVynqTp5MKQal
         V3EFvBVGVg6NTPM1fsIi7WD0befTaWgcTor5eQjG757K9BikJfdF73XZA/r6OBtOKZ65
         HO1Q==
X-Gm-Message-State: APjAAAV3pKfUkFLhRxCwtDJjSlyNMSTlS8WdywM3dEc1sPKFBrBocg9M
        IQKMsO47vlaCKbRGQVWfuZc=
X-Google-Smtp-Source: APXvYqzE1zQRUyLNZl4b5dbIbgJpPfq1zmZoXk4RfvhFa48wUZKexC/xRGWPdaSnu1AeMvL1RtsWUA==
X-Received: by 2002:a62:fc93:: with SMTP id e141mr6982609pfh.262.1579336420136;
        Sat, 18 Jan 2020 00:33:40 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.169])
        by smtp.gmail.com with ESMTPSA id c10sm605038pgj.49.2020.01.18.00.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 00:33:39 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        shouryashukla.oo@gmail.com
Subject: [PATCH 2/3] t6025: replace pipe with redirection operator
Date:   Sat, 18 Jan 2020 14:03:22 +0530
Message-Id: <20200118083326.9643-3-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200118083326.9643-1-shouryashukla.oo@gmail.com>
References: <CAPig+cQX=jB1KTKcOMVE9u0jX-ZXt_vQBndkzqqQWORu5iFxeA@mail.gmail.com>
 <20200118083326.9643-1-shouryashukla.oo@gmail.com>
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

