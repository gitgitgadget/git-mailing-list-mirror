Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A95821F461
	for <e@80x24.org>; Sat, 17 Aug 2019 18:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfHQSmB (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 14:42:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33997 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfHQSmB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 14:42:01 -0400
Received: by mail-pl1-f193.google.com with SMTP id d3so1968772plr.1
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 11:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nSKGB0GuHLighFHkeVNGSxxY8rv4BjolX5UrR9B88t8=;
        b=dKcTldGE0G7Kr+BYTqt1EwcCq9aEfZPbzV+QmIZlU/SwSZzjT8XrHUJcVTmFVIvXIQ
         tO8/6PTkLOTNgZ0QBtMRm9oS20dF4ZbUNwUWSKzUAp52eF9ePmsLPhPthCA7O/wqnpdR
         pM4MAvoIQNMqMV3+KERXcIzhdXIvW0ActDKVG6Cyens5t+VIgi6+e4EIHXXGWeKkX2Cs
         vx6CzMMsqOGpNlUH13omROrrhAwB0qmaNUS6vlylzkdv9sNsA4poKzrtaSkYZ9CKsgiB
         xmZf+8Uba14dJ3PAH8b/S/b8nrzB/ufkpzVUgC9L59w3VwZu2kS+33o7jtkxAq0imSY2
         SBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nSKGB0GuHLighFHkeVNGSxxY8rv4BjolX5UrR9B88t8=;
        b=skMe1KvQDLh71SpI1c/tCa7k/Jr+d2oAScsm2JS95c4KkFTifayQlu63qc2Ga1P7bj
         L4EakMYvTWIYLix4KaVzClx0es5wVs+cRZqfnotVzg8Wp/ca8X36ZSq2IdVMjp6QxtwT
         1bZSRZJwixngHjLML/xkRNG5mK6zdST5bJhhmCTC8A6uYmW0pWfR1Naf9EvNQ9Jt5TOu
         Ho/Tu8Jo/GZRmKsjp1tuQj/l/07rmYiB+EnQScUY+eHXaHcuAPJaVyPSSv60Ep92RQSV
         f6I/aFaqJZvwpwHgpGImPgWFf5oZ2rdzNundjeYNxsQ0yBP8+7Av4jlJhcvLWYwUf2RE
         85rQ==
X-Gm-Message-State: APjAAAVLW5uVMoSe5Pz6y3mlYZGFE0TX+C04AlYZsHhOxLUUVhjASJfm
        ESthE1VeoQVjy5RVi9hh+Cqjx6Gw
X-Google-Smtp-Source: APXvYqyMZxZtPgYpNj8Cyi3Zdk9zoMK+3UGnh2YbSI9bByAuJqdxBaxFP+Zvrnsh87yHxQ9ZhnUMoA==
X-Received: by 2002:a17:902:246:: with SMTP id 64mr9803979plc.112.1566067320406;
        Sat, 17 Aug 2019 11:42:00 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j15sm9990422pfr.146.2019.08.17.11.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 11:41:59 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 01/24] merge-recursive: be consistent with assert
Date:   Sat, 17 Aug 2019 11:41:21 -0700
Message-Id: <20190817184144.32179-2-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.28.g5f89f15d7b.dirty
In-Reply-To: <20190817184144.32179-1-newren@gmail.com>
References: <20190815214053.16594-1-newren@gmail.com>
 <20190817184144.32179-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 8daec1df03de ("merge-recursive: switch from (oid,mode) pairs
to a diff_filespec", 2019-04-05), an assertion on a->path && b->path
was added for code readability to document that these both needed to be
non-NULL at this point in the code.  However, the subsequent lines also
read o->path, so it should be included in the assert.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 6b812d67e3..1d960fa64b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1043,7 +1043,7 @@ static int merge_3way(struct merge_options *opt,
 		}
 	}
 
-	assert(a->path && b->path);
+	assert(a->path && b->path && o->path);
 	if (strcmp(a->path, b->path) ||
 	    (opt->ancestor != NULL && strcmp(a->path, o->path) != 0)) {
 		base_name = opt->ancestor == NULL ? NULL :
-- 
2.23.0.rc2.28.g5f89f15d7b.dirty

