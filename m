Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97544C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 15:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0C5206A1
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 15:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkbkc6zX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgKKPSV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 10:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgKKPSU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 10:18:20 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C2DC0613D4
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 07:18:20 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h62so2661130wme.3
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 07:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hk2mIVKr3R6+Pro9n7iO55JGg+F0I9RXiAzr44D6Zuo=;
        b=hkbkc6zXR/sFal5OKVlTCoMsTTtiKjHVxpWyRDYDhx3vCR1xz5SNCMwB3TdOacB3sL
         XqIsXbBeHsBa2bPYVDwE7oE7ckJ9JbUXzODV+ii88FZbC2q3pwNe/+YOvLo9WQdnBIhV
         pKE1rUaDPHUP3UKeF/dSCjxaHA9UVtGEbr7rcU/EH1pekAsl2l34Yp0eFiMREOpYgKAw
         vFFmnMkZQbQz6YU+hw1++3p/+um6uWsdQKkOMSTPx98w5+YKqpXTEoTiEZVUfIDVGBXI
         kyodSavY8sWg6zyUv5roDViwVCHDWbKGPf4j+QLsNskuJypq4SNY8rvD3tHEpx6R2dFs
         yaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hk2mIVKr3R6+Pro9n7iO55JGg+F0I9RXiAzr44D6Zuo=;
        b=D1rrDAAdpyrIFDdiC+ZmOENXri/CfqOgmd0Ne3l10tlPJsRkrtLTrV3PFLye6nAdqi
         ElzEUWeK591H0BC1nwT87FqT9X9iQPRVsLKnSJ1VmuHgWxt0ftugcZqAqyhDi2BI/Fo4
         F+O8PJGTJOTlcqp82ImDRU4QpLUzm3XJq13VqJMqjXpcJc5/anDsPJ1YL72Wsi0XSjpv
         QLOfDo7lRx6pPF3NLF0GMQoVxyL7NGAcGt0BypDD5nFMfGzPK6enhoFXDQ2V7/JSb06X
         w18983C/dRit0vGxr53j0RPBlTM3/mb+d/csU0T9WRI5D4ib+RE8hp1WbwYqz2rHXl16
         6vaQ==
X-Gm-Message-State: AOAM5318CuIcxMXVFPGglgirYJmD3PDgRqoodnf3k1k55fWETV8O/qSD
        s+pUk+5+BTb7kZ5ySvQoX0DDECwAjCN/og==
X-Google-Smtp-Source: ABdhPJzOT7ZcIYrkBkRlxMGvxq7VHxycb5hFUPdttttiPkgmVtlHVGCUV+ZK8QPFtB+N5augXayaWQ==
X-Received: by 2002:a1c:964d:: with SMTP id y74mr4529178wmd.129.1605107898561;
        Wed, 11 Nov 2020 07:18:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q2sm2940010wru.76.2020.11.11.07.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 07:18:17 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] parse-remote: remove this now-unused library
Date:   Wed, 11 Nov 2020 16:17:54 +0100
Message-Id: <20201111151754.31527-6-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <CAGZ79kb57HzJQ4VLFD_NMKvEnriPVXoAAPimg6BG_Z+PPjJ4aQ@mail.gmail.com>
References: <CAGZ79kb57HzJQ4VLFD_NMKvEnriPVXoAAPimg6BG_Z+PPjJ4aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Completely remove the git-parse-remote shellscript library.

Since e9460a66e0 ("parse-remote: support default reflist in
get_remote_merge_branch", 2009-06-12) when there were around 300 lines
of code here used by various core code everything in it has become
unsued, and that unused code was removed in preceding commits. Almost
all of its previous functionality has now been rewritten in C.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitignore                         |  1 -
 Documentation/git-parse-remote.txt | 23 -----------------------
 Makefile                           |  2 --
 command-list.txt                   |  1 -
 git-submodule.sh                   |  1 -
 5 files changed, 28 deletions(-)
 delete mode 100644 Documentation/git-parse-remote.txt

diff --git a/.gitignore b/.gitignore
index 6232d33924..9da275e4e8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -114,7 +114,6 @@
 /git-pack-redundant
 /git-pack-objects
 /git-pack-refs
-/git-parse-remote
 /git-patch-id
 /git-prune
 /git-prune-packed
diff --git a/Documentation/git-parse-remote.txt b/Documentation/git-parse-remote.txt
deleted file mode 100644
index a45ea1ece8..0000000000
--- a/Documentation/git-parse-remote.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-git-parse-remote(1)
-===================
-
-NAME
-----
-git-parse-remote - Routines to help parsing remote repository access parameters
-
-
-SYNOPSIS
---------
-[verse]
-'. "$(git --exec-path)/git-parse-remote"'
-
-DESCRIPTION
------------
-This script is included in various scripts to supply
-routines to parse files under $GIT_DIR/remotes/ and
-$GIT_DIR/branches/ and configuration variables that are related
-to fetching, pulling and pushing.
-
-GIT
----
-Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 790a883932..c874dff9b8 100644
--- a/Makefile
+++ b/Makefile
@@ -613,7 +613,6 @@ SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
 
 SCRIPT_LIB += git-mergetool--lib
-SCRIPT_LIB += git-parse-remote
 SCRIPT_LIB += git-rebase--preserve-merges
 SCRIPT_LIB += git-sh-i18n
 SCRIPT_LIB += git-sh-setup
@@ -2577,7 +2576,6 @@ XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
 	--keyword=__ --keyword=N__ --keyword="__n:1,2"
 LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
 LOCALIZED_SH = $(SCRIPT_SH)
-LOCALIZED_SH += git-parse-remote.sh
 LOCALIZED_SH += git-rebase--preserve-merges.sh
 LOCALIZED_SH += git-sh-setup.sh
 LOCALIZED_PERL = $(SCRIPT_PERL)
diff --git a/command-list.txt b/command-list.txt
index 0e3204e7d1..c19c8a94fe 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -135,7 +135,6 @@ git-p4                                  foreignscminterface
 git-pack-objects                        plumbingmanipulators
 git-pack-redundant                      plumbinginterrogators
 git-pack-refs                           ancillarymanipulators
-git-parse-remote                        synchelpers
 git-patch-id                            purehelpers
 git-prune                               ancillarymanipulators   complete
 git-prune-packed                        plumbingmanipulators
diff --git a/git-submodule.sh b/git-submodule.sh
index a6219c34e2..e7962e1a45 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -20,7 +20,6 @@ USAGE="[--quiet] [--cached]
 OPTIONS_SPEC=
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
-. git-parse-remote
 require_work_tree
 wt_prefix=$(git rev-parse --show-prefix)
 cd_to_toplevel
-- 
2.29.2.222.g5d2a92d10f8

