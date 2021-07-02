Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4741AC11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 10:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29ADF613FA
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 10:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhGBKHn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 06:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhGBKHm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 06:07:42 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B78C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 03:05:09 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id l26so8099849oic.7
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 03:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y7kd1x4TAq97VKsuPbLTYSrKiHaAiOgve52b83B/Hck=;
        b=t7jSjYWqsG5buA8TbdJyN+R41BTWlx+6vZhL0/BjlSM3z/F5H82AHAN4mvP4qkX9y9
         gYABHLldHJ1s68ElnPmd+DfsLRp6ugTJHcrD75VOH9kKf/EiTtYd4HqnqJFVxrj0mhdo
         nWhSev/T4+o3dtGO0RMQt4QpbvPgLwH2UBrsRT9a1ivPwfzg7P3jprSPdOw/28HScu6n
         hgqAMxLO2adLXb2zFtg0vTKOZU9lPEBh97oItrIiZFotua4qVraFR/HPPviil6jEOsDi
         qUotIRswFPEHS5GXtIM0LC6o3faQmAbFlnGavkpy9BeZxZ2OKgqB6vN8W00ZT8Q5ta4c
         UuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y7kd1x4TAq97VKsuPbLTYSrKiHaAiOgve52b83B/Hck=;
        b=l4+0EzJkD7q3QvhFfTbAVrPcDAmzgMZTzSs3m9EiyC6l+KtxslM0zvK59ACZPQ3G2A
         StuKd42PotPY5D7xWymgUezoe68AFbs7guhNS2Ipz/g5G/DUXZ+KWNLkcn116TovLc8F
         NsMvEyZAkuLyJLmt9yYDuNdAh4aKXPesmGixKu7RIv0HkW5VJtkUwfeYZSSn4hAtauWq
         GjO3Cym8TUVys0uUCrjMvQBkpIHVgIrcjkPw7rhY26jxuOqKbOP4fSVltSh4J9tLhEdY
         fJT7/uANfz2cahUB4ckZt1byfA+ojD94+Tso3FjH4hUmprqeTQ20rcIfVcTiusYxJ3jY
         wLeg==
X-Gm-Message-State: AOAM53171EZdc13KfnX7YdHDlwq0/1BYUtrhzNAddMVIwopfdoGfvrdj
        63UQMW+D8Iud9GlfKllLOVgLpsXAZUOpRw==
X-Google-Smtp-Source: ABdhPJzMToaE8EYz37nmxEbAhnAZs7Sk7ZtiwxfzNoZqTROrhpb0R24Md3P5KUzgUnNt6y89Vnwozw==
X-Received: by 2002:a54:438c:: with SMTP id u12mr11329691oiv.64.1625220308791;
        Fri, 02 Jul 2021 03:05:08 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id q206sm615066oic.20.2021.07.02.03.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 03:05:08 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/5] Default aliases
Date:   Fri,  2 Jul 2021 05:05:01 -0500
Message-Id: <20210702100506.1422429-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.94.g4574ca548c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Virtually all VCS in history have default aliases, except git. Let's
fix that.

To make the aliases uncontroversial all of them have to follow certain
rules:

 1) Each default alias should have two characters
 2) Each default alias should map to a command without arguments
 3) Each default alias be widely used in the wild

The list of default aliases on this series have been discussed before,
and even Junio stated "I think it might be OK to implement them" [1].
Since git is virtually unusable without aliases, it's an imperative to
make it useful by default.

Additionally, users should be able to override the default aliases
without any issue.

[1] https://lore.kernel.org/git/xmqqtx9m8obr.fsf@gitster.dls.corp.google.com/

Felipe Contreras (5):
  test: add missing whitespaces
  config: trivial style fix
  config: trivial struct initialization cleanup
  config: initialize origin_type correctly
  config: add default aliases

 Documentation/git-branch.txt      |  4 +++
 Documentation/git-cherry-pick.txt |  4 +++
 Documentation/git-commit.txt      |  4 +++
 Documentation/git-mergetool.txt   |  4 +++
 Documentation/git-rebase.txt      |  4 +++
 Documentation/git-status.txt      |  4 +++
 config.c                          | 44 +++++++++++++++++++++++++------
 config.h                          |  3 ++-
 t/t1300-config.sh                 |  1 +
 t/test-lib.sh                     |  3 +++
 10 files changed, 66 insertions(+), 9 deletions(-)

-- 
2.32.0.94.g4574ca548c

