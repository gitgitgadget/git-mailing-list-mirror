Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 680F91F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 11:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfKMLRZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 06:17:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42389 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbfKMLRY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 06:17:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id a15so1878441wrf.9
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 03:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zcqpLyNxv3/vZdvB7akp9UewCUxp/WrtSwBtcElP3AY=;
        b=RSuc+JRAW8Kkb7YPhUFhJuQAmUeKikdn1D/6hfZzOn5jHLXMKUsxARoYwVZ/yEEXKm
         JmYwBU3V+vHlPETntPxhl3hFvFRbktDbCiMGbZQsZxkK7Zmtk7epbuxpWSmgfIbl8SMq
         BqPmAXpHvyDLVzxpQUDvOCpiPCfrrthHIVY+iEvB7tfEmnS2+b4OIi48lGEGdguxhGjv
         tPsX/Ihhw/UZT928HXHGLfxdL34l51Q6S/sGjaZM09B3rCg7NqM7LQi3bQvQZBCaIBBx
         85NYL1nVX45zm4NNloEXfKf4Tf8Bh+q7QddxDICuMbA9/hRQ3bpWJYRTvwogONFfj7k4
         r/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zcqpLyNxv3/vZdvB7akp9UewCUxp/WrtSwBtcElP3AY=;
        b=OjkPm5gCGdtrjieRXiCYLdJhfdMeJgVrzzxgqr7C80PA7MEv23C7jOaggHE2WMlZ2E
         +ZRy+X8tMRSvn9iF0Z47wJO/VL9EEXWY89412A368W91KEDWsH9QQRv1dwgHolwX01DM
         P2gmyDDlZydI0mCiloHExFgeshTFL0xV+6+ztQvwO/kjhxV67eiR3ZhDai7b7Cvbj746
         ohISKkBaQM3ujzfwq2wcfrHwZRqAcj0tqViKFoNdKVhdrHtxUgsDZeBxDBl+29xZtPeK
         dLMy5BaLR7bnG8ru23/I//Qj003QcJguP4aqbbIwK2H9ml7hDWVYrRBQDBkUiwPv3pxA
         GFHA==
X-Gm-Message-State: APjAAAXnoyCTgrSFtCZKS8ZNFbYireo69RHeDQau0DjRYr3xv8NqweAr
        n+jtdvScEtXnM3VNChrd66rAaKkbukE=
X-Google-Smtp-Source: APXvYqx85C5MastGfKKcmo3vqTf05FE0zyct2QpexjvS84U7bKS7hsqHg9QewASmPKRBS78MC5Hfww==
X-Received: by 2002:a5d:6350:: with SMTP id b16mr2387567wrw.357.1573643841773;
        Wed, 13 Nov 2019 03:17:21 -0800 (PST)
Received: from localhost ([62.253.227.125])
        by smtp.gmail.com with ESMTPSA id t133sm7288883wmb.1.2019.11.13.03.17.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Nov 2019 03:17:21 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Grzegorz Rajchman <rayman17@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 2/2] stash: make sure we have a valid index before writing it
Date:   Wed, 13 Nov 2019 11:17:18 +0000
Message-Id: <20191113111718.21412-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.24.0.155.gd9f6f3b619
In-Reply-To: <20191113111718.21412-1-t.gummerer@gmail.com>
References: <20191111195641.GC3115@cat>
 <20191113111718.21412-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 'do_apply_stash()' we refresh the index in the end.  Since
34933d0eff ("stash: make sure to write refreshed cache", 2019-09-11),
we also write that refreshed index when --quiet is given to 'git stash
apply'.

However if '--index' is not given to 'git stash apply', we also
discard the index in the else clause just before.  We need to do so
because we use an external 'git update-index --add --stdin', which
leads to an out of date in-core index.

Later we call 'refresh_and_write_cache', which now leads to writing
the discarded index, which means we essentially write an empty index
file.  This is obviously not correct, or the behaviour the user
wanted.  We should not modify the users index without being asked to
do so.

Make sure to re-read the index after discarding the current in-core
index, to avoid dealing with outdated information.  Instead we could
also drop the 'discard_cache()' + 'read_cache()', however that would
make it easy to fall into the same trap as 34933d0eff did, so it's
better to avoid that.

We can also drop the 'refresh_and_write_cache' completely in the quiet
case.  Previously in legacy stash we relied on 'git status' to refresh
the index after calling 'git read-tree' when '--index' was passed to
'git apply'.  However the 'reset_tree()' call that replaced 'git
read-tree' always passes options that are equivalent to '-m', making
the refresh of the index unnecessary.

Reported-by: Grzegorz Rajchman <rayman17@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/stash.c  | 7 +++----
 t/t3903-stash.sh | 7 ++++++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index ab30d1e920..372fbdb7ac 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -481,13 +481,12 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 		if (ret)
 			return -1;
 
+		/* read back the result of update_index() back from the disk */
 		discard_cache();
+		read_cache();
 	}
 
-	if (quiet) {
-		if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
-			warning("could not refresh index");
-	} else {
+	if (!quiet) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 
 		/*
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index db7cc6e664..0157771e24 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -263,8 +263,11 @@ test_expect_success 'save -q is quiet' '
 	test_must_be_empty output.out
 '
 
-test_expect_success 'pop -q is quiet' '
+test_expect_success 'pop -q works and is quiet' '
 	git stash pop -q >output.out 2>&1 &&
+	echo bar >expect &&
+	git show :file >actual &&
+	test_cmp expect actual &&
 	test_must_be_empty output.out
 '
 
@@ -273,6 +276,8 @@ test_expect_success 'pop -q --index works and is quiet' '
 	git add file &&
 	git stash save --quiet &&
 	git stash pop -q --index >output.out 2>&1 &&
+	git diff-files file2 >file2.diff &&
+	test_must_be_empty file2.diff &&
 	echo foo >expect &&
 	git show :file >actual &&
 	test_cmp expect actual &&
-- 
2.24.0.155.gd9f6f3b619

