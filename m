Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8497C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 02:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C89706103A
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 02:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbhG2CBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 22:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhG2CBh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 22:01:37 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2B2C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 19:01:34 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id a19so2884791qtx.1
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 19:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9TgkNxk6/gBR666bMdmkMxuVaoNYpkKDdy08B3Y3428=;
        b=O27tvxLgXv8UE3fe9ouiuB1nVOQ94yRiS4iUHfDVJheAJlJnSA/L+TPDR+COITSWSW
         iJdD2xIFZMTqI7HjXUK2q9s6HdqjQodj5+b3i6+gYcneKB+/YjBxVg8CRFYxxGRLOCqd
         chJUDb8ZDSiLpP9uW577ju3Jp2d8uCamHfiwCTSGzOTHkkPtKRDVY6waft+nZPREWCIh
         T9hWpKQmEJJqM5F9gpMvBTGyO3gmzCi3IZwEv3MXvmpS4GSuONTkD+7MXfCTQ73xol5Z
         2HtCQnYwk+M0UehsGss1Ktsj7zq57yocJzcLK+3rBn/5aBCt8CLQuw6hCHror97Lh7LL
         pOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9TgkNxk6/gBR666bMdmkMxuVaoNYpkKDdy08B3Y3428=;
        b=bNEJGKzIrLzbEQA8Wq9/we7U+uIncjQARWaGEQojthX9GZjM+Wsd3T8srCs4i/8Ujh
         jqGGt3cD9wPPMEXidvq+AHBR8nOsxpwkxr7JcLpXjuOWjlyTr+v/OIf+HrnvCMP837at
         gxvMcksdFoLdbv4snzcOouD2XI9tQMuRRICXDjxpdsPvbeZAls3nDNs8jWuDbKoOiCcn
         IvCIllscX4LMrqAN3SQ3PQU9rQ2LxU9XaDBeM2HP6GiOcnHmaYGczG8XDKj9uCDIrDNi
         gRLkef5aKZin+M88eRItn57Im21YkFLg7qIzy6xjspO4EU2ukbfKd6ayjalBc96EGWFJ
         1F2g==
X-Gm-Message-State: AOAM530uSwDwg6k7uGrpq61nhGYe9U1XnjyrkunSpgePVPO4CcNGTHIR
        8FqQIdS8iC+v/2q/tyDk2tenuAAF7cmK2Q==
X-Google-Smtp-Source: ABdhPJxc3MIrHq0UkUMKrvSzZLp06NDUp2QbTa592RNYXU+X1p8t43yBeTPz9vJ9PqOSICYr2FcnOA==
X-Received: by 2002:ac8:751a:: with SMTP id u26mr2369326qtq.329.1627524093318;
        Wed, 28 Jul 2021 19:01:33 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id q184sm1009337qkd.35.2021.07.28.19.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 19:01:32 -0700 (PDT)
From:   Ben Boeckel <mathstuf@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 0/1] Improve automatic setup of tracking for new branches
Date:   Wed, 28 Jul 2021 22:01:24 -0400
Message-Id: <20210729020125.746206-1-mathstuf@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210728135041.501850-1-mathstuf@gmail.com>
References: <20210728135041.501850-1-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I recently discovered some of the nicer behaviors of the `--track`
option for local branches (courtesy of `vim-fugitive`'s status
rendering). However, after a few weeks of slowly working `-t
origin/master` into my workflow, I figured that Git could help me out
here.

This patch adds two new configuration variables to initialize the
`branch.<name>.*` settings for tracking remote branches.

I searched the docs (including `Documentation/gitworkflows.txt`), but
didn't see anywhere to describe the fork-based workflow common on forges
(such as GitHub and GitLab) where this felt "at home". I suppose I could
describe the workflow I'm used to, but I think I'll hammer that out as
blog posts before submitting it as documentation.

I suspect there are more tests that should be added.

Thanks,

--Ben

---
v1 -> v2:
  - removed `branch.defaultPushRemote` (`remote.pushDefault` covers this
    case already)
  - improved the commit message with more background and an expanation
    of the intended uses

Ben Boeckel (1):
  config: support a default remote tracking setup upon branch creation

 Documentation/config/branch.txt | 14 ++++++++++++
 branch.c                        | 22 ++++++++++---------
 branch.h                        |  2 ++
 config.c                        | 10 +++++++++
 environment.c                   |  2 ++
 t/t3200-branch.sh               | 39 +++++++++++++++++++++++++++++++++
 6 files changed, 79 insertions(+), 10 deletions(-)


base-commit: eb27b338a3e71c7c4079fbac8aeae3f8fbb5c687
-- 
2.31.1

