Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA28A1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 22:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbfILWMx (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 18:12:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33327 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729456AbfILWMw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 18:12:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id n190so14204791pgn.0
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 15:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=THev88kukGSpJfT1nKOWfVG+AAU39sH5fy+9GsGQDzg=;
        b=BaFQJutkRi2Sd4Ycs89UqUv7pdjhsxMq4abFb7Y2Oc2IakXKg74KUyD1lHrmMg+ugv
         UmH9HDNILpZK0GVWZrse1tPhwzALIQX0LrZsmS/AVDPTRFxcoIFWdzZEUm9kV0u0VASd
         VZEa45h95olBy8Vvgj7Jlb2YnD18rJ2u//idlNmOtQs4dHdRA+JQy1d9LdLVtqC25w+t
         zV2OXuQ7WOloYL2xkm28dLhyFIrU6m+ZDCdCzgSgfNyeY99k0Kk0R1jK9xRYOkVvWKUY
         RwbDbevJGD1nufsQf4nOh7K3ogKD92gd+OKgDH9px57PimOkiNgPJ1AL392JYyxFHxF5
         JEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=THev88kukGSpJfT1nKOWfVG+AAU39sH5fy+9GsGQDzg=;
        b=dTvI60n7HmhCPasj36c97YkG6gdwqjzkYt4ajqgsDBWqxWIZMB1Dwncs68lyF7rNJM
         vYa7LoGa4g6WxJUCN801BtFFhOQxkUENslouWyS5jMHG5AKizRKTQSD0MgsOZf+77BEW
         C5kQj0hAHX9/fJi6wHZJ/8woCRRi8fSYhow1sQa/Q4f/DJecF8it1tYVs4moo058ohWA
         7fkGjthbG1NJ78i4oWBjf6xt6XTWO6aq7P0nahbtGfZ2hFYiDFv+fJgFsILXB1mSyJlk
         /aGCXnDoN8UeNNK6msrOV7067Bwj7q5zwtsf6nJSXo/cBX0AtTPRahL3pT/Lx6ear4BR
         HALw==
X-Gm-Message-State: APjAAAUaUtTkW7QMoEDRmL4Rn/hsOunawmEXt55jfxJ0WSewDWN/9cSp
        Kbf0QjJPlVe9BFdJv0ujEzvyQt6QP8Q=
X-Google-Smtp-Source: APXvYqxZRqJKbKuCCV/uHTGtSw81DSYwO0QnJJqeOW60lMD5lfD07HI16tB5L7mBjryNulR8VRA4+g==
X-Received: by 2002:aa7:96ab:: with SMTP id g11mr44478383pfk.61.1568326371515;
        Thu, 12 Sep 2019 15:12:51 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id y13sm24358188pfn.73.2019.09.12.15.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Sep 2019 15:12:50 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 05/12] dir: make the DO_MATCH_SUBMODULE code reusable for a non-submodule case
Date:   Thu, 12 Sep 2019 15:12:33 -0700
Message-Id: <20190912221240.18057-6-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.173.gad11b3a635.dirty
In-Reply-To: <20190912221240.18057-1-newren@gmail.com>
References: <20190905154735.29784-1-newren@gmail.com>
 <20190912221240.18057-1-newren@gmail.com>
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
2.23.0.173.gad11b3a635.dirty

