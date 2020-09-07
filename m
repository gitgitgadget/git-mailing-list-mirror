Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309AAC43461
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 00:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0DDE2078E
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 00:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHh57vAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgIGADf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Sep 2020 20:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgIGADb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Sep 2020 20:03:31 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66297C061755
        for <git@vger.kernel.org>; Sun,  6 Sep 2020 17:03:30 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id b17so11063140ilh.4
        for <git@vger.kernel.org>; Sun, 06 Sep 2020 17:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xAZAVCNQGcdMhBwcRAu/Qilofw+kziw4Fw6pySYYf28=;
        b=oHh57vAocR9ig4AQ2oQtql8XpLEYgymQlemQ/CxBIv/y9BJCEJbyAMb3hlJHUwCd/c
         SGESsW3i9vAVcH8vnppyEvAqriw9k9xPQvEakDFQ3rVuzOofsqUwPwrLXJn4xRdwQtNd
         b29cVx+re7tqjNIXm+ta8zOq8DdXkK6IfMak38HNTD1NZBf60cJUMgTXxlz6Vgnwf2Iz
         biQ8YGWJ++lBWDLBfP7lBM2A3pu5IqsZr78CRr0cAp2Ijr6x6+V7VxZ96kBjmInUP3mm
         +fARhEqBeO573GBzk4iFnoXkDdxiBr2dxbxcEAMb3e+onLOHorpU/MKHmq8uhXkLrMmQ
         KszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xAZAVCNQGcdMhBwcRAu/Qilofw+kziw4Fw6pySYYf28=;
        b=ejQosw68vv1bHor1z1vfdpwy454n+5wd8xbLzWaLAKYLEnb3seqHRzKIP7q35OZj2s
         Wke+i4Zo/gFSamREGxcjEQYPkP/vWa/Tt2uwtHb30Sd2CLLarVI6nItS8RI4r+Vjy0YX
         X4g5tKtXtgpbYKWNmIygsfRvLcVJ7ePWQz9XtF1Dt2sI1bMHyzeRlj61uYWp4kW7qD4r
         Msd6Nt0d+43OjVJ2wwB/fuOryr6JcssukdHCsJ8gOpzTigpWYJQTX4DHd/QAMtJEkdac
         KXuJF9BSzDiKQ9L0ho+SBzuqnXoDRUwJI61RcD6Rz30pkL9wJLai+MxS3Ff8I2vAoy6y
         3WVA==
X-Gm-Message-State: AOAM532mxGJ7BnkdrnueLs6VysWx15UZEpuvJWuIFEupeUWq3oLAC7tQ
        N/227tDHEYkGO6AuNIwgdoUA8j6E9zU=
X-Google-Smtp-Source: ABdhPJxiuw671BPj38oAb4WabnmPy4dQ76wAH2SHyz8XmXzWH0uf2K/YWqKCk4WAqeLck6Ji4iIlQg==
X-Received: by 2002:a92:3007:: with SMTP id x7mr17149364ile.48.1599437003630;
        Sun, 06 Sep 2020 17:03:23 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id e22sm6381664ioc.43.2020.09.06.17.03.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Sep 2020 17:03:23 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/3] git-checkout.txt: document -d short option for --detach
Date:   Sun,  6 Sep 2020 20:02:20 -0400
Message-Id: <20200907000222.4717-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <20200907000222.4717-1-sunshine@sunshineco.com>
References: <20200904070703.47898-1-sunshine@sunshineco.com>
 <20200907000222.4717-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git checkout` learned -d as short option for --detach in 163e3b2975
(switch: add short option for --detach, 2019-03-29) but the
documentation was never updated to reflect the change.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-checkout.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 5b697eee1b..afa5c11fd3 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -198,6 +198,7 @@ Use `--no-guess` to disable this.
 	Create the new branch's reflog; see linkgit:git-branch[1] for
 	details.
 
+-d::
 --detach::
 	Rather than checking out a branch to work on it, check out a
 	commit for inspection and discardable experiments.
-- 
2.28.0.618.gf4bc123cb7

