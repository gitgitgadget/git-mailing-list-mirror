Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3E911FEB3
	for <e@80x24.org>; Fri, 13 Jan 2017 00:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750978AbdAMAAm (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 19:00:42 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36284 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbdAMAAj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 19:00:39 -0500
Received: by mail-pf0-f172.google.com with SMTP id 189so20708031pfu.3
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 16:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H/E0WIr80mxP0lPjmWz6iruwCSQaJ4NCI1Yw4UiCI1U=;
        b=DTb8rxevzSLpV0SzrmdAt+lkOU4OJCrjGiP+XAyUbDYkTej3E4vjNpFXrNNGODzQVZ
         8fsk/fyCz/r9ZZEjtUbi/Bp5cG+4zmU9J6ZKqXZDqqhfmdLNS1AtrCtJQ+GfpHDen5my
         JXkMXp7mTbPqe2Xx9+zqgQZjyX2pMO1Hm6Y4rbWwUjDqFOV5OXdshVHyKe7zXIA+RWwP
         cKT4KjO5jhTb+CtgTkbSVNvzzgjrHZFx4+CmWDWyOLhpoilkXieTmhWNBgU0zgXy7zOk
         9PTWxErVQXBNOmmC36YjLLMkI1QCXXOoBm0fO6PSlIOlI3yrJYjbRSXs9krU0UsrGVTx
         mRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H/E0WIr80mxP0lPjmWz6iruwCSQaJ4NCI1Yw4UiCI1U=;
        b=cPBFgaFBLJu/nsm43yUT8o0e20+jDXn/0vXDwli9nChHL/+JNpE1i0Oup8K22UdZ5z
         Cbk9tCpkpOsrbNIY8bzY7/otx/3ZsCi5gfvY1mz8pO8zdylvni9dpxE79GKckvPCQPoY
         UaRRcsSeBh64Oj8hlSPIS0UfcFqPqbEeTtt/9IPj5uHHAwRpmEqvBLmVUkHYarod2UZp
         9GK9kyRVd2rC+vUoCWP79m0q2hSX29/CIHSufxVdU5w5+lodRqFT776KNHYs9ALRaycx
         7aXU4WwozMzbF4uk9A8h7dvtqEWJdGz3NK3GE/Y7hEoUjERMnEkPcXarCd0v4CKYU+fq
         /6UQ==
X-Gm-Message-State: AIkVDXIQHOZKm+yzGqQQE/R/JxuKhiXiFEeu+wfWFp3dC3WYi2cIzuwvv+pG++rlAl9B6tiT
X-Received: by 10.98.49.6 with SMTP id x6mr19300666pfx.176.1484265245258;
        Thu, 12 Jan 2017 15:54:05 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id e6sm24312192pgf.4.2017.01.12.15.54.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jan 2017 15:54:04 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, pclouds@gmail.com,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 02/27] attr.c: use strchrnul() to scan for one line
Date:   Thu, 12 Jan 2017 15:53:29 -0800
Message-Id: <20170112235354.153403-3-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170112235354.153403-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index 1fcf042b8..04d24334e 100644
--- a/attr.c
+++ b/attr.c
@@ -402,8 +402,8 @@ static struct attr_stack *read_attr_from_index(const char *path, int macro_ok)
 	for (sp = buf; *sp; ) {
 		char *ep;
 		int more;
-		for (ep = sp; *ep && *ep != '\n'; ep++)
-			;
+
+		ep = strchrnul(sp, '\n');
 		more = (*ep == '\n');
 		*ep = '\0';
 		handle_attr_line(res, sp, path, ++lineno, macro_ok);
-- 
2.11.0.390.gc69c2f50cf-goog

