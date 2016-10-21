Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FBEC20229
	for <e@80x24.org>; Sat, 22 Oct 2016 00:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935797AbcJVAAA (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 20:00:00 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:32908 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935590AbcJUX74 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 19:59:56 -0400
Received: by mail-pf0-f173.google.com with SMTP id 128so65000777pfz.0
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 16:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DSWB6+U0gxflaL5DEUabuICRCTA1o+CbMegLbiME8dc=;
        b=Ks8OInXVx3Lv5wlUsG2fvUBu8uJzVAdiuymnHD7uuxGNoxJvLcvzMbD2e31fDwvbnV
         FyUsscRc02P6q5vfmMiy82Nrf0wppOkbljbw2JBCSPbNROyubjQuuUEJ5wWfsmWpK2uY
         yGXWVSDWKjH1meEi63ruq33b9dDc5q8I1kLqoZDvDdcBXAt/Q/L51tNWxyC4Vpr6shkJ
         L9J5YWT2jzEPbbEfCHh0k9dSmwXBY07xLAKAnksGRIL/y31xxbQJry11yzBy3437DzdN
         RaAwlJZuOS9sowfLT8bqUYV2BQyfR3miP8EXsp05VPR20NqcS/EuHZt5bRUB9q6eEO8a
         sfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DSWB6+U0gxflaL5DEUabuICRCTA1o+CbMegLbiME8dc=;
        b=KOd4g7gcG80lkDA9vc9oS1hO99tpoQU2yv/hWNCaXp8KwD4aV8+ka2qX3u127wIL4t
         If+wZHkxM585l2rE8Thk7liIBGW3F/Ktb3efQsnM+SLgIqsxYBSEb92RTjjKcO3+/4aZ
         NMwRFV5KAbQeADNVxJJHAlIUZzTzbTn1bie03CDNZV+EiyR4QhO4L0vlUPbblkQ/V866
         opa0WFX6ij0ety8Osr5UdeJh7YBxpqsJ3f40l3QOXwlYwG91yc4CAmFiYSK0vy9kYHMp
         KXDLg0Jp7GEZlx5UAq8dVjnhfS5i8PjVJwFb8jSWLA0j7l6gbWRVZOVSeR0sybcCR7+6
         KmVg==
X-Gm-Message-State: ABUngvdC2o5sql/uC5MfQinyxNnxS2KMq9gfWDL3Hroct4/jQLpJi/NmVwrVB/NV4VxOD7HW
X-Received: by 10.98.34.218 with SMTP id p87mr6249205pfj.76.1477094395602;
        Fri, 21 Oct 2016 16:59:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:cc9c:7559:8571:d165])
        by smtp.gmail.com with ESMTPSA id x16sm7600187pff.39.2016.10.21.16.59.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 21 Oct 2016 16:59:55 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, j6t@kdbg.org, Johannes.Schindelin@gmx.de
Cc:     git@vger.kernel.org, venv21@gmail.com, dennis@kaarsemaker.net,
        jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/3] t7506: fix diff order arguments in test_cmp
Date:   Fri, 21 Oct 2016 16:59:37 -0700
Message-Id: <20161021235939.20792-2-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.507.g2a9098a
In-Reply-To: <20161021235939.20792-1-sbeller@google.com>
References: <20161021235939.20792-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the argument order for test_cmp. When given the expected
result first the diff shows the actual output with '+' and the
expectation with '-', which is the convention for our tests.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7506-status-submodule.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index d31b34d..74cb6b8 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -260,7 +260,7 @@ test_expect_success 'diff with merge conflict in .gitmodules' '
 		cd super &&
 		git diff >../diff_actual 2>&1
 	) &&
-	test_cmp diff_actual diff_expect
+	test_cmp diff_expect diff_actual
 '
 
 test_expect_success 'diff --submodule with merge conflict in .gitmodules' '
@@ -268,7 +268,7 @@ test_expect_success 'diff --submodule with merge conflict in .gitmodules' '
 		cd super &&
 		git diff --submodule >../diff_submodule_actual 2>&1
 	) &&
-	test_cmp diff_submodule_actual diff_submodule_expect
+	test_cmp diff_submodule_expect diff_submodule_actual
 '
 
 test_done
-- 
2.10.1.507.g2a9098a

