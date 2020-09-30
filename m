Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6E4C2D0A8
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 07:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D97F12071E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 07:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F9vh+T6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgI3Hrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 03:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbgI3Hrs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 03:47:48 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527A5C061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 00:47:48 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 16so414560qky.8
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 00:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=8LA1WVSDIyuBaZ4pM8+wPOSC0VJRxHzGpBHKQrQGsvM=;
        b=F9vh+T6V3C6bctD984pFdeRvUjFIHLyMFzEHARDaWfZmlc0kkufN6QIlwmPPg2qFao
         Jqdm/1bHJI7DFMm9d4AtGZesmc5aHVNivgCR4uKYqKcbUxID0mRSRnO+CYRqBvX+5T0t
         ZpCE9t5FmuJkKJ1IjIC+XoNtP27fhszfk+gTuQyCdEHXMMs0Nxt4i6YmP92o5Yoe6EWR
         U2BeYC3Rl6aSkUmccxS3//WXEEV6sPitCWN8y5rW576SA9h2jNHf8RzcKLMHGRFqy/eq
         oI+c75Ca8wqNPF8AGzqI7TLLnOSFlrHUJ9Zo6YLJczznXz6pcG+fWtIVxa7o0zzviSdS
         YL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=8LA1WVSDIyuBaZ4pM8+wPOSC0VJRxHzGpBHKQrQGsvM=;
        b=apbrrYoq6K4wCeqlAAcOatkq7bBjghUzR9gUc6cYciEdmDO6m0TeK9CeYb60TO2Szr
         kbF1TYC2WCAzCgdo6masZx7VbRCKibRegfYT1ABCOq8YzPLGO2zlHN2iM764u1eQDmTx
         /qdzHnomJPI41YNoZkPVi1DoyKtMn0Jc69CFxVCpaoBvXbmaK+UoU/8N0mMITa23tixX
         070hECJ35toH5HABdzRAkGAOmyxQ/Tz6xRsDguBrNrF2d0HElGo4b2A5yje6Vl6YHwmq
         p1RLyhS3PWtWGp/pQNHDsok4ActQ04KLnqMgqpTzyAWJVOs9faWcCGfCB8OCP294Z/Yk
         BODg==
X-Gm-Message-State: AOAM532Nl3RQMzuoaQt5ecy2okhw7/KLmT6DTv83Y5NC/O4kN0K9wdLk
        cvH8HQnZn/M3mMKVuncwAcsOxtMoC2p+1ewzIESv8xew00oKCiIPtpsZB73pD64WUrENo4cUQe8
        UeMzjbsZ6KqezhGxYUy3VvSwM6DccLheeE3RM+zIRE3YgBwoYMfwbzLw=
X-Google-Smtp-Source: ABdhPJzF3vEwbn1u/XBFYWN8+WdlCfZHEMxfQuhr08jjncNJ8ffbSbygLedWXbjIx/8pitihXs2qU1eVHw==
Sender: "tbodt via sendgmr" <tbodt@tbodt.mtv.corp.google.com>
X-Received: from tbodt.mtv.corp.google.com ([2620:0:1000:5000:7220:84ff:fe09:feee])
 (user=tbodt job=sendgmr) by 2002:a0c:d443:: with SMTP id r3mr1207498qvh.17.1601452067355;
 Wed, 30 Sep 2020 00:47:47 -0700 (PDT)
Date:   Wed, 30 Sep 2020 00:47:30 -0700
Message-Id: <20200930074729.99629-1-tbodt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH] Propagate --quiet on submodule update to merge/rebase
From:   Theodore Dubois <tbodt@google.com>
To:     git@vger.kernel.org
Cc:     Theodore Dubois <tbodt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Without this, commands such as
git pull --rebase --recurse-submodules --quiet
might produce non-quiet output from the merge or rebase.

Signed-off-by: Theodore Dubois <tbodt@google.com>
---
 git-submodule.sh            | 4 ++--
 t/t7406-submodule-update.sh | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git git-submodule.sh git-submodule.sh
index 6fb12585cb..5c22b17221 100755
--- git-submodule.sh
+++ git-submodule.sh
@@ -614,13 +614,13 @@ cmd_update()
 				say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
 				;;
 			rebase)
-				command="git rebase"
+				command="git rebase ${GIT_QUIET:+--quiet}"
 				die_msg="$(eval_gettext "Unable to rebase '\$sha1' in submodule path '\$displaypath'")"
 				say_msg="$(eval_gettext "Submodule path '\$displaypath': rebased into '\$sha1'")"
 				must_die_on_failure=yes
 				;;
 			merge)
-				command="git merge"
+				command="git merge ${GIT_QUIET:+--quiet}"
 				die_msg="$(eval_gettext "Unable to merge '\$sha1' in submodule path '\$displaypath'")"
 				say_msg="$(eval_gettext "Submodule path '\$displaypath': merged in '\$sha1'")"
 				must_die_on_failure=yes
diff --git t/t7406-submodule-update.sh t/t7406-submodule-update.sh
index aa19ff3a2e..5213e47af8 100755
--- t/t7406-submodule-update.sh
+++ t/t7406-submodule-update.sh
@@ -1022,4 +1022,13 @@ test_expect_success 'git clone passes the parallel jobs config on to submodules'
 	rm -rf super4
 '
 
+test_expect_success 'submodule update --quiet passes quietness to merge/rebase' '
+	(cd super &&
+	 test_commit -C rebasing message &&
+	 git submodule update --rebase --quiet >out 2>err &&
+	 test_must_be_empty out &&
+	 test_must_be_empty err
+	)
+'
+
 test_done
-- 
2.28.0.709.gb0816b6eb0-goog

