Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6258C1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeCWRqA (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:46:00 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43403 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752171AbeCWRpx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:45:53 -0400
Received: by mail-lf0-f68.google.com with SMTP id v207-v6so19491430lfa.10
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jkzSYny5yPEYgTv5kJWOrlAuZJ1sl2Ix5ibi0/e+Oik=;
        b=YRPnxeuszZWwckxKLtnMmg8tHkoIrb3Kh9unBdMBWlHt6nt3tKMHMi5t5Zn63ejrQk
         pETTeKDMPiOS60aH83F7048imnXCpSDzgcOtzJlPL8gNtw/auZ4aEw5LdI0chEI+LfTx
         9luyRzpzYCUgEWq5v/FHB/t2/Ho+4l5IB6PN38bERKrL5oZ5FSRSh4SvDXFL0H+76TEM
         b+rOziddgMCN7FkkmIckPuUcxP2j+FM470LHKRxsQHUBvHn8BXHw1fMPrQH+RohYfNYY
         A897NQxNs31U4Z4OOamUfdw7j5VJStwmnburtVibCN3kgw9yRgP7BzPB6s8cBtQ5I5DY
         G8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jkzSYny5yPEYgTv5kJWOrlAuZJ1sl2Ix5ibi0/e+Oik=;
        b=MojM+Si4DsOm4C+RYWlSiwlrFAY8CVglbOL3C+nzJQ6lJz7/tv1i9SXx+sZMFWZ+m+
         BJ1011a14MeQ43iBwhtlNh46wXCRPXRdenu3azUoVEhIASIw6mpnva534DDp0ct0USAI
         mis22zywBgqM7FM7awiyjWsPrNuQcj0sgK1Yrk7xlKN3e+9OMCbZmfd4iEWwISjZ/QAn
         OcEqLZ8divkJnET+jbQp6Fo13LfPnGghTI6q6jLEWK5sYzfoUYLLTngfM6gE3Sfnxo7E
         C1d5cYausqWV4CVySH3Z8jAZ6RvtQt2fECgqeacZlUssFblpllCqfW4t+EcafMDmSkY2
         djPA==
X-Gm-Message-State: AElRT7GxZ66Uf9xOHDu/el8hiwc/QrI5y6gCMRLQ2qg3HCb2cO0FaxiY
        rWKXwm6emEaXhKP/UjzQ+lU=
X-Google-Smtp-Source: AG47ELsR9ff8Ta2uiGa/cU+j53rvh57FP/il5uF/ELzby+cJ7jR2T2QmFKMzKSZC+Pjf+DsIvRYQJg==
X-Received: by 2002:a19:d80b:: with SMTP id p11-v6mr20912354lfg.11.1521827152620;
        Fri, 23 Mar 2018 10:45:52 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id e8sm847487ljj.6.2018.03.23.10.45.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:45:51 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 09/12] packfile: allow reprepare_packed_git to handle arbitrary repositories
Date:   Fri, 23 Mar 2018 18:45:24 +0100
Message-Id: <20180323174527.30337-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323174527.30337-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323174527.30337-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 packfile.c | 8 ++++----
 packfile.h | 3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/packfile.c b/packfile.c
index ad90c61422..eb2dc53331 100644
--- a/packfile.c
+++ b/packfile.c
@@ -898,11 +898,11 @@ void prepare_packed_git(struct repository *r)
 	r->objects->packed_git_initialized = 1;
 }
 
-void reprepare_packed_git_the_repository(void)
+void reprepare_packed_git(struct repository *r)
 {
-	the_repository->objects->approximate_object_count_valid = 0;
-	the_repository->objects->packed_git_initialized = 0;
-	prepare_packed_git(the_repository);
+	r->objects->approximate_object_count_valid = 0;
+	r->objects->packed_git_initialized = 0;
+	prepare_packed_git(r);
 }
 
 struct packed_git *get_packed_git(struct repository *r)
diff --git a/packfile.h b/packfile.h
index 3fd9092472..ee6da3a9ae 100644
--- a/packfile.h
+++ b/packfile.h
@@ -35,8 +35,7 @@ extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 extern void prepare_packed_git(struct repository *r);
-#define reprepare_packed_git(r) reprepare_packed_git_##r()
-extern void reprepare_packed_git_the_repository(void);
+extern void reprepare_packed_git(struct repository *r);
 extern void install_packed_git(struct repository *r, struct packed_git *pack);
 
 struct packed_git *get_packed_git(struct repository *r);
-- 
2.17.0.rc0.348.gd5a49e0b6f

