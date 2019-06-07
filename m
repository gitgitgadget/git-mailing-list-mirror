Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 735AA1F462
	for <e@80x24.org>; Fri,  7 Jun 2019 01:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfFGBJ0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 21:09:26 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:38860 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFGBJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 21:09:26 -0400
Received: by mail-vk1-f202.google.com with SMTP id q191so149549vkh.5
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 18:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2hd/7vgoTSTtZbgrss4lNyuf40Z0SlsWEf0GCTpiPV0=;
        b=gElfw3nxMKx7XifK/nYTw7AMwNg6quXPmll7awXXiiOQScby3fxBkvJmMKoFmH8fqu
         nit4tiI/VKnD8R7OChtDlZ4ZAsUkp2Fvw1lDysRND5ia8a/wrEWbx4A9XkBc0AsK/N+j
         wtayaqZRj0Iput7B2d2tizjOVZbdvVWJnbm0n4tPjJVElz8T+J7AldjovkO2A/f94iKx
         YGE2FO00epHrDtWeJlxfrbgK5rUw7/BMF9Thz1s/h1fc8mqp1Hs45XdgyHiCEg2gXv1T
         JaRTnXiWz9jn4d2oFWNYC9Y+30IUIiAbXm/4fvREDh0Fh8nF5cIav2SS6S2gD4Gf/tN6
         t1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2hd/7vgoTSTtZbgrss4lNyuf40Z0SlsWEf0GCTpiPV0=;
        b=I+9Cmpwx8H8q6IWh96PcPACkNe/deQjDnI/NBYEcEFe68+Y1mGYxGs/qX6ck6gs+lF
         WkoT754PaIKRKBI47jg6sjLxm08xqRslRvJWvLe+5+hqHr5NzuHYKoco2ejZrtlqIpNZ
         7Wp3XNo+k4fO2CUEdkMEnRmtkKfRvSVX3yhOig5V8aLhLOhTOXfNLNDIMK+8EM8wO8wR
         L35luPWmKTy7VK6A4bnYs17Jo+StHvmY4oiNe2aQTxB2fAohqNY83D9gk99HYqybWZCi
         tNurBb8TaR9ubfYNdRa4NGoTZZbVkjQiwhaCuHQMGb8u4tlZ6hE0HKMkjtTsOXZq7gBs
         XEmg==
X-Gm-Message-State: APjAAAVQyDlps9Av+smYAPqLPRz1WPbp8CTApkxhTUozwnlhmgO0jDXR
        soCYYDDcG5KTs3y3EkrWHRgO1r3mXTYxJ79VkNujaiUbVEqlB3t+CnUL61ekX84Qk64cJJQcchY
        PBCTy4yfL8EiUhggCTzZ4bbHJPw8gVUF7NxnhRiKgcuKd5bq59uCY6wUpXu5ZImyvlmWWHcojhQ
        ==
X-Google-Smtp-Source: APXvYqzf1M88N6RLF4htxc6grnYttxRMKA1ZWCdTCEm8R+mKiQdLKJQV76E8gDBM7sQ6KZz8kZUITgCFlKwXflUWgog=
X-Received: by 2002:ab0:1004:: with SMTP id f4mr17827103uab.79.1559869764551;
 Thu, 06 Jun 2019 18:09:24 -0700 (PDT)
Date:   Thu,  6 Jun 2019 18:08:10 -0700
In-Reply-To: <20190607010811.52944-1-emilyshaffer@google.com>
Message-Id: <20190607010811.52944-13-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190607010708.46654-1-emilyshaffer@google.com> <20190607010811.52944-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [RFC PATCH 12/13] walken: count omitted objects
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It may be illuminating to see which objects were not included within a
given filter. This also demonstrates, since filter-spec "tree:1" is
used, that the 'omitted' list contains all objects which are omitted,
not just the first objects which were omitted - that is, it continues to
dereference omitted trees and commits.

This is part of a tutorial on performing revision walks.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/walken.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin/walken.c b/builtin/walken.c
index f2c98bcd6b..d93725ee88 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -137,6 +137,9 @@ static int walken_object_walk(struct rev_info *rev)
 {
 	struct list_objects_filter_options filter_options = {};
 	struct oidset omitted;
+	struct oidset_iter oit;
+	struct object_id *oid = NULL;
+	int omitted_count = 0;
 	oidset_init(&omitted, 0);
 
 	printf("walken_object_walk beginning...\n");
@@ -172,9 +175,15 @@ static int walken_object_walk(struct rev_info *rev)
 			walken_show_commit, walken_show_object, NULL, &omitted);
 	}
 
+	/* Count the omitted objects. */
+	oidset_iter_init(&omitted, &oit);
+
+	while ((oid = oidset_iter_next(&oit)))
+		omitted_count++;
+
 	printf(_("Object walk completed. Found %d commits, %d blobs, %d tags, "
-	       "and %d trees.\n"), commit_count, blob_count, tag_count,
-	       tree_count);
+	       "and %d trees; %d omitted objects.\n"), commit_count,
+	       blob_count, tag_count, tree_count, omitted_count);
 
 	return 0;
 }
-- 
2.22.0.rc1.311.g5d7573a151-goog

