Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A645DC433FE
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238605AbiDMUFE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238594AbiDMUEn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:04:43 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779FE7C781
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:17 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o20-20020a05600c511400b0038ebbbb2ad8so1872041wms.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ofn1s6W+yCV/oGzzBdrB7F3s0em6EkUI9rj17Gu8G8M=;
        b=pe94PzM+7UtOJyvz4gG3X5z6EpLpm2FIzztFPd5epnlq/3cQRY/fkK4UEp0oZScmrE
         v611vL+wtr6KY9gFbtT+1t8leR1T4mFAOvLHnzrVFvc19BL0o8AvexM9PyxzPhIv3RQD
         w+E/mSHxnqJEfzp/jABQYcxI+GLf9pXniPzSNJ+o6I66wJ1L7WVDddcG55S2XckleRO5
         lrmRPm35V9j9OAnM1fxoeed2fjQqZRyXE+ZaISfCyeq+r/JR0nxQEFpUM0+6xEID3+44
         0iSr3YRK4VTVkJtMrNHnVB0KfzKiSMIZUJKPuogfVwdbl6Hw5P0gZirm2UJAuzmC366F
         XDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ofn1s6W+yCV/oGzzBdrB7F3s0em6EkUI9rj17Gu8G8M=;
        b=DsCVi3Ea5jBYtZqFJvcwVTtn2wZbVTeEtK+jPJ5HbP7hLMUEs1fVTUE4VodeiDZp2b
         bR42521j21ysBlfiqSfoDsCKRNhh6CGy5v9LqzrMSlqqn5DHniSNR49gVqXWcrAwxKOS
         YnY2uNRC+pabe0ZnUFSbSMWPcgcwNtxkWmdunaNEBInG737XR3uOJxzRDhkE43iuAWm6
         leUFX1IQ+Z/8xR9kiuBXxhaSijxn9PmdfGNdmPbTW0AQF3jwElJlelXnyaEg0rIzZ80E
         h2a9tyoCLzSgC2bjfL/X6ISOUpjvQRFUceeWVidGw8HsOnff9WdYM9WBeTYGBKBX0DKM
         Ur8w==
X-Gm-Message-State: AOAM53143QeAwVS6VpJBPBYnENUEc7UAvP6yzqdg3ZVeUgHGWnYq5bee
        bfbS7UZG2zf27+sJ+wdMIH1wotCR4k1Tkg==
X-Google-Smtp-Source: ABdhPJxWnCvNMlHRsfq2L5909oB+3HKIBXQfaN0F/o3wlejUOx7c3W4EUaKDihkbFpuzGVT/1PrtBQ==
X-Received: by 2002:a05:600c:4f90:b0:38e:d3bb:ca with SMTP id n16-20020a05600c4f9000b0038ed3bb00camr331906wmq.2.1649880135862;
        Wed, 13 Apr 2022 13:02:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b002057ad822d4sm35220498wri.48.2022.04.13.13.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:02:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 16/27] revisions API: have release_revisions() release "commits"
Date:   Wed, 13 Apr 2022 22:01:45 +0200
Message-Id: <patch-v6-16.27-dcf63f64135-20220413T195935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
References: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com> <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the the release_revisions() function so that it frees the
"commits" in the "struct rev_info".

We don't expect to use this "struct rev_info" again, so there's no
reason to NULL out revs->commits, as e.g. simplify_merges() and
create_boundary_commit_list() do.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.c b/revision.c
index 472fff1e0a7..553f7de8250 100644
--- a/revision.c
+++ b/revision.c
@@ -2928,6 +2928,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 void release_revisions(struct rev_info *revs)
 {
+	free_commit_list(revs->commits);
 	object_array_clear(&revs->pending);
 }
 
-- 
2.36.0.rc2.843.g193535c2aa7

