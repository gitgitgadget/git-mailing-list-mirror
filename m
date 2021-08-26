Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACAFC4320E
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 21:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 551D760EE5
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 21:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243626AbhHZVBH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 17:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243614AbhHZVBE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 17:01:04 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCABC0613C1
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 14:00:16 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b7so6658778edu.3
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 14:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VRGE+vejbJYxOysILJDGLQN8MZpRmXDaO3vCDFqWDZY=;
        b=bJ+n3unQxl1nDdqK5qif35iEyFiq8rIdtLZn8BC4c1qpyK0Sn+K4hTo61FyvfSgFtK
         lYGvAeNuWXk+J0IGWt5i/bU77xdgQ1AZF920dobzR6QoV4cQDepyGzmvPofwuS5oG36h
         hUDhlu5NhCNcuILScMu2B+hj0OgjtwqK/qTnjI9UGO8TK6Dw0h5VAAbeZ19Oiw2FMgxx
         q6dQUjXUiAeq43eBicLoXgb3oEul86PFM7exYGCEtCI0NQLhcvPf07GKHMbUd3fPAy2t
         jAd9z7xAgWi+4TynFJUrbHf/2vOWV9+pk5lvK96zdl2hGKLBTIjMwjndgV87V5XF0RKZ
         TVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VRGE+vejbJYxOysILJDGLQN8MZpRmXDaO3vCDFqWDZY=;
        b=cUZokwb8SmBUO0Ob03qH7SPLMM2PChl4q1TweXstAOXwmUeLVp6ByURD/kvFWsP3GK
         1CCSWWrTkaHETI8qwzSUWAjUnY7MLOuTG4hHncs/As9zRDwl7tHXUJkGAHpr/qrmjMCG
         eJeZixEoBO9822IDJF51S/r7IZSpyNzg9Xsh0nA+zy1VN+n8tTQEBwmuCi3Ec119CCuL
         VEA8evgdbPh+Rtbofu9qibdvpzLZC/nxp9FdtwZjiyc/m221Wm1Sb7HcKBtkEjnpBW8f
         cF/6gVCmy9DkBQnBw7tDTfCjzLvb2Lb4YhdqK/1k6iPeQ95eO95hAf54v39BejmLZf3w
         1v7A==
X-Gm-Message-State: AOAM5328pEy1NEEbwjMiP/QlVummOpfEntFuAHafG+nWst5guYLYg9NQ
        HWsNW790rb6PLjI9O5T4NAoRqIsCxDQ=
X-Google-Smtp-Source: ABdhPJzE6dFdlFwVO9EWm2Fr3FNq6eaMbYpYhXpgl8UPl1kbz6Dz7weVu8bpaSaHUxTv0rW4YVM1iQ==
X-Received: by 2002:aa7:d6d1:: with SMTP id x17mr6345497edr.64.1630011615302;
        Thu, 26 Aug 2021 14:00:15 -0700 (PDT)
Received: from localhost.localdomain (84-236-78-211.pool.digikabel.hu. [84.236.78.211])
        by smtp.gmail.com with ESMTPSA id q14sm1884779ejc.93.2021.08.26.14.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 14:00:15 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 4/6] read-cache: look for shared index files next to the index, too
Date:   Thu, 26 Aug 2021 23:00:02 +0200
Message-Id: <20210826210004.672860-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.33.0.358.g803110d36e
In-Reply-To: <20210826210004.672860-1-szeder.dev@gmail.com>
References: <20210817174938.3009923-1-szeder.dev@gmail.com>
 <20210826210004.672860-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When reading a split index git always looks for its referenced shared
base index in the gitdir of the current repository, even when reading
an alternate index specified via GIT_INDEX_FILE, and even when that
alternate index file is the "main" '.git/index' file of an other
repository.  However, if that split index and its referenced shared
index files were written by a git command running entirely in that
other repository, then, naturally, the shared index file is written to
that other repository's gitdir.  Consequently, a git command
attempting to read that shared index file while running in a different
repository won't be able find it and will error out.

I'm not sure in what use case it is necessary to read the index of one
repository by a git command running in a different repository, but it
is certainly possible to do so, and in fact the test 'bare repository:
check that --cached honors index' in 't0003-attributes.sh' does
exactly that.  If GIT_TEST_SPLIT_INDEX=1 were to split the index in
just the right moment [1], then this test would indeed fail, because
the referenced shared index file could not be found.

Let's look for the referenced shared index file not only in the gitdir
of the current directory, but, if the shared index is not there, right
next to the split index as well.

[1] We haven't seen this issue trigger a failure in t0003 yet,
    because:

      - While GIT_TEST_SPLIT_INDEX=1 is supposed to trigger index
        splitting randomly, the first index write has always been
        deterministic and it has never split the index.

      - That alternate index file in the other repository is written
        only once in the entire test script, so it's never split.

    However, the next patch will fix GIT_TEST_SPLIT_INDEX, and while
    doing so it will slightly change its behavior to always split the
    index already on the first index write, and t0003 would always
    fail without this patch.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 read-cache.c           | 14 +++++++++++++-
 t/t1700-split-index.sh | 23 +++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 9048ef9e90..fbd59886a3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2391,9 +2391,21 @@ int read_index_from(struct index_state *istate, const char *path,
 	base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_oid_hex);
 	trace2_region_enter_printf("index", "shared/do_read_index",
 				   the_repository, "%s", base_path);
-	ret = do_read_index(split_index->base, base_path, 1);
+	ret = do_read_index(split_index->base, base_path, 0);
 	trace2_region_leave_printf("index", "shared/do_read_index",
 				   the_repository, "%s", base_path);
+	if (!ret) {
+		char *path_copy = xstrdup(path);
+		const char *base_path2 = xstrfmt("%s/sharedindex.%s",
+						 dirname(path_copy),
+						 base_oid_hex);
+		free(path_copy);
+		trace2_region_enter_printf("index", "shared/do_read_index",
+					   the_repository, "%s", base_path2);
+		ret = do_read_index(split_index->base, base_path2, 1);
+		trace2_region_leave_printf("index", "shared/do_read_index",
+					   the_repository, "%s", base_path2);
+	}
 	if (!oideq(&split_index->base_oid, &split_index->base->oid))
 		die(_("broken index, expect %s in %s, got %s"),
 		    base_oid_hex, base_path,
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 986baa612e..e2aa0bd949 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -510,4 +510,27 @@ test_expect_success 'do not refresh null base index' '
 	)
 '
 
+test_expect_success 'reading split index at alternate location' '
+	git init reading-alternate-location &&
+	(
+		cd reading-alternate-location &&
+		>file-in-alternate &&
+		git update-index --split-index --add file-in-alternate
+	) &&
+	echo file-in-alternate >expect &&
+
+	# Should be able to find the shared index both right next to
+	# the specified split index file ...
+	GIT_INDEX_FILE=./reading-alternate-location/.git/index \
+	git ls-files --cached >actual &&
+	test_cmp expect actual &&
+
+	# ... and, for backwards compatibility, in the current GIT_DIR
+	# as well.
+	mv -v ./reading-alternate-location/.git/sharedindex.* .git &&
+	GIT_INDEX_FILE=./reading-alternate-location/.git/index \
+	git ls-files --cached >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.33.0.358.g803110d36e

