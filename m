Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E3691F404
	for <e@80x24.org>; Tue, 27 Mar 2018 23:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750922AbeC0X22 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 19:28:28 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38443 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbeC0X22 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 19:28:28 -0400
Received: by mail-pg0-f65.google.com with SMTP id a15so236822pgn.5
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 16:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0zET234v5FPIedhw9us0GTj8mUV+9sYBsLIvsbGP40Y=;
        b=Bjot8i1Kp0r0gPZRgBAaTSXjjVKDFY/3KbZVuU6BbNqvrtsG7qD7hFqvuIIXaKPjpA
         bajQj+k1U7E95UdqCGb99Gvnh5B3datglLNodBJJoVhmZv3A03fcIGyGd7W9khlRDhP8
         EpI5hGehey+2BBLD3ATJM7mRE6nvoKbXvaYW/TMbfvQfAVYO8+UwYUCyifL5oUCmEIaI
         Qcjt1mruFOQh0w6EKGj6innyMhRIf90eVfLI/NCbjbY45BTw1HSTZZp3Wv/7tj6ED9gp
         2IRnbG040Ej+CgmVCG4HdNUJkq6HB3HzgM10YAZPC3l6pFb08JeDJhrKvkUd6wpxkKl+
         ypWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0zET234v5FPIedhw9us0GTj8mUV+9sYBsLIvsbGP40Y=;
        b=E4CAJ8cdur5AbeF1kXXOPOarXsppLdYF9l2CAgoFEQ4bmQxMLjf58a93Q3BzTDwWvg
         dC4DN3ANkBtRgZrlwwXlojmtdN/Td7TmE3HI8BOcKwxPruIGfCvHTQTAyf+y9IzhHY8S
         dByczAA7vDHQXXQR20AdQi8QMFLQ0a1h9xh+2c7eITiYZFkv1m3ZLiwlcmUq5nDL0e9U
         95Tf7ifiNzmFpRWADR2R3W0anCizqRNKToIoaggXk/YS9/jw2IOJwP7n+GkYxElEXF/3
         dPI+IW3QbSfAEhQJBmAu0jMxMsFI3vCJ98bqYUs+1QY696FTGVNmLstLhBTWI8q880VT
         nP8w==
X-Gm-Message-State: AElRT7GSUV5PIDLGSHRHgViUhQIdsRuHSiGOe7XkTigB0pclaq1c3QC3
        Su3r2mOHVLx+Rrv042cGt+hTjja2yRQ=
X-Google-Smtp-Source: AIpwx49ebdc6snu7DA1cC7rzyqii2V9NSXb5aT+5IYPPdchjN0PrDx9Xz8KL2ceCtacg8M8T0tbAzA==
X-Received: by 10.99.167.6 with SMTP id d6mr812386pgf.287.1522193306907;
        Tue, 27 Mar 2018 16:28:26 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id z126sm4617003pfz.27.2018.03.27.16.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Mar 2018 16:28:26 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     kumbayo84@arcor.de, pc44800@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule deinit: handle non existing pathspecs gracefully
Date:   Tue, 27 Mar 2018 16:28:24 -0700
Message-Id: <20180327232824.112539-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
In-Reply-To: <CAGZ79kYGY5bjh0WPQh7xkXQxLkB9EQ-OcJhVuGE8YUnwmvk2Fg@mail.gmail.com>
References: <CAGZ79kYGY5bjh0WPQh7xkXQxLkB9EQ-OcJhVuGE8YUnwmvk2Fg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes a regression introduced in 22e612731b5 (submodule: port
submodule subcommand 'deinit' from shell to C, 2018-01-15), when handling
pathspecs that do not exist gracefully. This restores the historic behavior
of reporting the pathspec as unknown and returning instead of reporting a
bug.

Reported-by: Peter Oberndorfer <kumbayo84@arcor.de>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ee020d4749..6ba8587b6d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1042,7 +1042,7 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 		die(_("Use '--all' if you really want to deinitialize all submodules"));
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
-		BUG("module_list_compute should not choke on empty pathspec");
+		return 1;
 
 	info.prefix = prefix;
 	if (quiet)
-- 
2.17.0.rc1.321.gba9d0f2565-goog

