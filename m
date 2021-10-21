Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5ECC433FE
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 18:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6744961284
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 18:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhJUSj5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 14:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhJUSj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 14:39:56 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F855C0613B9
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 11:37:40 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i12so924864wrb.7
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 11:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nMfCm6tv8/xjVVypPT1eYlzwqbisPGRJw76mRTIkibg=;
        b=mxQZkYed2jcVjc5+b9sjjy4jcY2qgf4oFmztzqHmIP4sRe2sgH+SevfzdJjka6Ih5M
         EyOsk5+6fpTyVmxAIZ6xA/HD2o4K41e/CadjagyCStaTaVf8Fy3O9ut3A+9fR9YaH7on
         DfUd30lGKMAV3V+tXLlPGhYa64ePgMIeB8pMJtkSBzWsKnf6s5iQdQjuEfgK1KJfxLUY
         sychDee1/RkOx8BZFyMgMca+ivGeKWuOB2bsavnw84/cBkKDdCevLmlSvn0S0mfnzlYH
         o7VlWUaa5+f/fXaI4MnFtJVZeWW5pr2SV88mDS8uP63N3J6SypVSzYjmZdh3wyTePTUS
         qt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nMfCm6tv8/xjVVypPT1eYlzwqbisPGRJw76mRTIkibg=;
        b=GM53QirwkWn8hLohrsf92VenWfDUDPXAMOI8k0txGBlCrwzCNtd6oAkULxxWUoYVJt
         zvfp7kZ7F9qM6LdDM7COEFV1/iSF9dIMiU0IfzCnymahEwgLWXO+Sx0njwxe6lIrbn//
         ylLUs3BWkZZXUVXqAk3MjnS5Yu+gDfLiWkUaLLcmZjO/EE6fVMau1Mecn9BapyTgogAj
         fou8ihC01Kxqz3q6Ir42uf8LFeMH3/lRE2FqjrwgCBBmnP+bJehaeUGByck4FWdy2oNP
         E7xedBYa/WcjVqm2MmVGrOlR49J7q/Pp+KnGRL+dlyEMZIrUIpIkZg6bnOjCQjDndY1N
         R2tw==
X-Gm-Message-State: AOAM530SiYczYjDagGlE47ocv5+maJILot9MQ0xYuGt7n6w2OYjNGb9p
        i0SrDEPZCx6+Ej1PXMz/SRex6fEVG8nL6w==
X-Google-Smtp-Source: ABdhPJyVmAhs6Lu4UghY0aNwBzN6iTD+ilYxHLgymZ9VrdPFcw7syQf0qA2+Ol4pFyEQoagsbu0wVA==
X-Received: by 2002:adf:a31d:: with SMTP id c29mr9359427wrb.381.1634841457747;
        Thu, 21 Oct 2021 11:37:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u10sm7048278wrs.5.2021.10.21.11.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 11:37:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] git-sh-i18n: remove unused eval_ngettext()
Date:   Thu, 21 Oct 2021 20:37:32 +0200
Message-Id: <patch-1.2-4552f2115d1-20211021T183627Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
In-Reply-To: <cover-0.2-00000000000-20211021T183627Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211021T183627Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "eval_ngettext()" function has been orphaned since its last user
was removed in a74b35081c5 (rebase: drop support for
`--preserve-merges`, 2021-09-07).

See b8fc9e43a7d (i18n: rebase-interactive: mark here-doc strings for
translation, 2016-06-17) for the commit that added these
eval_ngettext() wrappers.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-sh-i18n.sh | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index e3d9f4836db..a15c0620db6 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -51,12 +51,6 @@ gettext_without_eval_gettext)
 		)
 	}
 
-	eval_ngettext () {
-		ngettext "$1" "$2" "$3" | (
-			export PATH $(git sh-i18n--envsubst --variables "$2");
-			git sh-i18n--envsubst "$2"
-		)
-	}
 	;;
 *)
 	gettext () {
@@ -70,12 +64,6 @@ gettext_without_eval_gettext)
 		)
 	}
 
-	eval_ngettext () {
-		(test "$3" = 1 && printf "%s" "$1" || printf "%s" "$2") | (
-			export PATH $(git sh-i18n--envsubst --variables "$2");
-			git sh-i18n--envsubst "$2"
-		)
-	}
 	;;
 esac
 
-- 
2.33.1.1494.g88b39a443e1

