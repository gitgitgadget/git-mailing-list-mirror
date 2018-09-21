Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21D291F453
	for <e@80x24.org>; Fri, 21 Sep 2018 15:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390576AbeIUVra (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 17:47:30 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34944 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389545AbeIUVr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 17:47:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id p10-v6so12125963ljg.2
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 08:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1DW7MDRTHYlHTcDaQT4HWNYJtHkPc1cSOwwLrijftAE=;
        b=PVnU5XBs0dHZb8AMvDqmi3QS4UaKAFTZS27xSLGNX6K33FTJckXnfrT6hAcyumAOQE
         Q7xQant5rTtIBu3+rG6tI8qxCRpI8mV/3Cfo9s6ysQKo+CFpiPVziuiXMZ5Sw4LJ3A5t
         bHB8YVeLKj7/R6914HuIzmsD92fItIHi9zc0flJHzFqgmmKF6+cXiUXNAx7zShQmvJIt
         xdDCj0BjBtTk0U1Zz+01jds203lU0yefcsLAE0UCXPmr18tKGcvM5MMtUThPiqDRbQS3
         PBdQyNS2/6t3kZMjv68eRHxjBRAKQXgk0JUV6SjxiJZjj++Ib/Zf1Er05YQsq4LI02e4
         BWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1DW7MDRTHYlHTcDaQT4HWNYJtHkPc1cSOwwLrijftAE=;
        b=PejVVluZSM5/14vWr/uypsqEgu82A2zwAsa2UIJ8t+UUIm2Txa4JQFPuhbIvjSvpMF
         C7msVPfQB3+vfavXUqpmovy9Blk3S1mqkZn8we9eIC9HpTGstB29JS02DbwtoSHEc/3+
         yCdCYheOZa07YCcpYNTLQvGpx/ksMsetkQMpyI1DqiVXu1yz7pJgWCES8mELnJ6LO+sw
         01k1WbJdG7CIvfJC6o2rkro2ndgFAl+ryHGcADjVWqri3NUM0nIISvJcsiy+9OhNKhpI
         NBW6tK2j2oG8q8fi9ybgOV+0jFkf1VETXipe97rbx/6eeUAfBts2/Xe6sHMe+vjr3Usn
         HTiQ==
X-Gm-Message-State: ABuFfohrn7thlXFzoGpRiLtHdjvMDeJV4H2nTQs0NKRTqeTpwIbE4vNw
        dcDNIhDpnz5dfmCG8u4GChg=
X-Google-Smtp-Source: ACcGV61bEEN9DnPHvSgZakYPWSmqxpupRAOGH8uO0/okmMWi/GPY6KRWp3QmWe1Ou4O7H+3xJGTcjA==
X-Received: by 2002:a2e:58b:: with SMTP id 133-v6mr2257937ljf.28.1537545478108;
        Fri, 21 Sep 2018 08:57:58 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o19-v6sm2192978lfk.30.2018.09.21.08.57.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:57:57 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com
Subject: [PATCH v5 09/23] read-cache.c: remove implicit dependency on the_index
Date:   Fri, 21 Sep 2018 17:57:25 +0200
Message-Id: <20180921155739.14407-10-pclouds@gmail.com>
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
2.19.0.640.gcd3aa10a8a

