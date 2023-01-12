Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A963C54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 12:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjALMrQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 07:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjALMqY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 07:46:24 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E01496CE
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:46:20 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ss4so37184402ejb.11
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jnf9yzlnX/3YrB4Jj3j2oGQkdEzNXoYMKUG4m/VZ30Q=;
        b=SrCaHy/XjEx5LBgIyDsL8Ii68l2lebFhqwofMc/61kHcVaWtz7yPhbT8+kvuEJjzHi
         uW8MzMC5R1ZT2mOeDWZmnhar0RjCXWMSJfl1VhP//on8UE6BsT8oD7T6/vQMJhM6QwNc
         7twVB3sS8aoBZaf5k3KemO2H1tlXNxFm9gzSdNhvUH9KzGt8bq3vApvbrZKNF7+ZJyLI
         hY2K8KXRKxNQowYw4ziBpxJdzp9S5fyEk43zEOqFZiib0/EG5slP6oUkn3S1EUtpasjS
         /l5VWxzhUHswT85oTXF2JtdYlhwW0vT5s5OL2qAQJUJF5l5yolnNsLdoy6DsSzExXUwE
         +x7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jnf9yzlnX/3YrB4Jj3j2oGQkdEzNXoYMKUG4m/VZ30Q=;
        b=6G+BII3yFVQCqf9kkRRXKVdvjR7nUmwoOkUeMqR65Y6nznhiA28VsXCf2U22rJ7t0F
         6DAX6Ue3+ldJQ6CTKA4zD90g4G9wkc2U0M7mGfhPQPd8ptMeZhiWm57CMgKd+bgaO3Vq
         gvD/ckwgCL57rSUB/EFBqfRLjXAQLSsGhogdU5ZcP0ZldpjfuG0ihDjYUgwBq32QKvaG
         q2FilWuscyf1GngsLuj0/H1XmvPnfHbINJz2FlVLkVH2YiaY09IkLIIf5kR+klpNVoBO
         WTBRKAvos73e+9WqqBOwdd+IiM5NUgI4AzI5xVvbMf26nfFOmqRCFP9dy3o6pnRut7LP
         G9EA==
X-Gm-Message-State: AFqh2kpE7i8EWF7Sf1kt2WcdWdqu94okH7bsw6fwsuFwXuLxdnZYsWmH
        JeEbQPeBd+KrnNK4U6u/5dG0QrMCa0GBdA==
X-Google-Smtp-Source: AMrXdXvJZ+qq1WzxcxyxODtklWYp4GEZ4KHxCtMidVri0g576ueJx2zFXSHmQ6caryJ/r7BL6c9ndA==
X-Received: by 2002:a17:907:7fa7:b0:866:6b08:946b with SMTP id qk39-20020a1709077fa700b008666b08946bmr2519728ejc.39.1673527573790;
        Thu, 12 Jan 2023 04:46:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v17-20020a170906293100b007be301a1d51sm7373523ejd.211.2023.01.12.04.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:46:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 9/9] commit.c: free() revs.commit in get_fork_point()
Date:   Thu, 12 Jan 2023 13:46:01 +0100
Message-Id: <patch-v2-9.9-fd9c7a5547c-20230112T124201Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1205.g2ca064edc27
In-Reply-To: <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that's been with us since d96855ff517 (merge-base:
teach "--fork-point" mode, 2013-10-23).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit.c                       | 1 +
 t/t3431-rebase-fork-point.sh   | 1 +
 t/t3432-rebase-fast-forward.sh | 1 +
 3 files changed, 3 insertions(+)

diff --git a/commit.c b/commit.c
index 14538a811ae..e433c33bb01 100644
--- a/commit.c
+++ b/commit.c
@@ -1033,6 +1033,7 @@ struct commit *get_fork_point(const char *refname, struct commit *commit)
 	ret = bases->item;
 
 cleanup_return:
+	free(revs.commit);
 	free_commit_list(bases);
 	free(full_refname);
 	return ret;
diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index 70e81363569..4bfc779bb87 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -8,6 +8,7 @@ test_description='git rebase --fork-point test'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # A---B---D---E    (main)
diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 5086e14c022..7f1a5dd3deb 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -8,6 +8,7 @@ test_description='ensure rebase fast-forwards commits when possible'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
-- 
2.39.0.1205.g2ca064edc27

