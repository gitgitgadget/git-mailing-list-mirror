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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7312FC433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 15:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57F3B61183
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 15:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbhIUPx4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 11:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbhIUPxz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 11:53:55 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B60C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 08:52:26 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id a12so13805909qvz.4
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 08:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z00fDEiZD/SH7VTfMygqJQT/qLuWpPs36a5+nuloeZM=;
        b=SCyXWNCT+1h7rYYcCcG+pvn4l7P0ML1jB1+64VDkXSxezzy2fg2cm1FnJaEcgQfELt
         UBgqhr+0pTESd9kfEijr4JFAOnMtDKsAFtR5+jg8eSk4saHP616b9BD6pYMjIhomGkvV
         VyXX+siCjoJtevSGXG0coZoap9u8QW/dNGiHd8HpaSDeTlntLC24N1BE0YNpG/FlbyQ1
         YhSWbdokjJJQFWJutrnkdvsscZRh/gXOt2SU6z+la7AJk3BeuHA6Bt/AXKsPPyH4+3Kp
         ZGBlN5icg446sIUIlcnzsN1DGRIL0XPpCQZK9VewiHEP06aJr7i2tmKLlw29dc4ktSj2
         zQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z00fDEiZD/SH7VTfMygqJQT/qLuWpPs36a5+nuloeZM=;
        b=JcOU4uJz5p8gjQmgH6AK1EE0/ewuhkVD0mxt9o0asc8RBuaIbn/vSUrKGh27At3mPs
         bPD/7V82eWfDoY76sFSKmkXlIRyKmSciM2dvfTjsibhsNgXu3CzRyrZFWclG8rIzi42k
         uz5siGw+3uyxQELC3mr6otCWsSrM4HHvbB7DMI2eakQ/BTGatSFjGxxfXEqr96Ku/zTM
         0ZODrLkf1C/rFgErQwgMx1SJTvWMvWRD6Gb9mQTp3blF/CjJkgLiJpB//+CREjP6Gvdt
         S/Dp7wka+iFenJc9gpjVlxdTqVX7KyzoAKxuTTzaEInNLLwRSVskg2IWKKh4pC8YCmwe
         7bNQ==
X-Gm-Message-State: AOAM530o8hPpnsngPHXRBik1ffzq4Pg+q6hjjSxodCu8/z8H6RESQAFl
        sxTIre8FTVkD8p+wmxwggoSY3zzlQh4=
X-Google-Smtp-Source: ABdhPJzma1PDohKzgYdJg2GKBhB+MEDSwCVPtG/QuDAhJH9+ynzeG4yrdNtRJpokRaOwXTzm9NrnWg==
X-Received: by 2002:a0c:b3c9:: with SMTP id b9mr31560642qvf.40.1632239545908;
        Tue, 21 Sep 2021 08:52:25 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id z9sm4956124qtf.95.2021.09.21.08.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 08:52:25 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     carenas@gmail.com, gitster@pobox.com, bagasdotme@gmail.com
Cc:     Thiago Perrotta <tbperrotta@gmail.com>, git@vger.kernel.org
Subject: [PATCH v4 0/3] send-email: shell completion improvements
Date:   Tue, 21 Sep 2021 11:51:49 -0400
Message-Id: <20210921155152.4215-1-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CAPUEsphn15H9HbHKHRk+GFMvjq5O=8NL0Vo4L8NoUwiRrQUJJA@mail.gmail.com>
References: <CAPUEsphn15H9HbHKHRk+GFMvjq5O=8NL0Vo4L8NoUwiRrQUJJA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git send-email" completion (bash, zsh) is inconsistent, its flags are
split into both git-completion.bash and git-send-email.perl, and it only
emits format-patch flags.

Make shell completion uniform, centralizing completion
options on git-send-email.perl.

Make "git send-email --git-completion-helper" properly emit send-email
specific options.

Additionally, update git-send-email(1) man page to explicitly
mention format-patch options.

Differences from V3:

- Incorporate Carlo Arenas' code suggestions, adding all flags
  exhaustively.
- Incorporate Bagas Sanjaya's suggestion.

Differences from V2:

- Incorporate Junio's code suggestions.
- Follow proper conventions for git commit messages.

Carlo suggests to generate the flags programatically from the perl
script. I am looking into this and already have a proof-of-concept
working and plan to submit it as a separate patch series. I would like
to get this series checked in first though.

Thiago Perrotta (3):
  send-email: terminate --git-completion-helper with LF
  send-email: move bash completions to core script
  send-email docs: add format-patch options

 Documentation/git-send-email.txt       |  6 ++-
 contrib/completion/git-completion.bash | 11 +----
 git-send-email.perl                    | 64 +++++++++++++++++++++++++-
 t/t9902-completion.sh                  |  3 ++
 4 files changed, 71 insertions(+), 13 deletions(-)

-- 
2.33.0

