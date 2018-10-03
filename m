Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33FDB1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 15:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeJCWZl (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 18:25:41 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46391 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJCWZl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 18:25:41 -0400
Received: by mail-lf1-f66.google.com with SMTP id q2-v6so4458774lfc.13
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 08:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fhWwyWt2lYelCmdazSYsoQ4sUh5+tGcY0PsW1zEh3yA=;
        b=Jf1Mkjv5ylyBOAzZyiyqcCB9+5rVOMlXdTMbGu622tkK53/kQelOZ/wZdgeSg1+M6E
         g0V3qD+ZcKHrGFndMF1p5LMMzqm2L5YJxAv8rmruacPSO3r+kR1o6P5BIgbbQZixY4tp
         n8WFY9YNhTOqHP7tKg72l2Fx1mM6Ca9x7owmObnlzJXOUlvw6Xvoy4Jn4N+ny/rfB6Nx
         L7ZgxbTsuILFiZZHh9iAP9HpqcVS2UOVZb0CgWfhlB+qzDHTSBYswj1xzM5/a4SQ4Im1
         jn9R1wCdW6a2v68uk4jqix5j7GsE+WBo/QKZ/MaF9h3Tf0VBb827gHwc71LEMkE7t6SV
         kfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fhWwyWt2lYelCmdazSYsoQ4sUh5+tGcY0PsW1zEh3yA=;
        b=tOQeRM0bBBjeLBbLTLbG6tXbwQOTbtqAYKvr1gMO2wvxpz+LJlhLobg7G03Jz4QrwQ
         ANoVEifTPaNwZm6RhAI5Cmzk0h4XHeAlLoNFg8nwW7M8bHeu9QlS8a5WzR1ow54x2ywI
         fLNUbBq2vNExM4vdR9zugaX3Kx6uRWLAoEZvctiI3gsrCdfkWwlL4+J31ESq/PZZcFC5
         udNlgVbLcjpLlfOLXUgQVBSgPjMZiJVGrh+1QIKjv1gPD6vLXkXiUtBPSrHwwzm9RYQn
         m/oV2ND058KP0C8yx8t/5OT4DobPkuZovHiXz5UQqRcM2mK8LJU7fZvHA1KC1M7x6OA3
         i8tA==
X-Gm-Message-State: ABuFfoj6jFEmduCu9A8aDcctsQbATucrviHUu7Gz08T3jpIR43n5U9UW
        qFxjBlBQ6shJGwCiWK/mlWmmT1q+
X-Google-Smtp-Source: ACcGV61I8yFPbUOtAYaI7TCND7b6KSVLlk2ADBmW1kdATbrkXRs4B/GKQ19BQLF7AkOo/75Xc4hF2g==
X-Received: by 2002:a19:4d8d:: with SMTP id a135-v6mr1393972lfb.60.1538581006252;
        Wed, 03 Oct 2018 08:36:46 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id u196-v6sm471838lja.42.2018.10.03.08.36.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Oct 2018 08:36:45 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        gitgitgadget@gmail.com, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 1/2] commit-graph: free `struct packed_git` after closing it
Date:   Wed,  3 Oct 2018 17:36:22 +0200
Message-Id: <84a5957ab8a38ac18c432843a3717c0afd0fbea9.1538579441.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.19.0.329.g76f2f5c1e3
In-Reply-To: <cover.1538579441.git.martin.agren@gmail.com>
References: <1686b309-e0af-5518-0fa5-4635b2f481b9@gmail.com> <cover.1538579441.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`close_pack(p)` does not free the memory which `p` points to, so follow
up with a call to `free(p)`. All other users of `close_pack()` look ok.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 commit-graph.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/commit-graph.c b/commit-graph.c
index 3d644fddc0..9b481bcd06 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -766,6 +766,7 @@ void write_commit_graph(const char *obj_dir,
 				die(_("error opening index for %s"), packname.buf);
 			for_each_object_in_pack(p, add_packed_commits, &oids, 0);
 			close_pack(p);
+			free(p);
 		}
 		stop_progress(&oids.progress);
 		strbuf_release(&packname);
-- 
2.19.0.329.g76f2f5c1e3

