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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FEDC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85521610F9
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbhHTArp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 20:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbhHTArp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 20:47:45 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A263C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:47:08 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id q6so4650713qvs.12
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wmIkdClZIGJ72GjHhrXDHTr5n7vrkY8bK6LUO4FiNxc=;
        b=Qnn+DjjoiYL8g7t2SSTM/4XoCKi2maf63++rX/cOe6qvjzYiVcMJThl9p2/99YfFPn
         ZtKvFK+kGf5CstzWdHJGEVRLzfMzRULbDVBOYXFrxbUXv94SnmbVNl4tGsX1C48bIrUD
         kfiwpjH7HK8LgbwRtJCbdbuXR6piyptemKyX4JSl+xs9dg6xbmo2fj3REh/VvhizE2XA
         r7ANPSePbMYVNM2+HU6S5pE9/r5qF0SZp0t2xJObMlUgPduBT/XQO4726L4k5ddAudX8
         TeBb/69Odmt2wH8tx0W2Y+qEmj49geCp8+G8r/5OmlwqpmnC/1VcVh0opuvWxXEia4gc
         8YMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wmIkdClZIGJ72GjHhrXDHTr5n7vrkY8bK6LUO4FiNxc=;
        b=T/icLfc0LpidGQZ0zKvINmXNrdDgjFszS//HvFU3dS2cyTtbZBLqsLLk6wqZJqzRqr
         IqJb1IJwid9X8dp01EyTZ7124sOgvuRzIeWkJrJyX6ggNcle/bxTXcdFiX1RXQWR3R80
         NMko8rWZqHN92/nau98lcxwGH260aNMcQ1XRbGwkaikBip5gzqF49BzPnqVJNq8G7Zdr
         ShSGROckYT31DsmS2riM63/IH0JcK9ub1EqryxO0jC2djHEUPL8q2H9pksJQK5AddS+h
         70JvM11uOGcsKPO0t+kYBPuwNWL/MGWcy/NmwpkZG1lGPq2faBIa7b0ispKISByPxMNS
         aB6w==
X-Gm-Message-State: AOAM531iVYzEYgw5wFct1oMfVPPLfQXVbF/iTtmu+HwNCk5f9eh50Hdp
        D5w15UdenWqgdPHaOZ25g3DJ3qAOyns=
X-Google-Smtp-Source: ABdhPJzKzVm2yoriDlATsqo/5Pj2Umf970gutThZ5BPvv/hRlzpvnA+D2KMf4iHFoK6mniCQmFwDqQ==
X-Received: by 2002:a05:6214:5094:: with SMTP id kk20mr17545878qvb.3.1629420427386;
        Thu, 19 Aug 2021 17:47:07 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id o12sm2095724qtt.94.2021.08.19.17.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 17:47:07 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     git@vger.kernel.org
Cc:     Thiago Perrotta <tbperrotta@gmail.com>
Subject: [PATCH v2 0/3] send-email: shell completion improvements
Date:   Thu, 19 Aug 2021 20:46:01 -0400
Message-Id: <20210820004604.9948-1-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch makes git-send-email(1) shell completion (bash, zsh) uniform,
centralizing the completion options on git-send-email.perl instead of
git-completion.bash

The overall result is that git send-email --git-completion-helper now
properly emits send-email specific options. Previously, it was only
emitting format-patch flags.

Additionally there's a sentence in git-send-email(1) to explicitly
mention that format-patch options can also be passed to it. Currently
it's not obvious this is the case from the man page alone.

Difference from V1: Improved commit messages.

Thiago Perrotta (3):
  send-email: print newline for --git-completion-helper
  send-email: move bash completions to the perl script
  send-email docs: mention format-patch options

 Documentation/git-send-email.txt       |  2 ++
 contrib/completion/git-completion.bash | 11 +-------
 git-send-email.perl                    | 35 ++++++++++++++++++++++++++
 t/t9902-completion.sh                  |  3 +++
 4 files changed, 41 insertions(+), 10 deletions(-)

-- 
2.33.0

