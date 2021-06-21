Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E18C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 19:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D75916128A
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 19:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhFUTLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 15:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhFUTLM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 15:11:12 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CD6C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 12:08:57 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l11so6218600pji.5
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 12:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SPVRoyESIkrCkgdLESIzcwAb70lGlCM8L/H9TYl2utM=;
        b=RjVnH7sjuSC2V685sbUAL/jURs8AU5JEZQIrC/tBOyNuceSmlmPRJOCqImhsiMO/7q
         hn5pk0FF6dkMUH7QcUqz+l2WSp0Rc+FxaZtke6xAQuhwkX1xRlyWSZhvt4Sj5GSWizJE
         60oyFMN0b5eEKDgzDZsp2jInLpWRJT9ad3d1gxmXE47JYGi8jDqfI6xX5XV/G+pjvFPs
         OWnv4CJp6qSijgd4QeBVOcEJLmpjZxdu+sXbevBFgAF7rUTMURQdtZ8h2hVPm41iMsYi
         iPEbd7sHLCN+PEyYFJ3t0VqxlPWhRi+WsYDHEPRCUuAYJOXSuN1rRMHaToDav9I+DzSP
         Qhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SPVRoyESIkrCkgdLESIzcwAb70lGlCM8L/H9TYl2utM=;
        b=bd/nDzPpYcEUKNEt03wIFfZttMx328UTJ1yU4L5XHyTswcNIwEc+nYNt4nyxdUUuM4
         KEdTygtPIF1wxWkhoj34C+MI+yO2jKHiRXi8hp/N38lhIf6uPXUckyXHLK2Dk2wK02sS
         HDK5n+SckGE07nyckuCVScTNDSEB/150qMd19isuEHGfpMEq0l0uyEZVS2S+JAIME5+J
         VBaGVwGa2FvmL5f8i0jR0ApuwOL9SiI+waHMiDi9vODghv4Ks7O5XkPXnkAycHi7rcl6
         kyCxTeZQMtVs8DVBWr16CapwBBu34umu+gspUemmKGIL+RYJ8Ws+UGYgJCUBzWBmuBJZ
         apUw==
X-Gm-Message-State: AOAM530PbG0fQv4TdMlqLyCV+FqwnAwvIUTaLVMieQA0/ZCsxTwep+gT
        RcJszxpZNwBqXRsJ+zz8NTfwznERqwqygg==
X-Google-Smtp-Source: ABdhPJwGKiDu6PMkb6IGOLx6AyvWLKT2C7jCIYG62FEUYr/UbxzHurcq4G0BsA83d8HIH2eXxydU2g==
X-Received: by 2002:a17:90a:9910:: with SMTP id b16mr28659231pjp.94.1624302536958;
        Mon, 21 Jun 2021 12:08:56 -0700 (PDT)
Received: from localhost.localdomain ([49.205.82.114])
        by smtp.gmail.com with ESMTPSA id i125sm16256991pfc.7.2021.06.21.12.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 12:08:56 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH 1/2] submodule--helper: remove an unreachable call to usage_with_options
Date:   Tue, 22 Jun 2021 00:38:36 +0530
Message-Id: <20210621190837.9487-2-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.32.0.9.g81a5432dce.dirty
In-Reply-To: <20210621190837.9487-1-kaartic.sivaraam@gmail.com>
References: <20210621190837.9487-1-kaartic.sivaraam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code path in question calls `error` in a particular case.
But, `error` never returns as it exits directly. This makes
the call to `usage_with_options` that follows the `error` call
unreachable.

So, remove the unreachable `usage_with_options` call.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 builtin/submodule--helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ae6174ab05..c9aa838083 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1637,8 +1637,6 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 
 	if (all && argc) {
 		error("pathspec and --all are incompatible");
-		usage_with_options(git_submodule_helper_usage,
-				   module_deinit_options);
 	}
 
 	if (!argc && !all)
-- 
2.32.0.9.g81a5432dce.dirty

