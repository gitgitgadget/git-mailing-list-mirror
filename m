Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A4311F453
	for <e@80x24.org>; Mon, 22 Oct 2018 21:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbeJWFay (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 01:30:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35109 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbeJWFay (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 01:30:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id w186-v6so511926wmf.0
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 14:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eDyX4HgaGQ9j+ZPMoz7AY0LAmN3CeA9Kdr28xmHZV0s=;
        b=DWJpxoCcyL8Zg8DOsGqfK26jFA7UVW5bkKM2xAQgyp9LFAxH4TyCNOUTdkWhIrM+eT
         aYyMmAbUPgsilgIDdhZqUFjK3cC3GtGIvktuKfu5Cau2I3PHaR/jitNCPLUfydNgRQhf
         sOkN/WIRf+VDmK6FwaIg+LcALrp+JRZq7COx0vcMZmq3t4LzP9Li16PFJLPGw9A7UUwa
         vBlgrit35v1n5Y/LXX03jIdyEbi2kTUxv72T1BpulChHw7UqUTniuocryfKUI7Dlzd3Q
         zRPRb9PqDWT+mImrCwS1PIO67o/L4Pyzsjvf7WujN9qApcpfLmF5aLmipUuvkpYZ/1BG
         cfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eDyX4HgaGQ9j+ZPMoz7AY0LAmN3CeA9Kdr28xmHZV0s=;
        b=O0oyX8jYPCOfNbmC5sXWhnGhXItR2XWecuwUQGpyAh9hIOVBkQjFqQ5qLhFd5lC2l9
         jxf4n6q0oC26UsuGqZUHDfMqC+BcGHbUagIENf9KEVHWd+eWuPqgIXIuQx65nX5oX461
         V+2fQxqIc3s+tgetC4HiaPao2putqvl0D25rygh9yrt8zgQ1/xjHiY9ORi4PhdRXHGDc
         A3o9Ip91VnT6y4NUfgo712PyooSEOVSHpQC1w44x+128sk7PmZnHgPdprTrhkwMfCopg
         841byMqJ77BH0e8FUcAkFrqMdsckR6b5od+YFnKGH2XsPviv0Fhbdh39c2gX0jBQ7A7R
         2xog==
X-Gm-Message-State: ABuFfohUOfrwEfXnSs/g1B7LcOwydO6ewLk+Ws8Mzob79VY3SSriErCd
        HVGrp7mS+I1wiv8CEfW/n1/+zlAg
X-Google-Smtp-Source: AJdET5du00oMO3lRsiIs2ugfMv/+B70jIxvZqaLmmiAj9k9qHtjsCL1Q+4DJ79nLoTe+pBXpEGHuWA==
X-Received: by 2002:a1c:9a11:: with SMTP id c17-v6mr17740540wme.101.1540242641703;
        Mon, 22 Oct 2018 14:10:41 -0700 (PDT)
Received: from localhost ([2.25.81.124])
        by smtp.gmail.com with ESMTPSA id e13-v6sm977392wrt.76.2018.10.22.14.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 14:10:40 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH] commit-reach: fix sorting commits by generation
Date:   Mon, 22 Oct 2018 22:10:37 +0100
Message-Id: <20181022211037.22719-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.19.1.759.g500967bb5e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

compare_commit_by_gen is used to sort a list of pointers to 'struct
commit'.  The comparison function for qsort is called with pointers to
the objects it needs to compare, so when sorting a list of 'struct
commit *', the arguments are of type 'struct commit **'.  However,
currently the comparison function casts it's arguments to 'struct
commit *' and uses those, leading to out of bounds memory access and
potentially to wrong results.  Fix that.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

I noticed this by running the test suite through valgrind.  I'm not
familiar with this code, so I'm not sure why this didn't cause any
issues or how they would manifest, but this seems like the right fix
for this function either way.

 commit-reach.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index bc522d6840..9efddfd7a0 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -516,8 +516,8 @@ int commit_contains(struct ref_filter *filter, struct commit *commit,
 
 static int compare_commits_by_gen(const void *_a, const void *_b)
 {
-	const struct commit *a = (const struct commit *)_a;
-	const struct commit *b = (const struct commit *)_b;
+	const struct commit *a = *(const struct commit **)_a;
+	const struct commit *b = *(const struct commit **)_b;
 
 	if (a->generation < b->generation)
 		return -1;
-- 
2.19.1.759.g500967bb5e

