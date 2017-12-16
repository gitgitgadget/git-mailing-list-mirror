Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EF441F404
	for <e@80x24.org>; Sat, 16 Dec 2017 09:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753207AbdLPJEg (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 04:04:36 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41098 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbdLPJEa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 04:04:30 -0500
Received: by mail-pf0-f193.google.com with SMTP id j28so7662342pfk.8
        for <git@vger.kernel.org>; Sat, 16 Dec 2017 01:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=wNBAwVb6LdQ4SXBipr68YYfKX3s+VTWTPaVoiKUJC6Q=;
        b=BU30goydqVZJyOV8QBIUXlkMt/CzSr+2Hw0g06MDDQDYl2667k7H/gz/bIBOcjrC4L
         Du5niKI/ZvgQMLAFjZbNPG2f3rBWabnf+ebnYuqtPMf/CHz4Pb0NLnUrf/kFSPoEHlJU
         RXLQBSU7BkIiYmQZ6Y4Y1Y91LP7bRkp2Nw5DdJ9PUAPteqBMLnX40pSkJ2kqDIgrtdBP
         CNEDZEQgGUgUhohLUcJ8ugPgdpGILNCt8rzMf1Qrl7RpkmVCNRARpEW1zTeMLujeyo1X
         l6s2TCtaxR79PlxQwZnVScFsq8dkfNMo99eeXQ82JdKO0mix8y4brJ0unl6aoKe3HAQ4
         pfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=wNBAwVb6LdQ4SXBipr68YYfKX3s+VTWTPaVoiKUJC6Q=;
        b=FpaJcuP0Q32XOljUOtpeGAGqzYj1T1X7cBDv+zjHqiT44qjxjxL0p+egkAERD5ibNG
         BnPksAGBTApBVDSsSMxX7nrgZzEZtxTuFUXnO6pR9140ZT4Zk2DHOAZj3KY/VTuvNwy1
         M9BGYORqwOiRMhF7fbNdZ+5V0qrQ713adwbWirp/vcEa1vGXeP3c9Be/Svl2hJioKEMR
         XWe1EUwTXAGxGqDpM7gT6FwALXjh/J38YWC9ROss4Q/3LOnU0Tdw8olhDbkfMCibzm84
         XihrdU3WJ1OFs8oM0xnrrjW3aszkPSWjoQ4rmc+pF7E9UQCxSGcq7e4X1+ZTsOsZF2Lz
         O1Og==
X-Gm-Message-State: AKGB3mLLTJCX2TTnlWfRBp8pcCbQX8piSzvmwmwtrOjLUO3ox80GT2LB
        /qvGxMx3kdPZmUHhU/bzcV6L4lNs
X-Google-Smtp-Source: ACJfBov9jPjpOszUvB9konxgNYpK/p3TBQ5FNe04QDPOk6+bXK9LLPDGEEeKFbg/YbQMFP/Ty2EaIg==
X-Received: by 10.98.217.17 with SMTP id s17mr16333247pfg.2.1513415069876;
        Sat, 16 Dec 2017 01:04:29 -0800 (PST)
Received: from localhost.localdomain ([117.249.248.104])
        by smtp.gmail.com with ESMTPSA id u68sm15775852pfu.17.2017.12.16.01.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Dec 2017 01:04:29 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 3/3] rebase: rebasing can also be done when HEAD is detached
Date:   Sat, 16 Dec 2017 14:33:19 +0530
Message-Id: <20171216090319.11902-4-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.531.g2ccb3012c
In-Reply-To: <20171216090319.11902-1-kaartic.sivaraam@gmail.com>
References: <20171127172104.5796-1-kaartic.sivaraam@gmail.com>
 <20171216090319.11902-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Attempting to rebase when the HEAD is detached and is already
up to date with upstream (so there's nothing to do), the
following message is shown

        Current branch HEAD is up to date.

which is clearly wrong as HEAD is not a branch.

Handle the special case of HEAD correctly to give a more precise
error message.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 git-rebase.sh | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 0f379ba2b..fd72a35c6 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -601,11 +601,23 @@ then
 		test -z "$switch_to" ||
 		GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to" \
 			git checkout -q "$switch_to" --
-		say "$(eval_gettext "Current branch \$branch_name is up to date.")"
+		if test "$branch_name" = "HEAD" &&
+			 ! git symbolic-ref -q HEAD
+		then
+			say "$(eval_gettext "HEAD is up to date.")"
+		else
+			say "$(eval_gettext "Current branch \$branch_name is up to date.")"
+		fi
 		finish_rebase
 		exit 0
 	else
-		say "$(eval_gettext "Current branch \$branch_name is up to date, rebase forced.")"
+		if test "$branch_name" = "HEAD" &&
+			 ! git symbolic-ref -q HEAD
+		then
+			say "$(eval_gettext "HEAD is up to date, rebase forced.")"
+		else
+			say "$(eval_gettext "Current branch \$branch_name is up to date, rebase forced.")"
+		fi
 	fi
 fi
 
-- 
2.15.0.531.g2ccb3012c

