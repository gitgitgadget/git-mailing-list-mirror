Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFDE21F78F
	for <e@80x24.org>; Mon,  1 May 2017 18:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750924AbdEASBT (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 14:01:19 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35849 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750895AbdEASBN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 14:01:13 -0400
Received: by mail-pf0-f175.google.com with SMTP id q66so33311373pfi.3
        for <git@vger.kernel.org>; Mon, 01 May 2017 11:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dOJoMuJbMMfxUiT7xGv9q9ZTNkJlMOU1QCVAA+kRjrI=;
        b=u6/ZcJKl5aLgGw1EijbBX4FzedUofo+laAN+dFkn3ubp/I2kiOYXCN4ig4J4RIyzMn
         etEDq5K3C6Ye725pFrZVeNjagQ8zDa7hwJlxu4E6WWfP4hyp72yD+nL7gBp+rNc3VZ1G
         iVSBn+14I0ePcFIJ+E6ncH4EIBzivn3vPqkAAAbSZynl39acCLSd6F9x9/VmvPY+NJSG
         03ocR58UrBE/UrXkpHMJFLhvQBExTsX8fbqDv6TjCp0vh67+gnL5xO4kEbu0xT2ZAqH0
         euKRYEAkkDVxxHkWBtL9fpcAtiZtL+kT1TdV/KMrBDPq7HPZ2sFlpx2JfCLyHiu293i3
         bBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dOJoMuJbMMfxUiT7xGv9q9ZTNkJlMOU1QCVAA+kRjrI=;
        b=dAsV+bqaKQlxx52VIRKpH2A3XUWeei7sVm+LsO5BzxU50FGawy9YfahdFC/SbID6vJ
         TQE3R9kPxnauZe3v5Lg47EELK3L07T+97XWbg4INKFkJDACjYMCBN9+MM6pMZa88aADU
         5X5O4ym2QjLofdY8ExPp/KQ7/4Q1YtcMnSpwH+ooyZHy71OK/fBFcxuFS5KTr/eOvDiE
         IJUctSub1fb3ZxGoOWOAJZmxU54u4lqSZEP2bapwPbyBKqi6DOxuDgcZjmm8eIz7cbra
         zEsDljeAZA/Nl/JbCa/wOT+FQMY/o+7YQZagiG0x7W0SLEFR56jz8dxqgxJJ4QAxtOOc
         4jew==
X-Gm-Message-State: AN3rC/5Wext9ukZuVzSYuP1U7dlhtX9AZFUfc7Eou2DLLcMhm8f1ZD7r
        8WTtjbee4giFaDSNhxucWA==
X-Received: by 10.98.54.129 with SMTP id d123mr3024277pfa.17.1493661672149;
        Mon, 01 May 2017 11:01:12 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c4be:9746:6a14:c7a4])
        by smtp.gmail.com with ESMTPSA id 130sm12295682pga.7.2017.05.01.11.01.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 11:01:11 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jrnieder@gmail.com, bmwill@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [RFC  PATCH 5/5] submodule_move_head: reattach submodule HEAD to branch if possible.
Date:   Mon,  1 May 2017 11:00:58 -0700
Message-Id: <20170501180058.8063-6-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.1.gbc33f0f778
In-Reply-To: <20170501180058.8063-1-sbeller@google.com>
References: <20170501180058.8063-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Side note: We also want to call this from git submodule update

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/submodule.c b/submodule.c
index 4e74e38829..66651ffa34 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1483,6 +1483,8 @@ int submodule_move_head(const char *path,
 				ret = -1;
 				goto out;
 			}
+
+			reattach_HEAD(path, 0);
 		} else {
 			struct strbuf sb = STRBUF_INIT;
 
-- 
2.13.0.rc1.1.gbc33f0f778

