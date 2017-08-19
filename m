Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 683061F667
	for <e@80x24.org>; Sat, 19 Aug 2017 20:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751697AbdHSUNm (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 16:13:42 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38434 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbdHSUNl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 16:13:41 -0400
Received: by mail-pg0-f67.google.com with SMTP id 123so18876839pga.5
        for <git@vger.kernel.org>; Sat, 19 Aug 2017 13:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ajPjOmAAyXs0bcWs4S6OgsOBpizmRxOZ/vDjpWY0254=;
        b=kr6AoGhWnsfKNP+PNR3PAQ0k4OQdpMJGSKSA4gsGSP9NJflL2xNvSOud7ayvIPa4jY
         6RzqYC7L3M71rVOk4hYrztds3sV98ROqsQdeEeeh9yZGJjrnMKmDRtcfyYqBbS+coj+d
         YQuYcckEHfYqebAXlBUSKvETVCNjzwTKYwkNrCVQBsOCIcqtHuY2nHzA2w6n5UnU5VOm
         Z5LMYGH3zjM1+l51JsQFwZsPaNR1fD3PeaeQ/BE/sSvsOaJJj7d2mEQBXr54M7ErSLit
         Od4wfD3vwCPpvx/Pd3AIUVGt3lT04CmrTmOWhKWEH4U762qhNZG/I4B3WEMj3O6CLRZM
         psCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ajPjOmAAyXs0bcWs4S6OgsOBpizmRxOZ/vDjpWY0254=;
        b=sdeYqGZJpiPJ+Qp/vi3d+EU4ZkXYZGrv3DOBL2uDtFh5/Z5AYFjP+UuzOqtjnoNIyt
         ADj8eLDGUUjqDKMavCJVRST9FDXuJq5G8EJVZWxWBsH9nUV7Mz+6aUaQaxL8tMpfkTHj
         679pD8GhHO1dCYI+LkaNIheOyW892p8Kr/E/AaTBf2RMdk8ZJtsjrjRC80jRpgxNu6yA
         65AeDZ6q/0kdWKgpFNLYmd29IumWbkN5WnVpi41tcQcl9rRCIIwr95JQSStH+tLqYwHi
         hRW8DMgbfmUY9qkeLd6lHoTOVBoVhZdJQEmMb5YY6CCcHvaUWpl59tYk3AcQ/dMnfe6w
         qUmg==
X-Gm-Message-State: AHYfb5jVkne8wjHVB1gxgEfAZXUbx+cuQLqsge9WPdEx7RlZY9TQobXs
        aUBB269r4FHzxJrNgs8=
X-Received: by 10.84.139.36 with SMTP id 33mr13937427plq.20.1503173620592;
        Sat, 19 Aug 2017 13:13:40 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id l15sm14172681pgs.58.2017.08.19.13.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Aug 2017 13:13:40 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     git@vger.kernel.org
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH 2/3] stash: Add a test for when apply fails during stash branch
Date:   Sat, 19 Aug 2017 13:13:25 -0700
Message-Id: <20170819201326.6872-2-joel@teichroeb.net>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170819201326.6872-1-joel@teichroeb.net>
References: <20170819201326.6872-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the return value of merge recursive is not checked, the stash could end
up being dropped even though it was not applied properly

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 t/t3903-stash.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index f0708ced27..887010c497 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -656,6 +656,20 @@ test_expect_success 'stash branch should not drop the stash if the branch exists
 	git rev-parse stash@{0} --
 '
 
+test_expect_success 'stash branch should not drop the stash if the apply fails' '
+	git stash clear &&
+	git reset HEAD~1 --hard &&
+	echo foo >file &&
+	git add file &&
+	git commit -m initial &&
+	echo bar >file &&
+	git stash &&
+	echo baz >file &&
+	test_when_finished "git checkout master" &&
+	test_must_fail git stash branch new_branch stash@{0} &&
+	git rev-parse stash@{0} --
+'
+
 test_expect_success 'stash apply shows status same as git status (relative to current directory)' '
 	git stash clear &&
 	echo 1 >subdir/subfile1 &&
-- 
2.14.1

