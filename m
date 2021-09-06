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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B50C433F5
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 07:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D7061004
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 07:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239882AbhIFHGc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 03:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239827AbhIFHG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 03:06:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13185C0613C1
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 00:05:25 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q26so7283822wrc.7
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 00:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J4rtb0XNUxakAicw8Jq10ClElIOFsvKBp8Y5s1rPmGA=;
        b=Dr1CeVLpH0nK2+n5ubdQuk7U3NLNcWwe7n/CYVwyQA3BRueBvZ0aciFxZoFipexnPK
         PSWjf2VqYicX/HoSRhUTVYuNzG+U1iENn87Sprw8/JA7lID5yRiQsLfadKTQf3VHEO8p
         duRfB9cGcsZ5A5vVn3sblidB0Krup5dPnDsOb1tHB0PxZVUdSIiY57pkJ26bD3EYvJOV
         TT7NLAHUbY3d/A07f1jVpxsX7/7GBgs2on5P/8ciIF0iYJsFmR3TyMq3LxAF0uS6gvMl
         iY/Cb3Me44LmKP4Y5mKaBU8zolbmoYsCzz9DSEGgINBjHMg1z7IKQ/MuHNWOfXotHqb5
         ASSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J4rtb0XNUxakAicw8Jq10ClElIOFsvKBp8Y5s1rPmGA=;
        b=pfeFmUhL+cRIMT4o5gXU51lVvFCp/0RxEpZX/aLp7Mz21b/bSBrt8l+df3dw5kt2mw
         xFz2i2UPVHWNq/YQcnCYonLDAypG2H8CzSxDezcER5RCSANKvMu9MkmEbIk6X0t7f8yi
         5lv073r/0q1Q0Cz04eVPPY38YfVhe4X9GBR8hgLbl+khaiU29KvQ98Xx1vIWrV8XPxPk
         pymm8mjNI5oKIS+i+ycBovOS1ggLPE6mYYRCEPlJjDqjgJ2W3quDgtFQl91phpuEXK3v
         Ybit02fgj1ls02BSf+b7BVG4+u6JEQWv4+vuTvWy6hYnn6FNiTqXDo8dguNmptYfE1XX
         XO5g==
X-Gm-Message-State: AOAM530MIDwCeziPQZlyV18K2cNWUDNeso597BQ4slKdnAyxLEtd9I5t
        fRRYFq2XoHj5ApUo8OYDx/ahHrG0acy2MA==
X-Google-Smtp-Source: ABdhPJz0thiivKVjj1ACBszfT8UXsAnOZe+PHWkEo6Utgnw0lXRhLjuPlMmxPxxrFjvu/WDRTYbw2w==
X-Received: by 2002:adf:f645:: with SMTP id x5mr11387191wrp.353.1630911923435;
        Mon, 06 Sep 2021 00:05:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm8076684wrt.63.2021.09.06.00.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 00:05:23 -0700 (PDT)
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
Subject: [PATCH v2 3/7] git-sh-setup: move peel_committish() function to git-subtree.sh
Date:   Mon,  6 Sep 2021 09:05:14 +0200
Message-Id: <patch-v2-3.7-d92e880fcfa-20210906T070201Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.821.gfd4106eadbd
In-Reply-To: <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com> <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the peel_committish() function out of git-sh-setup to its only
user, contrib/subtree/git-subtree.sh. Since d03ebd411c6 (rebase:
remove the rebase.useBuiltin setting, 2019-03-18) when
git-legacy-rebase.sh was removed, it has only been used in
git-subtree.sh.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/subtree/git-subtree.sh | 12 ++++++++++++
 git-sh-setup.sh                | 12 ------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 7f767b5c38f..a6deb57bcae 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -818,6 +818,18 @@ cmd_add_repository () {
 	cmd_add_commit FETCH_HEAD
 }
 
+peel_committish () {
+	case "$1" in
+	:/*)
+		peeltmp=$(git rev-parse --verify "$1") &&
+		git rev-parse --verify "${peeltmp}^0"
+		;;
+	*)
+		git rev-parse --verify "${1}^0"
+		;;
+	esac
+}
+
 # Usage: cmd_add_commit REV
 cmd_add_commit () {
 	# The rev has already been validated by cmd_add(), we just
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index c170be07c7d..3fc8830cb36 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -365,15 +365,3 @@ if test -z "$NONGIT_OK"
 then
 	git_dir_init
 fi
-
-peel_committish () {
-	case "$1" in
-	:/*)
-		peeltmp=$(git rev-parse --verify "$1") &&
-		git rev-parse --verify "${peeltmp}^0"
-		;;
-	*)
-		git rev-parse --verify "${1}^0"
-		;;
-	esac
-}
-- 
2.33.0.821.gfd4106eadbd

