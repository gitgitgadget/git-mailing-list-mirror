Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9F8E20248
	for <e@80x24.org>; Fri,  5 Apr 2019 03:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbfDEDh6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 23:37:58 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:41924 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729941AbfDEDh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 23:37:58 -0400
Received: by mail-pg1-f171.google.com with SMTP id f6so2296967pgs.8
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 20:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nIQRy5oKpfovtvtUNRuuXxdSyxPv41Jq/FlYM5wt0wg=;
        b=J4ubGEJM8y5NNw04OapfimFzPmIhI54w6ro1nN0Dh9G+E44u/2yJaINkgl77bDknEH
         YkYsBGM1rGgp4y6pTB6V0N+z9olY1LvV70OxMZ4nbRt16oW+88RdMa3KkVkBxKdTVK3n
         Dhtjf/TR1xmOCzdV2HQA0TRG7cTQUzHcFuiqUFeaN+6EtnzTqsQIeWoKOeFtHzyhGo4n
         +dlqD23/kkxe2yRE8SnfZfLnZi6vMRugmkCAQS913oPSYZl0GgN6Stzj3TlQfH2XvLzp
         VCkNrFg0FzC7hRtSnXQ6DeM87q3zb28MVJ6EuEnvViQyIhBwY0venJPd/KmAdzZnyDzS
         mj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nIQRy5oKpfovtvtUNRuuXxdSyxPv41Jq/FlYM5wt0wg=;
        b=OWOjFJrojnJDzslCJh8bDPpHPMvOv06mHxVB6XuOTJsSHBiIbL9AmYj8NhLwZ2JNCn
         COa0TnAvdemJt14UEwV9DPdjBPJIaia0CjCiKpnNG5L99CIQm1oP2/gwnDaDvAFcSNdQ
         qzo7rG3tCNNa0ivFlVApwhjduWpaviNvNuZSieBZUQgLI0+P8ZwQXCzRFSkhX+GQDnt6
         RIZmvnfSQ3b7dK0DyhYlCIBvh9F+CeeDKEnwAWb7L7t6FujdxbIUiy54lsVq1aIvOcsK
         R72Zd2kRoNofy2i7Y6E75Xaql3d1ZWnQrbSnjzz9NGpl/lKjLy8O4GQsa7RKV15ueGzR
         2q8g==
X-Gm-Message-State: APjAAAXq58VNrl1USqGjtF07/AmPNIdkKaWdmuVQwFbXlFpi6mIlI3Nq
        6rc6bxkackqE2+adLUV83b4y9L1HBmlu/A==
X-Google-Smtp-Source: APXvYqz5HlFVGowQewrKQKVcxQrEMvkEOmoURsmtHDRWTWelACvJ5SoO4AUkfDXQI5Rerb8SH9Y5mg==
X-Received: by 2002:a63:1003:: with SMTP id f3mr9309364pgl.227.1554435477331;
        Thu, 04 Apr 2019 20:37:57 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:9900:4016:ceb4:1574])
        by smtp.gmail.com with ESMTPSA id e21sm29004683pfd.177.2019.04.04.20.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 20:37:56 -0700 (PDT)
Date:   Thu, 4 Apr 2019 20:37:55 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com
Subject: [PATCH 7/7] rev-list: detect broken root trees
Message-ID: <358da99528daba2c9d34430fe0d262b6b5d23009.1554435033.git.me@ttaylorr.com>
References: <cover.1554435033.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554435033.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

When the traversal machinery sees a commit without a root tree, it
assumes that the tree was part of a BOUNDARY commit, and quietly ignores
the tree. But it could also be caused by a commit whose root tree is
broken or missing.

Instead, let's die() when we see a NULL root tree. We can differentiate
it from the BOUNDARY case by seeing if the commit was actually parsed.
This covers that case, plus future-proofs us against any others where we
might try to show an unparsed commit.

Signed-off-by: Jeff King <peff@peff.net>
---
 list-objects.c                         | 3 +++
 t/t6102-rev-list-unexpected-objects.sh | 6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index bb7e61ef4b..b5651ddd5b 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -374,6 +374,9 @@ static void do_traverse(struct traversal_context *ctx)
 			struct tree *tree = get_commit_tree(commit);
 			tree->object.flags |= NOT_USER_GIVEN;
 			add_pending_tree(ctx->revs, tree);
+		} else if (commit->object.parsed) {
+			die(_("unable to load root tree for commit %s"),
+			      oid_to_hex(&commit->object.oid));
 		}
 		ctx->show_commit(commit, ctx->show_data);
 
diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
index c8d4b31f8f..98f5cffbb6 100755
--- a/t/t6102-rev-list-unexpected-objects.sh
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -68,8 +68,10 @@ test_expect_success 'traverse unexpected non-tree root (lone)' '
 	test_must_fail git rev-list --objects $broken_commit
 '
 
-test_expect_failure 'traverse unexpected non-tree root (seen)' '
-	test_must_fail git rev-list --objects $blob $broken_commit
+test_expect_success 'traverse unexpected non-tree root (seen)' '
+	test_must_fail git rev-list --objects $blob $broken_commit \
+		>output 2>&1 &&
+	test_i18ngrep "not a tree" output
 '
 
 test_expect_success 'setup unexpected non-commit tag' '
-- 
2.21.0.203.g358da99528
