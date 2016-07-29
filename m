Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C76EF1F858
	for <e@80x24.org>; Fri, 29 Jul 2016 00:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193AbcG2AoS (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 20:44:18 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36032 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbcG2AoR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 20:44:17 -0400
Received: by mail-pa0-f46.google.com with SMTP id pp5so25570222pac.3
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 17:44:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CE+7buPvAuLCia10L+LbdyfsABFPcSkV6sXonxCwgkg=;
        b=JLBZqx+7htRpNJjAe98FAVrwNhG/1qN7ElqLtZ5VPJfEOrnWLNosSceoCd6nvUwaS/
         xa3IDrXpibSeFhVJVo9PEVKPS9vPco6l+FDtGR5pklpQH80lR4rsjI5bmIo24NYGAxP/
         ixlMY30fWp4T/d5jl6GOMMRDHRisBPf/KErzKdjmzycjBsqLzXO16+yDVViLL4Hsrek8
         iLWahU1x9U0JGfX8MEN1SgUzpvEYHjgufCvs+sdX9HlhsNnHEaP53fCE022cu6f8LkPw
         3q91MWdmlq1je/UO67BoLHbyzPYxGqzBMx21e1OtaYW9lIQWC1fs7OMbK6bsYF3dbHN+
         6hQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CE+7buPvAuLCia10L+LbdyfsABFPcSkV6sXonxCwgkg=;
        b=IyUjkYpWmsm+DuJguYCkyiXZdrxHbzjv9wcW7+SosoWpBb2jAufyAycU+bFoDhQSj5
         KCeWbCC0bAFMoYQfds/Ur7ZU8x28mO8nudGR21Kf+81nzPwU+3lXl00cTSanu8QPuctc
         YOQGTdOYra6xNVQSGwEM5061x3tqT9KprqJpybcesEtJmeDkBUp9cqW/ryAiGr9cPb9w
         2UCssb0lCDxmRsFx6TTGpthyHvFfqcSlgDTl0HV30M/Qu9RBd88uAXvaKE+ntAFWWQjK
         ZQTepPR4BrCwJCa+kTFYfKLjgTRn32rzpU9ZbkZh4+H8wzOIgKDplBbnHrgmSIuS0KQ3
         xsyQ==
X-Gm-Message-State: AEkoouuzypfWfQ64SUjMYtGFRc0zf1Wh0PuKiCbU3SMB5hY/GNOD9PN7/ZXwRjsBgw1LHqdJ
X-Received: by 10.66.66.13 with SMTP id b13mr64415104pat.45.1469753056049;
        Thu, 28 Jul 2016 17:44:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:6dbf:17d9:7b5c:47ec])
        by smtp.gmail.com with ESMTPSA id v124sm19885988pfb.14.2016.07.28.17.44.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Jul 2016 17:44:15 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, apenwarr@gmail.com,
	jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 1/7] t7406: future proof tests with hard coded depth
Date:	Thu, 28 Jul 2016 17:44:03 -0700
Message-Id: <20160729004409.2072-2-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.472.g1ffb07c.dirty
In-Reply-To: <20160729004409.2072-1-sbeller@google.com>
References: <20160729004409.2072-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The prior hard coded depth was chosen to be exactly the length from the
recorded gitlink to the tip of the remote, so if you add more commits
to the remote before, this test will not test its intention any more.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7406-submodule-update.sh | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 88e9750..8fc3a25 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -841,16 +841,19 @@ test_expect_success SYMLINKS 'submodule update can handle symbolic links in pwd'
 '
 
 test_expect_success 'submodule update clone shallow submodule' '
+	test_when_finished "rm -rf super3" &&
+	first=$(git -C cloned submodule status submodule |cut -c2-41) &&
+	second=$(git -C submodule rev-parse HEAD) &&
+	commit_count=$(git -C submodule rev-list $first^..$second | wc -l) &&
 	git clone cloned super3 &&
 	pwd=$(pwd) &&
-	(cd super3 &&
-	 sed -e "s#url = ../#url = file://$pwd/#" <.gitmodules >.gitmodules.tmp &&
-	 mv -f .gitmodules.tmp .gitmodules &&
-	 git submodule update --init --depth=3
-	 (cd submodule &&
-	  test 1 = $(git log --oneline | wc -l)
-	 )
-)
+	(
+		cd super3 &&
+		sed -e "s#url = ../#url = file://$pwd/#" <.gitmodules >.gitmodules.tmp &&
+		mv -f .gitmodules.tmp .gitmodules &&
+		git submodule update --init --depth=$commit_count &&
+		test 1 = $(git -C submodule log --oneline | wc -l)
+	)
 '
 
 test_expect_success 'submodule update --recursive drops module name before recursing' '
-- 
2.9.2.472.g1ffb07c.dirty

