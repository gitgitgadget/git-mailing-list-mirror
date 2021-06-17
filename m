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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BC6C49EA2
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C8E61003
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhFQKD4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbhFQKDw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:03:52 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA30C0617A6
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:01:44 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id d7so3253821edx.0
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=swX0Kh/fRV0k+cZTT5juqC17nGKBQp0N8/a2flSEYWI=;
        b=YQuk4dZ1lsXH/VAu5zVscgP4ZJBGs+RWsi4ajGUa95l1FacBxXXthJK3/G+BoDjY+n
         ypMeC+iuZVLuzRWlLvsoWnmSH0HMEbnym1aq9tohQ1vYilCeUsZ0csMhdsJfsF/Ykj4f
         hiiyDIvP5CkDgk0XZPTqEmPX+fIaDyrDXHqEtMoni3RLDLJEu577PCQ6V2rwy0S77E2Y
         3Nhlqg6Lvx/Y9szQEJ7t6ahO1CIH+UgJ5W/nIJyHxs/KmEiiagP2Nu0hFiL8u4S269KN
         tHMp//clY5zp2TT0W8WR5BrcJrjUQdMHNovRg2Mwdca0+tJKer7LrNz04XogXKx5WLR4
         6v0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=swX0Kh/fRV0k+cZTT5juqC17nGKBQp0N8/a2flSEYWI=;
        b=lVRR1c1PVT2uj/zTkfCF1AMIYLqWFj41JwrGvRlxYMGLBT+BO93FMm6y3od8ri/HgJ
         texNepbgee2BBPkKJwM7IYPxEUJMlKcGeW6do9PFsL87OXEWdgNoxEV5MV3RSbidg3kz
         fJYRf3f0rL4quPciBstpiyR1MedIeSROPax8Em63MjwIk3YMPdwKm4bsLnHlhP8qooY+
         N+iwE/M4rrmde2DEoly98kwMDLxz3PxzHcX7eAuo8tAsELaXnsFyHnZ1S31/M32hoHEZ
         5xPudRKCD92YPWLV2gmiLljFP8OvsrdcsmOFL45Q2H0vhpBLZj+93NBlrt2n4KLDou8n
         /9zA==
X-Gm-Message-State: AOAM531HukDBYDpsznfqlk8hY6dVADhZPBgq/Ep71s7RegOcBHGllQqb
        0lyy/e7Jig1E1XflTyp0iiaVVwbwv52B9A==
X-Google-Smtp-Source: ABdhPJysdTSQP6xQFqT/k9gAn2cKvNO+tlSWsDc1aOCpOBD5IE5ODMVuwlTj4A1g0UJKF0fdXnxNBQ==
X-Received: by 2002:a05:6402:2552:: with SMTP id l18mr5430263edb.166.1623924103246;
        Thu, 17 Jun 2021 03:01:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m7sm3827031edc.46.2021.06.17.03.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:01:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] Makefile: remove an out-of-date comment
Date:   Thu, 17 Jun 2021 12:01:38 +0200
Message-Id: <patch-3.3-ddae86802e-20210617T095827Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
In-Reply-To: <cover-0.3-0000000000-20210617T095827Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210617T095827Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This comment added in dfea575017 (Makefile: lazily compute header
dependencies, 2010-01-26) has been out of date since
92b88eba9f (Makefile: use `git ls-files` to list header files, if
possible, 2019-03-04), when we did exactly what it tells us not to do
and added $(GENERATED_H) to $(OBJECTS) dependencies.

The rest of it was also somewhere between inaccurate and outdated,
since as of b8ba629264 (Makefile: fold MISC_H into LIB_H, 2012-06-20)
it's not followed by a list of header files, that got moved earlier in
the file into LIB_H in b8ba629264 (Makefile: fold MISC_H into LIB_H,
2012-06-20).

Let's just remove it entirely, to the extent that we have anything
useful to say here the comment on the
"USE_COMPUTED_HEADER_DEPENDENCIES" variable a few lines above this
change does the job for us.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Makefile b/Makefile
index 66f5ded3a4..29a152cd4f 100644
--- a/Makefile
+++ b/Makefile
@@ -2503,12 +2503,6 @@ ifneq ($(dep_files_present),)
 include $(dep_files_present)
 endif
 else
-# Dependencies on header files, for platforms that do not support
-# the gcc -MMD option.
-#
-# Dependencies on automatically generated headers such as command-list.h
-# should _not_ be included here, since they are necessary even when
-# building an object for the first time.
 
 $(OBJECTS): $(LIB_H) $(GENERATED_H)
 endif
-- 
2.32.0.576.g59759b6ca7d

