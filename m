Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96644C74A5B
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 15:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjCQPgC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 11:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjCQPf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 11:35:59 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F20BA8EAA
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:30 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w9so22037123edc.3
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679067325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eO7HYkk+WrAC4Ur1UNnXIcWTk/Gz6cB+R68aFC8dGw4=;
        b=jVLNP6gsABFvWUc4buIj1iVhrJRolsTWB7mJquoJKd4TtTMox6P6Zc4bhkqTCBTSDl
         fYoCnZ+B5HVP10qPjUhdpB3XluFrSR7VS4ZsJSH3RHnGtMVNsT6K3ZxCNrP+zmiBdY/t
         WGvgX/y8JxpuYyjy3AuwMJpkyW1c1tCa/92EmgvNwH6m6iTorjiKOg0BONZoJmrsPAPJ
         mkAN3tFfF+iCI1F3d5x+WokZb4AIFSESSCwf3q/xrv6C8wS01mfKEzNmqg3Zfk6LUNi5
         MDF3uLlVUxYgZQw98yMzAOaVlYcU8rdLwfrKpkCr7IV0bilBvUwlTLWsZ4GVqtUu1ZZh
         2Ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679067325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eO7HYkk+WrAC4Ur1UNnXIcWTk/Gz6cB+R68aFC8dGw4=;
        b=xG+JalvDPZssdk8amsz/DO+ZOD6wjcMHm1cgppNrH12u77/TkugoWfoKwH7cUGRTr8
         g6U/wxNU8BAgbg3AR+QStFzChpsZ5HMtuplK1AAZ7627Hq5Tw/7jheTZN3tKSop6253j
         1HrZ83isWvn8kdlOhylQzY2BC9fJitxvsxuxlqB04N2zbPJOvb22B9tEmajhEHYK+bvJ
         cdR1/OPFdoF8CfHQdxjAtXQ5NT7hh8aHiPFN7TbCI9Ww6qaDfVyhYA1gyR6f1Vg2std5
         NnUVlnV+VvxYpXT4Hg5Diopnkap5RqrgupzAgHraFVUHVwrAMoPIvk/wfPeRayWpeij4
         JE3w==
X-Gm-Message-State: AO0yUKW4ql0p9mDRc5cnRUmIfKeXSVv4VTGeA9T1co0IKRB7cCAqha/G
        gJoHm7aSzGsBDRKee/xOnQgowmqAYd6lCA==
X-Google-Smtp-Source: AK7set/OEAN/pjKGH0RRq+bj5weuGZX3LOs2w76WV+bkyd2hoHSi7jJWOViKBhXKOTcs/FBKvHlocg==
X-Received: by 2002:aa7:c956:0:b0:4fe:9160:6a7b with SMTP id h22-20020aa7c956000000b004fe91606a7bmr3555355edt.9.1679067325096;
        Fri, 17 Mar 2023 08:35:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6-20020a50d086000000b004fb00831851sm1199232edd.66.2023.03.17.08.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:35:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/17] cocci: remove dead rule from "the_repository.pending.cocci"
Date:   Fri, 17 Mar 2023 16:35:05 +0100
Message-Id: <patch-01.17-c167bde3c0c-20230317T152724Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "parse_commit_gently" macro went away in [1], so we don't need to
carry his for its migration.

1. ea3f7e598c8 (revision: use repository from rev_info when parsing
   commits, 2020-06-23)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/coccinelle/the_repository.pending.cocci | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 747d382ff5f..23b97536da5 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -34,14 +34,6 @@ expression G;
 + repo_parse_commit_internal(the_repository,
   E, F, G)
 
-@@
-expression E;
-expression F;
-@@
-- parse_commit_gently(
-+ repo_parse_commit_gently(the_repository,
-  E, F)
-
 @@
 expression E;
 @@
-- 
2.40.0.rc1.1034.g5867a1b10c5

