Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C6F51F4B6
	for <e@80x24.org>; Tue, 16 Jul 2019 14:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733223AbfGPOX1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 10:23:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50347 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbfGPOX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 10:23:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so18887793wml.0
        for <git@vger.kernel.org>; Tue, 16 Jul 2019 07:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SDuxlQOMTIZF+HADWIa7Xwf7uDphhKTodqHz9W1rUZU=;
        b=fq0y8OIviF5bfxLvuE+eEKhokqTBonawWN4jE2y7MJIm9Dp7anrMT7xhlTaTwTp5UK
         ozq0NdDEmPGMajS+RiWQTiIUn2aF9NdPA1lKonnR7dTRFXrAuKsM9iqBUYTmKKEJgJwS
         O7PtiAwp8tN9xbD8izPCwDf6oGvIhgb3vLcEXSDm+ZIkcfrRiVHoodcs/q7Rj9niV2fE
         51sLn3H0ixWgtgUBk7ZagOLak30o/2V+UGelkWBn4lo7bxpuFwBQqF6OpktAvxGmnLjV
         Rqw2mDsPi7sBHG2kFwqQ3aQu+f3vVL5um2UFtF1hnEOnB9N482CuJeHautFk4EjMkVBL
         HFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SDuxlQOMTIZF+HADWIa7Xwf7uDphhKTodqHz9W1rUZU=;
        b=o1gb2z2UhrVSeZODzmZhVV3FTLJ9fQxf/xO+fuhhGw8vHqjKT5sdZV6NgJGTK8VPot
         7h4GEn8IQKLRbb9PVj3IO3A6ezpbrbFeSiSftNnE3yN4ff9eaSzWR3MkLk8lwtknNg1a
         nqzUGhE8PTf4P2UOJXCM6Kgvj3WWhW1D0T97Vn2snF2nJ6SSraxPz7GuZFBB5lro5glm
         9NeXVxndZv0Pl2MdCM4bFY2in863uGMtqdVwIQgmpe4Tx0lfhCPslm39vyFOYHEL+iMw
         SR/K4qSLhfJLk9URFQIqSpnDovkLjh3qzJ1AD7rAeRy/W5NKqLMKsjAysEtTBQBldEAf
         t2PQ==
X-Gm-Message-State: APjAAAUKoWGSHJoGdzQaRSUXrNuOYi7NReroRU0mxlMO4KckntS5BYMc
        MpkDZxvdC17mnc3ddp2pKrr1LKlRZIRN2w==
X-Google-Smtp-Source: APXvYqwYk9rbtblL0R41OyPiw7cbMEJ1x6+NPgQ1d6tE5GaWXObBWMGWaPWrJUGABNGwgDKApk5LWg==
X-Received: by 2002:a05:600c:2218:: with SMTP id z24mr30906557wml.84.1563287004231;
        Tue, 16 Jul 2019 07:23:24 -0700 (PDT)
Received: from localhost (host145-110-dynamic.14-87-r.retail.telecomitalia.it. [87.14.110.145])
        by smtp.gmail.com with ESMTPSA id f12sm21826862wrg.5.2019.07.16.07.23.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 07:23:23 -0700 (PDT)
Date:   Tue, 16 Jul 2019 15:23:22 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Martin Nicolay <m.nicolay@osm-ag.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] stash: fix handling removed files with --keep-index
Message-ID: <20190716142322.GH15477@hank.intra.tgummerer.com>
References: <alpine.LSU.2.20.1907111452560.3570@cpza.bfz-tzou.qr>
 <20190711174828.GF15477@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711174828.GF15477@hank.intra.tgummerer.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git stash push --keep-index is supposed to keep all changes that have
been added to the index, both in the index and on disk.

Currently this doesn't behave correctly when a file is removed from
the index.  Instead of keeping it deleted on disk, --keep-index
currently restores the file.

Fix that behaviour by using 'git checkout' in no-overlay mode which
can faithfully restore the index and working tree.  This also
simplifies the code.

Note that this will overwrite untracked files if the untracked file
has the same name as a file that has been deleted in the index.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

This would be the version using 'git checkout' instead of 'git
restore'.  Still not doing everything in-core though, as mentioned in
the previous email.

 builtin/stash.c  | 32 +++++++++-----------------------
 t/t3903-stash.sh |  7 +++++++
 2 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index fde6397caa..b5a301f24d 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1391,30 +1391,16 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 		}
 
 		if (keep_index == 1 && !is_null_oid(&info.i_tree)) {
-			struct child_process cp_ls = CHILD_PROCESS_INIT;
-			struct child_process cp_checkout = CHILD_PROCESS_INIT;
-			struct strbuf out = STRBUF_INIT;
-
-			if (reset_tree(&info.i_tree, 0, 1)) {
-				ret = -1;
-				goto done;
-			}
-
-			cp_ls.git_cmd = 1;
-			argv_array_pushl(&cp_ls.args, "ls-files", "-z",
-					 "--modified", "--", NULL);
-
-			add_pathspecs(&cp_ls.args, ps);
-			if (pipe_command(&cp_ls, NULL, 0, &out, 0, NULL, 0)) {
-				ret = -1;
-				goto done;
-			}
+			struct child_process cp = CHILD_PROCESS_INIT;
 
-			cp_checkout.git_cmd = 1;
-			argv_array_pushl(&cp_checkout.args, "checkout-index",
-					 "-z", "--force", "--stdin", NULL);
-			if (pipe_command(&cp_checkout, out.buf, out.len, NULL,
-					 0, NULL, 0)) {
+			cp.git_cmd = 1;
+			argv_array_pushl(&cp.args, "checkout", "--no-overlay",
+					 oid_to_hex(&info.i_tree), "--", NULL);
+			if (!ps->nr)
+				argv_array_push(&cp.args, ":/");
+			else
+				add_pathspecs(&cp.args, ps);
+			if (run_command(&cp)) {
 				ret = -1;
 				goto done;
 			}
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index b22e671608..b8e337893f 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1234,4 +1234,11 @@ test_expect_success 'stash works when user.name and user.email are not set' '
 	)
 '
 
+test_expect_success 'stash --keep-index with file deleted in index does not resurrect it on disk' '
+	test_commit to-remove to-remove &&
+	git rm to-remove &&
+	git stash --keep-index &&
+	test_path_is_missing to-remove
+'
+
 test_done
-- 
2.22.0.599.gf5cf68d754
