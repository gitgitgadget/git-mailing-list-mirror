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
	by dcvr.yhbt.net (Postfix) with ESMTP id ED1771F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 21:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732464AbfHOVlS (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 17:41:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37445 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730573AbfHOVlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 17:41:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id 129so1985550pfa.4
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 14:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xj5SPg238lgVxydTrdsSl0RDGkUT+0FCmMsBmULbm/o=;
        b=RWjaGvFsz06tOzTLk3X4jYGQc00wt4SCxRT5aWUFBRWRDDDXeURibyJDhPCsVKUnZx
         bhIvG7hbsiN8Amksxs249iI7Zu+ZA3bG2O/o/qhtZN5LPew4RBZhab+Pjxyq/X8mJhhv
         TE0Bk+W36lLDPZY00nO47ayb42ZOI8Fl13GOxfvZfln2GuvgcToEaaEOkIAcn+QFnKHT
         G8W9+v6S+4jgxDP/mUBmcUYv3ERIZ0QX44HraCtA9x7QHn1r2J75yTDBZ/51LNzY5lcm
         Y3ZOgLayUBimMcUmYgGykG+axWV8XCId5pjJnBvpAYytTXM+Sk36T6d4q1/0v3f3/dZz
         t9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xj5SPg238lgVxydTrdsSl0RDGkUT+0FCmMsBmULbm/o=;
        b=bUX1zy+BdnNGQMnLTlDnSa283fHInP8GDAEpQwDDcM377bTTJW8OdwP9lVjrUbF66K
         XpnoFC7Whf7iqk+MXETYPu9LWvjJ2ayu4V08BGAEy+QC8HzRWfURoKBZjQCTtOsR6Nw3
         +8GcE2vbOi/IG3zHYlTy/vsQ2oovCrRK2VpkP29fQFp9O/eyV/WQJuI4u+g4Q0GmUL2p
         MtUl7k65kzsyWE6uJkIjvzgv8PUidY548pBNbzUjPI4WqCBv74VhYAQWWWU1AtKSeMDr
         sotPcbGvoOu8D5zT/bB9aLXAXSz0kfdndXZ7K5Eg3D5ryEazpssvbuCnxbOPyvOQV5ei
         tAkg==
X-Gm-Message-State: APjAAAWwDYs7ZKfavdWcvSKymroS2eCKyClaT3k58JLapQZHPSoWjd7A
        HwQZfaNmD9K7NE+BcckjNTPKCAct
X-Google-Smtp-Source: APXvYqxHYrls85TCX/WViGWZ3lhgoTFgQfl2lPH9cigYFBDlaSlUj0LlxDDc5pcD5QaWRxlprCMB0g==
X-Received: by 2002:a62:c584:: with SMTP id j126mr7487552pfg.21.1565905275372;
        Thu, 15 Aug 2019 14:41:15 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id i124sm4131966pfe.61.2019.08.15.14.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 14:41:14 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 02/24] checkout: provide better conflict hunk description with detached HEAD
Date:   Thu, 15 Aug 2019 14:40:31 -0700
Message-Id: <20190815214053.16594-3-newren@gmail.com>
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

When running 'git checkout -m' and using diff3 style conflict markers,
we want all the conflict hunks (left-side, "common" or "merge base", and
right-side) to have label markers letting the user know where each came
from.  The "common" hunk label (o.ancestor) came from
old_branch_info->name, but that is NULL when HEAD is detached, which
resulted in a blank label.  Check for that case and provide an
abbreviated commit hash instead.

(Incidentally, this was the only case in the git codebase where
merge_trees() was called with opt->ancestor being NULL.  A subsequent
commit will prevent similar problems by enforcing that merge_trees()
always be called with opt->ancestor != NULL.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/checkout.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6123f732a2..d5b946dc3a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -713,6 +713,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			struct tree *old_tree;
 			struct merge_options o;
 			struct strbuf sb = STRBUF_INIT;
+			struct strbuf old_commit_shortname = STRBUF_INIT;
 
 			if (!opts->merge)
 				return 1;
@@ -768,6 +769,12 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			if (ret)
 				return ret;
 			o.ancestor = old_branch_info->name;
+			if (old_branch_info->name == NULL) {
+				strbuf_add_unique_abbrev(&old_commit_shortname,
+							 &old_branch_info->commit->object.oid,
+							 DEFAULT_ABBREV);
+				o.ancestor = old_commit_shortname.buf;
+			}
 			o.branch1 = new_branch_info->name;
 			o.branch2 = "local";
 			ret = merge_trees(&o,
@@ -781,6 +788,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 					 opts, 0,
 					 writeout_error);
 			strbuf_release(&o.obuf);
+			strbuf_release(&old_commit_shortname);
 			if (ret)
 				return ret;
 		}
-- 
2.23.0.rc2.32.g2123e9e4e4

