Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485B0ECAAD3
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 08:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiHaIl5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 04:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiHaIlz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 04:41:55 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB51B655F
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 01:41:53 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id ay12so6968923wmb.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 01:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=lCcLjELQewX38BLCD3LpGvqi2PLpoqjXS8dqNsp+ixw=;
        b=R2EytjCwRh4/K1AXei7QKwvWQw8WR6HpVAcHGgN7qSd2BrOOan7JyZ1fGGDqODvtH6
         g8S6rUKjlvw/WHewnHfo++Hcb/sxRRQZRbxhNl7JAv8Hnj+OCkcYNpFB22UhUBVjdjn4
         DINDaOR1d6niVKgESFfADUYqRoZyGqs27HybmikwoNyQpTaw+tuE0cjyuh0nQow1pyk2
         cUQj+FuzOeJBiO7COByN7jDnnOoUJsliUDljB4OX42ApusGwSsb8eTHQHkaJjaYqN6kc
         McZs6R0mqkKM3gHEOsJCFF73fZ7DO4rgqI5vj9Y4St/T60d06keMNsMbXQVIGFcwlDaw
         QPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lCcLjELQewX38BLCD3LpGvqi2PLpoqjXS8dqNsp+ixw=;
        b=ht1wckep1pOy/qfg7yU5OInMbgvPDkZ/bxrIMq1cleybvNX5RmAS/7VIVYCQ38MQ9Q
         XAtI2kJcSAQBciHEAwQQQo+Xbu1EkBveKGpzl5012I+Qa39t1SLKzdvpVGqlUxwLY+ai
         tIcpHyx70qvUpdxW3GJuE2/wneDKmTlSlrfdbsN4t7C8kXvhyiGs89aIPcXFCgxsF9oz
         whDCzns0XdlgLjtM5v2IRFbVG7iTUYpVH3SJ9EkQfoh8hVRhF2+P5AXXTE5YsWxf+vJY
         PoEx4T7CVuAe94Ua3ly4R1fvCo6KClVAqE3gfiznScpBMCJIW7JGTJubrV2yRTm6DDI9
         Ep/Q==
X-Gm-Message-State: ACgBeo3PfFATFVkJmGjpf6xFDn0XTQvaK/6PPsyNvb3hD6wSJvCfMYCo
        tooehg1IlunBtaaPJljpaGWXgBXgg4P+jg==
