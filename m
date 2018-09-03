Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57BA31F404
	for <e@80x24.org>; Mon,  3 Sep 2018 18:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbeICWbz (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 18:31:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36387 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbeICWbz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 18:31:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id v26-v6so1090727ljj.3
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 11:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+1KQtQ1Nv8cbrkpQ3gC/vTrrzzDnvc2mzBiNM/X2Vj8=;
        b=qzNdz2/Ue9sIrN8xdcDogHsCe1jyH2dC1mMMzjV0vWUCqBXURUE1NdnpJ1C+CDo+AN
         hor2s5iB7FYL2lkG6MNGxGYqL5Y2vJezXWD32dwVStgDeYpNb7igRTZF1J9MovA2chG1
         i94p5q8rR5WSxx0k0aAZsvJ9kPOs/pzKnRswvvEkfDu2IOuHW3xbFnb/954BUrqV5lB3
         oTaNxCYZb2UvR0TCQMGCxk3KR1duRnk/F9i7B/rrdrHzYuqdNoLWE81H3nHYPlqww/K5
         HAMhNSBiJfVsKi7Q15lbGBbFu/BFAPZguB3iTK1hqVLjDnbx5MJPzuDp0kSmMajS8ls+
         oC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+1KQtQ1Nv8cbrkpQ3gC/vTrrzzDnvc2mzBiNM/X2Vj8=;
        b=CO6xpQeLc9Blyyu70IVVb6rdUFeXXTO3+t4b9QaNJOZkvFS1V8+hAOARbST9BrHusV
         YoVwCWEU/H51UJwZRsCRP5IIN53QjpIwUXhvUvMv9ECESg6fPbSKdykNurT5N1W01JfC
         GApkySXqAcw4zWcVVQMM6iXJP36t7A6Yf24osY9Fsrvr0o9NaHxC2BQN3WLDp1ed9GUT
         J8/WQrwZ+fQPgURTGLD9P4rX6pEIvQMMdnchl95KAaZv4KkokDWYw1Ybf/kH89dEdP0x
         ncmGQzccI+Vw8SD/FvstfHrQ+QkIkIEgJcD0kzhYOaOHm8lFLXq5TQhLuDLi1KqErnWe
         XpiQ==
X-Gm-Message-State: APzg51CiMIksiHvmgIsj90o8bYo9aNpSbnQQWu32GlTitiD/6Oz6Y3rX
        F4vPCJ+jRgiFebCUFG3zpPKh0V06
X-Google-Smtp-Source: ANB0VdbhyPaJ2FKfDZDY9RYHmBheZl3zOTah3md1+c6hQc5zvsr3sZHsmpbwy1LIybDOZ08EE6Wqxw==
X-Received: by 2002:a2e:658a:: with SMTP id e10-v6mr16376702ljf.99.1535998234483;
        Mon, 03 Sep 2018 11:10:34 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x20-v6sm3706062lfi.8.2018.09.03.11.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 11:10:33 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 20/24] tree-diff.c: remove implicit dependency on the_index
Date:   Mon,  3 Sep 2018 20:09:28 +0200
Message-Id: <20180903180932.32260-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180903180932.32260-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
 <20180903180932.32260-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 tree-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tree-diff.c b/tree-diff.c
index 1cfd77ae6b..86cf5a3971 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -605,7 +605,7 @@ static void try_to_follow_renames(const struct object_id *old_oid,
 	choice = q->queue[0];
 	q->nr = 0;
 
-	diff_setup(&diff_opts, the_repository);
+	diff_setup(&diff_opts, opt->repo);
 	diff_opts.flags.recursive = 1;
 	diff_opts.flags.find_copies_harder = 1;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-- 
2.19.0.rc0.337.ge906d732e7

