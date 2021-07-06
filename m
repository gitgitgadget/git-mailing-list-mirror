Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D96C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 16:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 322FB61C24
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 16:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhGFQZ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 12:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhGFQZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 12:25:26 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FF0C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 09:22:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id h18-20020a05600c3512b029020e4ceb9588so2202294wmq.5
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 09:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endorphin.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BC0r+JCT2RHlwHgjeRBWOhjoH3m6SxzIKm0hrLIR7Sg=;
        b=ZS8z8I8tKYx0+4ctGwDNlKARJ2brveeDA0MtCA5snWRI8T/iYFLO0xHZw3fApOmj6K
         xEEREIUxncBWpz7ERXK687VURH7wOPIkFS+9ZrEKyqSJ0JXG+FndzUWio7FCJW/Ai+Oa
         F0/j+rbeq0PpShNpweJzT/AQ4aEKiBDcfIOyB562cUDCx97K7di+NhISTPLzYJLvNQWA
         iwYjCApkG5dcH7zvFQSA9a+dJSa2BCHyimYRufOGZvIU8L9Pg/fmqdlla78/LOuzMLrB
         W1/CKMik7TO69Z7o62MhljlOO0tpCXkYkZNwR3/SoYI/ECxcAqbNoQjKyPlzkW6Perz4
         v/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BC0r+JCT2RHlwHgjeRBWOhjoH3m6SxzIKm0hrLIR7Sg=;
        b=MHmdRdmWcFPhEzFJDV8fEW8iZ1Lryou9SqqS2g0IVLLBU8bAEmKQUxkgWWQMeuCU+o
         TwXU4/kaJR33nyzbERC2P97WDbpq0pdEYNj+TV3Y60PtnSRWhyHHqjtyBgKCD7sJQUFw
         6jghJIpOPtaEHg4L/J4pwV7lWhLvzIl5o6Keja5DcFfjoBCidCXKRNiDRhDVCfu6I4dI
         9Ak/IBN20kIue4mLvFt+C1FZf5/w3QWCjE69VP3ajIiGfKV6mTXHNWg+y//N5ViVKHP7
         INCbL+LakEMAG6yiuQFSNrDXZgZgWaCP/pirsfntnK9ciWlZ8fGfDm1asn2uMF/KyTwV
         q9hA==
X-Gm-Message-State: AOAM5336SA73o4EssEzDL105BrIHVxm74AHkn0u4zP5962Bw2+xIvPRC
        U7BJLADUZWvAU69xtldRnPZLi4BjcULWrmnW
X-Google-Smtp-Source: ABdhPJxzhY7grmnBO999awLThHliGDCnC1Vl1p1TS9vn1X/mOiRtOz/gjLEk6GohMsxJQq9sQ0nIEw==
X-Received: by 2002:a05:600c:4143:: with SMTP id h3mr1708581wmm.35.1625588565456;
        Tue, 06 Jul 2021 09:22:45 -0700 (PDT)
Received: from leto.endorphin.org (85-195-242-6.fiber7.init7.net. [85.195.242.6])
        by smtp.gmail.com with ESMTPSA id z3sm20207964wrv.45.2021.07.06.09.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 09:22:44 -0700 (PDT)
From:   Clemens Fruhwirth <clemens@endorphin.org>
To:     git@vger.kernel.org
Cc:     Clemens Fruhwirth <clemens@endorphin.org>
Subject: [PATCH] fetch: Fix segfault on pull --set-upstream outside a branch.
Date:   Tue,  6 Jul 2021 18:22:38 +0200
Message-Id: <20210706162238.575988-1-clemens@endorphin.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

branch_get("HEAD") can return NULL, when we are outside a branch and
the user calls pull --set-upstream. Catch this case and warn the user
to avoid a segfault.

Signed-off-by: Clemens Fruhwirth <clemens@endorphin.org>
---
 builtin/fetch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 9191620e50..1097235b90 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1602,6 +1602,10 @@ static int do_fetch(struct transport *transport,
 		struct ref *rm;
 		struct ref *source_ref = NULL;
 
+		if (!branch) {
+			warning(_("no branch detected to use --set-upstream with."));
+			goto skip;
+		}
 		/*
 		 * We're setting the upstream configuration for the
 		 * current branch. The relevant upstream is the
-- 
2.31.1

