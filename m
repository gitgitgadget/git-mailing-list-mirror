Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AA5C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 07:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344950AbiCUHf1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 03:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242942AbiCUHfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 03:35:25 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32544AA03C
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:33:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mm17-20020a17090b359100b001c6da62a559so3907285pjb.3
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=esbW2+0bS/aEXI6nWZlj3jKCsIYW/DTe+MH1VU3cVqw=;
        b=Q1lChfjbEODZ3+MoGlwrJWEbyH75eQSztbzCfK3zNcnaJr/k82gHn3qYU0Hvwad6qa
         TqDZj8jd2liNl5QgrrHiZDrQroQTPuk9Bo5N7nlQU/ldT1AhMvo54vPlRJ8tniAZhO/w
         ISndE7MxJOwoiVuMyRNdbUZ0ty5ue3XBMY2S+HUfQ6K7OFcOWeqGmRbhqx7T0zEAHosa
         KOBv1dQihYPioU0Ir/UnJLSoqLmirbYTNzFGxA9m5X7vipcM1uXW5VdlZAHFajPNwwfw
         aWN8U/SJkcPxWYS7erGsQz52bt/83TNk5tTgN8oWasagtucqsYDWsWM3lcpzeQZqJisJ
         TITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=esbW2+0bS/aEXI6nWZlj3jKCsIYW/DTe+MH1VU3cVqw=;
        b=pXhxq40JMeUWQJlBS/O1AzXhU+HOyrTcos7cWnoNy31AJsZIMFMdeIAlAzkAEhwHVt
         04nK7YCbCzj9J5237X04yoUZAN/a54wPOIH/MU/U0xgtwtunFcPdDwdZ+fHyFiuN9Y8c
         uOZHSPWGquv7bds7ATN+Dktut4DtBsIlL1pFQtAiDUV/Zm/36RyRLF7eWD0v3cUC9/fO
         25GfNqlx9yYYiiW3vgVZcQW3zWC0T2NUu+y9LlcpikFbEbL4QUW+pPZfg5BQwZ+HGyX8
         EaoYbdx6E7OYKFjeTLKdOGBuHNSQUMBIfDzpr/Q18gP8289K/CC/Eavj/6QIipbQcNsK
         R1/g==
X-Gm-Message-State: AOAM53229PdDL91pfaIySpPEtdyW270uy8kkWT7ECW4x8qxRRQyWlWEp
        iCEo0AYYunxUPdY3aeLD+SJ8mmkVaRohmg==
X-Google-Smtp-Source: ABdhPJxdv2nb+4zzeFtLcutFgqSE8KL2H29y03oLgFVbMxUgTRFEbE/JQ1Y4ovtIZjY9ca3Ucm+qaw==
X-Received: by 2002:a17:90a:af88:b0:1bd:6b5d:4251 with SMTP id w8-20020a17090aaf8800b001bd6b5d4251mr24437105pjq.134.1647848038642;
        Mon, 21 Mar 2022 00:33:58 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.46])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090ad20600b001b8d01566ccsm18914422pju.8.2022.03.21.00.33.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2022 00:33:58 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v13 07/16] ls-tree: fix "--name-only" and "--long" combined use bug
Date:   Mon, 21 Mar 2022 15:33:21 +0800
Message-Id: <25a07e048f25e0efdd2f8690f2e6967352a20e9b.1647846935.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.406.g2e0e55130e
In-Reply-To: <cover.1647846935.git.dyroneteng@gmail.com>
References: <cover.1647846935.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we execute "git ls-tree" with combined "--name-only" and "--long"
, only the pathname will be printed, the size is omitted (the original
discoverer was Peff in [1]).

This commit fix this issue by using `OPT_CMDMODE()` instead to make both
of them mutually exclusive.

[1] https://public-inbox.org/git/YZK0MKCYAJmG+pSU@coredump.intra.peff.net/

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c       | 12 ++++++------
 t/t3103-ls-tree-misc.sh |  9 +++++++++
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index d4be71bad2..7be4c13228 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -123,12 +123,12 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 			LS_SHOW_TREES),
 		OPT_SET_INT('z', NULL, &line_termination,
 			    N_("terminate entries with NUL byte"), 0),
-		OPT_BIT('l', "long", &ls_options, N_("include object size"),
-			LS_SHOW_SIZE),
-		OPT_BIT(0, "name-only", &ls_options, N_("list only filenames"),
-			LS_NAME_ONLY),
-		OPT_BIT(0, "name-status", &ls_options, N_("list only filenames"),
-			LS_NAME_ONLY),
+		OPT_CMDMODE('l', "long", &ls_options, N_("include object size"),
+			    LS_SHOW_SIZE),
+		OPT_CMDMODE(0, "name-only", &ls_options, N_("list only filenames"),
+			    LS_NAME_ONLY),
+		OPT_CMDMODE(0, "name-status", &ls_options, N_("list only filenames"),
+			    LS_NAME_ONLY),
 		OPT_SET_INT(0, "full-name", &chomp_prefix,
 			    N_("use full path names"), 0),
 		OPT_BOOL(0, "full-tree", &full_tree,
diff --git a/t/t3103-ls-tree-misc.sh b/t/t3103-ls-tree-misc.sh
index d18ba1bd84..d9d7fa932f 100755
--- a/t/t3103-ls-tree-misc.sh
+++ b/t/t3103-ls-tree-misc.sh
@@ -23,4 +23,13 @@ test_expect_success 'ls-tree fails with non-zero exit code on broken tree' '
 	test_must_fail git ls-tree -r HEAD
 '
 
+for opts in \
+	"--name-only --long" \
+	"--name-status --long"
+do
+	test_expect_success "usage: incompatible options: $opts" '
+		test_expect_code 129 git ls-tree $opts $tree
+    '
+done
+
 test_done
-- 
2.34.1.406.g2e0e55130e

