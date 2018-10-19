Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C378C1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 16:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeJTAT1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 20:19:27 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35083 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbeJTAT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 20:19:26 -0400
Received: by mail-qt1-f196.google.com with SMTP id k3-v6so3022157qth.2
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 09:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wRtu7/h6Bix6Vcw4Xfx2ru4d12CEnaR6YK8Pms953p0=;
        b=q7J/ktxgEOE2mmVLthVd/Bp2woM9G3q6yMCN7+5zFY2JxIr5Y/2TVAfMUEX3npDrqi
         kjIRjLRZju0fKmtD3hqQrkzuGId0oYDlaewjUGWdJ6YKu1wVz/RdVmmNMwb0IruYwcli
         z3OTjvRVG7W83INH97G6c//ydFg+oFE+K3pAJMtvywER97c0QqzpxXIg+hl7ifTZn0Bx
         MMI+lbazfsfWbrsLyhbWjGnzgyuZngpq6BxWRDuuol2Aj1jadZawF+sQYO5oHdR/I5QQ
         B8etL5BcMQMGEpNmOrW9+rZpvvXBNrW9gLe+++rIelyaLUnUq47Qkf9PmBDvi/dffict
         szwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wRtu7/h6Bix6Vcw4Xfx2ru4d12CEnaR6YK8Pms953p0=;
        b=lhPzxdSOG3vvfSGrNy3HyLiNDnj7yMZPO4iMLmNA9fBqeEUCdoS8nWTtdsGZuQAfMq
         0l6Op9XnURRnAGzUUQ0a3hdSTdbYoKkKwCvrNtEmQaMOIiFgLodgtZBWcXFTXth5Py61
         T2uwrgV07xx4I3Y/0Fp8NEevi26JGBrcYU6/Z0V8ld6VxiLWWLUfJdtvROPn1DKyFfbI
         lqgrL7tzJh2imjhCrTYiElCqZPsPESt32qtIrRTw/lke8EojbXa7qm2mHmZ/WT0XODTN
         y62XLcLzIxuKKpANrdjcnIx4NatTZTzg9ZcbIlHyCQ5qYiQK2/nj6aaIAYCDtIK3fW+D
         pw4g==
X-Gm-Message-State: ABuFfohpHcxoTP0kc20IvDZc5tRXRLwS4Zm54qLmRIlk9V+/Gcvvqpni
        Uch+MOtbullImUzXqafo7rOq/wbPRsU=
X-Google-Smtp-Source: ACcGV60FKoHbFcF+cskICrtc0lKbsC2wbPXLuh9Dn8AfqVxTWKFBSG1s7CMUSeiTgBecWZXPCbiRIQ==
X-Received: by 2002:ac8:464d:: with SMTP id f13-v6mr32599268qto.377.1539965559646;
        Fri, 19 Oct 2018 09:12:39 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id l27-v6sm3666485qkj.79.2018.10.19.09.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 09:12:38 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, peartben@gmail.com,
        peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v2 1/3] reset: don't compute unstaged changes after reset when --quiet
Date:   Fri, 19 Oct 2018 12:12:26 -0400
Message-Id: <20181019161228.17196-2-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20181019161228.17196-1-peartben@gmail.com>
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181019161228.17196-1-peartben@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

When git reset is run with the --quiet flag, don't bother finding any
additional unstaged changes as they won't be output anyway.  This speeds up
the git reset command by avoiding having to lstat() every file looking for
changes that aren't going to be reported anyway.

The savings can be significant.  In a repo with 200K files "git reset"
drops from 7.16 seconds to 0.32 seconds for a savings of 96%.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 builtin/reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 11cd0dcb8c..04f0d9b4f5 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -375,7 +375,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
 			if (read_from_tree(&pathspec, &oid, intent_to_add))
 				return 1;
-			if (get_git_work_tree())
+			if (!quiet && get_git_work_tree())
 				refresh_index(&the_index, flags, NULL, NULL,
 					      _("Unstaged changes after reset:"));
 		} else {
-- 
2.18.0.windows.1

