Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 019AF1F424
	for <e@80x24.org>; Mon,  9 Apr 2018 08:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751635AbeDIIvN (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 04:51:13 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36716 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbeDIIvM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 04:51:12 -0400
Received: by mail-io0-f193.google.com with SMTP id o4so8718416iod.3
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 01:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=8ahcQP7BrTfOvjhlUpSGm7En4CuDKGsv8L+7KEYMWbk=;
        b=gx/go2vYFTy4w1z5ZbdIkfF3gf8XXD5qfE3dQfxS36ofyEzRn5IMEiHQi+Td6Q253n
         8IleSBAlqxHk7G/pjrOsdMtWoPXlfNOzsHVRFIAmxJrl2KKNvxbPSVy+8L6sZVE0UI0j
         V4TDvgLcOcdBgSN1eXS8MeCalSgBnpsyp8o7BwZFZqvLgCMgyPJLp++y/x71FvmsZ6OO
         MfCTUk06dWnQQYLgfPDARfvXjJmE9mUSY0KGpYtS2yq7Ztgo5Q42PWBE/ckzPilIjUVX
         nnRxN7xYMdrqLmKmRLi31Q4hGFrBZqw5nkgV12QnzysVwRGgKAFxL6UwWrklAFDVoA15
         9oRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=8ahcQP7BrTfOvjhlUpSGm7En4CuDKGsv8L+7KEYMWbk=;
        b=LU40oIWhxZrF6hZ4Wj2iS3TRxu+udlWrW+N/rihHc6qIyJz+KiTgdFQnIcJXyGtEk+
         /ku/WzDjD3BA1g/kJ+LADRScLLdSd6CkuMwszjPZYzaSNUDMI6KkL6c9QO16sne+/Fqb
         oTwxgvs1yGu/DVtFU1b5IAawohBTPGL1YN3GbimnqwMe922bniMtek46ssYs2Kyvxkki
         QUsP6laz/vDKZKDo6qwqt9HuScdNJBvY+/JaHzJjboOatZksL9j3p1JnC9FyNWmHvuJ9
         Is1fmOIP8VpReokf5wMO3mw/GKxi8dC7isAt+MNkl3LILPPkA6uEk3JIFPCG0MN24D1W
         tsdA==
X-Gm-Message-State: AElRT7GZgUavLywBqnzHhR86Llb14GxlyEhc3u8GA4cT2Jfr37p9fMo4
        6ZiTMypPbb/15ueDOkDxgOvXAQ==
X-Google-Smtp-Source: AIpwx48laNhFNdI0tXPpcDEOGqHGw1iP56w0ccKyn9i8PYn1mchPUC+iMZF7Il7M9li+6wlzczGMAQ==
X-Received: by 10.107.128.78 with SMTP id b75mr33615757iod.233.1523263871399;
        Mon, 09 Apr 2018 01:51:11 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id 191sm8553174iou.55.2018.04.09.01.51.10
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 09 Apr 2018 01:51:10 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Primrose <jprimros@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] configure.ac: fix botched FREAD_READS_DIRECTORIES check
Date:   Mon,  9 Apr 2018 04:50:42 -0400
Message-Id: <20180409085042.20215-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

3adf9fdecf (configure.ac: loosen FREAD_READS_DIRECTORIES test program,
2017-06-14) broke the test program for the FREAD_READS_DIRECTORIES check
by making it syntactically invalid (a dangling ")") and by botching the
type returned from 'main' (a FILE* rather than int). As a consequence,
the test program won't even compile, thus the check fails
unconditionally. Fix these problems.

Reported-by: Jonathan Primrose <jprimros@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Problem report and discussion:
https://public-inbox.org/git/82c91eac-9dc4-834b-4648-3c4ba45af80d@gmail.com/

 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 7f8415140f..a30d947e2a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -923,7 +923,7 @@ AC_RUN_IFELSE(
 	[AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT],
 		[[
 		FILE *f = fopen(".", "r");
-		return f)]])],
+		return f != NULL;]])],
 	[ac_cv_fread_reads_directories=no],
 	[ac_cv_fread_reads_directories=yes])
 ])
-- 
2.17.0.484.g0c8726318c
