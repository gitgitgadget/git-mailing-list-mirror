Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA08C6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjDAIra (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjDAIrC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:47:02 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F186E1EFC4
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:46:46 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id ca2-20020a056830610200b006a11ab58c3fso12466998otb.4
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBIidAvDgd2+eHMeTXcV+ZdHU4h71AR2peyv4lPjnjI=;
        b=LZg0oVNrAZPvokPAMO/27yYE5oOlASNY5NP/gCgka675elbRitp7AFe/lIG0E5KoDr
         TGoLRZv8NhftSieK/yxxo7bX1SOAtgUUZ5pDK76+bTLBRQHDkzNoKnBmWIwZoG5Y5iiB
         kkmvJ//2Qx9FC6RxWC139QdV0Vz50BK5LQ+lcYqZSYqWh9TTmdQnKQ1DSdae7qKkBNbq
         NIU+hU49V8gB7HaOB0/08/4FbBKuRfZSisqyOuPQBgWINrq/IsqAro0FsLqpxmYGKEDf
         YMAHDyPYvcRUahuivlnn59qOjptV8y6R+dEhRaB9sDJ5OVNtqGKZ95PVUK2d5WthAhDm
         FQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBIidAvDgd2+eHMeTXcV+ZdHU4h71AR2peyv4lPjnjI=;
        b=ktu8EKihrfr1SM8hIuJrjmdNMfvF398P0/kWQo4jSd2+a4qObnWVk6RD5KqIST6nwM
         d9lLwhrE+74nQq2LnbVG0CaHfwYaL6lloPJjPQOOgU0lGNxuSMl+DpLKdtlzAEBmUxJK
         oG2V71z1etdBPA49OoNnw177oQDKC64tJyXxStW4VfU3ayw9j5sJHAn6Fdcf/IqwDRLU
         71d+EwM6B8rH3TsMffPI2yUyPzFxa2nh4Lqao3PDmgYRBv54VoUMr+Ra6PJsyXmjD3BI
         crR1uEeaQmT+sKbODaQVZnbgEjISJE8U2eKXapwYNkufRKNK8Dqdvsmb0amDPG5GDUzc
         0DNg==
X-Gm-Message-State: AO0yUKUbDZVHkXQ1sinds+yf7E07AKdQagSIAEaQkJ7abzPfaIhoCLRK
        +iv8g+aVK1khJzTcffv3KFLVFFMzggQ=
X-Google-Smtp-Source: AK7set/5B8gSez46Enw+6NFmwC5ABSDgVrdAO7kFUrX7XnCtX9HRPXpi0ITGidkf9m4m0R5f3JYlxQ==
X-Received: by 2002:a9d:76c3:0:b0:694:331b:80b with SMTP id p3-20020a9d76c3000000b00694331b080bmr12854749otl.33.1680338806058;
        Sat, 01 Apr 2023 01:46:46 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id z1-20020a9d7a41000000b006a144b97e73sm2043910otm.74.2023.04.01.01.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:46:45 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 13/49] test: completion: fix currently typed words
Date:   Sat,  1 Apr 2023 02:45:50 -0600
Message-Id: <20230401084626.304356-14-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

They don't match what we are supposed to be completing.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh     | 4 ++--
 t/t9904-completion-zsh.sh | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 6c3cfe7e5a..bfd8570885 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -486,7 +486,7 @@ test_expect_success '__gitcomp - option parameter' '
 '
 
 test_expect_success '__gitcomp - prefix' '
-	test_gitcomp "branch.me" "remote merge mergeoptions rebase" \
+	test_gitcomp "branch.maint.me" "remote merge mergeoptions rebase" \
 		"branch.maint." "me" <<-\EOF
 	branch.maint.merge Z
 	branch.maint.mergeoptions Z
@@ -494,7 +494,7 @@ test_expect_success '__gitcomp - prefix' '
 '
 
 test_expect_success '__gitcomp - suffix' '
-	test_gitcomp "branch.me" "master maint next seen" "branch." \
+	test_gitcomp "branch.ma" "master maint next seen" "branch." \
 		"ma" "." <<-\EOF
 	branch.master.Z
 	branch.maint.Z
diff --git a/t/t9904-completion-zsh.sh b/t/t9904-completion-zsh.sh
index 994d57a67f..9221539296 100755
--- a/t/t9904-completion-zsh.sh
+++ b/t/t9904-completion-zsh.sh
@@ -125,7 +125,7 @@ test_expect_success '__gitcomp - option parameter' '
 '
 
 test_expect_failure '__gitcomp - prefix' '
-	test_gitcomp "branch.me" "remote merge mergeoptions rebase" \
+	test_gitcomp "branch.maint.me" "remote merge mergeoptions rebase" \
 		"branch.maint." "me" <<-\EOF
 	branch.maint.merge Z
 	branch.maint.mergeoptions Z
@@ -133,7 +133,7 @@ test_expect_failure '__gitcomp - prefix' '
 '
 
 test_expect_failure '__gitcomp - suffix' '
-	test_gitcomp "branch.me" "master maint next seen" "branch." \
+	test_gitcomp "branch.ma" "master maint next seen" "branch." \
 		"ma" "." <<-\EOF
 	branch.master.Z
 	branch.maint.Z
-- 
2.33.0

