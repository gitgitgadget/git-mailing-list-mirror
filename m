Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28CFE201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 23:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbdBXXvO (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 18:51:14 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33140 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbdBXXvL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 18:51:11 -0500
Received: by mail-pg0-f54.google.com with SMTP id z128so17263588pgb.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 15:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jSU16u9odxC3+ey4052ikSa5Pad2YJkUz4vliCHxv+c=;
        b=L7Rin5C0AMbJikPT1g//28oVGbAH21ziiflqRP3dbexuMAvubcC2d/8J8S5VGx6ucj
         7JSmB88bolWodzmeA3VY0AzpnxAOM8KHpcfw6fpvpZP6nWiJ/ixnT4VHwJTEQHsIESnp
         JvdsBAL/wRMUFQbBNUI+ueI2ZkJwKjqCY1Cze6SJHwUljuuecmvqTRc4rjMel4VpP8Uy
         Hcfn6GH7T2iNk9X8brIp525zr2PwAjJgeNYtJVDZNRpdwRmUb9YE9ka6Pd38d4afo0t8
         GVpLP35FQ03ibr1TURhS6AYFMHooEznp14e2PPFvy6mQu6gRvQypAYzvMymm22UOiz7e
         wvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jSU16u9odxC3+ey4052ikSa5Pad2YJkUz4vliCHxv+c=;
        b=QpZ5zH41Wi8dsC0Bw5iPIdJC8N8XhKEMQVDswXTvPuOU42lqft0FRAfmc1pgYnpED9
         k3p3WETJ0j0X9uhzIyHJ360nsr5e8W+QCZGLC6AXzg7yPTQqjA/i+4geROQPCp/10HQA
         ZVjr+1Lqt1gepvNYNG25VACdaWum7uJIREgWGITzKnxgKqnzb0HIHA4bEzQdRmKSkfQG
         j+QqxBPDWFGhtbXR09Q2kjeCCZShj97TwdZzRJOUEKwoyG6VamurL6rDmHjuux39N5bX
         w46VqrwpiwvEM9UZIWd5UImLC/HB5+A9ViQKo2XwYuA6G7zEwg1CRsWX0ogJmSX3iknK
         lxCw==
X-Gm-Message-State: AMke39k5JLd1sdpMaePp0HWr16RaNt8Tewynhwsbap42BTX2CocxioT4PdNgfqX4nRv414ya
X-Received: by 10.99.215.5 with SMTP id d5mr6886416pgg.51.1487980270383;
        Fri, 24 Feb 2017 15:51:10 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id v69sm17048236pgd.18.2017.02.24.15.51.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 15:51:09 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com
Subject: [PATCH 2/5] pathspec: add PATHSPEC_FROMROOT flag
Date:   Fri, 24 Feb 2017 15:50:57 -0800
Message-Id: <20170224235100.52627-3-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170224235100.52627-1-bmwill@google.com>
References: <20170224235100.52627-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the `PATHSPEC_FROMROOT` flag to allow callers to instruct
'parse_pathspec()' that all provided pathspecs are relative to the root
of the repository.  This allows a caller to prevent a path that may be
outside of the repository from erroring out during the pathspec struct
construction.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 2 +-
 pathspec.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/pathspec.c b/pathspec.c
index 7ababb315..ff622ba18 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -353,7 +353,7 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 	if (pathspec_prefix >= 0) {
 		match = xstrdup(copyfrom);
 		prefixlen = pathspec_prefix;
-	} else if (magic & PATHSPEC_FROMTOP) {
+	} else if ((magic & PATHSPEC_FROMTOP) || (flags & PATHSPEC_FROMROOT)) {
 		match = xstrdup(copyfrom);
 		prefixlen = 0;
 	} else {
diff --git a/pathspec.h b/pathspec.h
index 49fd823dd..cad197436 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -66,6 +66,8 @@ struct pathspec {
  * allowed, then it will automatically set for every pathspec.
  */
 #define PATHSPEC_LITERAL_PATH (1<<8)
+/* For callers that know all paths are relative to the root of the repository */
+#define PATHSPEC_FROMROOT (1<<9)
 
 extern void parse_pathspec(struct pathspec *pathspec,
 			   unsigned magic_mask,
-- 
2.11.0.483.g087da7b7c-goog

