Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C077FECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbiHaXPT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbiHaXO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:14:56 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E10D639F
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:52 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id s23so8109126wmj.4
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=9cS3P9v0M+cXvpQIjdziH8zupYYJcid/h1ZbFDHkCJo=;
        b=UQo2yDnyjS3u0aR16S9Fs9oRB2HzD5u4suk21tcIDr9yofgfhRcfGItR9jaTSRcjy3
         f5ho/G9/DZYALko/POmV3T5a6s2RmNB/CMzbLRbg3FsWHRI+1SwEMt2uwj/UiaKA6HL9
         bFkyWM/cpIkdpJBHTZOziXzXZ2m2DL4egRVahKQjxboBmZ3ET0cFDvxMaLFmtBH+KEjF
         w3fqGuVmIQq/EuufAfMxH1T97JTp6hq7MYwR6p7GjmT2TOxaWbs2+Uif1mnNAVEJ9oD4
         TIcLarTZ+H0FgXuDW260u7Japd1XpUfU+WjnyKkULSaLc+KejDeIVUWC3Msa2VTen1oo
         baTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9cS3P9v0M+cXvpQIjdziH8zupYYJcid/h1ZbFDHkCJo=;
        b=nKn7WEd70rOLHDU0Q8Jf/SYZbQYMLGDZdIlMdPvyBx7bZCwsnF/0qS2BK/qPhGXhv4
         xCFRalRZN69phva2W2cBPnxt9FwWkLTwRGJb6IV9No4IXnsXvOwQYyLWTebb4hNeqkIv
         iomgA2vX2Qm1rGpLQCKv6fwhC+fcPJJW4X7U8zJp+rZTh05Xv0XnYF09Tga9oxM9Qup8
         DwrUqKCU33fxXKaCbnRNytVPtNCE+4bSAGY6p0uEYN+BHOkm6yHhbvZ8m2kqJyLd9Vj4
         j5GUOX3g+LyN7z9Uf/qJYYDvyPSCd36mLInr6izMxPTPRZUbte3iv+58piY6LpNHFeUo
         zVCA==
X-Gm-Message-State: ACgBeo2Kb4HtkUdc2VGd/2E2tNYiVsguP/Jd5w3otXs+ELzA0PL10RTY
        jKiGWG3JkBai8VwYfUm5KQ4BsObrrYFICQ==
X-Google-Smtp-Source: AA6agR4txkT+/Z7kP5mAH/qCLB2HICH7sPyX6a9YJ+vfB3Hvrr0gD4O9nKaiT+/NwT1B+DkrobTxLA==
X-Received: by 2002:a05:600c:22cd:b0:3a6:7b62:3778 with SMTP id 13-20020a05600c22cd00b003a67b623778mr3332847wmg.45.1661987690311;
        Wed, 31 Aug 2022 16:14:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c058e00b003a5ad7f6de2sm3484666wmd.15.2022.08.31.16.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:14:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 07/17] submodule--helper: fix "errmsg_str" memory leak
Date:   Thu,  1 Sep 2022 01:14:14 +0200
Message-Id: <patch-v7-07.17-600526e1301-20220831T231003Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
References: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak introduced in e83e3333b57 (submodule: port submodule
subcommand 'summary' from shell to C, 2020-08-13), we sometimes append
to the "errmsg", and need to free the "struct strbuf".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ae918a662b4..75a5d9d47fd 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -973,6 +973,7 @@ static void generate_submodule_summary(struct summary_cb *info,
 	free(displaypath);
 	free(src_abbrev);
 	free(dst_abbrev);
+	strbuf_release(&errmsg);
 }
 
 static void prepare_submodule_summary(struct summary_cb *info,
-- 
2.37.3.1420.g76f8a3d556c

