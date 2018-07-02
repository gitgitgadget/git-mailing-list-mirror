Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DA291F516
	for <e@80x24.org>; Mon,  2 Jul 2018 00:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753025AbeGBAZ6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 20:25:58 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45899 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752733AbeGBAY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 20:24:58 -0400
Received: by mail-io0-f195.google.com with SMTP id l25-v6so13210576ioh.12
        for <git@vger.kernel.org>; Sun, 01 Jul 2018 17:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1GVSZj4MKVSD46xnquXhlCZuLPhKE2nRNfM5GtgwieU=;
        b=MsjHqiKbSJUYIuiKtiGBhm71ld8Plp0d2wILDDN4o+l0mfFlSHwe+q9bf79eEVgGeB
         h1ENxLU7PAD8IiFyTCegZ39Wse5nl8+YDDd4qU9wGccQCfkPcGj+9v23MyShcWHNsY6k
         a17uHQgKQ3NAzadhZOK4m9j9jaaX5lJ6fhpZFmtQv331qZ3q1GTorDMCQSFgI6XnymZp
         1X1dP5UjQN0G4oTptZhlF1ixhol0iE8H5iPMa9vIqEaGE051HUgfiPSgGmGK61xHvuAP
         b0vQV5EcvUeTnn5wPGkbali/8JPM24YMsiGBwHVbQjmFJKiN6dJOGVyQK5QRfjITlqFn
         /hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=1GVSZj4MKVSD46xnquXhlCZuLPhKE2nRNfM5GtgwieU=;
        b=aAmJkRQQNcR/IlF90FpOt9+yW4eIaRzFbKRZm5I+QSGaIb0D/yMr64ug//3neVIw6j
         lNT0NGpN7I8ArcLQuGpJRXXMNlHCpu+8BQExVdLlAt3qBTqwpH6uy/u1DzHsVDBUzEB1
         iSuOXlIxeh8NrIjVZxZoMieIQ+LSBjn6o4j6qbUsEkGq4LaidYADa81tbamsxRld2hvl
         JYkWJDgBxJtnn2GZO9PSMOHpPo8adOeFBx9NFDC8Pzgby4wSGdevJoYUt9Tp/41gYEEN
         Byd8kSgTIHAC2TCZuTSNQou2seDp4SEhMkVSUglUmEkJgYU6eR18v5Myx0kcxdwQ7WCR
         b8uA==
X-Gm-Message-State: APt69E1dj4g9EUWiTbkvobHcv0coOssXZqy+z2STfrThyM/PawewteYY
        /wXxfODWhIXeonmldOBZrseQjg==
X-Google-Smtp-Source: AAOMgpfs0QNHj39DwT+lvtyIurzYQPKTcGpZGsFVCZpAS7QcZcSHvXKUCk6o2Upq85rzJAlIypgi+Q==
X-Received: by 2002:a6b:343:: with SMTP id 64-v6mr12162632iod.66.1530491097980;
        Sun, 01 Jul 2018 17:24:57 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id o143-v6sm3302562itb.42.2018.07.01.17.24.56
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 01 Jul 2018 17:24:57 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 09/25] t6036: fix broken "merge fails but has appropriate contents" tests
Date:   Sun,  1 Jul 2018 20:23:49 -0400
Message-Id: <20180702002405.3042-10-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180702002405.3042-1-sunshine@sunshineco.com>
References: <20180702002405.3042-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These tests reference non-existent object "c" when they really mean to
be referencing "C", however, these errors went unnoticed due to a broken
&&-chain later in the tests. Fix these errors, as well as the broken
&&-chains behind which they hid.

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t6036-recursive-corner-cases.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index b5621303d6..b32ff8e1db 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -506,10 +506,10 @@ test_expect_success 'merge of D & E2 fails but has appropriate contents' '
 		test_line_count = 2 out &&
 
 		git rev-parse >expect    \
-			B:a   E2:a/file  c:a/file   A:ignore-me &&
+			B:a   E2:a/file  C:a/file   A:ignore-me &&
 		git rev-parse   >actual   \
 			:2:a  :3:a/file  :1:a/file  :0:ignore-me &&
-		test_cmp expect actual
+		test_cmp expect actual &&
 
 		test_path_is_file a~HEAD
 	)
@@ -533,10 +533,10 @@ test_expect_success 'merge of E2 & D fails but has appropriate contents' '
 		test_line_count = 2 out &&
 
 		git rev-parse >expect    \
-			B:a   E2:a/file  c:a/file   A:ignore-me &&
+			B:a   E2:a/file  C:a/file   A:ignore-me &&
 		git rev-parse   >actual   \
 			:3:a  :2:a/file  :1:a/file  :0:ignore-me &&
-		test_cmp expect actual
+		test_cmp expect actual &&
 
 		test_path_is_file a~D^0
 	)
-- 
2.18.0.203.gfac676dfb9

