Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 124041F453
	for <e@80x24.org>; Fri, 19 Oct 2018 14:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeJSW7Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 18:59:24 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39562 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbeJSW7X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 18:59:23 -0400
Received: by mail-lj1-f196.google.com with SMTP id p1-v6so31091971ljg.6
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 07:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=84qzXiIeP9mV0deTSbY4zzVupPShp2lNqVX616TDbXo=;
        b=X4p2aGdEhwmQ0cxln7/HG4Eq5cCkBnkTR1Nkzvo9AjKwwEkW68x4mPZ0RlZf/KTonq
         gZVJvgtZ72sG4s89WOmSSGkciSpEobMVgynu/Q8zsUYF8oR9jsZ89RweFsRulgZByCVz
         O9ShP3iUpfB5pbnym1g/kYwHUmJoq848o3toDHl1o+6oD2LJk8oCNhQWFvQk52xI7ClY
         o5CMtgEs7DwA32bvDW941htlhKRn0RfyLCTPLUCEBW7D6dRru7ZV5cR27BClliXM5w6U
         43Q2xIEBuosdALIbJ1zk5R4Ut+rzcdnB6fSGDz8aDhw0IbasxM1qF3VXDGidATlEbpj/
         8dhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=84qzXiIeP9mV0deTSbY4zzVupPShp2lNqVX616TDbXo=;
        b=g+juD+UK0ETcoV35c6R06tIpCjQehAPW0kI0MeTivTB/bevzrvo+Sif8BSJhiwU9eE
         9DHszv4bk5buWg0cJC8HxNPW25td/wJJI9FbxfPtjE3qUBEZLbD0Wx4W/0ZXg3BmStXF
         3JeGf1Fd++uYcJoXlUbF/021oF2F59/uMNtKW4TqRAv0Ch2pz8xwu8HznxOrLXAWARDq
         jMKIf1ZkrG10+In8M/c+7x3qn9gxOs4v77gYG5RNVfhlPSbs7VWAhUxx4P7855E3MEK+
         ROX33nB/DxCkEH++qTxwDeSW7EFkcVaJFS7D0wvdmSC8IfUTc261W8WaNe7TTPygzKg5
         lZzw==
X-Gm-Message-State: ABuFfohCE1nKS7qGtktHE7J3h9ZRUJwHps8h/B2F0XW39x+FAYCQUCgR
        h654R/4Gj2JmZC6Hnjnq6kES7LlH
X-Google-Smtp-Source: ACcGV62Z/l8G3bPGZTY2zh8u0Nr2TgkRjuOIikeBWUNmmjbZ7uea6r6gtXoorTnob1wgRL73LkPToA==
X-Received: by 2002:a2e:7312:: with SMTP id o18-v6mr22484243ljc.125.1539960774246;
        Fri, 19 Oct 2018 07:52:54 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g64-v6sm4002414lfe.87.2018.10.19.07.52.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 07:52:53 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/19] checkout: avoid the_index when possible
Date:   Fri, 19 Oct 2018 16:52:28 +0200
Message-Id: <20181019145237.16079-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181019145237.16079-1-pclouds@gmail.com>
References: <20181019145237.16079-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index acdafc6e4c..38b28c20e2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -284,7 +284,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 		return run_add_interactive(revision, "--patch=checkout",
 					   &opts->pathspec);
 
-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
+	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
 	if (read_cache_preload(&opts->pathspec) < 0)
 		return error(_("index file corrupt"));
 
-- 
2.19.1.647.g708186aaf9

