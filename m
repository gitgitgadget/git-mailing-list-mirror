Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A33720248
	for <e@80x24.org>; Sun, 17 Mar 2019 06:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfCQGAk (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 02:00:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46877 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfCQGAk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 02:00:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id s23so9062917pfe.13
        for <git@vger.kernel.org>; Sat, 16 Mar 2019 23:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+XupUoyD4IX7onNpglqOOEzWPpoEkM9QKz+29QAVcWQ=;
        b=jAMMaZUXUyiF/7ht6uUCVssvwzcAa9JHfv03mN698NqKrfbBdcsW4J32/+h9Ue5KXL
         2FWJWmCtrEfA3ZkYOcjx+aqG1KFpLWC4xbOpuYN/i9jfYmFGOxXRW6dOz+um73HAyL9x
         6RQOG7HgdvF3PptxBv/qLnO9NxnTEG0gdl+7jOk1U+ah6VtENYDMe692zt/C4s8xFbcI
         iaJK2hfSK3BDKxhCNu+X7I5HptyYhbpIgRNuE47csKzB7HfFEUyXpK9ru7ZSFjYWcSYV
         gM4/wPscDCD8QmZCmx/1P/P/1Ptm7ZS2J7QefDMUi6SPvenlApKwlm8HyOFeRoDn6gKy
         fphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+XupUoyD4IX7onNpglqOOEzWPpoEkM9QKz+29QAVcWQ=;
        b=c7Hb8S9Tscl2mlN71BurpPB1kcTzMRbFVZFS0iqGi+AptnpXuTXfcpFpf/EOgL3kVM
         5Wu5gCNALUhD1TAqS5m9+H/LGXdKjuDIA8M2pqhGp1W8+sOsyAIicdnJmd9HhuajwuLf
         ESt19aufL/xznL+IZk1j/NGMO0QGPqbsHGp6ZYIVnHpMLNSujIjsYKnOPGuNP/2w8bsc
         NESYmVCrj5xMzpeTXSnPs1sOxuwYeKw3cbatA1791sBebswkMCSSBF+xt9iMr3vQd73g
         oB6sly9PdroOB+ohNFalcteGFM7MsA9nL2UCTfRvX3QWiPm4rV+x3bpwIKUaSNXuUn9P
         fxEA==
X-Gm-Message-State: APjAAAWmFaO69jwx39QzB+O4KYAY+pyi+nLD2tuFahMu473F4F1Wlrog
        IqRVR8ebI72CYZE72dB7gFo=
X-Google-Smtp-Source: APXvYqy9VPy0G9Dnt/xz5tWMN3CqlqsWJclrL0HgCo9NQVzryVzNCxe3OoXBL0aQ4MMQKnEFvp0UwQ==
X-Received: by 2002:a17:902:b413:: with SMTP id x19mr13155577plr.256.1552802438935;
        Sat, 16 Mar 2019 23:00:38 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id p86sm12981398pfa.104.2019.03.16.23.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 23:00:37 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Mar 2019 13:00:32 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     phillip.wood123@gmail.com, gitster@pobox.com
Cc:     git@vger.kernel.org, martin.agren@gmail.com, pclouds@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH] unpack-trees: fix oneway_merge accidentally carry over stage index
Date:   Sun, 17 Mar 2019 13:00:23 +0700
Message-Id: <20190317060023.3651-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
References: <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One-way merge is supposed to take stat info from the index and
everything else from the given tree. This implies stage 0 because trees
can't have non-zero stages. The add_entry(.., old, ...) call however
will keep stage index from the index.

This is normally not a problem if the entry from the index is
normal (stage #0). But if there is a conflict, we'll get stage #1 entry
as "old" and it gets recorded in the final index. Fix it by clearing
stage mask.

This bug probably comes from b5b425074e (git-read-tree: make one-way
merge also honor the "update" flag, 2005-06-07). Before this commit, we
may create the final ("dst") index entry from the one in index, but we
do clear CE_STAGEMASK.

I briefly checked two- and three-way merge functions. I think we don't
have the same problem in those.

Reported-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 This is one of the two bugs reported by Phillip. It's not tangled with
 nd/switch-and-restore code changes and I'm sending it separately.

 t/t2026-checkout-force.sh (new +x) | 26 ++++++++++++++++++++++++++
 unpack-trees.c                     |  2 +-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/t/t2026-checkout-force.sh b/t/t2026-checkout-force.sh
new file mode 100755
index 0000000000..272ccf533a
--- /dev/null
+++ b/t/t2026-checkout-force.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+test_description='checkout --force'
+. ./test-lib.sh
+
+test_expect_success 'force checking out a conflict' '
+	echo a >a &&
+	git add a &&
+	git commit -ama &&
+	A_OBJ=$(git rev-parse :a) &&
+	git branch topic &&
+	echo b >a &&
+	git commit -amb &&
+	B_OBJ=$(git rev-parse :a) &&
+	git checkout topic &&
+	echo c >a &&
+	C_OBJ=$(git hash-object a) &&
+	git checkout -m master &&
+	test_cmp_rev :1:a $A_OBJ &&
+	test_cmp_rev :2:a $B_OBJ &&
+	test_cmp_rev :3:a $C_OBJ &&
+	git checkout -f topic &&
+	test_cmp_rev :a $A_OBJ
+'
+
+test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 22c41a3ba8..1ccd343cad 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2386,7 +2386,7 @@ int oneway_merge(const struct cache_entry * const *src,
 		if (o->update && S_ISGITLINK(old->ce_mode) &&
 		    should_update_submodules() && !verify_uptodate(old, o))
 			update |= CE_UPDATE;
-		add_entry(o, old, update, 0);
+		add_entry(o, old, update, CE_STAGEMASK);
 		return 0;
 	}
 	return merged_entry(a, old, o);
-- 
2.21.0.548.gd3c7d92dc2

