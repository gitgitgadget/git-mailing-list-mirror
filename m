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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C85AC433EF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 07:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E3FB60F9E
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 07:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239834AbhIFHGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 03:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238731AbhIFHG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 03:06:28 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525FDC06175F
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 00:05:24 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v10so8219625wrd.4
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 00:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R/babb/TCWMJcK75N9R4vjAws0MQuNP40ct4OHCI2mY=;
        b=NUz18+CSLuyZ8kqqKal+Scr5hkGufWHi5CRl7OZlJQxdnTCZnf1HbmpTMiFsTdSu7F
         Xjvwgb7nvGAe35we5jeJ2I2ufirHqrVfQcdFqthYcUVH1qdYeNLlyRv8ciJTSp7YmvXJ
         XWdOjYB2+u2kisIrSAipD8fuiPjiX5meokXiCDfsLoufALR9He2q37i46gkZ78zrArcm
         E//+0hIl2e2Ih4M5M8y0J2lDboumISoMqmP7spOpy2TZDrBsSQEbPkQI/abaADBVlLBn
         JpQXxAv3eRJxdZHphOw2Pk5QvjepupK1XL0oQ8r7Uy/BgeNdmwRpE2xfrOoRX9slNXaL
         09Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R/babb/TCWMJcK75N9R4vjAws0MQuNP40ct4OHCI2mY=;
        b=AsN0IMkcL/S+hoPkOt6TDOHm6nRsRbyQ4Ky2my8yTDD8KAWNUb5bjWnd2ZDkKmTK2a
         lDcrvSndiJvjpdMGY+mdZs3fvmFIUCYwNGLqMVB4jcTtvRhNISDodSyYmfYepSB8zyeX
         I6JtVCvTCotIFJN9vUR3exehvygrOSzqejVlxEd6pLOdtq+VHNuOW+tXZLDvQ4tQh8cL
         8UPRCoOgtEUlWCFVpcVFZ/NjGsqxCAv0+HZbtDN8rQncnd6MOQvMVQ2xzfgQfUOcfSss
         R4oZ1zwzKjjFEizVXKEjCko+A1gMntQ4rLGxe9PFrOdb9FZ9E6oil7YT3H4lkXfzMXYS
         dcCA==
X-Gm-Message-State: AOAM532sykunbzk/DH7VN9t1ZDz6FS2WWOeL0qtdpHtL320mq9L5HyFk
        Y2XADFClAXrPiNnjXykmQ54GHyiq9XcIow==
X-Google-Smtp-Source: ABdhPJzayqXkpE0lFf679ZgjGwsoO36VIKfvUV7Q1lcvPN/rJo7WvRA5EJ2sGLDYs0zyYgo3xIN0Zg==
X-Received: by 2002:a05:6000:160c:: with SMTP id u12mr11529635wrb.100.1630911922651;
        Mon, 06 Sep 2021 00:05:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm8076684wrt.63.2021.09.06.00.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 00:05:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/7] git-sh-setup: remove unused sane_egrep() function
Date:   Mon,  6 Sep 2021 09:05:13 +0200
Message-Id: <patch-v2-2.7-e7f3115797c-20210906T070201Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.821.gfd4106eadbd
In-Reply-To: <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com> <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com>
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
index 7ee4b0edff5..c170be07c7d 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -161,10 +161,6 @@ sane_grep () {
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
2.33.0.821.gfd4106eadbd

