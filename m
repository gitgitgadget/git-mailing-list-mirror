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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98984C43217
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 07:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BB6F60F6E
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 07:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239886AbhIFHGe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 03:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239832AbhIFHGa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 03:06:30 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921CDC061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 00:05:26 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q26so7283923wrc.7
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 00:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bPK7vU5qGoeM0mxEi1omxvUHbJ0G1avanmLiBIKHiso=;
        b=IpIFDecw/VlAuBzvnv7LZZsCcsrfj9yr9rQQpr9tgfOKlxU0Sz69/2iQ8ETtSayKck
         XObqlvhd6/ws3Uj935oVm1i3P7xDZVKHsTso47fPmv6WBiyYrRnFb19XYhknuXvjvPms
         asIeCfNy9tQ516Wlom9H5VzUSZk9eNeySuPstB7SFRH6pjXicpgkhwsZ/59LYxXO0wIH
         J2OUOGxgBq9rtugI2O+AOZg78JJ52OaczrEYvxlRcslepgdiz/2zkiVviEFWlIO03YGo
         9wlnGXrSHIGVj86Ek0yibFGPH5x4fzf0+BiETbtMvHFlJrV3NhOrwy/O/xoTd0zI+Dhw
         Z9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bPK7vU5qGoeM0mxEi1omxvUHbJ0G1avanmLiBIKHiso=;
        b=Xb8B9SalUX89LLqVVrFlqwIH9P8ilrXmNG0hUJ+MBM+wXJ1nEyEkOQCR2S9AvvfsWb
         IiDzLxPf+B/3WRHdfM2Qb1ZHAMB71Xuo5jivQtvBVcjyUf+Hk7SY/UTHpzCm6hWOB4ds
         BQZpy7Q4RugQLfRTa5PJS7VrwMoU9d3MdQ27KbeIOr+yYbMR4UtPMSNEZRWs17594asY
         bGRt7Q4ZEzz4qzNOOOsEu3Vgq/6JAMnV/Bp3U0ieEJcFwb6KsYVvGuH7A0pBoqGRsuNL
         U+UXEZZu2DMfsyeY7p94KFZh/ak2Nj4to7NaucwyGMOr07yqtghV6Xg/1mOk5/IvD9Lw
         baGw==
X-Gm-Message-State: AOAM533p2puEZoEb/a27A43Y+LYTstEQ7gUGenu5bh6Ms2GrCsw2B9e+
        NOcUOF5d5O2p9aFKj6PwtGVCUuCyVAHANw==
X-Google-Smtp-Source: ABdhPJwzF5KksOmRPvz4U+PCAWY3HIYavFBl13Jq6CwAnJRIWwbTZiAl6hVY80s5uYcPJ7FS2G48Rw==
X-Received: by 2002:adf:9003:: with SMTP id h3mr11473128wrh.75.1630911924932;
        Mon, 06 Sep 2021 00:05:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm8076684wrt.63.2021.09.06.00.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 00:05:24 -0700 (PDT)
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
Subject: [PATCH v2 5/7] git-sh-setup: remove unused "pull with rebase" message
Date:   Mon,  6 Sep 2021 09:05:16 +0200
Message-Id: <patch-v2-5.7-45c1369e958-20210906T070201Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.821.gfd4106eadbd
In-Reply-To: <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com> <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the "pull with rebase" message previously used by the
git-pull.sh script, which was removed in 49eb8d39c78 (Remove
contrib/examples/*, 2018-03-25).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-sh-setup.sh | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index b3a97d6455a..acbd05fe25b 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -203,9 +203,6 @@ require_clean_work_tree () {
 		"rewrite branches")
 			gettextln "Cannot rewrite branches: You have unstaged changes." >&2
 			;;
-		"pull with rebase")
-			gettextln "Cannot pull with rebase: You have unstaged changes." >&2
-			;;
 		*)
 			eval_gettextln "Cannot \$action: You have unstaged changes." >&2
 			;;
@@ -222,9 +219,6 @@ require_clean_work_tree () {
 			rebase)
 				gettextln "Cannot rebase: Your index contains uncommitted changes." >&2
 				;;
-			"pull with rebase")
-				gettextln "Cannot pull with rebase: Your index contains uncommitted changes." >&2
-				;;
 			*)
 				eval_gettextln "Cannot \$action: Your index contains uncommitted changes." >&2
 				;;
-- 
2.33.0.821.gfd4106eadbd

