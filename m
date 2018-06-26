Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 961DF1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752691AbeFZHa4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:30:56 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:45765 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752323AbeFZHax (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:30:53 -0400
Received: by mail-io0-f194.google.com with SMTP id l25-v6so14978336ioh.12
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d3pI7CrBhOeFo4uMNHI0+AXD47mnBMZrALH3/b/5w7U=;
        b=pjJCRYVniAFzmwETgqgA5KiRLtbadjl2ZxVjzNcjacUYPUjdS57iKWnNRougt810O/
         R6ajs4FdY/KppUlGQ9skAceh3TVXwvr6EmYrV6Cmtszptdznz4bgE4hnrr5VeYg6Tivy
         HER38rBqembuFaJYJ9q7ycDnWli61jSX+fOQeDvBaVMUs3To3aq/jvVIvOxX5+ilGUeu
         E+Yb7d8V8v0hK4iyKDQyG3u22Rx2yGUNRS3EvKU4t6yD42TsDoEBm1NCFNiOpidysZNG
         tX+/c+W7g5S2ZuVBGvUIyZwS6T1Mtof2EO68zWE5Pz3gx0krYUg+fFe07fyWi1uxF3HB
         C1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=d3pI7CrBhOeFo4uMNHI0+AXD47mnBMZrALH3/b/5w7U=;
        b=VM+gFhmDGOgzANxBP0Hy9cRXyUhZ3pqqk3rHznrCy17jBPQcMkeE12lXVYpDNnXLZY
         PvmgbRqqgp8tmUgVn2ItEKnkX3cgHucLID5mWmSlYIeU98un0RyV+hIiOGnbCnLQZh4m
         4QlJT5Tnh3piGBrUUthEiXgWMXkaB7SbAgFtfAo1JCt8HYJsHdAtbQpfh1Eoo6efp6xZ
         Y3Y+rW3uaMHdp0qDNnkfWgSpmu3YT8ZoyxNVbR2qYFQXNbWJPw0mPHYzxQPqzl+Wxkwq
         MqJK+ddZkkzBewP1XJhDP4T5FIYsz9Jm0jx/M/gJTbMEH5fMNVpy0l0kJwCXRVEIi3WF
         Mruw==
X-Gm-Message-State: APt69E3o6Vnh7dkCBRDmAvyVpF25cl7eKi4g0MEqEzzsHRiTjX7c8sGd
        UJVUwk3xE6NCxEEcqY0GMZlJ8g==
X-Google-Smtp-Source: AAOMgpeN8gOQryr2x3NRyc7PrBzwPaDJ2KMgNFCboKPAEZuK8WiQsv/HjyrKbKeVup8fQM1TG/YvOg==
X-Received: by 2002:a6b:d00c:: with SMTP id x12-v6mr296286ioa.5.1529998251962;
        Tue, 26 Jun 2018 00:30:51 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.30.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:30:51 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 03/29] t1300: use sane_unset() to avoid breaking &&-chain
Date:   Tue, 26 Jun 2018 03:29:35 -0400
Message-Id: <20180626073001.6555-4-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test intentionally breaks the &&-chain after "unset HOME" since it
doesn't know if 'unset' will succeed or fail. However, an upcoming
change will teach --chain-lint to detect &&-chain breakage inside
subshells, and it will catch this broken &&-chain. Instead, use
sane_unset() which can be safely linked into the &&-chain.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t1300-config.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 03c223708e..24706ba412 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -888,7 +888,7 @@ EOF
 
 test_expect_success !MINGW 'get --path copes with unset $HOME' '
 	(
-		unset HOME;
+		sane_unset HOME &&
 		test_must_fail git config --get --path path.home \
 			>result 2>msg &&
 		git config --get --path path.normal >>result &&
-- 
2.18.0.419.gfe4b301394

