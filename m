Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08CAC4332F
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 14:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B74B0603E8
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 14:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbhINOor (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 10:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbhINOoD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 10:44:03 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2874C061224
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 07:39:20 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b6so20603487wrh.10
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 07:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j2bGVjqPT7Pn8kjChLvmqQS0Jlg6df0AQr+Wz7oQLNA=;
        b=C9c6jft0sjO2I3xizwfJapvrhm/uu1O7vbEFWBDfamlH2WTmAuocnwZyrcujMF2lFx
         JdnxKpJMewPknRBgomgdyeZzPXqbhpJ6m9DBE5tVw568YEsU6LXBo+qFzFNZwlG0G5kh
         Kcgr9q5feYm+uijMr1xXIrJgFA5iQjcMejcTY6Mii28FfolqYQiHOb7DKCJZ27SYgukB
         sLvCg6/UyI4d1jwI2QqjPzILGewSHNM3qZgtqZ6jzzuRs8A4ipRluh2EMmTYdM37iPcd
         FAqRmWZ7ppAJAi4Tn2MHNIcnP3bRCTFlRAW1eNfRZDE2/9cZDCRrUW6lIC/Jx8eFnUR1
         HZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=j2bGVjqPT7Pn8kjChLvmqQS0Jlg6df0AQr+Wz7oQLNA=;
        b=C4pGlAwK/QKS0fT1RxqRY1HMUcwrOcNHwWFEJUTG5NEt18xgTvXUZUg4Cj7a1kExDO
         ETY2vAbw5W1K446+dro6AxmE43lFhHqc8d40tc6Obr26mXU74ZsWBCQmkPC5AygaRDuZ
         3DLWNDx4Ix66+b3jI3qP6NbJUaJ2lOhqEHraq+MTYhVYZ8ZmRjL5QKjm82b7HidfyDvo
         jUAO5Xg9Bh7UJgxgVqqVcF96hUEMzjSa/OJQdicQBzNA+GXzBn4r3MjxI7ozPEf5+i6Z
         w3ADyXDN+kBaBqzd4OSJpUe4kOC10u8g9IeVU4UXBId15c4d/tR1qXebREiwp2PoXQ7E
         sRbA==
X-Gm-Message-State: AOAM533ZdszsH0xRG4VfYneQyP8PS+Zvy6X2oRke6vXzMglNeLfzRHnq
        94YXeTSGB/Lo2GztJ5BMaVOQ7ifVCiw=
X-Google-Smtp-Source: ABdhPJw2iw2Azep+zOs5Ffhb6J7YpmVZbx+YBwG0x03snGsuaaZMQEW0MnPfmU1OVvZMxo90QbjdXA==
X-Received: by 2002:adf:90cc:: with SMTP id i70mr19216637wri.408.1631630359469;
        Tue, 14 Sep 2021 07:39:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm11299490wrg.31.2021.09.14.07.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 07:39:19 -0700 (PDT)
Message-Id: <6ab9c7195da4e5c9bab2460296bdd6dcb744a9fb.1631630356.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
References: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
        <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Sep 2021 14:39:03 +0000
Subject: [PATCH v4 02/15] scalar: start documenting the command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This commit establishes the infrastructure to build the manual page for
the `scalar` command.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/.gitignore |  3 +++
 contrib/scalar/Makefile   | 14 +++++++++++++-
 contrib/scalar/scalar.txt | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100644 contrib/scalar/scalar.txt

diff --git a/contrib/scalar/.gitignore b/contrib/scalar/.gitignore
index ff3d47e84d0..00441073f59 100644
--- a/contrib/scalar/.gitignore
+++ b/contrib/scalar/.gitignore
@@ -1,2 +1,5 @@
+/*.xml
+/*.1
+/*.html
 /*.exe
 /scalar
diff --git a/contrib/scalar/Makefile b/contrib/scalar/Makefile
index 40c03ad10e1..85c186634e9 100644
--- a/contrib/scalar/Makefile
+++ b/contrib/scalar/Makefile
@@ -6,6 +6,7 @@ ifndef V
 	QUIET_SUBDIR0  = +@subdir=
 	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
 			 $(MAKE) $(PRINT_DIR) -C $$subdir
+	QUIET          = @
 else
 	export V
 endif
@@ -30,5 +31,16 @@ $(TARGETS): $(GITLIBS) scalar.c
 
 clean:
 	$(RM) $(TARGETS)
+	$(RM) scalar.1 scalar.html scalar.xml
 
-.PHONY: all clean FORCE
+docs: scalar.html scalar.1
+
+scalar.html: | scalar.1 # prevent them from trying to build `doc.dep` in parallel
+
+scalar.html scalar.1: scalar.txt
+	$(QUIET_SUBDIR0)../../Documentation$(QUIET_SUBDIR1) \
+		MAN_TXT=../contrib/scalar/scalar.txt \
+		../contrib/scalar/$@
+	$(QUIET)test scalar.1 != "$@" || mv ../../Documentation/$@ .
+
+.PHONY: all clean docs FORCE
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
new file mode 100644
index 00000000000..5f7131861a5
--- /dev/null
+++ b/contrib/scalar/scalar.txt
@@ -0,0 +1,38 @@
+scalar(1)
+=========
+
+NAME
+----
+scalar - an opinionated repository management tool
+
+SYNOPSIS
+--------
+[verse]
+scalar <command> [<options>]
+
+DESCRIPTION
+-----------
+
+Scalar is an opinionated repository management tool. By creating new
+repositories or registering existing repositories with Scalar, your Git
+experience will speed up. Scalar sets advanced Git config settings,
+maintains your repositories in the background, and helps reduce data sent
+across the network.
+
+An important Scalar concept is the enlistment: this is the top-level directory
+of the project. It usually contains the subdirectory `src/` which is a Git
+worktree. This encourages the separation between tracked files (inside `src/`)
+and untracked files, such as build artifacts (outside `src/`). When registering
+an existing Git worktree with Scalar whose name is not `src`, the enlistment
+will be identical to the worktree.
+
+The `scalar` command implements various subcommands, and different options
+depending on the subcommand.
+
+SEE ALSO
+--------
+linkgit:git-maintenance[1].
+
+Scalar
+---
+Associated with the linkgit:git[1] suite
-- 
gitgitgadget

