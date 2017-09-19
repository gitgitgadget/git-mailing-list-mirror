Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4109F2090B
	for <e@80x24.org>; Tue, 19 Sep 2017 07:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751564AbdISHPt (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 03:15:49 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38233 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751009AbdISHPr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 03:15:47 -0400
Received: by mail-pg0-f66.google.com with SMTP id m30so1584732pgn.5
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 00:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vLCttZ7FLsu7rTcTV24nfw9c2MNoV1Eyf7DlrLYmarY=;
        b=I4pC+WBv01XfwVft/1dkAX0LoU9BHOrLW4H05tFo3TXTR9MJw7f11yaf0GrdGws7BU
         CpQZPTLvRB8c07hgefLsDcuolgHXhCFoIzENfOeuXPUJTzf17fq3+TYQB13cB7kT8/gj
         AXwNPqccJ1obXkeUavuGbFS5FzhP9SX03oKoPPRKBZv++IlD+baMSX03rDJQz2apj+Dd
         DZdDp0MGDyvT05AB6nTTd030Ob/QTYI5nULOoGDurUgs1PKb/CsI+347pCfyJ29K++dO
         WE5p+4X0YsZGJtPmBzWVjMaDPz4CZreyDCZfnOFH4BmIqThSPeC/zcVNOTjC87CYz7ub
         PEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vLCttZ7FLsu7rTcTV24nfw9c2MNoV1Eyf7DlrLYmarY=;
        b=WuM5PQ3JP/zUtSOqe7Qnswka4zlKn1tHDyTMm4AEzLnHCrHW1EMtU8pwcpaInplp6t
         DYR/2AOCHKssZMRzaErnt2siktTw+JbxVT54gVXRUpJKgXFnl0VWr6nHy/o4KxFMcOIj
         Dnc+eEDUHciUEULQX86w42cszzNVL/Iz6xs+1T7lJwdxPfkVaEnP+sOf7xqFfa4jYC5V
         Dqb34WZtiwQa5IUQCBSJBjZYSQZtPZPOPt8dSFBjNVljva+dk1t62mM4cYbyu7HJs06b
         D2PD9GWU4qXsERZco6h1mt3D8YDn2dBk8zpP0FmXrRyTmWbkn8DwfQUWJoWkKFiHoat7
         QaJA==
X-Gm-Message-State: AHPjjUhe9s6PErFhrDWGlHopcLbgRhGadqzvnII5+yqNBV7LhLTFxVNX
        NLJPNJ39WbU/8LWVy7HdI9sNXb0WrpQ=
X-Google-Smtp-Source: AOwi7QDD6y6qodj7uLh/N7SCtQJIoqT7lsrwPxq9rJEFSIus1sFx7EpLvJ0CYqvTQYg9QW7XwyRcLw==
X-Received: by 10.98.103.27 with SMTP id b27mr446978pfc.160.1505805347083;
        Tue, 19 Sep 2017 00:15:47 -0700 (PDT)
Received: from glitch-pc.sce.com ([117.209.170.72])
        by smtp.gmail.com with ESMTPSA id d126sm1927863pgc.85.2017.09.19.00.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Sep 2017 00:15:46 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [RFC PATCH 1/5] builtin/checkout: avoid usage of  '!!'
Date:   Tue, 19 Sep 2017 12:45:21 +0530
Message-Id: <20170919071525.9404-2-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.1.930.g532ff9be2
In-Reply-To: <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
References: <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
 <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Documentation/CodingGuidelines says,

    "Some clever tricks, like using the !! operator with arithmetic
     constructs, can be extremely confusing to others.  Avoid them,
     unless there is a compelling reason to use them."

There was a usage for which there's no compelling reason.So, replace
such a usage as with something else that expresses the intent more
clearly.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 I think the expression,

    !!opts.new_branch_force

 is equivalent to,

    opts.new_branch_force != NULL

 in all cases. If it's not, let me know.

 builtin/checkout.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5c202b7af..76859da9d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1281,11 +1281,10 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	if (opts.new_branch) {
 		struct strbuf buf = STRBUF_INIT;
+		int force = opts.new_branch_force != NULL;
 
-		opts.branch_exists =
-			validate_new_branchname(opts.new_branch, &buf,
-						!!opts.new_branch_force,
-						!!opts.new_branch_force);
+		opts.branch_exists = validate_new_branchname(opts.new_branch, &buf,
+							     force, force);
 
 		strbuf_release(&buf);
 	}
-- 
2.14.1.868.g66c78774b

