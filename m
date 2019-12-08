Return-Path: <SRS0=+MKA=Z6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5871FC43603
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 09:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D6F20637
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 09:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQrxi7cx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfLHJ1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Dec 2019 04:27:44 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33758 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfLHJ1o (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Dec 2019 04:27:44 -0500
Received: by mail-lj1-f193.google.com with SMTP id 21so12277482ljr.0
        for <git@vger.kernel.org>; Sun, 08 Dec 2019 01:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IwJ5FR0OKesse016kIja1wBtqTNgDKMENcweTdbrar4=;
        b=lQrxi7cxXAl09IzYsdBeoKxPbEjSg/VvMxAPNMPzhqQAeakLetgoygkTFUW/h2QJOC
         KrChgli+yZhF/WrFW49OQnUSmmldzygC1H8g5GPjIbLUcuf+59rxKK2SQ4gOKZI3GaiC
         OCDvez54gM69QAepbJauU/m5ZR9ShvoseGgjxaUNINOrn/UoFnEVchQsjs/BLLb7g6vX
         OpIGFJzBd/EGckf5ADtXfa9B1cdA20dehkAlH/C0w5e4v2+Zh4g/6kggRHRVrYyvbLiI
         fiqMkUWYKlJwLMtGqAg9DNJKn3ZmbLEpW33xIy3xH5d2sp5csduHw8l9ddxivKXQ75w7
         HVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IwJ5FR0OKesse016kIja1wBtqTNgDKMENcweTdbrar4=;
        b=jGCJYrnjVNNiJzIcHEJcWXtPIc9vt8srzBJcW1C3YjQLkbKa0X4n6EgirJAIxGSAO0
         Dg0oKuJ9DsiAUiAPSPLRZs+PlTG7zKAH1UHfcc7JA5g3/j5V1vFjCELx6tDFSP3BJA1J
         MOx6FMtKXwpWJp5PaHJXncl2bKP7lCSRujWpCtbWJ4hyrzK0FrxDNA4NAVQI9ZzZl5Mi
         AwXD1rdoIcony/FMtdoBmAZQKYtSJQoTEFJUV64U6ZQWtoRuW6TJRFdHqLXnkfs0qNgd
         dNq4bv5fG8h78QS9ZBk+U4xOjHh/C0hy1JWFldzkkFZumuzO7iBpyVBd5BOG5aeNuj0/
         XtBQ==
X-Gm-Message-State: APjAAAWDRpS1Ci5sUkS2U2ZC3qviwjUe3Hs7atcrh6c9/jmiDbwwYfwA
        Dhp5nvavdnF5Q2fYcimNT64=
X-Google-Smtp-Source: APXvYqzX9gTljlxOTrkFuKGEN5kHwWr1haGOxpy0IBV/BNm2WOlbAlNS03lxjg+InhqGaDRbWhUoJg==
X-Received: by 2002:a2e:9741:: with SMTP id f1mr12743122ljj.123.1575797262243;
        Sun, 08 Dec 2019 01:27:42 -0800 (PST)
Received: from localhost.localdomain (host-176-36-198-58.la.net.ua. [176.36.198.58])
        by smtp.gmail.com with ESMTPSA id d4sm170369lfn.42.2019.12.08.01.27.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Dec 2019 01:27:41 -0800 (PST)
From:   Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Subject: [PATCH] l10n: minor case fix in 'git branch' '--unset-upstream' description
Date:   Sun,  8 Dec 2019 11:26:47 +0200
Message-Id: <20191208092647.7588-1-dimitriy.ryazantcev@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
---
 builtin/branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 2ef214632f..d8297f80ff 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -624,7 +624,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT_F(0, "set-upstream", &track, N_("do not use"),
 			BRANCH_TRACK_OVERRIDE, PARSE_OPT_HIDDEN),
 		OPT_STRING('u', "set-upstream-to", &new_upstream, N_("upstream"), N_("change the upstream info")),
-		OPT_BOOL(0, "unset-upstream", &unset_upstream, N_("Unset the upstream info")),
+		OPT_BOOL(0, "unset-upstream", &unset_upstream, N_("unset the upstream info")),
 		OPT__COLOR(&branch_use_color, N_("use colored output")),
 		OPT_SET_INT('r', "remotes",     &filter.kind, N_("act on remote-tracking branches"),
 			FILTER_REFS_REMOTES),
-- 
2.24.0

