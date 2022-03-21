Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91482C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbiCUXKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbiCUXJA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:09:00 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFC83B5025
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:15 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q8so11294965wrc.0
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9YqNh3kdxe+Wvy/MZM4MclSUNX55FdTMPxhaEFXtHnQ=;
        b=Z3z9AeBpyeyTIVNV31jMnzUCrlOO+90/BNf2z081RAEJvhWQB61fTJew9zjAdoEeOi
         jhNcpaDCQ4vBeqdIJDIL9J98SLmBKAuhmEvYkFCRyZ1q88BC3RDrkFCLb21ZvZpNSD+q
         QHVzcOrxfYTjd7gsKRVFdbFv6dB5rPsQ5xvJNCHigmSXhiVIvbU1Dcce7CqFzKKUDGj2
         XDJsbJ/Zr8BGJZvlSFb4jrQ5d/LtGXznwNu7JWVj5mQzVq7jsRgVWJaIDHZwXZMQ9cFB
         Z4MyPVdnr5P38DhyT0ffVAyW/e4yhobDrLOz/QlZhht9r+jB4owuNMeB5i/8W+2ghRCE
         YCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9YqNh3kdxe+Wvy/MZM4MclSUNX55FdTMPxhaEFXtHnQ=;
        b=zKB9E24gRwHm1zP1rKUhm1YLWo2lwGFesy3qJ3Xz0Q1I2PHyHeUG7dbfio070sh8mz
         b75o+KTNekExXb6xvprC7YHfbCe90ECkNsYA1WDJCDypF4xV1wb5W9j48LlTkx8s3nl1
         sFFy4LM+BwjalN+ivFh4lbNOG3g6sQwAu/vQMgLxIr838Mv0j1P4L421ZXD1Zq7ODU7T
         B9lGHx0HlUz6CkjPTNMpf+a5w/X3812bObORWQJdtVQqbUflk8nQLhKHeA424zhLK8ax
         wRbnczz2UF2ian4FVpcbRevZgQOF3JHy8pIvDFIEBvK+l9tX/4mvzkTmZfLKBM6b6jTV
         w7RQ==
X-Gm-Message-State: AOAM532n6ICpAXiixKMPzdO5pzupEBVM0MAbROJeG6QSjouHUphZWzAg
        ogmAOjoO8b7ZqL3nfTR7J+NcCTbbbCE=
X-Google-Smtp-Source: ABdhPJxT07oob67T+ew21YFwBYySiTpdLv5d8B4nHu2dherluoApx8trPFTK7xYqBKMWs74SpUOOhQ==
X-Received: by 2002:adf:ef48:0:b0:1f0:47ba:d4e6 with SMTP id c8-20020adfef48000000b001f047bad4e6mr20509460wrp.438.1647903349201;
        Mon, 21 Mar 2022 15:55:49 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:55:48 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 09/41] mailsplit.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:54:51 +0000
Message-Id: <20220321225523.724509-10-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321225523.724509-1-gitter.spiros@gmail.com>
References: <20220321225523.724509-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C standard specifies two constants, EXIT_SUCCESS and  EXIT_FAILURE, that may
be  passed  to exit() to indicate successful or unsuccessful termination,
respectively. The value of status in exit(status) may be EXIT_SUCCESS,
EXIT_FAILURE, or any other value, though only the least significant 8 bits (that
is, status & 0377) shall be available to a waiting parent proces. So exit(-1)
return 255.

Use the C standard EXIT_SUCCESS and EXIT_FAILURE to indicate the program exit
status instead of "0" or "1", respectively. In <stdlib.h> EXIT_FAILURE has the
value "1": use EXIT_FAILURE even if the program uses exit(-1), ie 255, for
consistency.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/mailsplit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 7baef30569..9127ac49e3 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -73,7 +73,7 @@ static int split_one(FILE *mbox, const char *name, int allow_bare)
 
 	if (is_bare && !allow_bare) {
 		fprintf(stderr, "corrupt mailbox\n");
-		exit(1);
+		exit(EXIT_FAILURE);
 	}
 	fd = xopen(name, O_WRONLY | O_CREAT | O_EXCL, 0666);
 	output = xfdopen(fd, "w");
-- 
2.35.1

