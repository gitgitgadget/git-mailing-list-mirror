Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59368E936E9
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 21:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244007AbjJDVqb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 17:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243992AbjJDVq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 17:46:27 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD17BC9
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 14:46:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3214cdb4b27so318101f8f.1
        for <git@vger.kernel.org>; Wed, 04 Oct 2023 14:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696455981; x=1697060781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFcPxuW7u7Z0GBMNFlSj1Uiqe2G5+FSgsPLc+oB4fS0=;
        b=j23sOdPDXKDpRYjRhr6ZXgv2NGXLOXhjYrGkomShSFAKKTGMd/mCyssqbkVNVo/d/u
         zuEd21Z4wb7sz2DYAjakA9/QFiubCByet1sr2jXoG7jTma83Gr+RqLP2PEzhcTc2qqVY
         w9vflVLyybq/kKsYONsJOpI8WKvzUz6c0tdJCa+Mt/M9LG+VVqOBsPuu35f4xTd1JbwZ
         +W8DuwT/9C1I7KHK0wbIl+naH7bwQbYHUdm9L6jO75nAgfc5Axf5QKqEpb1zixD0RM7n
         OaYYS9OTdgO+RdGORvSSdMh+AvKNtzYq4D3qZ/oKyEJhqdbdhjXin6vODDRKG0Xwyj3b
         iIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696455981; x=1697060781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFcPxuW7u7Z0GBMNFlSj1Uiqe2G5+FSgsPLc+oB4fS0=;
        b=deaWoE/VueXa2jQHOV3fZODDAO5PZ3hk7mBbFXBLZzPsZGw8wXv+iegvzKBnTSJGLj
         p8mObSok2RJax8aeBt3/vOZdi+00KzBYT21r1B8NWWFsGasHRPSI2C0aNnQx1DvADirl
         4oLdrmbNouaDqTuCDBQOtV7H86I5cNqAT52m1BOQOqTGME5YnBdAjvU/+fELSItAhaia
         obro91k/iIBFFchd2SeC33mHuGP4AYodaKi7Gfr/jVPWX76e8YL4xmKsnyQYovESbeMQ
         ilaJRTk2d/XomrmQUPv1YXetEIQei2T9QLUvdA8/MbaA5gPx8ZvIPW0VXO8GGAueajyB
         CPqw==
X-Gm-Message-State: AOJu0Yzf1Zc4mDdZyVTmJ5oXTF4zCirl7hLdnIcw+WMEO+3rP7RHeW7u
        lFtwr+sd8vDr2H83eHEEmmnngN44sYM=
X-Google-Smtp-Source: AGHT+IFRxXuKoUG4/OqsS9CKuLb/hkeOLJIoyFfJRuzQ0EuuXrb2Dqvq5+1fJoW1EGgcXN9P8PCyOw==
X-Received: by 2002:a5d:6447:0:b0:31f:fb5d:96da with SMTP id d7-20020a5d6447000000b0031ffb5d96damr3481481wrw.64.1696455981028;
        Wed, 04 Oct 2023 14:46:21 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id r25-20020a2e9959000000b002bfba0d26bcsm7818ljj.8.2023.10.04.14.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 14:46:20 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 2/3] diff-merges: introduce '--dd' option
Date:   Thu,  5 Oct 2023 00:45:57 +0300
Message-Id: <20231004214558.210339-3-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231004214558.210339-1-sorganov@gmail.com>
References: <20230909125446.142715-1-sorganov@gmail.com>
 <20231004214558.210339-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This option provides a shortcut to request diff with respect to first
parent for any kind of commit, universally. It's implemented as pure
synonym for "--diff-merges=first-parent --patch".

NOTE: originally proposed as '-d', and renamed to '--dd' due to Junio
request to keep "short-and-sweet" '-d' reserved for other uses.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/diff-options.txt | 5 +++++
 Documentation/git-log.txt      | 2 +-
 diff-merges.c                  | 3 +++
 t/t4013-diff-various.sh        | 8 ++++++++
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 8035210c1418..f80d493dd4c8 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -56,6 +56,11 @@ ifdef::git-log[]
 	Produce dense combined diff output for merge commits.
 	Shortcut for '--diff-merges=dense-combined -p'.
 
+--dd::
+	Produce diff with respect to first parent for both merge and
+	regular commits.
+	Shortcut for '--diff-merges=first-parent -p'.
+
 --remerge-diff::
 	Produce diff against re-merge.
 	Shortcut for '--diff-merges=remerge -p'.
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 9b7ec96e767a..579682172fe4 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -120,7 +120,7 @@ By default, `git log` does not generate any diff output. The options
 below can be used to show the changes made by each commit.
 
 Note that unless one of `--diff-merges` variants (including short
-`-m`, `-c`, and `--cc` options) is explicitly given, merge commits
+`-m`, `-c`, `--cc`, and `--dd` options) is explicitly given, merge commits
 will not show a diff, even if a diff format like `--patch` is
 selected, nor will they match search options like `-S`. The exception
 is when `--first-parent` is in use, in which case `first-parent` is
diff --git a/diff-merges.c b/diff-merges.c
index ec97616db1df..45507588a279 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -131,6 +131,9 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 	} else if (!strcmp(arg, "--cc")) {
 		set_dense_combined(revs);
 		revs->merges_imply_patch = 1;
+	} else if (!strcmp(arg, "--dd")) {
+		set_first_parent(revs);
+		revs->merges_imply_patch = 1;
 	} else if (!strcmp(arg, "--remerge-diff")) {
 		set_remerge_diff(revs);
 		revs->merges_imply_patch = 1;
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 5de1d190759f..4b474808311e 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -473,6 +473,14 @@ test_expect_success 'log --diff-merges=on matches --diff-merges=separate' '
 	test_cmp expected actual
 '
 
+test_expect_success 'log --dd matches --diff-merges=1 -p' '
+	git log --diff-merges=1 -p master >result &&
+	process_diffs result >expected &&
+	git log --dd master >result &&
+	process_diffs result >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'deny wrong log.diffMerges config' '
 	test_config log.diffMerges wrong-value &&
 	test_expect_code 128 git log
-- 
2.25.1

