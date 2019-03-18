Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 381D520248
	for <e@80x24.org>; Mon, 18 Mar 2019 11:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfCRLis (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 07:38:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45711 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbfCRLir (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 07:38:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id v21so11045339pfm.12
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 04:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZZqCKjJB7Gsmkf6liODCFFSOINWMq2mlNVr/6ojMnUQ=;
        b=sZhgakcNWouVZx/sDcfRNbMA9Q+dqGNBV8M8dQThV3q9eObvyERs3zU+i7jxx/L7pz
         9+EpEe+PwTdlBOImhGTK+87CVLf+EpKwcwiTlfTwiCs5j/azi2NgNL8jOrxwNNMyWZBw
         fGxbhNWTsZVY8NrF3ryxW674tKeOwzsApI21F2FtMgw1EmA3prNfnirNqtcueGoK72R7
         aMMyFEoO8x1y3yO2emWNaQHXarwnHx2bMa9rxm2cYelqW126bQnmFptXDiYhVuBMuZSs
         JBJjUlBz5BYXexmxMgR4ogZJn5lzVvdc15l3k/qL7pR2CMyV3l+a9J+Tp0ASMtockWmO
         8aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZZqCKjJB7Gsmkf6liODCFFSOINWMq2mlNVr/6ojMnUQ=;
        b=p9uFxEVy+gK7SvgBRCCeWbLdN6LY/iwdgrgIuPo/hbfJDvKgC1HR+yDNsUoS3hWYNw
         jaKupzc6pUrKYl893PBSAP1zB0Tf2WmKZ6DuPdnSquCUdN92TM8EZwaOWvPIzT0R6ihO
         dDyPJz0X3Desz9qQa2vtdBzVqsgp+afgXQCI72ytvTvkSWlWYlONeqQreeAhpK+gLSbg
         DggO8y6L9eNXkMwhpfwbUdkyGU32M6XbZKSSTgFYEZE4HxYbyZTleyzxhfsKvhFPrIfd
         +QCp9nDR+uJSbfILhFCk4A6XlfqIHiStLVnx00rylEUB4aUNvWp0v/GvAlmIoiBnSK7/
         LChQ==
X-Gm-Message-State: APjAAAWohBxcnXEYGricN/Cd4Lsp+8RfXLqrZLwwxrDL4y+uWj9jNZh+
        v2KgPmPMbAhah/7LlA/XjMo=
X-Google-Smtp-Source: APXvYqyJ+kkmndX1pNx35GVQQOXm8srF8wqmwyE/onfIaRuFeAcZmOa5FMc7r37S5EAr15I+AibMtQ==
X-Received: by 2002:a17:902:421:: with SMTP id 30mr19012719ple.142.1552909126589;
        Mon, 18 Mar 2019 04:38:46 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id k9sm17092537pfc.57.2019.03.18.04.38.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 04:38:45 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 18 Mar 2019 18:38:38 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v2] unpack-trees: fix oneway_merge accidentally carry over stage index
Date:   Mon, 18 Mar 2019 18:38:22 +0700
Message-Id: <20190318113822.6195-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190317060023.3651-1-pclouds@gmail.com>
References: <20190317060023.3651-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip found out that 'git checkout -f <branch>' does not restore
conflict/unmerged files correctly. All tracked files should be taken
from <branch> and all non-zero stages removed. Most of this is true,
except that the final file could be in stage one instead of zero.

"checkout -f" (among other commands) does this with one-way merge, which
is supposed to take stat info from the index and everything else from
the given tree. The add_entry(.., old, ...) call in oneway_merge()
though will keep stage index from the index.

This is normally not a problem if the entry from the index is
normal (stage #0). But if there is a conflict, stage #0 does not exist
and we'll get stage #1 entry as "old" variable, which gets recorded in
the final index. Fix it by clearing stage mask.

This bug probably comes from b5b425074e (git-read-tree: make one-way
merge also honor the "update" flag, 2005-06-07). Before this commit, we
may create the final ("dst") index entry from the one in index, but we
do clear CE_STAGEMASK.

I briefly checked two- and three-way merge functions. I think we don't
have the same problem in those.

Reported-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 v2 updates log message to describe the problem and moves the test to
 t2023-checkout.m.sh

 t/t2023-checkout-m.sh | 24 ++++++++++++++++++++++++
 unpack-trees.c        |  2 +-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/t/t2023-checkout-m.sh b/t/t2023-checkout-m.sh
index 7e18985134..fca3f85824 100755
--- a/t/t2023-checkout-m.sh
+++ b/t/t2023-checkout-m.sh
@@ -46,4 +46,28 @@ test_expect_success '-m restores 3-way conflicted+resolved file' '
 	test_cmp both.txt.conflicted.cleaned both.txt.cleaned
 '
 
+test_expect_success 'force checkout a conflict file creates stage zero entry' '
+	git init co-force &&
+	(
+		cd co-force &&
+		echo a >a &&
+		git add a &&
+		git commit -ama &&
+		A_OBJ=$(git rev-parse :a) &&
+		git branch topic &&
+		echo b >a &&
+		git commit -amb &&
+		B_OBJ=$(git rev-parse :a) &&
+		git checkout topic &&
+		echo c >a &&
+		C_OBJ=$(git hash-object a) &&
+		git checkout -m master &&
+		test_cmp_rev :1:a $A_OBJ &&
+		test_cmp_rev :2:a $B_OBJ &&
+		test_cmp_rev :3:a $C_OBJ &&
+		git checkout -f topic &&
+		test_cmp_rev :0:a $A_OBJ
+	)
+'
+
 test_done
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

