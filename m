Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A75A1F404
	for <e@80x24.org>; Sun,  9 Sep 2018 08:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbeIINnm (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 09:43:42 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:33495 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbeIINnl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 09:43:41 -0400
Received: by mail-lf1-f41.google.com with SMTP id m26-v6so15157324lfb.0
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 01:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tri7MOw0zPSM9hxik4U6j/eEIciWu3QEgSq8JGgW2/E=;
        b=USO/biM8TqI4m3anT3jBNHbAM3A1h6pnJmYVdHJAHctT+yufqtnWqc9kugZIcdUTgD
         +F7g8BYsihL3PY4yTsUtcJPicWkNJHLLIOWFHR5ZIgKWw2pXVa0RCUDIwybrXdNDcoDD
         NrEr1WdcTxx40j76A7xWgyP0jomrPdmOJKPRKpv+GzbBDy3EhlIfhL/8dg7kGjU5f/uu
         /4CtUmjepUWgfXSoUYOLMVCj3lG4i+5w0/8R9uQs/5c0u4PrskKAlesjQAUI+7sSLzSY
         CDLH86xlePKHoAh1U0FuTWfbl/OAx2075KPH7yHT2O8K6+ISwvpzc5JKgLDTzszO3JKP
         Qs8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tri7MOw0zPSM9hxik4U6j/eEIciWu3QEgSq8JGgW2/E=;
        b=K5XuqXnMI6Zwt2n2QobtEfQ/cJN1eWcpxNZ3igpXVSDzIXi8ZJz3l7F8bUBVt2ll73
         fmOnNDTqWdeUl0JNyud/dIMHpAVhAnzhX0XVi9G6sssMQOyNLDx0DPDyaIxG0aTCHpr1
         6mb6d+kE2fSSV1t44ELAydoSfv9M7cBf0Z0hlossRDUIqqZYFhUQ6HYL+ZDpzEEvMgkc
         aXDc8aXomYh0WdTCpewPjXlUGJIoZzJjmywwy9HIIngbam9kI+6+IrAFCLSKuWmveGo+
         vHjFzLoVRKJm6/h8TMUA5jqT/kr46zatMAXBSxVjBC61Wrfk5Zl8OULyy9a8KE+9giNf
         HXOQ==
X-Gm-Message-State: APzg51As8KitZ/KrOfJ+/n4CSwzh636sKG7GzL1M4cygorOGaxYokOQH
        eBQts3XntUv1PeX1vy6dAdE=
X-Google-Smtp-Source: ANB0VdZQhhc3vStCqfCzNMy5RSfsPfYOfDIaF/u/iXCrmzqLN8aRdQb53QtWqcGTFi9IioU2bLeNPQ==
X-Received: by 2002:a19:c143:: with SMTP id r64-v6mr4599647lff.59.1536483282232;
        Sun, 09 Sep 2018 01:54:42 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g16-v6sm2102525lfb.5.2018.09.09.01.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 01:54:40 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 09/23] read-cache.c: remove implicit dependency on the_index
Date:   Sun,  9 Sep 2018 10:54:04 +0200
Message-Id: <20180909085418.31531-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180909085418.31531-1-pclouds@gmail.com>
References: <20180903180932.32260-1-pclouds@gmail.com>
 <20180909085418.31531-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 read-cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 6f772b2885..563500fe98 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -823,7 +823,7 @@ struct cache_entry *make_cache_entry(struct index_state *istate,
 	ce->ce_namelen = len;
 	ce->ce_mode = create_ce_mode(mode);
 
-	ret = refresh_cache_entry(&the_index, ce, refresh_options);
+	ret = refresh_cache_entry(istate, ce, refresh_options);
 	if (ret != ce)
 		discard_cache_entry(ce);
 	return ret;
@@ -1493,7 +1493,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		if (ignore_submodules && S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		if (pathspec && !ce_path_match(&the_index, ce, pathspec, seen))
+		if (pathspec && !ce_path_match(istate, ce, pathspec, seen))
 			filtered = 1;
 
 		if (ce_stage(ce)) {
-- 
2.19.0.rc0.337.ge906d732e7

