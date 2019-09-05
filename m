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
	by dcvr.yhbt.net (Postfix) with ESMTP id A1FB01F461
	for <e@80x24.org>; Thu,  5 Sep 2019 15:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732921AbfIEPrr (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 11:47:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40754 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732587AbfIEPrq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 11:47:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so2012612pfb.7
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 08:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UfggoI4hiwPuvKtkekoszKGwBR80GvMJUVuwpGpu10w=;
        b=dDt84Mq9iNjP7QvxJ0SQynOcbCfIZXZ4pw8rsS9H/eh87OKV+clQqTLkowfL14QxrK
         /roscU9ho2xsRVeM68cfleR1UQ3RRcvWcqolbFFEJg4Sb/53X/Vz4pQqG/Y6OZLNux0b
         UgL/AjXOz67n4umRxGzKUH2/Lk++3yhHfXr3gEu8Fvt5hF8W3Qz6/jVTTI7MzxZ5FRvQ
         7nCD209nsquSfJwo5yV1R4CP0X5ilwwszRLBOS5uZ8z795Wu24XqAGX8YqBVfkOZMC+F
         GMzU5GoSIyRDs3TOlqWPufL9FhulHonS9wTykrWyYYQzqWdIiMV5Q71RMWIMZv4U2kss
         vFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UfggoI4hiwPuvKtkekoszKGwBR80GvMJUVuwpGpu10w=;
        b=KC3t+WzkZcEkWgknnPouPomYF5sSe2sm4PgRRafa0P1wwEfZdV/mQRMhHylTGZk2W2
         MaibFKOzsYnYLS7EtYO7+t3GMWelMyjwk7bvmIh2+CfMN6fJ5mQbC8m+MZkSzq/BXxoL
         5mo5off1sLvrLVxEYmikFYL6Fa/uXSCSVjk38SzqD+aQxLhmpamoYbKSdder8I4TiYmM
         26LMTtgiSvy69nId6LqiHrpNw5CPphfdQvgJPPmH++CckPvaKLjOhFdJhDp93U6m8slv
         8Q2+yIgR7FNb7/QNLHrebgYRdZhVP0HRsYX7f+4l1KDJVb+2t6oKcd0KZznJM3OMS+9d
         3RJA==
X-Gm-Message-State: APjAAAVdTeq6KSnh6qIG/DKsrTT/cTFNe9RC+tfFSMxBymhjFAK7m0Hr
        qTpD08hi0VrpPENMVuTE4nDz2VIJ
X-Google-Smtp-Source: APXvYqzoNKa2wXx4z6QbOeqb5aW7AbZFS6L6m1TGq5fy2iKAZ3KetiGsTYpYpK/22VcnY1MWUIZfGA==
X-Received: by 2002:a63:70d:: with SMTP id 13mr3875808pgh.326.1567698465289;
        Thu, 05 Sep 2019 08:47:45 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id x16sm2339867pjn.12.2019.09.05.08.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Sep 2019 08:47:44 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v2 04/12] dir: Directories should be checked for matching pathspecs too
Date:   Thu,  5 Sep 2019 08:47:27 -0700
Message-Id: <20190905154735.29784-5-newren@gmail.com>
X-Mailer: git-send-email 2.22.1.11.g45a39ee867
In-Reply-To: <20190905154735.29784-1-newren@gmail.com>
References: <20190825185918.3909-1-szeder.dev@gmail.com>
 <20190905154735.29784-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even if a directory doesn't match a pathspec, it is possible, depending
on the precise pathspecs, that some file underneath it might.  So we
special case and recurse into the directory for such situations.  However,
we previously always added any untracked directory that we recursed into
to the list of untracked paths, regardless of whether the directory
itself matched the pathspec.

For the case of git-clean and a set of pathspecs of "dir/file" and "more",
this caused a problem because we'd end up with dir entries for both of
  "dir"
  "dir/file"
Then correct_untracked_entries() would try to helpfully prune duplicates
for us by removing "dir/file" since it's under "dir", leaving us with
  "dir"
Since the original pathspec only had "dir/file", the only entry left
doesn't match and leaves nothing to be removed.  (Note that if only one
pathspec was specified, e.g. only "dir/file", then the common_prefix_len
optimizations in fill_directory would cause us to bypass this problem,
making it appear in simple tests that we could correctly remove manually
specified pathspecs.)

Fix this by actually checking whether the directory we are about to add
to the list of dir entries actually matches the pathspec; only do this
matching check after we have already returned from recursing into the
directory.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c            | 5 +++++
 t/t7300-clean.sh | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index bf1a74799e..76a3c3894b 100644
--- a/dir.c
+++ b/dir.c
@@ -1951,6 +1951,11 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 							 check_only, stop_at_first_file, pathspec);
 			if (subdir_state > dir_state)
 				dir_state = subdir_state;
+
+			if (!match_pathspec(istate, pathspec, path.buf, path.len,
+					    0 /* prefix */, NULL,
+					    0 /* do NOT special case dirs */))
+				state = path_none;
 		}
 
 		if (check_only) {
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 2c254c773c..12617158db 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -699,7 +699,7 @@ test_expect_failure 'git clean handles being told what to clean' '
 	test_path_is_missing d2/ut
 '
 
-test_expect_failure 'git clean handles being told what to clean, with -d' '
+test_expect_success 'git clean handles being told what to clean, with -d' '
 	mkdir -p d1 d2 &&
 	touch d1/ut d2/ut &&
 	git clean -ffd */ut &&
@@ -715,7 +715,7 @@ test_expect_failure 'git clean works if a glob is passed without -d' '
 	test_path_is_missing d2/ut
 '
 
-test_expect_failure 'git clean works if a glob is passed with -d' '
+test_expect_success 'git clean works if a glob is passed with -d' '
 	mkdir -p d1 d2 &&
 	touch d1/ut d2/ut &&
 	git clean -ffd "*ut" &&
-- 
2.22.1.11.g45a39ee867

