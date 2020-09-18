Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85983C43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 11:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44B2921D42
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 11:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBNloC6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgIRLTd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 07:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgIRLTd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 07:19:33 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D524C06174A
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 04:19:33 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k13so2835144plk.3
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 04:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EayWVFWmaR0GS1fTSy+u0NySsisMW7I91xPjmUgjv+w=;
        b=DBNloC6c+FbnPsMFBNNaN1JxH4s0+tNQRFjht5MOY3B1IRSxxAALFkKl+tpter7uu6
         daohyLZm2cCKS3g4f2sKIrnCfeejPu1omlW6CLSHa1ww6JOq+g6zhIElnFSedBmcYLxb
         v8PiFbcSNWphx0zDIA9PmpCm9YrzKMz5CzXLDVHvt6w6Q9m6nwK+jjB2w4LxNHc44IeV
         QgOqNkMr+V6Z+vMkgS32AWhnZuRmHPdvnAkYzSWZzWhzU/VPtA4X73w/vqRwkMtKXxaA
         txWbGgCItVJYAagtuC9n2aUy+gzINhpTmR9AN8Hi6kxV57XTVILEj3Vwl4TK2sgFKGzy
         PWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EayWVFWmaR0GS1fTSy+u0NySsisMW7I91xPjmUgjv+w=;
        b=nYCpBUKMzkWDtVY66AhzmkJVY0DWo5fQr7q6ppZXnlkJMflnC333wyoHJ4iwP3gst0
         ACVD4vzajUTu1m/8DU4JndN0guR3fzN2pmelgk8gBJsG63+0wQgt7jgs82EIu2kOFtcb
         GajUepTJuZ015YEBVTAICf5Yss29j58ozKTNeXufGaoZ+MHnqn/teKS9JZFMT65eLJSh
         eyVDTTp1nlb7gA0dYrNHMuW6myBO0OHvj4GFp+fx5xzu9EEZgfWUgM36vP63+NhAEo3Y
         zfl5NOj4Y23gPyyCvhiXpEccgvM2e5UPu5zPPX674IA2cGh7QW6IrmN3+rSAtf8GYA5/
         Lt0w==
X-Gm-Message-State: AOAM532xjxhF5mHdRsu66MEC01byAVdIL5KAbpI3cChoC44pN691GBOl
        v5t7vDW+H2NQQ6UppjiNFFs2wpFfkgY=
X-Google-Smtp-Source: ABdhPJw4/vRyvIU+p5AgGrIn8raxMAxiS+LH7D8SUVHIEKlSl9cz+Gmq75jbK6Fy4FTSdJco24Of3A==
X-Received: by 2002:a17:90a:6e45:: with SMTP id s5mr12399231pjm.12.1600427972383;
        Fri, 18 Sep 2020 04:19:32 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id x4sm3034120pff.57.2020.09.18.04.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 04:19:31 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 0/4] sample hooks: become hash agnostic
Date:   Fri, 18 Sep 2020 04:19:01 -0700
Message-Id: <cover.1600427894.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are currently two hooks that have hardcoded 40 zeros as the null
OID and, thus, are not hash-agnostic. Rewrite these to use the newly
introduced `git rev-parse --null-oid` so that they become hash-agnostic.

Denton Liu (4):
  hooks--pre-push.sample: prefer $() for command substitution
  builtin/rev-parse: learn --null-oid
  hooks--pre-push.sample: use hash-agnostic null OID
  hooks--update.sample: use hash-agnostic null OID

 Documentation/git-rev-parse.txt  | 4 ++++
 builtin/rev-parse.c              | 4 ++++
 t/t1500-rev-parse.sh             | 6 ++++++
 templates/hooks--pre-push.sample | 8 ++++----
 templates/hooks--update.sample   | 2 +-
 5 files changed, 19 insertions(+), 5 deletions(-)

-- 
2.28.0.618.gf4bc123cb7

