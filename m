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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E83C48BE8
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AED95616EC
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhFOQVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 12:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhFOQU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 12:20:59 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF0AC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:18:54 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso1835917wmc.1
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=54P68A4j0kW0cfpfjZp01+AYsbO1nzRrfEOVCotY9ig=;
        b=hJbKsvT9aGYYkuCJtu9wvGMxwtFCMr5GCSxHVH1UGHrN8oN2RV4vtqeymThGc8RmYI
         VCkzCm68CLB6TpIbgoTtiwsEeqvdxoWeq0DDS8ZJ5CgLI2V2HeyUNCmqVPU0WymkX0+F
         Sce1Y/kPiZj9DVxTagRVBkQjxEn2YRlkW2iWNAV3X/8ppM6u6aDjW98OLi4tk6XfM4CE
         qY03aoMsvGNLwVtbi+wxGuFnaK6oashBlbKK90VQcpCEWsjxgYSLpJrBTbuNirHB2zF+
         mTV0gSCNWZCY80FUvuQnNUd02BEandG83T8RJ8tkkIUVncY5wR1aK3oguDggQBPrZi61
         cP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=54P68A4j0kW0cfpfjZp01+AYsbO1nzRrfEOVCotY9ig=;
        b=CPQ516QNdO+PbW4co85y3TLUC59bqjnA/MxtJepIpdj8IeofkEHvSI/x9EPJ7+iSA6
         40wgbkCLwx0DpYRWHgJEsuw9VwaiZWUPbMMtIzT31I3uwJi6YneZZNt9bsLNERPGOwTK
         6RNFKZzjRsIVgC5rJ8srNvZAVg3J6m2mcoGqOVpLhWvUOP3j3mZTVp04admiV6jBAw8l
         s+TeiR4e9fF0S95a4aVg0KQyLdmsXiK3SRdcYo1Is5XlJP5rP5kNdg/cjDz0GOIXpnZt
         NNgytWDb8zD1RQ1l9WMJvQYVKQgCQz2KrLuVLm0if5Ms4mSNbcdam9ktOPzg6s3pBKqO
         EnGw==
X-Gm-Message-State: AOAM530dFMQZeUzUiKOyliV6HqY7g0pDky51628WhyjWC0I/GQ1pCSbd
        LIEcmvw7CRUw+rP/i2vslk2xZGPsUVe73g==
X-Google-Smtp-Source: ABdhPJx6BYODuja0R337bKfdr5q+GOqaLOkBKCxKLRrmaK+4pFFLvTQNLGQSnxASFyw/TyOZbtwMbA==
X-Received: by 2002:a7b:cb03:: with SMTP id u3mr60254wmj.119.1623773933326;
        Tue, 15 Jun 2021 09:18:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b8sm2671901wmd.35.2021.06.15.09.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 09:18:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/6] gitcvs-migration doc: replace "alice" and "bob" with "you" and "www-data"
Date:   Tue, 15 Jun 2021 18:17:59 +0200
Message-Id: <patch-2.6-39e8654507c-20210615T161330Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.555.g0268d380f7b
In-Reply-To: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue the work started in the last commit and change the cast of
characters introduced in cd976f5c526 (Documentation: reorganize
cvs-migration.txt, 2006-12-06) to refer to the "you" and "www-data"
examples the gittutorial documentation now uses.

In addition to the reasons for this in the last commit, this also
brings the gitcvs-migration documentation in line with the example in
the tutorial, which was added by the same author at a around the same
time in 927a503cd07 (New tutorial, 2006-01-22).

Aside from talking about a bare repository here and a non-bare
checkout in the tutorial we use the same paths, and make explicit
reference to the more extended documentation in the tutorial here and
its relevance to this example.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/gitcvs-migration.txt | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/gitcvs-migration.txt b/Documentation/gitcvs-migration.txt
index 1cd1283d0f8..f2ff379886e 100644
--- a/Documentation/gitcvs-migration.txt
+++ b/Documentation/gitcvs-migration.txt
@@ -86,17 +86,21 @@ possibly created from scratch or from a tarball (see
 linkgit:gittutorial[7]), or imported from an already existing CVS
 repository (see the next section).
 
-Assume your existing repo is at /home/alice/myproject.  Create a new "bare"
-repository (a repository without a working tree) and fetch your project into
-it:
+Assume your existing repo is at /home/you/project.  Create a new "bare"
+repository (a repository withoupt a working tree) and fetch your project into
+it. 
 
 ------------------------------------------------
-$ mkdir /pub/my-repo.git
-$ cd /pub/my-repo.git
+$ mkdir /var/www-data/deployment.git
+$ cd /var/www-data/deployment.git
 $ git --bare init --shared
-$ git --bare fetch /home/alice/myproject master:master
+$ git --bare fetch /home/you/project master:master
 ------------------------------------------------
 
+(See the "Using Git for collaboration" section in
+linkgit:gittutorial[7] for an extended version of this example that
+doesn't use a bare repository.)
+
 Next, give every team member read/write access to this repository.  One
 easy way to do this is to give all the team members ssh access to the
 machine where the repository is hosted.  If you don't want to give them a
@@ -107,7 +111,7 @@ Put all the committers in the same group, and make the repository
 writable by that group:
 
 ------------------------------------------------
-$ chgrp -R $group /pub/my-repo.git
+$ chgrp -R $group /var/www-data/deployment.git
 ------------------------------------------------
 
 Make sure committers have a umask of at most 027, so that the directories
-- 
2.32.0.555.g0268d380f7b

