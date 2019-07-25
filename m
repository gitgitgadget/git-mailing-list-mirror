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
	by dcvr.yhbt.net (Postfix) with ESMTP id 74CF81F462
	for <e@80x24.org>; Thu, 25 Jul 2019 17:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403781AbfGYRqV (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 13:46:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34568 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403772AbfGYRqU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 13:46:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id b13so23121245pfo.1
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 10:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XxNcj2ebZ96mBgp/C2n01LV8DiMxhq4yQo5oGrbhIBY=;
        b=uCUeBX1UgA08mKWyqLJGMk9AoxrCwgnEt4csxE4T9pFAD9fxsNoE5UfiyHS85hOZOg
         GLWvq2qOrIJ2ZHiN9qQpoWzhholESI10QfqGLsBs+ZFDMIrToe1I5Ya5+DMM+VwkjMjH
         bXBj0SgN2rh1Sz7Bi+CUI66HHCQvOAtQjUCa1RK1gC506CxEWhWuBR4dJ7+6/f0TpRnM
         yKMFEuXgAWAvUz7g5zvC2pKiJcX9BZR97nPhcsx0lXDmOD4h2gVigg9IqQc3V2w8WUAe
         uLuQhSgumIGYyEVeUZbChlAxlcUZ4KPX4e6Ba3OIh920ytjhNsxrUQrKYTob3z5jttEM
         eS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XxNcj2ebZ96mBgp/C2n01LV8DiMxhq4yQo5oGrbhIBY=;
        b=XF5qnppMvaW27EmfNvVX429zOMEUH2j9CiA1W6qhgfNfiI+g8FN4SAurdoaehIg2Z8
         PxFWhgtrOGj6rbUmg894ryFYyJVnIfomiqy4073rWH40JiSG/1N1fMJKwtLpEsoz6zqT
         c7ztA+DkGftj2T1suPHzWQS6Xf3XX42RtAVgBqFHzUtakSKLG11cRXrFPmYMtkp0wks2
         YPDk3kzeBAhvqZ1s6pPG1dMWN7BrOUf/01tatGVhhpVtYEJxC+DgLavTCRIbI4vly1L4
         J7+T2FzJAx7v49Ct1zcjgVyEKB1wlvETykc7hqlgFwYLaBaVPLC/XY/nD8DrEN1mZz6z
         8dkg==
X-Gm-Message-State: APjAAAURBkne4GHkEJ6PuFhWso/OqmTSmr+7kY5c4iphzyExfi8U1DTi
        VEbsZCWFV35b8T/oFAsD+RHjJxaC
X-Google-Smtp-Source: APXvYqwbqspBVM+Cnk/1qe8If7Y84t2uDgX5F3f2b/apWB8sfjo15bAJ4wJgewjT1BzxoXn2FUb3mw==
X-Received: by 2002:a63:f452:: with SMTP id p18mr61577800pgk.373.1564076779380;
        Thu, 25 Jul 2019 10:46:19 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id v138sm58171800pfc.15.2019.07.25.10.46.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jul 2019 10:46:18 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 02/19] merge-recursive: remove another implicit dependency on the_repository
Date:   Thu, 25 Jul 2019 10:45:54 -0700
Message-Id: <20190725174611.14802-3-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.559.g28a8880890.dirty
In-Reply-To: <20190725174611.14802-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit d7cf3a96e9a0 ("merge-recursive.c: remove implicit dependency on
the_repository", 2019-01-12) and follow-ups like commit 34e7771bc644
("Use the right 'struct repository' instead of the_repository",
2019-06-27), removed most implicit uses of the_repository.  Convert
calls to get_commit_tree() to instead use repo_get_commit_tree() to get
rid of another.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1163508811..37bb94fb4d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3571,8 +3571,11 @@ int merge_recursive(struct merge_options *opt,
 		repo_read_index(opt->repo);
 
 	opt->ancestor = "merged common ancestors";
-	clean = merge_trees(opt, get_commit_tree(h1), get_commit_tree(h2),
-			    get_commit_tree(merged_common_ancestors),
+	clean = merge_trees(opt,
+			    repo_get_commit_tree(opt->repo, h1),
+			    repo_get_commit_tree(opt->repo, h2),
+			    repo_get_commit_tree(opt->repo,
+						 merged_common_ancestors),
 			    &mrtree);
 	if (clean < 0) {
 		flush_output(opt);
-- 
2.22.0.559.g28a8880890.dirty

