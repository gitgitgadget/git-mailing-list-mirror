Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBEC81FF6D
	for <e@80x24.org>; Tue, 20 Dec 2016 09:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934306AbcLTJsz (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 04:48:55 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32931 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934301AbcLTJsv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 04:48:51 -0500
Received: by mail-pg0-f66.google.com with SMTP id g1so9553300pgn.0
        for <git@vger.kernel.org>; Tue, 20 Dec 2016 01:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s6MTWIPREwB/oMLWFHaxNj1E5oraYANU7qttRWUt1JE=;
        b=G7Vc0RWPkuvC2EfOfKvGDiOgKoNw8Wf8vWejq3V9qZYgdOl0S63Tr87eCCL5W8OzfM
         S1VJnu0v/5Qc2bps93BymUGv18GPTNXHXb6PpKDlON1GOa7I2N6s9sDV2HHPD0PCk7D6
         DhjELGa04B63L2QV66v4Ay8W++FTpxLbJoK+NMD58nSWYchpcNfwruH7xI91NURInQ9T
         kipGJhK7vfWTxZPRDh4j1sMyBQsKCkkTSRvss+R0wdDWMZpnXYHQiq2TIPyLiITOfKfz
         3dY/aoOUH5J4JZ5cmTKvts7vRuEKTroX/T37wj3JsNFtitIs4uioqmykpjbgu68dZTPk
         Z3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s6MTWIPREwB/oMLWFHaxNj1E5oraYANU7qttRWUt1JE=;
        b=cVDTOevlXi12pFZEYdXvd2tlbcMBlOqMkCGbdMx5aPAAaChxenT4uNBnLK9JP6/A0X
         SbReqIuI/6XWW7Q8zeW6LKxEDH4j+ACNjJ9zdxXeRzO1yzsO68GtGf39ZjErJ7GW9pwW
         4UMlzjqULYYSGhy3aq+mnmYnMXdfU84RAAT3rHZEZRCgpsl5zrWSoyumZ7QBHMd0eLx2
         u0u4Tc4Utf66O8BOQgZUm3R5Am97QPfZN88PtcTjeTMDr0uxs1ADqbMu+kCFIekObaIE
         vOR9Yy7sRbUtm7jx2mH8VYxlgZGS2wxQnteDjmpj1PxKs7mvndbFsqo2507l0o1y22iF
         0xcw==
X-Gm-Message-State: AKaTC00I9wdlzFCVexOzTxRPRfJI8RdiKOsA4dkx9pQSaU/lVfdQlnzKEF4FDcJmOQJqcQ==
X-Received: by 10.99.153.26 with SMTP id d26mr35189874pge.44.1482227331035;
        Tue, 20 Dec 2016 01:48:51 -0800 (PST)
Received: from ash ([115.73.171.119])
        by smtp.gmail.com with ESMTPSA id a24sm37631769pfh.57.2016.12.20.01.48.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Dec 2016 01:48:50 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 20 Dec 2016 16:48:46 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, josharian@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/2] config.c: handle lock file in error case in git_config_rename_...
Date:   Tue, 20 Dec 2016 16:48:36 +0700
Message-Id: <20161220094836.4131-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161220094836.4131-1-pclouds@gmail.com>
References: <20161220094746.GA3917@ash>
 <20161220094836.4131-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We could rely on atexit() to clean up everything, but let's be
explicit when we can. And it's good anyway because the function is
called the second time in the same process, we're in trouble.

This function should not affect the successful case because after
commit_lock_file() is called, rollback_lock_file() becomes no-op.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.c b/config.c
index 505e0d0..e02def4 100644
--- a/config.c
+++ b/config.c
@@ -2483,6 +2483,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 		ret = error_errno("could not write config file %s",
 				  config_filename);
 out:
+	rollback_lock_file(lock);
 	free(filename_buf);
 	return ret;
 }
-- 
2.8.2.524.g6ff3d78

