Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD08C4332F
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238982AbhLVEAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238795AbhLVD7z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 22:59:55 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5925C061746
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:54 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id f134-20020a1c1f8c000000b00345c05bc12dso696325wmf.3
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DRcDz5mRrLFJg1Chi59B2VkbtbvV25HAmi3ZWGu9OWQ=;
        b=HRx/jbIMkk8Q2IEpFaMxKyM0vPWzb/QpYLmosAq1z7kvIaUqRYF9bxWw4UWEeQlr2w
         7CdiUlwCHLB4uXf8lffK5CG8HFjSYaHL2Cm2FLAa1AXG55dBXCXhjWHf/jDFHuIfh78T
         kc2gFZ15/CNH/MXMW7qxHEOviYCefb6tvLtNGcMzpYcw4Aqgb4Sg6aXj5xIczc6R6EhO
         V0G+BiSdmYQLaZUjN4qKGltSp/oFHECImn0eNXHpYXrTkEm6RNzl/m9MW8vOMxcYhqJV
         FMYrY1IJhmqPPfu81SvcRVR7TqnLZMfP9zSYtQz+lraDG4NuxIry3F0iA0Y2wf7kUDmN
         eJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DRcDz5mRrLFJg1Chi59B2VkbtbvV25HAmi3ZWGu9OWQ=;
        b=LnWHyL/HjDDuIslRTajBjDxjwmfu8ruaHmxwZDP5M8BJe8qqcKeb06ObShgXP5Fmki
         /t/5GJuN0WnP9y3SX/ESB+6YMot+zTzUbvdw60miVDV6oEz7FJ4HFqgKAyxtwNeUynOo
         elM4NUseIa1lo35Wthj8u8EC4aaPq30sYqxsYyXq9caxOtsy6umDKog6Bk2pRHEHt9Ua
         k9G1P2bxv5citcuNriIeVEwSjE31eMYTeZ0J/VfkCzt5SczMqzrsXAvD3WHCsTc1G/rr
         +WvbTUiGwykGGRaN97O14ziiX5qr99Y7chKJD+gPq+fhFSlP5DtArJroFYj1+W/3XxpB
         4Jxw==
X-Gm-Message-State: AOAM533KMN5A6uyHOmDEe99lO/oH1yyzJf6wcWXcrjlqSFDrYIQMxmFk
        moJ42Ik74H2kIXUU36aMQE2ts3JkIMfUdw==
X-Google-Smtp-Source: ABdhPJyawPP7JdG7klC3xQVtWrxREnsV5Yy36bMtIWv37u6jOUxraBr2mk4GPwD4e8ztHA8Si0eRsg==
X-Received: by 2002:a05:600c:5025:: with SMTP id n37mr958142wmr.18.1640145593163;
        Tue, 21 Dec 2021 19:59:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s8sm867300wra.9.2021.12.21.19.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:59:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 08/17] merge: convert post-merge to use hook.h
Date:   Wed, 22 Dec 2021 04:59:34 +0100
Message-Id: <patch-v6-08.17-6f8d3754b4f-20211222T035755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Teach post-merge to use the hook.h library instead of the
run-command.h library to run hooks.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 5f0476b0b76..5be3009c2a2 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -487,7 +487,7 @@ static void finish(struct commit *head_commit,
 	}
 
 	/* Run a post-merge hook */
-	run_hook_le(NULL, "post-merge", squash ? "1" : "0", NULL);
+	run_hooks_l("post-merge", squash ? "1" : "0", NULL);
 
 	apply_autostash(git_path_merge_autostash(the_repository));
 	strbuf_release(&reflog_message);
-- 
2.34.1.1146.gb52885e7c44

