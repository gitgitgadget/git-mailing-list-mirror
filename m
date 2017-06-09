Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 788281F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 18:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751724AbdFISSG (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 14:18:06 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34536 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbdFISSE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 14:18:04 -0400
Received: by mail-wr0-f193.google.com with SMTP id u101so8436975wrc.1
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 11:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qQjg91a4FrJVbZpOVKbb+RI82Q/bg5rOuIzlV3oUOkw=;
        b=PmmacrxondeSG5BbAZ5JvYP/Hy5uDiluKqnvBH/42APWGQ4i4TWktgqyc1PB167TFW
         r8xjwfLvkKpmu4iy0ht19hwyAZtM9ihwdPGFNkeITif3QVuS77e+hf4/njxGRW7rRsq7
         BTZ/gHWqb2q6gsDMcuwoEjPIiW5BrfUrsQ0on9w44mAX6qEhv3UR/0feYb1mdEGLNn+x
         3Gpj1bXhyG+kSLOsNK3bAwb6Xkklqk2jzRJNRMDMeoloTN5iWoKZWLPYYVemMYpkpUXj
         nTFtsPCnHc8a/HzxWPgYZhr2OR45fDwwy6DDmz4Vz9Hx5jIAAM79Avg8NZXCViMYprEP
         VAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qQjg91a4FrJVbZpOVKbb+RI82Q/bg5rOuIzlV3oUOkw=;
        b=Dck0jIiozfr/uburIUZ6VbuoSCulHwZdOJ5pPCOe0enpF7fntxThtHGC3spfXC0Bw0
         UifPANij5jUAX8qZboDdRyPhkRAk0MBxftWHcYnr+JpqEYMhnuSjcw0Jtk7iB63VIVNQ
         Ag5nq67TZfw1SORRhovlB61AxgCkSakUEtGMsK2ta3jNKHWlLa2YTVPOACo4kFSJBryT
         mDZmhBCoGSA1J3WU+dtvGK0W2qfPsQSKVtQIRoWwhK4zCi0K1SDjPkDKiFvwY3ohboG4
         6YlNHkEFmAVJlCJozbb2E2FSHauX66K0xNcpgRr4NhYaZfrz3D6tR1dS8ej31AEaXTub
         2MyA==
X-Gm-Message-State: AKS2vOxdyMnnoEHP0D3dO4sJ0sY701fKtP5kVsWIcEV/IfYJMWaW39Xg
        eBwvMvSExAHXzw==
X-Received: by 10.28.136.201 with SMTP id k192mr898670wmd.122.1497032283225;
        Fri, 09 Jun 2017 11:18:03 -0700 (PDT)
Received: from localhost.localdomain (x590e0f24.dyn.telefonica.de. [89.14.15.36])
        by smtp.gmail.com with ESMTPSA id g46sm3485851wrg.69.2017.06.09.11.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 11:18:02 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 3/5] revision.c: stricter parsing of '--early-output'
Date:   Fri,  9 Jun 2017 20:17:31 +0200
Message-Id: <20170609181733.6793-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.0.420.g54001f015
In-Reply-To: <20170609181733.6793-1-szeder.dev@gmail.com>
References: <20170602201143.6avkhp224no3dukb@sigill.intra.peff.net>
 <20170609181733.6793-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The parsing of '--early-output' with or without its optional integer
argument allowed bogus options like '--early-output-foobarbaz' to slip
through and be ignored.

Fix it by parsing '--early-output' in the same way as other options
with an optional argument are parsed.  Furthermore, use strtoul_ui()
to parse the optional integer argument and to refuse negative numbers.

While at it, use skip_prefix() instead of starts_with() and magic
numbers.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 revision.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/revision.c b/revision.c
index 2f37e1e3a..68531ff5d 100644
--- a/revision.c
+++ b/revision.c
@@ -1785,16 +1785,13 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--author-date-order")) {
 		revs->sort_order = REV_SORT_BY_AUTHOR_DATE;
 		revs->topo_order = 1;
-	} else if (starts_with(arg, "--early-output")) {
-		int count = 100;
-		switch (arg[14]) {
-		case '=':
-			count = atoi(arg+15);
-			/* Fallthrough */
-		case 0:
-			revs->topo_order = 1;
-		       revs->early_output = count;
-		}
+	} else if (!strcmp(arg, "--early-output")) {
+		revs->early_output = 100;
+		revs->topo_order = 1;
+	} else if (skip_prefix(arg, "--early-output=", &optarg)) {
+		if (strtoul_ui(optarg, 10, &revs->early_output) < 0)
+			die("'%s': not a non-negative integer", optarg);
+		revs->topo_order = 1;
 	} else if (!strcmp(arg, "--parents")) {
 		revs->rewrite_parents = 1;
 		revs->print_parents = 1;
-- 
2.13.0.420.g54001f015

