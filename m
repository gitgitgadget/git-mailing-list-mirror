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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259C5C5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 15:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A882F206A1
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 15:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V10zal5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgKKPSU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 10:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgKKPSS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 10:18:18 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92638C0613D4
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 07:18:18 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id k2so2901867wrx.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 07:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QeWFLoUL3mPFjP1BmAqJ7SsS0nyu/3qp56Y0rUGVtBs=;
        b=V10zal5KOnN+wY2SHVdaVFS41pjNOwd1KnZnmLVkNp6nH121uj658wbjB/WZkJ3QFC
         jm2hV6xx5uTb22jwVA1Vgzf68ChRq9BL27XVuVcRX/J7YDGCld3TMTsnr267OufIQ3Ac
         p4Kin7/ldM5cGhdwFCivXLS70RxtH6n1TscnlQG5l9SpfLxTZBCLwzBDXIpCQEzBpBu1
         s+DmV96Yp0l2EN7x6olsQwbZaYQNscNfEgpn7C5qV/XLrIW2AVgpTgSWwBtezfUqoaW1
         2RuO4H2W0GVhP6M8qRxykiu6Z4fohPkccEIDaxJkpbvyXWqncGNl9I+HfRdKfjuf1Jq5
         qXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QeWFLoUL3mPFjP1BmAqJ7SsS0nyu/3qp56Y0rUGVtBs=;
        b=MPROBkP62PVFUDyCIqdY9RgAhUjaYXHjKxZ36HlIdzLrSvrRjzC95J7NQa7ZTEz8uH
         nfeRK1ln3Jk3nx96Akv1ilPlGR3WLM1z3bH9CgkyJ8NJSMgwuKfxk8lhIdVZFt0slgJK
         qzbwW+/HM20Y7ecrFgf+jqEw8y9Kf9uTLQ9gzC8F5+69Fkcj1LuynOnLa3B1UcCKg0nF
         CKYDutgLnyTbJumfuMhgGkVukLy4AT0L4Ml0K6+l/2y56Sil5EsvZE8AWMFjPQQvjO2w
         YCK79DdKXfoYXz4Vcjxh2VxNzVka8rzSNBLb8j6/GpANeSJctgJx6JfTtOt/7MYn6rFo
         FZJg==
X-Gm-Message-State: AOAM530XyHm9eOrmLCVxd/gDoItgfStW6Id1HAo2x3H8S8XyUuuMXmRN
        1HCDV3zBliBK2Lf15EsvgmBwdBJdmHnPCA==
X-Google-Smtp-Source: ABdhPJw6i0LWZogjJ5rZm8IR4Dnl9b+VwzIe6a07+UhleH9SQ3vLbaIOLtpWJd9vRyLymD055djbug==
X-Received: by 2002:adf:ec47:: with SMTP id w7mr30470571wrn.253.1605107897061;
        Wed, 11 Nov 2020 07:18:17 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q2sm2940010wru.76.2020.11.11.07.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 07:18:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] parse-remote: move used code to git-submodule.sh
Date:   Wed, 11 Nov 2020 16:17:53 +0100
Message-Id: <20201111151754.31527-5-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <CAGZ79kb57HzJQ4VLFD_NMKvEnriPVXoAAPimg6BG_Z+PPjJ4aQ@mail.gmail.com>
References: <CAGZ79kb57HzJQ4VLFD_NMKvEnriPVXoAAPimg6BG_Z+PPjJ4aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the only code in git-parse-remote.sh that was actually used to
git-submodule.sh.

This leaves just a comment in git-parse-remote.sh for ease of review,
a later commit will remove it and its build system configuration.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-parse-remote.sh | 7 -------
 git-submodule.sh    | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 864519eecf..b8d6a215e6 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -1,10 +1,3 @@
 # This is a shell library to calculate the remote repository and
 # upstream branch that should be pulled by "git pull" from the current
 # branch.
-
-get_default_remote () {
-	curr_branch=$(git symbolic-ref -q HEAD)
-	curr_branch="${curr_branch#refs/heads/}"
-	origin=$(git config --get "branch.$curr_branch.remote")
-	echo ${origin:-origin}
-}
diff --git a/git-submodule.sh b/git-submodule.sh
index 7ce52872b7..a6219c34e2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -413,6 +413,13 @@ is_tip_reachable () (
 	test -z "$rev"
 )
 
+get_default_remote () {
+	curr_branch=$(git symbolic-ref -q HEAD)
+	curr_branch="${curr_branch#refs/heads/}"
+	origin=$(git config --get "branch.$curr_branch.remote")
+	echo ${origin:-origin}
+}
+
 fetch_in_submodule () (
 	sanitize_submodule_env &&
 	cd "$1" &&
-- 
2.29.2.222.g5d2a92d10f8

