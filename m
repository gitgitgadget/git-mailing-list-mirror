Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AD762013A
	for <e@80x24.org>; Thu, 16 Feb 2017 00:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756271AbdBPAiy (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 19:38:54 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35324 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756261AbdBPAis (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 19:38:48 -0500
Received: by mail-pf0-f177.google.com with SMTP id 202so796729pfx.2
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 16:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L8rX3Y11T2tC8W9UAAJTVzH2YhCmHbIhWYdnMtK7XPk=;
        b=Z6y0UKeunqTiQp86FVyeAjZn37IBTLvyYeVHFK/4HcY3L2M+rziczF/DEMf2Jzrd+A
         NUQY5pkdEnlPYtDZhxPZ3cyZF7m28sNC0M3u2vQx1yKT0jR2YtZhivQOKWN3QhYTwMVy
         WuOpreDnMf+hLwUOQgsjSre2cD+iwfKZ54RpeBtJwRlTA84fKKLD7uTwfzFerpgaxaQ3
         XkQIX9pITP1TTF5q21CLxir0BPIxAposWassVA9lMF7ln0ti1JTSzJ2Q8toF4ckyljK4
         y6Wol1aQrzC+UaBgz1oCXIJP2jvIDZquPrVnTHpvV+0wWSoNw0AhSwUcrxSjFXT9fYPl
         nmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L8rX3Y11T2tC8W9UAAJTVzH2YhCmHbIhWYdnMtK7XPk=;
        b=TcMX7QdSkpVaJlP2EuAzH7eISM/aIBDZuof5GBJ985jrDVPoSFIJiX5K7KYGewooyJ
         utrsXW/mGQMK+vCrCw8hc1cyPE+eWMOsbzeiHRdkCL6cNrkYAqj/daFLME1MgMznAlkp
         /lG1Z5v8YyMexxGG7PTFL9LU7m+K57Qczs+TubKPVN/u/ejzg9L9G/lnH6M1zrS4r6uq
         399eYH6b/DX268FksJ7mMenbv2YFAKED14z4mBUpsYQFcpl9a+2xVTGu5Es/X2U3PquE
         NvXNjdPZ+YwwB7LgBe3U+nTTCdZFe8QgelRr6bn377HGiubgB50XmkKzSiGnRgM9vvi8
         QxWA==
X-Gm-Message-State: AMke39lhHKY5E4ZcXgZDRFxdKsZi8VjeoYt0Kf8FuAwrxa8isz+s9s9h9EgN2pImcBtx06tF
X-Received: by 10.98.155.155 with SMTP id e27mr40524557pfk.140.1487205517312;
        Wed, 15 Feb 2017 16:38:37 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2ca1:506:4965:89ed])
        by smtp.gmail.com with ESMTPSA id 75sm9480577pfw.103.2017.02.15.16.38.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 16:38:36 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 13/15] read-cache: remove_marked_cache_entries to wipe selected submodules.
Date:   Wed, 15 Feb 2017 16:38:09 -0800
Message-Id: <20170216003811.18273-14-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <20170216003811.18273-1-sbeller@google.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com>
 <20170216003811.18273-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 read-cache.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 9054369dd0..b78a7f02e3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -18,6 +18,7 @@
 #include "varint.h"
 #include "split-index.h"
 #include "utf8.h"
+#include "submodule.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -532,6 +533,8 @@ void remove_marked_cache_entries(struct index_state *istate)
 
 	for (i = j = 0; i < istate->cache_nr; i++) {
 		if (ce_array[i]->ce_flags & CE_REMOVE) {
+			if (is_active_submodule_with_strategy(ce_array[i], SM_UPDATE_UNSPECIFIED))
+				submodule_go_from_to(ce_array[i]->name, "HEAD", NULL, 0, 1);
 			remove_name_hash(istate, ce_array[i]);
 			save_or_free_index_entry(istate, ce_array[i]);
 		}
-- 
2.12.0.rc1.16.ge4278d41a0.dirty

