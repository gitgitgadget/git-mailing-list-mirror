Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C10C43460
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48AB4611AF
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhDIIui (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 04:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhDIIu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 04:50:29 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43C6C061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 01:50:16 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 18so5637545edx.3
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 01:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JRH+yAWNcriUMTwf4DSfmOI/KdeSaK4uRJx35+CDGcI=;
        b=lCcw0UT6+qOv+7LETB4ufkhSv2oTUMQ/PPBZA2goD6Wy3uwhnOL7kpTFodZa+KiuQx
         b3p6/9qXpleJrBjahTEkKEbXcElJnmRGsgKk+aOkR2LRnWsaCvuP4//cY+UGuDoEynXK
         xhAv9PrapAW+U15OPpM3WWxXhl2odHwq01i6D1SFjurmVXpq58eBx4M2rqUE9wfBT7vf
         7r+2DP4zf1dPCwwr0cnvbTjfnSOiiyECvK3i9URPXWlH+IdA93Syt98gRdAVeDmhCjkc
         8ih/uol2xGfJX148qWBXGR/6v6/OAIIrU9mM7sVzPWBRv13VckK9cnvX1whratJygm8W
         NHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JRH+yAWNcriUMTwf4DSfmOI/KdeSaK4uRJx35+CDGcI=;
        b=o11B77mgfIZIOlnmbAIlSx7/mAE4SBJ1kuz/Sz+0Oa1vQv7sjUWJYAM/UD9K9Ea0iI
         ZOzj66Sa5Ovtjk4q1fiECtypXvgWlsQkDN6G/truPDNOWYp2dvlgbF0gYAjpSUJfsZ9i
         rtE9QvDxXhpNFnG76zx5iYAUHsP8BswxZEI3u6cPbBVqexeD6NUrTYgv75rdEjQToYIM
         5VuNw9xUqum5yod6hD0H+aJf5BvO5eGPtycOjyn1iBcBJpmqgjZlHrHLiAiqJRFeEtCx
         9+MBFzYF1IlN7iuuRq7We4IQ51mZg3BmI+KRHvCtw9rtPAy68s1g/9wl4wqcRjPWifnC
         bytQ==
X-Gm-Message-State: AOAM532CfHCEgZ14QwB6c5xsU7CDf/VhtPnUHIxnZlm58xsQkBa/KilM
        ilY0v7qyWaWxfgpwhiDqPxa8slKVG7tCqw==
X-Google-Smtp-Source: ABdhPJxqfmX1zZK1SCmM/AYiJW3CjT9cpdLgd/5TGF0KrGllKEgpKhm/GmBmKewPwFr8Okxq7iVdTw==
X-Received: by 2002:a50:9b12:: with SMTP id o18mr16614643edi.376.1617958215302;
        Fri, 09 Apr 2021 01:50:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m29sm883601ejl.61.2021.04.09.01.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 01:50:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/7] commit-graph: use obj->type, not object_as_type()
Date:   Fri,  9 Apr 2021 10:49:59 +0200
Message-Id: <patch-4.7-995135c814-20210409T083436Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.592.gdf54ba9003
In-Reply-To: <cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com> <cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a check of a deref_tag() return value to just use obj->type
instead of object_as_type(). The object_as_type() function is for
low-level use by fsck, {commit,tree,blob,tag}.c and the like, here we
can just assume the object is fully initialized.

As can be seen in plenty of existing uses in our codebase the return
value of deref_tag() won't be an obj->type == OBJ_NONE or
!obj->parsed. Fixes code added in 2f00c355cb7 (commit-graph: drop
COMMIT_GRAPH_WRITE_CHECK_OIDS flag, 2020-05-13).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index cd86315221..347d65abc8 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -158,7 +158,7 @@ static int read_one_commit(struct oidset *commits, struct progress *progress,
 			   NULL, 0);
 	if (!result)
 		return error(_("invalid object: %s"), hash);
-	else if (object_as_type(result, OBJ_COMMIT, 1))
+	else if (result->type == OBJ_COMMIT)
 		oidset_insert(commits, &result->oid);
 
 	display_progress(progress, oidset_size(commits));
-- 
2.31.1.592.gdf54ba9003

