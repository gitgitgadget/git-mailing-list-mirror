Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A5D61F516
	for <e@80x24.org>; Sun,  1 Jul 2018 01:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbeGABZX (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 21:25:23 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38355 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbeGABZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 21:25:16 -0400
Received: by mail-oi0-f65.google.com with SMTP id v8-v6so11735260oie.5
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 18:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pQsIOmzttF4Hi8TfVf/dasRfE61CqaWIqQEJGk4BFM4=;
        b=Gy1bkmFpLYL/qgEMGZY1ADXKHF2McyIC7rNGP1+k8tMs8DKvXeIusXDTbMG4wUb+aU
         1zlBW12vL5Pym0m0VaJX4tTZJ3ZHENdyI+9JdrZbuRrW9ifJG7xoj1VvOyE0FX4ou1mq
         9LY5ZNIMYiKLdlIHR6WllggQBquZkYyHylqzKPNIcq+O7+CkTBuwjzma/M+6w9mDNqHU
         F1GihbL1uY35MkQicRIx0sstXBKiki1LbJjL3+/po106ghn7+Hz/Tkxk9snIjnmEniXX
         li1J7+9GJQ6mAoQMJ6+yjBetUDIm+o1li+lXqQ2rDv09I7B6f+DPinkpeQgF6cV4tVy0
         GPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pQsIOmzttF4Hi8TfVf/dasRfE61CqaWIqQEJGk4BFM4=;
        b=cvuFIIp/xk4IjM9Bmw+6sM1nYy2aIMfjyDqoDQlPBw9X310a2/wAEm+zlB/dKdu0on
         tz6WiA1FcUmPZIKnDeGvPCYKJisKtVa+S85PVicbhf13EyPfUk4l/6FhpyOINIYVvbdX
         WIKm1+aOfxjnCyPpzchg/L78HuRPCGJYfj5A9bIr5AoifyEeBiqDbN5c3fBXr84ruXe/
         Um0Xlg5v+BaZH2IoY3wHCL/z773tbwqApbMi7UuPBjpdlUxIDDui8SVLek+Uw3uWQbCr
         TgsppggZK1NP2ebSFP9hr//gTBRqo6ClSdfrwvxDsf7cUhZTZF8Jn0e6SJIbT2Uq5quS
         4t8g==
X-Gm-Message-State: APt69E05yv2dmzWb4MuTjamHaolIPsU8EcMNj8lY4HhwcnXjgj4FdZ2Q
        xcO1UGQ931wt/W3W4n+4ECu+3A==
X-Google-Smtp-Source: AAOMgpdP8yk+GuYeAkuLvw3yfauDsRZO5r/JkjD9+BAQsGY5jcBsjooKBtig8Fe2Yg3KH/dtuRwmUw==
X-Received: by 2002:aca:a93:: with SMTP id k19-v6mr12034646oiy.83.1530408315274;
        Sat, 30 Jun 2018 18:25:15 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id g20-v6sm3509394ote.38.2018.06.30.18.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 18:25:14 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 4/9] t6044: add a testcase for index matching head, when head doesn't match HEAD
Date:   Sat, 30 Jun 2018 18:24:58 -0700
Message-Id: <20180701012503.14382-5-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.137.g2a11d05a6.dirty
In-Reply-To: <20180701012503.14382-1-newren@gmail.com>
References: <20180603065810.23841-1-newren@gmail.com>
 <20180701012503.14382-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `git merge-recursive` command allows the user to directly specify
three commits to merge -- base, head, and remote.  (More than three can be
specified in the case of multiple merge bases.)  Note that since the user
is allowed to specify head, it need not match HEAD.

Virtually every test and script in the current git.git codebase calls `git
merge-recursive` with head=HEAD, and likely external callers do as well,
which is why this has gone unnoticed.  There is one notable
counter-example: git-stash.sh.  However, git-stash called `git
merge-recursive` with an index that matches the expected merge result,
which happens to be a currently allowed exception to the "index must match
head" rule, so this never triggered an error previously.

Since we would like to tighten up the "index must match head" rule, we
need to make sure we are comparing to the correct head.  Add a testcase
that demonstrates the failure when we check the wrong HEAD.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6044-merge-unrelated-index-changes.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t6044-merge-unrelated-index-changes.sh b/t/t6044-merge-unrelated-index-changes.sh
index f9c2f8179..92ec55255 100755
--- a/t/t6044-merge-unrelated-index-changes.sh
+++ b/t/t6044-merge-unrelated-index-changes.sh
@@ -126,6 +126,17 @@ test_expect_failure 'recursive, when merge branch matches merge base' '
 	test_path_is_missing .git/MERGE_HEAD
 '
 
+test_expect_failure 'merge-recursive, when index==head but head!=HEAD' '
+	git reset --hard &&
+	git checkout C^0 &&
+
+	# Make index match B
+	git diff C B | git apply --cached &&
+	# Merge B & F, with B as "head"
+	git merge-recursive A -- B F > out &&
+	test_i18ngrep "Already up to date" out
+'
+
 test_expect_success 'octopus, unrelated file touched' '
 	git reset --hard &&
 	git checkout B^0 &&
-- 
2.18.0.137.g2a11d05a6.dirty

