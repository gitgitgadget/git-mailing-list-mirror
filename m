Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E5691F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 21:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732649AbfHOVlW (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 17:41:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36721 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732317AbfHOVlV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 17:41:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id w2so1991100pfi.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 14:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=74Jop780BvtbGEr1qIupIDUlD248Jd8VxDP1345xiw0=;
        b=hCuInrZeCT4jpKbPqz8RSGcMakZ8WvSnmuM3lWly3NMSywVktiGYnSwyWwu1ts/t9s
         edWYQmxiItLwYPeTkL8I5qLxbDUVvb2WIYcVc3LkioTEgxZ/yk6HXXrR2c+ZkYAFwcdd
         L/xzYDcYXMXrv6/syuMR5oXAP1JIbQqhrgm5R3rW9iA3mS0LscVHt0qopQwxglnXfZRy
         VLOiPGvtUsyQKUwGaN6eq49T7TTStht60ruQ/cQalmWqTMFpmbBdVC7hF40yjLxIBhWz
         HT9dU9aZ/1VIzEPWg6xgpTuFuNeKMRdCQKkIxQ7eroJ6TbtVt2S+tE7SBn4y4KwNthM9
         dtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=74Jop780BvtbGEr1qIupIDUlD248Jd8VxDP1345xiw0=;
        b=N4zecasGwecZaAysWJxhzo1VPbHgMeUYlvR+q5c5xF8ECUBf1Jh4g+DoDwh3bcr+5+
         enyNXRmMlgv/vVXbTAmgnqwXPD1LRzJLf+5IuusJikzAsLBCmbJCgI/YoYbfsEl0PB3I
         rNGcRy5Ihy7bVp7fMTcqN7bHeM/dVxeHUTalIXnmVunwQB65bNgTEUfvfqGv0jYqdVTJ
         gRco9yUQHgtBKosGtUPwgnM8bhIchLFr5APtxzMmAErgFQFYEeb2MsOFr/xe3nYUT6aG
         ph29ecHueZCpoFVGIH3MON4i4F2mT9/gyGHPYZVoLRoTN/9mlHS72K3a4BujEsjlo7py
         X3ew==
X-Gm-Message-State: APjAAAX6A7esSpD1EmzOKhsnN/SYspZLDII/cv5UW6TT0nRw357sYbIr
        M+uwftrJ4RdP9c4O6QD5RB56oKuR
X-Google-Smtp-Source: APXvYqwY+hpUHN3iwF3I2zL99rVawb12MRJaPoJJujVkIBUFlHKjiuxdXD+bSpvbwZuwIceqV4/Qtg==
X-Received: by 2002:a63:784c:: with SMTP id t73mr5243293pgc.268.1565905280686;
        Thu, 15 Aug 2019 14:41:20 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id i124sm4131966pfe.61.2019.08.15.14.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 14:41:20 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 07/24] merge-recursive: remove another implicit dependency on the_repository
Date:   Thu, 15 Aug 2019 14:40:36 -0700
Message-Id: <20190815214053.16594-8-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.32.g2123e9e4e4
In-Reply-To: <20190815214053.16594-1-newren@gmail.com>
References: <20190726155258.28561-1-newren@gmail.com>
 <20190815214053.16594-1-newren@gmail.com>
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
index eae3e4fbcc..fb668fc84c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3592,8 +3592,11 @@ int merge_recursive(struct merge_options *opt,
 	default:
 		opt->ancestor = "merged common ancestors";
 	}
-	clean = merge_trees(opt, get_commit_tree(h1), get_commit_tree(h2),
-			    get_commit_tree(merged_common_ancestors),
+	clean = merge_trees(opt,
+			    repo_get_commit_tree(opt->repo, h1),
+			    repo_get_commit_tree(opt->repo, h2),
+			    repo_get_commit_tree(opt->repo,
+						 merged_common_ancestors),
 			    &mrtree);
 	strbuf_release(&merge_base_abbrev);
 	if (clean < 0) {
-- 
2.23.0.rc2.32.g2123e9e4e4

