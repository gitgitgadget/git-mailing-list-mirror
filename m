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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B68C43214
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97ECB60FE6
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhHQRuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 13:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbhHQRuj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 13:50:39 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9791DC0613C1
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:50:05 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id b15so40192672ejg.10
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8H7d17Xlz7rxX/Abmc48F3/xo3gCQ26PatkHtxy9xbA=;
        b=U/aRvOgwkr9WCgNZFW9DApHq0LpxM5mS7QwskMul1kFLZV99KY32wL3xe7bo1xYAnq
         D596Ti+j0pN80BgSW11f/VtBjyotiZktC4prWzH5Ks1mqNy1KLnS5aANRq9oJQO65rpA
         yXmrIMUP27gGfznXHA/T01RbJ8+yNFtMCL1sTIUuTgSD8423LpxE2XPZrylBOUrrIxW9
         vCwo6nT5EbX8u5cp9XWTdmMsAS1Ta3bmV0FRaYXqMvJxr/r5XT/3REVQ3z/g3r1liMVM
         Uub/K6bs7pGer0ZmR3zdNMK8fERTsjoQBQ0tqo2c/sLf5sA7xSz3w85+JfxjuB5LTY9u
         Q3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8H7d17Xlz7rxX/Abmc48F3/xo3gCQ26PatkHtxy9xbA=;
        b=Q1pJ8W7N2DGVrQMZ08+hQ1iWraL+9kRSS+Cca7ux+7prA5tDbiKFfIzlpsVr7I6zpE
         AVrijEEDm8ZhJZ/ROFxIk8LWWs9R1//qErvCn+t/sPadXb91cVqgwXkuodTVjxG7n+94
         CFH6xehp0ky2orhlQiTTP7Ipm8oSZZGlen2FHDpopPjTHa8jw5gCyP8/gbt4YOg9y/sd
         tQpkX5M5YVvj+PwcK5wWW+TrGTLKFEj31KKWCyMtW1hjsOgl5+EnluR+gpQUSv290EMk
         3ndvga83yRibD6cxzqepRXuo8h2W0NzuOn5d/aY2X6RuuiEMkSO8V6wQcwi6CtlCTaYL
         zQuQ==
X-Gm-Message-State: AOAM531J9w9UQSl72M4yDNDcAqoEvtI4sNtSoQpT7ISppL+rpFS7cnGN
        jfX9x7iTJyOmVwSFbqHiLX5RnrDzI5s=
X-Google-Smtp-Source: ABdhPJzJIwT0VoSc3TT9ENHwlC7rDqyPxZGQvztB5bwAps3m09NWiblEo6QBKErwPNSI4FYaVXN8Lw==
X-Received: by 2002:a17:906:858d:: with SMTP id v13mr5185741ejx.424.1629222604222;
        Tue, 17 Aug 2021 10:50:04 -0700 (PDT)
Received: from localhost.localdomain (78-131-17-78.pool.digikabel.hu. [78.131.17.78])
        by smtp.gmail.com with ESMTPSA id p23sm1375240edt.71.2021.08.17.10.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 10:50:04 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 4/6] read-cache: look for shared index files next to the index, too
Date:   Tue, 17 Aug 2021 19:49:36 +0200
Message-Id: <20210817174938.3009923-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.33.0.453.gc5e41af357
In-Reply-To: <20210817174938.3009923-1-szeder.dev@gmail.com>
References: <20210817174938.3009923-1-szeder.dev@gmail.com>
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
2.33.0.453.gc5e41af357

