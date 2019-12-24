Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32BEC2D0D6
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88EE42075E
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exD9DIuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLXTzW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 14:55:22 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34804 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLXTzM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 14:55:12 -0500
Received: by mail-ed1-f68.google.com with SMTP id l8so18682298edw.1
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 11:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BAhNliR1ZkRUC0qZ6iUsnYc0YkrscXoRR69gsMZ/BNk=;
        b=exD9DIufO0rlIqH5MXXiRk6ZjRqOrkNF+rkPif11XH7w4sT4fH2SxfCSKlOT/PSQkg
         EYD1074MN4gEbDktasCTzQhPqtSGBu5u6qsiN501jdpDb0qIWxOu9mTK+Zn8KllMxNEu
         Y3Wh932atPYIBY7nYG4RpxyXzj/PMQ1QOcrPn4gDvXlw/zzCDoG3NkSAUP02YGxFCuiQ
         rGdUs3hlLaGbvGhM5pZPugQfcNhvdoHc9Jg8ey6abHWilT+sIJ/U3TKjwILqDwaFnB13
         MCRCPO4gZ0TIKeHFidy0rLvVpfKWH3DIjhCJOnnnPBugHBJ+hQ9HRl3F5uF0OwjC6/M/
         1s/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BAhNliR1ZkRUC0qZ6iUsnYc0YkrscXoRR69gsMZ/BNk=;
        b=WG0tiWwKf2auBd04fbjtFw5pIbBUKOSNxeDTErRSu60qgz1/8LFXmPpFUkyOYi/faN
         s0cidr4JVS38B3ycAIU6G6xcPcIv5UKOkblzd4Xmbft9U36A6m1GJQr+leIJuHdUoi7L
         QqFfjzzOU7akfQigfN561cejUg5rS2cva42xefZKOHNEIQpsnEunCVsOv0aoAeRswN4B
         ufRQMkjbm6E4p876jIkallkeOKhTcJUEaaB5tN9u68CR3jf8ebUO/d+mM55p/nMPqUkD
         tIUJdI+xy+tBOLtOdyub5CIL2rLLeoAbxd8ixlowVR0SpHYjZ8T6runD7ZiJsGOubnc5
         bbNQ==
X-Gm-Message-State: APjAAAXOko7XxJ+XH/Ldya5jq79nzE1f/m+jlV6QNk31HSbONQ0Rm3r1
        EqQ/d+AstVm3H0+PnjioCGifMb9u
X-Google-Smtp-Source: APXvYqxnXHMl0rnu6e2Hiz0b77EJ9h+kCQB2AuUICk859VKH/CMlmMdYE1gxIj2KSvV6Or2a9KsLUg==
X-Received: by 2002:a05:6402:21e3:: with SMTP id ce3mr40768571edb.165.1577217311149;
        Tue, 24 Dec 2019 11:55:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2sm2761141edx.35.2019.12.24.11.55.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Dec 2019 11:55:10 -0800 (PST)
Message-Id: <c2ba6317bf06a63a12de3eb97f6634e558554004.1577217299.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
        <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Dec 2019 19:54:57 +0000
Subject: [PATCH v3 13/15] rebase tests: repeat some tests using the merge
 backend instead of am
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In order to ensure the merge/interactive backend gets similar coverage
to the am one, add some tests for cases where previously only the am
backend was tested.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t5520-pull.sh                   | 17 +++++++++++++++--
 t/t6047-diff3-conflict-markers.sh | 13 +++++++++++--
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 602d996a33..3fff6a06fa 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -277,14 +277,27 @@ test_expect_success '--rebase' '
 	test_cmp expect actual
 '
 
-test_expect_success '--rebase fast forward' '
+test_expect_success '--rebase (merge) fast forward' '
 	git reset --hard before-rebase &&
 	git checkout -b ff &&
 	echo another modification >file &&
 	git commit -m third file &&
 
 	git checkout to-rebase &&
-	git pull --rebase . ff &&
+	git -c rebase.backend=merge pull --rebase . ff &&
+	test_cmp_rev HEAD ff &&
+
+	# The above only validates the result.  Did we actually bypass rebase?
+	git reflog -1 >reflog.actual &&
+	sed "s/^[0-9a-f][0-9a-f]*/OBJID/" reflog.actual >reflog.fuzzy &&
+	echo "OBJID HEAD@{0}: pull --rebase . ff: Fast-forward" >reflog.expected &&
+	test_cmp reflog.expected reflog.fuzzy
+'
+
+test_expect_success '--rebase (am) fast forward' '
+	git reset --hard before-rebase &&
+
+	git -c rebase.backend=am pull --rebase . ff &&
 	test_cmp_rev HEAD ff &&
 
 	# The above only validates the result.  Did we actually bypass rebase?
diff --git a/t/t6047-diff3-conflict-markers.sh b/t/t6047-diff3-conflict-markers.sh
index 860542aad0..d383ce8130 100755
--- a/t/t6047-diff3-conflict-markers.sh
+++ b/t/t6047-diff3-conflict-markers.sh
@@ -186,7 +186,7 @@ test_expect_success 'check multiple merge bases' '
 	)
 '
 
-test_expect_success 'rebase describes fake ancestor base' '
+test_expect_success 'rebase --merge describes parent of commit being picked' '
 	test_create_repo rebase &&
 	(
 		cd rebase &&
@@ -194,7 +194,16 @@ test_expect_success 'rebase describes fake ancestor base' '
 		test_commit master file &&
 		git checkout -b side HEAD^ &&
 		test_commit side file &&
-		test_must_fail git -c merge.conflictstyle=diff3 rebase master &&
+		test_must_fail git -c merge.conflictstyle=diff3 rebase --merge master &&
+		grep "||||||| parent of" file
+	)
+'
+
+test_expect_success 'rebase --am describes fake ancestor base' '
+	(
+		cd rebase &&
+		git rebase --abort &&
+		test_must_fail git -c merge.conflictstyle=diff3 rebase --am master &&
 		grep "||||||| constructed merge base" file
 	)
 '
-- 
gitgitgadget

