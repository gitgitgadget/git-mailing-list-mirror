Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67D2D1F516
	for <e@80x24.org>; Mon,  2 Jul 2018 00:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752968AbeGBAZQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 20:25:16 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51493 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752729AbeGBAZB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 20:25:01 -0400
Received: by mail-it0-f65.google.com with SMTP id o5-v6so8852735itc.1
        for <git@vger.kernel.org>; Sun, 01 Jul 2018 17:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=psgz7Ix50qSH2/HkKCTvpMKi4Fo+buIhUXHCtWvw/Rg=;
        b=KRDe2ORBrXv4c1VV4oJlmWwJLWi8AYGkgQ/nk8OfeP/RVrv3bj1cy3swqv4g5cXoal
         jqGgc7pO2t0nlZ/y+rLbPXSIVrFsicuQFHojRg4BNAxFpZVmL5+sKjwtU7KG7u0HNZmX
         ldQiua1LQrCKfhUSfNAgdfDRmxgW3LZesn1W5nZx2kh+E7+Wqysmr6rx4490GaeuI6bL
         uFrtGR5DQhZ6fz+HVCGq/p81zPK4PPDlHAsn/MlNhKAr/P77hwrwPk5KXYd2h0dH5iJX
         X6igZNu3AjJQpYJHe0TQ9jnVn7VHbRQj8Qlp0dXHFAHRaH6FYw9BXmQTUMO7IGxW2hXu
         GmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=psgz7Ix50qSH2/HkKCTvpMKi4Fo+buIhUXHCtWvw/Rg=;
        b=owKhyIiw2Pj0RNGMCFeP8whjyOzm/joeCoUKVUHt+p4BSOpbW+1OhkaO9L3HPoFD3F
         4k02u2zMtGzAP2ymCyGkoEbUB+AQe1jv3k640ld+z8JLZ4zmw8uwix35J6blFrGEZjNf
         A+67YdBE2QTNSyrCouf+oeJFT8qv5NPAgs28R0E9BJXCrHw6Y8b7FJgsbguqaUcQUZJk
         p6f9MYy/ES4S5tHGcDEXyERi7NaOXjeVPWBhZKcn0d8vqbze+two8ICaWJptejQJr6ho
         UBYIm1J5qP2bBqzvFWRgN4WFJQAWLs3yvZr7Sx28KpYC1pPWGJJ07yS/KGWcODgDqkkF
         BVFQ==
X-Gm-Message-State: APt69E2RLIjvKgdhVumRwRTDzYkfbpHnCXCa9guYrFqDFhEtF6OXITsX
        0oAX3aXB4vv71flr7fJHCE5hNA==
X-Google-Smtp-Source: AAOMgpedfwgRhZ0ZtqyYEoZHb7E8s4hz35orF7Bc0mGb4RQ3DekYsPC5NDxtvRCwLimpTsN5EVNSgg==
X-Received: by 2002:a24:78e:: with SMTP id f136-v6mr7858459itf.89.1530491100933;
        Sun, 01 Jul 2018 17:25:00 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id o143-v6sm3302562itb.42.2018.07.01.17.24.59
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 01 Jul 2018 17:25:00 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 12/25] t7810: use test_expect_code() instead of hand-rolled comparison
Date:   Sun,  1 Jul 2018 20:23:52 -0400
Message-Id: <20180702002405.3042-13-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180702002405.3042-1-sunshine@sunshineco.com>
References: <20180702002405.3042-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test manually checks the exit code of git-grep for a particular
value. In doing so, it intentionally breaks the &&-chain. Modernize the
test by taking advantage of test_expect_code() and a normal &&-chain.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t7810-grep.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 1797f632a3..fecee602c1 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -845,10 +845,9 @@ test_expect_success 'grep from a subdirectory to search wider area (1)' '
 test_expect_success 'grep from a subdirectory to search wider area (2)' '
 	mkdir -p s &&
 	(
-		cd s || exit 1
-		( git grep xxyyzz .. >out ; echo $? >status )
-		! test -s out &&
-		test 1 = $(cat status)
+		cd s &&
+		test_expect_code 1 git grep xxyyzz .. >out &&
+		! test -s out
 	)
 '
 
-- 
2.18.0.203.gfac676dfb9

