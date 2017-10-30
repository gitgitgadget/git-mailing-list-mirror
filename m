Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26D6A202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 19:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932875AbdJ3Tqz (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 15:46:55 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:49690 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932873AbdJ3Tqy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 15:46:54 -0400
Received: by mail-io0-f195.google.com with SMTP id n137so29916573iod.6
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 12:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IO8tlypddJATV0y2Ya2EIEinq09WBYz+HLfSWiH2ZNI=;
        b=X/AJpAzYem1P69KD5xHJpck7/iIGTMEGxmpnD1CZHnJ7NJ9Gds3d5MaceDIKU6sSTS
         wMuI49Rj/e6wgIPBwy5WrUKKnRu6HFSAxzrmbJ4fek9mys5dzpSnAanFcODopDOdewsk
         SgxoIbUp5E48ZR/ayVU1Tf2Qe3UjXWvTPzdAXYH0Lah+nAL+HhXI9Cl/+4tPJc66RiGW
         UXH+RZpn19XNC/ymDwkiazia6ietWnJGY+7R1NxXq7dkK1CUwlgyajGcT72tak6GpuTl
         dXbqhrDrsYW6s1c/KmFTJB0/0RpRCbeYoBk87Iz9MwPwDWvxNgxiFbC5YHwvBrmxnFZJ
         E7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IO8tlypddJATV0y2Ya2EIEinq09WBYz+HLfSWiH2ZNI=;
        b=qdhuVlNTKAAEsbA+f3Tav6pK/mOdz9SEMFOL2CD0qHmvVCpy4xZjRiyCTmJjzYFvwX
         T1/FH7ddRRwAnvwh1X7RHJ1w118tZO0Wi06tXHe3xcHE1gtv/F5Zjp1g5h4dSDyrUPuB
         3E4jD/uKNEacNqbfvrjACxfkk6viTHoI+VAWQIYSDNv4eflu/LODylW8gqZ/0ZDZFMcN
         b1Md2pYwcLsT2RJjYCln8zFSo8vh1vKStkCWKSpPbnQfk4N2etpDs1LLthq6IoREahcu
         5GhZWczv21ew/XsW/sYpbvuLiyoPtxJ6L89lFLp93RlDTkMykiwrfSjDRb2LFrZaDzmk
         CB0Q==
X-Gm-Message-State: AMCzsaX5q/iUsAzxS2K3sTLSbCgR6kQTeW1qzWVp/7QjXt5HU+DcWUJw
        4GnhPOriRmWtIB/uoOo2qCgwIuLK+Cg=
X-Google-Smtp-Source: ABhQp+RuC7K8rWhyEI1/mR0Ii56qaf2czuxlKbv2zxj5/CfWmcLdooHmLK3hcoJoEI6gHxQyP2aDIg==
X-Received: by 10.36.185.94 with SMTP id k30mr475052iti.2.1509392813074;
        Mon, 30 Oct 2017 12:46:53 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id g195sm2372805itc.14.2017.10.30.12.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Oct 2017 12:46:52 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 1/4] add, reset: use DIFF_OPT_SET macro to set a diff flag
Date:   Mon, 30 Oct 2017 12:46:43 -0700
Message-Id: <20171030194646.27473-2-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.403.gc27cc4dac6-goog
In-Reply-To: <20171030194646.27473-1-bmwill@google.com>
References: <20171027222853.180981-1-bmwill@google.com>
 <20171030194646.27473-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of explicitly setting the 'DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG'
flag, use the 'DIFF_OPT_SET' macro.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/add.c   | 2 +-
 builtin/reset.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index a648cf4c5..b70e8a779 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -116,7 +116,7 @@ int add_files_to_cache(const char *prefix,
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = update_callback;
 	rev.diffopt.format_callback_data = &data;
-	rev.diffopt.flags |= DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
+	DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
 	clear_pathspec(&rev.prune_data);
diff --git a/builtin/reset.c b/builtin/reset.c
index 9cd89b230..ea2fad5a0 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -166,7 +166,7 @@ static int read_from_tree(const struct pathspec *pathspec,
 	opt.output_format = DIFF_FORMAT_CALLBACK;
 	opt.format_callback = update_index_from_diff;
 	opt.format_callback_data = &intent_to_add;
-	opt.flags |= DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
+	DIFF_OPT_SET(&opt, OVERRIDE_SUBMODULE_CONFIG);
 
 	if (do_diff_cache(tree_oid, &opt))
 		return 1;
-- 
2.15.0.403.gc27cc4dac6-goog

