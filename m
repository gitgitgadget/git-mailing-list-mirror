Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10473C43215
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 04:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA6E2082C
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 04:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0JJ9YTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKYEPu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 23:15:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34236 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfKYEPu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 23:15:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so16132402wrr.1
        for <git@vger.kernel.org>; Sun, 24 Nov 2019 20:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V5iy872TkBWPr45/mXXgJb8yeb5O557VvdomOZ19pWg=;
        b=n0JJ9YTCF4ME3yi0eTZQXtJzm1awpE3VRlExY/GHDy1n2+gQHjN4etKlfcRbBDGIzg
         /vSiGxi9/hMYgwgZljMfoOGQ2x/0jDCZ3YwcVtIvjFGK4q5taG2FRtfZFqkM6hv7xew5
         DxvpOWTT1KdFQvKMLrW7zFUEYpz4LqBHkSrMEQj1dnTJN7UBI0sIzrSscVDAopM9p2un
         iZbbF04OxNB2RIgvzJuWDjZRQ9/XpqdE6EeRK59jnTUO4bDgWIvYNEilThsTp+WfoFv/
         imHrB46ilmRhyhd93BbUVY3QRzXaLE7KjV1DMGc259WNLkJ8KyRnoXs2uxV949/SAkV9
         BFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V5iy872TkBWPr45/mXXgJb8yeb5O557VvdomOZ19pWg=;
        b=VhUDqJpCLW4y5Vs7+JvK9g46RIUfX8LNh8iqzEPJ+ZgpeUdBH+npqX1wPJCj4t0FZE
         oW3AbALJdOqhWZz0v5B2NVkalFcsy+ka+NVDjH//Q4xQDVQe0elS9xjxXuHNV+6Ijvzf
         hTbS2Wzz1eXhPEiEMLP1ufq/T9tBXvfTVnKfd0c9MinEiURb+5w7I9nkNNqr4NyDevCl
         UTAJfJlglV+QvGz7KyuNpQ8WR8nbQWBLzny0iF15C93Z3XwbZD9vhOYX5RXCorZUeFBS
         moN6/yqvgncYUBCJMNq1cj93OTPGiAX3etKjwlhDuzkc26E1lIxK/7qJwNq/kDJCYmKz
         1v8g==
X-Gm-Message-State: APjAAAU+GyCYn4cCF01PGjWaomZJ0t0W1u7NBBkBF+55aBz410gpPzJU
        RBkkIVlDCJRs7XCDM1/o7fv/Gsi9
X-Google-Smtp-Source: APXvYqyNZe0+R+Vgc/mVzYFrbbzvTLpLm1h8uEZRPAJwpOH+Oax9T+tYRcYr4OtX0sDsSvyXvS6qaw==
X-Received: by 2002:a5d:518c:: with SMTP id k12mr29270438wrv.104.1574655345847;
        Sun, 24 Nov 2019 20:15:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 72sm9078352wrl.73.2019.11.24.20.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2019 20:15:45 -0800 (PST)
Message-Id: <8dcea6b399923e931625ef09d66661e93975b93a.1574655344.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.472.v3.git.1574655344.gitgitgadget@gmail.com>
References: <pull.472.v2.git.1574582473.gitgitgadget@gmail.com>
        <pull.472.v3.git.1574655344.gitgitgadget@gmail.com>
From:   "Manish Goregaokar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Nov 2019 04:15:44 +0000
Subject: [PATCH v3 1/1] submodule: fix 'submodule status' when called from a
 subdirectory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Manish Goregaokar <manishsmail@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Manish Goregaokar <manishsmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Manish Goregaokar <manishsmail@gmail.com>

When calling `git submodule status` while in a subdirectory, we are
incorrectly not detecting modified submodules and
thus reporting that all of the submodules are unchanged.

This is because the submodule helper is calling `diff-index` with the
submodule path assuming the path is relative to the current prefix
directory, however the submodule path used is actually relative to the root.

Always pass NULL as the `prefix` when running diff-files on the
submodule, to make sure the submodule's path is interpreted as relative
to the superproject's repository root.

Signed-off-by: Manish Goregaokar <manishsmail@gmail.com>
---
 builtin/submodule--helper.c |  3 ++-
 t/t7400-submodule-basic.sh  | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 909e77e802..eeea8dfa97 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -802,7 +802,8 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 			 path, NULL);
 
 	git_config(git_diff_basic_config, NULL);
-	repo_init_revisions(the_repository, &rev, prefix);
+
+	repo_init_revisions(the_repository, &rev, NULL);
 	rev.abbrev = 0;
 	diff_files_args.argc = setup_revisions(diff_files_args.argc,
 					       diff_files_args.argv,
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index a208cb26e1..09d8408f88 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -356,6 +356,28 @@ test_expect_success 'status should only print one line' '
 	test_line_count = 1 lines
 '
 
+test_expect_success 'status from subdirectory should have the same SHA1' '
+	test_when_finished "rmdir addtest/subdir" &&
+	(
+		cd addtest &&
+		mkdir subdir &&
+		git submodule status >output &&
+		awk "{print \$1}" <output >expect &&
+		cd subdir &&
+		git submodule status >../output &&
+		awk "{print \$1}" <../output >../actual &&
+		test_cmp ../expect ../actual &&
+		git -C ../submod checkout HEAD^ &&
+		git submodule status >../output &&
+		awk "{print \$1}" <../output >../actual2 &&
+		cd .. &&
+		git submodule status >output &&
+		awk "{print \$1}" <output >expect2 &&
+		test_cmp actual2 expect2 &&
+		! test_cmp actual actual2
+	)
+'
+
 test_expect_success 'setup - fetch commit name from submodule' '
 	rev1=$(cd .subrepo && git rev-parse HEAD) &&
 	printf "rev1: %s\n" "$rev1" &&
-- 
gitgitgadget
