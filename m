Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C4EC1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 13:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751701AbeCONEL (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 09:04:11 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40945 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbeCONEK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 09:04:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id t6so10379384wmt.5
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 06:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=lfvgSycoLE5t6S1Y+j1hN1KDrYuzr6MuWC6UdXnmkVo=;
        b=J/TojLcV1dbdUbu0o2cSPdZcXzXrXCs+VBRHbrAwkKSCRzlMCuxemaMPo5qEpIwD2I
         vzQp8OWWgqbJr83HLmtcM+F1LaVCoOYmZP9gAw0VNGzqm4Z/bi+cgeTgXMUKbNHpMr6n
         G0V5GprKt+55UIJbf1fvwAz4KL0JnY/+O3lWIqkgiX3QPtNMVmURdpS9IL7aDUIZ3hEc
         M9tbaKLFvZh7mVuFyiRtXTh76g5lBE7Q2cJQYvhocutyyg51boMEB1Z1hcfhwVS4ZONz
         pqsOh0FP7dUnSi3TJOJuZm8rYUFjVvo/P+vfNji9o27A97spCA3THWfRJPn+kCclV4hk
         Khcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=lfvgSycoLE5t6S1Y+j1hN1KDrYuzr6MuWC6UdXnmkVo=;
        b=lBs7W4CQ9vuiULPW74uvuMrhEEmxgWYo2EeYCdeUB6/IEcQw4v8efHj0jeyadyytJM
         mDE7wnU9KhW6qOuau+8n/IVTtpzNjljkRRN7WNx/ClJSpUvDpgg+qn/nFuNXqBbdw9E4
         MdEDrY4ZDvGRAmGiRP0lo7dQF5LUAovqr7c2RpLBUJplO9pvrWyywxpiopt6nMxaOhhb
         1UoZ/tlx3IiGKIWHT1x8mnuHmmxo9eMMCp+jEpOHArfbPKNEdwy9rMmbKx+gWlfjLFah
         pZstQijzvVR2e1mnpOGiGGAkEK96u+AYEs0lAh/qvNmWYsrmlVgStY0kLbr8YHnX7yv2
         AKMQ==
X-Gm-Message-State: AElRT7HYw9JRBDJMa2s8uRaAvYVC0LjrV4yntdjKZmD3LTxaNz+npjb4
        7e5U6iyJhBuc9pCe0tqAkce33GUB
X-Google-Smtp-Source: AG47ELvZUvmRIBMSnPyA0s2umFbsa1+vQdri3R5DRB/11gLB7kPyXH736C+lQaIAVzkD+o932DJS8Q==
X-Received: by 10.28.63.66 with SMTP id m63mr5016907wma.102.1521119048960;
        Thu, 15 Mar 2018 06:04:08 -0700 (PDT)
Received: from FUJITSU-PCD-030.progesoft.local (151-0-155-178.ip281.fastwebnet.it. [151.0.155.178])
        by smtp.gmail.com with ESMTPSA id w73sm3121654wmw.42.2018.03.15.06.04.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Mar 2018 06:04:08 -0700 (PDT)
From:   Michele Locati <michele@locati.it>
To:     git@vger.kernel.org
Cc:     Michele Locati <michele@locati.it>
Subject: [PATCH] filter-branch: return 2 when nothing to rewrite
Date:   Thu, 15 Mar 2018 14:03:59 +0100
Message-Id: <20180315130359.6108-1-michele@locati.it>
X-Mailer: git-send-email 2.16.2.windows.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using the --state-branch option allows us to perform incremental filtering.
This may lead to having nothing to rewrite in subsequent filtering, so we need
a way to recognize this case.
So, let's exit with 2 instead of 1 when this "error" occurs.

Signed-off-by: Michele Locati <michele@locati.it>
---
 git-filter-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 1b7e4b2cd..c285fdb90 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -310,7 +310,7 @@ git rev-list --reverse --topo-order --default HEAD \
 	die "Could not get the commits"
 commits=$(wc -l <../revs | tr -d " ")
 
-test $commits -eq 0 && die "Found nothing to rewrite"
+test $commits -eq 0 && die_with_status 2 "Found nothing to rewrite"
 
 # Rewrite the commits
 report_progress ()
-- 
2.16.2.windows.1

