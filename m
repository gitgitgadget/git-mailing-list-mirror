Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A01271F461
	for <e@80x24.org>; Thu,  5 Sep 2019 15:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732984AbfIEPrs (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 11:47:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35406 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731868AbfIEPrr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 11:47:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id gn20so1493622plb.2
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 08:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xbEe6xBurjeCypeKdNKCVn/ZoVPDMQbLGXSHlLi9Kzc=;
        b=dEIVIow7xT8XWmCPrkomiA/2zgaQsPiltDYNkCUdcMi7zaT3KdQ5RaaA8OV31GNUj7
         ZNJ0ivslR/pUPFwl6yWmj1QDam4ozDEvvsXsBQx8M/cKrgKMO1COZJ/Fo/GW0DoFSljO
         i7GlS87JAUpGCFYAbI232OZKb4YLQ34MrGYsP8EhmUFvMEEGr4GmGNE52DR1FKiqlfGN
         spQRKL7vZqr7oSs2tR3OvnxZRkpThZ3ewX4zLI3bIt/Dn32wEn+e0oy+iQ7/Y5z8C+Og
         Fmdo7GLLTCrjemjsLn8scLTUF45z2t73kYSeblj87dglkm+rpfz5QOzmuNHFrXdoRFUR
         uX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xbEe6xBurjeCypeKdNKCVn/ZoVPDMQbLGXSHlLi9Kzc=;
        b=RuGJIHjWQi56OrSeabZUuPiAcHJrhhkEMEAGwkrcBoZheyJFJrEbFqcFreSz08tdZb
         IPUgUbUnOPf2xRqocXn+P57Md0dtljR8MOddNCTb0MZioCj1Ud2cbTVbSK1MhkyMSG6D
         CQWY4m9h8p+Nes9HNPIHi4g/xk6ZoW8XKvGWdo6UtxMUb6eQ6lnEJCo3NffYfU6CVo1k
         bWow1LBrWN3O3z7pVmXPvTJSFlpw4gDSQo6AovfIQjnn5QU+w5nx3nMgoDDum/jsgUTC
         FcAwvY765X6OwNxgdowIyqCbM1L6wK2rcNMa1V639uXfE1gSonClTZoU5MQWoTgD7CCM
         gjdA==
X-Gm-Message-State: APjAAAVQg6rNdnq8G/ZTRkLpZsrQ6U7rYJVd2tM0c0H5UzVm39Pa58wx
        ncErt3VR8cHSple+CNkcfKz6QTgh
X-Google-Smtp-Source: APXvYqw7aWLi7CyaqWMNdb6Z6jMH1X+IEfxhXH0qcj0OF9EDHTU34xuOQ7O+EGrRmSgLa8k7MEJXOA==
X-Received: by 2002:a17:902:222:: with SMTP id 31mr4240682plc.167.1567698466268;
        Thu, 05 Sep 2019 08:47:46 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id x16sm2339867pjn.12.2019.09.05.08.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Sep 2019 08:47:45 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v2 05/12] dir: Make the DO_MATCH_SUBMODULE code reusable for a non-submodule case
Date:   Thu,  5 Sep 2019 08:47:28 -0700
Message-Id: <20190905154735.29784-6-newren@gmail.com>
X-Mailer: git-send-email 2.22.1.11.g45a39ee867
In-Reply-To: <20190905154735.29784-1-newren@gmail.com>
References: <20190825185918.3909-1-szeder.dev@gmail.com>
 <20190905154735.29784-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The specific checks done in match_pathspec_item for the DO_MATCH_SUBMODULE
case are useful for other cases which have nothing to do with submodules.
Rename this constant; a subsequent commit will make use of this change.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 76a3c3894b..b4d656192e 100644
--- a/dir.c
+++ b/dir.c
@@ -273,7 +273,7 @@ static int do_read_blob(const struct object_id *oid, struct oid_stat *oid_stat,
 
 #define DO_MATCH_EXCLUDE   (1<<0)
 #define DO_MATCH_DIRECTORY (1<<1)
-#define DO_MATCH_SUBMODULE (1<<2)
+#define DO_MATCH_LEADING_PATHSPEC (1<<2)
 
 /*
  * Does 'match' match the given name?
@@ -354,7 +354,7 @@ static int match_pathspec_item(const struct index_state *istate,
 		return MATCHED_FNMATCH;
 
 	/* Perform checks to see if "name" is a super set of the pathspec */
-	if (flags & DO_MATCH_SUBMODULE) {
+	if (flags & DO_MATCH_LEADING_PATHSPEC) {
 		/* name is a literal prefix of the pathspec */
 		int offset = name[namelen-1] == '/' ? 1 : 0;
 		if ((namelen < matchlen) &&
@@ -498,7 +498,7 @@ int submodule_path_match(const struct index_state *istate,
 					strlen(submodule_name),
 					0, seen,
 					DO_MATCH_DIRECTORY |
-					DO_MATCH_SUBMODULE);
+					DO_MATCH_LEADING_PATHSPEC);
 	return matched;
 }
 
-- 
2.22.1.11.g45a39ee867