X-Google-Smtp-Source: AA6agR4P76Ls42w+lzekQ9GpwQfSUPEboHCYMulrJewtYWgnSLbRSMKOAzjPIItE/k66BOtVhzwF4Q==
X-Received: by 2002:a1c:44d7:0:b0:3a6:725:c0a7 with SMTP id r206-20020a1c44d7000000b003a60725c0a7mr1305055wma.137.1661935312069;
        Wed, 31 Aug 2022 01:41:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2-20020a7bc5c2000000b003a5c064717csm1439036wmk.22.2022.08.31.01.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 01:41:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/9] docs: add and use include template for config/* includes
Date:   Wed, 31 Aug 2022 10:41:32 +0200
Message-Id: <patch-v3-1.9-da21c19978c-20220831T083759Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1406.g184357183a6
In-Reply-To: <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In b6a8d09f6d8 (gc docs: include the "gc.*" section from "config" in
"gc", 2019-04-07) the "git gc" documentation was made to include the
config/gc.txt in its "CONFIGURATION" section. We do that in several
other places, but "git gc" was the only one with a blurb above the
include to orient the reader.

We don't want readers to carefully scrutinize "git-config(1)" and
"git-gc(1)" looking for discrepancies, instead we should tell them
that the latter includes a part of the former.

This change formalizes that wording in two new templates to be
included, one for the "git gc" case where the entire section is
included from "git-config(1)", and another for when the inclusion of
"git-config(1)" follows discussion unique to that documentation. In
order to use that re-arrange the order of those being discussed in the
"git-merge(1)" documentation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile                             | 1 +
 Documentation/git-fsck.txt                         | 2 ++
 Documentation/git-gc.txt                           | 3 +--
 Documentation/git-imap-send.txt                    | 2 ++
 Documentation/git-merge.txt                        | 5 ++++-
 Documentation/git-mergetool.txt                    | 3 +++
 Documentation/git-rebase.txt                       | 2 ++
 Documentation/includes/cmd-config-section-all.txt  | 3 +++
 Documentation/includes/cmd-config-section-rest.txt | 3 +++
 9 files changed, 21 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/includes/cmd-config-section-all.txt
 create mode 100644 Documentation/includes/cmd-config-section-rest.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index bd6b6fcb930..849af6da307 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -62,6 +62,7 @@ HOWTO_TXT += $(wildcard howto/*.txt)
 
 DOC_DEP_TXT += $(wildcard *.txt)
 DOC_DEP_TXT += $(wildcard config/*.txt)
+DOC_DEP_TXT += $(wildcard includes/*.txt)
 
 ifdef MAN_FILTER
 MAN_TXT = $(filter $(MAN_FILTER),$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT))
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 5088783dccb..29318ea957e 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -107,6 +107,8 @@ care about this output and want to speed it up further.
 CONFIGURATION
 -------------
 
+include::includes/cmd-config-section-all.txt[]
+
 include::config/fsck.txt[]
 
 DISCUSSION
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 0af7540a0c8..a65c9aa62d6 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -110,8 +110,7 @@ users and their repositories.
 CONFIGURATION
 -------------
 
-The below documentation is the same as what's found in
-linkgit:git-config[1]:
+include::includes/cmd-config-section-all.txt[]
 
 include::config/gc.txt[]
 
diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 63cf498ce9f..f7b18515141 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -54,6 +54,8 @@ CONFIGURATION
 To use the tool, `imap.folder` and either `imap.tunnel` or `imap.host` must be set
 to appropriate values.
 
+include::includes/cmd-config-section-rest.txt[]
+
 include::config/imap.txt[]
 
 EXAMPLES
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index fee1dc2df28..2d6a1391c89 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -383,13 +383,16 @@ include::merge-strategies.txt[]
 
 CONFIGURATION
 -------------
-include::config/merge.txt[]
 
 branch.<name>.mergeOptions::
 	Sets default options for merging into branch <name>. The syntax and
 	supported options are the same as those of 'git merge', but option
 	values containing whitespace characters are currently not supported.
 
+include::includes/cmd-config-section-rest.txt[]
+
+include::config/merge.txt[]
+
 SEE ALSO
 --------
 linkgit:git-fmt-merge-msg[1], linkgit:git-pull[1],
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index f784027bc13..c44e205629b 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -102,6 +102,9 @@ success of the resolution after the custom tool has exited.
 CONFIGURATION
 -------------
 :git-mergetool: 1
+
+include::includes/cmd-config-section-all.txt[]
+
 include::config/mergetool.txt[]
 
 TEMPORARY FILES
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 1877942180e..9cb8931c7ac 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -1259,6 +1259,8 @@ merge cmake
 CONFIGURATION
 -------------
 
+include::includes/cmd-config-section-all.txt[]
+
 include::config/rebase.txt[]
 include::config/sequencer.txt[]
 
diff --git a/Documentation/includes/cmd-config-section-all.txt b/Documentation/includes/cmd-config-section-all.txt
new file mode 100644
index 00000000000..296a239f2ab
--- /dev/null
+++ b/Documentation/includes/cmd-config-section-all.txt
@@ -0,0 +1,3 @@
+Everything below this line in this section is selectively included
+from the linkgit:git-config[1] documentation. The content is the same
+as what's found there:
diff --git a/Documentation/includes/cmd-config-section-rest.txt b/Documentation/includes/cmd-config-section-rest.txt
new file mode 100644
index 00000000000..b1e7682c1dc
--- /dev/null
+++ b/Documentation/includes/cmd-config-section-rest.txt
@@ -0,0 +1,3 @@
+Everything above this line in this section isn't included from the
+linkgit:git-config[1] documentation. The content that follows is the
+same as what's found there:
-- 
2.37.3.1406.g184357183a6

