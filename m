Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A75C433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 02:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243048AbiFJCBw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242173AbiFJCBt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 22:01:49 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACCECE5D8
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 19:01:46 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id c21so1531896wrb.1
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 19:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aZm+F2jAqfX+TaU66E5IsHdaEc2h/PR1TlRlEu2HR7c=;
        b=DnPHlRyGikh7wCJs0TDt8GttB1bnFd6aOXqOrm++iCHX+Bv9hf703rQub5uF+ZhYGQ
         G5opEkbIMqF+0YJ1MajC6wdHHqQrrSWUCGoejikBAl19XzRvvRNSsevLuy6+hqPWKh41
         brJnhWhaxpdZ3gKhpVq4wLtWTqJLmJ8ZUsQwvijTkusAz2F2yROtUY2aXCrDlOOsQzsO
         mWBg1RuzEmX8G1/ejqETa4oIwD1Me5JP5g+lcwsQKQm5WLEOwzVOz6a3uqRq8H8eUgNt
         f3AYXWucOoYraJr6yiDMBzND1V+8Mdfd93mQP0mi7tecucnGf2i8n7nReDPxhBfZapm/
         efvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aZm+F2jAqfX+TaU66E5IsHdaEc2h/PR1TlRlEu2HR7c=;
        b=7UJtp7Ksrku3D30B+6syUboKChRn7uPLnHMNhZSSAfsS1QiivpbG3Ziivdfd8+XaWM
         ZPuZkbEYqOx+e7tHVxg09Mccb95lKoXh1AtsmO+fDbzpoSX77hIEIRK4K+tp5d6EGek1
         d8Ih5rbgSY7IfuIsBOGjUbhK3V5s5jzF+I+uGHWX0HDfcnhHbR4aRlE+HVrYwjJAEal5
         ZBuA6fsdJPIEGXfPO7FlV38KK5ieRdQzztVXYyZCK3eYMc4TN3nF0PxSnQkUtmMxA3hn
         hq1K3apTaMlSudddx4w4RJ3L6Hg5T2LTjaFRUB0+CPRM4MoWfSkxg23Un5mL3EwZghxc
         0slw==
X-Gm-Message-State: AOAM5309U41dDbusKUHW09Myq4b3VUfJ25TTOMcmIb4NH09ksa9DwTY7
        Cj5V00nks/p5Ber0/XzN3jVbXxRtjCGy2A==
X-Google-Smtp-Source: ABdhPJydEi8Sa0vqXiFUf1g9y3ms64fhViFH1VcSHNvKvDBUQmYBKQ9oBlndqwebCthcZhIKvrK8wg==
X-Received: by 2002:adf:eb46:0:b0:210:997:42c with SMTP id u6-20020adfeb46000000b002100997042cmr40946608wrn.555.1654826504609;
        Thu, 09 Jun 2022 19:01:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b00219e8d28fb1sm122547wrs.57.2022.06.09.19.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 19:01:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 01/20] git-submodule.sh: remove unused sanitize_submodule_env()
Date:   Fri, 10 Jun 2022 04:01:13 +0200
Message-Id: <RFC-patch-01.20-0e9f13822ef-20220610T011725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1178.gb5b1747c546
In-Reply-To: <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com> <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sanitize_submodule_env() function was last used in
b3c5f5cb048 (submodule: move core cmd_update() logic to C,
2022-03-15), let's remove it.

This also allows us to remove clear_local_git_env() from
git-sh-setup.sh. That function hasn't been documented in
Documentation/git-sh-setup.sh, and since 14111fc4927 (git: submodule
honor -c credential.* from command line, 2016-02-29) it had only been
used in the sanitize_submodule_env() function being removed here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-sh-setup.sh  |  7 -------
 git-submodule.sh | 11 -----------
 2 files changed, 18 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index d92df37e992..ecb60d9e3cb 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -285,13 +285,6 @@ get_author_ident_from_commit () {
 	parse_ident_from_commit author AUTHOR
 }
 
-# Clear repo-local GIT_* environment variables. Useful when switching to
-# another repository (e.g. when entering a submodule). See also the env
-# list in git_connect()
-clear_local_git_env() {
-	unset $(git rev-parse --local-env-vars)
-}
-
 # Generate a virtual base file for a two-file merge. Uses git apply to
 # remove lines from $1 that are not in $2, leaving only common lines.
 create_virtual_base() {
diff --git a/git-submodule.sh b/git-submodule.sh
index fd0b4a2c947..bc436c4ca47 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -56,17 +56,6 @@ isnumber()
 	n=$(($1 + 0)) 2>/dev/null && test "$n" = "$1"
 }
 
-# Sanitize the local git environment for use within a submodule. We
-# can't simply use clear_local_git_env since we want to preserve some
-# of the settings from GIT_CONFIG_PARAMETERS.
-sanitize_submodule_env()
-{
-	save_config=$GIT_CONFIG_PARAMETERS
-	clear_local_git_env
-	GIT_CONFIG_PARAMETERS=$save_config
-	export GIT_CONFIG_PARAMETERS
-}
-
 #
 # Add a new submodule to the working tree, .gitmodules and the index
 #
-- 
2.36.1.1178.gb5b1747c546

