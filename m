Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF92C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238670AbiDMUFN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238625AbiDMUE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:04:58 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994297D037
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:21 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id m14so4172538wrb.6
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xLyiUSai2IxfyPtvWsgpqYaOSiGO6goubINiSTf2+XE=;
        b=m2cSg7BV7ARA8VZVC3H+gyrJ9o6kKpP6n4Yy+ZG3N7j6htUiekieijBUYjpfszoRKe
         W4Y0Ei4QjHXV7KK4tP2EPbhKRL560NKc0ySAChrufR7oFmR7bmEppsJWUN/9qN2JaE/F
         VnVRNdtZ4Jk+HCEKXDyf6LeSA3Ppz2lPbm68gos4ZQDDj1eSe4RMl/UVcp32jCx4xArv
         CqZkgVcQ3kgS07/7hTYE5fhUFCUdVVxQotu7aQPAaJJekQNiaeYlA3C1UmsmcUSu1aLM
         p3RHhEQNXusGcQptdCczFzGuv3j/jYccfLb/MygRVLsvAeoCunK2wha5wD932h4LnQfo
         EsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xLyiUSai2IxfyPtvWsgpqYaOSiGO6goubINiSTf2+XE=;
        b=MMnzEeOIdxNdM1UItwrjx71LGLi+o0rr7FpU6yHg64kGsKNUjEZp5MyeaYpPEb6HO9
         fwlNwpibMW1GvLT/rT/fuxOa3mf52MzWOJJ6ROevRYrlxudFffsgnWL1msmpEhLAgnWZ
         DwFfM6L65jM+eqcSGqejvoUoKJlq2FGQF3dHC8u0l7945NrfUaa/QyCvwON2y8BA0rw2
         VoR3Zjpo/SQEZ4ijDMp2JRHhKeOnRfErgkWLxYLuXDDkKNFvbPoJPyLQK6JVW9+nWxja
         D7JQmM5g+KXKdqNZ+vn7R6Z7A8w+Ux6DkCon7S3Pj2eMcN582LRNya7WEObDRM5Gw3Dn
         0LAw==
X-Gm-Message-State: AOAM532AogJNEJEMGicR+Swx80Nm//PWKqoM3ITzg16o4gdvpM+xEbbW
        Qh3nHUh3sMIwIsX3i47OjYv8dYGL6NXqNg==
X-Google-Smtp-Source: ABdhPJzAYeV01u4Npop2GLkpGLmefq6EOa7xXicxfx0wuETXE4CB2nreuYOHWWfPA0PIMGxbXrCeCA==
X-Received: by 2002:a05:6000:1ac9:b0:205:8461:5664 with SMTP id i9-20020a0560001ac900b0020584615664mr350243wry.123.1649880139721;
        Wed, 13 Apr 2022 13:02:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b002057ad822d4sm35220498wri.48.2022.04.13.13.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:02:19 -0700 (PDT)
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
Subject: [PATCH v6 20/27] revisions API: have release_revisions() release "grep_filter"
Date:   Wed, 13 Apr 2022 22:01:49 +0200
Message-Id: <patch-v6-20.27-e7e0e46bbb2-20220413T195935Z-avarab@gmail.com>
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
"grep_filter" in the "struct rev_info".This allows us to mark a test
as passing under "TEST_PASSES_SANITIZE_LEAK=true".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c               | 1 +
 t/t9151-svn-mergeinfo.sh | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index a9d6d3a8dca..1db58c3e4db 100644
--- a/revision.c
+++ b/revision.c
@@ -2950,6 +2950,7 @@ void release_revisions(struct rev_info *revs)
 	release_revisions_cmdline(&revs->cmdline);
 	list_objects_filter_release(&revs->filter);
 	release_revisions_mailmap(revs->mailmap);
+	free_grep_patterns(&revs->grep_filter);
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
index 85221d439bd..c93a5beab25 100755
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -5,7 +5,6 @@
 
 test_description='git-svn svn mergeinfo properties'
 
-TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'load svn dump' "
-- 
2.36.0.rc2.843.g193535c2aa7

