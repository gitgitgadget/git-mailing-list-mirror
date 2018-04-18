Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C53701F404
	for <e@80x24.org>; Wed, 18 Apr 2018 22:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752280AbeDRWgv (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 18:36:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53776 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbeDRWgv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 18:36:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8BE286079B; Wed, 18 Apr 2018 22:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1524091010;
        bh=2U5ycBli9ecERo4mhuFOE5VuHeIGe41yVLQhg62eT1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=c0JRhgLx+4VZu3AVLUld9v8dYrJYYUMttXjs44cmlvyOYKAK/qCwLtdqPydWAa9R8
         aO377Fd1g2YdlZMoSCJr2R37I0lEK2KuOaZdzkPWlMoCcx24f4Gk3FlwFbp2wSloCZ
         dE3NTbJ8VKe6HrfGWtT0tUVYwIVZXiV75Tzns7lY=
Received: from localhost.localdomain (unknown [188.27.164.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eddy.petrisor@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 20E026025C;
        Wed, 18 Apr 2018 22:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1524091010;
        bh=2U5ycBli9ecERo4mhuFOE5VuHeIGe41yVLQhg62eT1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=c0JRhgLx+4VZu3AVLUld9v8dYrJYYUMttXjs44cmlvyOYKAK/qCwLtdqPydWAa9R8
         aO377Fd1g2YdlZMoSCJr2R37I0lEK2KuOaZdzkPWlMoCcx24f4Gk3FlwFbp2wSloCZ
         dE3NTbJ8VKe6HrfGWtT0tUVYwIVZXiV75Tzns7lY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20E026025C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=eddy.petrisor@codeaurora.org
From:   =?UTF-8?q?Eddy=20Petri=C8=99or?= <eddy.petrisor@codeaurora.org>
To:     sbeller@google.com, jrnieder@gmail.com
Cc:     =?UTF-8?q?Eddy=20Petri=C8=99or?= <eddy.petrisor@gmail.com>,
        git@vger.kernel.org
Subject: [RFC PATCH v4 2/9] t7406: add test for non-default branch in submodule
Date:   Thu, 19 Apr 2018 01:35:45 +0300
Message-Id: <20180418223552.18345-2-eddy.petrisor@codeaurora.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180418223552.18345-1-eddy.petrisor@codeaurora.org>
References: <20180418223552.18345-1-eddy.petrisor@codeaurora.org>
In-Reply-To: <CAGZ79kbT+AnVu-AJ9=OSt=Z2ErM5ocfoLfgx=qmHFfbnkqJqwg@mail.gmail.com>
References: <CAGZ79kbT+AnVu-AJ9=OSt=Z2ErM5ocfoLfgx=qmHFfbnkqJqwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eddy Petrișor <eddy.petrisor@gmail.com>

If a submodule uses a non-default branch and the branch info is versioned, on
submodule update --recursive --init the correct branch should be checked out.

Signed-off-by: Eddy Petrișor <eddy.petrisor@gmail.com>
---
 t/t7406-submodule-update.sh | 54 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 6f083c4d6..7b65f1dd1 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -259,6 +259,60 @@ test_expect_success 'submodule update --remote should fetch upstream changes wit
 	)
 '
 
+test_expect_success 'submodule update --remote --recursive --init should fetch module branch from .gitmodules' '
+	git clone . super5 &&
+	git clone super5 submodl2b2 &&
+	git clone super5 submodl1b1 &&
+	cd submodl2b2 &&
+	echo linel2b2 > l2b2 &&
+	git checkout -b b2 &&
+	git add l2b2 &&
+	test_tick &&
+	git commit -m "commit on b2 branch in l2" &&
+	git rev-parse --verify HEAD >../expectl2 &&
+	git checkout master &&
+	cd ../submodl1b1 &&
+	git checkout -b b1 &&
+	echo linel1b1 > l1b1 &&
+	git add l1b1 &&
+	test_tick &&
+	git commit -m "commit on b1 branch in l1" &&
+	git submodule add ../submodl2b2 submodl2b2 &&
+	git config -f .gitmodules submodule."submodl2b2".branch b2 &&
+	git add .gitmodules &&
+	test_tick &&
+	git commit -m "add l2 module with branch b2 in l1 module in branch b1" &&
+	git submodule init submodl2b2 &&
+	git rev-parse --verify HEAD >../expectl1 &&
+	git checkout master &&
+	cd ../super5 &&
+	echo super_with_2_chained_modules > super5 &&
+	git add super5 &&
+	test_tick &&
+	git commit -m "commit on default branch in super5" &&
+	git submodule add ../submodl1b1 submodl1b1 &&
+	git config -f .gitmodules submodule."submodl1b1".branch b1 &&
+	git add .gitmodules &&
+	test_tick &&
+	git commit -m "add l1 module with branch b1 in super5" &&
+	git submodule init submodl1b1 &&
+	git clone super5 super &&
+	(
+		cd super &&
+		git submodule update --recursive --init
+	) &&
+	(
+		cd submodl1b1 &&
+		git rev-parse --verify HEAD >../../actuall1 &&
+		test_cmp ../../expectl1 ../../actuall1
+	) &&
+	(
+		cd submodl2b2 &&
+		git rev-parse --verify HEAD >../../../actuall2 &&
+		test_cmp ../../../expectl2 ../../../actuall2
+	)
+'
+
 test_expect_success 'local config should override .gitmodules branch' '
 	(cd submodule &&
 	 git checkout test-branch &&
-- 
2.16.2

