Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 022331F404
	for <e@80x24.org>; Wed, 29 Aug 2018 07:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbeH2LBv (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 07:01:51 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39000 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbeH2LBv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 07:01:51 -0400
Received: by mail-yw1-f68.google.com with SMTP id m62-v6so1615024ywd.6
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 00:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CwsebXzJup/jHGGW0rFn9KoDy2zEZJ9wKKzO3GwW69o=;
        b=BkrCBzYkqXKQ1yRtc48igh6MsnYoUIWS8uTeQAnVXEp2V1YnTb/1YtibIvitmKCMCy
         9yHY9MYK6+c0H2t7OGylCqcQl4p6u0ktaKjAVhbQpwx1TXuE1axN2rAHQ/aUIsKPoW2Z
         IfKNFocCcKTXOZwufCj+MbCUitfG0YAuSsGZJtt4J2M3AOOCWDkkersxYOSrbgprths7
         M5/vrKRbNiDNA8CcDI+oFntrdptOcKqOljCyUu1EhmOBMM/9vhF2dP3fdI9iIjc6GUX2
         z8hQ3kwqBhds/ySWtmK4twe7YhH7E6VA1yszz0jnH2WE2WH6jXLRdDrWskzLlZuI1OJ7
         8bUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CwsebXzJup/jHGGW0rFn9KoDy2zEZJ9wKKzO3GwW69o=;
        b=OseAXBfOs4ACIEBYJ61Tcf6DuLXiwp3B6Xfk1mtdIKCPu03LQNOlYsdmx6sgBiq5ht
         A48GU3Cd/mHN8PwgNYA8rES6Jhg1fch6/dNyVSvVfXKJrlY3Qn61iCntXNt4bd1yH/M3
         Vusrzm9IX5/xFJuvYlNIlVY52mLh+QonBpxcMJZGteJXlHMozdrY/3lZ9MUgkd04wJll
         uRgQtCcqWvcofDz25FqRsEtcplhXNaH+x+zcNIHs2UpaZZCV+W3IzrBhb6lbA+d1s62q
         SBngnrOQysLtvb6L/BsFPSzE9Ab6wlLLSGqgVHlhCwhk47Y+AYlyGS3wX+KoD8dOHIEG
         Di5A==
X-Gm-Message-State: APzg51CvUtxZbNxJYrrCeCyjGtiypKYbUlW59SGZ7Nglqr+MB+C7hTte
        S3u2ICMMZbk2xeB2B2fXml/uU2ch
X-Google-Smtp-Source: ANB0VdbpjH4Q2rPUEsq3vaM4zrRt27qpL6+NYWpb2d/H681kq8DZo5jeXNdaQ+4+QuqpXeg6eVnlFQ==
X-Received: by 2002:a81:6904:: with SMTP id e4-v6mr2689225ywc.227.1535526384526;
        Wed, 29 Aug 2018 00:06:24 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id n6-v6sm1269794ywe.89.2018.08.29.00.06.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 00:06:24 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, corrmage@gmail.com, avarab@gmail.com,
        Johannes.Schindelin@gmx.de, sbeller@google.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 3/3] am: avoid directory rename detection when calling recursive merge machinery
Date:   Wed, 29 Aug 2018 00:06:13 -0700
Message-Id: <20180829070613.11793-4-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.12.g97a29da30a
In-Reply-To: <20180829070613.11793-1-newren@gmail.com>
References: <xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com>
 <20180829070613.11793-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's say you have the following three trees, where Base is from one commit
behind either master or branch:

   Base  : bar_v1, foo/{file1, file2, file3}
   branch: bar_v2, foo/{file1, file2},       goo/file3
   master: bar_v3, foo/{file1, file2, file3}

Using git-am (or am-based rebase) to apply the changes from branch onto
master results in the following tree:

   Result: bar_merged, goo/{file1, file2, file3}

This is not what users want; they did not rename foo/ -> goo/, they only
renamed one file within that directory.  The reason this happens is am
constructs fake trees (via build_fake_ancestor()) of the following form:

   Base_bfa  : bar_v1, foo/file3
   branch_bfa: bar_v2, goo/file3

Combining these two trees with master's tree:

   master: bar_v3, foo/{file1, file2, file3},

You can see that merge_recursive_generic() would see branch_bfa as renaming
foo/ -> goo/, and master as just adding both foo/file1 and foo/file2.  As
such, it ends up with goo/{file1, file2, file3}

The core problem is that am does not have access to the original trees; it
can only construct trees using the blobs involved in the patch.  As such,
it is not safe to perform directory rename detection within am -3.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/am.c                    | 1 +
 t/t3401-rebase-and-am-rename.sh | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 2fc2d1e82c..1494a9be84 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1596,6 +1596,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	o.branch1 = "HEAD";
 	their_tree_name = xstrfmt("%.*s", linelen(state->msg), state->msg);
 	o.branch2 = their_tree_name;
+	o.detect_directory_renames = 0;
 
 	if (state->quiet)
 		o.verbosity = 0;
diff --git a/t/t3401-rebase-and-am-rename.sh b/t/t3401-rebase-and-am-rename.sh
index a87df9e675..94bdfbd69c 100755
--- a/t/t3401-rebase-and-am-rename.sh
+++ b/t/t3401-rebase-and-am-rename.sh
@@ -152,7 +152,7 @@ test_expect_success 'rebase --interactive: NO directory rename' '
 	)
 '
 
-test_expect_failure 'rebase (am): NO directory rename' '
+test_expect_success 'rebase (am): NO directory rename' '
 	test_when_finished "git -C no-dir-rename rebase --abort" &&
 	(
 		cd no-dir-rename &&
@@ -190,7 +190,7 @@ test_expect_success 'rebase --merge: NO directory rename' '
 	)
 '
 
-test_expect_failure 'am: NO directory rename' '
+test_expect_success 'am: NO directory rename' '
 	test_when_finished "git -C no-dir-rename am --abort" &&
 	(
 		cd no-dir-rename &&
-- 
2.18.0.12.g97a29da30a

