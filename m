Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1DE51F516
	for <e@80x24.org>; Sun,  1 Jul 2018 01:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbeGABZa (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 21:25:30 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40105 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbeGABZR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 21:25:17 -0400
Received: by mail-oi0-f65.google.com with SMTP id w126-v6so4451811oie.7
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 18:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v6W99SuCdAaJ3rKJkOoyi2mGFndUpvaEStoIeP6cgqE=;
        b=DohRid9+10reRAyUSBl8yrgxaQNSl1/nU/3Ni1QgqudLC7PrkzXPJ2TJm1h4KHM5jf
         vQ7U0XGCFD2L166d8e6L1XuP/Hr0wq/VkoKkS0EmYvcatz3J9uGsqnubswlkQ1lB87Pt
         tXAfjdmkpsocQKOf/1ktqGAPn77BU2UZC4u29WLQM3ERfEjn3YVrtqaxMU346irfLdIC
         sXiwVK7HomRcYoABhLB2dCdCN46+tf4SzLTFLI55PMPKBo2ujnqb4zx6zYjxLBjhmzTc
         7beLbGzRsD91jwKTP9SxPmoZ2I6I1P9MkL6RN8lF2QidEWMPIdWpcMjpW55ghWuLFwdu
         wKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v6W99SuCdAaJ3rKJkOoyi2mGFndUpvaEStoIeP6cgqE=;
        b=JTegdWx5ohptPF+iJOPahb1Qhpao96NCMP0NVqT5+Uzi8KQTe/9wszIRzYyj9eb+nW
         caSR/aNBusEFdlZEZL1+ZwY0461aSXCr/XQUQtkPj1C/tvz7Sad0234MDIDjZ7baigCA
         zKRJK9hOrww1rdJAeq4Tqj72/CQ5+6Hu7ENB7d+zO6JjmOJH0kf++n+GafbD05tNBE64
         p0kCJt+yB66EK8y6RGeXeWVukEEy2tFceSsmC5F3U/wUyAldjNWBxUhRcgqOvCJwrf2g
         5qVHeFxv34ZJOf+bdeGI+cR9yR1DQZWApnxfwm6TiU20RGaFgJ3fraIGRjprkKDLuXD2
         4MWQ==
X-Gm-Message-State: APt69E1wkjprgi+sDC0g/F82NB1xREzT2wDjxypVkp6kg/DIbdk5UX3G
        EzYkHMXYRcdPAhggO3nMgGqbNQ==
X-Google-Smtp-Source: AAOMgpcEG8VswwzfVWiNUCJ/exXr3K7rULfQBao1nEBAucLUdvonYZ0BN0REet5SD9uVj9qiKwwEew==
X-Received: by 2002:aca:c692:: with SMTP id w140-v6mr10978392oif.284.1530408316305;
        Sat, 30 Jun 2018 18:25:16 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id g20-v6sm3509394ote.38.2018.06.30.18.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 18:25:15 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 5/9] merge-recursive: make sure when we say we abort that we actually abort
Date:   Sat, 30 Jun 2018 18:24:59 -0700
Message-Id: <20180701012503.14382-6-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.137.g2a11d05a6.dirty
In-Reply-To: <20180701012503.14382-1-newren@gmail.com>
References: <20180603065810.23841-1-newren@gmail.com>
 <20180701012503.14382-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 65170c07d4 ("merge-recursive: avoid incorporating uncommitted
changes in a merge", 2017-12-21), it was noted that there was a special
case when merge-recursive didn't rely on unpack_trees() to enforce the
index == HEAD requirement, and thus that it needed to do that enforcement
itself.  Unfortunately, it returned the wrong exit status, signalling that
the merge completed but had conflicts, rather than that it was aborted.
Fix the return code, and while we're at it, change the error message to
match what unpack_trees() would have printed.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                        | 4 ++--
 t/t6044-merge-unrelated-index-changes.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index f9384fabf..9c0699be5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3267,9 +3267,9 @@ int merge_trees(struct merge_options *o,
 		struct strbuf sb = STRBUF_INIT;
 
 		if (!o->call_depth && index_has_changes(&the_index, &sb)) {
-			err(o, _("Dirty index: cannot merge (dirty: %s)"),
+			err(o, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
 			    sb.buf);
-			return 0;
+			return -1;
 		}
 		output(o, 0, _("Already up to date!"));
 		*result = head;
diff --git a/t/t6044-merge-unrelated-index-changes.sh b/t/t6044-merge-unrelated-index-changes.sh
index 92ec55255..3876cfa4f 100755
--- a/t/t6044-merge-unrelated-index-changes.sh
+++ b/t/t6044-merge-unrelated-index-changes.sh
@@ -116,7 +116,7 @@ test_expect_success 'recursive' '
 	test_path_is_missing .git/MERGE_HEAD
 '
 
-test_expect_failure 'recursive, when merge branch matches merge base' '
+test_expect_success 'recursive, when merge branch matches merge base' '
 	git reset --hard &&
 	git checkout B^0 &&
 
-- 
2.18.0.137.g2a11d05a6.dirty

