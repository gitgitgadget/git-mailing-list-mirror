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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A9DC12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 303BF61260
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbhGNU0j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 16:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbhGNU0j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 16:26:39 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA544C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 13:23:46 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id h9so3738798oih.4
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 13:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X7/Qxu47AWN8a4ax8CJsjkQMOOxYHFVzC2iiylqzbjw=;
        b=N1NXD/f+i3C6sbFtcI2nwDgjmS2lJjsPmQlKw8NabHxyiiz1RoKXS+5EVvFInURRzd
         AZPO9p8RCs+u/xmN/6ao+hoe6cv0zzHgY21WCvdIqb6BOZPCl17i+gVKAMZzsvTrqay1
         b1mRJ4RCMYifw23+jC/IfadoYbJslP4BMa2rf5cRNB/OC5oLebxW6WKO1Irfx8z7n1PY
         ACpIIOTcUnmKxIpsCMJg+fjyOlLuyGJui51L72/mN2kH1/Z0YLUtvoOCnMpN3NzP6zkB
         S9y5E4GELTC8a7f4BhWkxP2++p2InvakOcOkKPn6KdP9q+6TnDfHcYruvT+08LjjhMDX
         q1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X7/Qxu47AWN8a4ax8CJsjkQMOOxYHFVzC2iiylqzbjw=;
        b=Pr1i7FMpz/nAhoSZVPmgO+1ARoYsEcbHvuE0MdnB++JfkmVsX6DnNsDUF3MfmLY/Jl
         RoKgIwtTzNL1T2/qmgUQctVY1idrS+weYZdNgm/NXlJtGqpmd45nclQE+Fm0tjCDTh5z
         WnnMIH83JLI2M4CVuX6VE0EEtVLDLNOZKWyR2W4R0G9Oh8AdF2gzaSFukNsLtIVseJhT
         ZhpbZDJxb084wrchew7AIkr7l08pybPWvRmlxtCJI0g3ZUAvpsTpF1eh5SkO24FnVbKZ
         l7U6+GV/3m/NFGBMJYggreg2USGvxkntPVNTorjSBQ7uMVQdCExpJTDIolLlNd7tNShZ
         EV7w==
X-Gm-Message-State: AOAM530UMC1FjjUVW6rbXG6XmUdBA/BuLxMWYpUo7ed7BRmV/Y4rqxcD
        Zyy9kLM5exOJRF2fG3sCxHYIy+wXxiG6fA==
X-Google-Smtp-Source: ABdhPJzENlah/xyWZM3D3AWHJzHFwcyqhxrOhuAjA5FNEVB3S+r29kmxRGPQmRi+BhOHjxAu7JzK4g==
X-Received: by 2002:aca:eb4e:: with SMTP id j75mr4219079oih.43.1626294226066;
        Wed, 14 Jul 2021 13:23:46 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id x30sm666826ote.44.2021.07.14.13.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 13:23:45 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Luke Shumaker <lukeshu@lukeshu.com>,
        Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 0/1] extra: new concept of extra components
Date:   Wed, 14 Jul 2021 15:23:43 -0500
Message-Id: <20210714202344.614468-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.38.g1d70fa854e
In-Reply-To: <20210710234629.17197-1-felipe.contreras@gmail.com>
References: <20210710234629.17197-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series introduces the concept of extra components. These are
components which are not yet part of the core but are good enough for
distributions to ship, and in fact, they already do.

This benefits everyone:

 1. Distribution packagers that just want to do `make install`
 2. People who download git's source code and just want to do
    `make install`
 3. Developers who have no idea what's production-level quality in
    contrib/ and just want to do `make install`.

For now they'll have to do `make install install-extra`. But if the
result is deemed correct, we might choose to add "install-extra" to the
"install" target.

The measuring stick I'm using to gauge if a component in contrib belongs
in extra is simple: are we already running tests for them with
'make test'? If the answer is "yes, we do run tests", then the answer is
"yes, it belongs in contrib".

We might want to move more components from contrib to extra once their
tests are being run reliably.

And we might move some components from the core which aren't really part
of the core to extra, like gitk, git-gui, git-p4, and git-svn.

For now only part of contrib/completion is graduated to the new area.

Since v2 I removed workdir from the list of graduates as Philippe Blain
suggested.

Felipe Contreras (1):
  completion: graduate out of contrib

 Makefile                                          | 10 ++++++++++
 {contrib => extra}/completion/git-completion.bash |  0
 {contrib => extra}/completion/git-completion.zsh  |  0
 {contrib => extra}/completion/git-prompt.sh       |  0
 t/t9902-completion.sh                             |  8 ++++----
 t/t9903-bash-prompt.sh                            |  2 +-
 6 files changed, 15 insertions(+), 5 deletions(-)
 rename {contrib => extra}/completion/git-completion.bash (100%)
 rename {contrib => extra}/completion/git-completion.zsh (100%)
 rename {contrib => extra}/completion/git-prompt.sh (100%)

Range-diff against v2:
1:  3f44bc3253 = 1:  3f44bc3253 completion: graduate out of contrib
2:  af9b24eeb1 < -:  ---------- git-new-workdir: graduate out of contrib
-- 
2.32.0.38.g1d70fa854e

