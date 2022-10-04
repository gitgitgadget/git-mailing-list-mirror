Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2FDC433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiJDNZV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiJDNYr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:24:47 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05BB54C87
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:24:20 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o5so8888615wms.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeM+AbE7gOOWUyl5jeCnmW+9IlQjsZorU6TLnAq2oKA=;
        b=FSC8V+qSuT/PFjpqEfVP9Un1LNXGVmrUWG21JVv5FFazl+GQQ7O5nSpZdttvIFuJLP
         RF6GTTiTGCoQ1kjpBXzErk8lsVTx3ZJi0iB49py3QFNCJZeKqbRQbZew+zZrqWLyWs6G
         2yaHd3lfOSTye0rwpDQGLGjX+QJz3AdiCszUGCfW0mdnNrx6TxXk4V+2ChcvBuV2rJSV
         Z12P0+WB85tS/1rSS05ZDoG90XSWk38z6gm36whuOZS0st99c1vjyZwsCwH1YSvTOpMq
         nSn2oxabCQbEOS2xXwyT6HriDLJ9SKdO76Ta90L/VZZSJqjNQemvE0wt4otnzuzfTWi9
         9i7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UeM+AbE7gOOWUyl5jeCnmW+9IlQjsZorU6TLnAq2oKA=;
        b=AKtcYt7lRHKuF5zMLoidG+Oy4vH9gxlOKNb6bK5PqNJKbQXHU+MZUv123mEex0KFpd
         rEWs+UzU8H9HrKXrLWlOtOtYWRmEkEUO7oyBsMK6dM5z3XPCe+lSPESpiKqoG6y9T6TY
         p75lX/hvk/5p1TyA/QsNXsjy3rqjPWWUkNrgV6LjLI+aO4t+hBQjmuR0Umh/Zr6Xc/vF
         cTDIY3vmX59eGCe/1Mls2ZLo56r1aQned5CT//VFQevd/5ykHGeCpMRxiiljvSkQV34S
         MyHnQ+s7Vvjr2PKskQOQWmlPmteZO+wViYSUmIxE/QkSeFnRTl/MFfNZyWlr662YWQeO
         H2Hg==
X-Gm-Message-State: ACrzQf2AiyR4sjAFqnfsHaSMwoYkWukzmMIxqf9E27cWuVfIanbShWTX
        dCJK0nozVMNswYin23YQBBB5MLEYzddm6g==
X-Google-Smtp-Source: AMsMyM68jLSjvoYoWGMO2pHq/J6sxPYwNhr+pc1oOaeERBsxu1Qij0Tyr/n3v0GKlXyU/obqG5ED/A==
X-Received: by 2002:a05:600c:19ce:b0:3b9:c36f:f9e2 with SMTP id u14-20020a05600c19ce00b003b9c36ff9e2mr6276770wmq.110.1664889857855;
        Tue, 04 Oct 2022 06:24:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:24:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 21/34] doc txt & -h consistency: make "read-tree" consistent
Date:   Tue,  4 Oct 2022 15:23:35 +0200
Message-Id: <patch-v4-21.34-2d4fdbd1aa1-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C version was right to use "()" in place of "[]" around the option
listing, let's update the *.txt version accordingly, and furthermore
list the *.c options in the same order as the *.txt.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-read-tree.txt | 2 +-
 builtin/read-tree.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index b9bfdc0a319..7567955bad8 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -9,7 +9,7 @@ git-read-tree - Reads tree information into the index
 SYNOPSIS
 --------
 [verse]
-'git read-tree' [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>]
+'git read-tree' [(-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>)
 		[-u | -i]] [--index-output=<file>] [--no-sparse-checkout]
 		(--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])
 
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index b3a389e1b1f..f4cbe460b97 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -39,7 +39,7 @@ static int list_tree(struct object_id *oid)
 
 static const char * const read_tree_usage[] = {
 	N_("git read-tree [(-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>)\n"
-	   "              [-u | -i]] [--no-sparse-checkout] [--index-output=<file>]\n"
+	   "              [-u | -i]] [--index-output=<file>] [--no-sparse-checkout]\n"
 	   "              (--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])"),
 	NULL
 };
-- 
2.38.0.rc2.935.g6b421ae1592

