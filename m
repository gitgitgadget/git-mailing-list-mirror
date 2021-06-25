Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67779C2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 19:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45A3161952
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 19:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhFYTlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 15:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFYTlS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 15:41:18 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0236C061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 12:38:56 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id w13so6947032wmc.3
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 12:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nZSHsOHmSB1wrXB0xGNSbQTyGHOxKw7at9NWbeUaE04=;
        b=Fj3dJWl4RbR5urK6V6Kx0iC3Uj0nDp9uuEXAYcukgJod7gZ3jkJzedtxy19Aonb+Kr
         +jz4Wsv4re6EcHiN6lJ0alk2CeNuj88r4+iSSs2gZeQP0TDKO0Ibms2BMpAPRwNTOtHE
         Rs2kWj1Z8IQaYXpyHc2I3wcPaS6yiw92M58DWlYczWVfnDz1gQRfklQujgs6aIMYzIGc
         wbwO/eRRQdPiXFbUwVj0VYMlN08P678LoacVQYkICDmywcpc0l94cM9gEfIfxq3Xzb7O
         qWFSqdMzj5IsdVOmg1etF7BSzc788rTohgg8/kgnncSeZ2UOIEpd17FRjF3ImGC8zb2e
         61AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nZSHsOHmSB1wrXB0xGNSbQTyGHOxKw7at9NWbeUaE04=;
        b=LswGKstLnqtc2fByQU56vISAgrg3mmdtRFVIkBk9JsVCrUINL8BSWDbBqphqvWGam4
         p3kot+NuUVm7LVpvs/0WY+MFODGaSLkYlNe8FuZxCF5iqz/BEP4rEElg2JlJs+LORQFB
         eMZPgDnTfG0OxbJ3/5NSSrVPqKnM0uxpgswGSExEb8mfb7QkofNLYwCd6prW+EXv4Zh4
         xFDzmhudPFh1LlDZcg8yvkyrMWXtr01xvo4MZe0vf87SqN04X7S+rg20lA7cFMNpX/4L
         rufDhA/2N4t0hU7+EYB52ppQ26rd028EGYDp7V4fKcIa5WsOvluk0RRrK4W2THHQaL+Z
         vnFQ==
X-Gm-Message-State: AOAM532o26UMGYeH8KFakSoUdRhMKJp6c1xg6cD8t0OMi+iKLcrSQscs
        Bau+LP2BQRvqd+q5gbo1EdfxCX5Ph8DYI1tET8+cLA==
X-Google-Smtp-Source: ABdhPJyysxsk1bSVCdKS7qrc4fur8NVoARMQF5lYr7XrViJlJqU6bgvRTQqCevkaZz/lF/Jupm7AnQ==
X-Received: by 2002:a7b:c253:: with SMTP id b19mr12389559wmj.172.1624649935340;
        Fri, 25 Jun 2021 12:38:55 -0700 (PDT)
Received: from localhost.localdomain ([46.246.3.237])
        by smtp.gmail.com with ESMTPSA id c18sm6679233wrt.83.2021.06.25.12.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 12:38:54 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Barret Rhoden <brho@google.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v3 0/3] Config option names typofixes
Date:   Fri, 25 Jun 2021 21:38:48 +0200
Message-Id: <20210625193851.2233114-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210619112912.76136-1-rybak.a.v@gmail.com>
References: <20210619112912.76136-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First patch in this series is the same as the v2 patch.  Second patch fixes
similar typos in mentions of config options in test messages.  Third patch is
just a fix for an unrelated typo I've stumbled upon.

Andrei Rybak (3):
  blame: correct name of config option in docs
  t: fix typos in test messages
  git-worktree.txt: fix typo in example path

 Documentation/config/blame.txt | 2 +-
 Documentation/git-worktree.txt | 2 +-
 t/t4258-am-quoted-cr.sh        | 2 +-
 t/t9001-send-email.sh          | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.32.0

