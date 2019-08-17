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
	by dcvr.yhbt.net (Postfix) with ESMTP id C64561F461
	for <e@80x24.org>; Sat, 17 Aug 2019 18:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfHQSmD (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 14:42:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39691 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfHQSmC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 14:42:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id f17so4807005pfn.6
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 11:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bEfuFzv6GSQu8bO0b16Ske6zvIUfiovZ+xO7W1H2whA=;
        b=vKFisq9T+jZMREOSmVUkGv4BmTRJn8GGKB6NGFIkSvZ0aNikBdHwOg+FIP8boU0lid
         mFrCygTEGTMLQZYfztQmBRo+MZpM6Z+THsyqbSZbsU6EpT4TK1tQn0VcM6SjpWSnnLC5
         3dmaIB7uVdaxgwsLmOAAu0JYxk1Jar/7V8auuvbljwK+/fhss6nsXy/2p4af/e68ZrlV
         KW6G9+I6ROn4iv/BlmfjhEIyJjMHwDc38NSY7fi4GVpC4iQ+sflHNHN96mM2x2DbYhHe
         AZgqkRUSTE8MiJeWDsjOKQxQ4PUOGfBtLzwiXYh+gSiXLNqu5oXSgNnZHfrx3g22zaZl
         Rkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bEfuFzv6GSQu8bO0b16Ske6zvIUfiovZ+xO7W1H2whA=;
        b=YAv3Sa3JGCQKMAlhcD0GMLmAHifaMw1kvf7ZTTS7ME0c6Wo12yLFXnYZpg1tF2eW0k
         8symQ2U10smprfOeCIQKYHMsQl9hg6ju468pqjE7nv47N21M/jXyRISXM3OZsh4apc64
         6vAnvGeMhiqFatRaPtP+XrddWNeAv/eF/O7LhSQDAAavvBKmks0n4MvEP65X5/SyECc2
         e8/bxg5ZccQiuk12T1GMemr78cL+yDEZH7fszT09PjYT19ITorxJzUXtV4E6ZU3Ppzve
         1buI/lWQekAZfUHYtFvaRNvY4qy5F5sP/8bc/HBPsG/gSUztFi5Ovz/M5GWK8B0mU3Mt
         2dSQ==
X-Gm-Message-State: APjAAAVKzMtiCQad91IGVJopg+oCYUX4vgjbFRyBmzLBLt6JH1rAxIYv
        6OtAY1JQ6HQYl/MAm/rP02JAtTwK
X-Google-Smtp-Source: APXvYqyE2P92L1LZm5xb/6qpbcA05f3h/klMYvze7IuCSqtRgSIiSJar+HEvNfr9WHzU4fqDznV5ww==
X-Received: by 2002:a63:f941:: with SMTP id q1mr13030928pgk.350.1566067321275;
        Sat, 17 Aug 2019 11:42:01 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j15sm9990422pfr.146.2019.08.17.11.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 11:42:00 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 02/24] checkout: provide better conflict hunk description with detached HEAD
Date:   Sat, 17 Aug 2019 11:41:22 -0700
Message-Id: <20190817184144.32179-3-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.28.g5f89f15d7b.dirty
In-Reply-To: <20190817184144.32179-1-newren@gmail.com>
References: <20190815214053.16594-1-newren@gmail.com>
 <20190817184144.32179-1-newren@gmail.com>
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
2.23.0.rc2.28.g5f89f15d7b.dirty

