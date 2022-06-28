Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F995C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 10:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344676AbiF1KGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242996AbiF1KGL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 06:06:11 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D219C2DD74
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:06:10 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e28so11740816wra.0
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wC2fD32nZCXyBHEu7qLiVPQBP771Zs+EAnSAMRVzoI8=;
        b=NrZh0FlG46RBbTqmSnsMn0WQVYkYlWNcKMJeScfhZFqY1C8B0pWe/qdBq1PdWNPiQk
         y6bTPUxTE2sey/YuyRf14qNuODrzjpQMgwM4dGY1ylGkiMXGaIJ/AK44rwKppb8RR52b
         R1UBSq15++4EznIsLncymRRVGk/VPp0+wzcrmnDyg/Fa+AEM3hHB7debk5y/SUQAwmQA
         vUJYD5VMftX1vvCKwkKs3rkWn81/Wb10ur9Skq7JBAW78O5ZS9lhCCue8u8NJOi0JT3L
         IaUX/nTDSLHKKG108guzsvY5VbWRPEp8C7pf9EET7Mda+uSAYPlNxN1FC/KrNlaHRtyx
         2qUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wC2fD32nZCXyBHEu7qLiVPQBP771Zs+EAnSAMRVzoI8=;
        b=lPW7LDuktZx6GOQGuz5mKqYq6hOFZcy3XRgI7AXnAKcDaAJe8QubHtWBH40x6N5uJD
         Wj67bfnM0eDoKPXBd+RinzT4ckffaSE4Y2RSdvWWmGUIuF4Wzt5gXusI/MNiOZW+apT1
         oAyHw5lLb4V4r8Yf014mj4Hj652HOnan8KnTP45qS2h1JJ5mm6Ww+SouRtrYW7EpItwR
         doti1+fDAg1u9AtHQuFOnzVBPi3HBgMoNGDMrxqwyHc7y27ODnjOyfnmH1pYyNbxji4O
         W2lt6NIlVKYa9IM4DGbRXVelnFeJWnMROU+CwJRlnypZMEr/DiRtKxRdEcF+YnFj2V4l
         ecIw==
X-Gm-Message-State: AJIora/Zf+F3J+0UXJHpzhOn6jN6jlZBPhIzpIaW4vII6jrZrl/gkZ1k
        6d57c5+TeEZpVW16b45ljFRD6hTJcu8=
X-Google-Smtp-Source: AGRyM1saekzv3NOZEzKw4vD3cv2riQLbdpPMs65JcRirY1yIYucfMqKvcRKl1mHUk65i61fHJDlDPw==
X-Received: by 2002:adf:fbd0:0:b0:21b:90cd:69f2 with SMTP id d16-20020adffbd0000000b0021b90cd69f2mr16238700wrs.525.1656410768938;
        Tue, 28 Jun 2022 03:06:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d4e90000000b0021b91d1ddbfsm12914430wru.21.2022.06.28.03.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:06:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 01/12] git-submodule.sh: remove unused sanitize_submodule_env()
Date:   Tue, 28 Jun 2022 12:05:23 +0200
Message-Id: <patch-v4-01.12-63150b4091c-20220628T095914Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.880.gf07d56b18ba
In-Reply-To: <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com> <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>
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
2.37.0.880.gf07d56b18ba

