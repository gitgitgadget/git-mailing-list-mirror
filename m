Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C4661F462
	for <e@80x24.org>; Sat, 15 Jun 2019 16:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfFOQMI (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jun 2019 12:12:08 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43125 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfFOQMH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jun 2019 12:12:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id cl9so2284727plb.10
        for <git@vger.kernel.org>; Sat, 15 Jun 2019 09:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KRIPiDOeEZHitOQ0XopQ57ITGkYGyueWSSB9U5N8ivA=;
        b=W2m2tn4cZ0alpCIAl7gqB6G/xKlEzgQmCtj4+QQmgjJOqUJFu1MFK0Wzx5oBpDaDD4
         3TjR0cZdxB/Y+6ZzhQYR3mSbEu+bxCoUZGA3VrrSGBzLtpx+vg/Y7PXW7c+Pu3d8X5lH
         +f5Pp+0pO1LWmc5BefPq1FNd3jTtFnTRhYYdojzKHeVSVZftRk1oJSrttXba/9VlE54l
         gEDBVKlPNu+q60aAqNGTUFd0k0ZrBFZmRVhrIsbQtf8bmsosbkoSYq8Ehzl1S96X1g9+
         plekx9rzVqrTGYy6zcLxpGLZFMihVaxu0xi0XszCYHgBbIn8Uecr+UCmozBwNupRzdKo
         Wzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KRIPiDOeEZHitOQ0XopQ57ITGkYGyueWSSB9U5N8ivA=;
        b=uTy8j32NwH1He+9M1BcFiwrOKcvtx1ASUaMRQE6K0WA8BA4alrECY1D1IdB6Ic7GRg
         TMhy5UoIF3ukBB0VWWnjYHy/sUXJJY5lG7Yg7VQ+aneQItdw/9GFw4ZTw2yxQ/sdjr1Y
         4/mF/+MIR/i1ROojbPNyF4c4cQmyE6D0YrlfNuY1km/oE9V/HTiX6mH1Iv0E4Z/oxH2E
         j/ul6VDJc3BLYE0H+UuVbTcFgxCoHtCm6iWJUpT2IWSDfmxRaaZ5e6sc3fASXMhbE0C/
         VbzCbFPSBuDF1OrQ9XmDOzMzqSpP6EKkbgeFV4EkAEofWcmr7fyRCyTUhrzV1fK30uWe
         Zrcg==
X-Gm-Message-State: APjAAAUO+FL5TAhfXENK3lmBa0w240jhbUsl7TEWt7k8+Owl7VqqTZNm
        78derxeJW+uWSqgFwkgkdFrq6bEk
X-Google-Smtp-Source: APXvYqyOqmVBgOl5z0BPHRvtY0SfG0LiLJnSpnAZfddtjQGAigHDdSgmLOIo4O0TSy6PlDcfto+OPQ==
X-Received: by 2002:a17:902:9041:: with SMTP id w1mr85929862plz.132.1560615126698;
        Sat, 15 Jun 2019 09:12:06 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id m19sm3833267pjl.0.2019.06.15.09.12.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Jun 2019 09:12:05 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     benpeart@microsoft.com
Subject: [PATCH] fsmonitor: avoid signed integer overflow / infinite loop
Date:   Sat, 15 Jun 2019 09:11:35 -0700
Message-Id: <20190615161135.57269-1-carenas@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

883e248b8a ("fsmonitor: teach git to optionally utilize a file system
monitor to speed up detecting new or changed files.", 2017-09-22) uses
an int in a loop that would wrap if index_state->cache_nr (unsigned)
is bigger than INT_MAX

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 fsmonitor.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 1dee0aded1..231e83a94d 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -56,7 +56,7 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
 
 void fill_fsmonitor_bitmap(struct index_state *istate)
 {
-	int i;
+	unsigned int i;
 	istate->fsmonitor_dirty = ewah_new();
 	for (i = 0; i < istate->cache_nr; i++)
 		if (!(istate->cache[i]->ce_flags & CE_FSMONITOR_VALID))
@@ -134,7 +134,7 @@ void refresh_fsmonitor(struct index_state *istate)
 	size_t bol; /* beginning of line */
 	uint64_t last_update;
 	char *buf;
-	int i;
+	unsigned int i;
 
 	if (!core_fsmonitor || istate->fsmonitor_has_run_once)
 		return;
@@ -192,7 +192,7 @@ void refresh_fsmonitor(struct index_state *istate)
 
 void add_fsmonitor(struct index_state *istate)
 {
-	int i;
+	unsigned int i;
 
 	if (!istate->fsmonitor_last_update) {
 		trace_printf_key(&trace_fsmonitor, "add fsmonitor");
@@ -225,7 +225,7 @@ void remove_fsmonitor(struct index_state *istate)
 
 void tweak_fsmonitor(struct index_state *istate)
 {
-	int i;
+	unsigned int i;
 	int fsmonitor_enabled = git_config_get_fsmonitor();
 
 	if (istate->fsmonitor_dirty) {
-- 
2.22.0

