Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1AAC433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 01:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443124AbiDVBmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 21:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344083AbiDVBmR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 21:42:17 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F1A49FA9
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 18:39:26 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id bb21so4593985qtb.3
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 18:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xVfj5M8AAyGa/1dsezC8V1v0LQipdG11GVEvHFi+goA=;
        b=e4pEp0Yr29wj/E2fvWTSRHUUOEsG0I/HYyez4OVdGb9pJQx1cAHRh/TnDKjFlOsJtM
         wjxAmEQDSwAxCbswKt47m9lgJLi0zp01YRx3DH6gvR7mg8y9uLC1B8q4+QmavWbNOjTH
         njBCG70W2M1H0ZEU6vmHaNFldRYKPuGHK/80e3hCum6QbaXJKfELY1k4hq5BbJH3TXRp
         q+ZaeH20YQ/XA1qx6jpim/VNsxUR3KbMqvmOB5qcTU8XKvTQAuTXgcsLGvD3YsVqlzNu
         awjj2rEniHiU5gwB5EJjm3Nwqbc3ls6MEySxVDSifsjkc/UXJ49xQesoilfD6U6pnekJ
         MdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xVfj5M8AAyGa/1dsezC8V1v0LQipdG11GVEvHFi+goA=;
        b=Y6Qu4fo2JXVbWyIh2BMN4nlvMY2GrzEH0VRUPymwMt5svHAXfuuFOoVzhdFhThWNO6
         ZV6TvmzZ13+DiwDxB0L6LFOzh2v/R2WgpD0uaG9aexP4HgbdTQsAPsa0zk1iFhc/nz78
         kwZU3koS0L00YGbTDmcwKvFGKPN57NDucfnLHnBDu2M3bN0Xx3OrG+YwoQbJ1/Hpt/TK
         hj+KV5BlgFbyIr4ZSE3qRwd0G0fx5xuYMgNjoOc9krf24jIqOLPWXc3aomhfjdD8OZM2
         v3VQyspRPToDTM4dJpHJApABzLZCGEVnl4aJYVkaB97a7Y4P11xgH5emGwo/LOfH15ET
         sDrg==
X-Gm-Message-State: AOAM532gGE0/hdqUBB7eKQrW0/KXgMP1xBwbG+WVkTxqORkDVZSumpQM
        iX6vhrBuQ56Mg6H/eVhzY17bPlKzN/0=
X-Google-Smtp-Source: ABdhPJxfsfQjCT4K5aUjR27TG2kq/ITaE/5ZuxvB5XeJATwKr5dExFeZaDp47U9Dd69ZKjxT6E1xjA==
X-Received: by 2002:a05:622a:9:b0:2f1:e9d7:d734 with SMTP id x9-20020a05622a000900b002f1e9d7d734mr1656131qtw.476.1650591565663;
        Thu, 21 Apr 2022 18:39:25 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id y3-20020a376403000000b0069e899ec3c7sm308026qkb.75.2022.04.21.18.39.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Apr 2022 18:39:25 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sunshine@sunshineco.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 2/2] ci: make perforce installation optional in macOS
Date:   Thu, 21 Apr 2022 18:39:11 -0700
Message-Id: <20220422013911.7646-3-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.266.g59f845bde02
In-Reply-To: <20220422013911.7646-1-carenas@gmail.com>
References: <20220421225515.6316-1-carenas@gmail.com>
 <20220422013911.7646-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using brew to install perforce has several documented[1,2,3,4] edge
cases that make it fail periodically, so if problems were found while
installing it, just continue without it.

This means that until the problem is solved all perforce tests will be
skipped in macOS, but they are still most likely covered by the other
unaffected runs and will be covered again once the issue solves itself.

1 0eb3671ed96 (ci(osx): use new location of the `perforce` cask, 2019-10-23)
2 5ed9fc3fc86 (ci: prevent `perforce` from being quarantined, 2020-02-27)
3 3831132ace6 (ci/install-depends: attempt to fix "brew cask" stuff, 2021-01-14)
4 https://lore.kernel.org/git/cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com/

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 6de20108775..aca01a414ab 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -43,7 +43,7 @@ macos-latest)
 		git -C "$cask_repo" pull --no-stat --ff-only &&
 		brew install --cask --no-quarantine perforce
 	} ||
-	brew install homebrew/cask/perforce
+	brew install homebrew/cask/perforce || true
 
 	if test -n "$CC_PACKAGE"
 	then
-- 
2.36.0.266.g59f845bde02

