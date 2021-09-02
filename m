Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F00C4320E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 16:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D69610A2
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 16:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346082AbhIBQC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 12:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346072AbhIBQC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 12:02:26 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F4FC061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 09:01:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b6so3751620wrh.10
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 09:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u8a5Vuu6yPoZU9MjFcGZGGWQiy3kcWsPYU19eTRnzTI=;
        b=nsc+5NwLRz0yTSDoCwXMvETTQi91uOCXL2TVma5Yw5ZUdCnEADqRj29RcHNkzeETUb
         LqJXTHa/xmgV+F72hmvefW51LE5+ml3c+W8YLXNcMuK/KWvPg8v6UT2qF79xAGsb67fC
         5RodgiB7tuxLzuoAn1qvIGL1wMSOQbqnpzi2paa0ICVdJsVz2GajND1d9PYv0DHQYsPm
         OMvkWI0NBlsv6VHAmDjCnaawI5zkyFwlmhSM+XsnV4KI6MYEehyx9Q5N46Y8l/sNl9W1
         3viT8OcFYSowCuhF9yRigqwYqdFGp35ULwwRZM6IA13SztV+53tK1cBqp93vCeme7QGc
         Hy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u8a5Vuu6yPoZU9MjFcGZGGWQiy3kcWsPYU19eTRnzTI=;
        b=CpxX0uxCX1xZDBfB76GgBZB1G1NPUJ1/WPi0OMOWZPknLVe0zVTYIjjoW9itdT46Ia
         zC4Lf0P9TRBPGItN/Es4GG0ks9OfskAP/T/vZFF7BSNHhMObn+00E4+ei4z2PmNgLM8f
         4H9RAQQaya8aepcNBPZygp4w+NwXxF9BpiT9J8s7TbO9SFOpP2pvgVjn6H2rVxd+hwce
         kq8C9hvFpZYKQICquRwLy5SrSaY9cFy+k7Zl5lqJFXIXSwfjbMK5suA65eZOKnrWTwCX
         urCNPazAuK7N1ExIgc0CAJJenVbzOaAD/yfiS8Ygmily3Eh/Ipzdl9sDKKGo65aj4yH2
         ca9g==
X-Gm-Message-State: AOAM532DrX+KLliXgqNr/v9qoUqY9IAB+PVOtnwXsKuHLJj5b0liQOXh
        OA9gE/O7aIG13g8as02J956t9NfCYvwjmg==
X-Google-Smtp-Source: ABdhPJwEhNjpQhHiyYy2GlQxcNQxZ9Fh4K0aEyHqoQdCr+oa3WTN3yTc2nXW/FMPUODQTbOf2JCJig==
X-Received: by 2002:adf:fb91:: with SMTP id a17mr4425282wrr.376.1630598485723;
        Thu, 02 Sep 2021 09:01:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u26sm2403215wrd.32.2021.09.02.09.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:01:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/9] git-sh-setup: remove unused sane_egrep() function
Date:   Thu,  2 Sep 2021 18:01:11 +0200
Message-Id: <patch-4.9-73f0676db7a-20210902T155758Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.814.gb82868f05f3
In-Reply-To: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The is_zero_oid() function in git-submodule.sh has not been used since
e83e3333b57 (submodule: port submodule subcommand 'summary' from shell
to C, 2020-08-13), so we can remove it, and the sane_egrep() function,
dead is_zero_oid() was the only function which still referenced it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-sh-setup.sh  | 4 ----
 git-submodule.sh | 5 -----
 2 files changed, 9 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index d4e8225affa..a2a28982b6d 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -110,10 +110,6 @@ sane_grep () {
 	GREP_OPTIONS= LC_ALL=C grep @@SANE_TEXT_GREP@@ "$@"
 }
 
-sane_egrep () {
-	GREP_OPTIONS= LC_ALL=C egrep @@SANE_TEXT_GREP@@ "$@"
-}
-
 is_bare_repository () {
 	git rev-parse --is-bare-repository
 }
diff --git a/git-submodule.sh b/git-submodule.sh
index dbd2ec20503..aeb96c58243 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -63,11 +63,6 @@ isnumber()
 	n=$(($1 + 0)) 2>/dev/null && test "$n" = "$1"
 }
 
-# Given a full hex object ID, is this the zero OID?
-is_zero_oid () {
-	echo "$1" | sane_egrep '^0+$' >/dev/null 2>&1
-}
-
 # Sanitize the local git environment for use within a submodule. We
 # can't simply use clear_local_git_env since we want to preserve some
 # of the settings from GIT_CONFIG_PARAMETERS.
-- 
2.33.0.814.gb82868f05f3

