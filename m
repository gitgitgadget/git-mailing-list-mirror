Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED805C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 14:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356900AbiFVO3X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 10:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357912AbiFVO2O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 10:28:14 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F39654C
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 07:28:13 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n1so23434929wrg.12
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 07:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SZz5/KAUtwJd75mvLxj4GUa9sffsa7d36rY3weXr0so=;
        b=jlM0YCgYDsZpaV6fLLb4+S01fYi3EwDKEJvC/ikSVujMicb3fa6t8SITa6NAsOoXLG
         Gd9DavGRqTpghfFd9nC/Iq7xvBEkjXmAgwMQHbZm78B4IBmTaP7IvRRl9Zd1+RS2SNmX
         /GU40ztssGWuHkTbXM+l7i2+7e5mnGiPkww6PB7nxytK/MsEdLrsP2X0dlhkIAYCc8cK
         ARJjbKJscn/WU0b/RUWvjteMqgtd0eyy07EI98Q3IsKbU6IaGwPpZ6OqEOlBk0tB3qqW
         96asOyLvlMHFegSXc4TS3JcRAb+07PT7cZqFRxuhqabvB+kCoTvZT1D4N0oTj5jHBUU3
         YCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SZz5/KAUtwJd75mvLxj4GUa9sffsa7d36rY3weXr0so=;
        b=kUtQp4yV0zz2IURzPT/yEuPxRcVf4jNX9YhWcAklu5onvEpcQ5Hu/WDp4oMoiHCpzZ
         ZVjGDXTZ7HmgisHK1w2QWDgD31LCdGfoxwA4ZK0s9Zd+ofk3FusAFffFF2p0ZxiOh28I
         kYggzcMJPFzSSfvmZUNFi0235SR6XTHxsBXMkKkVZ7B31BP3Q8Ky6yO3EFPaYFXxaON0
         Elz85tw+jDyF8+7ow43KksRCnwR7lCQ8rrhbO15Ou8LmQhBpo21J1r6OdsjEt6kHAfiL
         phBXNeL7eL7l8Ck5SoOn2aDB80NrQEPEqMqvE0geMM3hBs3XVws8lxAf4t5ET5+d72dD
         P1ng==
X-Gm-Message-State: AJIora/jkkoWZkSSguoTkPtzXS03Blm5K428JDrtxE3WaHdGpECE9x/f
        bTBipO12kp182wH3iCQQvw1uKWCTPQuJJg==
X-Google-Smtp-Source: AGRyM1sRaTR7MuKsL9WoeGG+9+RXvldY+TYe2hZc6iKaeHEeHlwk43U1vIMYDYuxjhYaTeb+4C7m3w==
X-Received: by 2002:a5d:47aa:0:b0:218:5ac8:f3a8 with SMTP id 10-20020a5d47aa000000b002185ac8f3a8mr3613778wrb.442.1655908091229;
        Wed, 22 Jun 2022 07:28:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b0039c5328ad92sm30468304wmq.41.2022.06.22.07.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 07:28:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/12] git-submodule.sh: remove unused sanitize_submodule_env()
Date:   Wed, 22 Jun 2022 16:27:56 +0200
Message-Id: <patch-v3-01.12-ed487469d62-20220622T142012Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
References: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
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

