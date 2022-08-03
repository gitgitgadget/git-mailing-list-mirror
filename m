Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33617C19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 04:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbiHCEv4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 00:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHCEvw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 00:51:52 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B653DFD2
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 21:51:48 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id u133so8794073pfc.10
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 21:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GbMtIN7CsnhBPR+4zS7TVgnlzrUAp+IhVUnvo90SnK8=;
        b=iqU6OZXyFPnSkRNCYSm31miszyyW2zYnkT1Zi7DQH2FWgLBimKi/9dv/cU70rYnlMK
         HPvhGC8s7rs6GmHoOLoT3M6/ys4rsY0HPMyycK+Eph2rP4W5J27afpo66OhSPkiVtvxg
         C9EI9c3BopkEYpJLTQjRU3B+2WyV6cB/5VZADs8BGycD99SOpVKIE8Qmw/tLVpMv52hH
         PqaHIRT3QGmUBHOA0Zoiylf8zc7DWdZC4hokO9zFg7XVyWITE2WZ29Nnatx+uR+Bblk+
         zfZQIe5jMIXbTuJG+stukqd7DRDMJBg0/D1dk9QJVsoUiLqc9bEBuL0HdSOcj7NOXGvc
         s58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GbMtIN7CsnhBPR+4zS7TVgnlzrUAp+IhVUnvo90SnK8=;
        b=ZIGRGvZ++sRrvOb9uV2MNPlj6ht2o3LU1BlFRN7rUn7IX3mAs1rA0cBkVg3rG5UPWm
         QQFMM2CH9F2MnPMrNl1nM2EgE/9BZ6zjJ2h8VYXkzrRm+DHUOK/mlG/pIuHhk6PxQuKE
         Rfco284718JEt9cdodGtXyQeMQxphnDn5IlhPwqurfetnfeHBE4YLKARHifSmGwfZMgC
         ylU92lWR2BYnvCr0OYZ5NOwTCbWUDFRdZhHwVp39M7x1w9kVfXWswBpPSGjAQfuGGGLf
         HfZNEMUuUBLkQ4rIZymcNY1FOsZd73IOn98iBsmpyL4zILHSm4TLaZa1jB5wQwe9xH/U
         x5cA==
X-Gm-Message-State: ACgBeo0iIauDOfJE1H4wlx7f+L/Qkx/roYA6ftpr3qhNjB24EkVjj/4k
        oxmSWPMie5rhYcPP9fXKD9IrXSbB9/4u0Sdh
X-Google-Smtp-Source: AA6agR5tdn4NdiYOx1R23P5VO+cUjNGWGMttzclZDDpptbnutrNiFeoqXLpwRDU8EWYu6GdHlk30Og==
X-Received: by 2002:a62:cd8c:0:b0:52d:a632:a8e0 with SMTP id o134-20020a62cd8c000000b0052da632a8e0mr10050412pfg.52.1659502307500;
        Tue, 02 Aug 2022 21:51:47 -0700 (PDT)
Received: from ffyuanda.localdomain ([113.65.228.71])
        by smtp.gmail.com with ESMTPSA id f131-20020a623889000000b0052e2a1edab8sm470211pfa.24.2022.08.02.21.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 21:51:47 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v1 4/4] rm: integrate with sparse-index
Date:   Wed,  3 Aug 2022 12:51:18 +0800
Message-Id: <20220803045118.1243087-5-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
References: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Enable the sparse index within the `git-rm` command.

The `p2000` tests demonstrate a ~96% execution time reduction for
'git rm' using a sparse index.

Test                                     before  after
-------------------------------------------------------------
2000.74: git rm -f f2/f4/a (full-v3)     0.66    0.88 +33.0%
2000.75: git rm -f f2/f4/a (full-v4)     0.67    0.75 +12.0%
2000.76: git rm -f f2/f4/a (sparse-v3)   1.99    0.08 -96.0%
2000.77: git rm -f f2/f4/a (sparse-v4)   2.06    0.07 -96.6%

Also, normalize a behavioral difference of `git-rm` under sparse-index.
See related discussion [1].

`git-rm` a sparse-directory entry within a sparse-index enabled repo
behaves differently from a sparse directory within a sparse-checkout
enabled repo.

For example, in a sparse-index repo, where 'folder1' is a
sparse-directory entry, `git rm -r --sparse folder1` provides this:

        rm 'folder1/'

Whereas in a sparse-checkout repo *without* sparse-index, doing so
provides this:

        rm 'folder1/0/0/0'
        rm 'folder1/0/1'
        rm 'folder1/a'

Because `git rm` a sparse-directory entry does not need to expand the
index, therefore we should accept the current behavior, which is faster
than "expand the sparse-directory entry to match the sparse-checkout
situation".

Modify a previous test so such difference is not considered as an error.

[1] https://github.com/ffyuanda/git/pull/6#discussion_r934861398

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/rm.c                             | 2 ++
 t/perf/p2000-sparse-operations.sh        | 1 +
 t/t1092-sparse-checkout-compatibility.sh | 6 +++---
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 58ed924f0d..b6ba859fe4 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -287,6 +287,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (!index_only)
 		setup_work_tree();
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 
 	if (read_cache() < 0)
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index c181110a43..853513eb9b 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -123,5 +123,6 @@ test_perf_on_all git blame $SPARSE_CONE/f3/a
 test_perf_on_all git read-tree -mu HEAD
 test_perf_on_all git checkout-index -f --all
 test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
+test_perf_on_all git rm -f $SPARSE_CONE/a
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 75649e3265..58632fe483 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -912,7 +912,7 @@ test_expect_success 'read-tree --prefix' '
 	test_all_match git read-tree --prefix=deep/deeper1/deepest -u deepest &&
 	test_all_match git status --porcelain=v2 &&
 
-	test_all_match git rm -rf --sparse folder1/ &&
+	run_on_all git rm -rf --sparse folder1/ &&
 	test_all_match git read-tree --prefix=folder1/ -u update-folder1 &&
 	test_all_match git status --porcelain=v2 &&
 
@@ -1870,7 +1870,7 @@ test_expect_success 'rm pathspec inside sparse definition' '
 	test_all_match git status --porcelain=v2
 '
 
-test_expect_failure 'rm pathspec outside sparse definition' '
+test_expect_success 'rm pathspec outside sparse definition' '
 	init_repos &&
 
 	for file in folder1/a folder1/0/1
@@ -1910,7 +1910,7 @@ test_expect_failure 'rm pathspec outside sparse definition' '
 	test_sparse_match git status --porcelain=v2
 '
 
-test_expect_failure 'sparse index is not expanded: rm' '
+test_expect_success 'sparse index is not expanded: rm' '
 	init_repos &&
 
 	ensure_not_expanded rm deep/a &&
-- 
2.37.0

