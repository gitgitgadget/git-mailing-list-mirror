Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB72320989
	for <e@80x24.org>; Tue, 11 Oct 2016 00:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752583AbcJKAV0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 20:21:26 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33745 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752418AbcJKAVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 20:21:25 -0400
Received: by mail-pa0-f46.google.com with SMTP id vu5so3981501pab.0
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 17:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U92o2E7Za+E2SoBNRIHrBkxGNmmwss0HOJ7upwc067Q=;
        b=pCfPrtQFdv8B78CEzY48qPyARUV8HlMKZ/WHx9dy2z0/aqhzkYgupi0o/H+0iitEgl
         8xYs3NuWJ7EAK1OfXqEo9GHpL58p37+i8yYk3xN2GJAZzZHZMH3rZhqLALly/+BXO4/z
         CPMIPoRfDM8BnIY075YUfUnrzBKJzDP+w4Kfn73ZPCQElrjlxejlEtn6/ByZLNBgDTUu
         hBUIwS0zsSASgI0yR9RN3PwqHuT6NMp+DL9A4jg1123I1P43bkEFVnYPQWP+f/XFT0jI
         LQ/cV85q/ncbKkMWjLbxS9AuHBigDV2V0/B9d+qTwQtzKaELrtgiw7YTsO12LWpeIvU7
         3RZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U92o2E7Za+E2SoBNRIHrBkxGNmmwss0HOJ7upwc067Q=;
        b=Y6sqeuubFa93AOUf2FPqM2tUynOVWJvpgdffzuZB4qH+UOQBGrjwBsNtxdyPdvJCT9
         Jg1+ktdUwwm4R/+gSctTXahHeh7KZRSaoLEAFVDZkBDCo0nUb45SUcnH7/gkyhyp2i7J
         +iaSwbKB+e5Jaw3H43+loXkvloM8s9SYjqcmgmt6vBS8jhCRQe0awTnUh/mV8nIHmwAq
         zhQbB1lIeFpZ66GpGZpjG4ubpVx+ta3c9OLUmzmkzvWsxnIaj1hr6Z7Xd3EVyyiFuSMk
         8qUC1CAthRG3mWfst/6kXC/mrSKoCFw4qHfa5lUw1MpLkWVSjtW/AFQ2YDSJ9CMFGb3B
         6Xlw==
X-Gm-Message-State: AA6/9RmxwgUQDG1jUx0K1JAZFwJDAjRUn4AtsDw54d3Jrj+B5bioHGJGksp1YuRzW0Aa+xX5
X-Received: by 10.66.124.198 with SMTP id mk6mr1715640pab.74.1476145284124;
        Mon, 10 Oct 2016 17:21:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id zg12sm540220pab.5.2016.10.10.17.21.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 17:21:23 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 01/28] commit.c: use strchrnul() to scan for one line
Date:   Mon, 10 Oct 2016 17:20:48 -0700
Message-Id: <20161011002115.23312-2-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <20161011002115.23312-1-sbeller@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 856fd4a..41b2fdd 100644
--- a/commit.c
+++ b/commit.c
@@ -415,8 +415,7 @@ int find_commit_subject(const char *commit_buffer, const char **subject)
 		p++;
 	if (*p) {
 		p = skip_blank_lines(p + 2);
-		for (eol = p; *eol && *eol != '\n'; eol++)
-			; /* do nothing */
+		eol = strchrnul(p, '\n');
 	} else
 		eol = p;
 
-- 
2.10.1.382.ga23ca1b.dirty

