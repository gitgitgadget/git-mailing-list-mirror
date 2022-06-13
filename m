Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C95DC433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 22:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240328AbiFMWjL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 18:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiFMWjK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 18:39:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8E562C9
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:39:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w17so1332573wrg.7
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SZz5/KAUtwJd75mvLxj4GUa9sffsa7d36rY3weXr0so=;
        b=kdD1/des6P/52824jThcRzovsfKYq/WLF9ecI2CJ+Zh+Bw2HnW8aZ0UK78MWXX6Lgi
         aYYA3HTEKm9QtzCZtrx6uzT48xK0o35WfxG6+13Ep2IMS3/hgZOWiwNQKYN5LHFj9kjm
         Xg10hfbNlte8McyYUg1CLRVQTsstdSH1lLLUcubzcbw5lNa3efrillm2i39oprJY7qCT
         eZEmnE9TZGX1OVh2r2OFmSsU1B7qJj8TBoRU/msy0r8euwpFkdnppgNFUS/e6WQF8i7D
         gY7LWxqh0Dj9PHi1ATwHgl07TGOtjIwduV+LgiBht1DF5VTronxMpUvCnr/KYbKlW5o/
         iZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SZz5/KAUtwJd75mvLxj4GUa9sffsa7d36rY3weXr0so=;
        b=tptJqaTdAgQlDOa556nyxc+YMwAzZZ33asLN/KVpDcuYg3XwqRcnZabJL6L1wXpcYN
         84y/VddJ5qG7XFl2JOKrfylpXGpRRcWRez8SKI6mbgKFN1/mJtGLWYoLSLVGHnbti6ul
         JJOnRxI2udCSDQytlCCEDioS9dOoDeFeJh0hG8xcKHmhuu+CWzyI04A7ARzmsvrTdZ8j
         ntaaA/TGRd1AnsGSN8viPsTaHCK+yvGJ/NxqNRrcXr7l4s2OvSsEH9V5cSLD08U/BeXP
         hf6bueYRDj2eLtUkYu7h5Yi9coFsSuU4Xlg+doR2lxJqMOiw07iK0PF+bOYTfMVVqBdT
         OEcw==
X-Gm-Message-State: AJIora/4/9SPufM8GbWTPnsVFzA0G/mQEGighkPUI4mZFxRTVP9IfeRJ
        PzPYCPlYQT/1Q0u98W9W8T6K6f/9povRqw==
X-Google-Smtp-Source: AGRyM1snTuBavJwo8S2eeVm3bh6ikcWTZAwrjIvJ9yqy1kLmMcSCYe9IIxaoZcIn4ry452irQv4gwA==
X-Received: by 2002:a5d:4389:0:b0:213:1d58:1666 with SMTP id i9-20020a5d4389000000b002131d581666mr1785653wrq.294.1655159947818;
        Mon, 13 Jun 2022 15:39:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y3-20020adfd083000000b002103cfd2fbasm9670303wrh.65.2022.06.13.15.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 15:39:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/12] git-submodule.sh: remove unused sanitize_submodule_env()
Date:   Tue, 14 Jun 2022 00:38:52 +0200
Message-Id: <patch-v2-01.12-c5afc72e075-20220613T220150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
References: <kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com> <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sanitize_submodule_env() function was last used before
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
2.36.1.1239.gfba91521d90

