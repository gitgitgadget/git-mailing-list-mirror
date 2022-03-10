Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4BBC433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 13:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242611AbiCJN6S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 08:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242598AbiCJN6P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 08:58:15 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3CF14FFE1
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:57:14 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id j26so8141760wrb.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zccgqm5NQ33F8V57r3tVB2s+DDzPw+xehfma7K1UOic=;
        b=M+KhgrGKc0LStb44UOpvDg91AiJgilFsl6WCElTRTppxN2NTvMyfGAdexpDMARkRYs
         XzuiJgUteQoOrlN53VxoKHauQK9/8Zf+cywK6Z1LFhFdRpBEOq9/5+YN0Mpzl4wYhd4B
         6hIdBds9snNIK0LYw9ReQm9gZVc4/1vi0m6CZ8EENl7Fdbl8WVEmZ/GKtMu7EGLNIGUJ
         VOs8qZlIqR0lBEZX5DCMm3skX3iYJsMoUykaGom+hZL4ANnQaFp6yp3K960TLAB39dhn
         M+iX/j9RXxQfhVnDmBfhW79YiQgLQoOvGVmdGp1lN3ddn1a/sZxXyOwYb1d4BXkpwt4s
         Liog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zccgqm5NQ33F8V57r3tVB2s+DDzPw+xehfma7K1UOic=;
        b=eHTNgZTc/OUUKOQSq/NWdqgbx9vlki5eDIJAyb3vCoPMNqNTigePkcZfk9zmqPBvo1
         N7qdxuL9O/AGkLgAjWdRWmidFWlb4pKpj8ZRjJpsuAYSFJt5RzVi2keTN+DtlSMyxc3J
         4afQqN4+2wQYutCK/1ttnPvgBjIGWhWIPMHyHt/EyQIEDFt7YUeRVK7v0psOSfqkQQAj
         /5qLDxkqcYqRH2179zx4qhdqC1vX8Lo8dAiv7s1q+ypbde6elbbHht0zLkNnZUV4Lx9D
         tSLZzcKIcMQPLcIP4dLiw3vxVGNKNBoHMXeNYFIRULW360eqv9f2xpuMHB4QJFuBQNZq
         qYwg==
X-Gm-Message-State: AOAM5334sUK68riXJArQCIRFVJ0lzmWC/qEUXiQNXHnkem/lTyArl5rd
        nT9+PjjOTpWBYjRRRAoN4zYkiWQGwmYUbw==
X-Google-Smtp-Source: ABdhPJz3/vCBTKu9ETsz4CkWuIisW+a5kN0uBR2n1XFzgCML10JQcFgwJC6TfvN0lFrbUeywycLwow==
X-Received: by 2002:a5d:6d0f:0:b0:203:9157:1c48 with SMTP id e15-20020a5d6d0f000000b0020391571c48mr865315wrq.192.1646920632707;
        Thu, 10 Mar 2022 05:57:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p2-20020a1c7402000000b0038159076d30sm7737162wmc.22.2022.03.10.05.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 05:57:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>, Johannes.Schindelin@gmx.de,
        congdanhqx@gmail.com, tenglong.tl@alibaba-inc.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/REVIEW 5/7] ls-tree: detect and error on --name-only --name-status
Date:   Thu, 10 Mar 2022 14:57:01 +0100
Message-Id: <patch-5.7-2d2f0fcec62-20220310T134811Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-0.7-00000000000-20220310T134811Z-avarab@gmail.com>
References: <cover.1646390152.git.dyroneteng@gmail.com> <cover-0.7-00000000000-20220310T134811Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --name-only and --name-status options are synonyms, but let's
detect and error if both are provided.

In addition let's add explicit --format tests for the combination of
these various options.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c       | 11 ++++++++++-
 t/t3103-ls-tree-misc.sh | 15 +++++++++------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 95816709d38..528b4e5b5f6 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -52,6 +52,7 @@ static const  char * const ls_tree_usage[] = {
 static enum ls_tree_cmdmode {
 	MODE_LONG = 1,
 	MODE_NAME_ONLY,
+	MODE_NAME_STATUS,
 	MODE_OBJECT_ONLY,
 } cmdmode;
 
@@ -301,7 +302,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "name-only", &cmdmode, N_("list only filenames"),
 			    MODE_NAME_ONLY),
 		OPT_CMDMODE(0, "name-status", &cmdmode, N_("list only filenames"),
-			    MODE_NAME_ONLY),
+			    MODE_NAME_STATUS),
 		OPT_CMDMODE(0, "object-only", &cmdmode, N_("list only objects"),
 			    MODE_OBJECT_ONLY),
 		OPT_SET_INT(0, "full-name", &chomp_prefix,
@@ -327,6 +328,14 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		ls_tree_prefix = prefix = NULL;
 		chomp_prefix = 0;
 	}
+	/*
+	 * We wanted to detect conflicts between --name-only and
+	 * --name-status, but once we're done with that subsequent
+	 * code should only need to check the primary name.
+	 */
+	if (cmdmode == MODE_NAME_STATUS)
+		cmdmode = MODE_NAME_ONLY;
+
 	/* -d -r should imply -t, but -d by itself should not have to. */
 	if ( (LS_TREE_ONLY|LS_RECURSIVE) ==
 	    ((LS_TREE_ONLY|LS_RECURSIVE) & ls_options))
diff --git a/t/t3103-ls-tree-misc.sh b/t/t3103-ls-tree-misc.sh
index ce39158338a..81c63439623 100755
--- a/t/t3103-ls-tree-misc.sh
+++ b/t/t3103-ls-tree-misc.sh
@@ -24,15 +24,18 @@ test_expect_success 'ls-tree fails with non-zero exit code on broken tree' '
 '
 
 for opts in \
-	"--name-only --long" \
-	"--name-status --long" \
-	"--name-only --object-only" \
+	"--long --name-only" \
+	"--name-only --name-status" \
 	"--name-status --object-only" \
-	"--object-only --long" \
-	" --object-only --format"
+	"--object-only --long"
 do
 	test_expect_success "usage: incompatible options: $opts" '
 		test_expect_code 129 git ls-tree $opts $tree
-    '
+	'
+
+	one_opt=$(echo "$opts" | cut -d' '  -f1)
+	test_expect_success "usage: incompatible options: $one_opt and --format" '
+		test_expect_code 129 git ls-tree $one_opt --format=fmt $tree
+	'
 done
 test_done
-- 
2.35.1.1295.g6b025d3e231

