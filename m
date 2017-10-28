Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DB7B1FBF4
	for <e@80x24.org>; Sat, 28 Oct 2017 00:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbdJ1ApO (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 20:45:14 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:47079 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbdJ1ApL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 20:45:11 -0400
Received: by mail-io0-f196.google.com with SMTP id 101so16173710ioj.3
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 17:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TsnE8jSwAOl/d8qMmB4Fl5NGVTO85z4Ra8XOWu2yOxs=;
        b=Ro5Nl97KuZORTaet6iz7aJc4iYL+e/MUKhZAlX8672EtHlrRCVjbvfFbGLmnRZHOjw
         P6PHbJMryt9wGI/jwNp85b1BvPaob18sEt39QYhAFpDsIArgUueWCmVIVnxghzgvtaAF
         lirEy9fVg5EZ0MpUuuA2QEnv/oHzQbjaZE+xusBS2sESJGnyaoNo6KX/eP9FY8PwsA0T
         Wa95wFD+8qPBjw6b39QqI2Liw6z+PBxe0i+Qrbb/gwhw2wvz/FRm3t/mcvk2S8NAyWVX
         ojb1Pe915AM/gjUQaLiAN94bmI+9E86qOD8SkwrElahRB7BvcxWLMSwIhTUFmUz1zp4H
         Qj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TsnE8jSwAOl/d8qMmB4Fl5NGVTO85z4Ra8XOWu2yOxs=;
        b=UubTunvRXHCOPZrM4/clSuuP/mys7KG2gw4jW+3yQfLpBvHKtPIWbqYzYVJdRCIGzA
         pJRxNSMV2wYhSdxCk1Vd7NUZtpQfkhIeZNOWZVitNyAMW0xlkQh2HxkzkygYdVwECDW1
         Duo17Z32o4R1ocxxLAouOGL2VfYBUuufDUqik120lp4NbfSP3jRozIOa2H2ug2zwq23g
         swE24QmJa07Wo+7dtOcCE1JNxPTTfsiPGoZvCDxw77frMhc2EmQ46qu3M+Tl1stCi7hz
         kL54bNezgsckdkMcb+hxeQnQCCTDNFMovm9550uKniore9lsp18/GgeFXf4nL2rFayTr
         6Rpw==
X-Gm-Message-State: AMCzsaUUhjs3S2QUr7k+mTWq1lYSsfvAXnavO5SjybRCIT0n6Y/y1Okq
        3FDl4T1yHjv1JKpPRqyVeOY6eQ==
X-Google-Smtp-Source: ABhQp+Qbh9HXZ50L/uOslgVs2oOw3I683lmKcQuZfXFZ3FY8jvIMaMX3wld2l4+3o5mLrs++pPZ7/g==
X-Received: by 10.107.111.2 with SMTP id k2mr2732324ioc.39.1509151510558;
        Fri, 27 Oct 2017 17:45:10 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:1da7:34ee:3ff4:f700])
        by smtp.gmail.com with ESMTPSA id b102sm1467640itd.19.2017.10.27.17.45.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 27 Oct 2017 17:45:10 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Subject: [PATCH 2/3] revision.h: introduce blob/tree walking in order of the commits
Date:   Fri, 27 Oct 2017 17:45:05 -0700
Message-Id: <20171028004506.10253-2-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.443.gfcc3b81c0a
In-Reply-To: <20171028004506.10253-1-sbeller@google.com>
References: <20171028004419.10139-1-sbeller@google.com>
 <20171028004506.10253-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will be useful shortly.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 list-objects.c | 2 ++
 revision.h     | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/list-objects.c b/list-objects.c
index 0ee0551604..ef64a237d3 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -237,6 +237,8 @@ void traverse_commit_list(struct rev_info *revs,
 		if (commit->tree)
 			add_pending_tree(revs, commit->tree);
 		show_commit(commit, data);
+		if (revs->tree_blobs_in_commit_order)
+			traverse_trees_and_blobs(revs, &base, show_object, data);
 	}
 	traverse_trees_and_blobs(revs, &base, show_object, data);
 
diff --git a/revision.h b/revision.h
index 54761200ad..86985d68aa 100644
--- a/revision.h
+++ b/revision.h
@@ -121,7 +121,8 @@ struct rev_info {
 			bisect:1,
 			ancestry_path:1,
 			first_parent_only:1,
-			line_level_traverse:1;
+			line_level_traverse:1,
+			tree_blobs_in_commit_order:1;
 
 	/* Diff flags */
 	unsigned int	diff:1,
-- 
2.15.0.rc2.443.gfcc3b81c0a

