Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D46DE1F424
	for <e@80x24.org>; Wed,  9 May 2018 17:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965673AbeEIREn (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 13:04:43 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43565 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965651AbeEIREX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 13:04:23 -0400
Received: by mail-lf0-f65.google.com with SMTP id g12-v6so51988887lfb.10
        for <git@vger.kernel.org>; Wed, 09 May 2018 10:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ARDCP5UfzsMcPQClOCwY1n8WsMST09e2O4pB/sn/ds4=;
        b=gzzOubU4rfh0q4p/0rIxbHlix6RrZwypcHqZynM/IJ+a4E++ApTU/KfX4coQFG51jH
         EmYPACj9iCamsN5x4TwxEeI+0p+oacoBy2aHGi9r2E2b8fb1FfeGItxmBkgsgJ205Zjq
         tYNxi3iUTL+DYd7GDowqb+iZ8jxMjtygU33T6Zw5JaaeFhdVlcjFJobstvJtfe2iXr1k
         8MJ6YV5hHXRMIsUJnTdCZJ00HmZ6eumHLemBi+xedTOJGkYeORtTneS1IqdGVc3mg5Tr
         c0vdmaF/HBBPFnOh2FtlCwO47SNcp3oxN0VRZvwEutNhCrCGasLBbgekIr4GVEMrkqAu
         VLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ARDCP5UfzsMcPQClOCwY1n8WsMST09e2O4pB/sn/ds4=;
        b=BlXaTSM8preCj2E3yNsqT9IXTPRDYJ4FKY7PQU86AAy9GXADfYPPp3QUtpBjF0Hw9z
         mxUkQ4ffmKOlNLklQX143JuvXteoQK6/hE0peX1aAt9SBxZvWXKH045ZJicxdozJrGWW
         MrpmDGDaZodDE8n/Lb+aomnXtt85YpX6DQNFvZ/ODPxOkC4BT1jnF8MIRWbkS5JvWNdy
         76p9S7WErq2LmlNb6Nzo2FyqMR+pvUwxjo20m9GEOwi0vQeeuw2J2hdXiz9H2ywUI3T3
         M7o+v5nMUmkuc12Bm97+MzyvaAJQoeCISsoUTcgMYSNkAJBgnL6hwJLCjfYl6KP0fQxe
         J2dw==
X-Gm-Message-State: ALQs6tBQO9F8lFsGCpvFDQnAVx/NDXfyB/vak+pY9V4xMSt5NxBI7Wbc
        QPHaikEbdb5Pez9jG6U2hipFfA==
X-Google-Smtp-Source: AB8JxZreDk/uPCuAJHP/HQX7Cn4mdWkZgUceFxWRujFdqI6A8oFkEJRuDMHQd6FVyz+scOkY6vBllQ==
X-Received: by 2002:a2e:9d95:: with SMTP id c21-v6mr32935556ljj.89.1525885461520;
        Wed, 09 May 2018 10:04:21 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r189-v6sm924418lfe.81.2018.05.09.10.04.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 May 2018 10:04:20 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] repository: fix free problem with repo_clear(the_repository)
Date:   Wed,  9 May 2018 19:04:09 +0200
Message-Id: <20180509170409.13666-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

the_repository is special. One of the special things about it is that
it does not allocate a new index_state object like submodules but
points to the global the_index variable instead. As a global variable,
the_index cannot be free()'d.

Add an exception for this in repo_clear(). In the future perhaps we
would be able to allocate the_repository's index on heap too. Then we
can remove revert this.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 I was trying to test the new parsed_object_pool_clear() and found this.

 repository.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/repository.c b/repository.c
index a4848c1bd0..f44733524a 100644
--- a/repository.c
+++ b/repository.c
@@ -238,7 +238,9 @@ void repo_clear(struct repository *repo)
 
 	if (repo->index) {
 		discard_index(repo->index);
-		FREE_AND_NULL(repo->index);
+		if (repo->index != &the_index)
+			free(repo->index);
+		repo->index = NULL;
 	}
 }
 
-- 
2.17.0.705.g3525833791

