Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BD1C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 08:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21F7E610CB
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 08:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhJVI6R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 04:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbhJVI6K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 04:58:10 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A84CC061220
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 01:55:53 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o24so2204178wms.0
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 01:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mQ2t4T/52zeBY2r2c/9A/g+VIPUK1AUBzCE9i3AKqcc=;
        b=l/VZSSwmA3l2PQd5VLxBObSDUbDczxVvGuhbqKSgk6lKe0DsFMWa1vsc18uqoABeDT
         5xHFj5i9zcEOFN2Das0wH56A/hfpnt093aeNccf1j1or+E7l3OfZv0phIR2Jh5f5pD9B
         Xz2LHuAvjxMN5QGFF5fCe5TqmZkgQT2GowNNc+CcwF/dX00JZ10uXzs/RU054jK6PIBk
         7vAeOyiGzRvkXAnMkcGyEDeFhegOusU+N2luJMxHutBt10HntEXO++tvsA5c7E7y9cM6
         AyeHL8zvjN0mxhb3NwQmfbgm6sOAODwPCv11icgNK0nSvgms2+7y2qfwqnjK+LBX6/gS
         foYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mQ2t4T/52zeBY2r2c/9A/g+VIPUK1AUBzCE9i3AKqcc=;
        b=a/S+qJcC5NBgQtwvhkm3CV65xbP/vcdNEelNb0SBcefYts3k8u7tuuK8QFAC+tt8WA
         NNzsfbd/lPw1iOSrApJ9MfxL71U8dUKS/5nQw4Ox0U+Y676CDIKP5l5GZqd4a6OwougM
         eg712jE4Ia7zaRlMU5wD7+2YKa0upVojwci32c8w6hMvQhon/Z6a4O7PPPbFruewt0Yt
         ewJJ8Q6jdBVGezhQSUyC1+DArhRPjhEA3cvnLLXMcIIf8+E1NOesHhS7PhsVKk5wqGvT
         Gu3FvdoqD1HyVdXtF68L9j5gWzaM6ibujP/ss1hHxtIKl8mwzx99ou7+En+cS4vqXdVn
         fEXw==
X-Gm-Message-State: AOAM532Oljsudew1Jv0KLzncQ3CpP7T6MN4cubk0F0Xj9f5NgcR0pGkg
        JZRjlRDOjOXwJDbRgf2o5Ueql92sD6T8qg==
X-Google-Smtp-Source: ABdhPJz+7PZ6jVzL64Gu7wZOM+eiHrR1i9iPOq0sPCdtU4R0bON1SB8I8Y2C6X3pSO7q6jYIF52pVA==
X-Received: by 2002:a1c:f405:: with SMTP id z5mr12833916wma.72.1634892951849;
        Fri, 22 Oct 2021 01:55:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b19sm10609069wmj.9.2021.10.22.01.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 01:55:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/6] clone: fix a memory leak of the "git_dir" variable
Date:   Fri, 22 Oct 2021 10:55:42 +0200
Message-Id: <patch-v2-4.6-0d0e6359cf4-20211022T085306Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
In-Reply-To: <cover-v2-0.6-00000000000-20211022T085306Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211021T155529Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20211022T085306Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At this point in cmd_clone the "git_dir" is always either an
xstrdup()'d string, or something we got from mkpathdup(). Let's free()
it before we clobber it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/clone.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 559acf9e036..fb377b27657 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1040,8 +1040,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, NULL,
 		INIT_DB_QUIET);
 
-	if (real_git_dir)
+	if (real_git_dir) {
+		free((char *)git_dir);
 		git_dir = real_git_dir;
+	}
 
 	/*
 	 * additional config can be injected with -c, make sure it's included
-- 
2.33.1.1494.g88b39a443e1

