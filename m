Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 179A11F42D
	for <e@80x24.org>; Wed, 30 May 2018 17:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753851AbeE3RDI (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 13:03:08 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39824 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753510AbeE3RDH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 13:03:07 -0400
Received: by mail-pg0-f68.google.com with SMTP id w12-v6so7205793pgc.6
        for <git@vger.kernel.org>; Wed, 30 May 2018 10:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JtP5GIjYawF9oI/1tnNn+ner2/IY1PKHrrcO1kieuek=;
        b=sihD5ciYryuxsSTuLD4UsUfQBd1ouVPNFnLCYFsvYPCkus2HvnIotiTkRWvQ/WgUYO
         ke/3Js+Qx1Nw+LSG7nBJ3q6Mvcrs+ndkYJnyQcdWm0Tud+97iQKkTBFDjMJ1Xh8/IDxm
         Y0IJwCqDQuC1G+a4SiOC7D+//1aA0JoIlRurTtIyILRnkVUEHfMV7jO04tbxkn4U6HQ+
         IREH7s7qWhaU7XICHH+V17S7cSAQjYDrvdn5T3xS7ngdygNLqIZ/dsnQSsB6A231aXKv
         pAjcDXsWDyF+xO/fwnteHK/ImJ7QAkK6Z8ZTC2jGqGvBQI5qhS+c1B4CUyc9rBV9RqOy
         M5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JtP5GIjYawF9oI/1tnNn+ner2/IY1PKHrrcO1kieuek=;
        b=tAuUATLTRy61mJ7cKR9izWeG9uWfDUgiy9cfTMgIR3WBLSrXcGOD02jnJ158nIb0/C
         ma0n8JGgaM8gWz1I4XkGh5okqLq5Idf4LVftlF1ss6no7mTqwYGM8xEJeUaBfEaMulgS
         stddNmuxFYkLvzG113///lyQVnQafOBAxZv0zw8DRA26DheYshuyPHVooke4wnWq7nNX
         VeKKYUsHDcA6A37H1AyqozHWR2v90S/fgMkcm//SKYRd4HNmK5DSyFedyV6PSBcABYOR
         FR3+/CoZCbhrQ+bDidRz+BPWBvBWxMZXUzv58HQugwD3xyP6zDRjzxdKDs2vi5l6tGjD
         7a8w==
X-Gm-Message-State: ALKqPwftwXxfVH3ueQ2+yBSytOToiBFLMZFmOBPRreLbxNjJc5BHbIxe
        K3fr4AhK9B1V6jTdr707/enHOjrHnV8=
X-Google-Smtp-Source: ADUXVKJyAih7gMSHq2sfR+H3PUtX/oqOPA1n46CyUfujnNXQz25Z3+J9nOOZJlFMRNtp2RfNenJZ4w==
X-Received: by 2002:a65:644a:: with SMTP id s10-v6mr2843969pgv.360.1527699786047;
        Wed, 30 May 2018 10:03:06 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id v5-v6sm55874742pff.130.2018.05.30.10.03.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 May 2018 10:03:05 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/3] refs/packed-backend.c: close fd of empty file
Date:   Wed, 30 May 2018 10:03:00 -0700
Message-Id: <20180530170302.191176-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---

This was an oversight in 01caf20d57a (load_contents(): don't try to mmap an
empty file, 2018-01-24).

This and the following 2 patches apply on master.

 refs/packed-backend.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index cec3fb9e00f..d447a731da0 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -499,6 +499,7 @@ static int load_contents(struct snapshot *snapshot)
 	size = xsize_t(st.st_size);
 
 	if (!size) {
+		close(fd);
 		return 0;
 	} else if (mmap_strategy == MMAP_NONE || size <= SMALL_FILE_SIZE) {
 		snapshot->buf = xmalloc(size);
-- 
2.17.1.1185.g55be947832-goog

