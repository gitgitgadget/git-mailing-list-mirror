Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0FC21F453
	for <e@80x24.org>; Fri, 21 Sep 2018 15:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390667AbeIUVro (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 17:47:44 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36878 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390111AbeIUVrn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 17:47:43 -0400
Received: by mail-lf1-f67.google.com with SMTP id b12-v6so4558273lfa.4
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 08:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZY9HF+Z4eIJ8u1E4p/928ueso0GQ6ZIpguoZe0rEgr0=;
        b=JqftTUVXeLWA24X55DVg8M3r0a/hthkfCt0ofCPPpmTZkOkp9mzjY1d0lw1jFicPz8
         zZIxChKnONbMe0iMVYyqKf02e5MCrjCM+HK1VL9Br0B/86mxVL7vWO/2rTeJAJ5RxZU8
         MIayIvdCQhlmG+lO3vcXTdxRjnIxTRDB6yy4ExxWxBlN5N8xCjeH6CId9CHUc6hYaEIc
         ccgXawN1lUYZ3mR7VMTQsTWgjdW+mkgrB8cgcGkKfWaUdHi7qc/p0fXtTpk2HP4MV8EI
         VAtnW81BIBQnV3T7aaPWkfw+SPkhvNhKnsZQDDWHukJ++07B69xIsWi7BVu2L04iimGF
         Pn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZY9HF+Z4eIJ8u1E4p/928ueso0GQ6ZIpguoZe0rEgr0=;
        b=BQBHLwhhhqtxSGfbr1IgwL2obQcAG08tNvAwjgvZ5ofbJTS17tZIyBuq/lAhKvPdhN
         AMU+Zsw8aM/WkPKkXKVd4g3Axu/Kr6UrT9zX2AC1pMJ6Va5tU/CT5cB74jFJecsiKy2u
         PeRmJ3H7W9HWDU4N8TGiG1IKhyG/145lMv58GAGbIHnMhqZPA1kEoq1Bwc4TBRX0xawj
         nkxzSJsuLXeeSYR93Diy2fstbKcz8solUoWle+sf4sDeLEb320Ykdd5deQJW4NePyQQf
         Rm/vPZQGR9xEKM6VwS/UW3pJ2Yu9jeOvtOl1X1lJ/5s5CY42Zo7VPY2g8YAbmdnT6W0d
         17Uw==
X-Gm-Message-State: APzg51B0WUddfXpdu4j5ckJD+rd7S8Vkg6B9ELqAE15MeJAYWj1ZLwCj
        ieUSOKJ8LBuno744HF90fc4=
X-Google-Smtp-Source: ANB0VdYUI7c8JleaWBAW4kGUBNN2K8URCfaRUEgZX3WMLmR16+3ALwRdVEmoyrP/ytjskT5nDfS/EQ==
X-Received: by 2002:a19:d769:: with SMTP id o102-v6mr29936628lfg.106.1537545490921;
        Fri, 21 Sep 2018 08:58:10 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o19-v6sm2192978lfk.30.2018.09.21.08.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:58:09 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com
Subject: [PATCH v5 20/23] tree-diff.c: remove implicit dependency on the_index
Date:   Fri, 21 Sep 2018 17:57:36 +0200
Message-Id: <20180921155739.14407-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.640.gcd3aa10a8a
In-Reply-To: <20180921155739.14407-1-pclouds@gmail.com>
References: <20180915161759.8272-1-pclouds@gmail.com>
 <20180921155739.14407-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 tree-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tree-diff.c b/tree-diff.c
index 57a15f51f0..16b28ff6d6 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -605,7 +605,7 @@ static void try_to_follow_renames(const struct object_id *old_oid,
 	choice = q->queue[0];
 	q->nr = 0;
 
-	repo_diff_setup(the_repository, &diff_opts);
+	repo_diff_setup(opt->repo, &diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.flags.find_copies_harder = 1;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-- 
2.19.0.640.gcd3aa10a8a

