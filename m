Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AB3920248
	for <e@80x24.org>; Wed, 10 Apr 2019 02:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfDJCN0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 22:13:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46394 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfDJCNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 22:13:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id y6so358916pll.13
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 19:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J6pvJyAVVkdi2nWzGxuznoVHl8qMv+EJV5RdSVqHEUA=;
        b=SBuECwnNKr3A+vnUBMMOB5UpfiEIp0gX27WTO8u5ntGRHKcwQIZ3t/XXApRZ3foEbd
         +u4z30sTx3Fe7qwzYIaFWFdLaxGDsYkkT+d4m0oZUKl5tVQwA9uc4HFC/40R6qw1D8aE
         NGg3riPzMKY2gd2oFrVnJ/GlKpsVGriT4HZV7xkdFQwbHeGUO+H9etDBH0lef7x/bSoh
         +Jw1ygWZCLM/+sSU0gn1JOch9lEpxNEoSWJunKTjGMiNucn0wNA8D8iSzNjmbDPGUZAm
         sEJ+OAfjBBi/nq5bw/u77sL+ZnSdAuc7HrO7vKHTQm6bEj2jDLn72W6+HVw/VTbKC1lR
         1zlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J6pvJyAVVkdi2nWzGxuznoVHl8qMv+EJV5RdSVqHEUA=;
        b=ms/B378d7sMzNnR6QNMwbjMz9fZuzEou5GLnxrGYIb/GRVTKgFVi4Xxa+XTRV+bnYj
         ylghfI2IPIEuULzetW/i+V0TEZa8zYuNbu+jie9YpgTRNEkt94Pr4FV1TRgjArLCe4iV
         1j21t2JC2eY5H+NrgbqvNyROBSuky/g9D543MsIV1cVoAp4pAopYW6e0sFqNCioUB61H
         1ew72ZtLjK5Xq1zfhZhBylF5teLlRcWyt/1JKMqtxBhmpjHAHolGCFcyF7Ss4t6QKeKR
         L3ZfeiOoaFgmWi2pXWKhvaKAHRp4dEHCUi7Kq8IMK8IdjKp2wBdkTLKLH8dwltMjjWVO
         AE5g==
X-Gm-Message-State: APjAAAXJ7XBVs6rirVYdx0TPZJdplreCDfBHHWyC+vbFykx/y6A1UGhN
        ZlFSKrpzvam5xmdBQSSTr2wonocmCQBbST/p
X-Google-Smtp-Source: APXvYqxdcirh0BXBCOOYycOe/YqYwdhdW78AyAf2wzIU10wB//sLjidL5XDEqWjSrUz9VYTf98EWHg==
X-Received: by 2002:a17:902:b948:: with SMTP id h8mr40673218pls.39.1554862404176;
        Tue, 09 Apr 2019 19:13:24 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:c47d:9491:9418:887])
        by smtp.gmail.com with ESMTPSA id g2sm50284156pfd.134.2019.04.09.19.13.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 19:13:23 -0700 (PDT)
Date:   Tue, 9 Apr 2019 19:13:23 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, peff@peff.net,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v2 6/7] rev-list: let traversal die when --missing is not in
 use
Message-ID: <88ca5dfe68c4cdb558aff6e90a525ec06f15dbd6.1554861974.git.me@ttaylorr.com>
References: <cover.1554435033.git.me@ttaylorr.com>
 <cover.1554861974.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554861974.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Commit 7c0fe330d5 (rev-list: handle missing tree objects properly,
2018-10-05) taught the traversal machinery used by git-rev-list to
ignore missing trees, so that rev-list could handle them itself.

However, it does so only by checking via oid_object_info_extended() that
the object exists at all. This can miss several classes of errors that
were previously detected by rev-list:

  - type mismatches (e.g., we expected a tree but got a blob)

  - failure to read the object data (e.g., due to bitrot on disk)

This is especially important because we use "rev-list --objects" as our
connectivity check to admit new objects to the repository, and it will
now miss these cases (though the bitrot one is less important here,
because we'd typically have just hashed and stored the object).

There are a few options to fix this:

 1. we could check these properties in rev-list when we do the existence
    check. This is probably too expensive in practice (perhaps even for
    a type check, but definitely for checking the whole content again,
    which implies loading each object into memory twice).

 2. teach the traversal machinery to differentiate between a missing
    object, and one that could not be loaded as expected. This probably
    wouldn't be too hard to detect type mismatches, but detecting bitrot
    versus a truly missing object would require deep changes to the
    object-loading code.

 3. have the traversal machinery communicate the failure to the caller,
    so that it can decide how to proceed without re-evaluting the object
    itself.

Of those, I think (3) is probably the best path forward. However, this
patch does none of them. In the name of expediently fixing the
regression to a normal "rev-list --objects" that we use for connectivity
checks, this simply restores the pre-7c0fe330d5 behavior of having the
traversal die as soon as it fails to load a tree (when --missing is set
to MA_ERROR, which is the default).

Note that we can't get rid of the object-existence check in
finish_object(), because this also handles blobs (which are not
otherwise checked at all by the traversal code).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-list.c                     | 4 +++-
 t/t6102-rev-list-unexpected-objects.sh | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 425a5774db..9f31837d30 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -379,7 +379,6 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	repo_init_revisions(the_repository, &revs, prefix);
 	revs.abbrev = DEFAULT_ABBREV;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
-	revs.do_not_die_on_missing_tree = 1;
 
 	/*
 	 * Scan the argument list before invoking setup_revisions(), so that we
@@ -409,6 +408,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (arg_missing_action)
+		revs.do_not_die_on_missing_tree = 1;
+
 	argc = setup_revisions(argc, argv, &revs, &s_r_opt);
 
 	memset(&info, 0, sizeof(info));
diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
index e3ec195532..28ee1bcb07 100755
--- a/t/t6102-rev-list-unexpected-objects.sh
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -30,7 +30,7 @@ test_expect_success 'setup unexpected non-tree entry' '
 	broken_tree="$(git hash-object -w --literally -t tree broken-tree)"
 '
 
-test_expect_failure 'traverse unexpected non-tree entry (lone)' '
+test_expect_success 'traverse unexpected non-tree entry (lone)' '
 	test_must_fail git rev-list --objects $broken_tree
 '
 
@@ -63,7 +63,7 @@ test_expect_success 'setup unexpected non-tree root' '
 		broken-commit)"
 '
 
-test_expect_failure 'traverse unexpected non-tree root (lone)' '
+test_expect_success 'traverse unexpected non-tree root (lone)' '
 	test_must_fail git rev-list --objects $broken_commit
 '
 
-- 
2.21.0.203.g358da99528

